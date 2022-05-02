Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A424851738A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386212AbiEBQFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386147AbiEBQEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 12:04:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C050BE12;
        Mon,  2 May 2022 09:00:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 470FB6214; Mon,  2 May 2022 12:00:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 470FB6214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651507258;
        bh=MgexYy/qSvZKhZG5OaGDKjaf+0dL78kNEUaZBzH7cTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MA4TVwilAIpU1e7Q5brjWFgbjw26KJ/iLL2YCf+tzucg8Y6BmHBeJrI9KjWIM+byc
         whod/pbRa4jGf1hk2mi1ZauH5nNCuPHpYU5RoPqhhGblOxUHK6W4pN3g1YM30CwNsV
         LN412usz7OmtOn9nSNyQcIvs9NQEKlclBHCqzVqo=
Date:   Mon, 2 May 2022 12:00:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v24 6/7] NFSD: add support for lock conflict to
 courteous server
Message-ID: <20220502160058.GF30550@fieldses.org>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
 <1651426696-15509-7-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651426696-15509-7-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 01, 2022 at 10:38:15AM -0700, Dai Ngo wrote:
> This patch allows expired client with lock state to be in COURTESY
> state. Lock conflict with COURTESY client is resolved by the fs/lock
> code using the lm_lock_expirable and lm_expire_lock callback in the
> struct lock_manager_operations.
> 
> If conflict client is in COURTESY state, set it to EXPIRABLE and
> schedule the laundromat to run immediately to expire the client. The
> callback lm_expire_lock waits for the laundromat to flush its work
> queue before returning to caller.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>

(These searches over hash tables that we're adding in a few places are
inefficient, but I'm assuming it won't matter.  And I don't have a
better idea off the top of my head.  So I'm fine with just doing this
instead of optimizing prematurely.)

--b.

> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 70 +++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f369142da79f..4ab7dda44f38 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5715,39 +5715,51 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>  }
>  #endif
>  
> +/* Check if any lock belonging to this lockowner has any blockers */
>  static bool
> -nfs4_has_any_locks(struct nfs4_client *clp)
> +nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
> +{
> +	struct file_lock_context *ctx;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +
> +	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
> +		nf = stp->st_stid.sc_file;
> +		ctx = nf->fi_inode->i_flctx;
> +		if (!ctx)
> +			continue;
> +		if (locks_owner_has_blockers(ctx, lo))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool
> +nfs4_anylock_blockers(struct nfs4_client *clp)
>  {
>  	int i;
>  	struct nfs4_stateowner *so;
> +	struct nfs4_lockowner *lo;
>  
> +	if (atomic_read(&clp->cl_delegs_in_recall))
> +		return true;
>  	spin_lock(&clp->cl_lock);
>  	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>  		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
>  				so_strhash) {
>  			if (so->so_is_open_owner)
>  				continue;
> -			spin_unlock(&clp->cl_lock);
> -			return true;
> +			lo = lockowner(so);
> +			if (nfs4_lockowner_has_blockers(lo)) {
> +				spin_unlock(&clp->cl_lock);
> +				return true;
> +			}
>  		}
>  	}
>  	spin_unlock(&clp->cl_lock);
>  	return false;
>  }
>  
> -/*
> - * place holder for now, no check for lock blockers yet
> - */
> -static bool
> -nfs4_anylock_blockers(struct nfs4_client *clp)
> -{
> -	if (atomic_read(&clp->cl_delegs_in_recall) ||
> -			!list_empty(&clp->async_copies) ||
> -			nfs4_has_any_locks(clp))
> -		return true;
> -	return false;
> -}
> -
>  static void
>  nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>  				struct laundry_time *lt)
> @@ -6712,6 +6724,29 @@ nfsd4_lm_put_owner(fl_owner_t owner)
>  		nfs4_put_stateowner(&lo->lo_owner);
>  }
>  
> +/* return pointer to struct nfs4_client if client is expirable */
> +static bool
> +nfsd4_lm_lock_expirable(struct file_lock *cfl)
> +{
> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)cfl->fl_owner;
> +	struct nfs4_client *clp = lo->lo_owner.so_client;
> +	struct nfsd_net *nn;
> +
> +	if (try_to_expire_client(clp)) {
> +		nn = net_generic(clp->net, nfsd_net_id);
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/* schedule laundromat to run immediately and wait for it to complete */
> +static void
> +nfsd4_lm_expire_lock(void)
> +{
> +	flush_workqueue(laundry_wq);
> +}
> +
>  static void
>  nfsd4_lm_notify(struct file_lock *fl)
>  {
> @@ -6738,9 +6773,12 @@ nfsd4_lm_notify(struct file_lock *fl)
>  }
>  
>  static const struct lock_manager_operations nfsd_posix_mng_ops  = {
> +	.lm_mod_owner = THIS_MODULE,
>  	.lm_notify = nfsd4_lm_notify,
>  	.lm_get_owner = nfsd4_lm_get_owner,
>  	.lm_put_owner = nfsd4_lm_put_owner,
> +	.lm_lock_expirable = nfsd4_lm_lock_expirable,
> +	.lm_expire_lock = nfsd4_lm_expire_lock,
>  };
>  
>  static inline void
> -- 
> 2.9.5
