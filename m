Return-Path: <linux-fsdevel+bounces-37661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2A9F57A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F214188F701
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2881FA14E;
	Tue, 17 Dec 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koEEiMPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EA1F9F77;
	Tue, 17 Dec 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467153; cv=none; b=q00dulzop4sdzVv+1SSmHReb9jC2Pyup/Fd4mpp8KZ0ATt9XWdbIwxKRWROQNLYfGxSc2ZlUarLIu6CSW8tznxKL+ziXS6ja+t8/1Jre+K2fd7Dku1G6F+vVQpOmRN+3kHrG01jjmZmm9c1+VGqICSoeuGzmy6i/HvFNrb8R4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467153; c=relaxed/simple;
	bh=lgrEhA3p/nfcS2IPzQr3OFtILmjK5zVqv5Y3OF2r6nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDvbrPPWe1qbaxdZDbfsMyhw3bg0zoyESy9hyHmXps+R1hOeHXGkdOSM27iDSuXyIIhTncDUwZih7ZJvBjlihg1/4uirvx6F0Ny872DX4SvTUCFeazPdJBV4ppkUi8YV8h+M4n5ssTlAPmsN4Wa7UwuM6LBeplnNerzHlstpxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koEEiMPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EF1C4CED3;
	Tue, 17 Dec 2024 20:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467153;
	bh=lgrEhA3p/nfcS2IPzQr3OFtILmjK5zVqv5Y3OF2r6nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koEEiMPRl8DVzHhxNihZocA27hEs/V+Un1u1RoXBY2sc1qH7AY42JonV+Uzqc3R5h
	 1jkMG2U5J+dqAzq2Ou1L7ubfxcoUy7W+U5At6o3D0+z5oyfjqYS6myOv9gCZTUxRkT
	 5Xc5z6tG5z3JbxM2ZStjQ47ZEwIH4FmPcaKsBOzUItaEXef54+KjhUTA+JcclP2nKS
	 VRrz756zQG/VXICdXatXp8QlNARTnxVugDFsSTvSAFZRDbVJZBZUXUBgqSnYyFootF
	 NDLYhY7I0l0v2EfNbcAe7ke8QdlOC7ihFHw04PgDAg3W/ZjJX7bDfWx4nEDoeWwYhB
	 +he8vESDuHxmQ==
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
	Song Liu <song@kernel.org>
Subject: [RFC 2/2] evm: Add kernel parameter to disable EVM
Date: Tue, 17 Dec 2024 12:25:25 -0800
Message-ID: <20241217202525.1802109-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217202525.1802109-1-song@kernel.org>
References: <20241217202525.1802109-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides kernel parameter 'evm=' that disables EVM.
This will reduce memory consumption by the EVM when it is not needed.
Specifically, this saves one evm_iint_cache per inode in the system.

Originally-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 security/integrity/evm/evm.h       |  6 ++++++
 security/integrity/evm/evm_main.c  | 22 ++++++++++++++--------
 security/integrity/evm/evm_secfs.c |  3 ++-
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 51aba5a54275..64428c35e4cf 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -17,6 +17,10 @@
 
 #include "../integrity.h"
 
+#define EVM_MODE_OFF	0
+#define EVM_MODE_ON	1
+#define EVM_MODE_FIX	2
+
 #define EVM_INIT_HMAC	0x0001
 #define EVM_INIT_X509	0x0002
 #define EVM_ALLOW_METADATA_WRITES	0x0004
@@ -26,6 +30,8 @@
 #define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP_COMPLETE | \
 		       EVM_ALLOW_METADATA_WRITES)
 
+extern int evm_mode;
+
 struct xattr_list {
 	struct list_head list;
 	char *name;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 377e57e9084f..738c38f8190d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -72,17 +72,19 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
-static int evm_fixmode __ro_after_init;
-static int __init evm_set_fixmode(char *str)
+int evm_mode __ro_after_init = EVM_MODE_ON;
+
+static int __init evm_setup(char *str)
 {
-	if (strncmp(str, "fix", 3) == 0)
-		evm_fixmode = 1;
+	if (strncmp(str, "off", 3) == 0)
+		evm_mode = EVM_MODE_OFF;
+	else if (strncmp(str, "fix", 3) == 0)
+		evm_mode = EVM_MODE_FIX;
 	else
 		pr_err("invalid \"%s\" mode", str);
-
-	return 1;
+	return 0;
 }
-__setup("evm=", evm_set_fixmode);
+__setup("evm=", evm_setup);
 
 static void __init evm_init_config(void)
 {
@@ -441,7 +443,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
+	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_mode == EVM_MODE_FIX)
 		return INTEGRITY_PASS;
 	return evm_verify_hmac(dentry, NULL, NULL, 0);
 }
@@ -1117,6 +1119,9 @@ static int __init init_evm(void)
 	int error;
 	struct list_head *pos, *q;
 
+	if (evm_mode == EVM_MODE_OFF)
+		return 0;
+
 	evm_init_config();
 
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
@@ -1178,6 +1183,7 @@ DEFINE_LSM(evm) = {
 	.name = "evm",
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
+	.enabled = &evm_mode,
 	.blobs = &evm_blob_sizes,
 };
 
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 9b907c2fee60..65f896cb838e 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -69,7 +69,8 @@ static ssize_t evm_write_key(struct file *file, const char __user *buf,
 	unsigned int i;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE))
+	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE) ||
+	    evm_mode == EVM_MODE_OFF)
 		return -EPERM;
 
 	ret = kstrtouint_from_user(buf, count, 0, &i);
-- 
2.43.5


