Return-Path: <linux-fsdevel+bounces-77062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MImKIABfjmm1BwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:15:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37F131AF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD73A30BE984
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FCF3385AA;
	Thu, 12 Feb 2026 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="DJ849dH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91E32C31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938079; cv=none; b=lYIeGva2qlqpbTlavoTxiqD49UvADbGRMox+Z5YdMQ73J89dD3U04zzZ0yvgU3/B7spFtpLz6YZqMOLiLFOkNO6JXyPYTYWsm7vm09z3bBavE6p5mXE2anCLr31LGetXAOxllPVaSEMFRHg7mJ1zcNKOUtk8C0amOyz+NQ8t6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938079; c=relaxed/simple;
	bh=VujJSdmEoJTD6/CjhEXhw86+rrs42e4hcgzHdZkbE2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVsle0f8MgVwFUk2ANQlqqUICp2lzH5Xmk/77e3B5wUHgZubBWWKUztoS5pxZA4P8d0Q3gg1IKwMkTv5+R6CVgwF+8MftvNPIbsQ5x/C+X8U+RdiyTbLZITS0XjK/4AoRwdRv+N5+XI/iCkbWp/SR1NSOxrbl2kFbsY7/divcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=DJ849dH0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c710439535so31897585a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 15:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1770938077; x=1771542877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYlTsqk5WbL68NN7FM9m06GUejc3cnUvw44ceTTX69A=;
        b=DJ849dH0xLOhq5hd4MSjo8wV9wObxVW5iPzCs5obHuEx7kvwwFnbVftqD7ayTTRQjK
         fqJN5WkAZOUWCm14eH8HBKPIfRhz/22RteGTLT1PKwFKc1QlHwb1Rkevyldm/gHmA3YM
         RZbupc2FZVI4Z7CWnIVgspN7PlV+6DtrhS49ws+AlO21SG40QaiQ5AHsEulOWHdkyEbX
         moUCN7NqmefOqofI+iboaPsS6Fq1zviv5g+8Kl7UQWf9KEh6vzJXMmqKIPrSOrnvWa+X
         FHZ4CHsI9udtj2EiBBW9FhxVxwneH74Q7F6+7dYkWMiqi5IoiiRRVG/uu3VwVCOLmH49
         d8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770938077; x=1771542877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYlTsqk5WbL68NN7FM9m06GUejc3cnUvw44ceTTX69A=;
        b=piL2mpRtAQ2rJ12X5Y9ppBFlvVlVyIFjevDosmnb4AQae0rfy2xx5x3gMGIh+wZNPT
         skaWNxGzeKVucL9aDkW0Z0qyMTk+gsH7ud/U2N8YHqSFlRB9VG3OMyTjJlhzGLrPPXpX
         O0ehyEjJVDpoLZmuGQy3tx2fXL28VZdtdHTjmwOS/3X1BQr7hZmGQZxzzmC6pCB+ZAWs
         8aiTz3BY1wzpCTf4HnREenOgdsDEyjmRotZJuivf7EOBYpfAoVlQyoz2idzUtKgHWMah
         NSxAs/s09ByxtzDhPsqnmLsDCjZG8rbvRc7d2ijzRNbK2Fk97oHNd5z+ZQnyxjJzmy7f
         xCLg==
X-Gm-Message-State: AOJu0YyTRcQ+iymmRGmneYdb3nHDGR3s22qAHdnsFI4pt0D6bT0FQVi3
	0L85QQ1BCn4ydsw3o59pTeti82Ji88kgx7LlYKcripL9iHSBZzi1fhtQ3zMPpL9Snpk=
X-Gm-Gg: AZuq6aIaoLnkv0bvSknp9ryXUOyZ370VOm1r0rI20CjS2uFrsXnIs2qOtV6YNe2pDmT
	IiSbPswsY4g+VRe2sxcOx84YUE87jJneqyxiZUnQYBervfYKbfTC5yDIdqOmFYYhlPU62SJSgP9
	b6gDD4q97wmzzz65RitgNWTe6R00xdwz0cGjRCQgvainvCoUpFGgvvgAwOaiFU9Ea23wcZwnewV
	VFsQfqu2t+sYzwuBNUrK3uH9zCWyPWeHnUq4nyYx6tOifKx0MbxjyFsnigxdZ8ryEbQDVBmBqEh
	tcKl1F+M+Kb7Eqgi2yKBfjwP1hLTAwxfDaydtB5ZcrivU0NRQh0rtbNoW1vjSfwAWqNM+dr94Eg
	AkgysXRQJVsDIiLlV59YpRGjymeqAPbPvXmWiVrBKdtuZdIXULxso22YnDqnDhJUgj8y4oqlI2P
	GqKGo4QffYCRR4hsjK6qzldD9sPZIPXlRyMJvcw/4bb/UD25l+WnP8ESAIdu7BIYogdSsqc4uaA
	vY=
X-Received: by 2002:a05:620a:450f:b0:8c5:1fd2:e9ef with SMTP id af79cd13be357-8cb408693cfmr75424285a.28.1770938077327;
        Thu, 12 Feb 2026 15:14:37 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c8505sm441165385a.25.2026.02.12.15.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 15:14:36 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 1/2] befs: Add FS_IOC_GETFSLABEL ioctl
Date: Thu, 12 Feb 2026 18:13:38 -0500
Message-ID: <20260212231339.644714-2-ethan.ferguson@zetier.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77062-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 0F37F131AF6
X-Rspamd-Action: no action

Add the FS_IOC_GETFSLABEL ioctl to the befs filesystem.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/befs/befs.h     |  1 +
 fs/befs/linuxvfs.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/befs/super.c    |  1 +
 3 files changed, 48 insertions(+)

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
index d7c5d9270387..4850295e5fe0 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -64,6 +64,15 @@ static struct dentry *befs_fh_to_parent(struct super_block *sb,
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
@@ -81,6 +90,10 @@ static const struct file_operations befs_dir_operations = {
 	.iterate_shared	= befs_readdir,
 	.llseek		= generic_file_llseek,
 	.setlease	= generic_setlease,
+	.unlocked_ioctl	= befs_generic_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= befs_generic_compat_ioctl,
+#endif
 };
 
 static const struct inode_operations befs_dir_inode_operations = {
@@ -940,6 +953,39 @@ befs_statfs(struct dentry *dentry, struct kstatfs *buf)
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


