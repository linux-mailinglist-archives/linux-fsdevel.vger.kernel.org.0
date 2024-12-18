Return-Path: <linux-fsdevel+bounces-37702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCF9F5EC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B621655F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820AE156885;
	Wed, 18 Dec 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezhu4+Iq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2A14658C;
	Wed, 18 Dec 2024 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504223; cv=none; b=TbTttFVjWA08jlIYjF2Uz4LCRIenv09NPMQShDYfXdTs6n26rzU1A5Xj4sCH9yOiKZM0lKPHPbL8mH/LRPpNUUqIVZhUupfv5EwjIceX0J/mBJ3yh0T5XPRT4uD071FSOLsE/hhqTHyxzU3SyQKUH+ZMFn8AZ64sy40FGlA3KyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504223; c=relaxed/simple;
	bh=EghMRPzE/D4DHB3sS/SM6PUM66BwpEaBexdzVdfc15g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUjR4mkgnuhzF6VK8KeddSc1gBGl5SuVoYMTrA8TgPWUYdeeW4CM3eWyusVr3vk6Ea+wK6rz0FxLDyQZVPNHwfuhPtr0HH/wNTKjWMcIb65D3J8CKTOSCdQe5/hJBgjl9L0OdGLPBZc9br+8noAab23Ag5yadbBGxwiJ+fgUIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezhu4+Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5E4C4CECE;
	Wed, 18 Dec 2024 06:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734504223;
	bh=EghMRPzE/D4DHB3sS/SM6PUM66BwpEaBexdzVdfc15g=;
	h=From:To:Cc:Subject:Date:From;
	b=Ezhu4+IqWqgmQyel7dt8747oFZfpRHa/v4AlkaG+Pv5B11r7GaAwO2HiycRwjn7Br
	 OIHoNCydK0IezB445et5qu5MG6awAJP+bjahIWyHa1zVRosbW3PqZldk9915wz9Q3r
	 Suy+ELmJ79JKTiwJGaECT8y674agM7Qi72Dev2aEVHYVXntboXKm8v3ghF50gfGz/+
	 Tm0zHGIp662ZM++64nPZ+O2mdVTEbogvYd0uVsBy/7u4KMQpJVG1cIuKKrDliPR7b8
	 UipukmSkWG0cEazHPL9Ar7CenNHyR1nwQZFlanmU/IMb6ubrPKCo5LMLLExUJkb1aN
	 cdjlmaCyGRPfw==
From: Song Liu <song@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kernel-team@meta.com,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	Song Liu <song@kernel.org>
Subject: [PATCH] lsm: integrity: Allow enable/disable ima and evm with lsm= cmdline
Date: Tue, 17 Dec 2024 22:43:28 -0800
Message-ID: <20241218064328.2676938-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let lsm= cmdline option enable and disable ima and evm.

Before the change:
(ima and evm are not enabled in cmdline)
[root@(none) /]# grep -o "lsm.*" /proc/cmdline
lsm=

(but they are actually enabled)
[root@(none) /]# ls /sys/kernel/security/
evm  ima  integrity  lsm
[root@(none) /]# cat /sys/kernel/security/lsm
capability,ima,evm

After the change:
(ima and evm are not enabled in cmdline)
[root@(none) /]# grep -o "lsm=.*" /proc/cmdline
lsm=

(ima and evm are not enabled, as expected)
[root@(none) /]# ls /sys/kernel/security/
integrity  lsm
[root@(none) /]# cat /sys/kernel/security/lsm
capability

(ima and evm are enabled in cmdline)
[root@(none) /]# grep -o "lsm.*" /proc/cmdline
lsm=ima,evm

(ima and evm are enabled, expected)
[root@(none) /]# ls /sys/kernel/security/
evm  ima  integrity  lsm
[root@(none) /]# cat /sys/kernel/security/lsm
capability,ima,evm

Signed-off-by: Song Liu <song@kernel.org>

---

This was discussed in this RFC [1].

[1] https://lore.kernel.org/linux-integrity/20241217202525.1802109-1-song@kernel.org/
---
 security/integrity/evm/evm.h       |  2 ++
 security/integrity/evm/evm_main.c  |  8 ++++++++
 security/integrity/evm/evm_secfs.c |  3 ++-
 security/integrity/ima/ima_main.c  | 10 ++++++++++
 security/security.c                | 14 ++++++++++++--
 5 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 51aba5a54275..4b6dd02df7aa 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -85,4 +85,6 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		  char *hmac_val);
 int evm_init_secfs(void);
 
+bool evm_enabled(void);
+
 #endif
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 377e57e9084f..e7e4a053cbfa 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1117,6 +1117,9 @@ static int __init init_evm(void)
 	int error;
 	struct list_head *pos, *q;
 
+	if (!evm_enabled())
+		return 0;
+
 	evm_init_config();
 
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
@@ -1181,4 +1184,9 @@ DEFINE_LSM(evm) = {
 	.blobs = &evm_blob_sizes,
 };
 
+bool evm_enabled(void)
+{
+	return *__lsm_evm.enabled != 0;
+}
+
 late_initcall(init_evm);
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 9b907c2fee60..9d15be44837d 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -69,7 +69,8 @@ static ssize_t evm_write_key(struct file *file, const char __user *buf,
 	unsigned int i;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE))
+	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE) ||
+	    !evm_enabled())
 		return -EPERM;
 
 	ret = kstrtouint_from_user(buf, count, 0, &i);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..77ef83707fa8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1141,10 +1141,15 @@ static int ima_kernel_module_request(char *kmod_name)
 
 #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
 
+static bool ima_enabled(void);
+
 static int __init init_ima(void)
 {
 	int error;
 
+	if (!ima_enabled())
+		return 0;
+
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
@@ -1217,4 +1222,9 @@ DEFINE_LSM(ima) = {
 	.blobs = &ima_blob_sizes,
 };
 
+static bool ima_enabled(void)
+{
+	return *__lsm_ima.enabled != 0;
+}
+
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/security.c b/security/security.c
index 7523d14f31fb..3036a1e5bffc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -363,8 +363,17 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (strcmp(lsm->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
+				if (lsm->order == LSM_ORDER_MUTABLE) {
 					append_ordered_lsm(lsm, origin);
+				} else if (lsm->order == LSM_ORDER_LAST) {
+					/*
+					 * We cannot append "LAST" LSM yet.
+					 * Set a flag to append it later.
+					 * Use lsm->enabled as the flag.
+					 */
+					set_enabled(lsm, true);
+				}
+
 				found = true;
 			}
 		}
@@ -386,7 +395,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* LSM_ORDER_LAST is always last. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_LAST)
+		/* If the "LAST" LSM is enabled above, append it now. */
+		if (lsm->order == LSM_ORDER_LAST && is_enabled(lsm))
 			append_ordered_lsm(lsm, "   last");
 	}
 
-- 
2.43.5


