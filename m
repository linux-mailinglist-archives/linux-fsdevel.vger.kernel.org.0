Return-Path: <linux-fsdevel+bounces-11682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B65855FC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6147A293938
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7112C55E;
	Thu, 15 Feb 2024 10:35:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0512C817;
	Thu, 15 Feb 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993351; cv=none; b=BStdQ+vEWTU6AzKm2rHxiCtu/P5VphLWiHP3hIVx6EobCOKEobyMT+lFW2/oAogBB3q0ju60SwlSFWZ4I72Aawa/p4WMjxwlN22ESdEWGdQ9kAgAA3ISERz6vb3fTQS4xdnipCwvi5OpLNQnN0hcfcj9tzWktqXhY7L2YSQtY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993351; c=relaxed/simple;
	bh=yWcy60M7kP/hgSC/+384mQ/AhJ3cH0hoJw346f2m0hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irKgcLed3Lf8MpGdvpXtLbhAH8K5EQMUgMaOfRKxTFsiW+lVe3+Uy6K2FIzNF86/d1bnXxuT1AkmTLENN1WOqxxmmUoY8SX8iB0hiP+VUD5Is6CfY/kA81csue1zid8NMr3gyeID4slxYss0Ag9A4sTHEVgBwIfPySjIuGeFYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TbB0F05L5z9yTLW;
	Thu, 15 Feb 2024 18:20:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5BA981406BE;
	Thu, 15 Feb 2024 18:35:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxjQ6M1l4QeNAg--.58293S4;
	Thu, 15 Feb 2024 11:35:39 +0100 (CET)
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
Subject: [PATCH v10 12/25] security: Introduce file_post_open hook
Date: Thu, 15 Feb 2024 11:31:00 +0100
Message-Id: <20240215103113.2369171-13-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwA3LxjQ6M1l4QeNAg--.58293S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xGF4DKw4kCrW7Kr17Wrg_yoWrurW8pF
	ZYy3WUGFW8GFy7Wrn7AF47ua4Sg39agryUWFZ5W3s0yF1vqrnYgFs0yr1Ykr15JrZ5JFyI
	q3Wa9rW3Cr1DZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
	CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbp6wtUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf2AAAso

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation to move IMA and EVM to the LSM infrastructure, introduce the
file_post_open hook. Also, export security_file_post_open() for NFS.

Based on policy, IMA calculates the digest of the file content and
extends the TPM with the digest, verifies the file's integrity based on
the digest, and/or includes the file digest in the audit log.

LSMs could similarly take action depending on the file content and the
access mask requested with open().

The new hook returns a value and can cause the open to be aborted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c                    |  2 ++
 fs/nfsd/vfs.c                 |  6 ++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 17 +++++++++++++++++
 5 files changed, 32 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 4e0de939fea1..ef867f1d6704 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3639,6 +3639,8 @@ static int do_open(struct nameidata *nd,
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
+	if (!error)
+		error = security_file_post_open(file, op->acc_mode);
 	if (!error)
 		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b7c7a9273ea0..e44d8239545b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -877,6 +877,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out;
 	}
 
+	host_err = security_file_post_open(file, may_flags);
+	if (host_err) {
+		fput(file);
+		goto out;
+	}
+
 	host_err = ima_file_check(file, may_flags);
 	if (host_err) {
 		fput(file);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f849f7d5bb53..3c84942d2818 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -191,6 +191,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
 LSM_HOOK(int, 0, file_open, struct file *file)
+LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
 LSM_HOOK(int, 0, file_truncate, struct file *file)
 LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
 	 unsigned long clone_flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 84ae03690340..97f2212c13b6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -411,6 +411,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+int security_file_post_open(struct file *file, int mask);
 int security_file_truncate(struct file *file);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
@@ -1074,6 +1075,11 @@ static inline int security_file_open(struct file *file)
 	return 0;
 }
 
+static inline int security_file_post_open(struct file *file, int mask)
+{
+	return 0;
+}
+
 static inline int security_file_truncate(struct file *file)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 0f0f2c11ef73..5b442032c273 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2967,6 +2967,23 @@ int security_file_open(struct file *file)
 	return fsnotify_open_perm(file);
 }
 
+/**
+ * security_file_post_open() - Evaluate a file after it has been opened
+ * @file: the file
+ * @mask: access mask
+ *
+ * Evaluate an opened file and the access mask requested with open(). The hook
+ * is useful for LSMs that require the file content to be available in order to
+ * make decisions.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_post_open(struct file *file, int mask)
+{
+	return call_int_hook(file_post_open, 0, file, mask);
+}
+EXPORT_SYMBOL_GPL(security_file_post_open);
+
 /**
  * security_file_truncate() - Check if truncating a file is allowed
  * @file: file
-- 
2.34.1


