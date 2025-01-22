Return-Path: <linux-fsdevel+bounces-39857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D49A1979D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B985F188E476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C521638A;
	Wed, 22 Jan 2025 17:26:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACF215175;
	Wed, 22 Jan 2025 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566762; cv=none; b=G5DJ9Ujxd3ubJypopMbzcBhvN8o3O3EXUFxYez5WYpsinV6Z4s1+i7s0WatuHnHST+08CxDtz86BucbP0QRmUqkzuDcaqEjKGX4bBJSRKEV/CqG+z5tThRwQjwuRMSbvlNedrs2MLsbwgpMU1nvRHrx+Bb1ZwXhKa698QCt3GoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566762; c=relaxed/simple;
	bh=P74EnrceI5B+8xgfQAJywqCUhNc1C8eOpKXiA4UtxFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QC+wyaywYyr/XGH2lQ2qOafHDs9yXHC4Q8ZdwqvS3YBhLGk1ftj6knjk2y7lX0Nysiuql/c0gLu6e/Pn8nCXI52K5eATPGgnjR4P7cC6/h0BpAkttwgyaFHbyRqpN2h8wyDmnV5cxi+wcxkskpX7LHR3m6ASLZjeIp9Toq3h2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4YdVlh5JS7z9v7Nd;
	Thu, 23 Jan 2025 01:03:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 11F35140442;
	Thu, 23 Jan 2025 01:25:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEvkKZFnsGscAQ--.5068S7;
	Wed, 22 Jan 2025 18:25:55 +0100 (CET)
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
Subject: [PATCH v3 5/6] ima: Defer fixing security.ima to __fput()
Date: Wed, 22 Jan 2025 18:24:31 +0100
Message-Id: <20250122172432.3074180-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDnbEvkKZFnsGscAQ--.5068S7
X-Coremail-Antispam: 1UD129KBjvJXoW3GF48tr47Zw45Ar4rGr47twb_yoW7tFWDpa
	90qF1UKrykWFWfurWkAay7uFWSk34jgFWUW398J3WvvFn3Xr10qr1rtr17uFy5Xr90yw4x
	tanFgw4UAw4qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGeQmNMFMAAAsf

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

Deferring fixing security.ima has a side effect: metadata of files with an
invalid EVM HMAC cannot be updated until the file is close. In alternative
to waiting, it is also recommended to add 'evm=fix' in the kernel command
line to handle this case (recommendation added to kernel-parameters.txt as
well).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt          |  3 +++
 security/integrity/ima/ima.h                   |  1 +
 security/integrity/ima/ima_appraise.c          |  7 +++++--
 security/integrity/ima/ima_main.c              | 18 +++++++++++-------
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0ca670..07219a3a2ee5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2083,6 +2083,9 @@
 			Format: { "off" | "enforce" | "fix" | "log" }
 			default: "enforce"
 
+			ima_appraise=fix should be used in conjunction with
+			evm=fix, when also inode metadata should be fixed.
+
 	ima_appraise_tcb [IMA] Deprecated.  Use ima_policy= instead.
 			The builtin appraise policy appraises all files
 			owned by uid=0.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f96021637bcf..e1a3d1239bee 100644
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
index 884a3533f7af..ec57b36925cf 100644
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
index 0aed8f730c42..46adfd524dd8 100644
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
+	if ((mode & FMODE_WRITE) && atomic_read(&inode->i_writecount) == 1) {
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
2.34.1


