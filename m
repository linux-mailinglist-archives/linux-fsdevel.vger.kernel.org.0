Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF921DEB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 19:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgGMR2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbgGMR2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:28:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4888DC061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so18156107eja.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lAw1dZEFjnFeT9loip9ug9GZCnCHV+9F05rbN8HJwXo=;
        b=uzOJKoX8CZ3z6Ueq9TF/Kov5JEogHxmvVnhsDfSkDnY4U+PTy8BJylYKqRBVw7ZF8X
         jT3vuFKia7DopfuXtC9AxtTJAWIUOrAohBVGmYMVX2ZNc/RlE1dyPjz0XykLQI72Jprf
         PV4cmdd2cJWVhj+eWiic0jXLj33/QE+QGLMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lAw1dZEFjnFeT9loip9ug9GZCnCHV+9F05rbN8HJwXo=;
        b=QRVdOPECXZfWQDze4zKqgRYlAYTR78l2Goxk2kgC8wEt74TAYw76012NMTlt11rmHS
         JEbTxH7pJiA6aV0b5qnrW2nsGZahttybWT7KC1jVLfe3ew0ocsuZ8+yY7UyxO3E31a9t
         MqDmc+CekmMbQYR40Mgqv6+RtlCw3JBw/mzQiGbPj3YETYKIkpvnHQKfzKW0OhuJO9vs
         sfMmW5FaF0qWVqN+/TUezU8oW9j9Xf7ieBsirUzyzE7SFjkssf+g49b5psDfMcAuOjBc
         g1G9AXs+LzM25nF3+fp+rB1TeNR6M8Pb9O2nQu+iBcdtNMzPUHLrUmHpsqN6yXSXYIdZ
         i2bg==
X-Gm-Message-State: AOAM532UaAODtYP2H9oxiotTytYLOS8WjY4Nq4OlTq4nMM3DzN+l38wk
        x9Fg2U9Q7TXCwG3RksGXijl60w==
X-Google-Smtp-Source: ABdhPJyFfdljDqwF/Jf9HT1imvTpTzxHomhkSeYf3CTCe74uewyvJiqsXwkbIn1F12F+2DUPKbecpQ==
X-Received: by 2002:a17:906:8542:: with SMTP id h2mr703721ejy.517.1594661295897;
        Mon, 13 Jul 2020 10:28:15 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id w8sm10329473ejb.10.2020.07.13.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:28:15 -0700 (PDT)
Date:   Mon, 13 Jul 2020 18:28:15 +0100
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
Subject: [PATCH v7 1/2] tmpfs: Per-superblock i_ino support
Message-ID: <1986b9d63b986f08ec07a4aa4b2275e718e47d8a.1594661218.git.chris@chrisdown.name>
References: <cover.1594661218.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594661218.git.chris@chrisdown.name>
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
index a0dbe62f8042..0ae250b4da28 100644
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
+#define SHMEM_INO_BATCH 1024
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
+		if (unlikely(ino % SHMEM_INO_BATCH == 0)) {
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

