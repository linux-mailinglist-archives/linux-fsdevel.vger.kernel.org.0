Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5321DB65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgGMQPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbgGMQPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:15:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F0C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:15:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so17894329ejx.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbBWDCi7iz22DChOpfvPVlTPsSL/v1a9f9Ou3ZgRVK4=;
        b=wSlaXhF727aJ3I+5O4LFn/wV3RcfXQ6KE4bLoLPfILl0rUVJZHHt5r/eBBIWpzjpMQ
         pE4Q/MDpw3QLRgLWR5wPgP1jHlIKsb13EDqf7A+lJmHCZbWn4+jF6xm6ru860qHEQ3sO
         rLV4cJCUGHnQWY19PSOfvHvxkpVjcay1tV8zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbBWDCi7iz22DChOpfvPVlTPsSL/v1a9f9Ou3ZgRVK4=;
        b=Y+571NYjS16hpnKHi5wkDFEVUlVZGh/auX6sHyLxNrdF5BVxYKWVpjSkniF4fEnLqs
         3TsVpgzCyq3LRYPJUvnCMXNqjdU8LdtAp1g6LFy0SIzBaV5TTijPAW5NgoW/WkOaRpWO
         cJiFDpfZjiAbNJRJx2UxgG65j8ldzlgRfhaH26irIuELCsKBEvZNRFW47CZaWYV0JCIR
         8aDQPhHDmM5tuBXmvIdg/IgNntzbM3921jimeDrhukkOfzLA8rNZAA2Ay1FZnjkWhEcX
         ik5AhrjUWRw9Bs8OxqeEjRC8thlyGIIzfyAJLSbZxbZoOECIGGRylZvMNFNKYh7AlU8M
         Ec/w==
X-Gm-Message-State: AOAM533beB5wQyjFk5h/aR7idTv+W/t4plzVV46URwm8qZJAG99Y+WlB
        IqqYhd1vRVfakoDk2XvBo9w4DA==
X-Google-Smtp-Source: ABdhPJzQoLp4NPhWotMCQGTlaEt7jA7VN6tuNrxZCyLMqSblR3lKyapVm87EMlO1TGOJ6nYeLRD+wQ==
X-Received: by 2002:a17:906:1250:: with SMTP id u16mr421090eja.299.1594656940600;
        Mon, 13 Jul 2020 09:15:40 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id h10sm11567871edz.31.2020.07.13.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:15:40 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:15:39 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 1/2] tmpfs: Per-superblock i_ino support
Message-ID: <2cddd4498ba1db1c7a3831d47b9db0d063746a3b.1594656618.git.chris@chrisdown.name>
References: <cover.1594656618.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594656618.git.chris@chrisdown.name>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

get_next_ino has a number of problems:

- It uses and returns a uint, which is susceptible to become overflowed
  if a lot of volatile inodes that use get_next_ino are created.
- It's global, with no specificity per-sb or even per-filesystem. This
  means it's not that difficult to cause inode number wraparounds on a
  single device, which can result in having multiple distinct inodes
  with the same inode number.

This patch adds a per-superblock counter that mitigates the second case.
This design also allows us to later have a specific i_ino size
per-device, for example, allowing users to choose whether to use 32- or
64-bit inodes for each tmpfs mount. This is implemented in the next
commit.

For internal shmem mounts which may be less tolerant to spinlock delays,
we implement a percpu batching scheme which only takes the stat_lock at
each batch boundary.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 include/linux/fs.h       | 15 +++++++++
 include/linux/shmem_fs.h |  2 ++
 mm/shmem.c               | 66 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f15848899945..b70b334f8e16 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2961,6 +2961,21 @@ extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
 
