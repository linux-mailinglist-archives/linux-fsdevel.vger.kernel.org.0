Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07E415524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbhIWBga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:36:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5EC061574;
        Wed, 22 Sep 2021 18:34:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7296A7033; Wed, 22 Sep 2021 21:34:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7296A7033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632360898;
        bh=uM3kBsp8ulgegC0eDcKqTRVGLe14x6NZsZB5xDJKJ4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtSmjlwemPsa8c2G5561tS95FHVhWLL81RzhcXexzzaCrUWugcIfKraXilzASMxJf
         LKbYRMi2J+HDroSXy+7Io60VUXb/1CiR11FFXILOW+L4yPEP3eTsxOlKgb2lCtUpjq
         FwV5DoV63itJjVNTVc0qRRz0kqd9ayWApXlhVMD8=
Date:   Wed, 22 Sep 2021 21:34:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210923013458.GE22937@fieldses.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916182212.81608-3-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
> +/*
> + * If the conflict happens due to a NFSv4 request then check for
> + * courtesy client and set rq_conflict_client so that upper layer
> + * can destroy the conflict client and retry the call.
> + */

I think we need a different approach.  Wouldn't we need to take a
reference on clp when we assign to rq_conflict_client?

What happens if there are multiple leases found in the loop in
__break_lease?

It doesn't seem right that we'd need to treat the case where nfsd is the
breaker differently the case where it's another process.

I'm not sure what to suggest instead, though....  Maybe as with locks we
need two separate callbacks, one that tests whether there's a courtesy
client that needs removing, one that does it after we've dropped the
lock.

--b.

> +static bool
> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
> +{
> +	struct svc_rqst *rqst;
> +	struct nfs4_client *clp = dp->dl_recall.cb_clp;
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +	bool ret = false;
> +
> +	if (!i_am_nfsd()) {
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> +			mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +			return true;
> +		}
> +		return false;
> +	}
> +	rqst = kthread_data(current);
> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
> +		return false;
> +	rqst->rq_conflict_client = NULL;
> +
> +	spin_lock(&nn->client_lock);
> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) &&
> +				!mark_client_expired_locked(clp)) {
> +		rqst->rq_conflict_client = clp;
> +		ret = true;
> +	}
> +	spin_unlock(&nn->client_lock);
> +	return ret;
> +}
> +
>  /* Called from break_lease() with i_lock held. */
>  static bool
>  nfsd_break_deleg_cb(struct file_lock *fl)
> @@ -4660,6 +4706,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>  	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
>  
> +	if (nfsd_check_courtesy_client(dp))
> +		return false;
>  	trace_nfsd_cb_recall(&dp->dl_stid);
>  
>  	/*
> @@ -5279,6 +5327,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>  	 */
>  }
>  
> +static bool
> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
> +{
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ||
> +			mark_client_expired_locked(clp)) {
> +		spin_unlock(&nn->client_lock);
> +		return false;
> +	}
> +	spin_unlock(&nn->client_lock);
> +	expire_client(clp);
> +	return true;
> +}
> +
>  __be32
>  nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
>  {
> @@ -5328,7 +5392,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  			goto out;
>  		}
>  	} else {
> +		rqstp->rq_conflict_client = NULL;
>  		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
> +			if (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
> +				status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		}
> +
>  		if (status) {
>  			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
> @@ -5562,6 +5632,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>  }
>  #endif
>  
> +static
> +bool nfs4_anylock_conflict(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +	struct inode *ino;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +
> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
> +		/* scan each lock owner */
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +
> +			/* scan lock states of this lock owner */
> +			lo = lockowner(so);
> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
> +					st_perstateowner) {
> +				nf = stp->st_stid.sc_file;
> +				ino = nf->fi_inode;
> +				ctx = ino->i_flctx;
> +				if (!ctx)
> +					continue;
> +				/* check each lock belongs to this lock state */
> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +					if (fl->fl_owner != lo)
> +						continue;
> +					if (!list_empty(&fl->fl_blocked_requests))
> +						return true;
> +				}
> +			}
> +		}
> +	}
> +	return false;
> +}
> +
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -5577,7 +5688,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	};
>  	struct nfs4_cpntf_state *cps;
>  	copy_stateid_t *cps_t;
> +	struct nfs4_stid *stid;
>  	int i;
> +	int id = 0;
>  
>  	if (clients_still_reclaiming(nn)) {
>  		lt.new_timeo = 0;
> @@ -5598,8 +5711,33 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	spin_lock(&nn->client_lock);
>  	list_for_each_safe(pos, next, &nn->client_lru) {
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			goto exp_client;
> +		}
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			if (ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
> +				goto exp_client;
> +			/*
> +			 * after umount, v4.0 client is still
> +			 * around waiting to be expired
> +			 */
> +			if (clp->cl_minorversion)
> +				continue;
> +		}
>  		if (!state_expired(&lt, clp->cl_time))
>  			break;
> +		spin_lock(&clp->cl_lock);
> +		stid = idr_get_next(&clp->cl_stateids, &id);
> +		spin_unlock(&clp->cl_lock);
> +		if (stid && !nfs4_anylock_conflict(clp)) {
> +			/* client still has states */
> +			clp->courtesy_client_expiry =
> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			continue;
> +		}
> +exp_client:
>  		if (mark_client_expired_locked(clp))
>  			continue;
>  		list_add(&clp->cl_lru, &reaplist);
> @@ -5679,9 +5817,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>  }
>  
> -static struct workqueue_struct *laundry_wq;
> -static void laundromat_main(struct work_struct *);
> -
>  static void
>  laundromat_main(struct work_struct *laundry)
>  {
> @@ -6486,6 +6621,19 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>  		lock->fl_end = OFFSET_MAX;
>  }
>  
> +/* return true if lock was expired else return false */
> +static bool
> +nfsd4_fl_expire_lock(struct file_lock *fl, bool testonly)
> +{
> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)fl->fl_owner;
> +	struct nfs4_client *clp = lo->lo_owner.so_client;
> +
> +	if (testonly)
> +		return test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ?
> +			true : false;
> +	return nfs4_destroy_courtesy_client(clp);
> +}
> +
>  static fl_owner_t
>  nfsd4_fl_get_owner(fl_owner_t owner)
>  {
> @@ -6533,6 +6681,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>  	.lm_notify = nfsd4_lm_notify,
>  	.lm_get_owner = nfsd4_fl_get_owner,
>  	.lm_put_owner = nfsd4_fl_put_owner,
> +	.lm_expire_lock = nfsd4_fl_expire_lock,
>  };
>  
>  static inline void
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..93e30b101578 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,8 @@ struct nfs4_client {
>  #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>  #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>  					 1 << NFSD4_CLIENT_CB_KILL)
> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>  	unsigned long		cl_flags;
>  	const struct cred	*cl_cb_cred;
>  	struct rpc_clnt		*cl_cb_client;
> @@ -385,6 +387,7 @@ struct nfs4_client {
>  	struct list_head	async_copies;	/* list of async copies */
>  	spinlock_t		async_lock;	/* lock for async copies */
>  	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> +	int			courtesy_client_expiry;
>  };
>  
>  /* struct nfs4_client_reset
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 064c96157d1f..349bf7bf20d2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -306,6 +306,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	void			*rq_conflict_client;
>  };
>  
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> -- 
> 2.9.5
