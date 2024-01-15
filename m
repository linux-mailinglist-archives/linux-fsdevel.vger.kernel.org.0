Return-Path: <linux-fsdevel+bounces-7976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347D882DFA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B51C21FCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F214418ED9;
	Mon, 15 Jan 2024 18:24:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B518C15;
	Mon, 15 Jan 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TDKsm6bybz9yJhy;
	Tue, 16 Jan 2024 02:09:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2E1931406BE;
	Tue, 16 Jan 2024 02:24:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0ia8d6VlgjybAA--.56873S11;
	Mon, 15 Jan 2024 19:24:01 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 19/25] integrity: Move integrity_kernel_module_request() to IMA
Date: Mon, 15 Jan 2024 19:18:03 +0100
Message-Id: <20240115181809.885385-20-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDn0ia8d6VlgjybAA--.56873S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar13WF1rWFyfur15Ww1fXrb_yoW7tw18pw
	s8KFW3Jry8Zr97CaykAF1xua45K3yfGrW3Wwsxur1rAFs8Zr4qvrsrXF17Xry3WFWrJr40
	gFs2qr1ak34qyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU1hiSPUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5iR2gAAsk

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for removing the 'integrity' LSM, move
integrity_kernel_module_request() to IMA, and rename it to
ima_kernel_module_request().

Compile it conditionally if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled,
and call it from security.c (removed afterwards with the move of IMA to the
LSM infrastructure).

Adding this hook cannot be avoided, since IMA has no control on the flags
passed to crypto_alloc_sig() in public_key_verify_signature(), and thus
cannot pass CRYPTO_NOLOAD, which solved the problem for EVM hashing with
commit e2861fa71641 ("evm: Don't deadlock if a crypto algorithm is
unavailable").

EVM alone does not need to implement this hook, first because there is no
mutex to deadlock, and second because even if it had it, there should be a
recursive call. However, since verification from EVM can be initiated only
by setting inode metadata, deadlock would occur if modprobe would do the
same while loading a kernel module (which is unlikely).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/ima.h                    | 10 +++++++++
 include/linux/integrity.h              | 13 ------------
 security/integrity/digsig_asymmetric.c | 23 --------------------
 security/integrity/ima/ima_main.c      | 29 ++++++++++++++++++++++++++
 security/security.c                    |  2 +-
 5 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 31ef6c3c3207..0f9af283cbc8 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -256,4 +256,14 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 	return false;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+#if defined(CONFIG_IMA) && defined(CONFIG_INTEGRITY_ASYMMETRIC_KEYS)
+extern int ima_kernel_module_request(char *kmod_name);
+#else
+static inline int ima_kernel_module_request(char *kmod_name)
+{
+	return 0;
+}
+
+#endif
 #endif /* _LINUX_IMA_H */
diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2ea0f2f65ab6..ef0f63ef5ebc 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -42,17 +42,4 @@ static inline void integrity_load_keys(void)
 }
 #endif /* CONFIG_INTEGRITY */
 
-#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
-
-extern int integrity_kernel_module_request(char *kmod_name);
-
-#else
-
-static inline int integrity_kernel_module_request(char *kmod_name)
-{
-	return 0;
-}
-
-#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
-
 #endif /* _LINUX_INTEGRITY_H */
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 895f4b9ce8c6..de603cf42ac7 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -132,26 +132,3 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	pr_debug("%s() = %d\n", __func__, ret);
 	return ret;
 }
-
-/**
- * integrity_kernel_module_request - prevent crypto-pkcs1pad(rsa,*) requests
- * @kmod_name: kernel module name
- *
- * We have situation, when public_key_verify_signature() in case of RSA
- * algorithm use alg_name to store internal information in order to
- * construct an algorithm on the fly, but crypto_larval_lookup() will try
- * to use alg_name in order to load kernel module with same name.
- * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
- * we are safe to fail such module request from crypto_larval_lookup().
- *
- * In this way we prevent modprobe execution during digsig verification
- * and avoid possible deadlock if modprobe and/or it's dependencies
- * also signed with digsig.
- */
-int integrity_kernel_module_request(char *kmod_name)
-{
-	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
-		return -EINVAL;
-
-	return 0;
-}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 02021ee467d3..908fa026ec58 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1091,6 +1091,35 @@ int ima_measure_critical_data(const char *event_label,
 }
 EXPORT_SYMBOL_GPL(ima_measure_critical_data);
 
+#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+
+/**
+ * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
+ * @kmod_name: kernel module name
+ *
+ * We have situation, when public_key_verify_signature() in case of RSA
+ * algorithm use alg_name to store internal information in order to
+ * construct an algorithm on the fly, but crypto_larval_lookup() will try
+ * to use alg_name in order to load kernel module with same name.
+ * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
+ * we are safe to fail such module request from crypto_larval_lookup().
+ *
+ * In this way we prevent modprobe execution during digsig verification
+ * and avoid possible deadlock if modprobe and/or it's dependencies
+ * also signed with digsig.
+ *
+ * Return: Zero if it is safe to load the kernel module, -EINVAL otherwise.
+ */
+int ima_kernel_module_request(char *kmod_name)
+{
+	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/security.c b/security/security.c
index d2a1226e6e69..6c6571a141a1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3255,7 +3255,7 @@ int security_kernel_module_request(char *kmod_name)
 	ret = call_int_hook(kernel_module_request, 0, kmod_name);
 	if (ret)
 		return ret;
-	return integrity_kernel_module_request(kmod_name);
+	return ima_kernel_module_request(kmod_name);
 }
 
 /**
-- 
2.34.1


