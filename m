Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187DB571A1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 14:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiGLMfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiGLMf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8494B26137
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657629327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6Oxuau9mdcJyn5Csp6BWf4d97wuR60ZGEZCqIDkQm8=;
        b=g/NeyhN+C/tEVsFyAHrVYYa79slWYXCBqDiwMdv3oxVho38D/Zzoe+pS1+HpQ3usEYYLqa
        qPdJDDLGupbENoQhtZoSqKrwRcEjuqGern8Uemuh8+Lwj5oJrmhvtUNSbeOBYhQx83u7xN
        dhW/PIPJ5U38SqrW6n+xAklYbVYT4ME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-LBTBh47VMRKHDvhTr-OusA-1; Tue, 12 Jul 2022 08:35:22 -0400
X-MC-Unique: LBTBh47VMRKHDvhTr-OusA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16714811E84;
        Tue, 12 Jul 2022 12:35:22 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD984C2811A;
        Tue, 12 Jul 2022 12:35:21 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 67DA110C30E2; Tue, 12 Jul 2022 08:35:21 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, Ian Kent <raven@themaw.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] KEYS: Add keyagent request_key
Date:   Tue, 12 Jul 2022 08:35:21 -0400
Message-Id: <061dd6fe81dc97a4375e52ec0da20a54cf582cb5.1657624639.git.bcodding@redhat.com>
In-Reply-To: <cover.1657624639.git.bcodding@redhat.com>
References: <cover.1657624639.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During key construction, search the calling process' session keyring for a
keyagent key with a description that matches the requested key_type.  If
found, link the authkey into the keyagent's process_keyring, and signal the
keyagent task with a realtime signal containing the serial number of the
key that needs to be constructed.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/uapi/asm-generic/siginfo.h |  1 +
 security/keys/internal.h           |  4 ++
 security/keys/keyagent.c           | 85 ++++++++++++++++++++++++++++++
 security/keys/request_key.c        |  9 ++++
 4 files changed, 99 insertions(+)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index ffbe4cec9f32..542e297f4466 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -185,6 +185,7 @@ typedef struct siginfo {
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 #define SI_TKILL	-6		/* sent by tkill system call */
 #define SI_DETHREAD	-7		/* sent by execve() killing subsidiary threads */
+#define SI_KEYAGENT	-8		/* sent by request-key */
 #define SI_ASYNCNL	-60		/* sent by glibc async name lookup completion */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..a6db6eecfff5 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -372,5 +372,9 @@ static inline void key_check(const struct key *key)
 
 #define key_check(key) do {} while(0)
 
+#endif
+
+#ifdef CONFIG_KEYAGENT
+extern int keyagent_request_key(struct key *authkey, void *aux);
 #endif
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyagent.c b/security/keys/keyagent.c
index 87ebfe00c710..cf70146925f0 100644
--- a/security/keys/keyagent.c
+++ b/security/keys/keyagent.c
@@ -9,8 +9,11 @@
 #include <linux/slab.h>
 #include <linux/key.h>
 #include <linux/key-type.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
 
 #include <keys/user-type.h>
+#include <keys/request_key_auth-type.h>
 
 /*
  * Keyagent key payload.
@@ -20,6 +23,88 @@ struct keyagent {
 	int sig;
 };
 
+struct key_type key_type_keyagent;
+
+/*
+ * Given a key representing a keyagent and a target_key to construct, link
+ * the the authkey into the keyagent's process_keyring and signal the
+ * keyagent to construct the target_key.
+ */
+static int keyagent_signal(struct key *ka_key, struct key *target_key,
+							struct key *authkey)
+{
+	struct keyagent *ka = ka_key->payload.data[0];
+	struct task_struct *task;
+	const struct cred *cred;
+	kernel_siginfo_t info = {
+		.si_code = SI_KEYAGENT,
+		.si_signo = ka->sig,
+		.si_int = target_key->serial,
+	};
+	int ret = -ENOKEY;
+
+	task = get_pid_task(ka->pid, PIDTYPE_PID);
+	/* If the task is gone, should we revoke the keyagent key? */
+	if (!task) {
+		key_revoke(ka_key);
+		goto out;
+	}
+
+	/* We're expecting valid keyagents to have a process keyring,
+	 * if not, should we warn? */
+	cred = get_cred(task->cred);
+	if (!cred->process_keyring)
+		goto out_nolink;
+
+	/* Link the autkey to the keyagent's process_keyring */
+	ret = key_link(cred->process_keyring, authkey);
+	if (ret < 0)
+		goto out_nolink;
+
+	ret = send_sig_info(ka->sig, &info, task);
+
+out_nolink:
+	put_cred(cred);
+	put_task_struct(task);
+out:
+	return ret;
+}
+
+/*
+ * Search the calling process' keyrings for a keyagent that
+ * matches the requested key type.  If found, signal the keyagent
+ * to construct and link the key, else return -ENOKEY.
+ */
+int keyagent_request_key(struct key *authkey, void *aux)
+{
+	struct key *ka_key, *target_key;
+	struct request_key_auth *rka;
+	key_ref_t ka_ref;
+	const struct cred *cred = current_cred();
+	int ret;
+
+	/* We must be careful not to touch authkey and aux if
+	 * returning -ENOKEY, since it will be reused.   */
+	rka = get_request_key_auth(authkey);
+	target_key = rka->target_key;
+
+	/* Does the calling process have a keyagent in its session keyring? */
+	ka_ref = keyring_search(
+					make_key_ref(cred->session_keyring, 1),
+					&key_type_keyagent,
+					target_key->type->name, false);
+
+	if (IS_ERR(ka_ref))
+		return -ENOKEY;
+
+	/* We found a keyagent, let's call out to it. */
+	ka_key = key_ref_to_ptr(ka_ref);
+	ret = keyagent_signal(ka_key, target_key, authkey);
+	key_put(key_ref_to_ptr(ka_ref));
+
+	return ret;
+}
+
 /*
  * Instantiate takes a reference to the current task's struct pid
  * and the requested realtime signal number.
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2da4404276f0..4c1f5ef55856 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -240,9 +240,18 @@ static int construct_key(struct key *key, const void *callout_info,
 	actor = call_sbin_request_key;
 	if (key->type->request_key)
 		actor = key->type->request_key;
+#ifdef CONFIG_KEYAGENT
+	else {
+		ret = keyagent_request_key(authkey, aux);
 
+		/* ENOKEY: no keyagents match on calling process' keyrings */
+		if (ret != -ENOKEY)
+			goto done;
+	}
+#endif
 	ret = actor(authkey, aux);
 
+done:
 	/* check that the actor called complete_request_key() prior to
 	 * returning an error */
 	WARN_ON(ret < 0 &&
-- 
2.31.1

