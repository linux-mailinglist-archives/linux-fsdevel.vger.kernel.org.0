Return-Path: <linux-fsdevel+bounces-36054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C6F9DB544
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A7F28287C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF151917E9;
	Thu, 28 Nov 2024 10:07:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F317B402;
	Thu, 28 Nov 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788447; cv=none; b=Zu2nhBTOgi2mXXn49LmVSd6i1BXQ7BkTSJ5gVcSwZKZI+p90CpgajfDM+slMVHC5Gj17Ybsf2dQKQOCUdLcbFz38WoUA/Ftng56bBMi6rqQClJvGK7pJG3BkMVvm+XGuyfOD+iVwqcDapbwUDI0Digey7pTYLjUthhCHfVwA0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788447; c=relaxed/simple;
	bh=XXYI20ISz4FzwTDGShmNHWid6MPxaBqZSECE2oDi4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s70CKr0XnYrAQpSuWeh0pdGg/FxWxeUbvKkVdK4IngtckYn4ZXzLqWrOwuVxhZFvjH3KDyRrjBzGjk2YmBumrHLan5vW/6ArCL8Bo7LbsiMrZYbGzUMjxqm2jgRm0rpDXVeGpxm75t8Uk+vjfmspzDTQd3mtKjRrMq42DRlFnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XzWfJ2p73z9v7Vv;
	Thu, 28 Nov 2024 17:46:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 444821402E2;
	Thu, 28 Nov 2024 18:07:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnj365QEhn6eNzAg--.15234S5;
	Thu, 28 Nov 2024 11:07:20 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 3/7] ima: Ensure lock is held when setting iint pointer in inode security blob
Date: Thu, 28 Nov 2024 11:06:16 +0100
Message-ID: <20241128100621.461743-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAnj365QEhn6eNzAg--.15234S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xZw1rAFy3Xr1UWF4rXwb_yoW8Kw4fpa
	1DKa4UJ34jqFZ7Wrs5Ca42kr4fK3yIgFyUWws8A3WqyFsrJr1jqr48try7ury5Gr4rA3Z2
	vr1qgws8Aa1qyr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07j4T5LUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGdH1XMCqQAAsq

From: Roberto Sassu <roberto.sassu@huawei.com>

IMA stores a pointer of the ima_iint_cache structure, containing integrity
metadata, in the inode security blob. However, check and assignment of this
pointer is not atomic, and it might happen that two tasks both see that the
iint pointer is NULL and try to set it, causing a memory leak.

Ensure that the iint check and assignment is guarded, by adding a lockdep
assertion in ima_inode_get().

Consequently, guard the remaining ima_inode_get() calls, in
ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the lockdep
warnings.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_iint.c |  2 ++
 security/integrity/ima/ima_main.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index dcc32483d29f..fca9db293c79 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -97,6 +97,8 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 	if (!iint_lock)
 		return NULL;
 
+	lockdep_assert_held(&iint_lock->mutex);
+
 	iint = iint_lock->iint;
 	if (iint)
 		return iint;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 05cfb04cd02b..1e474ff6a777 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -705,14 +705,19 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 	if (!must_appraise)
 		return;
 
+	ima_iint_lock(inode);
+
 	/* Nothing to do if we can't allocate memory */
 	iint = ima_inode_get(inode);
-	if (!iint)
+	if (!iint) {
+		ima_iint_unlock(inode);
 		return;
+	}
 
 	/* needed for writing the security xattrs */
 	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
 	iint->ima_file_status = INTEGRITY_PASS;
+	ima_iint_unlock(inode);
 }
 
 /**
@@ -737,13 +742,18 @@ static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 	if (!must_appraise)
 		return;
 
+	ima_iint_lock(inode);
+
 	/* Nothing to do if we can't allocate memory */
 	iint = ima_inode_get(inode);
-	if (!iint)
+	if (!iint) {
+		ima_iint_unlock(inode);
 		return;
+	}
 
 	/* needed for re-opening empty files */
 	iint->flags |= IMA_NEW_FILE;
+	ima_iint_unlock(inode);
 }
 
 /**
-- 
2.47.0.118.gfd3785337b


