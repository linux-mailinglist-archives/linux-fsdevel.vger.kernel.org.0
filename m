Return-Path: <linux-fsdevel+bounces-36057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDE9DB550
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583AD282712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615C1991CA;
	Thu, 28 Nov 2024 10:07:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96537194091;
	Thu, 28 Nov 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788461; cv=none; b=pWdB7a/CeXkIOqMk4MM9xQ8q7jalK2/++9c5UuIT006RUB/axEmLiU8iD0pcHN/fw+U/EhXaKmHUkI4O5EaQxVAucV3ZiFSpzS+Rdic654xfux/Jry+cvgIXlk97uZLVCGAS5+QH1nPZY3ushrdjlhDWtwMkpuDdihIdnoFdte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788461; c=relaxed/simple;
	bh=75g8iLZj0SsTOis1QL83NQYLsvToFXQk2vfMPoPKTfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp3O3OxK7XhCJIMcKkdegrFhfC6i7WUKF99iAgGF34Mx/5QpaorIWqysAhieEvJ96l7XXKeggrYiSwiWK4zrw9jctmK0fOZIXTBjjeX7R3EAYnmSC4LVUaJXjp9+zw2GO9HxtElrTtli3GDesY4mto0aWaVNb3B4HzSVR/lNAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XzWfd6sGWz9v7QC;
	Thu, 28 Nov 2024 17:46:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8AE501402C1;
	Thu, 28 Nov 2024 18:07:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnj365QEhn6eNzAg--.15234S7;
	Thu, 28 Nov 2024 11:07:36 +0100 (CET)
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
Subject: [PATCH v2 5/7] ima: Set security.ima on file close when ima_appraise=fix
Date: Thu, 28 Nov 2024 11:06:18 +0100
Message-ID: <20241128100621.461743-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAnj365QEhn6eNzAg--.15234S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDXFW8urWxtF1Dur43trb_yoW7JFWfpa
	90g3WUKrykWFWfurWkAa47CFWFk3yjgFWUWw45J3WqvFn3Xr10vr1rJr129Fy5Xr90yw1x
	twsFgw45Aw4vy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jxwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGdH1XMCqgAAsp

From: Roberto Sassu <roberto.sassu@huawei.com>

IMA-Appraisal implements a fix mode, selectable from the kernel command
line by specifying ima_appraise=fix.

The fix mode is meant to be used in a TOFU (trust on first use) model,
where systems are supposed to work under controlled conditions before the
real enforcement starts.

Since the systems are under controlled conditions, it is assumed that the
files are not corrupted, and thus their current data digest can be trusted,
and written to security.ima.

When IMA-Appraisal is switched to enforcing mode, the security.ima value
collected during the fix mode is used as a reference value, and a mismatch
with the current value cause the access request to be denied.

However, since fixing security.ima is placed in ima_appraise_measurement()
during the integrity check, it requires the inode lock to be taken in
process_measurement(), in addition to ima_update_xattr() invoked at file
close.

Postpone the security.ima update to ima_check_last_writer(), by setting the
new atomic flag IMA_UPDATE_XATTR_FIX in the inode integrity metadata, in
ima_appraise_measurement(), if security.ima needs to be fixed. In this way,
the inode lock can be removed from process_measurement(). Also, set the
cause appropriately for the fix operation and for allowing access to new
and empty signed files.

Finally, update security.ima when IMA_UPDATE_XATTR_FIX is set, and when
there wasn't a previous security.ima update, which occurs if the process
closing the file descriptor is the last writer.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_appraise.c |  7 +++++--
 security/integrity/ima/ima_main.c     | 18 +++++++++++-------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b4eeab48f08a..22c3b87cfcac 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -179,6 +179,7 @@ struct ima_kexec_hdr {
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_UPDATE_XATTR_FIX	5
 
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..94401de8b805 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -576,8 +576,10 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
-			if (!ima_fix_xattr(dentry, iint))
-				status = INTEGRITY_PASS;
+			/* Fix by setting security.ima on file close. */
+			set_bit(IMA_UPDATE_XATTR_FIX, &iint->atomic_flags);
+			status = INTEGRITY_PASS;
+			cause = "fix";
 		}
 
 		/*
@@ -587,6 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
 		    test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
 			status = INTEGRITY_PASS;
+			cause = "new-signed-file";
 		}
 
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1e474ff6a777..50b37420ea2c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -158,13 +158,16 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
 	fmode_t mode = file->f_mode;
-	bool update;
+	bool update = false, update_fix;
 
-	if (!(mode & FMODE_WRITE))
+	update_fix = test_and_clear_bit(IMA_UPDATE_XATTR_FIX,
+					&iint->atomic_flags);
+
+	if (!(mode & FMODE_WRITE) && !update_fix)
 		return;
 
 	ima_iint_lock(inode);
-	if (atomic_read(&inode->i_writecount) == 1) {
+	if (atomic_read(&inode->i_writecount) == 1 && (mode & FMODE_WRITE)) {
 		struct kstat stat;
 
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
@@ -181,6 +184,10 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 				ima_update_xattr(iint, file);
 		}
 	}
+
+	if (!update && update_fix)
+		ima_update_xattr(iint, file);
+
 	ima_iint_unlock(inode);
 }
 
@@ -378,13 +385,10 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
-		if (rc != -EPERM) {
-			inode_lock(inode);
+		if (rc != -EPERM)
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
 						      xattr_len, modsig);
-			inode_unlock(inode);
-		}
 		if (!rc)
 			rc = mmap_violation_check(func, file, &pathbuf,
 						  &pathname, filename);
-- 
2.47.0.118.gfd3785337b


