Return-Path: <linux-fsdevel+bounces-76898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePo2Lhmwi2mEYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:24:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9D11FBDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEC22306B2FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779A33A6E4;
	Tue, 10 Feb 2026 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="WjwwxfHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8481339B3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762201; cv=none; b=RWBMSO8SWthgdbIgKmxrbKnNc0Z2lQgdMFPlijTQ8V2Iw2j8ndTE0TZyqQFfXM/9449MbJ+r+0AeWS0rxTngvohC+bdSOmZms3oEZTxYey70XrchpcFNND8mxOZpv+MUi0UeAzU5eP1oYe1KPiB09FSeN4iwaWEaw8ScV0Q+jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762201; c=relaxed/simple;
	bh=m6kuT4ru0pzsc9PoL8u98ZqQt+Y4v5WSn+QSSceV3h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dycC9Qqb0TJyAdPBq9vCBxeFcF78+2JZ8mSPhYODN3kAUlJCH9cGsDNB7N0rt1cNA5EeHDRra5/u0py9aPnIv31fXQ6zAXNO00os9dBlYd17ilVUG/MnQ0WeTibfh84hw4ctyVtDAStKtjb5++DcJKMivSOwVIgEv6Uudh9GI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=WjwwxfHZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502acd495feso52603571cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1770762199; x=1771366999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=img53VqC7R04RkA7EExplxfa/I0yMn636xW9pad0/C0=;
        b=WjwwxfHZpFnfNu/jlAZ3RYNqn8ZFNr979TJtEc85iK5g+V2cIa4WwcIqxm7sGQUZoF
         YxMEUH92dY9VZiA8rkAo8XXFycFalAqrXgjwU6TVdA2Ww1A1PaFhhacmsCmAgCX3lhz4
         Jhm8n10XfisEURrIMNRaphB1LvnsO8LOdk/Bkcz2wr5KoE1s/wCFqhGj9JQp9B7qpzZq
         S9rTO8p+BmTnr1Y9ZdFdTpI3GI+wTFLk034sC+1hXnQTbGsUidNbVmalpPFEkbExU+3Z
         6YNecv2Mam0m0R95wwY0E0ZmyScrabG7Pi8DGsyGFmJ73gKW5Pfhm/CbIth7wUVEXP6b
         O0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770762199; x=1771366999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=img53VqC7R04RkA7EExplxfa/I0yMn636xW9pad0/C0=;
        b=st2dO9w6vz0DJ7IxPfMneNyr63HoZmTlJdjpOGwzjr8LJOfXahjPJ6iss/RnjOpu24
         gYtqfRM1SgajwmQZ7uS48nbHkWQdFJfktLW6pRbohJLojSRnHAKIrMj1na94A+XCocN8
         YpBR7wY3nYb0BQZnbNx1tyQQxketwlRvUnyqvO6oyr5g3/eZye0nRWjbB9Hx08V76XEC
         irsFHIasIO3rwEzWOHgtMSmpHUhTW1FtVqCtRXS1J/Kj/lVwf209Uu7eiS+bV8bpoKIs
         0ztOM+K4QCWnbqxRjdXwSYuGyDLWUhEvVHDRngzYDmczcE4BxQs3bN1Ycz3/QudtSwxN
         uqPw==
X-Gm-Message-State: AOJu0YwHj4khh1W6zmN9Be0Ae7/3NCNNlzGz0LMRJsry5o0yqIoyWhPg
	rXp/dnnno5o3IuHn4TOES1ROuE56aEARjtkgEPDz13WH9FYiKGr4fZdRR9P9oa7CaKg=
