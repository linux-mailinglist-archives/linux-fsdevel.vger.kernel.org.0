Return-Path: <linux-fsdevel+bounces-77317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNiKA3hmk2k44QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:48:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3660147135
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DF0F300D776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65E2E8B82;
	Mon, 16 Feb 2026 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="cD9luRQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22C2D780C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267697; cv=none; b=iWAvp7GjhMf9JDoFiiXj+qrjCa6cBqiKsMr5mtOfMQdTZK5vEKLW6Oq4D4xL3aeBoE4EaSc2PAqEqanFrXHRjdowqCI/tVSnYrzUTGYfplUTVNXJNgNJQRXlyHuORmcUoCHSsTbCkYddif1A1o1lD5CIYgJb9wUEMhRFCI4z5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267697; c=relaxed/simple;
	bh=sG+WbVQlxuQia5HjUs8kRut/EDDZgsAt64p2h2iilk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmugj/AnDQzEZ6tYaxlaeYnGEZqw3QIs5W10bH1BhHTGI/xQ5ceVNw2pnMgD+WXcnS5af/vySPgTm/pqV06S7wQCn37Ql+dCG7xiCnLGIeM8ueB1zVwNFTAq5SAtwjuUUyyESjbQI+9nZ/xHqm7BGq7B9bdKdmAUfyu27STyt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=cD9luRQl; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb48234b08so307621385a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771267695; x=1771872495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTgueUMUNqPPeLpij1IzKLOOR2xA2a9HugYD4yHosO0=;
        b=cD9luRQljvKBJUlUIVd9sVrYrRdNKkfjYGyaPGPWujai2gY8dpBHrIdlhRn7pv8uxB
         QofI834a4iG6VbV7+Cj51IxuA4x994usZin6H1HiMBzrpCEXDe/hkdNnJ3igqQcnEFLd
         LqAmq3mJa0+l652qQyNxxg5k883nubE9w7OyvhuEL+bznKZTdudV6xMXhZjLw7r3ArVT
         mUYXjrCcX0HSPEJbrrwY9c6P5MrpzAPCos4eabdJICig5pxJxuB5c4eS6h7Mb5i+B3dQ
         58WYj6wdjHEdF+6RTWXzqn7350rToeCoQlC8EmMIpHPC5cQqTEm4lFVhck8IK6/ID2nL
         0FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267695; x=1771872495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTgueUMUNqPPeLpij1IzKLOOR2xA2a9HugYD4yHosO0=;
        b=q+0EQ3bMctu7+HvGukM7GsbSXefKmi7aVWtI1tjw6jVz29UM7r4npxg8LHNHPUnVuR
         Oy4oqm5cPwE1+Dy6hb1ysTXuTXQZqGMiRxr78+XwtJMm/4OOeNSCHpABQRRdQTtPvDkm
         GO2mRgUqS2TlIA2Ps+TOJrWIhIo3vGA6O1HV/UVcFkAsTDwmlJk5F2LoD1OK+EudEO3H
         reMJ/H3cN6HphuDPKT4uWbXvJ27Qy9DooPeeRgluUn6dVCmlAW9jHLD2WQ7STQl/dfBE
         hbBjxWeYj7dFJF0vVHRGk1f6enuLC3APcr1GnhmsFQF244RsEWzEI+gHSXOCLtm1WnjT
         CWyQ==
X-Gm-Message-State: AOJu0YyFc4pYjEp4erzhfIh0w6V2NVIMHEwoYdtqUpSdoUKFwgyEXftg
	gxjEJmaRH8W/bepCFKUSHWDgzppnmi+5KIYNwQBosKe12CaM8+lPOqqt6rzpo4Zeg5M=
X-Gm-Gg: AZuq6aI+GdMpkFyigE6RDEgUw29tw8b0h7UBbKLLdUnNxWqtJH4GDwWvv30IA43ZqpG
	O7+KqZmKy3EZ8jMmePQmEn0xVqZ4ntWUlef+5C2rmb9TnxTCswa8eprcEVFhLaNMTok3lYthRM7
	QNRIrD1N5eYpCHVAmh2TAF27zPIv83G51R9Nbm8eoY8BOerCwSd7a8iTVFdesMOlCE5bkpvsnLc
	BET8Ud7MUnUP4Z2zEsdG/pICmm9JC8fLY7Y2pjuK1amAFcj9CCBlu/VN1lozgXYiNj9Mjs7Erne
	vDN2jgUvVrM+myx2slrGV/ZY67UhDM+zbSypwpouet6roR66bD+Lnw2ut2oHJPfGsMmPOo+jsX/
	Zpcffzeb2D7Tr6q4YApUc7E1s3Q5nGgmrv6gbY21/jVfxFTYtrzcDYW/IFGZs6/TmJc91yekv6x
	6s9TORCzEWFRFb0v/rhk8yORr7KIoZniWA4Y80PEoJrAuoMdtSHOQOakxBrLeqhGisKtM9nfh8V
	VL6
X-Received: by 2002:a05:620a:40c1:b0:8cb:44d7:39ac with SMTP id af79cd13be357-8cb4c01e32bmr1070269685a.73.1771267694690;
        Mon, 16 Feb 2026 10:48:14 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb3e89dc23sm1027650185a.20.2026.02.16.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:48:14 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 2/2] befs: Add FS_IOC_SETFSLABEL ioctl
Date: Mon, 16 Feb 2026 13:47:55 -0500
Message-ID: <20260216184755.48549-3-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216184755.48549-1-ethan.ferguson@zetier.com>
References: <20260216184755.48549-1-ethan.ferguson@zetier.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77317-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zetier.com:mid,zetier.com:dkim,zetier.com:email]
X-Rspamd-Queue-Id: A3660147135
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


