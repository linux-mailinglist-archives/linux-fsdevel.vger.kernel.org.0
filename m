Return-Path: <linux-fsdevel+bounces-7967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25D082DF53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610CB1F22D26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C30199C6;
	Mon, 15 Jan 2024 18:21:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9818B02;
	Mon, 15 Jan 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDKnx4b4pz9xrcl;
	Tue, 16 Jan 2024 02:06:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 51AF4140A11;
	Tue, 16 Jan 2024 02:20:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXBCjzdqVl8DKbAA--.57127S11;
	Mon, 15 Jan 2024 19:20:44 +0100 (CET)
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
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
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
Subject: [PATCH v9 09/25] security: Align inode_setattr hook definition with EVM
Date: Mon, 15 Jan 2024 19:17:53 +0100
Message-Id: <20240115181809.885385-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAXBCjzdqVl8DKbAA--.57127S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47tr4fJFWrKr17ury7Awb_yoW5ur18pF
	4UJ3ZxGr4rXFy7Wr1vkF45ua1S9FWfurWUArWjgw1SyF92qr1IgFyxGr1jkF15GrWUGrnF
	qFsFvrs8Wr15ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5iRzQAAsz

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
index 185924c56378..a843bb5f6f4b 100644
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
index ab847af2c74d..1d332e294704 100644
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
index 179540441115..dae53d7778bb 100644
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
index c126f6a16de4..9b75216d4a58 100644
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


