Return-Path: <linux-fsdevel+bounces-72278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A9CEBA79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B58B30657A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEA1318131;
	Wed, 31 Dec 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="G3u9w4Ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68031578E;
	Wed, 31 Dec 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172445; cv=none; b=Kjf+UiHYcVgBJAXTMG47SqyYkV8WYMnk9+PjLod1hjPjjep7PlnrfTuELnFBEi628UTbn0CrsY9D9n/V75hzaz+qlp5eDaPOQfuaCclJKGDFMN/vJy19/ADuDU7y0TutYM7u2XRO5ZaIgUGlUauT9xWw9yfBP3fbau5r0rhiBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172445; c=relaxed/simple;
	bh=rXVocoARrav5F9iqdE9uW2S2fitJawjEKBGGH3kMBC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=png3H9sx05mRpNDhMc1suGYaFZ6CWQiDC3ydKMDQA44k9P2w1yFenK/KS2vlR33vTYlUJJuO6OIvJlB4z0dDr3eWfI2P2dFr01X41+smsOQDca0gcIS8DHJBQDOz8MqgHp3F9febdRsxKzwN4wkq+p1KvEqzvOYGuzCn+4Kktic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=G3u9w4Ct; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AkwyAy/a1gOEFPbH0KVqKhamoqcDqFdiJaCVxpOTKuw=;
	b=G3u9w4CtQ+ZjFlbzmXiZ8/OmYCzYhPDyKR9C8AOvElUTGdc/lleVCm3VrnhU8vnBfSCP45MjO
	UAplSxw93Q61QmZJcR9cZxWa5R6irYYDuzyWMEr+nEXAAfSIFKu0tfTfO5pOOz/iyvx9Ac8VHpx
	ihwDY3Gt4X9lSU3o5x/HSfQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dh41j6vwFzLlXZ;
	Wed, 31 Dec 2025 17:10:49 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7957340562;
	Wed, 31 Dec 2025 17:14:00 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:13:59 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 05/10] erofs: support user-defined fingerprint name
Date: Wed, 31 Dec 2025 09:01:13 +0000
Message-ID: <20251231090118.541061-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251231090118.541061-1-lihongbo22@huawei.com>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

When creating the EROFS image, users can specify the fingerprint name.
This is to prepare for the upcoming inode page cache share.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/Kconfig    |  9 +++++++++
 fs/erofs/erofs_fs.h |  5 +++--
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    |  9 +++++++++
 fs/erofs/xattr.c    | 13 +++++++++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index d81f3318417d..b71f2a8074fe 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_PAGE_CACHE_SHARE
+	bool "EROFS page cache share support (experimental)"
+	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
+	help
+	  This enables page cache sharing among inodes with identical
+	  content fingerprints on the same machine.
+
+	  If unsure, say N.
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index e24268acdd62..b30a74d307c5 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,7 +17,7 @@
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER		0x00000004
 #define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
 #define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX		0x00000010
-
+#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS		0x00000020
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -83,7 +83,8 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_xattr_prefix_id;
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 98fe652aea33..ec79e8b44d3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,6 +134,7 @@ struct erofs_sb_info {
 	u32 xattr_blkaddr;
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
+	u8 ishare_xattr_prefix_id;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 	unsigned int xattr_filter_reserved;
 #endif
@@ -238,6 +239,7 @@ EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
 EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
+EROFS_FEATURE_FUNCS(ishare_xattrs, compat, COMPAT_ISHARE_XATTRS)
 
 static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
 {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f18f43b78fca..dca1445f6c92 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -320,6 +320,15 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
 	sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
+	if (erofs_sb_has_ishare_xattrs(sbi)) {
+		if (dsb->ishare_xattr_prefix_id >= sbi->xattr_prefix_count) {
+			erofs_err(sb, "invalid ishare xattr prefix id %u",
+				  dsb->ishare_xattr_prefix_id);
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+		sbi->ishare_xattr_prefix_id = dsb->ishare_xattr_prefix_id;
+	}
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..ae61f20cb861 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -519,6 +519,19 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	}
 
 	erofs_put_metabuf(&buf);
+	if (!ret && erofs_sb_has_ishare_xattrs(sbi)) {
+		struct erofs_xattr_prefix_item *pf = pfs + sbi->ishare_xattr_prefix_id;
+		struct erofs_xattr_long_prefix *newpfx;
+
+		newpfx = krealloc(pf->prefix,
+			sizeof(*newpfx) + pf->infix_len + 1, GFP_KERNEL);
+		if (newpfx) {
+			newpfx->infix[pf->infix_len] = '\0';
+			pf->prefix = newpfx;
+		} else {
+			ret = -ENOMEM;
+		}
+	}
 	sbi->xattr_prefixes = pfs;
 	if (ret)
 		erofs_xattr_prefixes_cleanup(sb);
-- 
2.22.0


