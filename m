Return-Path: <linux-fsdevel+bounces-77063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CLgDiBfjmm1BwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:15:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 912E5131B04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 010653112878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D902F12C5;
	Thu, 12 Feb 2026 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="VJjlENBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA23370FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938081; cv=none; b=Rw+G3/EdVwaa/d73U60diEePQwM9H5t91IhOFBH8DtlwXE0TehqGEpjCxVb4BLsqQ7hXzu19N6j8E2GYTe7JKZhnbqjHnqkWecC/hh34aAyQs8aHMvKtMAq0Mq/4Vl4J4N8G+dTNHeqJeO/vdTXfLGp3554ojA/R+OPsaYkswNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938081; c=relaxed/simple;
	bh=8PzBjb1BC5IXRuE5/L3hohJrpfpYHnZMV57JAQRQuYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXYlwyEtaZshBzfnYZr4nqdIhE0W/w8d7hL8xFln4zzF+cb0oJ9Q9fzFt1z3TcRImH13YGnVVAoSwFZgP5/v88EZGzzJwFKR4dFR9K5NA2l6BADv3kd3Rhe2YpvOV8FKE4+heJVE/AL+tmpd7OK9nnosiw05/zwPiqaC+rQvnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=VJjlENBy; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ca01dc7d40so41802285a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 15:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1770938079; x=1771542879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25FG61RMxEgfldkZ2mHU1yb2uvHGCvudsNE5iAmhPxI=;
        b=VJjlENByO95814WM0MIiXALYOGMla1uaAap0cb6ewbpuj3EhDK6C/SAim7vzBb7s8S
         x7AvOx0ohz660XtPBT4JrLMBKkLyc8Njk3qr+Nmp5F8Q3jy7u4YP6yb2c7YUA6CVCq72
         9XkNmXoqBLxUfKrROwMfGuqZFHC/Kdo4qk6mMFFf56c/ZWvKXRarT0KGQ/2OxDFH4GBa
         layX9Gh2yz3gtp8fDgw5nnhdKTe0YF/x+d6WiEfHU5kEg4FwgSRtotwCrqbRxWnz11gh
         IqWu+swSpc1kWhWulYH5aiu3i1qXBgLvj74VBLgcTJyqzgvs+Tp0sQHDqBkrzzG/6DcI
         spAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770938079; x=1771542879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25FG61RMxEgfldkZ2mHU1yb2uvHGCvudsNE5iAmhPxI=;
        b=v/FciCRRR90EcYVNdR3FnaUEdb+n0WCFgdFPrdunZmxmM04FaQv+wWtVcZP75XN1RJ
         LKcHwMuzjboEpxJi56ujDhTZYPS//Wd5SYFGEOKXxoSWiyFQMQnfz5FrdnzCrec5rkob
         0AOI4nWjKMmu2AMNBg3cOSXKmzGjh7oUYu1KtbDqJDDQwqp3vI3SI7juKODaiuwX9h2I
         Khml9Q/OJAw4C1N/fbW1Y7MBeqinC5xm0oCITLOTU2Tw093b4obk7nNcR1eR6D16CVIZ
         6WSKMlIyCNSyRd90yngrjx02OSlfJyArrjpEvJ5tjVYKLLaQ4peCRjyUQX5qx3gzS3vE
         5q3A==
X-Gm-Message-State: AOJu0YzwAGEBwBFm4N/8yh204CMv+EX7hwbTYBwmIbUwsPKz/VhGkAM2
	nZ4l1WgqRA41VnWUSudl4NkZ3YgdDfLgHXixy0S7+iGlqxhVbzp88jKGRVYQLaE/QPI=
X-Gm-Gg: AZuq6aIgVtuevOJHregF1DuMC/lJAVT/lrDjbVziEuez3enk8kPKpO5bQMCOTOkxeDD
	wS2EAbgolyNNWM5thRqAKOzYXjnaUkM5nZMzXDp+X4THNn72u9PntQFJ10bEc3YV6Q9xMivaMEw
	sBpcwi3Ay5CxQTfwaNsZQ7HRtjEsMCE748WQmGqTx4XNWRLgcykqDwb4FQtcio1i1SW5AdKcYAe
	Ao2YV0gkogN23P1jSn6PhWIiQ/INONoC3HP0Tfr9SjRFTt6PufNQh1jN3zPEnCypsSBaH8yuE+U
	CVuy0Cq5nOFfMFdMF6idTwp6Z865PRwR0uTTz2ruw06cv4mQbJTGJN8Lp68nput1SxWJy9mEema
	z0XSF5QKfbB4Bva3XFb+FrDGlblpjIeGiicjFMNNkFMwNcMx10sal+TMpAYpPkJKzXV5cIfIHQ8
	Q8LA6WZwJu2BbLRZBIOyM/RkFSEPXtPMBW76mqlbFBECn6cGHgB42hIyxr+T4OVOx7T/wSX4a8o
	P8=
