Return-Path: <linux-fsdevel+bounces-11689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C6856144
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 12:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB47DB27833
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4D12EBFA;
	Thu, 15 Feb 2024 10:37:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0931350EB;
	Thu, 15 Feb 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993453; cv=none; b=R2rgFljw3NUefMl9+YrdNqM0bcYm8tbfXG6G4Q/tOt/TBUhIaIBex8K7xz/2fk7L0e4u3D8qK1K0d8I8EDIJDpv/u8GgT7EL9l2BRftZqafCYSmxXZwN04BTtMkijJgFATNYQ7kVo0e7bZD2eMDXzuuNT1rLGr37QUG7ICeY7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993453; c=relaxed/simple;
	bh=6pDNjirN0csgffvdwyGCh7PvsfoDg+SXCp+EeNhVQTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfRLOWWhJ0mcRWQr8JJ5BnP1TMhFJIQOIcbreB0U1gdzlsaW1MBW9gUzyfmb8wRkL1eIpjb/b4MtsfaYfYI5AIBKxU7Rn57h16ankaWiX31NCt8GRPjCXParGhRdK66DAROXCDK+RQXqWP3VaLmHaDygpWPUIQQ+2npDeenOOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tb9xl2bGXz9v7Z2;
	Thu, 15 Feb 2024 18:18:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 086C61405A2;
	Thu, 15 Feb 2024 18:37:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxjQ6M1l4QeNAg--.58293S11;
	Thu, 15 Feb 2024 11:37:17 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
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
	omosnace@redhat.com,
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
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 19/25] integrity: Move integrity_kernel_module_request() to IMA
Date: Thu, 15 Feb 2024 11:31:07 +0100
Message-Id: <20240215103113.2369171-20-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwA3LxjQ6M1l4QeNAg--.58293S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar13WF1xZr45Kr1UuF43Awb_yoWxXw17pa
	95KFW5Jry8Zr97CaykAF1xCa45K3yfGrW3WrsxCr1fCFn0vr4qvr47JF13Xry3WrWrJF4F
	grs2qr13Cw1qy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UdfHUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5pfaAAAsX

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for removing the 'integrity' LSM, move
integrity_kernel_module_request() to IMA, and rename it to
ima_kernel_module_request(). Rewrite the function documentation, to explain
better what the problem is.

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
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h                    | 10 ++++++++
 include/linux/integrity.h              | 13 ----------
 security/integrity/digsig_asymmetric.c | 23 ------------------
 security/integrity/ima/ima_main.c      | 33 ++++++++++++++++++++++++++
 security/security.c                    |  2 +-
 5 files changed, 44 insertions(+), 37 deletions(-)

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
index 02021ee467d3..3891b83efdb3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1091,6 +1091,39 @@ int ima_measure_critical_data(const char *event_label,
 }
 EXPORT_SYMBOL_GPL(ima_measure_critical_data);
 
+#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+
+/**
+ * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
+ * @kmod_name: kernel module name
+ *
+ * Avoid a verification loop where verifying the signature of the modprobe
+ * binary requires executing modprobe itself. Since the modprobe iint->mutex
+ * is already held when the signature verification is performed, a deadlock
+ * occurs as soon as modprobe is executed within the critical region, since
+ * the same lock cannot be taken again.
+ *
+ * This happens when public_key_verify_signature(), in case of RSA algorithm,
+ * use alg_name to store internal information in order to construct an
+ * algorithm on the fly, but crypto_larval_lookup() will try to use alg_name
+ * in order to load a kernel module with same name.
+ *
+ * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
+ * we are safe to fail such module request from crypto_larval_lookup(), and
+ * avoid the verification loop.
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
index f8d9ebeb4c31..48dc3db4c834 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3250,7 +3250,7 @@ int security_kernel_module_request(char *kmod_name)
 	ret = call_int_hook(kernel_module_request, 0, kmod_name);
 	if (ret)
 		return ret;
-	return integrity_kernel_module_request(kmod_name);
+	return ima_kernel_module_request(kmod_name);
 }
 
 /**
-- 
2.34.1


