Return-Path: <linux-fsdevel+bounces-46502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD41A8A4BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2360A3AACFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E15829CB5C;
	Tue, 15 Apr 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqI3yO8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12A28B4F0;
	Tue, 15 Apr 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736121; cv=none; b=UcMSWO07zgDwg3m/0ytKF2DD0MuBLt70gcVIu0t4bC6xDhOQ/jQC2SQCllZI5LoOqm68yqGmGQaADmFcW1gflJlsoPvAK9cajMoTQriHDShmlZlI4S3VD7vqy7V8NLSOuBkHFcT4KuBrSUI/iMl5hkRLF8GJuSFSrbsdVI64W9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736121; c=relaxed/simple;
	bh=gepFJMioxNgLLwQexTADy6stExSWdk/vGxRm3RDDTAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mph2ey5xHwP4UFdvNQQMoDZhk+qmGUoK+q+FijDcT0XpoVj+snM6aW+h8+Pb5ZS0yjwCFmvCmI+dz+T7ydaudD8l89okH1Ix7ZHpa+q6hIRi/TNtMTcNcDboCHy6F45LJBVQzb1sV8nBBaTK9flZiIfEPkvzUriyEskZLalXrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqI3yO8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DFCC4CEEB;
	Tue, 15 Apr 2025 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736121;
	bh=gepFJMioxNgLLwQexTADy6stExSWdk/vGxRm3RDDTAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqI3yO8khY/SDdsi+Y1G3JMe+H/YhhKPsTMkqCueqwpg6dwoZK01i6WTjPtgGafJa
	 IRGri368LrHNc2IkwE4m94RvK9wLVJI4+CBHRk6Ojygqp9FOIL3VGRaNz4IsvbS6eO
	 e9V7qeNXDhVMjyDy5nRBR1tRvBJ1yx0HiTuCIUgHoze38Qu4SsTFL4OufMFHeFYo5r
	 Hc81kT+QFDv6gB1c/VbHVfM3MvWGHEP/yKskGWMk47h1lBg/aKkT1+l/BNCE7cGnYF
	 Mjoryc5ObMs5cAsmSci1JBAtlltzT7L/67KMi3y99l59y01RcApbOaJjquPkVcoBWc
	 l812LA4IRdYRA==
Date: Tue, 15 Apr 2025 09:55:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 14/14] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
Message-ID: <20250415165520.GS25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-15-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415121425.4146847-15-john.g.garry@oracle.com>

On Tue, Apr 15, 2025 at 12:14:25PM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Introduce a mount option to allow sysadmins to specify the maximum size
> of an atomic write.  When this happens, we dynamically recompute the
> tr_atomic_write transaction reservation based on the given block size,
> and then check that we don't violate any of the minimum log size
> constraints.
> 
> The actual software atomic write max is still computed based off of
> tr_atomic the same way it has for the past few commits.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/admin-guide/xfs.rst |  8 +++++
>  fs/xfs/libxfs/xfs_trans_resv.c    | 54 +++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_trans_resv.h    |  1 +
>  fs/xfs/xfs_mount.c                |  8 ++++-
>  fs/xfs/xfs_mount.h                |  5 +++
>  fs/xfs/xfs_super.c                | 28 +++++++++++++++-
>  fs/xfs/xfs_trace.h                | 33 +++++++++++++++++++
>  7 files changed, 135 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
> index b67772cf36d6..715019ec4f24 100644
> --- a/Documentation/admin-guide/xfs.rst
> +++ b/Documentation/admin-guide/xfs.rst
> @@ -143,6 +143,14 @@ When mounting an XFS filesystem, the following options are accepted.
>  	optional, and the log section can be separate from the data
>  	section or contained within it.
>  
> +  max_atomic_write=value
> +	Set the maximum size of an atomic write.  The size may be
> +	specified in bytes, in kilobytes with a "k" suffix, in megabytes
> +	with a "m" suffix, or in gigabytes with a "g" suffix.
> +
> +	The default value is to set the maximum io completion size
> +	to allow each CPU to handle one at a time.
> +
>    noalign
>  	Data allocations will not be aligned at stripe unit
>  	boundaries. This is only relevant to filesystems created
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
> index f530aa5d72f5..36e47ec3c3c2 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.c
> +++ b/fs/xfs/libxfs/xfs_trans_resv.c
> @@ -1475,3 +1475,57 @@ xfs_calc_max_atomic_write_fsblocks(
>  
>  	return ret;
>  }
> +
> +/*
> + * Compute the log reservation needed to complete an atomic write of a given
> + * number of blocks.  Worst case, each block requires separate handling.
> + * Returns true if the blockcount is supported, false otherwise.
> + */
> +bool
> +xfs_calc_atomic_write_reservation(
> +	struct xfs_mount	*mp,
> +	int			bytes)

