Return-Path: <linux-fsdevel+bounces-67827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478BC4BE79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADC03BB07A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6432E3563FF;
	Tue, 11 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bU5nMRV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243534B678;
	Tue, 11 Nov 2025 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844135; cv=none; b=d4STWkSThf3R5JYiQam6UO8nboNQB0l9gQ2yo8luga5YUVqIqH+aPufs/SAHLXENXXOSM2S0m4pZOidbQPCMDY3AfDyu/ixCBi1/ylzReO8YqK9kK86kWacSajRcToRmrddKCT3r3GU2AC61y/aFD9QZDRvQbYU72s3YaXJzaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844135; c=relaxed/simple;
	bh=9AS75eVlweTY+v6fpHuTI3Q7t//pHwL//inAnhQncd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/4j3OFrnEXpSg4kOP7ksyolLqK38/7+TE+1ybIhzYJrt/in8jJe0/pVSWXY5TvkNJEbRXomt5nIa4zJhM4lLYLPUwGBaSBXwzttH+hzqvmw5t3W4wZ0K2uipCZfaa95YrlIYdnFUxnsiJ7EE1Om09o8P+sYhig3ZQtwdxaaz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bU5nMRV1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NrCfZqIGx2QtH4dFK91zKO0X/du0eTzDDHu7mpHeJ3A=; b=bU5nMRV1HYIpzFuIj1mxnQVWFT
	n5MlL7sdQ4oFxAKmM3zgYB4MJa1s+CqH9ZNp8B+3Ya1Sk2/4un/w7RJ19EUnMyzYfuYu8qrRk7hcH
	oTDp3KIiXF4tCG8m0sjz7UOahMqzTzhzG7KRPXSFEHjjYQ7qLr/gKVI236b2dFyvffsabXoyb4psw
	DkIWYkpSFC7pByhnnBnQBOGDNjxrUmDbOap+jvLg8ryyflfD/qsK/ZwW54E6ih9xa+6z61jLA2jER
	FCKsCM4k6ydDGoxsiMGR9KTlQ7i744lbTyMfdrz3LAoDhXJaikJo4uOoFBfg8DLTBoPqaoI0tbfsP
	CK5V/4YA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHp-0000000BxBh-2EXa;
	Tue, 11 Nov 2025 06:55:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v3 41/50] hypfs: switch hypfs_create_str() to returning int
Date: Tue, 11 Nov 2025 06:55:10 +0000
Message-ID: <20251111065520.2847791-42-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Every single caller only cares about PTR_ERR_OR_ZERO() of return value...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/hypfs/hypfs.h         |  3 +--
 arch/s390/hypfs/hypfs_diag_fs.c | 40 +++++++++------------------------
 arch/s390/hypfs/hypfs_vm_fs.c   |  6 ++---
 arch/s390/hypfs/inode.c         |  9 ++++----
 4 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/arch/s390/hypfs/hypfs.h b/arch/s390/hypfs/hypfs.h
index 4dc2e068e0ff..0d109d956015 100644
--- a/arch/s390/hypfs/hypfs.h
+++ b/arch/s390/hypfs/hypfs.h
@@ -25,8 +25,7 @@ extern struct dentry *hypfs_mkdir(struct dentry *parent, const char *name);
 extern struct dentry *hypfs_create_u64(struct dentry *dir, const char *name,
 				       __u64 value);
 
-extern struct dentry *hypfs_create_str(struct dentry *dir, const char *name,
-				       char *string);
+extern int hypfs_create_str(struct dentry *dir, const char *name, char *string);
 
 /* LPAR Hypervisor */
 extern int hypfs_diag_init(void);
diff --git a/arch/s390/hypfs/hypfs_diag_fs.c b/arch/s390/hypfs/hypfs_diag_fs.c
index ede951dc0085..2178e6060a5d 100644
--- a/arch/s390/hypfs/hypfs_diag_fs.c
+++ b/arch/s390/hypfs/hypfs_diag_fs.c
@@ -228,8 +228,7 @@ static int hypfs_create_cpu_files(struct dentry *cpus_dir, void *cpu_info)
 			return PTR_ERR(rc);
 	}
 	diag224_idx2name(cpu_info__ctidx(diag204_get_info_type(), cpu_info), buffer);
-	rc = hypfs_create_str(cpu_dir, "type", buffer);
-	return PTR_ERR_OR_ZERO(rc);
+	return hypfs_create_str(cpu_dir, "type", buffer);
 }
 
 static void *hypfs_create_lpar_files(struct dentry *systems_dir, void *part_hdr)
