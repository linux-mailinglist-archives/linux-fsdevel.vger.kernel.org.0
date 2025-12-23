Return-Path: <linux-fsdevel+bounces-71940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A94CD7D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 03:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E0E3088DFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53893267B05;
	Tue, 23 Dec 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Xxoqf+hY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA49202C5C;
	Tue, 23 Dec 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766455750; cv=none; b=AeOZcp+3mZkKlXiRULfQLeoNp07aXgVlrd9p8AWNjFL7bomXtEzo8X9XWkdBF2u4O1ART2hfFomLlwp1DQNNb5MTXZpQr+bQhbLrm26X8fstsEdbNh7V+fhpElj3JPlawVJN5jOlG1jRYldhjS0X8xBrEYBQJyGjpoo3QZYve1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766455750; c=relaxed/simple;
	bh=xjQejwHpo21sqxcweisQvMiCA9nlciQ78yRV6gGAgtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLRu9A8VNRjbryjEPjO5yxHgYVdnNyh842ZosG76Qghud0T2RZQNe9saY46ogY6j2X0JRY0h4D3rLNvt2ESAZQ7ly+qKaFyUnKJ8HXBFUn16eFwf4J523DpzSkH+IpY6Uyf8Zne15d3XHaeuqwGGgniafyts7rLwR/+a6JBfpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Xxoqf+hY; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j/N4nU6o7xrNDKprehzCh2AlZWmtfEZgbQjQCLPtlc4=;
	b=Xxoqf+hY6BHtzYMaINHJrUWrQ38S/um79n/+M3JL+VIXX/Gy771OHQ8ebdQeN10geRGk8nREt
	PXBp9Qtols8bXUBGMgVteaeCt65uXq8MwNJsQlNW9/1GFHBOrqBVSan8hZQ9TGPkxG6eXb9pUHS
	T+qmwaWk5EJuBgXrjto9eRI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dZyz43X0tz12LF4;
	Tue, 23 Dec 2025 10:05:52 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AF19201E8;
	Tue, 23 Dec 2025 10:09:05 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:09:04 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 05/10] erofs: support user-defined fingerprint name
Date: Tue, 23 Dec 2025 01:56:14 +0000
Message-ID: <20251223015618.485626-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251223015618.485626-1-lihongbo22@huawei.com>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
 fs/erofs/super.c    |  3 +++
 fs/erofs/xattr.c    | 13 +++++++++++++
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index d81f3318417d..c88b6d0714a4 100644
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
+	  content fingerprints on the same device.
+
+	  If unsure, say N.
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index e24268acdd62..20515d2462af 100644
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
+	__u8 ishare_xattr_prefix_id;	/* indexes the ishare key in prefix xattres */
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 98fe652aea33..99e2857173c3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,6 +134,7 @@ struct erofs_sb_info {
 	u32 xattr_blkaddr;
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
+	u8 ishare_xattr_pfx;
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
index 2a44c4e5af4f..68480f10e69d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -298,6 +298,9 @@ static int erofs_read_superblock(struct super_block *sb)
 		if (ret)
 			goto out;
 	}
+	if (erofs_sb_has_ishare_xattrs(sbi))
+		sbi->ishare_xattr_pfx =
+			dsb->ishare_xattr_prefix_id & EROFS_XATTR_LONG_PREFIX_MASK;
 
 	ret = -EINVAL;
 	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..969e77efd038 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -519,6 +519,19 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	}
 
 	erofs_put_metabuf(&buf);
+	if (!ret && erofs_sb_has_ishare_xattrs(sbi)) {
+		struct erofs_xattr_prefix_item *pf = pfs + sbi->ishare_xattr_pfx;
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