+/*
+ * Userspace may rely on the the inode number being non-zero. For example, glibc
+ * simply ignores files with zero i_ino in unlink() and other places.
+ *
+ * As an additional complication, if userspace was compiled with
+ * _FILE_OFFSET_BITS=32 on a 64-bit kernel we'll only end up reading out the
+ * lower 32 bits, so we need to check that those aren't zero explicitly. With
+ * _FILE_OFFSET_BITS=64, this may cause some harmless false-negatives, but
+ * better safe than sorry.
+ */
+static inline bool is_zero_ino(ino_t ino)
+{
+	return (u32)ino == 0;
+}
+
 extern void __iget(struct inode * inode);
 extern void iget_failed(struct inode *);
 extern void clear_inode(struct inode *);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 7a35a6901221..eb628696ec66 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -36,6 +36,8 @@ struct shmem_sb_info {
 	unsigned char huge;	    /* Whether to try for hugepages */
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
+	ino_t next_ino;		    /* The next per-sb inode number to use */
+	ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
diff --git a/mm/shmem.c b/mm/shmem.c
index a0dbe62f8042..f70ab1623081 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -260,18 +260,67 @@ bool vma_is_shmem(struct vm_area_struct *vma)
 static LIST_HEAD(shmem_swaplist);
 static DEFINE_MUTEX(shmem_swaplist_mutex);
 
-static int shmem_reserve_inode(struct super_block *sb)
+/*
+ * shmem_reserve_inode() performs bookkeeping to reserve a shmem inode, and
+ * produces a novel ino for the newly allocated inode.
+ *
+ * It may also be called when making a hard link to permit the space needed by
+ * each dentry. However, in that case, no new inode number is needed since that
+ * internally draws from another pool of inode numbers (currently global
+ * get_next_ino()). This case is indicated by passing NULL as inop.
+ */
+#define SHMEM_INO_BATCH 1024U
+static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
-	if (sbinfo->max_inodes) {
+	ino_t ino;
+
+	if (!(sb->s_flags & SB_KERNMOUNT)) {
 		spin_lock(&sbinfo->stat_lock);
 		if (!sbinfo->free_inodes) {
 			spin_unlock(&sbinfo->stat_lock);
 			return -ENOSPC;
 		}
 		sbinfo->free_inodes--;
+		if (inop) {
+			ino = sbinfo->next_ino++;
+			if (unlikely(is_zero_ino(ino)))
+				ino = sbinfo->next_ino++;
+			if (unlikely(ino > UINT_MAX)) {
+				/*
+				 * Emulate get_next_ino uint wraparound for
+				 * compatibility
+				 */
+				ino = 1;
+			}
+			*inop = ino;
+		}
 		spin_unlock(&sbinfo->stat_lock);
+	} else if (inop) {
+		/*
+		 * __shmem_file_setup, one of our callers, is lock-free: it
+		 * doesn't hold stat_lock in shmem_reserve_inode since
+		 * max_inodes is always 0, and is called from potentially
+		 * unknown contexts. As such, use a per-cpu batched allocator
+		 * which doesn't require the per-sb stat_lock unless we are at
+		 * the batch boundary.
+		 */
+		ino_t *next_ino;
+		next_ino = per_cpu_ptr(sbinfo->ino_batch, get_cpu());
+		ino = *next_ino;
+		if (unlikely((ino & ~SHMEM_INO_BATCH) == 0)) {
+			spin_lock(&sbinfo->stat_lock);
+			ino = sbinfo->next_ino;
+			sbinfo->next_ino += SHMEM_INO_BATCH;
+			spin_unlock(&sbinfo->stat_lock);
+			if (unlikely(is_zero_ino(ino)))
+				ino++;
+		}
+		*inop = ino;
+		*next_ino = ++ino;
+		put_cpu();
 	}
+
 	return 0;
 }
 
@@ -2222,13 +2271,14 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	struct inode *inode;
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	ino_t ino;
 
-	if (shmem_reserve_inode(sb))
+	if (shmem_reserve_inode(sb, &ino))
 		return NULL;
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = ino;
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -2932,7 +2982,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	 * first link must skip that, to get the accounting right.
 	 */
 	if (inode->i_nlink) {
-		ret = shmem_reserve_inode(inode->i_sb);
+		ret = shmem_reserve_inode(inode->i_sb, NULL);
 		if (ret)
 			goto out;
 	}
@@ -3584,6 +3634,7 @@ static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
 	kfree(sbinfo);
@@ -3626,6 +3677,11 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
+	if (sb->s_flags & SB_KERNMOUNT) {
+		sbinfo->ino_batch = alloc_percpu(ino_t);
+		if (!sbinfo->ino_batch)
+			goto failed;
+	}
 	sbinfo->uid = ctx->uid;
 	sbinfo->gid = ctx->gid;
 	sbinfo->mode = ctx->mode;
-- 
2.27.0

