Return-Path: <linux-fsdevel+bounces-36052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99289DB53C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEA82823CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920718D63A;
	Thu, 28 Nov 2024 10:07:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B884E1C;
	Thu, 28 Nov 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788432; cv=none; b=XQc9gN5MSYopQZrIJ+SOfRjm/mrQW6hUDDWRdTwQsKUQo/PvSiDbanlYpA1OcN3WJP80oqdr145/2LaRYvcHh/NNWMPDHakoM139W0nof1DAlBu4lCC8GUx77YeHWDsimlZ3xtvfhJsPuxTxZiqaWVI7y4nOEAGZWNa+5ND6730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788432; c=relaxed/simple;
	bh=At99JRGrfCROwC9OJAlThdrDQCqL1u/LUz+6jzp3kmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDZuIcLZkQ1lTIMLPgbjHWOduK+6Ysm750z4f8yOYDevEQf1Cb2SCncu7rPmAOp8a7qUvNHwXQYK0ivOV1T905ueYSE+DWLQeGSAkKwJbgdqbUjp3OH+SGanozB5SposQN6xHGLFfDE/yQ+4FF/UKwwxXZkQLcOSoeFdsU87JL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XzWf34rlQz9v7JC;
	Thu, 28 Nov 2024 17:46:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 44AD11402C1;
	Thu, 28 Nov 2024 18:07:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnj365QEhn6eNzAg--.15234S3;
	Thu, 28 Nov 2024 11:07:05 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shu Han <ebpqwerty472123@gmail.com>
Subject: [PATCH v2 1/7] fs: ima: Remove S_IMA and IS_IMA()
Date: Thu, 28 Nov 2024 11:06:14 +0100
Message-ID: <20241128100621.461743-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAnj365QEhn6eNzAg--.15234S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWDuFyruF4rCr1kAr17GFg_yoWrAr4xpF
	4DKFW8J34DJFWxurWktFy7Zr1SgayUGFW8Ww45Aw40vF9rXw1vqF1xtry5ZFn5WFZYkw4I
	qFs0gw45u3WqkrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jQ4SrUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGdH1XMCpwAAsk

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 196f518128d2e ("IMA: explicit IMA i_flag to remove global lock on
inode_delete") introduced the new S_IMA inode flag to determine whether or
not an inode was processed by IMA. In that way, it was not necessary to
take the global lock on inode delete.

Since commit 4de2f084fbff ("ima: Make it independent from 'integrity'
LSM"), the pointer of the inode integrity metadata managed by IMA has been
moved to the inode security blob, from the rb-tree. The pointer is not NULL
only if the inode has been processed by IMA, i.e. ima_inode_get() has been
called for that inode.

Thus, since the IS_IMA() check can be now implemented by trivially testing
whether or not the pointer of inode integrity metadata is NULL, remove the
S_IMA definition in include/linux/fs.h and also the IS_IMA() macro.

Remove also the IS_IMA() invocation in ima_rdwr_violation_check(), since
whether the inode was processed by IMA will be anyway detected by a
subsequent call to ima_iint_find(). It does not have an additional overhead
since the decision can be made in constant time, as opposed to logarithm
when the inode integrity metadata was stored in the rb-tree.

Suggested-by: Shu Han <ebpqwerty472123@gmail.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/fs.h                | 3 +--
 security/integrity/ima/ima_iint.c | 5 -----
 security/integrity/ima/ima_main.c | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..b33363becbdd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2261,7 +2261,7 @@ struct super_operations {
 #define S_NOCMTIME	(1 << 7)  /* Do not update file c/mtime */
 #define S_SWAPFILE	(1 << 8)  /* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE	(1 << 9)  /* Inode is fs-internal */
-#define S_IMA		(1 << 10) /* Inode has an associated IMA struct */
+/* #define S_IMA	(1 << 10) Inode has an associated IMA struct (unused) */
 #define S_AUTOMOUNT	(1 << 11) /* Automount/referral quasi-directory */
 #define S_NOSEC		(1 << 12) /* no suid or xattr security attributes */
 #ifdef CONFIG_FS_DAX
@@ -2319,7 +2319,6 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #endif
 
 #define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
-#define IS_IMA(inode)		((inode)->i_flags & S_IMA)
 #define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)
 #define IS_NOSEC(inode)		((inode)->i_flags & S_NOSEC)
 #define IS_DAX(inode)		((inode)->i_flags & S_DAX)
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98..9d9fc7a911ad 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -26,9 +26,6 @@ static struct kmem_cache *ima_iint_cache __ro_after_init;
  */
 struct ima_iint_cache *ima_iint_find(struct inode *inode)
 {
-	if (!IS_IMA(inode))
-		return NULL;
-
 	return ima_inode_get_iint(inode);
 }
 
@@ -102,7 +99,6 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 
 	ima_iint_init_always(iint, inode);
 
-	inode->i_flags |= S_IMA;
 	ima_inode_set_iint(inode, iint);
 
 	return iint;
@@ -118,7 +114,6 @@ void ima_inode_free_rcu(void *inode_security)
 {
 	struct ima_iint_cache **iint_p = inode_security + ima_blob_sizes.lbs_inode;
 
-	/* *iint_p should be NULL if !IS_IMA(inode) */
 	if (*iint_p)
 		ima_iint_free(*iint_p);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..cea0afbbc28d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -126,7 +126,7 @@ static void ima_rdwr_violation_check(struct file *file,
 	bool send_tomtou = false, send_writers = false;
 
 	if (mode & FMODE_WRITE) {
-		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
+		if (atomic_read(&inode->i_readcount)) {
 			if (!iint)
 				iint = ima_iint_find(inode);
 			/* IMA_MEASURE is set from reader side */
-- 
2.47.0.118.gfd3785337b


