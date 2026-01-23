Return-Path: <linux-fsdevel+bounces-75237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDUIJZMsc2mTswAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:08:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471F7236A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0D0301CFB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79923A98D;
	Fri, 23 Jan 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pz2se/Fi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A432BDC1B;
	Fri, 23 Jan 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155538; cv=none; b=fRM1ch2mZpJHOCCguI99kJ7VsT0hQskQDIEe6tVXUxvS65EAQo8w30dpdSeuiOi29sKtBBqWCUjNHqyiIGtvLQptxUn1xm2UZumzSk70vDdsupXtxrpss1Bdj3xmYtgsU4HzCvO8zzWMD7gS7ojnNzoQDgQ2Nm7GBbrLxOaIPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155538; c=relaxed/simple;
	bh=eQvLqmNFHOqaWc8sfh7VZHffM7vCD8SzJxoFsh6ouTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkhpayL5WAFlnyzTuah3raYqSmAz+KYMBDT7kmhzsRIwPHnUHJUCM6QC0xZe0y8Uz6dKyCmfYWlubgl21wUl455jaybik4dBZPqayipKbhM+L/poRYv5+Px8o37k3+IImchNYL8Z/d7QUaDzsIl53veagYrCnvwt4mTE19obbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pz2se/Fi; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N8kBUN8O+wcXEbmTE8rSX4uHp1tFEBs7iyg4eXensaY=;
	b=pz2se/Fi3OhjcictbMjtROCxS5dsQLgVoiyzg+nD/YKjIZbITmWxTdwjZdQT6PdqpN2CRhq4o
	XmORjPIxhmxzokVND6tdoTzcQ37JFGAszv8rg1CBSGXbs0szBCKgxQER2WBzy17WFA9U7HRaixQ
	YCSalhjsEwWvFxhLcObt6Rc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dy9Pp0tlkz1prL0;
	Fri, 23 Jan 2026 16:02:06 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 046CE40537;
	Fri, 23 Jan 2026 16:05:33 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 16:05:32 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <brauner@kernel.org>, <chao@kernel.org>, <hsiangkao@linux.alibaba.com>
CC: <lihongbo22@huawei.com>, <amir73il@gmail.com>, <djwong@kernel.org>,
	<hch@lst.de>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 04/10] erofs: add erofs_inode_set_aops helper to set the aops
Date: Fri, 23 Jan 2026 07:52:39 +0000
Message-ID: <20260123075239.664330-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260123013132.662393-5-lihongbo22@huawei.com>
References: <20260123013132.662393-5-lihongbo22@huawei.com>
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
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,kernel.org,lst.de,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-75237-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1471F7236A
X-Rspamd-Action: no action

Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops
and use IS_ENABLED to make it cleaner.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/inode.c    | 24 +-----------------------
 fs/erofs/internal.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

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
index ec79e8b44d3b..48bc52f95358 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -455,6 +455,28 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
+static inline int erofs_inode_set_aops(struct inode *inode,
+				       struct inode *realinode, bool no_fscache)
+{
+	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
+		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
+			return -EOPNOTSUPP;
+		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
+			  erofs_info, realinode->i_sb,
+			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		inode->i_mapping->a_ops = &z_erofs_aops;
+		return 0;
+	}
+	inode->i_mapping->a_ops = &erofs_aops;
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
+	    erofs_is_fscache_mode(realinode->i_sb))
+		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
+	    erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
+		inode->i_mapping->a_ops = &erofs_fileio_aops;
+	return 0;
+}
+
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
-- 
2.22.0


