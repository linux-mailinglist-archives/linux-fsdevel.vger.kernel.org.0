Return-Path: <linux-fsdevel+bounces-39855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A34A19795
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08836188D6BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95290215F4A;
	Wed, 22 Jan 2025 17:25:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8921422F;
	Wed, 22 Jan 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566749; cv=none; b=ojnBanQ3Qn5H7kQizmiRsPxaAODvvbBka5nJViiaHZcBDLnsaitna56L/xo0ikAi9aDSmpWPn8sxpWonUvJEsD/GgYIJZKA0qEVHkWYldIUonME2FabaweCOSPnQZd9yc8O+iZ4evET/SpEXR9cCLccf6Drczmwpi2+HxXXZxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566749; c=relaxed/simple;
	bh=4IBURMP7g21DcmOA500BltGDI1MsqBcwr64/+gVtYOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnp5ilo9AYs+DZOwYPEkUXotXtPh9j4fMgjRgJYsa6iWddelgqjF2tcGJo5RUi67jQxLXH1OXsQaHSwCpjO6Nu99z71pbvuKcbtMZPM2ng8VvVjhXEL08qg4sLGLIJ7UEEDImyBzRV7bDvgEpnUMNqm1gmf0QJYzQHAYrbNhP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdVbY07ZLz9v7Jf;
	Thu, 23 Jan 2025 00:56:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 1A003141061;
	Thu, 23 Jan 2025 01:25:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEvkKZFnsGscAQ--.5068S5;
	Wed, 22 Jan 2025 18:25:36 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 3/6] ima: Detect if lock is held when iint pointer is set in inode security blob
Date: Wed, 22 Jan 2025 18:24:29 +0100
Message-Id: <20250122172432.3074180-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDnbEvkKZFnsGscAQ--.5068S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xZw1rAFWfJF1xKr1DAwb_yoW8Kw4Dpa
	1DKa4UJ34jqFZ7Wrs5Za42kr4fK3yIgFyUWws8Jw1qyFsrJr1jqr48try7ury5Gr4rA3Z2
	vr1jgws8Aa1qyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UA
	CztUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGeQmNQFNQACsc

From: Roberto Sassu <roberto.sassu@huawei.com>

IMA stores a pointer of the ima_iint_cache structure, containing integrity
metadata, in the inode security blob. However, check and assignment of this
pointer is not atomic, and it might happen that two tasks both see that the
iint pointer is NULL and try to set it, causing a memory leak.

Detect if the iint check and assignment is guarded by the iint_lock mutex,
by adding a lockdep assertion in ima_inode_get().

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
index 006f1e3725d6..0aed8f730c42 100644
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
2.34.1


