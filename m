Return-Path: <linux-fsdevel+bounces-11672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F56855F62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D12D283A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909012C81D;
	Thu, 15 Feb 2024 10:32:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199512C556;
	Thu, 15 Feb 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993159; cv=none; b=M6xEFXVwqbXoHOr5knRmvzOHGW3XbQpaUUEu14aH/SM+1kR38x+D/iwKahgEjJ+UcdE1r8nJL9AJ5O362hY3W9LY4cgucK4tAtju7nTDViq4rjbXgFGHM0k3Za7FgKe+Mlhrd4VfjLNpybUJqb7ZPjPPQgplYDM397m3KZ2Zr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993159; c=relaxed/simple;
	bh=ssuexqWPzBH657dquulDubPaZdrlVoNmR2rfvuXkSo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8zPemH/NxHioO3/kWBM2/Q2TVgT9MdKBbRl1CE8kyeiPn3Tb3vImVqYkbJQHCGjOmhp1bfUqu2xH8mprhv0fjnzV2E3lJG6Fv8b0TouYLcFue3d8TIdAGIrAiyI3NKWmOGi+S+Y4kUXXVogeJ6B+PU4KbIsGry8gJR1S9Nf1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tb9r61V62z9xrMY;
	Thu, 15 Feb 2024 18:13:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BC65B1405A1;
	Thu, 15 Feb 2024 18:32:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXUCQD6M1lUHGHAg--.4426S5;
	Thu, 15 Feb 2024 11:32:29 +0100 (CET)
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
Subject: [PATCH v10 03/25] ima: Align ima_inode_setxattr() definition with LSM infrastructure
Date: Thu, 15 Feb 2024 11:30:51 +0100
Message-Id: <20240215103113.2369171-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAXUCQD6M1lUHGHAg--.4426S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyDGF1DCryftr43tr48Crg_yoW5ZFyxpF
	s5Ga48G34FqFy7WryFyF47u39Y93y8WryUurWDK3Z2yFnxJr1xtFySyr1jvry5Zr48Kr1v
	qa1aqrs0k3W3trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5pfVQADsp

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_inode_setxattr() definition, so that it can be registered as
implementation of the inode_setxattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h                   | 11 +++++++----
 security/integrity/ima/ima_appraise.c |  5 +++--
 security/security.c                   |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b66353f679e8..077324309c11 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -188,8 +188,9 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry, int ia_valid);
-extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
-		       const void *xattr_value, size_t xattr_value_len);
+extern int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			      const char *xattr_name, const void *xattr_value,
+			      size_t xattr_value_len, int flags);
 extern int ima_inode_set_acl(struct mnt_idmap *idmap,
 			     struct dentry *dentry, const char *acl_name,
 			     struct posix_acl *kacl);
@@ -212,10 +213,12 @@ static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
 	return;
 }
 
-static inline int ima_inode_setxattr(struct dentry *dentry,
+static inline int ima_inode_setxattr(struct mnt_idmap *idmap,
+				     struct dentry *dentry,
 				     const char *xattr_name,
 				     const void *xattr_value,
-				     size_t xattr_value_len)
+				     size_t xattr_value_len,
+				     int flags)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 36c2938a5c69..cb2d0d11aa77 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -750,8 +750,9 @@ static int validate_hash_algo(struct dentry *dentry,
 	return -EACCES;
 }
 
-int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
-		       const void *xattr_value, size_t xattr_value_len)
+int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		       const char *xattr_name, const void *xattr_value,
+		       size_t xattr_value_len, int flags)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
 	int digsig = 0;
diff --git a/security/security.c b/security/security.c
index 78928d4c0db1..ec572380d0cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2270,7 +2270,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
 	if (ret)
 		return ret;
-	ret = ima_inode_setxattr(dentry, name, value, size);
+	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
 	if (ret)
 		return ret;
 	return evm_inode_setxattr(idmap, dentry, name, value, size);
-- 
2.34.1


