Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC51307D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 13:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAEMGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 07:06:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41856 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgAEMGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 07:06:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so46613915wrw.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2020 04:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PyXhwAP0dYhaGmqpZ7PAPREHaom0BNi3zqsng9yVMcQ=;
        b=d5rTJdZZQpgUNSTm+xzjt/ISjZG8hkHvPnXc0PLs9c3qT7xcatTLfIveeIFwRr3Ogu
         gwu08CadMR/UGVLZV0bKzQOjZfXOa7OmNbboL927Ip01LCce95NMQQjLLvoiTLzzdP9Q
         lMCs0wvsHVdDWnO+0uoDCDzd7uxvSWB1viKlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PyXhwAP0dYhaGmqpZ7PAPREHaom0BNi3zqsng9yVMcQ=;
        b=sVOllSfAqF7VdeseUkqud2FVtxpU87fRcz9wzq4m8WMnl/JBpi1kIySJd6gxlda5nh
         G/0A8hYqWt9o7/suSJhBcBSIAdqOZFqM3pYIwqYikoGAEG6dzFm/v1/iCrovgtbau3lZ
         urspfp6yjjrzVgervgnxZ4+XtGCFuCfC6MitRuHUi9gA3fB2kxmLf2eFy+lzZ8nxLriA
         vLwA8n313+Q7BKU7neThCU9WdDXLaDwYjPbSHaTwPRQ+VbsW0w2blb67jwpablGjOv9G
         HkrhiDVqmaDZ08xKQXOIHlwk584+88cV8pJWT6Jnpr+iS3tFISlk95tXT/lrS36YWmO0
         Wr4Q==
X-Gm-Message-State: APjAAAUWCR5An9vlNOZa84TjMuaq9w5w5L2MawEbzko4toFpKlNrnF7N
        nhsNzxgd4nDAB1FQ1bzkQR4wvA==
X-Google-Smtp-Source: APXvYqzrEecwDHa5ggF6zIdBC628KNozDxyAb/8JE3Vsn+XnRMY5j95WuqlqI6zv3fAH/k0ig6fL7Q==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr94773037wro.352.1578225961144;
        Sun, 05 Jan 2020 04:06:01 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:e1d7])
        by smtp.gmail.com with ESMTPSA id w19sm18753045wmc.22.2020.01.05.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 04:06:00 -0800 (PST)
Date:   Sun, 5 Jan 2020 12:06:00 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name>
References: <cover.1578225806.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578225806.git.chris@chrisdown.name>
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

Signed-off-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

v5: Nothing in code, just resending with correct linux-mm domain.

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index de8e4b71e3ba..7fac91f490dc 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -35,6 +35,7 @@ struct shmem_sb_info {
 	unsigned char huge;	    /* Whether to try for hugepages */
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
+	ino_t next_ino;		    /* The next per-sb inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
diff --git a/mm/shmem.c b/mm/shmem.c
index 8793e8cc1a48..9e97ba972225 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2236,6 +2236,12 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * shmem_get_inode - reserve, allocate, and initialise a new inode
+ *
+ * If this tmpfs is from kern_mount we use get_next_ino, which is global, since
+ * inum churn there is low and this avoids taking locks.
+ */
 static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
 				     umode_t mode, dev_t dev, unsigned long flags)
 {
@@ -2248,7 +2254,28 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		if (sb->s_flags & SB_KERNMOUNT) {
+			/*
+			 * __shmem_file_setup, one of our callers, is lock-free:
+			 * it doesn't hold stat_lock in shmem_reserve_inode
+			 * since max_inodes is always 0, and is called from
+			 * potentially unknown contexts. As such, use the global
+			 * allocator which doesn't require the per-sb stat_lock.
+			 */
+			inode->i_ino = get_next_ino();
+		} else {
+			spin_lock(&sbinfo->stat_lock);
+			if (unlikely(sbinfo->next_ino > UINT_MAX)) {
+				/*
+				 * Emulate get_next_ino uint wraparound for
+				 * compatibility
+				 */
+				sbinfo->next_ino = 1;
+			}
+			inode->i_ino = sbinfo->next_ino++;
+			spin_unlock(&sbinfo->stat_lock);
+		}
+
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -3662,6 +3689,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
+	sbinfo->next_ino = 1;
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
 	sbinfo->uid = ctx->uid;
-- 
2.24.1

