Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9723212AD4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZPsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 10:48:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42221 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfLZPsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 10:48:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so23886493wro.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RnNpSJkpTTHSSXdkTIGiG3GQdw5OOuvH5LxHNOHSFDE=;
        b=nF6ehLf/8fpuGvCYw5OHcTzrw6jh6/6C1d1DqyOLAGH/CcYOO75zG/mXseEbe4M1s/
         uV18piB0OPWBEnrE34ie6FqcWtAzYTsEAMQKs2R40oxGwKc9+WTwAdieNPk3OrPqKZ+9
         C79sGBv/p7xL2ydPW4XkE418onpuayegsATbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RnNpSJkpTTHSSXdkTIGiG3GQdw5OOuvH5LxHNOHSFDE=;
        b=uZHRgM4VrD1HAGfJp8bdMWiBN4bHgpMA4vpcQojy4ygzBI/7zKk+HCeEe0+WMGnNUg
         rT2d2w5ajB2eTi/02bHkjgyg2HE8YJ792PjQChGEG+Dm20qFwxJsBdM6wh17o39FpLwn
         OU9gdC252XLks8i1ksss38nuLcAnONo9Js+nmhKWVLW/FPDNhnBHSLqlK8TxMUKvkzS+
         /DJorVyg4NfnFVu8K0ZOL4IE4FubgO4YO40h+RAuIGTPFbKHAm9vO86jFbNlpUOb6frJ
         vKYQSQfywUQ2F7zrojHnxCck0FtUha7OfD1xhEfV3/avI3+ADOYBvvgFasGOa4zRroIw
         ttTA==
X-Gm-Message-State: APjAAAWif5WC4tbYXuRDCAe/NiRCEP5kVCabdbU12AEsY7O9cKM8hzS2
        h+12CVu4WWIIxVN7am10cjWXW1e7Bis=
X-Google-Smtp-Source: APXvYqxax5pv0cdrKt5vjhvwkgZltrnMbblRDmKCCwq0V8Ei4uVvGhMNkwDXjKwyqGioCgtc7AsqSw==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr47061397wrm.345.1577375290394;
        Thu, 26 Dec 2019 07:48:10 -0800 (PST)
Received: from localhost ([85.255.234.78])
        by smtp.gmail.com with ESMTPSA id z21sm8800006wml.5.2019.12.26.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 07:48:09 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:48:08 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, "zhengbin (A)" <zhengbin13@huawei.com>
Subject: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
Message-ID: <20191226154808.GA418948@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In Facebook production we are seeing heavy i_ino wraparounds on tmpfs.
On affected tiers, in excess of 10% of hosts show multiple files with
different content and the same inode number, with some servers even
having as many as 150 duplicated inode numbers with differing file
content.

This causes actual, tangible problems in production. For example, we
have complaints from those working on remote caches that their
application is reporting cache corruptions because it uses (device,
inodenum) to establish the identity of a particular cache object, but
because it's not unique any more, the application refuses to continue
and reports cache corruption. Even worse, sometimes applications may not
even detect the corruption but may continue anyway, causing phantom and
hard to debug behaviour.

In general, userspace applications expect that (device, inodenum) should
be enough to be uniquely point to one inode, which seems fair enough.
One might also need to check the generation, but in this case:

1. That's not currently exposed to userspace
   (ioctl(...FS_IOC_GETVERSION...) returns ENOTTY);
2. Even with generation, there shouldn't be two live inodes with the
   same inode number on one device.

In order to fix this, we reuse inode numbers from recycled slabs where
possible, allowing us to significantly reduce the risk of 32 bit
wraparound.

There are probably some other potential users of this, like some FUSE
internals, and {proc,sys,kern}fs style APIs, but doing a general opt-out
codemod requires some thinking depending on the particular callsites and
how far up the stack they are, we might end up recycling an i_ino value
that actually does have some semantic meaning. As such, to start with
this patch only opts in a few get_next_ino-heavy filesystems, and those
which looked straightforward and without likelihood for corner cases:

- bpffs
- configfs
- debugfs
- efivarfs
- hugetlbfs
- ramfs
- tmpfs

Another alternative considered was to change get_next_ino to use and
return ino_t with internal use of 64-bit atomics, but this has a couple
of setbacks that might make it not possible to use in all scenarios:

1. This may break some 32-bit userspace applications on a 64-bit kernel
   which cannot handle a 64-bit ino_t, see the comment above
   get_next_ino;
2. Some applications inside the kernel already make use of the ino_t
   high bits. For example, overlayfs' xino feature uses these to merge
   inode numbers and fsid indexes to form a new identifier.

