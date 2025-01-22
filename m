Return-Path: <linux-fsdevel+bounces-39853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442DA19787
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69490188BB11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953512153E9;
	Wed, 22 Jan 2025 17:25:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8821422F;
	Wed, 22 Jan 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566734; cv=none; b=lPwVrigYNkVaiJQ8GtMxGvUXfQzwvSfFffVpD67H+Hne+9Jh3Reks2tgqcLhJNs+2+ap3FOKGB01M4YGOtj+WDikViAmIJV98dowP2jO+z4bTHVSdXEUxBpAeR8oqN1k89URhyulKRFc7bUpREWwVo+rYsV3l79AK5bf+OuctS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566734; c=relaxed/simple;
	bh=hoGUqFqXPgCsOqjJaQmCCeaUzsDynCqhbbVgGNpfH3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIoUrtFGICCSHGbRgIBNWYSHtpAU6sWXuaUL7C09xdiHpKzpESSePAE0ySrGocfDkpa1LBEnPzc0E7eo8V4Am1hCXqtruBWDrfEj/KPvF6z8GT/+7PtY9HP+8e1cq6T9ox5AB12mfDDwXbxIHLv+lNYRP+quH1jKKRqViyXWUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4YdVl36FL2z9v7NL;
	Thu, 23 Jan 2025 01:03:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 2D6F2140635;
	Thu, 23 Jan 2025 01:25:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEvkKZFnsGscAQ--.5068S3;
	Wed, 22 Jan 2025 18:25:17 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shu Han <ebpqwerty472123@gmail.com>
Subject: [PATCH v3 1/6] fs: ima: Remove S_IMA and IS_IMA()
Date: Wed, 22 Jan 2025 18:24:27 +0100
Message-Id: <20250122172432.3074180-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDnbEvkKZFnsGscAQ--.5068S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWDuFyruF4rCr1kAr17GFg_yoWrAr47pF
	4DKFW8J34DJFyxurWktFy3ur4SgayUGFWUWw45Aw4jvF9rXw1vqF18tr1jvFn5GFZYkw4I
	qFs8Kw45u3WqkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqYL9U
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGeQmNQFNQAAse

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
Reviewed-by: Christian Brauner <brauner@kernel.org>
Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/fs.h                | 2 --
 security/integrity/ima/ima_iint.c | 5 -----
 security/integrity/ima/ima_main.c | 2 +-
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..8ee6961ab54a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2272,7 +2272,6 @@ struct super_operations {
 #define S_NOCMTIME	(1 << 7)  /* Do not update file c/mtime */
 #define S_SWAPFILE	(1 << 8)  /* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE	(1 << 9)  /* Inode is fs-internal */
-#define S_IMA		(1 << 10) /* Inode has an associated IMA struct */
 #define S_AUTOMOUNT	(1 << 11) /* Automount/referral quasi-directory */
 #define S_NOSEC		(1 << 12) /* no suid or xattr security attributes */
 #ifdef CONFIG_FS_DAX
@@ -2330,7 +2329,6 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
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
index 9b87556b03a7..6551be5754de 100644
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
2.34.1


