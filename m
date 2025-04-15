Return-Path: <linux-fsdevel+bounces-46518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0856A8AB59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 00:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06F67AC6D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 22:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1022DFB4;
	Tue, 15 Apr 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig9yW8xi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07128934F;
	Tue, 15 Apr 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756586; cv=none; b=WupjYMOZlc/59mH4LLgjS2k8SfFYvt7KCLwzDmkcGfSEAvYuYar/vQaQzYFy7/rHae7LEekV1qRBq/26xb/v/leXnhjIMwh8eG5NcHo7gLwupncbw6bAlxkmHKz2D6XHuZ2M26+Gct4VngOTDamNPZ1FDZbN4ZDQSCtITLJApZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756586; c=relaxed/simple;
	bh=WH9UUYC9KfYUqg0sqxc9yszTOLHLDkGjbDfqpf0VXyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h52R8rRFqx9lk9uRNcmGUxaTW00JMwhIc3IEaxSoEh9JHlCB9DG1vxQiTPg2P7nGDqnLr/x4A+6+W+9VO3/nWkGL6xhigZdUrwy67pxAFWQWNthvRmUjUqhZ/Mg7GfnqcT31Lsc/tSM1K7IUZ1vjn2cXsih/Jc1egGsKBBcOHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig9yW8xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBFDC4CEE7;
	Tue, 15 Apr 2025 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744756586;
	bh=WH9UUYC9KfYUqg0sqxc9yszTOLHLDkGjbDfqpf0VXyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ig9yW8xiyq/yYI2T+rIi6tW27/MPx3vy+r3c5uLxC2GrFQAK3emXTIpUTY101glIm
	 2ARQVigqRQuYnGQ9mqzELsA/P8F0pMP/mxu/bMi2nLPAEPpVoMOkcDJkb1sBt7WI8H
	 3i48eZufU6uxyYa/NBi6EEbW+CZlybo/fIcmNlhMVOo6gdquB32a/udCnQJI/586Sw
	 3Fuos32s9IQFIqPxgSNQK2UrWNj9zwbXzPVBjuvLrRrTo4ea2olm4eArXn1m+V3YVj
	 a+tAQAEIS5awDLzGrgc4YrOvZbZ+6G99WKqTGCxOTlFtZ/QwGWY5vvcmY4gdMP4Dnu
	 G6Zo+zVfiMxsA==
Date: Tue, 15 Apr 2025 15:36:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: [PATCH v7.1 14/14] xfs: allow sysadmins to specify a maximum atomic
 write limit at mount time
Message-ID: <20250415223625.GV25675@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Introduce a mount option to allow sysadmins to specify the maximum size
of an atomic write.  If the filesystem can work with the supplied value,
that becomes the new guaranteed maximum.

The value mustn't be too big for the existing filesystem geometry (max
write size, max AG/rtgroup size).  We dynamically recompute the
tr_atomic_write transaction reservation based on the given block size,
check that the current log size isn't less than the new minimum log size
constraints, and set a new maximum.

The actual software atomic write max is still computed based off of
tr_atomic_ioend the same way it has for the past few commits.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
v7.1: make all the tweaks I already complained about here
---
 fs/xfs/libxfs/xfs_trans_resv.h    |    2 +
 fs/xfs/xfs_mount.h                |    6 ++++
 fs/xfs/xfs_trace.h                |   33 ++++++++++++++++++++
 Documentation/admin-guide/xfs.rst |   11 +++++++
 fs/xfs/libxfs/xfs_trans_resv.c    |   53 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.c                |   59 ++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_super.c                |   60 ++++++++++++++++++++++++++++++++++++-
 7 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index a6d303b836883f..ea50a239c31107 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -122,5 +122,7 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
 xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+bool xfs_calc_atomic_write_reservation(struct xfs_mount *mp,
+		xfs_extlen_t blockcount);
 
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index c0eff3adfa31f6..68e2acc00b5321 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -236,6 +236,9 @@ typedef struct xfs_mount {
 	bool			m_update_sb;	/* sb needs update in mount */
 	unsigned int		m_max_open_zones;
 
+	/* max_atomic_write mount option value */
+	unsigned long long	m_awu_max_bytes;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
@@ -798,4 +801,7 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
 	percpu_counter_add(&mp->m_delalloc_blks, delta);
 }
 
