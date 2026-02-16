Return-Path: <linux-fsdevel+bounces-77316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL68LIBmk2mE4QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:48:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B7614713C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71202303A260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69A2E7BB5;
	Mon, 16 Feb 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="hQfrs/90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7E28AAEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267695; cv=none; b=plsMJUPnHfWxmj6Nf6cQdnBPxjMAk2elmixUz6DpXs96EI9w9j/je8GdMOiIocutyZZ2UFKx+4aGuYtCrx8xp9OdB50JGIkAapePrZ42frh7zAB8K56tJB1Asa28t4ruObe6v4kvtm9YzR49IkDeBr8ycFbdJmofIyqS8P9Hs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267695; c=relaxed/simple;
	bh=QbUr32o1qNknh8OKNJHyEYG9tcZZ7RE7ciOmZfVnlj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEHGA5UavC6QjFg7j2prtYL+liTGHKtr9+/KdgJVLh1BAbj0FxVizd5lRu5G+xXS6KRmFOYppXI016TnRiz0pmupSGM/BP8yN85U1avwpeUNxXCpewrAB6toaHzzrb6epkC75t6bv8MvYnbc6xVdYWGS5vkhmquaarfnls8lCzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=hQfrs/90; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3dfb3461so372213685a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771267693; x=1771872493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X54B7Vf+BK11FAXu0x08XDmOK83/BHoweBSyAzhyJlc=;
        b=hQfrs/90UW8ibIBRcYrMlwMObOKsn34uiLbXrMbF7br4gR6SVzmzKE5Z7s/yME5/fO
         s9SEReOxqHzkx14eN0YRvUOX10ALiAwdyqqTfccYlnMsKwhhQqC9ovzQbbtY0AbC2MtQ
         n2rY2XzVTeaHlsvARaLsPWWNdoZVJb2dFfbf1AhOUB+s9YoXbIo6/uAkqqk0VwjoKzS4
         htSY4ZQHxtTO64YIE0rjoMUaPd7F82UzViE1EgTjxmf4QXj94HwgWeu5wVAV3Qyk/9Kf
         Kz86cARgf+Huo197EVm7BpJaheDkvUQNU1KV957q0cOIShM/WpwRLuB8+BorLFG6pBtH
         2e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267693; x=1771872493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X54B7Vf+BK11FAXu0x08XDmOK83/BHoweBSyAzhyJlc=;
        b=Fdewo+rlj9zyiVS4F2dQbix3OT3HEghJuOT0iBt37CWa0FVZAH5sItvGJa113MLDG3
         JTLlyAeCIRVzlRRm5xHMEYQyFreaRVvMD1732VIAHa/ny8wnN1l3OB5qPGieu4OEANp3
         DTwavSo89aH4l4TbGIaIFqV6HoZui/9Sv5wdQfq7r4AG4w0SWXupCWY211PDznwaGXiP
         aFhzmWU/0J44SDk36INMVuaFIWPrscMdlzW3aDaLxpmD2BXSRRh/v9tk6CasCJfnmMEU
         yLSqZCam1riYnYS/OQFTHdkbT8JrZjulBHUf7B8ZRqfqm87eGjf9idSI7G1Zqm06++UI
         8hLA==
X-Gm-Message-State: AOJu0YxnlSY+DqSQE0S7pEqEFfdwUZA/pHvPsOzZDvRX09NVhQUIfqLk
	Xwh8dcFoqle07by1Qe10Hr5LQ0HWV8ap8ubpop+WhopAQH88Uwas3gcOiefy8loOX5E=
X-Gm-Gg: AZuq6aLD5DB3d56sdLFCJh0un1/nokZ7i6C/EGuZR4cTcN8chIBehAzYALIJEcGbnqR
	CTxeWfzDbmh13R5o1zUW6cvnFibyfLUkgPFTjDRkL3uTBYJK1ldqnfipQIF5Emna4vmCXuRQ15c
	0pkNfukII07n+9ly+37Q585B1bELcCCSodnTtHNQQ1uzc3AZnVnn7yfyiJnI8CGza7vSGVaFuXp
	gVedWWbOHwSTDbkHcrqIaxZDyLt8v1PU+4YFjJCKTSSdhtYq6so2JzpmyyAAJeknbMiIyRa0QrC
	SwQeyfaWfBDOMpcIYO36rX/Hor241yDS3i3zFSgLiNMKbs+GAnPcw6MC9WYII+gZONRpU1F/xcp
	+kYhsXok3r5dVZq1cSAzuDQhc9xalYVyXem4+7AqeWHF+Rt8xOYnUTR0QmatgmJAUaCDaCHhKz7
	TwmSc3NkRqZAqglveCp92Fkcxa0ukZrUPkG9WYSrm0cgZ+TTFFYBkISNuPguTrzrPGjf0UAO4I8
	hRm
X-Received: by 2002:a05:620a:1a9c:b0:8ca:3c67:8923 with SMTP id af79cd13be357-8cb408d6a37mr1475950185a.53.1771267693386;
        Mon, 16 Feb 2026 10:48:13 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb3e89dc23sm1027650185a.20.2026.02.16.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:48:12 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 1/2] befs: Add FS_IOC_GETFSLABEL ioctl
Date: Mon, 16 Feb 2026 13:47:54 -0500
Message-ID: <20260216184755.48549-2-ethan.ferguson@zetier.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77316-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E0B7614713C
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


