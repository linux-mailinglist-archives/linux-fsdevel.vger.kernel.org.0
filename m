Return-Path: <linux-fsdevel+bounces-75631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PkuC9j7eGlfuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:54:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B9B98AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B90130098AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD18320A34;
	Tue, 27 Jan 2026 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbPb+l17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0125CC74;
	Tue, 27 Jan 2026 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536466; cv=none; b=L1vLRkt55ZN2FLM8QSdKv5yelPT8frXq/2uvi5YfmaPceJF8ERUCjfrgcGqDyZS7v5pIpPjD8alh3qWAAsH6p/I+Eahn7/yQjhClrE2uTJrAv46FYUsU8iVSHh9/74erXXONxiyexa+Ap4XsA0cvMfM0TmwGPmk8OOONo+zYgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536466; c=relaxed/simple;
	bh=+TpQiso8+Mc5uOWPKO2vvxlLvyPF5R4SZOAV0KBfANw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCHdMrZEBHpB2yYTOcqY/hxf29Jyk5zhW0gPt9sEvj8KNgxHlFAlpaT2deN+xyjEhqKty6L3oQLrqmy2Qf8kC7oTlwnY8XNy2JeSC/FL5s1b4fjH46GMp9Ogo2UPjMpE2YqjbTWk/CzeF4DR0WcYDGsQprOMhWlHPdY0gc5redI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbPb+l17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627A8C116C6;
	Tue, 27 Jan 2026 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536465;
	bh=+TpQiso8+Mc5uOWPKO2vvxlLvyPF5R4SZOAV0KBfANw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lbPb+l17mI0AJ3c1NiC7kU4zokhO6FC9dKndZ/CqO5FKJqLoIVvacEsa3+XRlo9LE
	 4f9oxnFuTM+iV8a9lP5JLaqXLBaECxGZve9nGrlCGNkyqaSlYszvxwYHG6/ifqLVY+
	 gn52y4wqLeew6ImdSkTE6un9uNewAwYPM7CVarBxA5dt0R/p9a62ZBXE3Bg6uo8aOY
	 2ThtmYQlaMTCrWf0w4BfeoT3YrzHCrWulEkq2ZEF/1Nz3oq2A/BjtyfZa9dAbD5gUf
	 zwBHXVe+uhlqyUUeYYkViDp39IgDomcFWvfhlnlmslth9L/y6wzb2QichQrKtwknRy
	 JJMAhR39V6T3g==
Message-ID: <5d2288d77498582f78152bdb411222930a7e5978.camel@kernel.org>
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Tue, 27 Jan 2026 12:54:23 -0500
In-Reply-To: <20260127005013.552805-1-dai.ngo@oracle.com>
References: <20260127005013.552805-1-dai.ngo@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75631-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8B9B98AC9
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 16:50 -0800, Dai Ngo wrote:
> When a layout conflict triggers a recall, enforcing a timeout is
> necessary to prevent excessive nfsd threads from being blocked in
> __break_lease ensuring the server continues servicing incoming
> requests efficiently.
>=20
> This patch introduces a new function to lease_manager_operations:
>=20
> lm_breaker_timedout: Invoked when a lease recall times out and is
> about to be disposed of. This function enables the lease manager
> to inform the caller whether the file_lease should remain on the
> flc_list or be disposed of.
>=20
> For the NFSD lease manager, this function now handles layout recall
> timeouts. If the layout type supports fencing and the client has not
> been fenced, a fence operation is triggered to prevent the client
> from accessing the block device.
>=20
> While the fencing operation is in progress, the conflicting file_lease
> remains on the flc_list until fencing is complete. This guarantees
> that no other clients can access the file, and the client with
> exclusive access is properly blocked before disposal.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  2 +
>  fs/locks.c                            | 10 +++-
>  fs/nfsd/blocklayout.c                 | 38 ++++++-------
>  fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
>  fs/nfsd/nfs4state.c                   |  1 +
>  fs/nfsd/state.h                       |  6 ++
>  include/linux/filelock.h              |  1 +
>  7 files changed, 110 insertions(+), 27 deletions(-)
>=20
> v2:
>     . Update Subject line to include fencing operation.
>     . Allow conflicting lease to remain on flc_list until fencing
>       is complete.
>     . Use system worker to perform fencing operation asynchronously.
>     . Use nfs4_stid.sc_count to ensure layout stateid remains
>       valid before starting the fencing operation, nfs4_stid.sc_count
>       is released after fencing operation is complete.
>     . Rework nfsd4_scsi_fence_client to:
>          . wait until fencing to complete before exiting.
>          . wait until fencing in progress to complete before
>            checking the NFSD_MDS_PR_FENCED flag.
>     . Remove lm_need_to_retry from lease_manager_operations.
> v3:
>     . correct locking requirement in locking.rst.
>     . add max retry count to fencing operation.
>     . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>     . remove special-casing of FL_LAYOUT in lease_modify.
>     . remove lease_want_dispose.
>     . move lm_breaker_timedout call to time_out_leases.
> v4:
>     . only increment ls_fence_retry_cnt after successfully
>       schedule new work in nfsd4_layout_lm_breaker_timedout.
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index 04c7691e50e0..a339491f02e4 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,7 @@ prototypes::
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
>          bool (*lm_lock_expirable)(struct file_lock *);
>          void (*lm_expire_lock)(void);
> +        void (*lm_breaker_timedout)(struct file_lease *);
> =20
>  locking rules:
> =20
> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>  lm_lock_expirable	yes		no			no
>  lm_expire_lock		no		no			yes
>  lm_open_conflict	yes		no			no
> +lm_breaker_timedout     yes             no                      no
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 46f229f740c8..1b63aa704598 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, st=
ruct list_head *dispose)
>  {
>  	struct file_lock_context *ctx =3D inode->i_flctx;
>  	struct file_lease *fl, *tmp;
> +	bool remove =3D true;
> =20
>  	lockdep_assert_held(&ctx->flc_lock);
> =20
> @@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode, s=
truct list_head *dispose)
>  		trace_time_out_leases(inode, fl);
>  		if (past_time(fl->fl_downgrade_time))
>  			lease_modify(fl, F_RDLCK, dispose);
> -		if (past_time(fl->fl_break_time))
> -			lease_modify(fl, F_UNLCK, dispose);
> +
> +		if (past_time(fl->fl_break_time)) {
> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
> +				remove =3D fl->fl_lmops->lm_breaker_timedout(fl);
> +			if (remove)
> +				lease_modify(fl, F_UNLCK, dispose);

I'd not bother with the return code to lm_breaker_timedout.

Make it void return and have it call lease_modify itself before
returning in the cases where you have it returning true. If the
operation isn't defined then just do the lease_modify here like we
always have.

> +		}
>  	}
>  }
> =20
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 7ba9e2dd0875..69d3889df302 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, st=
ruct svc_rqst *rqstp,
>  	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>  }
> =20
> +/*
> + * Perform the fence operation to prevent the client from accessing the
> + * block device. If a fence operation is already in progress, wait for
> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
> + * update the layout stateid by setting the ls_fenced flag to indicate
> + * that the client has been fenced.
> + */
>  static void
>  nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file=
 *file)
