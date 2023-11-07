Return-Path: <linux-fsdevel+bounces-2246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F467E40BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6483FB2154A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23831A9A;
	Tue,  7 Nov 2023 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30730D19;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5E1718;
	Tue,  7 Nov 2023 05:45:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SPpz827Vwz9y1B5;
	Tue,  7 Nov 2023 21:31:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnFXUiP0plvHc3AA--.54683S4;
	Tue, 07 Nov 2023 14:44:40 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
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
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 12/23] security: Introduce file_post_open hook
Date: Tue,  7 Nov 2023 14:40:01 +0100
Message-Id: <20231107134012.682009-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAnFXUiP0plvHc3AA--.54683S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4rWFWkJrW5WFyfCrW3ZFb_yoWrCFy5pF
	ZYy3WUGrW8GFy7Wrn7Aanrua4ag39agryDWrZ5u34YyFn2qrnYgFs0yr1Ykr15JrZ5JFyI
	q3W2grW3Cr1DZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UHuWLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5YbggAAs1
X-CFilter-Loop: Reflected

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
---
 fs/namei.c                    |  2 ++
 fs/nfsd/vfs.c                 |  6 ++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 17 +++++++++++++++++
 5 files changed, 32 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..fb93d3e13df6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3620,6 +3620,8 @@ static int do_open(struct nameidata *nd,
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
+	if (!error)
+		error = security_file_post_open(file, op->acc_mode);
 	if (!error)
 		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..b0c3f07a8bba 100644
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
index 88452e45025c..4f6861fecacd 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -189,6 +189,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
 LSM_HOOK(int, 0, file_open, struct file *file)
+LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
 LSM_HOOK(int, 0, file_truncate, struct file *file)
 LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
 	 unsigned long clone_flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 922ea7709bae..c360458920b1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -409,6 +409,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+int security_file_post_open(struct file *file, int mask);
 int security_file_truncate(struct file *file);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
@@ -1065,6 +1066,11 @@ static inline int security_file_open(struct file *file)
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
index 8aa6e9f316dd..fe6a160afc35 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2954,6 +2954,23 @@ int security_file_open(struct file *file)
 	return fsnotify_perm(file, MAY_OPEN);
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


