Return-Path: <linux-fsdevel+bounces-75069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGH6LzxIcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:54:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2135B6949F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CE130078DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0CE4A5B1D;
	Thu, 22 Jan 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SuX4+bfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA742982A;
	Thu, 22 Jan 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096847; cv=none; b=RW1Ulflj3jfNV842F8dCQak5E71qAEcBfFZuQSTQ0xsHEsbzyy2eX53JOfXSFdGYT/3dzlEXkTibMdTWNWdvFsb6P5ul/Ew5Dv/MQvOpopzUngNkzjWTGTdsvKL94FrF498jcNNEU63ot+cMEaQKPHkU8GHl2QXob2OdR+Nx3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096847; c=relaxed/simple;
	bh=67NwvDdGZwISf0gpEtHKyP1sL9DL0moeJeKG2LuzblQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQGJZcDbkjaxYcL/Bd7gLZWHd7wT3ZUG9R0OcMPASjNN4sB5/pfr7WWmsSrlYHmwJBC/hNwA/MMYMXD7LQaDB0UM60ONR+uFARYjZFGf1A9SzseXsMzh3vwkPZvaMi/D22oyqaBp7B0lZVhSMpOC/DPya0q0w0n2HxiFlO6LoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SuX4+bfN; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YctZCX1tgE5I2CELmBJAleQs1uz92/+EoyicgNnJ3Ig=;
	b=SuX4+bfNd8ZMmGrLa/zyp9y33n41wpel+lqfm0R/Mqb+AZY4drP6t6Yl2+Re/M4cfy6xNfSkj
	I3+d69Lo8bIrWs9ehILwiAhYEmVM8brYCDwFoDwQPOmM9abdzxoR33kHWOreF+PA5/q53wUwj2d
	4uZbc/8R69XAk7uMr150XbU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dxlhr0WGrz1cypK;
	Thu, 22 Jan 2026 23:43:40 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C9F740563;
	Thu, 22 Jan 2026 23:47:04 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 23:47:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v17 04/10] erofs: add erofs_inode_set_aops helper to set the aops
Date: Thu, 22 Jan 2026 15:34:00 +0000
Message-ID: <20260122153406.660073-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260122153406.660073-1-lihongbo22@huawei.com>
References: <20260122153406.660073-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75069-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2135B6949F
X-Rspamd-Action: no action

Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops
to make it cleaner.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/inode.c    | 24 +-----------------------
 fs/erofs/internal.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index bce98c845a18..202cbbb4eada 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -203,7 +203,6 @@ static int erofs_read_inode(struct inode *inode)
 
 static int erofs_fill_inode(struct inode *inode)
 {
-	struct erofs_inode *vi = EROFS_I(inode);
 	int err;
 
 	trace_erofs_fill_inode(inode);
@@ -235,28 +234,7 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-#ifdef CONFIG_EROFS_FS_ZIP
-		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
-			  erofs_info, inode->i_sb,
-			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
-		inode->i_mapping->a_ops = &z_erofs_aops;
-#else
-		err = -EOPNOTSUPP;
-#endif
-	} else {
-		inode->i_mapping->a_ops = &erofs_aops;
-#ifdef CONFIG_EROFS_FS_ONDEMAND
-		if (erofs_is_fscache_mode(inode->i_sb))
-			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-#endif
-#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
-		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
-			inode->i_mapping->a_ops = &erofs_fileio_aops;
-#endif
-	}
-
-	return err;
+	return erofs_inode_set_aops(inode, inode, false);
 }
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ec79e8b44d3b..13b66564057a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -455,6 +455,32 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
+static inline int erofs_inode_set_aops(struct inode *inode,
+				       struct inode *realinode, bool no_fscache)
+{
+	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
+#ifdef CONFIG_EROFS_FS_ZIP
+		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
+			  erofs_info, realinode->i_sb,
+			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		inode->i_mapping->a_ops = &z_erofs_aops;
+#else
+		return -EOPNOTSUPP;
+#endif
+	} else {
+		inode->i_mapping->a_ops = &erofs_aops;
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		if (!no_fscache && erofs_is_fscache_mode(realinode->i_sb))
+			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+#endif
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
+			inode->i_mapping->a_ops = &erofs_fileio_aops;
+#endif
+	}
+	return 0;
+}
+
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
-- 
2.22.0


