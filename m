Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A5512FB9F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgACRa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:30:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgACRa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:30:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so43112373wre.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fxnatTiT58n8PHtK059X+60VI+LNzauBx16wAQrxk4=;
        b=lN4geLySZnlZACUVv/sHPOZ3AKiFB0hreULAn+xaHD4OTV69oEEsRIMl3h6jwE/DL5
         NL6wGcjPjbzIesA0V+Ck7YPSCEOEG8DmnSOBzO5CkMThramFsgdZhxTlxGrzQf8pezWK
         LiaBXXAwWBabwt8Xozqq+0pYvHVq0+Vu24OA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fxnatTiT58n8PHtK059X+60VI+LNzauBx16wAQrxk4=;
        b=K4b5KiS+/6Zwzo6mRVdr8Ywu3o2Xz4P0cuBT6Q4KCrGIFoeuhUHTEH6I+mtT5l83cF
         k4P+rXplzbAswwTxGxINduoTCAncbxbLuBQ7WPSybJYa+2XXfXt+I+H3BuqPnkr9AiwL
         IEj9N2vqXQT2mhmMQ9XA+m6fRzVfIA6Lu5WetkkEANgtQ1Ot8ztPXC1hxF9F+MaELjny
         Eyx19Cb3yKE1MCandNUkZSvJ/tOefBr+fhYd3n4yWSVL7RmVYvhsxC2FKWmmbc3jDihS
         ACeFEF00FKmZySADHJ1D+ZR2SsbuMcHwD+tqwYUTVYHxyJZ7sFvZKH6kK/x/lem3PH7j
         +7PA==
X-Gm-Message-State: APjAAAVO1pAaZVjp5logEgwt4V60aXic9URw4hPFmCJ2mtQIOnAGYS/K
        y1jeKQrY8F/QzlUTwyWKKaZBVCDEJnoMbg==
X-Google-Smtp-Source: APXvYqzbWoOSpY6jnp2YPg/CwIwSoeC4dJKMQ3P1P/S50D1z5qtzZNbtDnn0Nj82cONo4nv+A2Fz1w==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr88781633wru.40.1578072625871;
        Fri, 03 Jan 2020 09:30:25 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:5238])
        by smtp.gmail.com with ESMTPSA id h17sm64072300wrs.18.2020.01.03.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 09:30:25 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:30:24 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <19ff8eddfe9cbafc87e55949189704f31d123172.1578072481.git.chris@chrisdown.name>
References: <cover.1578072481.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578072481.git.chris@chrisdown.name>
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
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

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
index 8793e8cc1a48..638b1e30625f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2236,6 +2236,15 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * shmem_get_inode - reserve, allocate, and initialise a new inode
+ *
+ * If SB_KERNMOUNT, we use the per-sb inode allocator to avoid wraparound.
+ * Otherwise, we use get_next_ino, which is global.
+ *
+ * If max_inodes is greater than 0 (ie. non-SB_KERNMOUNT), we may have to grab
+ * the per-sb stat_lock.
+ */
 static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
 				     umode_t mode, dev_t dev, unsigned long flags)
 {
@@ -2248,7 +2257,28 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 
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
@@ -3662,6 +3692,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
+	sbinfo->next_ino = 1;
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
 	sbinfo->uid = ctx->uid;
-- 
2.24.1

