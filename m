Return-Path: <linux-fsdevel+bounces-76899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBRzOCewi2mEYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:24:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398711FBED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA3BC307242D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AB330307;
	Tue, 10 Feb 2026 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="PAlZHgJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4253385A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762201; cv=none; b=V7h/YnrB0AQkn/n8RO8Z4co2nf3Gjza9E1UFmry8pIIi440DwJPZGKUr0EdqDt/AxsfmukKlnsZBxLXLfowHIEBdzeMsrErdQjktFMnMlnxFVmBP4NKxKa2PcpkOugBfCO2XwOj/3+kdiAf/dqecAGldBsRXO+at7ZsNhUzzqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762201; c=relaxed/simple;
	bh=zFxFA1GCM8gPEXiEVpKpj+s09Uajmn5lAzVTqkSN9Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5MBMVn7hmFUxRSGf4HJJUYR4ZKMt+oTozKz7Rc1qKkYLgHkwX/iEE2nU0Gro89PZpXekRLG74mwo3eKpWKjjwSAutcYBoJZbgWcC0NvPohXdMvHYQxQptDBgerkkGiJKsp0yaBe0AtxGtpwXR7XcHS/+reG5+zExElk2Ph4QVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=PAlZHgJQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014600ad12so44016931cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1770762197; x=1771366997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdhijZyb/fF9pYUtdTXLnhISRtfqTlYJBcsQJEZtO1s=;
        b=PAlZHgJQkUJ28cEsifn1a3PURrAzE6uvHTBhfkDzgR3CTJJvdvF3BgmGE38zlH39Tc
         789r8GrWl6YAJj7tBkw1k4GNSKtAVcYtAwcUv+c/c0pxjxmorx4zUQyeXdCEumIhZqRj
         8cSYrC5euFPwYuk+vPmJ4MRLt0yWlL1AJus+7yvPVQb414y8J5JMjkX9pS1Th32nM6Uo
         HMrLpNh3ruZCMEE32IMZG8K799JHSI8giDZF+c/HAdtWRF/fVhA2LLv5LpyBcsBCb3Oc
         9yS3VpHz3wqobPTOCIk9H3dqbGWuLfa7/E0X6p/X1bXzIF9cHrIfqgVOB+ECSfL+iNZ5
         kA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770762197; x=1771366997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jdhijZyb/fF9pYUtdTXLnhISRtfqTlYJBcsQJEZtO1s=;
        b=IkAwVCSDZ7dXVU1KMjz+OWmGAtnn3NtCoC3v3aBgGcZtw3QNRGCz5JFa+ReHA6EPBo
         cL9KlcbzIbD1EYIBTyStAkS23/dY6MeOXjAbBLR0qKGqqnmeXTdeR7VhBiepuBqNuGN+
         o8y91g2XPS5KLVKIXvSNO+04LO4h9Ud/R/Mrknb0wbxxzVl2glssCto7V4bGjKFVSfqS
         VpUUgkVl64sY6h18kLGp+KKlrk2HFSAreIsVWzOVci4C+swd6LkG+YpoHmtmORpK+7Bi
         rThYnWZBINlk8yQ5NEdOEd4NzZ1L7sCnyvxHu5KWHXokGm6bBIyvQDjkUTEZasgWGt/p
         LKrg==
X-Gm-Message-State: AOJu0YxlrCI/olU2+HzFuNo0sJL4YDLomwjoszu/PeDAYipVINyPiey+
	ZQJDdtYs5qiJ/I7LOGwAy33jNXbjn0vEU5iGKxaUqzVCAiH1cozNy4zUSd0XNz6Yr20=
X-Gm-Gg: AZuq6aK1geL7Styxgz0tOs8TC5rhWRqApXjdwAvFjD2Tgu7WOpAb6jtuCQHkownb1G8
	UlCjb0u6URfD/x7DJkFOqW69K4aDXFnLxFDD+Ys5Z/6gOjtCLFtVtXb4gWfSYu9r1x6FjgyVyd1
	ZfbfFcbdgtxUIPfdzGHAaX15ilt40YuojWwKT1KhTs52YQPxohnFC2mSCZPthbrcsXK8IKj7mkH
	I0GElMCGSoXWrDGCGujtZmBdotKBZpP9+jw4gD+4TIVMShAQgsbYPWUcA2QRJ9uL9opkfCEgc8G
	JLX3c7Lyv8nt0JCpHDWKhFOklRiR8dBYqCfwAeFDoo/crGYVSXfoU00Y7oB80cvKsRQVHBh2iVa
	lmTMuWGYEIOLnsKN8+gExtWArsnW2M6biqyE0Bkhby7SfyUmcfb3D2sAWXcN8D3nDsiDC8RqVb/
	PbtVGQiZvlIMksaQYyjoxZ69HXubasf8+9m2SmiAukVN4XO/B+0HoEJ1YSfjf6gA7HHp++xV0Qr
	nx8ilJnHCTxtnk=
