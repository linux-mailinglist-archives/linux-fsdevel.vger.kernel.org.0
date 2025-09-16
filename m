Return-Path: <linux-fsdevel+bounces-61533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFDEB589A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098E03B4E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28E83CC7;
	Tue, 16 Sep 2025 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JanKC6AQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB41BC5C;
	Tue, 16 Sep 2025 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982886; cv=none; b=sVKvhOO5QvKbaD2b4A2KLyjECQpLBRI+gF8sMR/zogMfYhaCtvnd3RW9BVX5IQzTt7F9CQddVzv2S5MV0uh6Ly6LrcgiLs8FzOPeZgA10v0AehktZGk0f7AE9/SvwB49fAMMZ4dReCcVCXVE31wbDo1+hR7L7a7fm6X3EnOA6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982886; c=relaxed/simple;
	bh=8rNMH01miLyrIOfX212PMgIpGU+hYx3ZSB9mhk0SV8A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnzNWKEfks9L/Z1fjcdUyWFtjj1kTrbr09oZ25kJncj7RP+Qi9jujAXlQaKY3yLvjtJui2jcjuGlau94LPKZVh4bwEfoVCxQnFc2SjObG+b68eupVnnYNMb2BolWJet4olqXynPIThGojH1Li3LmEL9HnLq04qVXDWTKXFPmkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JanKC6AQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D42BC4CEF1;
	Tue, 16 Sep 2025 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982885;
	bh=8rNMH01miLyrIOfX212PMgIpGU+hYx3ZSB9mhk0SV8A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JanKC6AQF0v4YO2lFF9O+cMTjNu7l21U0UtR2mtLXkj3cM8Hbvi7Ws9KVEQEip6O2
	 iYwBaMLFbeguBlfaMZ3BMpEJZw19pA/yuzguyteVFUCVXbRw4b4tBf6AYzBCviulRD
	 hCMCK8GRLtH8bdYUJMNrpUnp2wXc5wGIwLV1hQ79Z7qjVXx9jWYW3um5fNe+nGXg0p
	 vBsyFTe5+5lhZbOG6EhUTQlHEvovpEoMDwXiQbqbB18Pt/mfasgD3ypJJtp+jaezyX
	 81hpxEXkeLTFlMjpO7DkKMQ9zakZBR/TQzdtgD/Toni0fvQqPOZ1yp1EcQRhKuDG1P
	 /GI/BGObKFLaw==
Date: Mon, 15 Sep 2025 17:34:45 -0700
Subject: [PATCH 26/28] fuse: allow more statx fields
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151823.382724.9672902202730606336.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow the fuse server to supply us with the more recently added fields
of struct statx.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    8 +++++
 include/uapi/linux/fuse.h |   15 ++++++++-
 fs/fuse/dir.c             |   75 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 86 insertions(+), 12 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4aa7199dd0cd9f..02af28f49cdfe5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1733,6 +1733,14 @@ void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
 
 sector_t fuse_bmap(struct address_space *mapping, sector_t block);
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+int fuse_iomap_sysfs_init(struct kobject *kobj);
+void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
+#else
+# define fuse_iomap_sysfs_init(...)		(0)
+# define fuse_iomap_sysfs_cleanup(...)		((void)0)
+#endif
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 bool fuse_iomap_enabled(void);
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b63fba0a2c52c9..e0139fb43f82ea 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -334,7 +334,20 @@ struct fuse_statx {
 	uint32_t	rdev_minor;
 	uint32_t	dev_major;
 	uint32_t	dev_minor;
-	uint64_t	__spare2[14];
+
+	uint64_t	mnt_id;
+	uint32_t	dio_mem_align;
+	uint32_t	dio_offset_align;
+	uint64_t	subvol;
+
+	uint32_t	atomic_write_unit_min;
+	uint32_t	atomic_write_unit_max;
+	uint32_t	atomic_write_segments_max;
+	uint32_t	dio_read_offset_align;
+	uint32_t	atomic_write_unit_max_opt;
+	uint32_t	__spare2[1];
+
+	uint64_t	__spare3[8];
 };
 
 struct fuse_kstatfs {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d62ceadbc05fb2..b5e3536f1d53c1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1274,6 +1274,50 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
 	attr->blksize = sx->blksize;
 }
 
