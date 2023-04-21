Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2958F6EB3D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjDUVoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjDUVoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19BC1BC3;
        Fri, 21 Apr 2023 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nny3k9GHvISmRebv/wiZT4olnvrgRU1LTkzNA8FqTDM=; b=4Ut9M+mnDbLVzS5mn357NtXNVg
        iW973AulcqLzyWup7ygr0muRVGEjzVtqC6kqytGxva5A/sIYSQFeBlshjjpIhF6OYCvi05IojwxWE
        tsKCO6qUCenqfN9MsAZAdEWGPc3v0HjGDax4M6XvZmaBXtzA5v2C3KaFqloimB+8x6u/npTruKLQs
        036sfUHB5iNErVxwNzS974BCSyU1Ar0fEOvtLbwggh51AghvUuMZYxAGZfc5IZ52Xmohp9mLGlsCy
        TaULQnEPNlB7MAFVSLGTPIcEwbgWNxO2AlGc26ENLqMM/u81jGPh5M591B/wApNppCBuEnfc313kb
        pACYjTwA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btoo-2A;
        Fri, 21 Apr 2023 21:44:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC 4/8] shmem: add helpers to get block size
Date:   Fri, 21 Apr 2023 14:43:56 -0700
Message-Id: <20230421214400.2836131-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421214400.2836131-1-mcgrof@kernel.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stuff the block size as a struct shmem_sb_info member when CONFIG_TMPFS
is enabled, but keep the current static value for now, and use helpers
to get the blocksize. This will make the subsequent change easier to read.

The static value for block size of PAGE_SIZE is used currently.

The struct super_block s_blocksize_bits represents the blocksize in
power of two, since the block size is always PAGE_SIZE this is PAGE_SHIFT
today, but to help make this a bit more apt to scale we can use __ffs()
for it instead.

This commit introduces no functional changes other than __ffs() for the
s_blocksize_bits and extending the struct shmem_sb_info with the blocksize.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/shmem_fs.h |  3 +++
 mm/shmem.c               | 24 +++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9029abd29b1c..89e471fcde1d 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -36,6 +36,9 @@ struct shmem_inode_info {
 #define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
 
 struct shmem_sb_info {
+#ifdef CONFIG_TMPFS
+	u64 blocksize;
+#endif
 	unsigned long max_blocks;   /* How many blocks are allowed */
 	struct percpu_counter used_blocks;  /* How many are allocated */
 	unsigned long max_inodes;   /* How many inodes are allowed */
diff --git a/mm/shmem.c b/mm/shmem.c
index d76e86ff356e..162384b58a5c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -125,7 +125,17 @@ struct shmem_options {
 #define SHMEM_SEEN_NOSWAP 16
 };
 
+static u64 shmem_default_bsize(void)
+{
+	return PAGE_SIZE;
+}
+
 #ifdef CONFIG_TMPFS
+static u64 shmem_sb_blocksize(struct shmem_sb_info *sbinfo)
+{
+	return sbinfo->blocksize;
+}
+
 static unsigned long shmem_default_max_blocks(void)
 {
 	return totalram_pages() / 2;
@@ -137,6 +147,12 @@ static unsigned long shmem_default_max_inodes(void)
 
 	return min(nr_pages - totalhigh_pages(), nr_pages / 2);
 }
+#else
+static u64 shmem_sb_blocksize(struct shmem_sb_info *sbinfo)
+{
+	return shmem_default_bsize();
+}
+
 #endif
 
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
@@ -3190,7 +3206,7 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
 
 	buf->f_type = TMPFS_MAGIC;
-	buf->f_bsize = PAGE_SIZE;
+	buf->f_bsize = shmem_sb_blocksize(sbinfo);
 	buf->f_namelen = NAME_MAX;
 	if (sbinfo->max_blocks) {
 		buf->f_blocks = sbinfo->max_blocks;
@@ -4100,6 +4116,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
+	sbinfo->blocksize = shmem_default_bsize();
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
@@ -4125,8 +4142,9 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	INIT_LIST_HEAD(&sbinfo->shrinklist);
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
-	sb->s_blocksize = PAGE_SIZE;
-	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_blocksize = shmem_sb_blocksize(sbinfo);
+	sb->s_blocksize_bits = __ffs(sb->s_blocksize);
+	WARN_ON_ONCE(sb->s_blocksize_bits != PAGE_SHIFT);
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	sb->s_time_gran = 1;
-- 
2.39.2

