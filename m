Return-Path: <linux-fsdevel+bounces-51383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB28AD65F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B66B1BC2022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E21F09A8;
	Thu, 12 Jun 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JA8gmvYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591F1DE2CC;
	Thu, 12 Jun 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697919; cv=none; b=lcgJB7CtXGslsjAMIBJz/PYmSgR0vSpGWCqLEA5CxGPbCJLj2XConZyZjGFAncY0KPzZDz3A5Mln+1DPlcIh5KuqUtR0ya94Zrt6VkZIcK50Oeer7jO8aYmKAbExs6zwgvEJVUwUoCz2zUjqBMCRZPdmZJwe8UAL4jUGuMnvvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697919; c=relaxed/simple;
	bh=239VQReSz+oAY5L4KC/BF6QLIHmMnN734GvLH0VxsQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tecaWqmqLtzZahtNuXpAO47SuD/rUBcFo/TORR/e+1O/Dp/Gahc1clahav+/txtrj1zifTxNEYJG2hVeEaCLnmuqYOKYCEAWftiq9DvdvwHHfYjPPHudTlOpYQ+DqE/FIlPDmqupTst1umrNj5z/vtQumVSGn3iG5y5N20roE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JA8gmvYT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ITiwp5uY8VxEqLH8rjQ96GREe8X9tiaVH2XlRGNXkvE=; b=JA8gmvYTCvHmIaiDFew3R4csHL
	3SmexntvxLi02pcF8DIIF/T+fl2F+Uj57Yt254B8eBolAF+iXS7SVps8kZnjkAw7UIaXF9z2laShr
	UjKK2Z9Glag6Fbtqjy2L76kXHkzYY3KQaDQdpCEubt9g6VuZjlpyq+KC3lFsRpEITAu5Gv6COb/dN
	3tnGqqEtUMOMlbjf/4/CmyS8ZHqpVUcn9G2J7Q1Lv254lfxFivRp/6Yhj+aaf7ikP+7WH1+wY2Zv8
	hbQuZU1HJGFCThTKVriiiaYf1bZZSmGxwxLR5aZnHOg+USJ9mkyFc4VjgQSvMdWXt41tahQHUK0hu
	Ktx66tJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gez-1fnc;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 05/10] efi_secret: clean securityfs use up
Date: Thu, 12 Jun 2025 04:11:49 +0100
Message-ID: <20250612031154.2308915-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
References: <20250612030951.GC1647736@ZenIV>
 <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

securityfs_remove() does take care of entire subtree now; no need
to mess with them individually.

NB: ->i_op replacement in there is still buggy.  One shouldn't
ever modify ->i_op of live accessible inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/virt/coco/efi_secret/efi_secret.c | 37 +++++------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
index f2da4819ec3b..5946c5abeae8 100644
--- a/drivers/virt/coco/efi_secret/efi_secret.c
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -31,8 +31,6 @@
 
 struct efi_secret {
 	struct dentry *secrets_dir;
-	struct dentry *fs_dir;
-	struct dentry *fs_files[EFI_SECRET_NUM_FILES];
 	void __iomem *secret_data;
 	u64 secret_data_len;
 };
@@ -119,10 +117,8 @@ static void wipe_memory(void *addr, size_t size)
 
 static int efi_secret_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct efi_secret *s = efi_secret_get();
 	struct inode *inode = d_inode(dentry);
 	struct secret_entry *e = (struct secret_entry *)inode->i_private;
-	int i;
 
 	if (e) {
 		/* Zero out the secret data */
@@ -132,10 +128,6 @@ static int efi_secret_unlink(struct inode *dir, struct dentry *dentry)
 
 	inode->i_private = NULL;
 
-	for (i = 0; i < EFI_SECRET_NUM_FILES; i++)
-		if (s->fs_files[i] == dentry)
-			s->fs_files[i] = NULL;
-
 	return simple_unlink(inode, dentry);
 }
 
@@ -186,15 +178,6 @@ static int efi_secret_map_area(struct platform_device *dev)
 static void efi_secret_securityfs_teardown(struct platform_device *dev)
 {
 	struct efi_secret *s = efi_secret_get();
-	int i;
-
-	for (i = (EFI_SECRET_NUM_FILES - 1); i >= 0; i--) {
-		securityfs_remove(s->fs_files[i]);
-		s->fs_files[i] = NULL;
-	}
-
-	securityfs_remove(s->fs_dir);
-	s->fs_dir = NULL;
 
 	securityfs_remove(s->secrets_dir);
 	s->secrets_dir = NULL;
@@ -209,7 +192,7 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 	unsigned char *ptr;
 	struct secret_header *h;
 	struct secret_entry *e;
-	struct dentry *dent;
+	struct dentry *dent, *dir;
 	char guid_str[EFI_VARIABLE_GUID_LEN + 1];
 
 	ptr = (void __force *)s->secret_data;
@@ -232,8 +215,6 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 	}
 
 	s->secrets_dir = NULL;
-	s->fs_dir = NULL;
-	memset(s->fs_files, 0, sizeof(s->fs_files));
 
 	dent = securityfs_create_dir("secrets", NULL);
 	if (IS_ERR(dent)) {
@@ -243,14 +224,13 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 	}
 	s->secrets_dir = dent;
 
-	dent = securityfs_create_dir("coco", s->secrets_dir);
-	if (IS_ERR(dent)) {
+	dir = securityfs_create_dir("coco", s->secrets_dir);
+	if (IS_ERR(dir)) {
 		dev_err(&dev->dev, "Error creating coco securityfs directory entry err=%ld\n",
-			PTR_ERR(dent));
-		return PTR_ERR(dent);
+			PTR_ERR(dir));
+		return PTR_ERR(dir);
 	}
-	d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
-	s->fs_dir = dent;
+	d_inode(dir)->i_op = &efi_secret_dir_inode_operations;
 
 	bytes_left = h->len - sizeof(*h);
 	ptr += sizeof(*h);
@@ -266,15 +246,14 @@ static int efi_secret_securityfs_setup(struct platform_device *dev)
 		if (efi_guidcmp(e->guid, NULL_GUID)) {
 			efi_guid_to_str(&e->guid, guid_str);
 
-			dent = securityfs_create_file(guid_str, 0440, s->fs_dir, (void *)e,
+			dent = securityfs_create_file(guid_str, 0440, dir, (void *)e,
 						      &efi_secret_bin_file_fops);
 			if (IS_ERR(dent)) {
 				dev_err(&dev->dev, "Error creating efi_secret securityfs entry\n");
 				ret = PTR_ERR(dent);
 				goto err_cleanup;
 			}
-
-			s->fs_files[i++] = dent;
+			i++;
 		}
 		ptr += e->len;
 		bytes_left -= e->len;
-- 
2.39.5


