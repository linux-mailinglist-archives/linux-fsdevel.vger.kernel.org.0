Return-Path: <linux-fsdevel+bounces-77313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOlnJe5kk2lX4QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:41:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CF147083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08E5030095D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70D2E973A;
	Mon, 16 Feb 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="BHh2+VlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7D2E88A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267268; cv=none; b=HOKcwYxlyiNGaRdz95YcKOCKmBjdH7azoyXmYzzFpiGLXfToeUONsogCJz2xusSC3/smBnYut4kHHEOwwgZzrULtp3kBQcSW5KqF5ttfz21F75L6aFTAq1fwuhq5BQY0dw1lQqzAZF6JKeezEfdHR0EOIFYIKmL3dX4+PB6lnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267268; c=relaxed/simple;
	bh=QbUr32o1qNknh8OKNJHyEYG9tcZZ7RE7ciOmZfVnlj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggFg7cCtGV5w5OO34qlpf5Fo23OvTHH0wyWfusK7YjXbV39mTWoX+ELpon6C7u+ojEwLTVttwK/Vak7V56n4fGRh9Uufhy7qSWxUBR/Bjg8S72UApMD/YNg8x1XkQqOq11DFAYJtcJDgikHe0asAcFrRDnwoDvctgwkNbTsbVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=BHh2+VlU; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb39f64348so297416085a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771267266; x=1771872066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X54B7Vf+BK11FAXu0x08XDmOK83/BHoweBSyAzhyJlc=;
        b=BHh2+VlU7LIj8WzOSttaOPQquED8qKmy+wrgVVjv/YAcGVXEsVsyDwQs8utltrHqB8
         K8r0241xH1s819GdeWRR/tHzn1HNQcWKAdC7JOiY+CkQlL6bRw4Ah4oLOvo5jS3K0ARX
         BaoMQ7l/NBL2mDj15tnv7D2jTlL8LIP51ynIS0h37PmvwZven9gt/vpIHztm+uB1XbDv
         S2O3yGshcJwK23itDuaRyQaul0+iU44oJZ8QXqSyfFwzPzmUYsS8c7XRQbV3CUkPyEQk
         HFYDAifT4XNb69N/Hu5LnmEmc1z7UP1SmQXtLd3/7BHHELeJH9b3aWfizwS+/uIbnTaQ
         mcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267266; x=1771872066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X54B7Vf+BK11FAXu0x08XDmOK83/BHoweBSyAzhyJlc=;
        b=XhRCPpQlcUeKJMQGCs/9biYBDmx5pgwMO4OgmwAhAdCqieoxgqUcTyMBu89F/L5tZG
         GSt4td6iu+jN1vywB9LxYwvSjXhpim5necyaSDD557DaUAgs+mFl4jUHMWwQ8TyKQWwB
         kBjzCCawXNVtqcrMSZfAyFIyazaxrtTGgpqfdB7bVapzNaMdQiiPiSckobvM+UxXaiUo
         U3pN2wy7x7QMaK+Mby2uLD6ODD98CIh1Or45gA26ETUJSg/GWsva14wWpjsCsb+5qSIT
         9XyVYrhu9On987GwiXIW2PlykUxNqGBGfCCqzCAmVqkCiLP0ZPJJya6t+2hf2/5wQwaW
         r6lA==
X-Gm-Message-State: AOJu0YxEyuJk4M+BnblystF27M7edoDaqWbm1Glw3decaE62ZuC9UaCr
	wc5kqHyPl6HaGCJcjuL2WFaILQTzkcpNiZZef4HGUlSw1/1NKVmlPnAZ9t8eDp6lgD4=
X-Gm-Gg: AZuq6aIsTe5lpxdlRehy4oxk5Hkalr53tmL2p9+kI805sQ2Nz4jYsIz9yZFd1gDJDlG
	Mlvkf9PkEj/fcXnoituF/DyiCNpQjzgAyL7cWrBAkivvmJPeGk4s8tznQa0jmkkWq/fVzRJWfY+
	xXZBDy3PZqnwdYl2jievvc3blqW0H6SJ8NJa1p4Q1nW7P89lM57y0PMmAO639qVS5qCjRKHwBdz
	AvN+QRcYg6dlK1u8gVBCY1pK5Eu7WijsIt2k5f343gjOfg7z++oLNNl/dmEdH4lW8t3n6I9OVvF
	oPoxLYBrwrX7DdyyHcTC86hTYE1m+lp1lTZDrEGLt59hSNAinO7djLlbWnNVwUkyLfnGgJPcGkw
	218XC//wNamqgHIXuAyLKoFe9YsuwAAJ1IeUtDd4JeviOM5FO2Qa4xHGfZ6TLr3Y99uqOF8rmbr
	O2JqlqOEcvv4UVG8ek0OC7bcSozt1i5XoW4zNZl/lU8tyTWFAVDDCGXVkRZ+RaTP1um8zQeTjXc
	V3P
