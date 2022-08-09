Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB158DD12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiHIRXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiHIRXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60B5F2529D
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660065799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6atus4XK2PeR0rSaAyXK58PrEh9v2DgHX9trvgun/Tk=;
        b=PsB0oD+QCTT3mUBdjc0dZCsgQxrUdyM16VNKdxAyrD7dQpWCSOlIjTI/HdpIcaugZoURyF
        mOoRjWEMJpTjYm5AgCi/FldZiQRk1gue3HVq7fsZKQQrcslLsdeaQOuWDuUBRkNAw5HcJF
        k/qpjnDV3ErecYhqxAwo2z/krilubrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-f4s3AowUNGmSsnDK0zHK5Q-1; Tue, 09 Aug 2022 13:23:16 -0400
X-MC-Unique: f4s3AowUNGmSsnDK0zHK5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 912811019C8D;
        Tue,  9 Aug 2022 17:23:15 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49DEB9457F;
        Tue,  9 Aug 2022 17:23:14 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Tue,  9 Aug 2022 13:22:54 -0400
Message-Id: <c4ae9b882c07ea9cac64094294da5edc0756bb50.1659996830.git.rgb@redhat.com>
In-Reply-To: <cover.1659996830.git.rgb@redhat.com>
References: <cover.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch passes the full value so that the audit function can use all
of it. The audit function was updated to log the additional information in
the AUDIT_FANOTIFY record. The following is an example of the new record
format:

type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=17

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/notify/fanotify/fanotify.c |  3 ++-
 include/linux/audit.h         |  9 +++++----
 kernel/auditsc.c              | 31 ++++++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 0f36062521f4..36c3ed1af085 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -276,7 +276,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	/* Check if the response should be audited */
 	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT);
+		audit_fanotify(event->response & ~FAN_AUDIT,
+			       event->info_len, event->info_buf);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
 		 group, event, ret);
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 3ea198a2cd59..c69efdba12ca 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -14,6 +14,7 @@
 #include <linux/audit_arch.h>
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
+#include <uapi/linux/fanotify.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -417,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
 extern void __audit_log_kern_module(char *name);
-extern void __audit_fanotify(u32 response);
+extern void __audit_fanotify(u32 response, size_t len, char *buf);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
@@ -524,10 +525,10 @@ static inline void audit_log_kern_module(char *name)
 		__audit_log_kern_module(name);
 }
 
-static inline void audit_fanotify(u32 response)
+static inline void audit_fanotify(u32 response, size_t len, char *buf)
 {
 	if (!audit_dummy_context())
-		__audit_fanotify(response);
+		__audit_fanotify(response, len, buf);
 }
 
 static inline void audit_tk_injoffset(struct timespec64 offset)
@@ -684,7 +685,7 @@ static inline void audit_log_kern_module(char *name)
 {
 }
 
-static inline void audit_fanotify(u32 response)
+static inline void audit_fanotify(u32 response, size_t len, char *buf)
 { }
 
 static inline void audit_tk_injoffset(struct timespec64 offset)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 433418d73584..f000fec52360 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -64,6 +64,7 @@
 #include <uapi/linux/limits.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/openat2.h> // struct open_how
+#include <uapi/linux/fanotify.h>
 
 #include "audit.h"
 
@@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
 	context->type = AUDIT_KERN_MODULE;
 }
 
-void __audit_fanotify(u32 response)
+void __audit_fanotify(u32 response, size_t len, char *buf)
 {
-	audit_log(audit_context(), GFP_KERNEL,
-		AUDIT_FANOTIFY,	"resp=%u", response);
+	struct fanotify_response_info_audit_rule *friar;
+	size_t c = len;
+	char *ib = buf;
+
+	if (!(len && buf)) {
+		audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+			  "resp=%u fan_type=0 fan_info=?", response);
+		return;
+	}
+	while (c >= sizeof(struct fanotify_response_info_header)) {
+		friar = (struct fanotify_response_info_audit_rule *)buf;
+		switch (friar->hdr.type) {
+		case FAN_RESPONSE_INFO_AUDIT_RULE:
+			if (friar->hdr.len < sizeof(*friar)) {
+				audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+					  "resp=%u fan_type=%u fan_info=(incomplete)",
+					  response, friar->hdr.type);
+				return;
+			}
+			audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+				  "resp=%u fan_type=%u fan_info=%u",
+				  response, friar->hdr.type, friar->audit_rule);
+		}
+		c -= friar->hdr.len;
+		ib += friar->hdr.len;
+	}
 }
 
 void __audit_tk_injoffset(struct timespec64 offset)
-- 
2.27.0