One limitation to this approach is that slab recycling is currently only
per-memcg. This means workloads which heavily exercise get_next_ino with
the same memcg are most likely to benefit, rather than those with a wide
range of cgroups thrashing it. Depending on the workload, I've seen from
10%-50% recycle rate, which seems like a reasonable win with no
significant increase in code complexity.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reported-by: Phyllipe Medeiros <phyllipe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 fs/configfs/inode.c  |  2 +-
 fs/debugfs/inode.c   |  2 +-
 fs/efivarfs/inode.c  |  2 +-
 fs/hugetlbfs/inode.c |  4 ++--
 fs/inode.c           | 31 +++++++++++++++++++++++++++++++
 fs/ramfs/inode.c     |  2 +-
 include/linux/fs.h   |  2 ++
 kernel/bpf/inode.c   |  2 +-
 mm/shmem.c           |  2 +-
 9 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index fd0b5dd68f9e..c0157f9b3e33 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -114,7 +114,7 @@ struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
 {
 	struct inode * inode = new_inode(s);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 		inode->i_mapping->a_ops = &configfs_aops;
 		inode->i_op = &configfs_inode_operations;
 
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index bda942afc644..64af16104661 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -66,7 +66,7 @@ static struct inode *debugfs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 		inode->i_atime = inode->i_mtime =
 			inode->i_ctime = current_time(inode);
 	}
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 96c0c86f3fff..ba2f3c6a4042 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -19,7 +19,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 	struct inode *inode = new_inode(sb);
 
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 		inode->i_mode = mode;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_flags = is_removable ? 0 : S_IMMUTABLE;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d5c2a3158610..a867035b6460 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -732,7 +732,7 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 		inode->i_mode = S_IFDIR | ctx->mode;
 		inode->i_uid = ctx->uid;
 		inode->i_gid = ctx->gid;
@@ -775,7 +775,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 	if (inode) {
 		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
-		inode->i_ino = get_next_ino();
+		inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 		inode_init_owner(inode, dir, mode);
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
diff --git a/fs/inode.c b/fs/inode.c
index aff2b5831168..0df68367587b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
+#include <linux/random.h>
 #include <linux/hash.h>
 #include <linux/swap.h>
 #include <linux/security.h>
@@ -880,6 +881,11 @@ static struct inode *find_inode_fast(struct super_block *sb,
 #define LAST_INO_BATCH 1024
 static DEFINE_PER_CPU(unsigned int, last_ino);
 
+/*
+ * As get_next_ino returns a type with a small width (typically 32 bits),
+ * consider calling recycle_or_get_next_ino instead if your callsite may be able
+ * to reuse a recycled inode's i_ino to reduce the risk of inode wraparound.
+ */
 unsigned int get_next_ino(void)
 {
 	unsigned int *p = &get_cpu_var(last_ino);
@@ -904,6 +910,31 @@ unsigned int get_next_ino(void)
 }
 EXPORT_SYMBOL(get_next_ino);
 
+/*
+ * get_next_ino() returns an unsigned int, which can wrap around on workloads
+ * havily making use of it.
+ *
+ * To reduce the risks, callsites can instead use recycle_or_get_next_ino to
+ * only get a new inode number when the slab wasn't recycled. old_ino should be
+ * i_ino from the (potentially) recycled slab.
+ */
+unsigned int recycle_or_get_next_ino(ino_t old_ino)
+{
+	/*
+	 * get_next_ino returns unsigned int. If this fires then i_ino must be
+	 * >32 bits and have been changed later, so the caller shouldn't be
+	 * recycling inode numbers
+	 */
+	WARN_ONCE(old_ino > UINT_MAX,
+		  "Recyclable i_ino not from get_next_ino: %llu", (u64)old_ino);
+
+	if (old_ino)
+		return old_ino;
+	else
+		return get_next_ino();
+}
+EXPORT_SYMBOL(recycle_or_get_next_ino);
+
 /**
  *	new_inode_pseudo 	- obtain an inode
  *	@sb: superblock
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 35624ca2a2f9..e517202dd607 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -66,7 +66,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 	struct inode * inode = new_inode(sb);
 
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 		inode_init_owner(inode, dir, mode);
 		inode->i_mapping->a_ops = &ramfs_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 190c45039359..d90be3ab5fc4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3053,6 +3053,8 @@ static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
 extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
+extern unsigned int recycle_or_get_next_ino(ino_t old_ino);
+
 extern void evict_inodes(struct super_block *sb);
 
 extern void __iget(struct inode * inode);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index ecf42bec38c0..a459a7da74d5 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -97,7 +97,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ENOSPC);
 
-	inode->i_ino = get_next_ino();
+	inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 	inode->i_atime = current_time(inode);
 	inode->i_mtime = inode->i_atime;
 	inode->i_ctime = inode->i_atime;
diff --git a/mm/shmem.c b/mm/shmem.c
index 165fa6332993..8c358d2c24d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2247,7 +2247,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = recycle_or_get_next_ino(inode->i_ino);
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
-- 
2.24.1