X-Received: by 2002:a05:620a:298c:b0:8cb:4f63:dac9 with SMTP id af79cd13be357-8cb4f63e093mr908068885a.17.1771267265778;
        Mon, 16 Feb 2026 10:41:05 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cca7299sm157766676d6.22.2026.02.16.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:41:05 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 1/2] befs: Add FS_IOC_GETFSLABEL ioctl
Date: Mon, 16 Feb 2026 13:38:58 -0500
Message-ID: <20260216183859.38269-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216183859.38269-1-ethan.ferguson@zetier.com>
References: <20260216183859.38269-1-ethan.ferguson@zetier.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77313-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zetier.com:mid,zetier.com:dkim,zetier.com:email]
X-Rspamd-Queue-Id: B43CF147083
X-Rspamd-Action: no action

Add the FS_IOC_GETFSLABEL ioctl to the befs filesystem.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/befs/befs.h     |  1 +
 fs/befs/linuxvfs.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/befs/super.c    |  1 +
 3 files changed, 49 insertions(+)

diff --git a/fs/befs/befs.h b/fs/befs/befs.h
index 7cd47245694d..e4e2e9f4e307 100644
--- a/fs/befs/befs.h
+++ b/fs/befs/befs.h
@@ -30,6 +30,7 @@ struct befs_mount_options {
 };
 
 struct befs_sb_info {
+	char name[B_OS_NAME_LENGTH];
 	u32 magic1;
 	u32 block_size;
 	u32 block_shift;
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index d7c5d9270387..942d247a6cae 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -25,6 +25,7 @@
 #include <linux/exportfs.h>
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
+#include <linux/compat.h>
 
 #include "befs.h"
 #include "btree.h"
@@ -64,6 +65,15 @@ static struct dentry *befs_fh_to_parent(struct super_block *sb,
 				struct fid *fid, int fh_len, int fh_type);
 static struct dentry *befs_get_parent(struct dentry *child);
 static void befs_free_fc(struct fs_context *fc);
+static int befs_ioctl_get_volume_label(struct super_block *sb,
+				       char __user *arg);
+static long befs_generic_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg);
+#ifdef CONFIG_COMPAT
+static long befs_generic_compat_ioctl(struct file *filp, unsigned int cmd,
+				      unsigned long arg);
+#endif
+
 
 static const struct super_operations befs_sops = {
 	.alloc_inode	= befs_alloc_inode,	/* allocate a new inode */
@@ -81,6 +91,10 @@ static const struct file_operations befs_dir_operations = {
 	.iterate_shared	= befs_readdir,
 	.llseek		= generic_file_llseek,
 	.setlease	= generic_setlease,
+	.unlocked_ioctl	= befs_generic_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= befs_generic_compat_ioctl,
+#endif
 };
 
 static const struct inode_operations befs_dir_inode_operations = {
@@ -940,6 +954,39 @@ befs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static int befs_ioctl_get_volume_label(struct super_block *sb, char __user *arg)
+{
+	struct befs_sb_info *sbi = BEFS_SB(sb);
+
+	if (copy_to_user(arg, sbi->name, B_OS_NAME_LENGTH))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long befs_generic_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	char __user *user = (char __user *)arg;
+
+	switch (cmd) {
+	case FS_IOC_GETFSLABEL:
+		return befs_ioctl_get_volume_label(inode->i_sb, user);
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static long befs_generic_compat_ioctl(struct file *filp, unsigned int cmd,
+				      unsigned long arg)
+
+{
+	return befs_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int befs_get_tree(struct fs_context *fc)
 {
 	return get_tree_bdev(fc, befs_fill_super);
diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c99d8..e6a13b497ac1 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -28,6 +28,7 @@ befs_load_sb(struct super_block *sb, befs_super_block *disk_sb)
 	else if (disk_sb->fs_byte_order == BEFS_BYTEORDER_NATIVE_BE)
 		befs_sb->byte_order = BEFS_BYTESEX_BE;
 
+	memcpy(befs_sb->name, disk_sb->name, B_OS_NAME_LENGTH);
 	befs_sb->magic1 = fs32_to_cpu(sb, disk_sb->magic1);
 	befs_sb->magic2 = fs32_to_cpu(sb, disk_sb->magic2);
 	befs_sb->magic3 = fs32_to_cpu(sb, disk_sb->magic3);
-- 
2.43.0


