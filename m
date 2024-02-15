Return-Path: <linux-fsdevel+bounces-11673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217B855F70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52121F21698
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E012F384;
	Thu, 15 Feb 2024 10:32:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C0128390;
	Thu, 15 Feb 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993178; cv=none; b=YMExnRSZhxOpH31o4osgElrR38nzv7V+Ird88yG4qXU/qkZ8PPHZWyXi6V5TQAbgVNJqF5Ki8h32digZ2inLk3SgqQLLOg8OYts6XucK/10ut8jbFxgFCLK4CYqHRleD7LzXtqdeQ9rIzjos3G6qbjktoSSLYpBtimx1X5S6Aag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993178; c=relaxed/simple;
	bh=eZUEbuELaRxlIYhZx2+NjpFpxz9Cjbe7BkbG8FvFDXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YiHWwCyqo2DMRQjhhX1UOm++FmXh6GvqJOaR4DMDNfSuMi7nht6mEoHVhGclawbY9mjsohuOYrHFtXS9HyvGip6KmJ0GURPKucgsm09ZkqaygfqgdDN9EI2Pn7qMYRc+YxuwowDnip3VcSma4xHu7xOSwzpdOEaENIbra1NMWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tb9wv5VKjz9yTLN;
	Thu, 15 Feb 2024 18:17:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B429114064F;
	Thu, 15 Feb 2024 18:32:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXUCQD6M1lUHGHAg--.4426S6;
	Thu, 15 Feb 2024 11:32:43 +0100 (CET)
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
Subject: [PATCH v10 04/25] ima: Align ima_inode_removexattr() definition with LSM infrastructure
Date: Thu, 15 Feb 2024 11:30:52 +0100
Message-Id: <20240215103113.2369171-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAXUCQD6M1lUHGHAg--.4426S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWrXry3uw4rAF4fGF4fGrg_yoW5Gw15pF
	s3K3WUC348XFy7WryFyF9xC34SgrW7GrnrX3yrW3Z2yFnxJr18XFWfXF1j9345Cr48KF1v
	qFsFvwsxC3W5trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf0QAAsh

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_inode_removexattr() definition, so that it can be registered as
implementation of the inode_removexattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h                   | 7 +++++--
 security/integrity/ima/ima_appraise.c | 3 ++-
 security/security.c                   | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 077324309c11..678a03fddd7e 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -200,7 +200,9 @@ static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
 {
 	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
 }
-extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
+
+extern int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
@@ -231,7 +233,8 @@ static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static inline int ima_inode_removexattr(struct dentry *dentry,
+static inline int ima_inode_removexattr(struct mnt_idmap *idmap,
+					struct dentry *dentry,
 					const char *xattr_name)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index cb2d0d11aa77..36abc84ba299 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -790,7 +790,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 }
 
-int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
+int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			  const char *xattr_name)
 {
 	int result;
 
diff --git a/security/security.c b/security/security.c
index ec572380d0cd..feb39de74385 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2431,7 +2431,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 		ret = cap_inode_removexattr(idmap, dentry, name);
 	if (ret)
 		return ret;
-	ret = ima_inode_removexattr(dentry, name);
+	ret = ima_inode_removexattr(idmap, dentry, name);
 	if (ret)
 		return ret;
 	return evm_inode_removexattr(idmap, dentry, name);
-- 
2.34.1