Hmm, the comment says this should be a block count, not a byte count.

	xfs_extlen_t		blockcount)

> +{
> +	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
> +	unsigned int		per_intent, step_size;
> +	unsigned int		logres;
> +	xfs_extlen_t		blockcount = XFS_B_TO_FSBT(mp, bytes);
> +	uint			old_logres =
> +		M_RES(mp)->tr_atomic_ioend.tr_logres;
> +	int			min_logblocks;
> +
> +	/*
> +	 * If the caller doesn't ask for a specific atomic write size, then
> +	 * we'll use conservatively use tr_itruncate as the basis for computing
> +	 * a reasonable maximum.
> +	 */
> +	if (blockcount == 0) {
> +		curr_res->tr_logres = M_RES(mp)->tr_itruncate.tr_logres;
> +		return true;
> +	}
> +
> +	/* Untorn write completions require out of place write remapping */
> +	if (!xfs_has_reflink(mp))
> +		return false;
> +
> +	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
> +
> +	if (check_mul_overflow(blockcount, per_intent, &logres))
> +		return false;
> +	if (check_add_overflow(logres, step_size, &logres))
> +		return false;
> +
> +	curr_res->tr_logres = logres;
> +	min_logblocks = xfs_log_calc_minimum_size(mp);
> +
> +	trace_xfs_calc_max_atomic_write_reservation(mp, per_intent, step_size,
> +			blockcount, min_logblocks, curr_res->tr_logres);
> +
> +	if (min_logblocks > mp->m_sb.sb_logblocks) {
> +		/* Log too small, revert changes. */
> +		curr_res->tr_logres = old_logres;
> +		return false;
> +	}
> +
> +	return true;
> +}
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
> index a6d303b83688..af974f920556 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.h
> +++ b/fs/xfs/libxfs/xfs_trans_resv.h
> @@ -122,5 +122,6 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
>  unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
>  
>  xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
> +bool xfs_calc_atomic_write_reservation(struct xfs_mount *mp, int bytes);
>  
>  #endif	/* __XFS_TRANS_RESV_H__ */
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 860fc3c91fd5..b8dd9e956c2a 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -671,7 +671,7 @@ static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
>  	return 1 << (ffs(nr) - 1);
>  }
>  
> -static inline void
> +void
>  xfs_compute_atomic_write_unit_max(
>  	struct xfs_mount	*mp)
>  {
> @@ -1160,6 +1160,12 @@ xfs_mountfs(
>  	 * derived from transaction reservations, so we must do this after the
>  	 * log is fully initialized.
>  	 */
> +	if (!xfs_calc_atomic_write_reservation(mp, mp->m_awu_max_bytes)) {
> +		xfs_warn(mp, "cannot support atomic writes of %u bytes",
> +				mp->m_awu_max_bytes);
> +		error = -EINVAL;
> +		goto out_agresv;
> +	}

Hmm.  I don't think this is sufficient validation of m_awu_max_bytes.
xfs_compute_atomic_write_unit_max never allows an atomic write that is
larger than MAX_RW_COUNT or larger than the allocation group, because
it's not possible to land a single write larger than either of those
sizes.  The parsing code ignores values that aren't congruent with
an fsblock size, and suffix_kstrtoint gets confused if you feed it
values that are too large (like "2g").  I propose something like this:

/*
 * Try to set the atomic write maximum to a new value that we got from
 * userspace via mount option.
 */
int
xfs_set_max_atomic_write_opt(
	struct xfs_mount	*mp,
	unsigned long long	new_max_bytes)
{
	xfs_filblks_t		new_max_fsbs = XFS_B_TO_FSBT(mp, new_max_bytes);

	if (new_max_bytes) {
		xfs_extlen_t	max_write_fsbs =
			rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
		xfs_extlen_t	max_group_fsbs =
			max(mp->m_groups[XG_TYPE_AG].blocks,
			    mp->m_groups[XG_TYPE_RTG].blocks);

		ASSERT(max_write_fsbs <= U32_MAX);

		if (new_max_bytes % mp->m_sb.sb_blocksize > 0) {
			xfs_warn(mp,
 "max atomic write size of %llu bytes not aligned with fsblock",
					new_max_bytes);
			return -EINVAL;
		}

		if (new_max_fsbs > max_write_fsbs) {
			xfs_warn(mp,
 "max atomic write size of %lluk cannot be larger than max write size %lluk",
					new_max_bytes >> 10,
					XFS_FSB_TO_B(mp, max_write_fsbs) >> 10);
			return -EINVAL;
		}

		if (new_max_fsbs > max_group_fsbs) {
			xfs_warn(mp,
 "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
					new_max_bytes >> 10,
					XFS_FSB_TO_B(mp, max_group_fsbs) >> 10);
			return -EINVAL;
		}
	}

	if (!xfs_calc_atomic_write_reservation(mp, new_max_fsbs)) {
		xfs_warn(mp,
 "cannot support completing atomic writes of %lluk",
				new_max_bytes >> 10);
		return -EINVAL;
	}

	xfs_compute_atomic_write_unit_max(mp);
	return 0;
}

and then we get some nicer error messages about what exactly failed
validation.

>  	xfs_compute_atomic_write_unit_max(mp);
>  
>  	return 0;
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index c0eff3adfa31..a5037db4ecff 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -236,6 +236,9 @@ typedef struct xfs_mount {
>  	bool			m_update_sb;	/* sb needs update in mount */
>  	unsigned int		m_max_open_zones;
>  
> +	/* max_atomic_write mount option value */
> +	unsigned int		m_awu_max_bytes;
> +
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
>  	 * Callers must hold m_sb_lock to access these two fields.
> @@ -798,4 +801,6 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
>  	percpu_counter_add(&mp->m_delalloc_blks, delta);
>  }
>  
> +void xfs_compute_atomic_write_unit_max(struct xfs_mount *mp);
> +
>  #endif	/* __XFS_MOUNT_H__ */
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b2dd0c0bf509..f7849052e5ff 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -111,7 +111,7 @@ enum {
>  	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
>  	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
>  	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
> -	Opt_lifetime, Opt_nolifetime,
> +	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
>  };
>  
>  static const struct fs_parameter_spec xfs_fs_parameters[] = {
> @@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
>  	fsparam_u32("max_open_zones",	Opt_max_open_zones),
>  	fsparam_flag("lifetime",	Opt_lifetime),
>  	fsparam_flag("nolifetime",	Opt_nolifetime),
> +	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
>  	{}
>  };
>  
> @@ -241,6 +242,9 @@ xfs_fs_show_options(
>  
>  	if (mp->m_max_open_zones)
>  		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
> +	if (mp->m_awu_max_bytes)
> +		seq_printf(m, ",max_atomic_write=%uk",
> +				mp->m_awu_max_bytes >> 10);
>  
>  	return 0;
>  }
> @@ -1518,6 +1522,13 @@ xfs_fs_parse_param(
>  	case Opt_nolifetime:
>  		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
>  		return 0;
> +	case Opt_max_atomic_write:
> +		if (suffix_kstrtoint(param->string, 10,
> +				     &parsing_mp->m_awu_max_bytes))

Let's replace this with a new suffix_kstrtoull helper that returns an
unsigned long long quantity that won't get confused.  This has the
unfortunate consequence that we have to burn a u64 in xfs_mount instead
of a u32.

--D

> +			return -EINVAL;
> +		if (parsing_mp->m_awu_max_bytes < 0)
> +			return -EINVAL;
> +		return 0;
>  	default:
>  		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
>  		return -EINVAL;
> @@ -2114,6 +2125,16 @@ xfs_fs_reconfigure(
>  	if (error)
>  		return error;
>  
> +	/* validate new max_atomic_write option before making other changes */
> +	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
> +		if (!xfs_calc_atomic_write_reservation(mp,
> +					new_mp->m_awu_max_bytes)) {
> +			xfs_warn(mp, "cannot support atomic writes of %u bytes",
> +					new_mp->m_awu_max_bytes);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	/* inode32 -> inode64 */
>  	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
>  		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
> @@ -2140,6 +2161,11 @@ xfs_fs_reconfigure(
>  			return error;
>  	}
>  
> +	/* set new atomic write max here */
> +	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
> +		xfs_compute_atomic_write_unit_max(mp);
> +		mp->m_awu_max_bytes = new_mp->m_awu_max_bytes;
> +	}
>  	return 0;
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 24d73e9bbe83..d41885f1efe2 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
>  		  __entry->blockcount)
>  );
>  
> +TRACE_EVENT(xfs_calc_max_atomic_write_reservation,
> +	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
> +		 unsigned int step_size, unsigned int blockcount,
> +		 unsigned int min_logblocks, unsigned int logres),
> +	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned int, per_intent)
> +		__field(unsigned int, step_size)
> +		__field(unsigned int, blockcount)
> +		__field(unsigned int, min_logblocks)
> +		__field(unsigned int, cur_logblocks)
> +		__field(unsigned int, logres)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = mp->m_super->s_dev;
> +		__entry->per_intent = per_intent;
> +		__entry->step_size = step_size;
> +		__entry->blockcount = blockcount;
> +		__entry->min_logblocks = min_logblocks;
> +		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
> +		__entry->logres = logres;
> +	),
> +	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->per_intent,
> +		  __entry->step_size,
> +		  __entry->blockcount,
> +		  __entry->min_logblocks,
> +		  __entry->cur_logblocks,
> +		  __entry->logres)
> +);
> +
>  TRACE_EVENT(xlog_intent_recovery_failed,
>  	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
>  		 int error),
> -- 
> 2.31.1
> 
> 