X-Received: by 2002:ac8:7f4d:0:b0:502:a28c:f195 with SMTP id d75a77b69052e-50673cf1be3mr46438771cf.13.1770762197149;
        Tue, 10 Feb 2026 14:23:17 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682edead7sm646801cf.7.2026.02.10.14.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:23:16 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 1/2] fat: Add FS_IOC_GETFSLABEL ioctl
Date: Tue, 10 Feb 2026 17:23:09 -0500
Message-ID: <20260210222310.357755-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210222310.357755-1-ethan.ferguson@zetier.com>
References: <20260210222310.357755-1-ethan.ferguson@zetier.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76899-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zetier.com:mid,zetier.com:dkim,zetier.com:email]
X-Rspamd-Queue-Id: 8398711FBED
X-Rspamd-Action: no action

Add support for reading the volume label of a FAT filesystem via the
FS_IOC_GETFSLABEL ioctl.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/fat/fat.h   |  1 +
 fs/fat/file.c  |  9 +++++++++
 fs/fat/inode.c | 11 +++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index d3e426de5f01..db9c854ddef8 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -89,6 +89,7 @@ struct msdos_sb_info {
 	int dir_per_block;	      /* dir entries per block */
 	int dir_per_block_bits;	      /* log2(dir_per_block) */
 	unsigned int vol_id;		/*volume ID*/
+	char vol_label[MSDOS_NAME];           /* volume label */
 
 	int fatent_shift;
 	const struct fatent_operations *fatent_ops;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 4fc49a614fb8..c55a99009a9c 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -153,6 +153,13 @@ static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 	return 0;
 }
 
+static int fat_ioctl_get_volume_label(struct inode *inode, char __user *arg)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+
+	return copy_to_user(arg, sbi->vol_label, MSDOS_NAME);
+}
+
 long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -165,6 +172,8 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fat_ioctl_set_attributes(filp, user_attr);
 	case FAT_IOCTL_GET_VOLUME_ID:
 		return fat_ioctl_get_volume_id(inode, user_attr);
+	case FS_IOC_GETFSLABEL:
+		return fat_ioctl_get_volume_label(inode, (char __user *) arg);
 	case FITRIM:
 		return fat_ioctl_fitrim(inode, arg);
 	default:
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 0b6009cd1844..f6bd3f079e74 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -53,12 +53,14 @@ struct fat_bios_param_block {
 
 	u8	fat16_state;
 	u32	fat16_vol_id;
+	u8	fat16_vol_label[MSDOS_NAME];
 
 	u32	fat32_length;
 	u32	fat32_root_cluster;
 	u16	fat32_info_sector;
 	u8	fat32_state;
 	u32	fat32_vol_id;
+	u8	fat32_vol_label[MSDOS_NAME];
 };
 
 static int fat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
@@ -1406,12 +1408,14 @@ static int fat_read_bpb(struct super_block *sb, struct fat_boot_sector *b,
 
 	bpb->fat16_state = b->fat16.state;
 	bpb->fat16_vol_id = get_unaligned_le32(b->fat16.vol_id);
+	memcpy(bpb->fat16_vol_label, b->fat16.vol_label, MSDOS_NAME);
 
 	bpb->fat32_length = le32_to_cpu(b->fat32.length);
 	bpb->fat32_root_cluster = le32_to_cpu(b->fat32.root_cluster);
 	bpb->fat32_info_sector = le16_to_cpu(b->fat32.info_sector);
 	bpb->fat32_state = b->fat32.state;
 	bpb->fat32_vol_id = get_unaligned_le32(b->fat32.vol_id);
+	memcpy(bpb->fat32_vol_label, b->fat32.vol_label, MSDOS_NAME);
 
 	/* Validate this looks like a FAT filesystem BPB */
 	if (!bpb->fat_reserved) {
@@ -1708,10 +1712,13 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
 	}
 
 	/* interpret volume ID as a little endian 32 bit integer */
-	if (is_fat32(sbi))
+	if (is_fat32(sbi)) {
 		sbi->vol_id = bpb.fat32_vol_id;
-	else /* fat 16 or 12 */
+		memcpy(sbi->vol_label, bpb.fat32_vol_label, MSDOS_NAME);
+	} else { /* fat 16 or 12 */
 		sbi->vol_id = bpb.fat16_vol_id;
+		memcpy(sbi->vol_label, bpb.fat16_vol_label, MSDOS_NAME);
+	}
 
 	__le32 vol_id_le = cpu_to_le32(sbi->vol_id);
 	super_set_uuid(sb, (void *) &vol_id_le, sizeof(vol_id_le));
-- 
2.53.0


