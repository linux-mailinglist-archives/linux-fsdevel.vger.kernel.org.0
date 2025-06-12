Return-Path: <linux-fsdevel+bounces-51385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F669AD6606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FE37ABFAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E371F237A;
	Thu, 12 Jun 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V8Jemjux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E481DE4EC;
	Thu, 12 Jun 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697919; cv=none; b=M06UWfazs68MtnHpNBi8vwG3bzFyQi1ARvmGf/obVTeUms6+fgIzS8zDUnyOtvUJIh+G1MIXMusmXV+TKNWEGiUkXBWCuDisM0rKBJYZi4KHBPig7WukF1SGeLizk78lVZgBeBep7bXUd01VVFmeVULV2FVNR2qmujuDZRItKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697919; c=relaxed/simple;
	bh=Icx60gs6c9PVitmYDGLVXPLXnoYHvxnJMJNP6W2kTU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSJqhpd6bsqR0kTvkMZqLAmsK+F3wV23LqhuV+nJeBg0bE1CAyFFE0tL0WpJXgTrjBIzH4zaj+aYkXqTlX43KydLfKUrR/BboepcFNdtpQnxiSzI5ZB8NgowSt7N+UwVE6BcP71iXUSA12QKoQE8pNI/ARW4CPwOSQAK3RpvLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V8Jemjux; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LCdUAtSZKR7eASwSAF/Qb8kqHEURk17XUmMubbLYiow=; b=V8Jemjux43tbfidv/AH56QB8CK
	ySk4bo7OOKuGim5ijblqfpz/oFPIoPm08lWD+KmSQCyC/0Osybp/FjRCRRDccYB7an4xRI+4qidnM
	Zpe3J9YzzMI8WohUCELIlVyIlWmKnuf491Gqxy8tZds5VzCm6NwdUuPMywx2uT/bXOo0COyTB5xAz
	7ZzYKdNxd7hs3a6AF33TS0pyjrYz22fK6cPgnooZsk1lMvMQnyCIlzHAjWLmXpqb5mPSQMX04ese8
	tpwH3Yuog7HGRed+7quxUFMg85s0slXHEV1GvQOtz9LkC00K8l62i3FFlchoABng7M70sKIv775kR
	JKcSSCzw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gf5-28TL;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 07/10] ima_fs: get rid of lookup-by-dentry stuff
Date: Thu, 12 Jun 2025 04:11:51 +0100
Message-ID: <20250612031154.2308915-7-viro@zeniv.linux.org.uk>
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

lookup_template_data_hash_algo() machinery is used to locate the
matching ima_algo_array[] element at read time; securityfs
allows to stash that into inode->i_private at object creation
time, so there's no need to bother

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/integrity/ima/ima_fs.c | 82 +++++++--------------------------
 1 file changed, 16 insertions(+), 66 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 88421e8895c4..87045b09f120 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,28 +116,6 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 		seq_putc(m, *(char *)data++);
 }
 
-static struct dentry **ascii_securityfs_measurement_lists __ro_after_init;
-static struct dentry **binary_securityfs_measurement_lists __ro_after_init;
-static int securityfs_measurement_list_count __ro_after_init;
-
-static void lookup_template_data_hash_algo(int *algo_idx, enum hash_algo *algo,
-					   struct seq_file *m,
-					   struct dentry **lists)
-{
-	struct dentry *dentry;
-	int i;
-
-	dentry = file_dentry(m->file);
-
-	for (i = 0; i < securityfs_measurement_list_count; i++) {
-		if (dentry == lists[i]) {
-			*algo_idx = i;
-			*algo = ima_algo_array[i].algo;
-			break;
-		}
-	}
-}
-
 /* print format:
  *       32bit-le=pcr#
  *       char[n]=template digest
@@ -160,9 +138,10 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	algo_idx = ima_sha1_idx;
 	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL)
-		lookup_template_data_hash_algo(&algo_idx, &algo, m,
-					       binary_securityfs_measurement_lists);
+	if (m->file != NULL) {
+		algo_idx = (unsigned long)file_inode(m->file)->i_private;
+		algo = ima_algo_array[algo_idx].algo;
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -256,9 +235,10 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	algo_idx = ima_sha1_idx;
 	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL)
-		lookup_template_data_hash_algo(&algo_idx, &algo, m,
-					       ascii_securityfs_measurement_lists);
+	if (m->file != NULL) {
+		algo_idx = (unsigned long)file_inode(m->file)->i_private;
+		algo = ima_algo_array[algo_idx].algo;
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -412,57 +392,33 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
-static void __init remove_securityfs_measurement_lists(struct dentry **lists)
-{
-	kfree(lists);
-}
-
 static int __init create_securityfs_measurement_lists(void)
 {
-	char file_name[NAME_MAX + 1];
-	struct dentry *dentry;
-	u16 algo;
-	int i;
-
-	securityfs_measurement_list_count = NR_BANKS(ima_tpm_chip);
+	int count = NR_BANKS(ima_tpm_chip);
 
 	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
-		securityfs_measurement_list_count++;
+		count++;
 
-	ascii_securityfs_measurement_lists =
-	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
-		    GFP_KERNEL);
-	if (!ascii_securityfs_measurement_lists)
-		return -ENOMEM;
-
-	binary_securityfs_measurement_lists =
-	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
-		    GFP_KERNEL);
-	if (!binary_securityfs_measurement_lists)
-		return -ENOMEM;
-
-	for (i = 0; i < securityfs_measurement_list_count; i++) {
-		algo = ima_algo_array[i].algo;
+	for (int i = 0; i < count; i++) {
+		u16 algo = ima_algo_array[i].algo;
+		char file_name[NAME_MAX + 1];
+		struct dentry *dentry;
 
 		sprintf(file_name, "ascii_runtime_measurements_%s",
 			hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
-						ima_dir, NULL,
+						ima_dir, (void *)(uintptr_t)i,
 						&ima_ascii_measurements_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 
-		ascii_securityfs_measurement_lists[i] = dentry;
-
 		sprintf(file_name, "binary_runtime_measurements_%s",
 			hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
-						ima_dir, NULL,
+						ima_dir, (void *)(uintptr_t)i,
 						&ima_measurements_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
-
-		binary_securityfs_measurement_lists[i] = dentry;
 	}
 
 	return 0;
@@ -543,9 +499,6 @@ int __init ima_fs_init(void)
 	struct dentry *dentry;
 	int ret;
 
-	ascii_securityfs_measurement_lists = NULL;
-	binary_securityfs_measurement_lists = NULL;
-
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return PTR_ERR(ima_dir);
@@ -600,9 +553,6 @@ int __init ima_fs_init(void)
 
 	return 0;
 out:
-	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
-	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
-	securityfs_measurement_list_count = 0;
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
 
-- 
2.39.5


