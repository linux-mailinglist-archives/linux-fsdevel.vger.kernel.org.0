Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C96E4AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDQOE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjDQOEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:04:55 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63F76B3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 07:04:36 -0700 (PDT)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33HE3Toj003234;
        Mon, 17 Apr 2023 23:03:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Mon, 17 Apr 2023 23:03:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33HE3T8F003231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Apr 2023 23:03:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bc30483b-7f9b-df4e-7143-8646aeb4b5a2@I-love.SAKURA.ne.jp>
Date:   Mon, 17 Apr 2023 23:03:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH] vfs: allow using kernel buffer during fiemap operation
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        Mark Fasheh <mark@fasheh.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org
References: <000000000000e2102c05eeaf9113@google.com>
 <00000000000031b80705ef5d33d1@google.com>
 <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
In-Reply-To: <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting circular locking dependency between ntfs_file_mmap()
(which has mm->mmap_lock => ni->ni_lock => ni->file.run_lock dependency)
and ntfs_fiemap() (which has ni->ni_lock => ni->file.run_lock =>
mm->mmap_lock dependency), for commit c4b929b85bdb ("vfs: vfs-level fiemap
interface") implemented fiemap_fill_next_extent() using copy_to_user()
where direct mm->mmap_lock dependency is inevitable.

Since ntfs3 does not want to release ni->ni_lock and/or ni->file.run_lock
in order to make sure that "struct ATTRIB" does not change during
ioctl(FS_IOC_FIEMAP) request, let's make it possible to call
fiemap_fill_next_extent() with filesystem locks held.

This patch adds fiemap_fill_next_kernel_extent() which spools
"struct fiemap_extent" to dynamically allocated kernel buffer, and
fiemap_copy_kernel_extent() which copies spooled "struct fiemap_extent"
to userspace buffer after filesystem locks are released.

Reported-by: syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
Reported-by: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/ioctl.c             | 52 ++++++++++++++++++++++++++++++++++++------
 fs/ntfs3/file.c        |  4 ++++
 fs/ntfs3/frecord.c     | 10 ++++----
 include/linux/fiemap.h | 24 +++++++++++++++++--
 4 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5b2481cd4750..60ddc2760932 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -112,11 +112,10 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 #define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
 #define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
 #define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
-int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
-			    u64 phys, u64 len, u32 flags)
+int do_fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
+			       u64 phys, u64 len, u32 flags, bool is_kernel)
 {
 	struct fiemap_extent extent;
-	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
 
 	/* only count the extents */
 	if (fieinfo->fi_extents_max == 0) {
@@ -140,16 +139,55 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	extent.fe_length = len;
 	extent.fe_flags = flags;
 
-	dest += fieinfo->fi_extents_mapped;
-	if (copy_to_user(dest, &extent, sizeof(extent)))
-		return -EFAULT;
+	if (!is_kernel) {
+		struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+
+		dest += fieinfo->fi_extents_mapped;
+		if (copy_to_user(dest, &extent, sizeof(extent)))
+			return -EFAULT;
+	} else {
+		struct fiemap_extent_list *entry = kmalloc(sizeof(*entry), GFP_NOFS);
+
+		if (!entry)
+			return -ENOMEM;
+		memmove(&entry->extent, &extent, sizeof(extent));
+		list_add_tail(&entry->list, &fieinfo->fi_extents_list);
+	}
 
 	fieinfo->fi_extents_mapped++;
 	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
 		return 1;
 	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
 }
-EXPORT_SYMBOL(fiemap_fill_next_extent);
+EXPORT_SYMBOL(do_fiemap_fill_next_extent);
+
+int fiemap_copy_kernel_extent(struct fiemap_extent_info *fieinfo, int err)
+{
+	struct fiemap_extent __user *dest;
+	struct fiemap_extent_list *entry, *tmp;
+	unsigned int len = 0;
+
+	list_for_each_entry(entry, &fieinfo->fi_extents_list, list)
+		len++;
+	if (!len)
+		return err;
+	fieinfo->fi_extents_mapped -= len;
+	dest = fieinfo->fi_extents_start + fieinfo->fi_extents_mapped;
+	list_for_each_entry(entry, &fieinfo->fi_extents_list, list) {
+		if (copy_to_user(dest, &entry->extent, sizeof(entry->extent))) {
+			err = -EFAULT;
+			break;
+		}
+		dest++;
+		fieinfo->fi_extents_mapped++;
+	}
+	list_for_each_entry_safe(entry, tmp, &fieinfo->fi_extents_list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	return err;
+}
+EXPORT_SYMBOL(fiemap_copy_kernel_extent);
 
 /**
  * fiemap_prep - check validity of requested flags for fiemap
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index e9bdc1ff08c9..1a3e28f71599 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1145,12 +1145,16 @@ int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (err)
 		return err;
 
+	INIT_LIST_HEAD(&fieinfo->fi_extents_list);
+
 	ni_lock(ni);
 
 	err = ni_fiemap(ni, fieinfo, start, len);
 
 	ni_unlock(ni);
 
+	err = fiemap_copy_kernel_extent(fieinfo, err);
+
 	return err;
 }
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index f1df52dfab74..b70f9dfb71ab 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1941,8 +1941,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	}
 
 	if (!attr || !attr->non_res) {
-		err = fiemap_fill_next_extent(
-			fieinfo, 0, 0,
+		err = fiemap_fill_next_kernel_extent(fieinfo, 0, 0,
 			attr ? le32_to_cpu(attr->res.data_size) : 0,
 			FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST |
 				FIEMAP_EXTENT_MERGED);
@@ -2037,8 +2036,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
-						      flags);
+			err = fiemap_fill_next_kernel_extent(fieinfo, vbo, lbo,
+							     dlen, flags);
 			if (err < 0)
 				break;
 			if (err == 1) {
@@ -2058,7 +2057,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_kernel_extent(fieinfo, vbo, lbo, bytes,
+						     flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
index c50882f19235..10cb33ed80a9 100644
--- a/include/linux/fiemap.h
+++ b/include/linux/fiemap.h
@@ -5,17 +5,37 @@
 #include <uapi/linux/fiemap.h>
 #include <linux/fs.h>
 
+struct fiemap_extent_list {
+	struct list_head list;
+	struct fiemap_extent extent;
+};
+
 struct fiemap_extent_info {
 	unsigned int fi_flags;		/* Flags as passed from user */
 	unsigned int fi_extents_mapped;	/* Number of mapped extents */
 	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
 	struct fiemap_extent __user *fi_extents_start; /* Start of
 							fiemap_extent array */
+	struct list_head fi_extents_list; /* List of fiemap_extent_list */
 };
 
 int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 *len, u32 supported_flags);
-int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
-			    u64 phys, u64 len, u32 flags);
+int do_fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
+			       u64 phys, u64 len, u32 flags, bool is_kernel);
+
+static inline int fiemap_fill_next_extent(struct fiemap_extent_info *info,
+					  u64 logical, u64 phys, u64 len, u32 flags)
+{
+	return do_fiemap_fill_next_extent(info, logical, phys, len, flags, false);
+}
+
+static inline int fiemap_fill_next_kernel_extent(struct fiemap_extent_info *info,
+						 u64 logical, u64 phys, u64 len, u32 flags)
+{
+	return do_fiemap_fill_next_extent(info, logical, phys, len, flags, true);
+}
+
+int fiemap_copy_kernel_extent(struct fiemap_extent_info *info, int err);
 
 #endif /* _LINUX_FIEMAP_H 1 */
-- 
2.34.1

