Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFAD5121E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiD0TB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiD0TBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:01:07 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A4762BCE;
        Wed, 27 Apr 2022 11:46:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CCEB8713D; Wed, 27 Apr 2022 14:46:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CCEB8713D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651085213;
        bh=WFHDoz9ZGDasBe6df2WBhiIrFz/NkNbSxRjaHWeeCfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBZKvrkmy+zNusBjk98XDp9kzx17FI176brvUBdi7Nxnu193vCq9Q7ttpk5i/8Zar
         Sv5UiQOZnOSS+afLPfjHcHD7m2OMQr3N5ZTWopwmMk8HKTMM67w5qrHs9nJOjzhcxt
         1jYRVZvmdtirsr//krYAGt+mHltGv+lL37jxhxr4=
Date:   Wed, 27 Apr 2022 14:46:53 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v22 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220427184653.GE13471@fieldses.org>
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 234e852fcdfa..216bd77a8764 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
>  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>  
> +static struct workqueue_struct *laundry_wq;
> +
>  static bool is_session_dead(struct nfsd4_session *ses)
>  {
>  	return ses->se_flags & NFS4_SESSION_DEAD;
> @@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
>  	if (is_client_expired(clp))
>  		return nfserr_expired;
>  	atomic_inc(&clp->cl_rpc_users);
> +	clp->cl_state = NFSD4_ACTIVE;
>  	return nfs_ok;
>  }
>  
> @@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
>  
>  	list_move_tail(&clp->cl_lru, &nn->client_lru);
>  	clp->cl_time = ktime_get_boottime_seconds();
> +	clp->cl_state = NFSD4_ACTIVE;
>  }

We shouldn't need that assignment in both places.

The laundromat really shouldn't let a client go to COURTESY while there
are rpc's in process for that client.  So, let's just add that check to
the laundromat (see below), and then the assignment in
renew_client_locked becomes unnecessary.

> +static void
> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> +				struct laundry_time *lt)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +	bool cour;
> +
> +	INIT_LIST_HEAD(reaplist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
> +		if (clp->cl_state == NFSD4_EXPIRABLE)
> +			goto exp_client;
> +		if (!state_expired(lt, clp->cl_time))
> +			break;
> +		if (!client_has_state_tmp(clp))
> +			goto exp_client;
> +		cour = (clp->cl_state == NFSD4_COURTESY);
> +		if (cour && ktime_get_boottime_seconds() >=
> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT)) {
> +			goto exp_client;
> +		}
> +		if (nfs4_anylock_blockers(clp)) {
> +exp_client:
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;
> +		}
> +		if (!cour)
> +			cmpxchg(&clp->cl_state, NFSD4_ACTIVE, NFSD4_COURTESY);

So, as in mark_client_expired_locked, we should only be doing this if
clp_cl_rpc_users is 0.

Also, it should just be a simple assignment, the cmpxchg isn't necessary
here.

--b.
