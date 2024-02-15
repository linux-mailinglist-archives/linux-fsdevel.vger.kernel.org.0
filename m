Return-Path: <linux-fsdevel+bounces-11683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C17855FD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5C928392E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2A12CDBC;
	Thu, 15 Feb 2024 10:36:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1B7133410;
	Thu, 15 Feb 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993369; cv=none; b=kplTboY1++D3hw41nqlzbt6ywMOK2DFylgwooFmGKXFQKoHBcK4BCPUJXis01wyqqgFVdYFh4+O4D/BbCqB9N0xfkgdbcGE0dZ7MiI/8Pm4vxafHighUHY08+lSw+adF5a/mIUXI50eaH4rPbocqnCYZhLiynqlr3r0YxAtfPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993369; c=relaxed/simple;
	bh=FRkDuKYrn+JaUiHkO/hEV0XA6Yl+4fzxz0tmqhKImvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vp3UgJXpUmkA8TTnkospzVA7J1PK6b8aVE5RQdk51AttVqQAy5zjuSjSIR2pCXSfBQJY1kTFsPmofBBcZn+K8A6DVOFTw45GnbECH2pwI4PhVHJNdlTIKFOUo/+7WaocBFdExAhWKBaoffJu61lm/Yypgz1WKDNNax8kg4oC9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbB0c6bbnz9yB7M;
	Thu, 15 Feb 2024 18:20:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4AA771405A2;
	Thu, 15 Feb 2024 18:35:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxjQ6M1l4QeNAg--.58293S5;
	Thu, 15 Feb 2024 11:35:53 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 13/25] security: Introduce file_release hook
Date: Thu, 15 Feb 2024 11:31:01 +0100
Message-Id: <20240215103113.2369171-14-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwA3LxjQ6M1l4QeNAg--.58293S5
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUGr4fGFWUKw15Ar1UJrb_yoW5try7pF
	Z8t3WUGFW5JF17Wrn7Aa9rua4Sg393Kr9rWrZ5W34rtF1DJr9YgFsxCr1DuF1DJrW8Jr10
	q3W2grW3Gr1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5pfYgAAsd

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the file_release hook.

IMA calculates at file close the new digest of the file content and writes
it to security.ima, so that appraisal at next file access succeeds.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/file_table.c               |  1 +
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  4 ++++
 security/security.c           | 11 +++++++++++
 4 files changed, 17 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index b991f90571b4..725407f374fa 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -367,6 +367,7 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
+	security_file_release(file);
 	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 3c84942d2818..7f9e9240606e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -173,6 +173,7 @@ LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
 	 struct kernfs_node *kn)
 LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
 LSM_HOOK(int, 0, file_alloc_security, struct file *file)
+LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
diff --git a/include/linux/security.h b/include/linux/security.h
index 97f2212c13b6..2997348afcb7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -395,6 +395,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
+void security_file_release(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
@@ -1008,6 +1009,9 @@ static inline int security_file_alloc(struct file *file)
 	return 0;
 }
 
+static inline void security_file_release(struct file *file)
+{ }
+
 static inline void security_file_free(struct file *file)
 { }
 
diff --git a/security/security.c b/security/security.c
index 5b442032c273..145e3141339c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2719,6 +2719,17 @@ int security_file_alloc(struct file *file)
 	return rc;
 }
 
+/**
+ * security_file_release() - Perform actions before releasing the file ref
+ * @file: the file
+ *
+ * Perform actions before releasing the last reference to a file.
+ */
+void security_file_release(struct file *file)
+{
+	call_void_hook(file_release, file);
+}
+
 /**
  * security_file_free() - Free a file's LSM blob
  * @file: the file
-- 
2.34.1


