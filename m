Return-Path: <linux-fsdevel+bounces-11678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0515855FA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6799292EDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D612B148;
	Thu, 15 Feb 2024 10:34:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D385263;
	Thu, 15 Feb 2024 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993247; cv=none; b=myZGNOKvP64u9gLPzGEwVNQhr1mYETy7Z7/kYBO3XxmYENNE+q6Cww6ipDfnD+RDpHaKR8B81A4jKuOjUGRU5KQerMZxnj1jjPJM/iau0j3S1r+Ue5ZJMcO2iHqrpW3XnnoVAoBKYFvwm4STjvJSXzCNvLq7CB92mcU4bBMLz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993247; c=relaxed/simple;
	bh=vWH+bbvz6ifJxldNvr7I686bbRzvQ9xgjkN0s3Xraro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idl98qoQVYl66XcYaPvZwEMmdehwiWOKOYo6o0CNIe9dCMrWw4gkGTJH/inTvkWI2Z8B/eGEz2ezYiDRo8U2fml5yYE6LzbEXSgSi3kfNdcKRnHXtV1LAwZSAlPoatRohYDmFFS+QC153t0geLePYYAhVsdVNbTcMKLnkbO1Rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Tb9yH2ldXz9yB7M;
	Thu, 15 Feb 2024 18:18:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E95541405A2;
	Thu, 15 Feb 2024 18:33:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXUCQD6M1lUHGHAg--.4426S11;
	Thu, 15 Feb 2024 11:33:53 +0100 (CET)
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
Subject: [PATCH v10 09/25] security: Align inode_setattr hook definition with EVM
Date: Thu, 15 Feb 2024 11:30:57 +0100
Message-Id: <20240215103113.2369171-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAXUCQD6M1lUHGHAg--.4426S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUJr13tr1rKw1DCF1kGrg_yoW5uF1UpF
	43G3ZxGr4rXFyxWr1vkFs8ua1S9FWfurW7JrW0gw1SyFn2qrn2gFyxKr1jkF15GrWUGrnF
	qFsFvrs8Wr15ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf1AABsl

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the idmap parameter to the definition, so that evm_inode_setattr() can
be registered as this hook implementation.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h | 3 ++-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 3 ++-
 security/smack/smack_lsm.c    | 4 +++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..b00b16d58413 100644
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
index 7c240d768a76..671472b34bbf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2216,7 +2216,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_setattr, 0, dentry, attr);
+	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
 	if (ret)
 		return ret;
 	return evm_inode_setattr(idmap, dentry, attr);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..cedb4cbf072e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3136,7 +3136,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	return rc;
 }
 
-static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 struct iattr *iattr)
 {
 	const struct cred *cred = current_cred();
 	struct inode *inode = d_backing_inode(dentry);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0fdbf04cc258..1b6abfdf7173 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1233,12 +1233,14 @@ static int smack_inode_permission(struct inode *inode, int mask)
 
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


