Return-Path: <linux-fsdevel+bounces-11676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24BA855F99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B7E292546
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53B132493;
	Thu, 15 Feb 2024 10:33:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B38129A91;
	Thu, 15 Feb 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993219; cv=none; b=d2CKG4RfVjEFYilXq3KQmPND5JoR96rh0n6hJc7XXKfBGXYTW4HfLAbstroH2OQkDY9sbmcu7Tnqqhq/M5RR44mYAZ6Xh+kE20T2v4N/6Xdn68Aleepm+hx0vfSH8qRxi9haK+GNMaKrphV87XKjLEZ65pgqcVuZdScx18cWp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993219; c=relaxed/simple;
	bh=EG3EXEeZeHcYdWa8uvleod1HQQQs2GEv7P/jU+8HKcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gw0eReACoFyELbYk5oM4Dw7sSSNckeoxp5M815ai/umhGN2xwMGtsyc3WNW1WMcEx0uEeESVCMgJLOk0X6u/BUY66rfrBtt+c41icuT2sKlgKQvDHqlHK3D4UoxbYsBgPfJOoljna9HuAhRvvyk5cpf/jSlrDOD58mRPhdYpOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tb9sF3TmJz9xw3r;
	Thu, 15 Feb 2024 18:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 041AB140636;
	Thu, 15 Feb 2024 18:33:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXUCQD6M1lUHGHAg--.4426S9;
	Thu, 15 Feb 2024 11:33:25 +0100 (CET)
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
Subject: [PATCH v10 07/25] evm: Align evm_inode_setxattr() definition with LSM infrastructure
Date: Thu, 15 Feb 2024 11:30:55 +0100
Message-Id: <20240215103113.2369171-8-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAXUCQD6M1lUHGHAg--.4426S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGryfXF4ktFyktr1fAw4xZwb_yoW5CF1fpF
	Z8Ka48Gw1FqFyUWryvkF17uayvg3yrWryjkrWDK3WvyF9xJrnYqFyfKF4jyryrCr48KrnI
	qanFvrs09w15X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5pfXAABsi

From: Roberto Sassu <roberto.sassu@huawei.com>

Change evm_inode_setxattr() definition, so that it can be registered as
implementation of the inode_setxattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/evm.h               | 4 ++--
 security/integrity/evm/evm_main.c | 3 ++-
 security/security.c               | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 5cc386312b5a..7de24c1ada90 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -27,7 +27,7 @@ extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *name,
-			      const void *value, size_t size);
+			      const void *value, size_t size, int flags);
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
@@ -107,7 +107,7 @@ static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
 
 static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
 				     struct dentry *dentry, const char *name,
-				     const void *value, size_t size)
+				     const void *value, size_t size, int flags)
 {
 	return 0;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ac34f21122cd..12ba3207fd31 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -581,6 +581,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
  * @xattr_value_len: pointer to the new extended attribute value length
+ * @flags: flags to pass into filesystem operations
  *
  * Before allowing the 'security.evm' protected xattr to be updated,
  * verify the existing value is valid.  As only the kernel should have
@@ -590,7 +591,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
  */
 int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       const char *xattr_name, const void *xattr_value,
-		       size_t xattr_value_len)
+		       size_t xattr_value_len, int flags)
 {
 	const struct evm_ima_xattr_data *xattr_data = xattr_value;
 
diff --git a/security/security.c b/security/security.c
index feb39de74385..16361f75c2ae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2273,7 +2273,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
 	if (ret)
 		return ret;
-	return evm_inode_setxattr(idmap, dentry, name, value, size);
+	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
 }
 
 /**
-- 
2.34.1


