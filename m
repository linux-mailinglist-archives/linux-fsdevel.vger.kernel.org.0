Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC266A9E7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjCCSWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjCCSWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:22:33 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A41040E;
        Fri,  3 Mar 2023 10:22:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSx0d167rz9xtSG;
        Sat,  4 Mar 2023 02:13:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgKOgJk5iFpAQ--.12605S18;
        Fri, 03 Mar 2023 19:21:52 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 16/28] security: Introduce file_post_open hook
Date:   Fri,  3 Mar 2023 19:18:30 +0100
Message-Id: <20230303181842.1087717-17-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVgKOgJk5iFpAQ--.12605S18
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fWrW8KF1DZFWruFWkXrb_yoWrXr1kpF
        ZYy3WUGFW8GFy7Wrn7Aanrua4ag39agryUWrZ5u345tFn2qrnYgFZ0yF1Ykr15JrZYyFyx
        X3W2grW3Cr1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
        kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
        WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x
        07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4YveQAAsi
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation to move IMA and EVM to the LSM infrastructure, introduce the
file_post_open hook. Also, export security_file_post_open() for NFS.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c                    |  2 ++
 fs/nfsd/vfs.c                 |  6 ++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 17 +++++++++++++++++
 5 files changed, 32 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index b4c52c4890b..41f7fdf4657 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3558,6 +3558,8 @@ static int do_open(struct nameidata *nd,
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
+	if (!error)
+		error = security_file_post_open(file, op->acc_mode);
 	if (!error)
 		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e7462b5e5f1..4b86c158ffb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -852,6 +852,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out_nfserr;
 	}
 
+	host_err = security_file_post_open(file, may_flags);
+	if (host_err) {
+		fput(file);
+		goto out_nfserr;
+	}
+
 	host_err = ima_file_check(file, may_flags);
 	if (host_err) {
 		fput(file);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2ae5224d967..5d4e256e250 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -187,6 +187,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
 LSM_HOOK(int, 0, file_open, struct file *file)
+LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
 LSM_HOOK(int, 0, file_truncate, struct file *file)
 LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
 	 unsigned long clone_flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index b511f608958..4fdc62a1b42 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -402,6 +402,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+int security_file_post_open(struct file *file, int mask);
 int security_file_truncate(struct file *file);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
@@ -1043,6 +1044,11 @@ static inline int security_file_open(struct file *file)
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
index 6bf4a92db94..e252c87df4f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2906,6 +2906,23 @@ int security_file_open(struct file *file)
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
+/**
+ * security_file_post_open() - Recheck access to a file after it has been opened
+ * @file: the file
+ * @mask: access mask
+ *
+ * Recheck access with mask after the file has been opened. The hook is useful
+ * for LSMs that require the file content to be available in order to make
+ * decisions.
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
2.25.1

