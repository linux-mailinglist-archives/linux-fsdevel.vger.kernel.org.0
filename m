Return-Path: <linux-fsdevel+bounces-37209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB4F9EF971
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104771798BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79D223E8D;
	Thu, 12 Dec 2024 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sjq46jaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A5223316
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025375; cv=none; b=MBqthe3oI+zaM48VS5yzwJ7oRuwAFAv5KiBsfwqEGspObfjeSbziU21gmCoUpALOf3G6oO4QcTJmqprxdgee0MOE7cuwMBeD0mglqYqsG345ZvHQfe+Dbvgx74Rzsc7Hu22VQYYsJv0jbU34iVXw+3tDhbhJvKNZ1wRVWnEoMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025375; c=relaxed/simple;
	bh=XXvI0TX1xzAn48I8sTlwK/qf6xAhPIm9D4CPl/Tq860=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSI1K1zrA4ym44iykzVdJ1YbpYZnJtxxe9TNkN4kOsUxcegiIpRCEetp8DMD48wI6xZab04T9uTDLcq9UNnhAHAqklbmht3/AwFpAWz400zZQEq88OJKTOeupyccOcz4NMbhHP+sRPWB716ES6NRQM1G0wXB8olcvpMcIMk3Og0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sjq46jaz; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y8KYj5qltz14n;
	Thu, 12 Dec 2024 18:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734025369;
	bh=XB5FDSOElLippt2L4YJKGDqg0dFGAnXejgtIjP9qLjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjq46jazjleJeRddEA8ulwHmUTQMvum/t5OcXWXwDqoNI2vhg1EqFMBcVZmwbKjHl
	 QnRfB7WW06oSxWO/Gjjd0a3zwMhlWhDyQ23PuUEB48AEDg2y2bCu1PWuJKm9H95knq
	 FhSE6FI3rnqSH0c90EMgci6dFHzuNA25Ahdp//b0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y8KYh372fz46M;
	Thu, 12 Dec 2024 18:42:48 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v23 8/8] ima: instantiate the bprm_creds_for_exec() hook
Date: Thu, 12 Dec 2024 18:42:23 +0100
Message-ID: <20241212174223.389435-9-mic@digikod.net>
In-Reply-To: <20241212174223.389435-1-mic@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Mimi Zohar <zohar@linux.ibm.com>

Like direct file execution (e.g. ./script.sh), indirect file execution
(e.g. sh script.sh) needs to be measured and appraised.  Instantiate
the new security_bprm_creds_for_exec() hook to measure and verify the
indirect file's integrity.  Unlike direct file execution, indirect file
execution is optionally enforced by the interpreter.

Differentiate kernel and userspace enforced integrity audit messages.

Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241212174223.389435-9-mic@digikod.net
---

I added both a Reviewed-by and a Signed-off-by because I may not be the
committer.

Changes since v22:
* Add Stefan's Tested-by.
* Replace AUDIT_INTEGRITY_DATA_CHECK with AUDIT_INTEGRITY_USERSPACE as
  spotted by Paul and suggested by Mimi.

Changes since v21:
* New patch cherry-picked from IMA's patch v3:
  https://lore.kernel.org/r/67b2e94f263bf9a0099efe74cce659d6acb16fe9.camel@linux.ibm.com
* Fix a typo in comment: s/execvat/execveat/ .
---
 include/uapi/linux/audit.h            |  1 +
 security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
 security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 75e21a135483..d9a069b4a775 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -161,6 +161,7 @@
 #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
 #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
 #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
+#define AUDIT_INTEGRITY_USERSPACE   1808 /* Userspace enforced data integrity */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 884a3533f7af..f435eff4667f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/file.h>
+#include <linux/binfmts.h>
 #include <linux/fs.h>
 #include <linux/xattr.h>
 #include <linux/magic.h>
@@ -469,6 +470,17 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
+static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
+{
+	struct linux_binprm *bprm;
+
+	if (func == BPRM_CHECK) {
+		bprm = container_of(&file, struct linux_binprm, file);
+		return bprm->is_check;
+	}
+	return false;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -483,6 +495,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     int xattr_len, const struct modsig *modsig)
 {
 	static const char op[] = "appraise_data";
+	int audit_msgno = AUDIT_INTEGRITY_DATA;
 	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
@@ -494,6 +507,16 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
 		return INTEGRITY_UNKNOWN;
 
+	/*
+	 * Unlike any of the other LSM hooks where the kernel enforces file
+	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
+	 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretion
+	 * of the script interpreter(userspace). Differentiate kernel and
+	 * userspace enforced integrity audit messages.
+	 */
+	if (is_bprm_creds_for_exec(func, file))
+		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
+
 	/* If reading the xattr failed and there's no modsig, error out. */
 	if (rc <= 0 && !try_modsig) {
 		if (rc && rc != -ENODATA)
@@ -569,7 +592,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
@@ -589,7 +612,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			status = INTEGRITY_PASS;
 		}
 
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else {
 		ima_cache_flags(iint, func);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..9f9897a7c217 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -554,6 +554,34 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 				   MAY_EXEC, CREDS_CHECK);
 }
 
+/**
+ * ima_bprm_creds_for_exec - collect/store/appraise measurement.
+ * @bprm: contains the linux_binprm structure
+ *
+ * Based on the IMA policy and the execveat(2) AT_EXECVE_CHECK flag, measure
+ * and appraise the integrity of a file to be executed by script interpreters.
+ * Unlike any of the other LSM hooks where the kernel enforces file integrity,
+ * enforcing file integrity is left up to the discretion of the script
+ * interpreter (userspace).
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	/*
+	 * As security_bprm_check() is called multiple times, both
+	 * the script and the shebang interpreter are measured, appraised,
+	 * and audited. Limit usage of this LSM hook to just measuring,
+	 * appraising, and auditing the indirect script execution
+	 * (e.g. ./sh example.sh).
+	 */
+	if (!bprm->is_check)
+		return 0;
+
+	return ima_bprm_check(bprm);
+}
+
 /**
  * ima_file_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
@@ -1174,6 +1202,7 @@ static int __init init_ima(void)
 
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
+	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
 	LSM_HOOK_INIT(file_post_open, ima_file_check),
 	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
 	LSM_HOOK_INIT(file_release, ima_file_free),
-- 
2.47.1