>  {
> @@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid =
*ls, struct nfsd_file *file)
>  	struct block_device *bdev =3D file->nf_file->f_path.mnt->mnt_sb->s_bdev=
;
>  	int status;
> =20
> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
> +	mutex_lock(&clp->cl_fence_mutex);
> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
> +		ls->ls_fenced =3D true;
> +		mutex_unlock(&clp->cl_fence_mutex);
> +		nfs4_put_stid(&ls->ls_stid);
>  		return;
> +	}
> =20

I don't understand what this new mutex is protecting, and this all
seems overly complex. If feels kind of like you want nfsd to be driving
the fencing retries, but I don't think we really do. Here's what I'd
do.

I'd just make ->fence_client a bool or int return, and have it indicate
whether the client was successfully fenced or not. If it was
successfully fenced, then have the caller call lease_modify() to remove
the lease.=C2=A0If it wasn't successfully fenced, have the caller (the
workqueue job) requeue itself if you want to retry. If the caller is
ready to give up, then call lease_modify() on it and remove it (and
probably throw a pr_warn()).

>  	status =3D bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KE=
Y,
>  			nfsd4_scsi_pr_key(clp),
>  			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
> -	/*
> -	 * Reset to allow retry only when the command could not have
> -	 * reached the device. Negative status means a local error
> -	 * (e.g., -ENOMEM) prevented the command from being sent.
> -	 * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
> -	 * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
> -	 * before device delivery.
> -	 *
> -	 * For all other errors, the command may have reached the device
> -	 * and the preempt may have succeeded. Avoid resetting, since
> -	 * retrying a successful preempt returns PR_STS_IOERR or
> -	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
> -	 * retry loop.
> -	 */
> -	if (status < 0 ||
> -	    status =3D=3D PR_STS_PATH_FAILED ||
> -	    status =3D=3D PR_STS_PATH_FAST_FAILED ||
> -	    status =3D=3D PR_STS_RETRY_PATH_FAILURE)
> +	if (status)
>  		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
> +	else
> +		ls->ls_fenced =3D true;
> +	mutex_unlock(&clp->cl_fence_mutex);
> +	nfs4_put_stid(&ls->ls_stid);
> =20
>  	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>  }
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..1c498f3cd059 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls=
)
>  	return 0;
>  }
> =20
> +static void
> +nfsd4_layout_fence_worker(struct work_struct *work)
> +{
> +	struct nfsd_file *nf;
> +	struct delayed_work *dwork =3D to_delayed_work(work);
> +	struct nfs4_layout_stateid *ls =3D container_of(dwork,
> +			struct nfs4_layout_stateid, ls_fence_work);
> +	u32 type;
> +
> +	rcu_read_lock();
> +	nf =3D nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (!nf) {
> +		nfs4_put_stid(&ls->ls_stid);
> +		return;
> +	}
> +
> +	type =3D ls->ls_layout_type;
> +	if (nfsd4_layout_ops[type]->fence_client)
> +		nfsd4_layout_ops[type]->fence_client(ls, nf);

If you make fence_client an int/bool return, then you could just
requeue this job to try it again.

> +	nfsd_file_put(nf);
> +}
> +
>  static struct nfs4_layout_stateid *
>  nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>  		struct nfs4_stid *parent, u32 layout_type)
> @@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_sta=
te *cstate,
>  	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>  	spin_unlock(&fp->fi_lock);
> =20
> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
> +	ls->ls_fenced =3D false;
> +	ls->ls_fence_retry_cnt =3D 0;
> +
>  	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>  	return ls;
>  }
> @@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, stru=
ct rpc_task *task)
>  		rcu_read_unlock();
>  		if (fl) {
>  			ops =3D nfsd4_layout_ops[ls->ls_layout_type];
> -			if (ops->fence_client)
> +			if (ops->fence_client) {
> +				refcount_inc(&ls->ls_stid.sc_count);
>  				ops->fence_client(ls, fl);
> -			else
> +			} else
>  				nfsd4_cb_layout_fail(ls, fl);
>  			nfsd_file_put(fl);
>  		}
> @@ -747,11 +775,9 @@ static bool
>  nfsd4_layout_lm_break(struct file_lease *fl)
>  {
>  	/*
> -	 * We don't want the locks code to timeout the lease for us;
> -	 * we'll remove it ourself if a layout isn't returned
> -	 * in time:
> +	 * Enforce break lease timeout to prevent NFSD
> +	 * thread from hanging in __break_lease.
>  	 */
> -	fl->fl_break_time =3D 0;
>  	nfsd4_recall_file_layout(fl->c.flc_owner);
>  	return false;
>  }
> @@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp, in=
t arg)
>  	return 0;
>  }
> =20
> +/**
> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
> + * If the layout type supports a fence operation, schedule a worker to
> + * fence the client from accessing the block device.
> + *
> + * @fl: file to check
> + *
> + * Return true if the file lease should be disposed of by the caller;
> + * otherwise, return false.
> + */
> +static bool
> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls =3D fl->c.flc_owner;
> +	bool ret;
> +
> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
> +		return true;
> +	if (ls->ls_fenced || ls->ls_fence_retry_cnt >=3D LO_MAX_FENCE_RETRY)
> +		return true;
> +
> +	if (work_busy(&ls->ls_fence_work.work))
> +		return false;
> +	/* Schedule work to do the fence operation */
> +	ret =3D mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
> +	if (!ret) {
> +		/*
> +		 * If there is no pending work, mod_delayed_work queues
> +		 * new task. While fencing is in progress, a reference
> +		 * count is added to the layout stateid to ensure its
> +		 * validity. This reference count is released once fencing
> +		 * has been completed.
> +		 */
> +		refcount_inc(&ls->ls_stid.sc_count);
> +		++ls->ls_fence_retry_cnt;
> +		return true;

The cases where the fencing didn't work after too many retries, or the
job couldn't be queued should probably get a pr_warn or something. The
admin needs to know that data corruption is possible and that they
might need to nuke the client manually.

> +	}
> +	return false;
> +}
> +
>  static const struct lease_manager_operations nfsd4_layouts_lm_ops =3D {
>  	.lm_break		=3D nfsd4_layout_lm_break,
>  	.lm_change		=3D nfsd4_layout_lm_change,
>  	.lm_open_conflict	=3D nfsd4_layout_lm_open_conflict,
> +	.lm_breaker_timedout	=3D nfsd4_layout_lm_breaker_timedout,
>  };
> =20
>  int
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 583c13b5aaf3..a57fa3318362 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name,
>  #endif
>  #ifdef CONFIG_NFSD_SCSILAYOUT
>  	xa_init(&clp->cl_dev_fences);
> +	mutex_init(&clp->cl_fence_mutex);
>  #endif
>  	INIT_LIST_HEAD(&clp->async_copies);
>  	spin_lock_init(&clp->async_lock);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 713f55ef6554..57e54dfb406c 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -529,6 +529,7 @@ struct nfs4_client {
>  	time64_t		cl_ra_time;
>  #ifdef CONFIG_NFSD_SCSILAYOUT
>  	struct xarray		cl_dev_fences;
> +	struct mutex		cl_fence_mutex;
>  #endif
>  };
> =20
> @@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
>  	stateid_t			ls_recall_sid;
>  	bool				ls_recalled;
>  	struct mutex			ls_mutex;
> +	struct delayed_work		ls_fence_work;
> +	bool				ls_fenced;
> +	int				ls_fence_retry_cnt;
>  };
> =20
> +#define	LO_MAX_FENCE_RETRY		5
> +
>  static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid=
 *s)
>  {
>  	return container_of(s, struct nfs4_layout_stateid, ls_stid);
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 2f5e5588ee07..13b9c9f04589 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
>  	int (*lm_open_conflict)(struct file *, int);
> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>  };
> =20
>  struct lock_manager {

--=20
Jeff Layton <jlayton@kernel.org>

