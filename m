Return-Path: <linux-fsdevel+bounces-77432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJN3ECD1lGlzJQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:09:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C6151B75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9084D300C7E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA63E31B111;
	Tue, 17 Feb 2026 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="UQvxiKrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900D306D40
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369737; cv=none; b=qfTbKf0SKjCgcZ0wZHGy43qlLsZ6tENe6Ruon+yy9mcYMXsMWB2i1/gZOp+tzESYZcNBhBDyE+cua/U7IW3BuYT9yzaVMctfCyYRtrLa9eGOAnMYeo5zDQYoMTuFh5ZN94FXTfNXfncwp58bOCkIaaRm3rc9F/m4dIzhlalxU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369737; c=relaxed/simple;
	bh=bpyKdwxEgiGS0ibektv1g5DWi5ZbckLP8xYHNlvIEmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul09AtyLO9qOrJwsEXE5H29ZEsZbtbdSrtJM22fZMLdO7sUmcCCGdNS6ppHcFE4ym0UJXgpXExpm+2doaxQ2Hv8Njq15TVx+0PGZFjOHkpT2fXIM1vMkrETtr5OJanRP+m2CGSerXrleyJxalqcfpnx21lwSzK5OWMfaUu3jIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=UQvxiKrI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-896f82e5961so3148076d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771369734; x=1771974534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67x0rmIMjc1SgKva+b4U06wk0ssnpT3jAfZBeoUNrj0=;
        b=UQvxiKrIyfeXPaHjdc4EPAg1rhTdynhZRhj2AeuMaf6fzevtiTPm8LL28BuJGJVIYd
         NcsS6aSfCBG3Sdqmr92xNgLOgFn8LIgviATv74z3jCGJNe9nA8hkoy2qjx5vLzPl2U3L
         UZfa9hTsJdbDUmjwAspuZONqYyPryZ+V3212+wklyMEDQikkrlXPGqYzKpD78dVTMAFq
         vT1QNZiJjwXW91fHIi4OMqNcIjcKVprSK9ZTiYpN/O3+fJg9y+8i+m+MlASDMlwPUbe6
         TSZ9nHU+tv9wAzS6BKNdNiv7gDGko4NQIl9H0C+CXt4RMVq0rXXjk9plAQnysj0DW+xn
         DeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369734; x=1771974534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67x0rmIMjc1SgKva+b4U06wk0ssnpT3jAfZBeoUNrj0=;
        b=Fdp/MuYt1ODbq3G3zQGXtRfSmz7dYnbbAXB8Jpz4jVx7fVaMHRHeeg2rLf2xmMyVKy
         uBUCWe2+PQZeh81DRGDbGmp4deMX4eFZXw9Lir0Z89d8yJDcwj9x8f6sp4y30jnXlVFC
         yVpxhLpwCW0FpLHRryxjeEpYY9+u8MRfftQWf0ioTp/wcTY8qm3U02O/gk1M+llSzvv6
         fZYH5qIIrUW7qWa5bUtXwQqv1VHkngct9F966wzlm1jfASGZCBcTDaDwNd9Oiy/7kFUv
         e/qPgbQ8yJdAHvI8/2CKmrQLYtYx69v7mbvt27J9I+2l8kHWGmeXtxAT8mHtjf3rXmBh
         RbDg==
X-Gm-Message-State: AOJu0YwOSCjk+u6b+pNqJov3kVMMNnHiKmnb3rwZnrlEBjagWz6XeP8C
	uTAjCAG5Q7a8FHjn3vHqIIvp0p+5cITRlwi5H+eIUtUAnRCQ1lfyGDxCfhWnMu5PaxM=
X-Gm-Gg: AZuq6aJKOhFO8Gv2Rz/A4CB7BrtK8bpqNh532QHzAx+LAs4yXOsQI+b0xr2ZllZD4AJ
	JDd4fhOiYKaN3m23CTGUvZZcOcjRqzjGnCOFz9Pwp+fi+pMv9WlN8SaEEcZgJbE50GAK2Gce2Hy
	qMl1EF934TNwFGIVyNAgNu0G4hXszIBV2WK68mBnpPlAZaWp25LW1YjIVVJLGjel+5nL04IUCtY
	83EgTGceu5UqB8aoGwpewnAX+0RDnbtOMA/KKGbQ3peXFDw9AmwEy8dXNoma8uRQRqkmzjidiqe
	tlAMEUeN6lq5gqfGY33AhtPoG+gz+K06SXFVAVB7BwKNAq1eceYBJ/uaKWbb0IkdHktyUkD7Emd
	w1DtTGVtdLkW/LQvSyuPMGZHWHsJSoL3KFHZmZmeJm7RVSiJumGcTAvXvJyVn+8biQSTlTIpT66
	BWK+jEvAJzsLDo/KvFYJeKDY9tASlv9GUG5hiVaKjHY9pEZ1P3pmRhKQ2bFJ0h3RGlDLicHawmV
	Fv7
X-Received: by 2002:ad4:5d6b:0:b0:895:4cc2:8bfe with SMTP id 6a1803df08f44-8974049b5ffmr182540386d6.48.1771369734196;
        Tue, 17 Feb 2026 15:08:54 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f82csm175513186d6.4.2026.02.17.15.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 15:08:53 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 1/2] fat: Add FS_IOC_GETFSLABEL ioctl
Date: Tue, 17 Feb 2026 18:06:27 -0500
Message-ID: <20260217230628.719475-2-ethan.ferguson@zetier.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77432-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A2C6151B75
X-Rspamd-Action: no action

Add support for reading the volume label of a FAT filesystem via the
FS_IOC_GETFSLABEL ioctl.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/fat/fat.h   |  1 +
 fs/fat/file.c  | 16 ++++++++++++++++
 fs/fat/inode.c | 11 +++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 0d269dba897b..4350c00dba34 100644
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
index 124d9c5431c8..029b1750d1ec 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -153,6 +153,20 @@ static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 	return 0;
 }
 
+static int fat_ioctl_get_volume_label(struct super_block *sb, char __user *arg)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int ret;
+
+	mutex_lock(&sbi->s_lock);
+	ret = copy_to_user(arg, sbi->vol_label, MSDOS_NAME);
+	mutex_unlock(&sbi->s_lock);
+	if (ret)
+		return -EFAULT;
+
+	return 0;
+}
+
 long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -165,6 +179,8 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fat_ioctl_set_attributes(filp, user_attr);
 	case FAT_IOCTL_GET_VOLUME_ID:
 		return fat_ioctl_get_volume_id(inode, user_attr);
+	case FS_IOC_GETFSLABEL:
+		return fat_ioctl_get_volume_label(inode->i_sb, (char __user *) arg);
 	case FITRIM:
 		return fat_ioctl_fitrim(inode, arg);
 	default:
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 59fa90617b5b..6f9a8cc1ad2a 100644
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
2.43.0