+int xfs_set_max_atomic_write_opt(struct xfs_mount *mp,
+		unsigned long long new_max_bytes);
+
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 24d73e9bbe83f4..d41885f1efe25b 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
 		  __entry->blockcount)
 );
 
+TRACE_EVENT(xfs_calc_max_atomic_write_reservation,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int blockcount,
+		 unsigned int min_logblocks, unsigned int logres),
+	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, blockcount)
+		__field(unsigned int, min_logblocks)
+		__field(unsigned int, cur_logblocks)
+		__field(unsigned int, logres)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->blockcount = blockcount;
+		__entry->min_logblocks = min_logblocks;
+		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
+		__entry->logres = logres;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->blockcount,
+		  __entry->min_logblocks,
+		  __entry->cur_logblocks,
+		  __entry->logres)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index b67772cf36d6dc..0f6e5d4784f9c3 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -143,6 +143,17 @@ When mounting an XFS filesystem, the following options are accepted.
 	optional, and the log section can be separate from the data
 	section or contained within it.
 
+  max_atomic_write=value
+	Set the maximum size of an atomic write.  The size may be
+	specified in bytes, in kilobytes with a "k" suffix, in megabytes
+	with a "m" suffix, or in gigabytes with a "g" suffix.  The size
+	cannot be larger than the maximum write size, larger than the
+	size of any allocation group, or larger than the size of a
+	remapping operation that the log can complete atomically.
+
+	The default value is to set the maximum I/O completion size
+	to allow each CPU to handle one at a time.
+
   noalign
 	Data allocations will not be aligned at stripe unit
 	boundaries. This is only relevant to filesystems created
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index f530aa5d72f552..48e75c7ba2bb69 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1475,3 +1475,56 @@ xfs_calc_max_atomic_write_fsblocks(
 
 	return ret;
 }
+
+/*
+ * Compute the log reservation needed to complete an atomic write of a given
+ * number of blocks.  Worst case, each block requires separate handling.
+ * Returns true if the blockcount is supported, false otherwise.
+ */
+bool
+xfs_calc_atomic_write_reservation(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount)
+{
+	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int		per_intent, step_size;
+	unsigned int		logres;
+	uint			old_logres =
+		M_RES(mp)->tr_atomic_ioend.tr_logres;
+	int			min_logblocks;
+
+	/*
+	 * If the caller doesn't ask for a specific atomic write size, then
+	 * we'll use conservatively use tr_itruncate as the basis for computing
+	 * a reasonable maximum.
+	 */
+	if (blockcount == 0) {
+		curr_res->tr_logres = M_RES(mp)->tr_itruncate.tr_logres;
+		return true;
+	}
+
+	/* Untorn write completions require out of place write remapping */
+	if (!xfs_has_reflink(mp))
+		return false;
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	if (check_mul_overflow(blockcount, per_intent, &logres))
+		return false;
+	if (check_add_overflow(logres, step_size, &logres))
+		return false;
+
+	curr_res->tr_logres = logres;
+	min_logblocks = xfs_log_calc_minimum_size(mp);
+
+	trace_xfs_calc_max_atomic_write_reservation(mp, per_intent, step_size,
+			blockcount, min_logblocks, curr_res->tr_logres);
+
+	if (min_logblocks > mp->m_sb.sb_logblocks) {
+		/* Log too small, revert changes. */
+		curr_res->tr_logres = old_logres;
+		return false;
+	}
+
+	return true;
+}
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index cec202cf7803d8..1eda18dfb1f667 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -737,6 +737,61 @@ xfs_compute_atomic_write_unit_max(
 			max_agsize, max_rgsize);
 }
 
