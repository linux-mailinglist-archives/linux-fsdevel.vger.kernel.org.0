Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5724F571A17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 14:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiGLMf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiGLMf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94ABF26137
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657629323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mahips1lu0ySaTvg9gVpfKQSOO+wb9pXCCegZia8ars=;
        b=M/ViHhxOxvNwlBi+RRykdQ/AQh5YgdVCvnIDAYD/OrMGYHBagvCJiHfg52k3TUT+6IwGH0
        wnogNNtzPerBDNLPbu8bkhhh7I4/L1q+1I4qCV8C+dQ+b+uD2ZJofgzOpEiMdJ0pLd79Fl
        +dNb3aku/peisyjPSQxSXQ8EqLCaHMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-0S4qp9sdOfi3PS15Qd8Fig-1; Tue, 12 Jul 2022 08:35:22 -0400
X-MC-Unique: 0S4qp9sdOfi3PS15Qd8Fig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1039918E0043;
        Tue, 12 Jul 2022 12:35:22 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDA06C28129;
        Tue, 12 Jul 2022 12:35:21 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 59EB010C30E1; Tue, 12 Jul 2022 08:35:21 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, Ian Kent <raven@themaw.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] KEYS: Add key_type keyagent
Date:   Tue, 12 Jul 2022 08:35:20 -0400
Message-Id: <65d37935ce8cc978430f93b831482e9455b9186d.1657624639.git.bcodding@redhat.com>
In-Reply-To: <cover.1657624639.git.bcodding@redhat.com>
References: <cover.1657624639.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define and register a new key_type called keyagent.  When instantiated,
keyagent keys take a reference on the struct pid of the current task, and
store a number between SIGRTMIN and SIGRTMAX.

In a later patch, we'll use that number to send a realtime signal to the
keyagent task in order to answer request-key callouts for other key types.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 security/keys/Kconfig    |  9 +++++
 security/keys/Makefile   |  1 +
 security/keys/keyagent.c | 73 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 security/keys/keyagent.c

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index abb03a1b2a5c..f31a0f94ca88 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -112,6 +112,15 @@ config USER_DECRYPTED_DATA
 
 	  If you are unsure as to whether this is required, answer N.
 
+config KEYAGENT
+	bool "KEYAGENT"
+	depends on KEYS
+	help
+	  This option allows persistent userland processes to answer
+	  request-key callouts.
+
+	  If you are unsure as to whether this is required, answer N.
+
 config KEY_DH_OPERATIONS
        bool "Diffie-Hellman operations on retained keys"
        depends on KEYS
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 5f40807f05b3..c753f8f79c38 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SYSCTL) += sysctl.o
 obj-$(CONFIG_PERSISTENT_KEYRINGS) += persistent.o
 obj-$(CONFIG_KEY_DH_OPERATIONS) += dh.o
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
+obj-$(CONFIG_KEYAGENT) += keyagent.o
 
 #
 # Key types
diff --git a/security/keys/keyagent.c b/security/keys/keyagent.c
new file mode 100644
index 000000000000..87ebfe00c710
--- /dev/null
+++ b/security/keys/keyagent.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Key Agent handling
+ *
+ * Copyright (C) 2022 Red Hat Inc. All Rights Reserved.
+ * Written by Benjamin Coddington (bcodding@redhat.com)
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/key.h>
+#include <linux/key-type.h>
+
+#include <keys/user-type.h>
+
+/*
+ * Keyagent key payload.
+ */
+struct keyagent {
+	struct pid *pid;
+	int sig;
+};
+
+/*
+ * Instantiate takes a reference to the current task's struct pid
+ * and the requested realtime signal number.
+ */
+static int
+keyagent_instantiate(struct key *key, struct key_preparsed_payload *prep)
+{
+	struct keyagent *ka;
+	__be16 sig = *(__be16 *)prep->data;
+
+	/* Only real-time signals numbers allowed */
+	if (sig < SIGRTMIN || sig > SIGRTMAX)
+		return -EINVAL;
+
+	ka = kzalloc(sizeof(struct keyagent), GFP_KERNEL);
+	if (!ka)
+		return -ENOMEM;
+
+	ka->pid = get_task_pid(current, PIDTYPE_PID);
+	ka->sig = sig;
+	key->payload.data[0] = ka;
+
+	return 0;
+}
+
+static void keyagent_destroy(struct key *key)
+{
+	struct keyagent *ka = key->payload.data[0];
+
+	put_pid(ka->pid);
+	kfree(ka);
+}
+
+/*
+ * keyagent keys represent userland processes waiting on signals from the
+ * kernel to respond to request-key callouts
+ */
+struct key_type key_type_keyagent = {
+	.name			= "keyagent",
+	.instantiate	= keyagent_instantiate,
+	.def_datalen	= sizeof(struct keyagent),
+	.destroy		= keyagent_destroy,
+	.describe		= user_describe,
+};
+
+static int __init keyagent_init(void)
+{
+	return register_key_type(&key_type_keyagent);
+}
+
+late_initcall(keyagent_init);
-- 
2.31.1

