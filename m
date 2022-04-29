Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A4514C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 16:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376883AbiD2OTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376873AbiD2OTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:19:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298308BF68;
        Fri, 29 Apr 2022 07:16:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5157A713E; Fri, 29 Apr 2022 10:16:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5157A713E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651241780;
        bh=VZadeBL5jilrQs1QERtClB9oP2TVHgY3KGjvVXWoV3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNV/rM/UyzJphTZL29l/79XKtl0G5l1vNOUXMi95Dc6hlV8cnPcmHjRRh0vDBZmS4
         YizxVyV0s+mPT8fLTsQnnVUHNIu4KdTDLxd7OVG1MGpcNhqChl+bJssM9plhFEjL5R
         U8Y6zNUZzzzL8+PvH2ODWRtBmr/aF07MyASuKELs=
Date:   Fri, 29 Apr 2022 10:16:20 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v23 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220429141620.GA7107@fieldses.org>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-2-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651129595-6904-2-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:06:29AM -0700, Dai Ngo wrote:
> This patch provides courteous server support for delegation only.
> Only expired client with delegation but no conflict and no open
> or lock state is allowed to be in COURTESY state.
> 
> Delegation conflict with COURTESY/EXPIRABLE client is resolved by
> setting it to EXPIRABLE, queue work for the laundromat and return
> delay to the caller. Conflict is resolved when the laudromat runs
> and expires the EXIRABLE client while the NFS client retries the
> OPEN request. Local thread request that gets conflict is doing the
> retry in _break_lease.
> 
> Client in COURTESY or EXPIRABLE state is allowed to reconnect and
> continues to have access to its state. Access to the nfs4_client by
> the reconnecting thread and the laundromat is serialized via the
> client_lock.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 79 ++++++++++++++++++++++++++++++++++++++++++++---------
>  fs/nfsd/nfsd.h      |  1 +
>  fs/nfsd/state.h     | 29 ++++++++++++++++++++
>  3 files changed, 96 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 234e852fcdfa..b84ba19c856b 100644
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
>  
>  static void put_client_renew_locked(struct nfs4_client *clp)
> @@ -2004,6 +2008,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>  	idr_init(&clp->cl_stateids);
>  	atomic_set(&clp->cl_rpc_users, 0);
>  	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
> +	clp->cl_state = NFSD4_ACTIVE;
>  	INIT_LIST_HEAD(&clp->cl_idhash);
>  	INIT_LIST_HEAD(&clp->cl_openowners);
>  	INIT_LIST_HEAD(&clp->cl_delegations);
> @@ -4694,9 +4699,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>  	bool ret = false;
>  	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
> +	struct nfs4_client *clp = dp->dl_stid.sc_client;
> +	struct nfsd_net *nn;
>  
>  	trace_nfsd_cb_recall(&dp->dl_stid);
>  
> +	if (try_to_expire_client(clp)) {
> +		nn = net_generic(clp->net, nfsd_net_id);
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	}
> +
>  	/*
>  	 * We don't want the locks code to timeout the lease for us;
>  	 * we'll remove it ourself if a delegation isn't returned
> @@ -5605,6 +5617,58 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>  }
>  #endif
>  
> +/*
> + * place holder for now, no check for lock blockers yet
> + */
> +static bool
> +nfs4_anylock_blockers(struct nfs4_client *clp)
> +{
> +	/*
> +	 * don't want to check for delegation conflict here since
> +	 * we need the state_lock for it. The laundromat willexpire
> +	 * COURTESY later when checking for delegation recall timeout.
> +	 */
> +	return false;
> +}
> +
> +static bool client_has_state_tmp(struct nfs4_client *clp)
> +{
> +	if (!list_empty(&clp->cl_delegations) &&
> +			!client_has_openowners(clp) &&
> +			list_empty(&clp->async_copies))
> +		return true;
> +	return false;
> +}
> +
> +static void
> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> +				struct laundry_time *lt)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +
> +	INIT_LIST_HEAD(reaplist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
> +		if (clp->cl_state == NFSD4_EXPIRABLE)
> +			goto exp_client;
> +		if (!state_expired(lt, clp->cl_time))
> +			break;
> +		clp->cl_state = NFSD4_COURTESY;
> +		if (!client_has_state_tmp(clp) ||
> +				ktime_get_boottime_seconds() >=
> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
> +			goto exp_client;
> +		if (nfs4_anylock_blockers(clp)) {
> +exp_client:
> +			if (!mark_client_expired_locked(clp))
> +				list_add(&clp->cl_lru, reaplist);
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -5627,7 +5691,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		goto out;
>  	}
>  	nfsd4_end_grace(nn);
> -	INIT_LIST_HEAD(&reaplist);
>  
>  	spin_lock(&nn->s2s_cp_lock);
>  	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> @@ -5637,17 +5700,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  			_free_cpntf_state_locked(nn, cps);
>  	}
>  	spin_unlock(&nn->s2s_cp_lock);
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_safe(pos, next, &nn->client_lru) {
> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
> -		if (!state_expired(&lt, clp->cl_time))
> -			break;
> -		if (mark_client_expired_locked(clp))
> -			continue;
> -		list_add(&clp->cl_lru, &reaplist);
> -	}
> -	spin_unlock(&nn->client_lock);
> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>  	list_for_each_safe(pos, next, &reaplist) {
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
>  		trace_nfsd_clid_purged(&clp->cl_clientid);
> @@ -5657,6 +5710,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> +		try_to_expire_client(dp->dl_stid.sc_client);

I don't think this quite works.  First, we're only looping over the
delegations that have been under recall for the longest, and those
aren't the only ones that may matter.  Second, just calling
try_to_expire_client isn't enough, we also need to reschedule the
laundromat.

It's not the end of the world, we'll just have to wait another lease
period, but I think we can do better.

How about something like the below?  (Incomplete.)   And then you can
check cl_delegs_in_recall in nfs4_anylock_blockers.

Otherwise, this patch seems OK to me.

--b.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4f45caead507..23041584d84f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4780,6 +4780,9 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 
 	trace_nfsd_cb_recall(&dp->dl_stid);
 
+	dp->dl_recalled = true;
+	atomic_inc(&clp->cl_delegs_in_recall);
+
 	if (!try_to_expire_client(clp)) {
 		nn = net_generic(clp->net, nfsd_net_id);
 		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
@@ -4827,9 +4830,14 @@ static int
 nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 		     struct list_head *dispose)
 {
-	if (arg & F_UNLCK)
+	struct nfs4_delegation *dp = (struct nfs4_delegation *)onlist->fl_owner;
+	struct nfs4_client *clp = dp->dl_stid.sc_client;
+
+	if (arg & F_UNLCK) {
+		if (dp->dl_recalled)
+			atomic_dec(&clp->cl_delegs_in_recall);
 		return lease_modify(onlist, arg, dispose);
-	else
+	} else
 		return -EAGAIN;
 }
 
