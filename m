Return-Path: <linux-fsdevel+bounces-15850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D10894D52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D6028307E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934D3E462;
	Tue,  2 Apr 2024 08:18:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42338DFC;
	Tue,  2 Apr 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045931; cv=none; b=fvYhPpm+CUf3d8mOkuDc6+4QrzT/m0NZWQ9QlKI42auZiAGsla55pVoNIqA2iVYQqfwS1pP6huhIwQCZdUKGnVVQc0MCN1iM7EhozVuTEITGYZwpO1AD5LuMtcle6uVhteX+0T60o4ikQSKuwrdmbCT8hCbfOQjW119BPjCv9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045931; c=relaxed/simple;
	bh=SLsLFlu2RcD+M7Lg/AfoUXyJ6aDUqNOWQceuD8zlcRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iuf9k6tsTi4Ow2bZvEKyCYlTmDs8UtnT60+muwiPTVbl0m/FgYP8EkPKp8YZM+rv63UirWV6mqgoN38Lrds0erin60Ud80qROoGR9kqCJZZ2Tj6cwJH55eSRFdHpYhCHeZWr+WUMzF8sLbIixmZ2s3pfSFv3spgL6I5Kpvqg3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4V80jJ44bTz9xGnY;
	Tue,  2 Apr 2024 16:02:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7735B140429;
	Tue,  2 Apr 2024 16:18:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCn4CRLvwtm5OBqBQ--.39080S2;
	Tue, 02 Apr 2024 09:18:33 +0100 (CET)
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
	Steve French <smfrench@gmail.com>
Subject: [PATCH v2] security: Handle dentries without inode in security_path_post_mknod()
Date: Tue,  2 Apr 2024 10:18:05 +0200
Message-Id: <20240402081805.2491789-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCn4CRLvwtm5OBqBQ--.39080S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWrAFWkCw4fAr45JF4xJFb_yoWrXFWxpF
	4rK3WkJr95XFy8Wr18AFy7u3WrKay5WFWUWan5Wa1ayFnxXr1jqr1Iv34j9rW5Jr4UGryx
	tw12yrsxua1qyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj5gBFwABs5

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

Reported-by: Steve French <smfrench@gmail.com>
Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
Fixes: 08abce60d63f ("security: Introduce path_post_mknod hook")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/evm/evm_main.c | 6 ++++--
 security/integrity/ima/ima_main.c | 5 +++--
 security/security.c               | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

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
index 7e118858b545..391477687637 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1801,7 +1801,10 @@ EXPORT_SYMBOL(security_path_mknod);
  */
 void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	struct inode *inode = d_backing_inode(dentry);
+
+	/* Not all dentries have an inode attached after mknod. */
+	if (inode && unlikely(IS_PRIVATE(inode)))
 		return;
 	call_void_hook(path_post_mknod, idmap, dentry);
 }
-- 
2.34.1


