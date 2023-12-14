Return-Path: <linux-fsdevel+bounces-6105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4181380E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBF81C20CF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86E65EB8;
	Thu, 14 Dec 2023 17:14:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918CB1719;
	Thu, 14 Dec 2023 09:14:23 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Srdrg2GnSz9y7ZG;
	Fri, 15 Dec 2023 01:00:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 13C1814064D;
	Fri, 15 Dec 2023 01:14:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHuGFtN3tlDa2DAg--.53313S10;
	Thu, 14 Dec 2023 18:14:10 +0100 (CET)
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
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 18/24] security: Introduce key_post_create_or_update hook
Date: Thu, 14 Dec 2023 18:08:28 +0100
Message-Id: <20231214170834.3324559-19-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHuGFtN3tlDa2DAg--.53313S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43CFW3tryUWF15KFyDWrg_yoWrur4Dpa
	y5K3W5t3ykKFyaqrZxAF12kayrK3y8Kry7K39xWryjkFnYvw4xXr42kFn8CrW5AryfJry0
	va12vrW3GF1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj5OoPwAAs4

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the key_post_create_or_update hook.

Depending on policy, IMA measures the key content after creation or update,
so that remote verifiers are aware of the operation.

Other LSMs could similarly take some action after successful key creation
or update.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      | 11 +++++++++++
 security/keys/key.c           |  7 ++++++-
 security/security.c           | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bfb10a1e6a44..2679905f4260 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -403,6 +403,9 @@ LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
 	 enum key_need_perm need_perm)
 LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
+LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
+	 struct key *key, const void *payload, size_t payload_len,
+	 unsigned long flags, bool create)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/include/linux/security.h b/include/linux/security.h
index 7b753460f09d..766eaccc4679 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1995,6 +1995,9 @@ void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm);
 int security_key_getsecurity(struct key *key, char **_buffer);
+void security_key_post_create_or_update(struct key *keyring, struct key *key,
+					const void *payload, size_t payload_len,
+					unsigned long flags, bool create);
 
 #else
 
@@ -2022,6 +2025,14 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 	return 0;
 }
 
+static inline void security_key_post_create_or_update(struct key *keyring,
+						      struct key *key,
+						      const void *payload,
+						      size_t payload_len,
+						      unsigned long flags,
+						      bool create)
+{ }
+
 #endif
 #endif /* CONFIG_KEYS */
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 0260a1902922..f75fe66c2f03 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -935,6 +935,8 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	security_key_post_create_or_update(keyring, key, payload, plen, flags,
+					   true);
 	ima_post_key_create_or_update(keyring, key, payload, plen,
 				      flags, true);
 
@@ -968,10 +970,13 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
 	key_ref = __key_update(key_ref, &prep);
 
-	if (!IS_ERR(key_ref))
+	if (!IS_ERR(key_ref)) {
+		security_key_post_create_or_update(keyring, key, payload, plen,
+						   flags, false);
 		ima_post_key_create_or_update(keyring, key,
 					      payload, plen,
 					      flags, false);
+	}
 
 	goto error_free_prep;
 }
diff --git a/security/security.c b/security/security.c
index a722d5db0a2c..423d53092604 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5406,6 +5406,25 @@ int security_key_getsecurity(struct key *key, char **buffer)
 	*buffer = NULL;
 	return call_int_hook(key_getsecurity, 0, key, buffer);
 }
+
+/**
+ * security_key_post_create_or_update() - Notification of key create or update
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @payload: data used to instantiate or update the key
+ * @payload_len: length of payload
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Notify the caller of a key creation or update.
+ */
+void security_key_post_create_or_update(struct key *keyring, struct key *key,
+					const void *payload, size_t payload_len,
+					unsigned long flags, bool create)
+{
+	call_void_hook(key_post_create_or_update, keyring, key, payload,
+		       payload_len, flags, create);
+}
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-- 
2.34.1


