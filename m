Return-Path: <linux-fsdevel+bounces-3240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA937F1AB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032F81F2561C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319A225D3;
	Mon, 20 Nov 2023 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939DF10E9;
	Mon, 20 Nov 2023 09:38:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYvS55nGVz9xxmv;
	Tue, 21 Nov 2023 01:21:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHuGEqmVtlz4kHAQ--.4148S5;
	Mon, 20 Nov 2023 18:37:38 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 13/25] security: Introduce file_release hook
Date: Mon, 20 Nov 2023 18:33:06 +0100
Message-Id: <20231120173318.1132868-14-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHuGEqmVtlz4kHAQ--.4148S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7CF1xAr4UKrykJF4ktFb_yoW5ur45pr
	Z8t3WUGFW5GF12grn7Aanrua4fK393KryDWrZ5W345tF1kJr95Kan8CryUCFs8JrWkJr10
	qw12grW3Gr4DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07jx
	UUUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apegACs0
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the file_release hook.

IMA calculates at file close the new digest of the file content and writes
it to security.ima, so that appraisal at next file access succeeds.

LSMs could also take some action before the last reference of a file is
released.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/file_table.c               |  1 +
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  4 ++++
 security/security.c           | 11 +++++++++++
 4 files changed, 17 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..c72dc75f2bd3 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -385,6 +385,7 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
+	security_file_release(file);
 	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e2b45fee94e2..175ca00a6b1d 100644
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
index c360458920b1..4c3585e3dcb4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -395,6 +395,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
+void security_file_release(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
@@ -1006,6 +1007,9 @@ static inline int security_file_alloc(struct file *file)
 	return 0;
 }
 
+static inline void security_file_release(struct file *file)
+{ }
+
 static inline void security_file_free(struct file *file)
 { }
 
diff --git a/security/security.c b/security/security.c
index fe6a160afc35..9aa072ca5a19 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2724,6 +2724,17 @@ int security_file_alloc(struct file *file)
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


