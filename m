Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFDAFDE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfIKNnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfIKNne (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBA7D10F23FA;
        Wed, 11 Sep 2019 13:43:33 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78F611001944;
        Wed, 11 Sep 2019 13:43:32 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 7/9] fiemap: Use a callback to fill fiemap extents
Date:   Wed, 11 Sep 2019 15:43:13 +0200
Message-Id: <20190911134315.27380-8-cmaiolino@redhat.com>
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Wed, 11 Sep 2019 13:43:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a goal to enable fiemap infrastructure to be used by fibmap too, we need a
way to use different helpers to fill extent data, depending on its usage. One
helper to fill extent data stored in user address space (used in fiemap), and
another fo fill extent data stored in kernel address space (will be used in
fibmap).

This patch sets up the usage of a callback to be used to fill in the extents.
It transforms the current fiemap_fill_next_extent, into a simple helper to call
the callback, avoiding unneeded changes on any filesystem, and reutilizes the
original function as the callback used by FIEMAP.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---

Changelog:
	V6:
		- Rebased against next/master
		- Fix conflict on ext4 code
	V5:
		- Rebased against 5.3 with no changes
	V3:
		- Rebase to current linux-next
		- Fix conflict on rebase
		- Merge this patch into patch 07 from V2
		- Rename fi_extents_start to fi_cb_data
	V2:
		- Now based on the rework on fiemap_extent_info (previous was
		  based on fiemap_ctx)

 fs/ext4/ioctl.c    |  4 ++--
 fs/ioctl.c         | 45 ++++++++++++++++++++++++++-------------------
 include/linux/fs.h | 12 +++++++++---
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 546a26a2c800..1dd267e7d450 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -794,12 +794,12 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 
 	fieinfo.fi_flags = fiemap.fm_flags;
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
-	fieinfo.fi_extents_start = ufiemap->fm_extents;
+	fieinfo.fi_cb_data = ufiemap->fm_extents;
 	fieinfo.fi_start = fiemap.fm_start;
 	fieinfo.fi_len = len;
 
 	if (fiemap.fm_extent_count != 0 &&
-	    !access_ok(fieinfo.fi_extents_start,
+	    !access_ok(fieinfo.fi_cb_data,
 		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
 		return -EFAULT;
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index ad8edcb10dc9..d72696c222de 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -77,29 +77,14 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	return error;
 }
 
-/**
- * fiemap_fill_next_extent - Fiemap helper function
- * @fieinfo:	Fiemap context passed into ->fiemap
- * @logical:	Extent logical start offset, in bytes
- * @phys:	Extent physical start offset, in bytes
- * @len:	Extent length, in bytes
- * @flags:	FIEMAP_EXTENT flags that describe this extent
- *
- * Called from file system ->fiemap callback. Will populate extent
- * info as passed in via arguments and copy to user memory. On
- * success, extent count on fieinfo is incremented.
- *
- * Returns 0 on success, -errno on error, 1 if this was the last
- * extent that will fit in user array.
- */
 #define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
 #define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
 #define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
-int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
+int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 			    u64 phys, u64 len, u32 flags)
 {
 	struct fiemap_extent extent;
-	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+	struct fiemap_extent __user *dest = fieinfo->fi_cb_data;
 
 	/* only count the extents */
 	if (fieinfo->fi_extents_max == 0) {
@@ -132,6 +117,27 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 		return 1;
 	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
 }
+
+/**
+ * fiemap_fill_next_extent - Fiemap helper function
+ * @fieinfo:	Fiemap context passed into ->fiemap
+ * @logical:	Extent logical start offset, in bytes
+ * @phys:	Extent physical start offset, in bytes
+ * @len:	Extent length, in bytes
+ * @flags:	FIEMAP_EXTENT flags that describe this extent
+ *
+ * Called from file system ->fiemap callback. Will populate extent
+ * info as passed in via arguments and copy to user memory. On
+ * success, extent count on fieinfo is incremented.
+ *
+ * Returns 0 on success, -errno on error, 1 if this was the last
+ * extent that will fit in user array.
+ */
+int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
+			    u64 phys, u64 len, u32 flags)
+{
+	return fieinfo->fi_cb(fieinfo, logical, phys, len, flags);
+}
 EXPORT_SYMBOL(fiemap_fill_next_extent);
 
 /**
@@ -209,12 +215,13 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
 
 	fieinfo.fi_flags = fiemap.fm_flags;
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
-	fieinfo.fi_extents_start = ufiemap->fm_extents;
+	fieinfo.fi_cb_data = ufiemap->fm_extents;
 	fieinfo.fi_start = fiemap.fm_start;
 	fieinfo.fi_len = len;
+	fieinfo.fi_cb = fiemap_fill_user_extent;
 
 	if (fiemap.fm_extent_count != 0 &&
-	    !access_ok(fieinfo.fi_extents_start,
+	    !access_ok(fieinfo.fi_cb_data,
 		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
 		return -EFAULT;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c0438de4982..df33997cc209 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -68,6 +68,7 @@ struct fsverity_info;
 struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_description;
+struct fiemap_extent_info;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1736,6 +1737,10 @@ extern bool may_open_dev(const struct path *path);
 /*
  * VFS FS_IOC_FIEMAP helper definitions.
  */
+
+typedef int (*fiemap_fill_cb)(struct fiemap_extent_info *fieinfo, u64 logical,
+			      u64 phys, u64 len, u32 flags);
+
 struct fiemap_extent_info {
 	unsigned int	fi_flags;		/* Flags as passed from user */
 	u64		fi_start;		/* Logical offset at which
@@ -1744,10 +1749,11 @@ struct fiemap_extent_info {
 						   caller cares about */
 	unsigned int	fi_extents_mapped;	/* Number of mapped extents */
 	unsigned int	fi_extents_max;		/* Size of fiemap_extent array */
-	struct		fiemap_extent __user *fi_extents_start;	/* Start of
-								   fiemap_extent
-								   array */
+	void		*fi_cb_data;		/* Start of fiemap_extent
+						   array */
+	fiemap_fill_cb	fi_cb;
 };
+
 int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
 			    u64 phys, u64 len, u32 flags);
 int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
-- 
2.20.1

