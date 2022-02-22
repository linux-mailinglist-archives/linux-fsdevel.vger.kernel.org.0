Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5614C0255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiBVTtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891EBA75A
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8NFgJPLOUrsRT5xlYRd3p1NyZk0l2XBlf3tW6EEd0Vk=; b=RMaNv+VK4vTfkmP6iBfQOdXgOb
        FtOMOGruGq4hedb90QycTT5swiT6J8vz//0+/wq4rnZpZ+LkvUbH/jrzQk8gRfF+lDtd3Q5PM3mdE
        cq5enQeP47KdLijPxicZYB3ZYFxofhWZVXbGxAYh/wuW5vkz7P0yXkBXmWHZeHTiUuhBTLvSfJiyV
        kvpdq4+hassEzVOYkf6SCfmKcAaJtG/nohJWJGDJ3TQHnjJC1qCVImdDRQHO8QJ68YAFdScaXGZNu
        Zkdt12tAF+gJ3f1ls+IGLgoSZdrsnn2OltOpK4Cul6MmNlhMwJLXwzcCiOmLG6RDH1WtOQ3CXcEuG
        V1qR2t9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb96-00360j-WA; Tue, 22 Feb 2022 19:48:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/22] fs: Remove aop flags parameter from cont_write_begin()
Date:   Tue, 22 Feb 2022 19:48:15 +0000
Message-Id: <20220222194820.737755-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no more aop flags left, so remove the parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/adfs/inode.c             | 2 +-
 fs/affs/file.c              | 2 +-
 fs/buffer.c                 | 2 +-
 fs/exfat/inode.c            | 2 +-
 fs/fat/inode.c              | 2 +-
 fs/hfs/inode.c              | 2 +-
 fs/hfsplus/inode.c          | 2 +-
 fs/hpfs/file.c              | 2 +-
 include/linux/buffer_head.h | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 561bc748c04a..b6912496bb19 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -58,7 +58,7 @@ static int adfs_write_begin(struct file *file, struct address_space *mapping,
 	int ret;
 
 	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, flags, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
 				adfs_get_block,
 				&ADFS_I(mapping->host)->mmu_private);
 	if (unlikely(ret))
diff --git a/fs/affs/file.c b/fs/affs/file.c
index b3f81d84ff4c..704911d6aeba 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -420,7 +420,7 @@ static int affs_write_begin(struct file *file, struct address_space *mapping,
 	int ret;
 
 	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, flags, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
 				affs_get_block,
 				&AFFS_I(mapping->host)->mmu_private);
 	if (unlikely(ret))
diff --git a/fs/buffer.c b/fs/buffer.c
index b5b83e5159bf..115a1184a0bf 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2441,7 +2441,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
  * We may have to extend the file.
  */
 int cont_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata,
 			get_block_t *get_block, loff_t *bytes)
 {
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index fc0ea1684880..8ed3c4b700cd 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -395,7 +395,7 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
 	int ret;
 
 	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, flags, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
 			       exfat_get_block,
 			       &EXFAT_I(mapping->host)->i_size_ondisk);
 
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 86957dd07bda..3d76e535e709 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -232,7 +232,7 @@ static int fat_write_begin(struct file *file, struct address_space *mapping,
 	int err;
 
 	*pagep = NULL;
-	err = cont_write_begin(file, mapping, pos, len, flags,
+	err = cont_write_begin(file, mapping, pos, len,
 				pagep, fsdata, fat_get_block,
 				&MSDOS_I(mapping->host)->mmu_private);
 	if (err < 0)
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 55f45e9b4930..396735dd3407 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -56,7 +56,7 @@ static int hfs_write_begin(struct file *file, struct address_space *mapping,
 	int ret;
 
 	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, flags, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
 				hfs_get_block,
 				&HFS_I(mapping->host)->phys_size);
 	if (unlikely(ret))
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 446a816aa8e1..435b6202532a 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -50,7 +50,7 @@ static int hfsplus_write_begin(struct file *file, struct address_space *mapping,
 	int ret;
 
 	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, flags, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
 				hfsplus_get_block,
 				&HFSPLUS_I(mapping->host)->phys_size);
 	if (unlikely(ret))
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 99493a23c5d0..8740b4ea0b52 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -200,7 +200,7 @@ static int hpfs_write_begin(struct file *file, struct address_space *mapping,
 	int ret;
 
 	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, flags, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
 				hpfs_get_block,
 				&hpfs_i(mapping->host)->mmu_private);
 	if (unlikely(ret))
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 63e49dfa7738..127b60fad77e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -238,7 +238,7 @@ int generic_write_end(struct file *, struct address_space *,
 void page_zero_new_buffers(struct page *page, unsigned from, unsigned to);
 void clean_page_buffers(struct page *page);
 int cont_write_begin(struct file *, struct address_space *, loff_t,
-			unsigned, unsigned, struct page **, void **,
+			unsigned, struct page **, void **,
 			get_block_t *, loff_t *);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
-- 
2.34.1

