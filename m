Return-Path: <linux-fsdevel+bounces-3236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38037F1A72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A221C21053
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88C22325;
	Mon, 20 Nov 2023 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807F136;
	Mon, 20 Nov 2023 09:36:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYvPn20RLz9xvr5;
	Tue, 21 Nov 2023 01:19:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXU3NimFtlBH8KAQ--.51496S11;
	Mon, 20 Nov 2023 18:35:37 +0100 (CET)
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
Subject: [PATCH v6 09/25] security: Align inode_setattr hook definition with EVM
Date: Mon, 20 Nov 2023 18:33:02 +0100
Message-Id: <20231120173318.1132868-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAXU3NimFtlBH8KAQ--.51496S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47tr4fJFWrKr17ury7Awb_yoW5ur18pF
	45GasxGr4rXFy7Wr1vkFs8ua1S9FWfurWUArWqgw1SyF92qr1vgFyxGr1jkF15GrW8GrnF
	qFsFvrs8Wrn8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5KqaQACsj
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the idmap parameter to the definition, so that evm_inode_setattr() can
be registered as this hook implementation.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/lsm_hook_defs.h | 3 ++-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 3 ++-
 security/smack/smack_lsm.c    | 4 +++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index c925a0d26edf..752ed8a4f3c6 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -135,7 +135,8 @@ LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 	 bool rcu)
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
-LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
+LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
+	 struct iattr *attr)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
 LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
diff --git a/security/security.c b/security/security.c
index 53793f3cb36a..7935d11d58b5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2215,7 +2215,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_setattr, 0, dentry, attr);
+	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
 	if (ret)
 		return ret;
 	return evm_inode_setattr(idmap, dentry, attr);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b340425ccfae..7363e0a07867 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3128,7 +3128,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	return rc;
 }
 
-static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 struct iattr *iattr)
 {
 	const struct cred *cred = current_cred();
 	struct inode *inode = d_backing_inode(dentry);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 53336d7daa93..3f60cc4b3b82 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1232,12 +1232,14 @@ static int smack_inode_permission(struct inode *inode, int mask)
 
 /**
  * smack_inode_setattr - Smack check for setting attributes
+ * @idmap: idmap of the mount
  * @dentry: the object
  * @iattr: for the force flag
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+static int smack_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			       struct iattr *iattr)
 {
 	struct smk_audit_info ad;
 	int rc;
-- 
2.34.1


