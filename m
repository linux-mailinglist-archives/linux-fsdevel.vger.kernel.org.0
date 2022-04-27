Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9189512292
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 21:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiD0T1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiD0TTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:19:14 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08DD88B0A;
        Wed, 27 Apr 2022 12:13:31 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 605D91506; Wed, 27 Apr 2022 15:13:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 605D91506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651086811;
        bh=9pnIKUeLsJcyeVDL2Txs9cWxBjrg+SIi9iT7kjMAEJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Veu59Udz8L+HtvQYBbmEspqZSvuIgfyW8dchubfkN7xSFyFodKGVguDKdBGymsBQI
         vF0DRl3BPj4fjKSaCMk3pptzYhWYmIgIPTqUffqqj4iFD/pHqJwmXkIugDbPZL+Uk1
         CBzPzTda186i3BiJmh13OpWMPtmTVL/0LnPKXJI0=
Date:   Wed, 27 Apr 2022 15:13:31 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v22 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220427191331.GF13471@fieldses.org>
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
 <20220427184653.GE13471@fieldses.org>
 <75276a04-53b2-4033-d07e-3b5eb210f9eb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75276a04-53b2-4033-d07e-3b5eb210f9eb@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:09:58PM -0700, dai.ngo@oracle.com wrote:
> 
> On 4/27/22 11:46 AM, J. Bruce Fields wrote:
> >On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
> >>diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>index 234e852fcdfa..216bd77a8764 100644
> >>--- a/fs/nfsd/nfs4state.c
> >>+++ b/fs/nfsd/nfs4state.c
> >>@@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
> >>  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> >>  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> >>+static struct workqueue_struct *laundry_wq;
> >>+
> >>  static bool is_session_dead(struct nfsd4_session *ses)
> >>  {
> >>  	return ses->se_flags & NFS4_SESSION_DEAD;
> >>@@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
> >>  	if (is_client_expired(clp))
> >>  		return nfserr_expired;
> >>  	atomic_inc(&clp->cl_rpc_users);
> >>+	clp->cl_state = NFSD4_ACTIVE;
> >>  	return nfs_ok;
> >>  }
> >>@@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
> >>  	list_move_tail(&clp->cl_lru, &nn->client_lru);
> >>  	clp->cl_time = ktime_get_boottime_seconds();
> >>+	clp->cl_state = NFSD4_ACTIVE;
> >>  }
> >We shouldn't need that assignment in both places.
> >
> >The laundromat really shouldn't let a client go to COURTESY while there
> >are rpc's in process for that client.  So, let's just add that check to
> >the laundromat (see below), and then the assignment in
> >renew_client_locked becomes unnecessary.
> 
> I added this for the case when the 4.0 COURTESY/EXPIRABLE client
> reconnects. The client needs to be restored back ACTIVE state and
> the RENEW is usually comes in first. Without this, the client
> continues to be in COURTESY/EXPIRABLE state.

Got it.  OK, I think that makes sense.

--b.