X-Gm-Gg: AZuq6aJ1ttLif4qFMeOxrf4VF5uCITfnwURpfIkgQAFIElunqcqyZfldSUGceugNiks
	sEr80zO8NmMPQST72SKEXCWTqOiQ3nbF8i1DUNpF7x1CkekXf91iI3NGuG8qb1zugwIfnLsNlan
	9+JlPWgYUtVeEfHCL/+ouRMnSAk1ceOFQhnlWNxueea3Nl8BEJVLMoU0jnhfaW3i3+4TcTm2TO4
	Bj5NdPwO1Qsy+qv2R7bAvIg1/irJel03YE95edQRiVeSCB1es+aQJk49Ybo6vJn0MpPDBv49aaV
	Y0lwjCJYR8KKEt60p+dHZhtzOWNtu8+Bl0hljRfsZ2lQYtjKYj0U1Y6rm5+d1BrulbTGV7LiTOz
	USMamofKA5LMht6JySqq+vLpnS6q5pgD/UrpMiEmVjE/TAmhN+gHaToyiZVPT1HdwoDL1BIQMHK
	mKOp+44red6lYfwVzLbv0p24xHRQYI5ox7tnlPG2IevLZnHo8mVrBZr/vQCmqQUgrHyKBkavicq
	pph
X-Received: by 2002:ac8:5ad6:0:b0:502:6312:8d6 with SMTP id d75a77b69052e-5068102b723mr12240941cf.12.1770762198654;
        Tue, 10 Feb 2026 14:23:18 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682edead7sm646801cf.7.2026.02.10.14.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:23:18 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Date: Tue, 10 Feb 2026 17:23:10 -0500
Message-ID: <20260210222310.357755-3-ethan.ferguson@zetier.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76898-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zetier.com:mid,zetier.com:dkim,zetier.com:email]
X-Rspamd-Queue-Id: 21B9D11FBDE
X-Rspamd-Action: no action

Add support for writing to the volume label of a FAT filesystem via the
FS_IOC_SETFSLABEL ioctl.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/fat/dir.c   | 22 ++++++++++++++++++++++
 fs/fat/fat.h   |  1 +
 fs/fat/file.c  | 19 +++++++++++++++++++
 fs/fat/inode.c | 15 +++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 92b091783966..13e87f4c6bf3 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1423,3 +1423,25 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	return err;
 }
 EXPORT_SYMBOL_GPL(fat_add_entries);
+
+int fat_rename_volume_label_dentry(struct super_block *sb, char *vol_label)
+{
+	struct inode *root_inode = sb->s_root->d_inode;
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de;
+	loff_t cpos = 0;
+
+	while (1) {
+		if (fat_get_entry(root_inode, &cpos, &bh, &de) == -1)
+			return -ENOENT;
+
+		if (de->attr == ATTR_VOLUME) {
+			memcpy(de->name, vol_label, MSDOS_NAME);
+			mark_inode_dirty(root_inode);
+			return 0;
+		}
+
+		brelse(bh);
+	}
+}
+EXPORT_SYMBOL_GPL(fat_rename_volume_label_dentry);
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index db9c854ddef8..5f1536c21adf 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -341,6 +341,7 @@ extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
 extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			   struct fat_slot_info *sinfo);
 extern int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo);
+extern int fat_rename_volume_label_dentry(struct super_block *sb, char *vol_label);
 
 /* fat/fatent.c */
 struct fat_entry {
diff --git a/fs/fat/file.c b/fs/fat/file.c
index c55a99009a9c..2475a8f58596 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -160,6 +160,23 @@ static int fat_ioctl_get_volume_label(struct inode *inode, char __user *arg)
 	return copy_to_user(arg, sbi->vol_label, MSDOS_NAME);
 }
 
+static int fat_ioctl_set_volume_label(struct inode *inode, char __user *arg)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	char new_vol_label[MSDOS_NAME];
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(new_vol_label, arg, MSDOS_NAME))
+		return -EFAULT;
+
+	fat_rename_volume_label_dentry(inode->i_sb, new_vol_label);
+
+	memcpy(sbi->vol_label, new_vol_label, MSDOS_NAME);
+	return 0;
+}
+
 long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -174,6 +191,8 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fat_ioctl_get_volume_id(inode, user_attr);
 	case FS_IOC_GETFSLABEL:
 		return fat_ioctl_get_volume_label(inode, (char __user *) arg);
+	case FS_IOC_SETFSLABEL:
+		return fat_ioctl_set_volume_label(inode, (char __user *) arg);
 	case FITRIM:
 		return fat_ioctl_fitrim(inode, arg);
 	default:
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index f6bd3f079e74..b40abb2b0010 100644
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
 
-- 
2.53.0


