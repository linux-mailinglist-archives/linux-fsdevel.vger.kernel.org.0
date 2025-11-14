Return-Path: <linux-fsdevel+bounces-68451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F02AC5C794
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67AC234B3D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35C230EF89;
	Fri, 14 Nov 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="V+TmuZrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14C30C360;
	Fri, 14 Nov 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114822; cv=none; b=rfpA0tSpC47QuTS1XRPEiADJTNGI+ovkfpzt7lNc/Ul7/xLu+5ne8ggIuKZDmHwT3NLCJ1/VY+AqKTev8/qby/rSuZ/0C9/zT/PpE0i9R2e+XE/zuGV0O0wY0B+10UkqpexmpT1we57/SNBx/18P23vEOtEUaKRXikhhqr+JLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114822; c=relaxed/simple;
	bh=Kg0QCfmFyUNtsDlUVBarSBCCkw7lWjyL3Ax0t78Uvxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXd9jGyGVE7y4Alvctar9XTVvF8iDB0/FAN6cjfKNr+X/qZXfFGngJp3u/3WMZDZZkpr4s0mMP0VwW15txeGV/pIU9NBkBjz6x/YNiVLNweIlFozgheSKH/+jar+F1DfyASLS3KufBCaZSoKT34/lDAXK25+UVv16m2xuxjizDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=V+TmuZrY; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YL/tWdSMyJnhT69kjA2piGvwBmgoM2UAWnLITs3jTEg=;
	b=V+TmuZrYmgHvOsWxyuHKiGIRN7ibFSt+AxOTCD9SrXmlbNoUuTqDaNvpnOf30R2wDLrlB7gv7
	ZLw5E25Ga8cOAzgfmSZ7qwj2ATBqTSLfjnpWWhlk/TeMbiSQNcdPo/zTRXPZ5Iks+YUnlB3Gvqw
	ISmjrPMwBRGUeBFlKftEXAM=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d7CSC3NMRzKm5f;
	Fri, 14 Nov 2025 18:05:15 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id C6EA9180044;
	Fri, 14 Nov 2025 18:06:56 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:56 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/9] erofs: support user-defined fingerprint name
Date: Fri, 14 Nov 2025 09:55:11 +0000
Message-ID: <20251114095516.207555-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

When creating the EROFS image, users can specify the fingerprint name.
This is to prepare for the upcoming inode page cache share.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/Kconfig    |  9 +++++++++
 fs/erofs/erofs_fs.h |  6 ++++--
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/super.c    |  5 ++++-
 fs/erofs/xattr.c    | 26 ++++++++++++++++++++++++++
 fs/erofs/xattr.h    |  6 ++++++
 6 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index d81f3318417d..1b5c0cd99203 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -194,3 +194,12 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_INODE_SHARE
+	bool "EROFS inode page cache share support (experimental)"
+	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
+	help
+	  This permits EROFS to share page cache for files with same
+	  fingerprints.
+
+	  If unsure, say N.
\ No newline at end of file
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3d5738f80072..104518cd161d 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -35,8 +35,9 @@
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
 #define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
+#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000200
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
+	((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -83,7 +84,8 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_key_start;	/* start of ishare key */
+	__u8 reserved[2];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index e80b35db18e4..3ebbb7c5d085 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -167,6 +167,11 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* inode page cache share support */
+	u8 ishare_key_start;
+	u8 ishare_key_idx;
+	char *ishare_key;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -236,6 +241,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
+EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0d88c04684b9..3561473cb789 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -339,7 +339,7 @@ static int erofs_read_superblock(struct super_block *sb)
 			return -EFSCORRUPTED;	/* self-loop detection */
 	}
 	sbi->inos = le64_to_cpu(dsb->inos);
-
+	sbi->ishare_key_start = dsb->ishare_key_start;
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
@@ -738,6 +738,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_xattr_set_ishare_key(sb);
+	if (err)
+		return err;
 	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..3c99091f39a5 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -564,3 +564,29 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 #endif
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+int erofs_xattr_set_ishare_key(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_xattr_prefix_item *pf;
+	char *ishare_key;
+
+	if (!sbi->xattr_prefixes ||
+	    !(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX))
+		return 0;
+
+	pf = sbi->xattr_prefixes +
+		(sbi->ishare_key_start & EROFS_XATTR_LONG_PREFIX_MASK);
+	if (!pf || pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+		return 0;
+	ishare_key = kmalloc(pf->infix_len + 1, GFP_KERNEL);
+	if (!ishare_key)
+		return -ENOMEM;
+	memcpy(ishare_key, pf->prefix->infix, pf->infix_len);
+	ishare_key[pf->infix_len] = '\0';
+	sbi->ishare_key = ishare_key;
+	sbi->ishare_key_idx = pf->prefix->base_index;
+	return 0;
+}
+#endif
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 6317caa8413e..21684359662c 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -67,4 +67,10 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
 #define erofs_get_acl	(NULL)
 #endif
 
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+int erofs_xattr_set_ishare_key(struct super_block *sb);
+#else
+static inline int erofs_xattr_set_ishare_key(struct super_block *sb) { return 0; }
+#endif
+
 #endif
-- 
2.22.0


