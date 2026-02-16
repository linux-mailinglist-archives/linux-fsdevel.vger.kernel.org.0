Return-Path: <linux-fsdevel+bounces-77314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBjBNPtkk2k44QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:42:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C4147093
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8032130074E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528132EAD09;
	Mon, 16 Feb 2026 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="in73cRoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB792E8B98
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267269; cv=none; b=XgaqzR0dsf0jrWI940nKBjSq3HiaF8TgsDaxELeWQ5WbtIz9gsqtPSA0wPvij1YrraiqvPP8YbmBi2N+0zgv8lYVIu35g4ZgSbOVwINWZ1I2D1i5tz2p3O1IToXOXz+oJ2oi8wrLa6mgPhsnHTZZ6k/RxyUcUaXIXrtDiC9yAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267269; c=relaxed/simple;
	bh=sG+WbVQlxuQia5HjUs8kRut/EDDZgsAt64p2h2iilk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBGue5N1su1P8gV7u8sw+VTHxbP5lDZlHL5KE0qUBEcUYRLveFasjVMN9ZpNualCaVw0tk3DZ3BmFCCUe28sJj552YwBf8X2PGRxmOqcENVqXbaVtN7muACig2WiUZIgZrQhSdvDzF9E6BE+ui+I5AanKuW7304FBM+3mo8kJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=in73cRoo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3fd71badso327633085a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771267267; x=1771872067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTgueUMUNqPPeLpij1IzKLOOR2xA2a9HugYD4yHosO0=;
        b=in73cRoo5Dp56jscGwTCfM2SFEudZvKKGoEFyITKZ8BXn9rIdRZDjZspygVsF4rGZ3
         Xtwks25hTye4W42gEbQlU/VOvGcHa4P+Kb3NzswRwCehe65yQAmkiTYpGHEVeZWah9gR
         i9foY9jphRbeWoSo6Afd9AA0ZIknPVq75xJhrkz4VaJhWg07GbvrHJ54b66ewEBrOydv
         ycLeQclA3YD1w9beCp3tKJH1yI5ZXRDrnzhgjOSF9yicM4kS3gSr5PxpSYtxBYc1Sxnq
         GzJBYXoy+B+iaUNoLqmY5kkPzQMfl0SiMwF4ds9GU+n39dUKipfjllgTRqiNNEo9YNHo
         jujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267267; x=1771872067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTgueUMUNqPPeLpij1IzKLOOR2xA2a9HugYD4yHosO0=;
        b=oxBgyjl0Tu6N86IkB6EO9hs6oXikmHZdIYm3baCuG9p8EPhuynDIAWi5QrVMEgiXpT
         71lOgcPy1Tc/waVX+yM4YYvqLDBboMlwAUaEDGAUyh3tOTGaefJPFY90wcmICL49/0vK
         NcpywaI4TwCe+2i5MPg7BMttWU9h5W2wvA6PALd/OZQpPAIsE7SdZRv3X3/2jkFfgcJm
         /pnv4hyBhzKKS7h1s6q4uYSF0r8HNUE2RDqsc/ZRWkTg55j4IpFYMdKMKVS9/bWG/BAm
         2nD9XtdkNRTGT71PThlYv0PTdA/ePQ8bQjEI/xf0cUZo08i5EsAaaVdES2xo6c1m8B1D
         BfYg==
X-Gm-Message-State: AOJu0YwqlF7yZu3YNY2yhjGeQE6q0Bn84vjO9ij1bEecgm4HIw+YNery
	eQSycyi42cjGIiIhpVAtjYFnK5ODaeUt5oX845Q9flxkW3PVNaOn+e2t8JIl9+J4OEA=
X-Gm-Gg: AZuq6aJwvKPBaDUxhH1xY1LGBaCngqTDghVYAMsPZv628AmxluWpHJJyyHYh1WIx5QE
	9wZ79vTj1DdEoScjeVaa8CWBleZMf7R9QB/mV7DGoXUduMUZCF4MrOlZWzeSUqtTGtszbyESw2/
	3pc87FqnwAbADFIb4j1N+AhiNYe9S9y17LKElr27f9BRAzarHkbnbVMRJ/ieZYcOjQfTnVAbnVg
	bbZSjqUUYyNKjlSXkIZdJ7mpzXzTC9z5pnZf1kUO/NLjdI2F5ved7ZWnRLkafaVbnK/qyCm4CZ5
	03i0Zg3YPFRoa1R4cyDyS0BvLehKMLpvjKtr92JLnjr6er25HGplNA/JqVasuAV/mjc5AGA42Mk
	zM9xlxENki8m+OTPdnDpn8MhROVA+hr6J/Irg5yCx78B8Iu7aKdj1yNbRWHapzlypP9j2NURXnR
	zCfdzbBnXpRGUq59Mh6tSKpF7YVdox1n+n/J9kWaE0VCbPcwtaCKyw0UFekGS9D82ph2DuL9lR4
	hW1i6O42+EIiqk=
X-Received: by 2002:a05:620a:d8c:b0:8c9:f9c2:118e with SMTP id af79cd13be357-8cb4226ca53mr1370063585a.32.1771267266960;
        Mon, 16 Feb 2026 10:41:06 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cca7299sm157766676d6.22.2026.02.16.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:41:06 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 2/2] befs: Add FS_IOC_SETFSLABEL ioctl
Date: Mon, 16 Feb 2026 13:38:59 -0500
Message-ID: <20260216183859.38269-3-ethan.ferguson@zetier.com>
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
	TAGGED_FROM(0.00)[bounces-77314-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 102C4147093
X-Rspamd-Action: no action

Add the FS_IOC_SETFSLABEL ioctl to the befs filesystem.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/befs/linuxvfs.c | 64 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 942d247a6cae..f017ae4577cc 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -754,6 +754,23 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
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
@@ -762,9 +779,21 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
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
@@ -799,7 +828,6 @@ befs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *root;
 	long ret = -EINVAL;
 	const unsigned long sb_block = 0;
-	const off_t x86_sb_off = 512;
 	int blocksize;
 	struct befs_mount_options *parsed_opts = fc->fs_private;
 	int silent = fc->sb_flags & SB_SILENT;
@@ -843,15 +871,7 @@ befs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -964,6 +984,22 @@ static int befs_ioctl_get_volume_label(struct super_block *sb, char __user *arg)
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
@@ -973,6 +1009,8 @@ static long befs_generic_ioctl(struct file *filp, unsigned int cmd,
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