@@ -276,8 +275,7 @@ static int hypfs_create_phys_cpu_files(struct dentry *cpus_dir, void *cpu_info)
 	if (IS_ERR(rc))
 		return PTR_ERR(rc);
 	diag224_idx2name(phys_cpu__ctidx(diag204_get_info_type(), cpu_info), buffer);
-	rc = hypfs_create_str(cpu_dir, "type", buffer);
-	return PTR_ERR_OR_ZERO(rc);
+	return hypfs_create_str(cpu_dir, "type", buffer);
 }
 
 static void *hypfs_create_phys_files(struct dentry *parent_dir, void *phys_hdr)
@@ -316,41 +314,25 @@ int hypfs_diag_create_files(struct dentry *root)
 		return rc;
 
 	systems_dir = hypfs_mkdir(root, "systems");
-	if (IS_ERR(systems_dir)) {
-		rc = PTR_ERR(systems_dir);
-		goto err_out;
-	}
+	if (IS_ERR(systems_dir))
+		return PTR_ERR(systems_dir);
 	time_hdr = (struct x_info_blk_hdr *)buffer;
 	part_hdr = time_hdr + info_blk_hdr__size(diag204_get_info_type());
 	for (i = 0; i < info_blk_hdr__npar(diag204_get_info_type(), time_hdr); i++) {
 		part_hdr = hypfs_create_lpar_files(systems_dir, part_hdr);
-		if (IS_ERR(part_hdr)) {
-			rc = PTR_ERR(part_hdr);
-			goto err_out;
-		}
+		if (IS_ERR(part_hdr))
+			return PTR_ERR(part_hdr);
 	}
 	if (info_blk_hdr__flags(diag204_get_info_type(), time_hdr) &
 	    DIAG204_LPAR_PHYS_FLG) {
 		ptr = hypfs_create_phys_files(root, part_hdr);
-		if (IS_ERR(ptr)) {
-			rc = PTR_ERR(ptr);
-			goto err_out;
-		}
+		if (IS_ERR(ptr))
+			return PTR_ERR(ptr);
 	}
 	hyp_dir = hypfs_mkdir(root, "hyp");
-	if (IS_ERR(hyp_dir)) {
-		rc = PTR_ERR(hyp_dir);
-		goto err_out;
-	}
-	ptr = hypfs_create_str(hyp_dir, "type", "LPAR Hypervisor");
-	if (IS_ERR(ptr)) {
-		rc = PTR_ERR(ptr);
-		goto err_out;
-	}
-	rc = 0;
-
-err_out:
-	return rc;
+	if (IS_ERR(hyp_dir))
+		return PTR_ERR(hyp_dir);
+	return hypfs_create_str(hyp_dir, "type", "LPAR Hypervisor");
 }
 
 /* Diagnose 224 functions */
diff --git a/arch/s390/hypfs/hypfs_vm_fs.c b/arch/s390/hypfs/hypfs_vm_fs.c
index 6011289afa8c..e8a32d66062b 100644
--- a/arch/s390/hypfs/hypfs_vm_fs.c
+++ b/arch/s390/hypfs/hypfs_vm_fs.c
@@ -100,11 +100,9 @@ int hypfs_vm_create_files(struct dentry *root)
 		rc = PTR_ERR(dir);
 		goto failed;
 	}
-	file = hypfs_create_str(dir, "type", "z/VM Hypervisor");
-	if (IS_ERR(file)) {
-		rc = PTR_ERR(file);
+	rc = hypfs_create_str(dir, "type", "z/VM Hypervisor");
+	if (rc)
 		goto failed;
-	}
 
 	/* physical cpus */
 	dir = hypfs_mkdir(root, "cpus");
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index a4dc8e13d999..c5e2d8932b88 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -398,24 +398,23 @@ struct dentry *hypfs_create_u64(struct dentry *dir,
 	return dentry;
 }
 
-struct dentry *hypfs_create_str(struct dentry *dir,
-				const char *name, char *string)
+int hypfs_create_str(struct dentry *dir, const char *name, char *string)
 {
 	char *buffer;
 	struct dentry *dentry;
 
 	buffer = kmalloc(strlen(string) + 2, GFP_KERNEL);
 	if (!buffer)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	sprintf(buffer, "%s\n", string);
 	dentry =
 	    hypfs_create_file(dir, name, buffer, S_IFREG | REG_FILE_MODE);
 	if (IS_ERR(dentry)) {
 		kfree(buffer);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 	hypfs_add_dentry(dentry);
-	return dentry;
+	return 0;
 }
 
 static const struct file_operations hypfs_file_ops = {
-- 
2.47.3


