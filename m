Return-Path: <linux-fsdevel+bounces-51387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8CAD6604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B277E17B248
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686B1F5435;
	Thu, 12 Jun 2025 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BZYc8us4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06E1DE2A8;
	Thu, 12 Jun 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697919; cv=none; b=NgburRki9dLhNTVzmp6XVLFbz/ZCQkHJKKgAiQijw5rXv9P01dnuB7Lh/EWLWzMEwj8hUaRwPoFzpntapLVkI8bBYNwzUBIstGCnSl+WCfioEv0xEuC+mPimjtKhRLL0HJuq20y4Bg6nn4Jf2/yyfNXJdSiWzhjDyb2Qd/hBXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697919; c=relaxed/simple;
	bh=FFDYIux3OwOBCA5/nYtTbyT6BsdKSiSJ6f6eXmAg4ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiFNvTfxnY6Eg39bpdqM+YmcXKWrn+/YeuO+DlBttywQ06ul/UNwPokxBWTXXE4gE/JLwOujj34tV7622zcVoyj9yVxrdTj+jsZZmHTFbEf9NWeHXX0iakB69wMILJ0oRtRRZMDStlyiPMu/g7avdmedhB0CCDKibCipCMoGdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BZYc8us4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ovB91mmxcmIQL/7mGBfaJ+3qIRZik7CGja3YGnuksGI=; b=BZYc8us4newN9NKgpTJzEoyLFX
	VTTLbhU7acmHE2UzSO1j9Siy94OfWuUN/apYFgKuUlIET6ynOJe+6pDFPdMCrdh6Ini3rjU5J5YH5
	Xd2Juq/I5ThqbQ4B02X+412EUqH+ikJG85bNP5M368S4RzwHZbOmrzkKFb3xIJ8bUuoyYCEQIJKec
	5Ul/556VftYh0r8OSxet+f/268ilhAW41HZU0fydn6X38+9hiXTb8VKzdYak+PygIr6tcKbCKa8t0
	/FIM4y9EpctwOM7KWixYW+izNY+5Wwlr6B/k64ZmsdpwSbog3a8OgfytygYZnoFxtGfufw1AwOWq0
	QFSzWahw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gf2-1si6;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 06/10] ima_fs: don't bother with removal of files in directory we'll be removing
Date: Thu, 12 Jun 2025 04:11:50 +0100
Message-ID: <20250612031154.2308915-6-viro@zeniv.linux.org.uk>
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

removal of parent takes all children out

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/integrity/ima/ima_fs.c | 57 +++++++++++----------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e4a79a9b2d58..88421e8895c4 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -396,11 +396,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 
 static struct dentry *ima_dir;
 static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -419,14 +414,7 @@ static const struct seq_operations ima_policy_seqops = {
 
 static void __init remove_securityfs_measurement_lists(struct dentry **lists)
 {
-	int i;
-
-	if (lists) {
-		for (i = 0; i < securityfs_measurement_list_count; i++)
-			securityfs_remove(lists[i]);
-
-		kfree(lists);
-	}
+	kfree(lists);
 }
 
 static int __init create_securityfs_measurement_lists(void)
@@ -533,8 +521,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy();
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	securityfs_remove(file->f_path.dentry);
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -553,6 +540,7 @@ static const struct file_operations ima_measure_policy_ops = {
 
 int __init ima_fs_init(void)
 {
+	struct dentry *dentry;
 	int ret;
 
 	ascii_securityfs_measurement_lists = NULL;
@@ -573,54 +561,45 @@ int __init ima_fs_init(void)
 	if (ret != 0)
 		goto out;
 
-	binary_runtime_measurements =
-	    securityfs_create_symlink("binary_runtime_measurements", ima_dir,
+	dentry = securityfs_create_symlink("binary_runtime_measurements", ima_dir,
 				      "binary_runtime_measurements_sha1", NULL);
-	if (IS_ERR(binary_runtime_measurements)) {
-		ret = PTR_ERR(binary_runtime_measurements);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	ascii_runtime_measurements =
-	    securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
+	dentry = securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
 				      "ascii_runtime_measurements_sha1", NULL);
-	if (IS_ERR(ascii_runtime_measurements)) {
-		ret = PTR_ERR(ascii_runtime_measurements);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	runtime_measurements_count =
-	    securityfs_create_file("runtime_measurements_count",
+	dentry = securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
-	if (IS_ERR(runtime_measurements_count)) {
-		ret = PTR_ERR(runtime_measurements_count);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	violations =
-	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
+	dentry = securityfs_create_file("violations", S_IRUSR | S_IRGRP,
 				   ima_dir, NULL, &ima_htable_violations_ops);
-	if (IS_ERR(violations)) {
-		ret = PTR_ERR(violations);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
+	dentry = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy)) {
-		ret = PTR_ERR(ima_policy);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto out;
 	}
 
 	return 0;
 out:
-	securityfs_remove(ima_policy);
-	securityfs_remove(violations);
-	securityfs_remove(runtime_measurements_count);
-	securityfs_remove(ascii_runtime_measurements);
-	securityfs_remove(binary_runtime_measurements);
 	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
 	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
 	securityfs_measurement_list_count = 0;
-- 
2.39.5


