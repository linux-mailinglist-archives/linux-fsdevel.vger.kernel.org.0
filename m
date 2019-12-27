Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C95312B535
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfL0OaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 09:30:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32784 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfL0OaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:30:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so26267342wrq.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 06:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=92kFRinn3sFpXfl+bsy2nrK1wJHcAh8dVpkxmGnzW/Q=;
        b=rP6MAgrdJlh5kAFpo7eWj/OwBIKnCOlfto2IQOmo/TYnyGjMMtc28adxD6V/xeai7t
         DvzfQ73PJGw4Vbm9RagpwfymPhHoLYi/dWhKuVctjZV1EMwhvv01Qr/ndYeL7Ibtxn9c
         1oK7+DLvivZCI1iGH8jJietGOS7FXCcWtG/m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92kFRinn3sFpXfl+bsy2nrK1wJHcAh8dVpkxmGnzW/Q=;
        b=LBXJ9UUNoUgLY6GPbHq5I+d6H8IzCSaGIkJp8uQhRruI3dPRe4aeTxYXiCQmv9F2IH
         TzSGpMJEYGzqz7MmhDUgvzr02q/cWw16Rab9CF2wzWPTop8MwWzhQmoptdwdftHDljd6
         nR0dZCyjwmDUqLkgMKymKJTLekK0DaNIf5kNmxN4+7nnk63ySNfwImHeZgk6BtIgfcYC
         lIfhi5tVLNmg4jsEmHonqTBTJw8Y3iqdVxGiiQuaH/HKFdaYRaieaNLbelvqfphjYW0C
         pLfCH/zGXneQVxrgOVaeYqwRKyyZj5iGqfLtHlxEWeMoHF2EU26vJIMZyHBTkEKDUsh0
         Mh8g==
X-Gm-Message-State: APjAAAWhNUzpC9I4hV83OuMrScOJqx9MjnIPC2Rt5MsTZz6AUrQMxujm
        lR8353p1k6ibqsrFkz4xqlBCMB53FR4=
X-Google-Smtp-Source: APXvYqzuBe8OfwsNyFeXOf+mE2O8Bd32sbZop18tvUK4hfn2PuR+GHG+Q/vgXwfVfwBivdAcLEHF6A==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr49339527wrs.42.1577457020474;
        Fri, 27 Dec 2019 06:30:20 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id v17sm34673092wrt.91.2019.12.27.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 06:30:20 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:30:19 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/3] fs: inode: Recycle volatile inode numbers from private
 slabs
Message-ID: <d12c4c3935d16fa2b4dd1aff9013ba6ccc4dce8e.1577456898.git.chris@chrisdown.name>
References: <cover.1577456898.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577456898.git.chris@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One limitation to this approach is that slab recycling is currently only
per-memcg. This means workloads which heavily exercise get_next_ino with
the same memcg are most likely to benefit, rather than those with a wide
range of cgroups thrashing it. Depending on the workload, I've seen from
10%-50% recycle rate, which seems like a reasonable win with no
significant increase in code complexity, although it of course doesn't
fix the problem entirely.

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
 fs/hugetlbfs/inode.c | 4 +++-
 fs/inode.c           | 5 +++++
 mm/shmem.c           | 4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d5c2a3158610..7b8fc84299c8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -732,7 +732,9 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		/* Recycle to avoid 32-bit wraparound where possible */
+		if (!inode->i_ino)
+			inode->i_ino = get_next_ino();
 		inode->i_mode = S_IFDIR | ctx->mode;
 		inode->i_uid = ctx->uid;
 		inode->i_gid = ctx->gid;
diff --git a/fs/inode.c b/fs/inode.c
index aff2b5831168..255a4ae81b65 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -880,6 +880,11 @@ static struct inode *find_inode_fast(struct super_block *sb,
 #define LAST_INO_BATCH 1024
 static DEFINE_PER_CPU(unsigned int, last_ino);
 
+/*
+ * As get_next_ino returns a type with a small width (typically 32 bits),
+ * consider reusing inode numbers in your filesystem if you have a private inode
+ * cache in order to reduce the risk of wraparound.
+ */
 unsigned int get_next_ino(void)
 {
 	unsigned int *p = &get_cpu_var(last_ino);
diff --git a/mm/shmem.c b/mm/shmem.c
index 165fa6332993..ff041cb15550 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2247,7 +2247,9 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		/* Recycle to avoid 32-bit wraparound where possible */
+		if (!inode->i_ino)
+			inode->i_ino = get_next_ino();
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
-- 
2.24.1