+#define FUSE_SUPPORTED_STATX_MASK	(STATX_BASIC_STATS | \
+					 STATX_BTIME | \
+					 STATX_DIOALIGN | \
+					 STATX_SUBVOL | \
+					 STATX_WRITE_ATOMIC)
+
+#define FUSE_UNCACHED_STATX_MASK	(STATX_DIOALIGN | \
+					 STATX_SUBVOL | \
+					 STATX_WRITE_ATOMIC)
+
+static void kstat_from_fuse_statx(const struct fuse_conn *fc,
+				  struct kstat *stat,
+				  const struct fuse_statx *sx)
+{
+	stat->result_mask = sx->mask & FUSE_SUPPORTED_STATX_MASK;
+
+	stat->attributes |= fuse_statx_attributes(fc, sx);
+	stat->attributes_mask |= fuse_statx_attributes_mask(fc, sx);
+
+	if (sx->mask & STATX_BTIME) {
+		stat->btime.tv_sec = sx->btime.tv_sec;
+		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec,
+					    NSEC_PER_SEC - 1);
+	}
+
+	if (sx->mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = sx->dio_mem_align;
+		stat->dio_offset_align = sx->dio_offset_align;
+	}
+
+	if (sx->mask & STATX_SUBVOL)
+		stat->subvol = sx->subvol;
+
+	if (sx->mask & STATX_WRITE_ATOMIC) {
+		stat->atomic_write_unit_min = sx->atomic_write_unit_min;
+		stat->atomic_write_unit_max = sx->atomic_write_unit_max;
+		stat->atomic_write_unit_max_opt = sx->atomic_write_unit_max_opt;
+		stat->atomic_write_segments_max = sx->atomic_write_segments_max;
+	}
+
+	if (sx->mask & STATX_DIO_READ_ALIGN)
+		stat->dio_read_offset_align = sx->dio_read_offset_align;
+}
+
 static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 			 struct file *file, struct kstat *stat)
 {
@@ -1297,7 +1341,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 	/* For now leave sync hints as the default, request all stats. */
 	inarg.sx_flags = 0;
-	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	inarg.sx_mask = FUSE_SUPPORTED_STATX_MASK;
 	args.opcode = FUSE_STATX;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -1325,11 +1369,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 
 	if (stat) {
-		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
-		stat->btime.tv_sec = sx->btime.tv_sec;
-		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-		stat->attributes |= fuse_statx_attributes(fm->fc, sx);
-		stat->attributes_mask |= fuse_statx_attributes_mask(fm->fc, sx);
+		kstat_from_fuse_statx(fm->fc, stat, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1394,16 +1434,29 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
-
-	/* FUSE only supports basic stats and possibly btime */
-	request_mask &= STATX_BASIC_STATS | STATX_BTIME;
+	/* Only ask for supported stats */
+	request_mask &= FUSE_SUPPORTED_STATX_MASK;
 retry:
 	if (fc->no_statx)
 		request_mask &= STATX_BASIC_STATS;
 
 	if (!request_mask)
 		sync = false;
-	else if (flags & AT_STATX_FORCE_SYNC)
+	else if (request_mask & FUSE_UNCACHED_STATX_MASK) {
+		switch (flags & AT_STATX_SYNC_TYPE) {
+		case AT_STATX_DONT_SYNC:
+			request_mask &= ~FUSE_UNCACHED_STATX_MASK;
+			sync = false;
+			break;
+		case AT_STATX_FORCE_SYNC:
+		case AT_STATX_SYNC_AS_STAT:
+			sync = true;
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+	} else if (flags & AT_STATX_FORCE_SYNC)
 		sync = true;
 	else if (flags & AT_STATX_DONT_SYNC)
 		sync = false;
@@ -1414,7 +1467,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		/* Try statx if BTIME is requested */
+		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {


