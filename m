Return-Path: <linux-fsdevel+bounces-3233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9FE7F1A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8096B219E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E73522320;
	Mon, 20 Nov 2023 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14DCF5;
	Mon, 20 Nov 2023 09:35:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SYvSW1yNWz9xvhC;
	Tue, 21 Nov 2023 01:21:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXU3NimFtlBH8KAQ--.51496S8;
	Mon, 20 Nov 2023 18:34:57 +0100 (CET)
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
Subject: [PATCH v6 06/25] evm: Align evm_inode_post_setattr() definition with LSM infrastructure
Date: Mon, 20 Nov 2023 18:32:59 +0100
Message-Id: <20231120173318.1132868-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAXU3NimFtlBH8KAQ--.51496S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fuFy5GFWkXry7uFWrGrg_yoW5Aw4kpF
	Z5K3WkCw1ruryUWr95GF48ZayFgFyrWryUX3yFgw1YyFnrtrnIqFn7K3yUAry5GrW8Grn0
	qFnFvrn5Cr15A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x
	07jxWrAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apcwABs+
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Change evm_inode_post_setattr() definition, so that it can be registered as
implementation of the inode_post_setattr hook (to be introduced).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/attr.c                         | 2 +-
 include/linux/evm.h               | 6 ++++--
 security/integrity/evm/evm_main.c | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 9bddc0a6352c..498e673bdf06 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -503,7 +503,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		ima_inode_post_setattr(idmap, dentry, ia_valid);
-		evm_inode_post_setattr(dentry, ia_valid);
+		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
 
 	return error;
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 01fc495a83e2..cf976d8dbd7a 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -23,7 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     struct integrity_iint_cache *iint);
 extern int evm_inode_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr);
-extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
+extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
+				   struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
@@ -97,7 +98,8 @@ static inline int evm_inode_setattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
+					  struct dentry *dentry, int ia_valid)
 {
 	return;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 894570fe39bc..d452d469c503 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -840,6 +840,7 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 /**
  * evm_inode_post_setattr - update 'security.evm' after modifying metadata
+ * @idmap: idmap of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @ia_valid: for the UID and GID status
  *
@@ -849,7 +850,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    int ia_valid)
 {
 	if (!evm_revalidate_status(NULL))
 		return;
-- 
2.34.1


