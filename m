Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05AE670D39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 00:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjAQXYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 18:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAQXXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D36D36F
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 13:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673990065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snFi/akkKHKx1wGUO+qbDamH+rl7T1sUZRXWgan5xUM=;
        b=EhQ6m9by5ydTje+FaDDVU4Ix3LzESwNxXRbNpBpAIuVAK0H+rBMiFGEO8HaFQFzLUiC+Wu
        taJMXqP+msyPPWSeUFA3ZdMjQqYmseC33z8JykGdlmqlb3WEomlU56oFOnGAxCR/7YRJRq
        7u5JFbF7Pdjrka+kM5Byl+newNoIIBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-deYXeml2PF-FRHVDYXCu6A-1; Tue, 17 Jan 2023 16:14:24 -0500
X-MC-Unique: deYXeml2PF-FRHVDYXCu6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD0228533DA;
        Tue, 17 Jan 2023 21:14:23 +0000 (UTC)
Received: from madcap2.tricolour.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C85AC15BAD;
        Tue, 17 Jan 2023 21:14:22 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full permission event response
Date:   Tue, 17 Jan 2023 16:14:07 -0500
Message-Id: <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
In-Reply-To: <cover.1673989212.git.rgb@redhat.com>
References: <cover.1673989212.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch passes the full response so that the audit function can use all
of it. The audit function was updated to log the additional information in
the AUDIT_FANOTIFY record.

Currently the only type of fanotify info that is defined is an audit
rule number, but convert it to hex encoding to future-proof the field.
Hex encoding suggested by Paul Moore <paul@paul-moore.com>.

The {subj,obj}_trust values are {0,1,2}, corresponding to no, yes, unknown.

Sample records:
  type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
  type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=2 obj_trust=2

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/notify/fanotify/fanotify.c |  3 ++-
 include/linux/audit.h         |  9 +++++----
 kernel/auditsc.c              | 16 +++++++++++++---
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 24ec1d66d5a8..29bdd99b29fa 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -273,7 +273,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	/* Check if the response should be audited */
 	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT);
+		audit_fanotify(event->response & ~FAN_AUDIT,
+			       &event->audit_rule);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
 		 group, event, ret);
diff --git a/include/linux/audit.h b/include/linux/audit.h
index d6b7d0c7ce43..31086a72e32a 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -14,6 +14,7 @@
 #include <linux/audit_arch.h>
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
+#include <uapi/linux/fanotify.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -416,7 +417,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
 extern void __audit_log_kern_module(char *name);
-extern void __audit_fanotify(u32 response);
+extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
@@ -523,10 +524,10 @@ static inline void audit_log_kern_module(char *name)
 		__audit_log_kern_module(name);
 }
 
-static inline void audit_fanotify(u32 response)
+static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 {
 	if (!audit_dummy_context())
-		__audit_fanotify(response);
+		__audit_fanotify(response, friar);
 }
 
 static inline void audit_tk_injoffset(struct timespec64 offset)
@@ -679,7 +680,7 @@ static inline void audit_log_kern_module(char *name)
 {
 }
 
-static inline void audit_fanotify(u32 response)
+static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 { }
 
 static inline void audit_tk_injoffset(struct timespec64 offset)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1fb821de104..3133c4175c15 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -64,6 +64,7 @@
 #include <uapi/linux/limits.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/openat2.h> // struct open_how
+#include <uapi/linux/fanotify.h>
 
 #include "audit.h"
 
@@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
 	context->type = AUDIT_KERN_MODULE;
 }
 
-void __audit_fanotify(u32 response)
+void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 {
-	audit_log(audit_context(), GFP_KERNEL,
-		AUDIT_FANOTIFY,	"resp=%u", response);
+	/* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
+	if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
+		audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+			  "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
+			  response, FAN_RESPONSE_INFO_NONE);
+		return;
+	}
+	audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+		  "resp=%u fan_type=%u fan_info=%X subj_trust=%u obj_trust=%u",
+		  response, friar->hdr.type, friar->rule_number,
+		  friar->subj_trust, friar->obj_trust);
 }
 
 void __audit_tk_injoffset(struct timespec64 offset)
-- 
2.27.0

