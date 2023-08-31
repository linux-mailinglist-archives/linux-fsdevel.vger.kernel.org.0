Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2841778EC2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjHaLjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 07:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjHaLjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:39:24 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F776BC;
        Thu, 31 Aug 2023 04:39:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbzQr3hldz9xFQH;
        Thu, 31 Aug 2023 19:27:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHebm+e_BkHQreAQ--.24451S2;
        Thu, 31 Aug 2023 12:38:52 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 20/25] security: Introduce key_post_create_or_update hook
Date:   Thu, 31 Aug 2023 13:37:58 +0200
Message-Id: <20230831113803.910630-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHebm+e_BkHQreAQ--.24451S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWruF13Jw45ZFWUJr4Utwb_yoWrWw18pa
        yYk3W5K3yFkFyaqrZxAF17Way5t3y0gry7K39xWw1rtFnYqa1xXr42kFn8CrW3XryfA340
        va17Zr43GrnFyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj49drAAAsP
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the key_post_create_or_update hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      | 11 +++++++++++
 security/keys/key.c           |  7 ++++++-
 security/security.c           | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eedc26790a07..7512b4c46aa8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -399,6 +399,9 @@ LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
 	 enum key_need_perm need_perm)
 LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
+LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
+	 struct key *key, const void *payload, size_t payload_len,
+	 unsigned long flags, bool create)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/include/linux/security.h b/include/linux/security.h
index e543ae80309b..f50b78481753 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1959,6 +1959,9 @@ void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm);
 int security_key_getsecurity(struct key *key, char **_buffer);
+void security_key_post_create_or_update(struct key *keyring, struct key *key,
+					const void *payload, size_t payload_len,
+					unsigned long flags, bool create);
 
 #else
 
@@ -1986,6 +1989,14 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
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
index 5c0c7df833f8..0f9c6faf3491 100644
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
index 32c3dc34432e..e6783c2f0c65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5169,6 +5169,25 @@ int security_key_getsecurity(struct key *key, char **buffer)
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

