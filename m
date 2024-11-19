Return-Path: <linux-fsdevel+bounces-35174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D969D2068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 07:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5687B1F22521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C113B7B3;
	Tue, 19 Nov 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qBbjajtL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99B17FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998793; cv=none; b=EGqTCO1yjIVdUXIzxIUz74IS9HxGmxlZm9CMLjM897cJNNVFaRJfINjdM/uC0zzkOf6JnjWlXjatGrpaQUZQ3Dp1VgJCycdVjGhsCHYbdUYBHce/2rS8qOmiuDSwY7qUMjBtYfIcNELeeCErjst4BucomTsUaxwI3k48IQVf0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998793; c=relaxed/simple;
	bh=ys/hZUOOKtbz7S4u4Tyy0Rxv9Udd9Wi0QYS869BxjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2VSGkbP2AXN9GqkIsCVZkNnTHxNei+tK2E7tUbAKBFQyn930prwV3Z+mnrSsM8DBpTcj8ynt9YA7CqXH4F62fqrEL/Ji36vSYEh2BgRZkZaqyhIzP3pO+kRm302NVVUCzcdoObBLuDe1k2NGhstfnDu27oBmPpEVfNIx1lN27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qBbjajtL; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:df8e:0:640:17d3:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id E0EDD60AFE;
	Tue, 19 Nov 2024 09:46:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KkKE7YnOrGk0-TvD7Tar7;
	Tue, 19 Nov 2024 09:46:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731998781; bh=MY49H5tl2my7uKCTDXg3I4UKxQHbPZ7VGZxHJNFqPHw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=qBbjajtLksroh4RFwDJHgnOpzgKYxeSQNHZAU/u4BPpNvPB5fmSxMCN0E9X0OzoY2
	 nQlHd9StYnoJpVCyV04nguepzVZEnNLzR2QnMbRvsNmhJLA+7zMjA52EdZHmm165gG
	 Givc2Sp34xjpZobNeIK2DjQEqSrLcTqYw/RhZm60=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com
Subject: [PATCH] jfs: add extra superblock validation
Date: Tue, 19 Nov 2024 09:46:18 +0300
Message-ID: <20241119064618.150005-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following crash:

ERROR: (device loop0): txBegin: read-only filesystem
ERROR: (device loop0): remounting filesystem as read-only
ERROR: (device loop0): dbFindCtl: Corrupt dmapctl page
jfs_create: dtInsert returned -EIO
ERROR: (device (efault)): txAbort:
Oops: general protection fault, probably for non-canonical address <...>
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
...
Call Trace:
 <TASK>
 ? die_addr.cold+0x8/0xd
 ? exc_general_protection+0x147/0x240
 ? asm_exc_general_protection+0x26/0x30
 ? vprintk+0x86/0xa0
 ? jfs_error+0x10a/0x2a0
 ? dtInsert+0x72f/0xb10
 ? __pfx_jfs_error+0x10/0x10
 ? vprintk+0x86/0xa0
 ? _printk+0xd0/0x108
 ? __pfx__printk+0x10/0x10
 ? txAbort+0x332/0x540
 txAbort+0x382/0x540
 jfs_create+0x48e/0xb00
 ? __pfx_jfs_create+0x10/0x10
 ? generic_permission+0x230/0x690
 ? bpf_lsm_inode_permission+0x9/0x10
 ? security_inode_permission+0xbf/0x250
 ? inode_permission+0xba/0x5d0
 vfs_create+0x4e6/0x7a0
 do_mknodat+0x2f7/0x5d0
 ? __pfx_do_mknodat+0x10/0x10
 ? getname_flags.part.0+0x1c5/0x550
 __x64_sys_mknod+0x118/0x170
 do_syscall_64+0xc7/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
...
 </TASK>

This happens during the mid-air condition when superblock is artificially
damaged before remount issued after superblock touch via 'fspick()' and
'fsconfig()'. So add basic superblock validation in 'readSuper()' and
do not go further if 'updateSuper()' returns non-zero error code.

Reported-by: syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5f0d7af0e45fae10edd1
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/jfs/jfs_mount.c  | 28 +++++++++++++++++-----------
 fs/jfs/jfs_umount.c | 22 ++++++++++++----------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 98f9a432c336..c0a51defc5b7 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -303,12 +303,6 @@ static int chkSuper(struct super_block *sb)
 	/*
 	 * validate superblock
 	 */
-	/* validate fs signature */
-	if (strncmp(j_sb->s_magic, JFS_MAGIC, 4) ||
-	    le32_to_cpu(j_sb->s_version) > JFS_VERSION) {
-		rc = -EINVAL;
-		goto out;
-	}
 
 	bsize = le32_to_cpu(j_sb->s_bsize);
 	if (bsize != PSIZE) {
@@ -449,6 +443,18 @@ int updateSuper(struct super_block *sb, uint state)
 	return 0;
 }
 
+static int validateSuper(struct buffer_head *bh)
+{
+	struct jfs_superblock *j_sb;
+
+	if (!bh)
+		return -EIO;
+
+	j_sb = (struct jfs_superblock *)bh->b_data;
+
+	return (strncmp(j_sb->s_magic, JFS_MAGIC, 4) == 0 &&
+		le32_to_cpu(j_sb->s_version) <= JFS_VERSION) ? 0 : -EINVAL;
+}
 
 /*
  *	readSuper()
@@ -457,17 +463,17 @@ int updateSuper(struct super_block *sb, uint state)
  */
 int readSuper(struct super_block *sb, struct buffer_head **bpp)
 {
-	/* read in primary superblock */
+	/* read in and validate primary superblock */
 	*bpp = sb_bread(sb, SUPER1_OFF >> sb->s_blocksize_bits);
-	if (*bpp)
+	if (!validateSuper(*bpp))
 		return 0;
 
-	/* read in secondary/replicated superblock */
+	/* read in and validate secondary/replicated superblock */
 	*bpp = sb_bread(sb, SUPER2_OFF >> sb->s_blocksize_bits);
-	if (*bpp)
+	if (!validateSuper(*bpp))
 		return 0;
 
-	return -EIO;
+	return -EINVAL;
 }
 
 
diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 8ec43f53f686..5f01f767bc0a 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -104,14 +104,15 @@ int jfs_umount(struct super_block *sb)
 	 * list (to signify skip logredo()).
 	 */
 	if (log) {		/* log = NULL if read-only mount */
-		updateSuper(sb, FM_CLEAN);
-
-		/*
-		 * close log:
-		 *
-		 * remove file system from log active file system list.
-		 */
-		rc = lmLogClose(sb);
+		rc = updateSuper(sb, FM_CLEAN);
+		if (!rc) {
+			/*
+			 * close log:
+			 *
+			 * remove file system from log active file system list.
+			 */
+			rc = lmLogClose(sb);
+		}
 	}
 	jfs_info("UnMount JFS Complete: rc = %d", rc);
 	return rc;
@@ -122,6 +123,7 @@ int jfs_umount_rw(struct super_block *sb)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	struct jfs_log *log = sbi->log;
+	int rc;
 
 	if (!log)
 		return 0;
@@ -147,7 +149,7 @@ int jfs_umount_rw(struct super_block *sb)
 	 */
 	filemap_write_and_wait(sbi->direct_inode->i_mapping);
 
-	updateSuper(sb, FM_CLEAN);
+	rc = updateSuper(sb, FM_CLEAN);
 
-	return lmLogClose(sb);
+	return rc ? rc : lmLogClose(sb);
 }
-- 
2.47.0


