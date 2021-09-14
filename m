Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4340A78F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbhINHfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbhINHfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:35:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5108C0613E2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v123so11326085pfb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XM8lTqwIC/t1cHsDphwpH5utYAkV5aMz9gOR8B5mwoQ=;
        b=uJWPoBJVzhjkadfGiWbAPJGCfqjtJnVl2tkbT7o5apxB0OtiGGSR6nsvigPaV+nfTF
         BtoROtsUfMMvB/F2ffqKth8a7dGZanTz0d1UhErkhnnrCuOGCnsfyNp0rAp6VeMypF2k
         Rrd33YEdK9ZJvl54CkUpwRDOtzr43ofl+vbQ5yBnpEyEZV8d7LjA+SA1hICBNds7IMu6
         sRQc6XrwtbYrQ46+wEqy84B8ZTEyXIBw1os8LJ5Dw7JG+UaUabwV7j258OKi+KyBcLX8
         DD0sEihMjZb0fn2zExvp38ZJJyhcC8YzYN/lu5mUHfinJq2cqP80FHYNaFQzoCX6DLxL
         K8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XM8lTqwIC/t1cHsDphwpH5utYAkV5aMz9gOR8B5mwoQ=;
        b=wO/xzmZVbrcujDFQyJCEbCC8mRgqJ+frPfKGgxX0sWjgdUkeezlwgsGrvlIRyq5HbT
         0/ejURXM2oOa05RHeS7PkJcMTFF7V8bGSP3LE5h7NJhvenzb47U4HyKnV40FxHg7VWxf
         cnzIisMnHJ5ozMDiDjl7PivW1fYCUyYYdoUL66ytNYHasgAykTG48402p2IDwrau1cEG
         hFP1rlJfyYwmo2qjTmga3JIq/fp/vVhVp+xsm1U682g835feKDW7Hfp0NrN/9lnAO8EK
         NGlM0v7cY4XFEEyNLU/AQwCiLub2BGpVlhczAWvDMrxhtdiXeEaPCUiTzZmcJBQSLUHJ
         XQ6Q==
X-Gm-Message-State: AOAM532qXIbzkakurAxjbFuqymGkqYZ2BVOVIPx6FiNcO/kWBOMiIfRB
        sW7hqY+/qER2fZQWNsrfQMeE1A==
X-Google-Smtp-Source: ABdhPJx4jDMCj3y+I06HB83GUQxuXdp7OYPPhRZx43pPnnq1Q0vnwOEKSObZyNzprSCEdhoVGGZdxQ==
X-Received: by 2002:a63:7454:: with SMTP id e20mr14233508pgn.136.1631604837380;
        Tue, 14 Sep 2021 00:33:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:57 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 09/76] fs: introduce alloc_inode_sb() to allocate filesystems specific inode
Date:   Tue, 14 Sep 2021 15:28:31 +0800
Message-Id: <20210914072938.6440-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The allocated inode cache is supposed to be added to its memcg list_lru
which should be allocated as well in advance. That can be done by
kmem_cache_alloc_lru() which allocates object and list_lru. The file
systems is main user of it. So introduce alloc_inode_sb() to allocate
file system specific inodes and set up the inode reclaim context
properly. The file system is supposed to use alloc_inode_sb() to
allocate inodes. In the later patches, we will convert all users to the
new API.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/filesystems/porting.rst |  5 +++++
 fs/inode.c                            |  2 +-
 include/linux/fs.h                    | 11 +++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index bf19fd6b86e7..c9c157d7b7bb 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -45,6 +45,11 @@ typically between calling iget_locked() and unlocking the inode.
 
 At some point that will become mandatory.
 
+**mandatory**
+
+The foo_inode_info should always be allocated through alloc_inode_sb() rather
+than kmem_cache_alloc() or kmalloc() related.
+
 ---
 
 **mandatory**
diff --git a/fs/inode.c b/fs/inode.c
index cb41f02d8ced..43d06b42f908 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -234,7 +234,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 	if (ops->alloc_inode)
 		inode = ops->alloc_inode(sb);
 	else
-		inode = kmem_cache_alloc(inode_cachep, GFP_KERNEL);
+		inode = alloc_inode_sb(sb, inode_cachep, GFP_KERNEL);
 
 	if (!inode)
 		return NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bec3781d260f..c03d8b3fa70c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/slab.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3173,6 +3174,16 @@ extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
 
+/*
+ * This must be used for allocating filesystems specific inodes to set
+ * up the inode reclaim context correctly.
+ */
+static inline void *
+alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
+{
+	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
+}
+
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
 {
-- 
2.11.0

