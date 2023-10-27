Return-Path: <linux-fsdevel+bounces-1332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B737D91D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77A8B2147A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B3156E0;
	Fri, 27 Oct 2023 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AB156C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:38:34 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA39D56;
	Fri, 27 Oct 2023 01:38:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SGwdN34tDz9xxnN;
	Fri, 27 Oct 2023 16:22:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX8JGqdjtlDvIBAw--.29710S6;
	Fri, 27 Oct 2023 09:38:02 +0100 (CET)
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
Subject: [PATCH v4 04/23] ima: Align ima_inode_removexattr() definition with LSM infrastructure
Date: Fri, 27 Oct 2023 10:35:39 +0200
Message-Id: <20231027083558.484911-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCX8JGqdjtlDvIBAw--.29710S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWktF47GrykAFWfuFWUXFb_yoW5Jr45pF
	s3K3WUC348XFy7Wr9YyF9ru3sa9rW7GrnrX3yrW3Z2yFnxJr1IqFWfXF1UC345CrW8KF1v
	qFsFqws8CF15trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5GTkgACsm
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_inode_removexattr() definition, so that it can be registered as
implementation of the inode_removexattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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
index ac1157edc0e2..b222c4b81760 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2423,7 +2423,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
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


