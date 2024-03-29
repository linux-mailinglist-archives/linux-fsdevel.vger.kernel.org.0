Return-Path: <linux-fsdevel+bounces-15671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8F891723
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 11:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE981F238F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE46A029;
	Fri, 29 Mar 2024 10:56:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CB364BA;
	Fri, 29 Mar 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709801; cv=none; b=s47UREUfTFlby6+5DDPDBItpERALFg+ethFOmdHQ3O3SJk5Ze8+rw9rAbIlrxpgChflWTkbLfEz2YUSDyHMbg89Skb6wINDg+uhiZySNKm1EzLeCzeasNxT4rxhfJhNU1wQIHLXvN7W8rvjls0zMh3D9zN4v4ZBoiE7qBcO2Cog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709801; c=relaxed/simple;
	bh=wXmD/wTPLUziOZNHo17aLeyr2LXTHIbWqldBHooT3mA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oAY78pFPdDUQ44pwFyD+Yuwk8AFkBbB776IM8U0dKW6E7Z5amMz57ReuqKHcdYnu85n7zt/k3muab/d9IodGWui9GNiajK6q4FPjxcpisfS/kBxd2Z0T3/gftTKl//oXgboef13/3x97pd53g5k19GonpzZbynScu80Ou3+4naE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4V5cPL1clGz9y0km;
	Fri, 29 Mar 2024 18:40:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 79883140556;
	Fri, 29 Mar 2024 18:56:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDnISZMngZmVsAqBQ--.12203S2;
	Fri, 29 Mar 2024 11:56:22 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	pc@manguebit.com,
	christian@brauner.io,
	Roberto Sassu <roberto.sassu@huawei.com>,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 1/2] security: Handle dentries without inode in security_path_post_mknod()
Date: Fri, 29 Mar 2024 11:56:08 +0100
Message-Id: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDnISZMngZmVsAqBQ--.12203S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWrAFWkCw4fWw45ury8Krg_yoWrXryUpF
	4rt3WkJr95XFy8Wr18AFy7u3WSkay5WFWUWan5Wa1ayFnxXr1jqrs2vryY9rW5tr4UGryx
	twnFyrsxAa1qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUxo7KDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj5vtpQABs3

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 08abce60d63fi ("security: Introduce path_post_mknod hook")
introduced security_path_post_mknod(), to replace the IMA-specific call to
ima_post_path_mknod().

For symmetry with security_path_mknod(), security_path_post_mknod() is
called after a successful mknod operation, for any file type, rather than
only for regular files at the time there was the IMA call.

However, as reported by VFS maintainers, successful mknod operation does
not mean that the dentry always has an inode attached to it (for example,
not for FIFOs on a SAMBA mount).

If that condition happens, the kernel crashes when
security_path_post_mknod() attempts to verify if the inode associated to
the dentry is private.

Add an extra check to first verify if there is an inode attached to the
dentry, before checking if the inode is private. Also add the same check to
the current users of the path_post_mknod hook, ima_post_path_mknod() and
evm_post_path_mknod().

Finally, use the proper helper, d_backing_inode(), to retrieve the inode
from the dentry in ima_post_path_mknod().

Cc: stable@vger.kernel.org # 6.8.x
Reported-by: Steve French <smfrench@gmail.com>
Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
Fixes: 08abce60d63fi ("security: Introduce path_post_mknod hook")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c | 6 ++++--
 security/integrity/ima/ima_main.c | 5 +++--
 security/security.c               | 4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 81dbade5b9b3..ec1659273fcf 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1037,11 +1037,13 @@ static void evm_file_release(struct file *file)
 static void evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct evm_iint_cache *iint = evm_iint_inode(inode);
+	struct evm_iint_cache *iint;
 
-	if (!S_ISREG(inode->i_mode))
+	/* path_post_mknod hook might pass dentries without attached inode. */
+	if (!inode || !S_ISREG(inode->i_mode))
 		return;
 
+	iint = evm_iint_inode(inode);
 	if (iint)
 		iint->flags |= EVM_NEW_FILE;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c84e8c55333d..afc883e60cf3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -719,10 +719,11 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	struct ima_iint_cache *iint;
-	struct inode *inode = dentry->d_inode;
+	struct inode *inode = d_backing_inode(dentry);
 	int must_appraise;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	/* path_post_mknod hook might pass dentries without attached inode. */
+	if (!ima_policy_flag || !inode || !S_ISREG(inode->i_mode))
 		return;
 
 	must_appraise = ima_must_appraise(idmap, inode, MAY_ACCESS,
diff --git a/security/security.c b/security/security.c
index 7e118858b545..455f0749e1b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1801,7 +1801,9 @@ EXPORT_SYMBOL(security_path_mknod);
  */
 void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	/* Not all dentries have an inode attached after mknod. */
+	if (d_backing_inode(dentry) &&
+	    unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
 	call_void_hook(path_post_mknod, idmap, dentry);
 }
-- 
2.34.1


