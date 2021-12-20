Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2147A659
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbhLTI5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbhLTI5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:57:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B2C06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:57:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iy13so3249164pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8LWBVAbOYqYnLKDnLn1dN7nJhLJCQoGJHk1oKVhcUk=;
        b=sQhVO4TCsELsn0nsfezX5Aqk1s6UHh4mzHQh2sF44KLQyMdbyVtDOlgUADejRo+j3p
         dImdHMJtSC/LZVj6ATaP/8KwTE449sTHK5xplv57lk/xGyk71fK7w2HHJjBjsNhSWQqi
         nfj9buyGdEBNFWlFaLSk9GU4ktz0NY2sXaZwIPixIogYyv/PL52UMDkSjK9+9YzJ3oQZ
         dsHA72Bvn7YGlfjOVt0IefKZG02/87z0c/e3iBIgsSZVWqlD7l9RCHSOnNkvMNsHN+PI
         xZmRlIHjcuJEo3ThjxNqETC2rZYL0gbdivTRi6sh2T7kbMSkdt1Hy7ZskFtbKTtlc7k0
         ISVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8LWBVAbOYqYnLKDnLn1dN7nJhLJCQoGJHk1oKVhcUk=;
        b=1nyV5dGL/hrYpJhiB+Psx9ImUCXCqy9Ra897jo2oaYl/PnfCb5dmgmCOq5U5KQ+8Ze
         RnWGUtPzwaW9ImCI1C04N2ISkvf07V+94gsVEiTAYvwjUhDpN/18Itx/QLnebFuefNtC
         bvvhYJ/6BOeZy6ek7C4knk/pAvfzo2vqxwHoeD7544bNM/6a1TrR3kgBJ32p13WelFES
         ps/bpUitwuE4ZZ68/lIGskVJr1hET/Y68QEUUpz9fhPPBpAGKbQqFrgpiSJ3eya3Axoo
         KIrIIDg5sc7VuWNu2MqZCWkEOEHMuXXvUV9VJWuJ8iLEXMbVBaMBQYvoGvK9Z8zBW4sO
         k/ww==
X-Gm-Message-State: AOAM530X3d/mqDnLWoPhbwxoCUPEIkHJj0FS5vVhiVwaRDMGU3xawL70
        4ODm488s3NaVhfSCiviNuWdP6g==
X-Google-Smtp-Source: ABdhPJwXrv+zzx+vKXphqlMjgN9s7JnvKikMUlYato1otBtEGQPStoADK9cC3eU+Kwbwkm1fnwH6zw==
X-Received: by 2002:a17:903:22c1:b0:148:c3cc:54c6 with SMTP id y1-20020a17090322c100b00148c3cc54c6mr16231351plg.98.1639990669029;
        Mon, 20 Dec 2021 00:57:49 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:57:48 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 03/16] fs: introduce alloc_inode_sb() to allocate filesystems specific inode
Date:   Mon, 20 Dec 2021 16:56:36 +0800
Message-Id: <20211220085649.8196-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
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
index 6b80a51129d5..dcb1e6cad201 100644
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
index bbf812ce89a8..4592f00ec5e7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/slab.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3178,6 +3179,16 @@ extern void free_inode_nonrcu(struct inode *inode);
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

