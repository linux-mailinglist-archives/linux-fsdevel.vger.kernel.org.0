Return-Path: <linux-fsdevel+bounces-66028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D1C17A72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A2544F8F65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA62D6E51;
	Wed, 29 Oct 2025 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRmOA8MC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A32D24B6;
	Wed, 29 Oct 2025 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699104; cv=none; b=hvgEn19VyNAUmQPo9Yga06Q4ksyU4HPKZLdr5+58iqs1UfWiUrbPxCDqWEbIkW74vQaM6bvFVQiSSWGkIcOv4ehwXXlYT9Kls+CSpKR56AaEkHEITFs323pC5ZfJmn+jvycTE/8nZgvhCJGC67ec8oc42vWv+Gt6P1qp6uWE/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699104; c=relaxed/simple;
	bh=WpyxXl3LKC/yUvJhnYFY8+iFPHKxqNN4W7iQvgjnwSs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bs/2TZJzCTeHJquth6lb4YkU6hLzGIQSPUWY/zjMUorElNXlLHw9y8R+y3vVQviUDYBlEdFAVs0l5Do/dV0tdbYEP2aNBWelDU7DiIDPx8ujOruEK5Zrb8vofC9s5NEJX2lOYtjLUdzDgp8uLiXnshNjvuk+rpTjdz3oGhs4enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRmOA8MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63840C4CEE7;
	Wed, 29 Oct 2025 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699104;
	bh=WpyxXl3LKC/yUvJhnYFY8+iFPHKxqNN4W7iQvgjnwSs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PRmOA8MCp63dZ77FbEzsgH6K8qK2pXxRx3XJpx/3Z+/GwLV8avj9p0NBptfjeUSGI
	 hpPQQkZbfOgTA+mC8iIs2lbGqtWBlB2xAGy32XGTF0JLVu2IE0kjKDBNH0z18t1aFL
	 iwKFtzdZYwVVlcrn4/C1Jazka5bG6EfPwmyDtHqNt8vgjxdaRl2yfUNWgkwSx5YL5m
	 CdbMZSDUOQdAn9p18AIdYwNIcLGDGHdMKboeIq3GGZFeF+TV8rA1M8jh60D4p0IvKa
	 0cuvFF8XZBGa+OR2YbXhZ9/CtWjja848PQf0wI2lxcaatmApwZelOJZk4ctjFim8YI
	 HTKhy8ZoafS8g==
Date: Tue, 28 Oct 2025 17:51:43 -0700
Subject: [PATCH 26/31] fuse: allow more statx fields
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810917.1424854.10390527171483697608.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
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
index e937add0ea7baf..f6b6944fad553c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1735,6 +1735,14 @@ void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
 
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
index 976773bb6295ff..838d925d2947e0 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -339,7 +339,20 @@ struct fuse_statx {
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
index 5e7e7d4c2c5085..c35ddd5070225c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1267,6 +1267,50 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
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
+static void kstat_from_fuse_statx(const struct inode *inode,
+				  struct kstat *stat,
+				  const struct fuse_statx *sx)
+{
+	stat->result_mask = sx->mask & FUSE_SUPPORTED_STATX_MASK;
+
+	stat->attributes |= fuse_statx_attributes(inode, sx);
+	stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
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
@@ -1290,7 +1334,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 	/* For now leave sync hints as the default, request all stats. */
 	inarg.sx_flags = 0;
-	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	inarg.sx_mask = FUSE_SUPPORTED_STATX_MASK;
 	args.opcode = FUSE_STATX;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -1318,11 +1362,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 
 	if (stat) {
-		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
-		stat->btime.tv_sec = sx->btime.tv_sec;
-		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-		stat->attributes |= fuse_statx_attributes(inode, sx);
-		stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
+		kstat_from_fuse_statx(inode, stat, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1387,16 +1427,29 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
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
@@ -1407,7 +1460,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		/* Try statx if BTIME is requested */
+		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {


