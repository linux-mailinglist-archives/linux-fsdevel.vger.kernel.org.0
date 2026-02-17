Return-Path: <linux-fsdevel+bounces-77433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOLvDkn1lGlzJQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:10:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9754151B8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811CA3065F29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A331D371;
	Tue, 17 Feb 2026 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="BaZYIcI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FD313E0F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369739; cv=none; b=RqipA8Zllxr8m8ym1vcb0rJZ9ygetXX0CtdOi2kpRa47rB1kDTFOV1IQoBr9lLZiKMM5AJxf8HslnuWD1x5YxVXdi8sQNbHz4b9MgrFCpjbDjbVYebHUzNPPq4C3ACtAJTY9HU6z7JQFNNocXqTES6vSdsVg9MmQy85NpxpH0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369739; c=relaxed/simple;
	bh=/dDrVfDKsUcytHVbJjVpT632+/VzkrBDFcDuhbzCGrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhJOBw/9owwsAbChbji9oqfCl5YvpFt5akhXd5lLeL90Mb6H+AbYZ65TyVSseOvLx/qZfV/2uK8HToa1l0ohIm3wJPszvAhr9Gi5Q6VNu/EnQb3ApIgGD4WpvJh+FOKS/8LZjflMRIWtpMm7xmpHZYv2cznPhL1RLsiC8H0vsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=BaZYIcI8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3e22435fso24984685a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771369736; x=1771974536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrA5zBI886Ak4PDcuZ2foshmoLSrHCLowKH+/koqLNU=;
        b=BaZYIcI8iCLAVN+Er7e6PAhfNT5B3ZoWsif7+4qPEs9zUVYbtzwuLV9w0K7i+Zyl5b
         zO65fRZkMVwSEO6h3/0MxTnvL6H75MgNVFgY0+N4p0T5jyGIQzXK05RC5ySDRgPlt/jq
         yXoD3g93jewOMWApU1HgJqiQFx3Prf1azDVJ3yDxzeKSP1l1Vn6OMzA9/W3cBn7rEK6X
         WyHlF+tzLWlbXpZ7kz/nTrc/lXgDbrJN1doRcjtoPBB8Bk0CjP4pgQiDuLMefYIXTAUU
         XI6QUTw5C6am8X4Fj/41KR6nXF4uBauPmKqfoms92fIkE8LFb/OJt6VBiizFL8/vrAS6
         XjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369736; x=1771974536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrA5zBI886Ak4PDcuZ2foshmoLSrHCLowKH+/koqLNU=;
        b=evRRr4UtY8rDSLKtP0GWdh4nTowklUcq39YMBzeeQ8PVX5LP8ojLVsMW7zovetp7d3
         gxdoYqmvnsPdVNDvgI2RYUlX9MSlsxkmRie9QezZDspBqbz2Abns3JGep4IyZbckBN0G
         c7LBoSuYw5oWs1rdDVq30hEKHLkHPP3BbSalovOQaqyPCnlpO6ZL97lne92RMVaHARZl
         5OXpmNZzZo/HmEpl8xsekZ764d4MOtgNH6QX+p5BDJZIxwKRC5mqfb/NSwRiSJ2MnUmU
         6tW7PBZHckmBoNPP7uVwG/HIQMt+E+v11RmhFZ97A/RgZnzMjQCvKv8Mt6N5UnQ8d3eq
         1faA==
X-Gm-Message-State: AOJu0Yy8dX7YU6XWIbXVd0WTdyQ2rwvjFKP/Iraw+8WvLTqDj5R2uiIz
	3iy1oxIHKGZJZ7n0AOd7hUuXbMtuPCrrJnDY1FtlxE94YbhK9+H1qUogpCDGlF+CFgE=
X-Gm-Gg: AZuq6aJj8rgOsVC95UMhnj8c48Mt5Qj+a+ekLEaUgNaqHTS18EByzK9AG/hjVqWIu5Z
	beQPRC67uxD3JrRhhusm2BcvVxNHgKxDqkz6QCs+Wia9uWMcEldAwg7fh/Rfwym5CA+iC/ir7Ax
	lfKVSrWCfLlmJzwq/sbew7dPErYJcl61Sk5co2WS6wb5v38smd/0TCZkf2PBCSdstEIekaa0Whv
	O8m5T+SFPUcobe4HmQxos9J7aYWUpGB+qQV0o6KRdvEcaLRLCy1oH8Bz49hij3O4Gh6sRRIFdAa
	k/L+2uuBSvYmd3A4n7W3tLijzfLGR2f+bkD4+dL2rhmMPJopWeRza6StImmCHN4FJ9rP2LKK2Ju
	FBH3Cvsr/8Xmwm3FuA1h/ffKh0ybzd3LBnhka/PvkJukYRAunxSt16l+Txpj/ZJGTIJTzaVkI4I
	I9JqpjgKUzRsDF/fJn21HZ9ctNPjTmLUutmPbuWLThuVTMu/957FdyTrYUSppKC+ZQzKYa3rXvc
	5BfUnJ0TjmzPxc=
X-Received: by 2002:a05:620a:254d:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-8cb741dd2d0mr5743685a.45.1771369735368;
        Tue, 17 Feb 2026 15:08:55 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f82csm175513186d6.4.2026.02.17.15.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 15:08:54 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Date: Tue, 17 Feb 2026 18:06:28 -0500
Message-ID: <20260217230628.719475-3-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217230628.719475-1-ethan.ferguson@zetier.com>
References: <20260217230628.719475-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zetier.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77433-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,de.date:url,zetier.com:mid,zetier.com:dkim,zetier.com:email]
X-Rspamd-Queue-Id: A9754151B8C
X-Rspamd-Action: no action

Add support for writing to the volume label of a FAT filesystem via the
FS_IOC_SETFSLABEL ioctl.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/fat/dir.c         | 51 +++++++++++++++++++++++++++++++++++
 fs/fat/fat.h         |  6 +++++
 fs/fat/file.c        | 63 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/inode.c       | 15 +++++++++++
 fs/fat/namei_msdos.c |  4 +--
 5 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 07d95f1442c8..1b11713309ae 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1425,3 +1425,54 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	return err;
 }
 EXPORT_SYMBOL_GPL(fat_add_entries);
