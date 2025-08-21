Return-Path: <linux-fsdevel+bounces-58462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C842EB2E9DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E21A265F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496B1E5B70;
	Thu, 21 Aug 2025 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY+Gd3ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F4C2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737879; cv=none; b=shqqMymQs3PPVTVALleX3Wqm2i4DGRuTfPZny8S76awWGJn+7SMdY5FxN81DHh4kmT84tZpf4i/aZopshyD3SupYErDc8M6kqmTzsC6CgjB3ujv6p9HGNKu8FjqiphQs6AjvpvWVH0CTjImrQSgAjS6ZScOTciFQgj+6KJeqeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737879; c=relaxed/simple;
	bh=aUoR+gQjQRy6xlH2RukbPHCJsAws0u0KMUokFWsbQ3s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA/ilFUeCCpS32innzvbD8YLAABTaJsAx8uPBRP6Ddk32ZcoDSk1RXqS3CfU6IA319u8VJApsRJ/CblJ/o9YCDOS7Irw8nrmHX61ygzO7BMOq6XiV/I9U2q17yy+fTrt5VoWH4WJfwfUvW0Y1ROkQLhGOjQ34P9yJHdtJX2WhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY+Gd3ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2458C4CEE7;
	Thu, 21 Aug 2025 00:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737878;
	bh=aUoR+gQjQRy6xlH2RukbPHCJsAws0u0KMUokFWsbQ3s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qY+Gd3ph45lcOYBk//QdVMlCdrgES+PnI/KfdSOWm+BLF84K5gQtaAEEGytOJnHFN
	 Hj3eE9N+FPaTi1P3e/lN2zaM3uodLVQ83/zrEuG0x5KiqH8ZYQ//S8O9Hq8woYpCBf
	 ui2JZLCQMXlqcktoyLTUfslVrRUr/6ZD0mQbBYR0oG44buJBqZqGCDGpSlfMOILvF7
	 JRsu9LW+9TMcdZJahvTgAPOl6DCdwJaW5ObAnMtpZdTpeCAr91CbNThukLJVsOpqk5
	 vtFjJoGwaYfN+SlBBb+btICcgxTRTVHYJuWccq8eT5UCE+zP413VL5qnffqmkEAQe0
	 7qr0B2+c0YIeQ==
Date: Wed, 20 Aug 2025 17:57:58 -0700
Subject: [PATCH 21/23] fuse: allow more statx fields
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709567.17510.9843223811055273569.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
 include/uapi/linux/fuse.h |   15 +++++++++
 fs/fuse/dir.c             |   73 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 84 insertions(+), 12 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 362fa87241ac70..4ca29315b2a434 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1677,6 +1677,14 @@ void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
 
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
index 1f8e3ba60e7ec5..cfeee8a280896a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -335,7 +335,20 @@ struct fuse_statx {
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
index 02c8e705af1e35..305b926b4a589a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1276,6 +1276,48 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
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
+static void kstat_from_fuse_statx(struct kstat *stat,
+				  const struct fuse_statx *sx)
+{
+	stat->result_mask = sx->mask & FUSE_SUPPORTED_STATX_MASK;
+
+	stat->attributes = sx->attributes;
+	stat->attributes_mask = sx->attributes_mask;
+
+	if (sx->mask & STATX_BTIME) {
+		stat->btime.tv_sec = sx->btime.tv_sec;
+		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
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
@@ -1299,7 +1341,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 	/* For now leave sync hints as the default, request all stats. */
 	inarg.sx_flags = 0;
-	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	inarg.sx_mask = FUSE_SUPPORTED_STATX_MASK;
 	args.opcode = FUSE_STATX;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -1327,11 +1369,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 
 	if (stat) {
-		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
-		stat->btime.tv_sec = sx->btime.tv_sec;
-		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-		stat->attributes = sx->attributes;
-		stat->attributes_mask = sx->attributes_mask;
+		kstat_from_fuse_statx(stat, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1396,16 +1434,29 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
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
@@ -1416,7 +1467,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		/* Try statx if BTIME is requested */
+		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {


