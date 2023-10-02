Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235797B4AC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjJBCaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:30:20 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932199
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1pGQQGV1uCgaPeHnwp4pkr+zNvPLm/SXzWPox8KGdic=; b=vz5Y5BoxcYxKOhm1Wki+kXmSPZ
        WOp52AyA++wrFPBLbS/EVOlY8UXt96Ett+g9fLvz2Fw9tASUvcFTVy86FYyi2ioagojTMvS5ihsWg
        c0WorlXOGS8lpoYwee91Rkb8hTKTA7p6Esz+07748hLqZ/PGLQrdOQg5SXXF0pAu8BmiIHG6UrzhW
        vExSyTxa+0qOHBFGqhAO6FZMqBdCuTBmsKrx7tjJBh6yK1N/4+QOUkoHE9p6dryXlHWg2UeFhlq5d
        qC61dSqB/O+SCrPwkLL2tG0FyG5srqXbcNE0brAkbb1TnWk03JKNkLrJVEC6+45oBEJt1yghYb00J
        XlPNXA/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8hL-00EDpj-2I;
        Mon, 02 Oct 2023 02:30:15 +0000
Date:   Mon, 2 Oct 2023 03:30:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 02/15] exfat: move freeing sbi, upcase table and dropping nls
 into rcu-delayed helper
Message-ID: <20231002023015.GC3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002022846.GA3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That stuff can be accessed by ->d_hash()/->d_compare(); as it is, we have
a hard-to-hit UAF if rcu pathwalk manages to get into ->d_hash() on a filesystem
that is in process of getting shut down.

Besides, having nls and upcase table cleanup moved from ->put_super() towards
the place where sbi is freed makes for simpler failure exits.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/nls.c      | 14 ++++----------
 fs/exfat/super.c    | 20 +++++++++++---------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f55498e5c23d..22e17b0a66e8 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -273,6 +273,7 @@ struct exfat_sb_info {
 
 	spinlock_t inode_hash_lock;
 	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
+	struct rcu_head rcu;
 };
 
 #define EXFAT_CACHE_VALID	0
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 705710f93e2d..afdf13c34ff5 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -655,7 +655,6 @@ static int exfat_load_upcase_table(struct super_block *sb,
 	unsigned int sect_size = sb->s_blocksize;
 	unsigned int i, index = 0;
 	u32 chksum = 0;
-	int ret;
 	unsigned char skip = false;
 	unsigned short *upcase_table;
 
@@ -673,8 +672,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		if (!bh) {
 			exfat_err(sb, "failed to read sector(0x%llx)",
 				  (unsigned long long)sector);
-			ret = -EIO;
-			goto free_table;
+			return -EIO;
 		}
 		sector++;
 		for (i = 0; i < sect_size && index <= 0xFFFF; i += 2) {
@@ -701,15 +699,12 @@ static int exfat_load_upcase_table(struct super_block *sb,
 
 	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
 		  index, chksum, utbl_checksum);
-	ret = -EINVAL;
-free_table:
-	exfat_free_upcase_table(sbi);
-	return ret;
+	return -EINVAL;
 }
 
 static int exfat_load_default_upcase_table(struct super_block *sb)
 {
-	int i, ret = -EIO;
+	int i;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	unsigned char skip = false;
 	unsigned short uni = 0, *upcase_table;
@@ -740,8 +735,7 @@ static int exfat_load_default_upcase_table(struct super_block *sb)
 		return 0;
 
 	/* FATAL error: default upcase table has error */
-	exfat_free_upcase_table(sbi);
-	return ret;
+	return -EIO;
 }
 
 int exfat_create_upcase_table(struct super_block *sb)
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 2778bd9b631e..593cfff8c6f4 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -39,9 +39,6 @@ static void exfat_put_super(struct super_block *sb)
 	exfat_free_bitmap(sbi);
 	brelse(sbi->boot_bh);
 	mutex_unlock(&sbi->s_lock);
-
-	unload_nls(sbi->nls_io);
-	exfat_free_upcase_table(sbi);
 }
 
 static int exfat_sync_fs(struct super_block *sb, int wait)
@@ -593,7 +590,7 @@ static int __exfat_fill_super(struct super_block *sb)
 	ret = exfat_load_bitmap(sb);
 	if (ret) {
 		exfat_err(sb, "failed to load alloc-bitmap");
-		goto free_upcase_table;
+		goto free_bh;
 	}
 
 	ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
@@ -606,8 +603,6 @@ static int __exfat_fill_super(struct super_block *sb)
 
 free_alloc_bitmap:
 	exfat_free_bitmap(sbi);
-free_upcase_table:
-	exfat_free_upcase_table(sbi);
 free_bh:
 	brelse(sbi->boot_bh);
 	return ret;
@@ -694,12 +689,10 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = NULL;
 
 free_table:
-	exfat_free_upcase_table(sbi);
 	exfat_free_bitmap(sbi);
 	brelse(sbi->boot_bh);
 
 check_nls_io:
-	unload_nls(sbi->nls_io);
 	return err;
 }
 
@@ -764,13 +757,22 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void delayed_free(struct rcu_head *p)
+{
+	struct exfat_sb_info *sbi = container_of(p, struct exfat_sb_info, rcu);
+
+	unload_nls(sbi->nls_io);
+	exfat_free_upcase_table(sbi);
+	exfat_free_sbi(sbi);
+}
+
 static void exfat_kill_sb(struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = sb->s_fs_info;
 
 	kill_block_super(sb);
 	if (sbi)
-		exfat_free_sbi(sbi);
+		call_rcu(&sbi->rcu, delayed_free);
 }
 
 static struct file_system_type exfat_fs_type = {
-- 
2.39.2

