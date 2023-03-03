Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D46A9F60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjCCSnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjCCSnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:43:41 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C412BE3;
        Fri,  3 Mar 2023 10:43:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PSx2N2nb4z9xrcx;
        Sat,  4 Mar 2023 02:14:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgKOgJk5iFpAQ--.12605S24;
        Fri, 03 Mar 2023 19:22:55 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 22/28] security: Introduce key_post_create_or_update hook
Date:   Fri,  3 Mar 2023 19:18:36 +0100
Message-Id: <20230303181842.1087717-23-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVgKOgJk5iFpAQ--.12605S24
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fCFy3GryfWFyrtFyDGFg_yoWrWrWUpa
        yYk3W5t3y8KFyaqrZxAF17Way5t3y0gry7K39xu34rtFnYqw4xXr42kFn8CrW5Xry5Ary0
        v3y7ZrW3Gr1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_GcCE3s1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F
        4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j7
        GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4otWgAAsM
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the key_post_create_or_update hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      | 11 +++++++++++
 security/keys/key.c           |  7 ++++++-
 security/security.c           | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6c324fe5099..cf171e65420 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -397,6 +397,9 @@ LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
 	 enum key_need_perm need_perm)
 LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
+LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
+	 struct key *key, const void *payload, size_t payload_len,
+	 unsigned long flags, bool create)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/include/linux/security.h b/include/linux/security.h
index f8df5b69667..be23a303bba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1952,6 +1952,9 @@ void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm);
 int security_key_getsecurity(struct key *key, char **_buffer);
+void security_key_post_create_or_update(struct key *keyring, struct key *key,
+					const void *payload, size_t payload_len,
+					unsigned long flags, bool create);
 
 #else
 
@@ -1979,6 +1982,14 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
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
index 5c0c7df833f..0f9c6faf349 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -934,6 +934,8 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	security_key_post_create_or_update(keyring, key, payload, plen, flags,
+					   true);
 	ima_post_key_create_or_update(keyring, key, payload, plen,
 				      flags, true);
 
@@ -967,10 +969,13 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
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
index b3a9c317f75..322090a50cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5195,6 +5195,25 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 	*_buffer = NULL;
 	return call_int_hook(key_getsecurity, 0, key, _buffer);
 }
+
+/**
+ * security_key_post_create_or_update() - Tell caller of key creation or update
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
2.25.1