+/*
+ * Try to set the atomic write maximum to a new value that we got from
+ * userspace via mount option.
+ */
+int
+xfs_set_max_atomic_write_opt(
+	struct xfs_mount	*mp,
+	unsigned long long	new_max_bytes)
+{
+	xfs_filblks_t		new_max_fsbs = XFS_B_TO_FSBT(mp, new_max_bytes);
+
+	if (new_max_bytes) {
+		xfs_extlen_t	max_write_fsbs =
+			rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
+		xfs_extlen_t	max_group_fsbs =
+			max(mp->m_groups[XG_TYPE_AG].blocks,
+			    mp->m_groups[XG_TYPE_RTG].blocks);
+
+		ASSERT(max_write_fsbs <= U32_MAX);
+
+		if (new_max_bytes % mp->m_sb.sb_blocksize > 0) {
+			xfs_warn(mp,
+ "max atomic write size of %llu bytes not aligned with fsblock",
+					new_max_bytes);
+			return -EINVAL;
+		}
+
+		if (new_max_fsbs > max_write_fsbs) {
+			xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max write size %lluk",
+					new_max_bytes >> 10,
+					XFS_FSB_TO_B(mp, max_write_fsbs) >> 10);
+			return -EINVAL;
+		}
+
+		if (new_max_fsbs > max_group_fsbs) {
+			xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
+					new_max_bytes >> 10,
+					XFS_FSB_TO_B(mp, max_group_fsbs) >> 10);
+			return -EINVAL;
+		}
+	}
+
+	if (!xfs_calc_atomic_write_reservation(mp, new_max_fsbs)) {
+		xfs_warn(mp,
+ "cannot support completing atomic writes of %lluk",
+				new_max_bytes >> 10);
+		return -EINVAL;
+	}
+
+	xfs_compute_atomic_write_unit_max(mp);
+	return 0;
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1158,7 +1213,9 @@ xfs_mountfs(
 	 * derived from transaction reservations, so we must do this after the
 	 * log is fully initialized.
 	 */
-	xfs_compute_atomic_write_unit_max(mp);
+	error = xfs_set_max_atomic_write_opt(mp, mp->m_awu_max_bytes);
+	if (error)
+		goto out_agresv;
 
 	return 0;
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf50979..9f422bcf651801 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -111,7 +111,7 @@ enum {
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
 	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
-	Opt_lifetime, Opt_nolifetime,
+	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_u32("max_open_zones",	Opt_max_open_zones),
 	fsparam_flag("lifetime",	Opt_lifetime),
 	fsparam_flag("nolifetime",	Opt_nolifetime),
+	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
 	{}
 };
 
@@ -241,6 +242,9 @@ xfs_fs_show_options(
 
 	if (mp->m_max_open_zones)
 		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
+	if (mp->m_awu_max_bytes)
+		seq_printf(m, ",max_atomic_write=%lluk",
+				mp->m_awu_max_bytes >> 10);
 
 	return 0;
 }
@@ -1334,6 +1338,42 @@ suffix_kstrtoint(
 	return ret;
 }
 
+static int
+suffix_kstrtoull(
+	const char		*s,
+	unsigned int		base,
+	unsigned long long	*res)
+{
+	int			last, shift_left_factor = 0;
+	unsigned long long	_res;
+	char			*value;
+	int			ret = 0;
+
+	value = kstrdup(s, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	last = strlen(value) - 1;
+	if (value[last] == 'K' || value[last] == 'k') {
+		shift_left_factor = 10;
+		value[last] = '\0';
+	}
+	if (value[last] == 'M' || value[last] == 'm') {
+		shift_left_factor = 20;
+		value[last] = '\0';
+	}
+	if (value[last] == 'G' || value[last] == 'g') {
+		shift_left_factor = 30;
+		value[last] = '\0';
+	}
+
+	if (kstrtoull(value, base, &_res))
+		ret = -EINVAL;
+	kfree(value);
+	*res = _res << shift_left_factor;
+	return ret;
+}
+
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
@@ -1518,6 +1558,14 @@ xfs_fs_parse_param(
 	case Opt_nolifetime:
 		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
 		return 0;
+	case Opt_max_atomic_write:
+		if (suffix_kstrtoull(param->string, 10,
+				     &parsing_mp->m_awu_max_bytes)) {
+			xfs_warn(parsing_mp,
+ "max atomic write size must be positive integer");
+			return -EINVAL;
+		}
+		return 0;
 	default:
 		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
 		return -EINVAL;
@@ -2114,6 +2162,16 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* Validate new max_atomic_write option before making other changes */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		error = xfs_set_max_atomic_write_opt(mp,
+				new_mp->m_awu_max_bytes);
+		if (error)
+			return error;
+
+		mp->m_awu_max_bytes = new_mp->m_awu_max_bytes;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;

