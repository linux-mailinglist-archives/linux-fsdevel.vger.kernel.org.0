Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494D3513FBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 02:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353447AbiD2AtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 20:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353360AbiD2AtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 162278879D
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 17:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651193144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efsbKnVljbpA44VkEsgc/rqvDihguP3Jfk2xwnWIRjI=;
        b=X53RAp/aQ/H++cUZOMRrg4MuTLcN6NaB1Qu+WhUEqy7+SycFDmXUezfGaG6Bq5wm8x/s/p
        +CeeptH/BJ7RDCV3h6UFWPg5rHYpO6QxTRb8esKgEUzHq0jphBwmUnxaPgU2RLVZ/BZg47
        Yyr097YvxbC2uBGSTzcgetxmDhTa+9g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-iIghL1NFMjKc8yG4gehxoA-1; Thu, 28 Apr 2022 20:45:42 -0400
X-MC-Unique: iIghL1NFMjKc8yG4gehxoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34C3D281180C;
        Fri, 29 Apr 2022 00:45:42 +0000 (UTC)
Received: from madcap2.tricolour.com (ovpn-0-8.rdu2.redhat.com [10.22.0.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17CF1815A;
        Fri, 29 Apr 2022 00:45:39 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 3/3] fanotify: Allow audit to use the full permission event response
Date:   Thu, 28 Apr 2022 20:44:36 -0400
Message-Id: <23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com>
In-Reply-To: <cover.1651174324.git.rgb@redhat.com>
References: <cover.1651174324.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch passes the full value so that the audit function can use all
of it. The audit function was updated to log the additional information in
the AUDIT_FANOTIFY record. The following is an example of the new record
format:

type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Link: https://lore.kernel.org/r/23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com
---
 fs/notify/fanotify/fanotify.c |  4 +++-
 include/linux/audit.h         |  8 ++++----
 kernel/auditsc.c              | 18 +++++++++++++++---
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 00aff6e29bf8..bb16d9e0f31b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -272,7 +272,9 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	/* Check if the response should be audited */
 	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT);
+		audit_fanotify(event->response & ~FAN_AUDIT,
+			       event->extra_info_type,
+			       (char *)&event->extra_info_buf);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
 		 group, event, ret);
diff --git a/include/linux/audit.h b/include/linux/audit.h
index d06134ac6245..0897128ee43b 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -419,7 +419,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
 extern void __audit_log_kern_module(char *name);
-extern void __audit_fanotify(unsigned int response);
+extern void __audit_fanotify(__u16 response, __u16 type, char *buf);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
@@ -526,10 +526,10 @@ static inline void audit_log_kern_module(char *name)
 		__audit_log_kern_module(name);
 }
 
-static inline void audit_fanotify(unsigned int response)
+static inline void audit_fanotify(__u16 response, __u16 type, char *buf)
 {
 	if (!audit_dummy_context())
-		__audit_fanotify(response);
+		__audit_fanotify(response, type, buf);
 }
 
 static inline void audit_tk_injoffset(struct timespec64 offset)
@@ -686,7 +686,7 @@ static inline void audit_log_kern_module(char *name)
 {
 }
 
-static inline void audit_fanotify(unsigned int response)
+static inline void audit_fanotify(__u16 response, __u16 type, char *buf)
 { }
 
 static inline void audit_tk_injoffset(struct timespec64 offset)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ea2ee1181921..afdbc416069a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -64,6 +64,7 @@
 #include <uapi/linux/limits.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/openat2.h> // struct open_how
+#include <uapi/linux/fanotify.h>
 
 #include "audit.h"
 
@@ -2893,10 +2894,21 @@ void __audit_log_kern_module(char *name)
 	context->type = AUDIT_KERN_MODULE;
 }
 
-void __audit_fanotify(unsigned int response)
+void __audit_fanotify(__u16 response, __u16 type, char *buf)
 {
-	audit_log(audit_context(), GFP_KERNEL,
-		AUDIT_FANOTIFY,	"resp=%u", response);
+	switch (type) {
+	case FAN_RESPONSE_INFO_AUDIT_RULE:
+		audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+			  "resp=%u fan_type=%u fan_ctx=%u",
+			  response, type, (__u32)*buf);
+		break;
+	case FAN_RESPONSE_INFO_AUDIT_NONE:
+	default:
+		audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+			  "resp=%u fan_type=%u fan_ctx=?",
+			  response, type);
+		break;
+	}
 }
 
 void __audit_tk_injoffset(struct timespec64 offset)
-- 
2.27.0

