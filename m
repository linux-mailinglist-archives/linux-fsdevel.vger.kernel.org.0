Return-Path: <linux-fsdevel+bounces-55926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75EB10238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D89C188A878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A1E26C396;
	Thu, 24 Jul 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5ShvM6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31597261B
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343340; cv=none; b=dBNLIHF1ipYCnGTetxy5e0kfcUErXQ+Lu/2EuxyCziOubey7Y8CH0kMGqnaJVCfyJ/SKaxCGXDeHv3d101/Fyfy6MWPsJKCgmUT4/NtHF7Luq7quxi3UlXaW4EFcLOPNdD2DkvCtDL+CgFKYnVqnq8qNqmg/E/K2NnJbabiUAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343340; c=relaxed/simple;
	bh=euVfqUQJnBYOXi6T5uD17zQleKoAIGnzUNsi8NvTSRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hnwn11zYcDwoh43vXbC0KpCEvJLdHS1vEYZoTdoo6+oSBW1LG98QRPX8r+RZlsbE7L6ZYzRm6hhiTUB4KOeFk+Z37oN7V/kRZug7GEPQ7LLkSMSQLtGMyDnNzplr9608uTl5YtK3evupIMlJSLfto/cCGlx33FK48nhuwHX+7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s5ShvM6N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2PPSILEoqTqD2FV/FafcJaOyfxL3DImrBPsj2nFRxXI=; b=s5ShvM6NyDPP3k1vJGQEomCqzb
	qmoWYBVTWlFjX8rchYVyaNSQdbfx/iBTAM0aWfCsa5W8vQUftxBbt6MlISfyDWxlTwpkO4E4i+Aj9
	hHemtRn+ah54crKZCiXgjRhQ/wcseKquS9xINbZML4JcUX8MZP0DnJnWgYDSvvAqRV85+TbFWGOQa
	SoC+BuzsmuDdFL5tG+o9mcpg9tSrBuhpqgarXyAgIV0XIycOX8o2afHguL3HCJz0QghAMHBCP4HR/
	K5xean8Gy2KBfyRDSKodYwxhu8fYFOSA/R9JmXY3e8Od+ctgcwq7YQhdG7Gdnr8lt0k3d1iloOIHs
	HPF3RtTw==;
Received: from [2001:67c:1232:144:a1d2:d12d:cb2d:5181] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueqhE-00000006kKK-3z2m;
	Thu, 24 Jul 2025 07:48:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: mark file_remove_privs_flags static
Date: Thu, 24 Jul 2025 09:48:54 +0200
Message-ID: <20250724074854.3316911-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

file_remove_privs_flags is only used inside of inode.c, mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/inode.c         | 3 +--
 include/linux/fs.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a..14abe12865e3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2190,7 +2190,7 @@ static int __remove_privs(struct mnt_idmap *idmap,
 	return notify_change(idmap, dentry, &newattrs, NULL);
 }
 
-int file_remove_privs_flags(struct file *file, unsigned int flags)
+static int file_remove_privs_flags(struct file *file, unsigned int flags)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = file_inode(file);
@@ -2215,7 +2215,6 @@ int file_remove_privs_flags(struct file *file, unsigned int flags)
 		inode_has_no_xattr(inode);
 	return error;
 }
-EXPORT_SYMBOL_GPL(file_remove_privs_flags);
 
 /**
  * file_remove_privs - remove special file privileges (suid, capabilities)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 040c0036320f..b57e4c3996a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3366,7 +3366,6 @@ static inline struct inode *new_inode_pseudo(struct super_block *sb)
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
-extern int file_remove_privs_flags(struct file *file, unsigned int flags);
 extern int file_remove_privs(struct file *);
 int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode);
-- 
2.47.2