X-Received: by 2002:a05:620a:1aa1:b0:8b2:2066:ffd3 with SMTP id af79cd13be357-8cb4091c0cbmr78529485a.81.1770938078773;
        Thu, 12 Feb 2026 15:14:38 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c8505sm441165385a.25.2026.02.12.15.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 15:14:38 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 2/2] befs: Add FS_IOC_SETFSLABEL ioctl
Date: Thu, 12 Feb 2026 18:13:39 -0500
Message-ID: <20260212231339.644714-3-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212231339.644714-1-ethan.ferguson@zetier.com>
References: <20260212231339.644714-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zetier.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77063-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zetier.com:mid,zetier.com:dkim,zetier.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 912E5131B04
X-Rspamd-Action: no action

Add the FS_IOC_SETFSLABEL ioctl to the befs filesystem.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/befs/linuxvfs.c | 64 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 4850295e5fe0..4425ae5b6ed0 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -753,6 +753,23 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static befs_super_block *befs_get_disk_sb(struct super_block *sb,
+					   struct buffer_head *bh)
+{
+	const off_t x86_sb_off = 512;
+	befs_super_block *ret = (befs_super_block *) bh->b_data;
+
+	if ((ret->magic1 == BEFS_SUPER_MAGIC1_LE) ||
+	    (ret->magic1 == BEFS_SUPER_MAGIC1_BE)) {
+		befs_debug(sb, "Using PPC superblock location");
+	} else {
+		befs_debug(sb, "Using x86 superblock location");
+		ret = (befs_super_block *) ((void *) bh->b_data + x86_sb_off);
+	}
+
+	return ret;
+}
+
 /* This function has the responsibiltiy of getting the
  * filesystem ready for unmounting.
  * Basically, we free everything that we allocated in
@@ -761,9 +778,21 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
 static void
 befs_put_super(struct super_block *sb)
 {
-	kfree(BEFS_SB(sb)->mount_opts.iocharset);
-	BEFS_SB(sb)->mount_opts.iocharset = NULL;
-	unload_nls(BEFS_SB(sb)->nls);
+	struct befs_sb_info *befs_sb = BEFS_SB(sb);
+	struct buffer_head *bh = NULL;
+	befs_super_block *disk_sb;
+
+	bh = sb_bread(sb, 0);
+	if (bh) {
+		disk_sb = befs_get_disk_sb(sb, bh);
+		memcpy(disk_sb->name, befs_sb->name, B_OS_NAME_LENGTH);
+		mark_buffer_dirty(bh);
+		brelse(bh);
+	}
+
+	kfree(befs_sb->mount_opts.iocharset);
+	befs_sb->mount_opts.iocharset = NULL;
+	unload_nls(befs_sb->nls);
 	kfree(sb->s_fs_info);
 	sb->s_fs_info = NULL;
 }
@@ -798,7 +827,6 @@ befs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *root;
 	long ret = -EINVAL;
 	const unsigned long sb_block = 0;
-	const off_t x86_sb_off = 512;
 	int blocksize;
 	struct befs_mount_options *parsed_opts = fc->fs_private;
 	int silent = fc->sb_flags & SB_SILENT;
@@ -842,15 +870,7 @@ befs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	/* account for offset of super block on x86 */
-	disk_sb = (befs_super_block *) bh->b_data;
-	if ((disk_sb->magic1 == BEFS_SUPER_MAGIC1_LE) ||
-	    (disk_sb->magic1 == BEFS_SUPER_MAGIC1_BE)) {
-		befs_debug(sb, "Using PPC superblock location");
-	} else {
-		befs_debug(sb, "Using x86 superblock location");
-		disk_sb =
-		    (befs_super_block *) ((void *) bh->b_data + x86_sb_off);
-	}
+	disk_sb = befs_get_disk_sb(sb, bh);
 
 	if ((befs_load_sb(sb, disk_sb) != BEFS_OK) ||
 	    (befs_check_sb(sb) != BEFS_OK))
@@ -963,6 +983,22 @@ static int befs_ioctl_get_volume_label(struct super_block *sb, char __user *arg)
 	return 0;
 }
 
+static int befs_ioctl_set_volume_label(struct super_block *sb, char __user *arg)
+{
+	struct befs_sb_info *sbi = BEFS_SB(sb);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sb_rdonly(sb))
+		return -EROFS;
+
+	if (copy_from_user(sbi->name, arg, B_OS_NAME_LENGTH))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long befs_generic_ioctl(struct file *filp, unsigned int cmd,
 			       unsigned long arg)
 {
@@ -972,6 +1008,8 @@ static long befs_generic_ioctl(struct file *filp, unsigned int cmd,
 	switch (cmd) {
 	case FS_IOC_GETFSLABEL:
 		return befs_ioctl_get_volume_label(inode->i_sb, user);
+	case FS_IOC_SETFSLABEL:
+		return befs_ioctl_set_volume_label(inode->i_sb, user);
 	default:
 		return -ENOTTY;
 	}
-- 
2.43.0