+
+static int fat_create_volume_label_dentry(struct super_block *sb, char *vol_label)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct inode *root_inode = sb->s_root->d_inode;
+	struct msdos_dir_entry de;
+	struct fat_slot_info sinfo;
+	struct timespec64 ts = current_time(root_inode);
+	__le16 date, time;
+	u8 time_cs;
+
+	memcpy(de.name, vol_label, MSDOS_NAME);
+	de.attr = ATTR_VOLUME;
+	de.starthi = de.start = de.size = de.lcase = 0;
+
+	fat_time_unix2fat(sbi, &ts, &time, &date, &time_cs);
+	de.time = time;
+	de.date = date;
+	if (sbi->options.isvfat) {
+		de.cdate = de.adate = date;
+		de.ctime = time;
+		de.ctime_cs = time_cs;
+	} else
+		de.cdate = de.adate = de.ctime = de.ctime_cs = 0;
+
+	return fat_add_entries(root_inode, &de, 1, &sinfo);
+}
+
+int fat_rename_volume_label_dentry(struct super_block *sb, char *vol_label)
+{
+	struct inode *root_inode = sb->s_root->d_inode;
+	struct buffer_head *bh = NULL;
+	struct msdos_dir_entry *de;
+	loff_t cpos = 0;
+	int err = 0;
+
+	while (1) {
+		if (fat_get_entry(root_inode, &cpos, &bh, &de) == -1)
+			return fat_create_volume_label_dentry(sb, vol_label);
+
+		if (de->attr == ATTR_VOLUME) {
+			memcpy(de->name, vol_label, MSDOS_NAME);
+			mark_buffer_dirty_inode(bh, root_inode);
+			if (IS_DIRSYNC(root_inode))
+				err = sync_dirty_buffer(bh);
+			brelse(bh);
+			return err;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(fat_rename_volume_label_dentry);
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 4350c00dba34..3b75223fbe76 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -341,6 +341,8 @@ extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
 extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			   struct fat_slot_info *sinfo);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
+extern int fat_rename_volume_label_dentry(struct super_block *sb,
+					  char *vol_label);
 
 /* fat/fatent.c */
 struct fat_entry {
@@ -480,6 +482,10 @@ extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
 int fat_cache_init(void);
 void fat_cache_destroy(void);
 
+/* fat/namei/msdos.c */
+int msdos_format_name(const unsigned char *name, int len,
+		      unsigned char *res, struct fat_mount_options *opts);
+
 /* fat/nfs.c */
 extern const struct export_operations fat_export_ops;
 extern const struct export_operations fat_export_ops_nostale;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 029b1750d1ec..5d445c2d8657 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -167,6 +167,67 @@ static int fat_ioctl_get_volume_label(struct super_block *sb, char __user *arg)
 	return 0;
 }
 
+static int fat_convert_volume_label_str(struct msdos_sb_info *sbi, char *in,
+					char *out)
+{
+	int ret, in_len = max(strnlen(in, FSLABEL_MAX), 11);
+	char *needle;
+
+	/*
+	 * '.' is not included in any bad_chars list in this driver,
+	 * but it is specifically not allowed for volume labels
+	 */
+	for (needle = in; needle - in < in_len; needle++)
+		if (*needle == '.')
+			return -EINVAL;
+
+	ret = msdos_format_name(in, in_len, out, &sbi->options);
+	if (ret)
+		return ret;
+
+	/*
+	 * msdos_format_name assumes we're translating an 8.3 name, but
+	 * we can handle 11 chars
+	 */
+	if (in_len > 8)
+		ret = msdos_format_name(in + 8, in_len - 8, out + 8,
+					&sbi->options);
+	return ret;
+}
+
+static int fat_ioctl_set_volume_label(struct super_block *sb, char __user *arg)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct inode *root_inode = sb->s_root->d_inode;
+	char from_user[FSLABEL_MAX];
+	char new_vol_label[MSDOS_NAME];
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sb_rdonly(sb))
+		return -EROFS;
+
+	if (copy_from_user(from_user, arg, FSLABEL_MAX))
+		return -EFAULT;
+
+	ret = fat_convert_volume_label_str(sbi, from_user, new_vol_label);
+	if (ret)
+		return ret;
+
+	inode_lock(root_inode);
+	ret = fat_rename_volume_label_dentry(sb, new_vol_label);
+	inode_unlock(root_inode);
+	if (ret)
+		return ret;
+
+	mutex_lock(&sbi->s_lock);
+	memcpy(sbi->vol_label, new_vol_label, MSDOS_NAME);
+	mutex_unlock(&sbi->s_lock);
+	return 0;
+}
+
 long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -181,6 +242,8 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fat_ioctl_get_volume_id(inode, user_attr);
 	case FS_IOC_GETFSLABEL:
 		return fat_ioctl_get_volume_label(inode->i_sb, (char __user *) arg);
+	case FS_IOC_SETFSLABEL:
+		return fat_ioctl_set_volume_label(inode->i_sb, (char __user *) arg);
 	case FITRIM:
 		return fat_ioctl_fitrim(inode, arg);
 	default:
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 6f9a8cc1ad2a..a7528937383b 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -736,6 +736,21 @@ static void delayed_free(struct rcu_head *p)
 static void fat_put_super(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct buffer_head *bh = NULL;
+	struct fat_boot_sector *bs;
+
+	bh = sb_bread(sb, 0);
+	if (bh == NULL)
+		fat_msg(sb, KERN_ERR, "unable to read boot sector");
+	else if (!sb_rdonly(sb)) {
+		bs = (struct fat_boot_sector *)bh->b_data;
+		if (is_fat32(sbi))
+			memcpy(bs->fat32.vol_label, sbi->vol_label, MSDOS_NAME);
+		else
+			memcpy(bs->fat16.vol_label, sbi->vol_label, MSDOS_NAME);
+		mark_buffer_dirty(bh);
+	}
+	brelse(bh);
 
 	fat_set_state(sb, 0, 0);
 
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index ba0152ed0810..92b5d387f88e 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -16,8 +16,8 @@ static unsigned char bad_chars[] = "*?<>|\"";
 static unsigned char bad_if_strict[] = "+=,; ";
 
 /***** Formats an MS-DOS file name. Rejects invalid names. */
-static int msdos_format_name(const unsigned char *name, int len,
-			     unsigned char *res, struct fat_mount_options *opts)
+int msdos_format_name(const unsigned char *name, int len, unsigned char *res,
+		      struct fat_mount_options *opts)
 	/*
 	 * name is the proposed name, len is its length, res is
 	 * the resulting name, opts->name_check is either (r)elaxed,
-- 
2.43.0


