Return-Path: <linux-fsdevel+bounces-10199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2368E848A7E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AE11F246BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546E8BF9;
	Sun,  4 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TtcHfJzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADB6FD1;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=LF6kvzr60KqxMrcQE+PygXnMIIca83KnwyLeG5wlfOLMqrdgJ12KwJuV4inSW6E9tpky9x/4PWqruZF2fEEjqsScCa7RkjpZcT0tsKNDS2LGIP/+b4ebfCljYCj+5yw1o89+KFNbSPjxeCwqrelXdUlmRBLsd5OGuxzWbcU6msw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=1rtYk8nQaR6Z1oX3dIJL6BYRNYvWov9U8Si234YvJHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZECjwoPZ4FdUv4C/yBe8H524OzCiriAUaTHhndKA9hpl4kHDao9I4LW/gWG5FFU7ZKuzfWUKWJ5+8OYV0TqNkzPRTgJM/B96AcL/n89rvNAwsZ2SJn6EUvGkUYJcJJbbdkHvvPiYxPFNkA6tga0w+myaNmUDSx+o3mhc7m08JGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TtcHfJzG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=txbefR1bImZynMySniqB43HTfyckqDaK6LKKZ+70ogY=; b=TtcHfJzGmY3hgu42vlk+4hxcrn
	aGH28IkeY0tk962KTYy2Vtmq5rrH3ZClMikX9dt8cn7iMPHvyYDMYuXkvBQotov6cELYdKdqBO+E+
	Yen++U2pB6iPd8HbYiTl5zAYfb8hq669w7GcE01+aWKUOt3SjKnNa/MX/7rV+DTbrUtxduPKPckyy
	FyiOpRK40a3l+Q4sJRMYwO+o1+YL1K8x4Fa/gy6py3TTjHc5ctEoutuxSOkUNciQxpA1ProNsNSaL
	L4cV3zTg+tODNaIUdLWEk1D2UQgT+UQMEBJnLHbSHX23dlkMJ1LxW4wCLMw6qc1zQDuD6owQcEIMN
	x+jhbwEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4i-004rCx-1g;
	Sun, 04 Feb 2024 02:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 04/13] exfat: move freeing sbi, upcase table and dropping nls into rcu-delayed helper
Date: Sun,  4 Feb 2024 02:17:30 +0000
Message-Id: <20240204021739.1157830-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

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
index 9474cd50da6d..361595433480 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -275,6 +275,7 @@ struct exfat_sb_info {
 
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
index d9d4fa91010b..fcb658267765 100644
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
@@ -600,7 +597,7 @@ static int __exfat_fill_super(struct super_block *sb)
 	ret = exfat_load_bitmap(sb);
 	if (ret) {
 		exfat_err(sb, "failed to load alloc-bitmap");
-		goto free_upcase_table;
+		goto free_bh;
 	}
 
 	ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
@@ -613,8 +610,6 @@ static int __exfat_fill_super(struct super_block *sb)
 
 free_alloc_bitmap:
 	exfat_free_bitmap(sbi);
-free_upcase_table:
-	exfat_free_upcase_table(sbi);
 free_bh:
 	brelse(sbi->boot_bh);
 	return ret;
@@ -701,12 +696,10 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = NULL;
 
 free_table:
-	exfat_free_upcase_table(sbi);
 	exfat_free_bitmap(sbi);
 	brelse(sbi->boot_bh);
 
 check_nls_io:
-	unload_nls(sbi->nls_io);
 	return err;
 }
 
@@ -771,13 +764,22 @@ static int exfat_init_fs_context(struct fs_context *fc)
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


