Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF958DD14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbiHIRXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbiHIRXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9977252B7
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660065803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPbho2+c8dAkqKWuFGRj6nlv+UYf9Vv/Uh5Ehbs5Rkg=;
        b=ShlIuN2j0dfYPoxhg8ttUc6OZldMH2rhCb7S2Rfe34qtqYkmalb3FTP4hQNluPb2mIZIg7
        kf9z5k7Sj7U9PqKqOZf4Va9J3dhx3GiHe/lL61g54sPsh104nkzNI9fYmZJpLMP1pTI5AD
        +AltRR2ykdCu/9jtbFAkefvsfcJGE6I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-8YK0xgFjP5S1HHOFkibRIw-1; Tue, 09 Aug 2022 13:23:17 -0400
X-MC-Unique: 8YK0xgFjP5S1HHOFkibRIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 184C63800C44;
        Tue,  9 Aug 2022 17:23:17 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4523945D2;
        Tue,  9 Aug 2022 17:23:15 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 4/4] fanotify,audit: deliver fan_info as a hex-encoded string
Date:   Tue,  9 Aug 2022 13:22:55 -0400
Message-Id: <2d8159cec4392029dabfc39b55ac5fbd0faa9fbd.1659996830.git.rgb@redhat.com>
In-Reply-To: <cover.1659996830.git.rgb@redhat.com>
References: <cover.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the only type of fanotify info that is defined is an audit
rule number, but convert it to hex encoding to future-proof the field.

Sample record:
  type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index f000fec52360..0f747015c577 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2908,22 +2908,36 @@ void __audit_fanotify(u32 response, size_t len, char *buf)
 
 	if (!(len && buf)) {
 		audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
-			  "resp=%u fan_type=0 fan_info=?", response);
+			  "resp=%u fan_type=0 fan_info=3F", response); /* "?" */
 		return;
 	}
 	while (c >= sizeof(struct fanotify_response_info_header)) {
+		struct audit_context *ctx = audit_context();
+		struct audit_buffer *ab;
+
 		friar = (struct fanotify_response_info_audit_rule *)buf;
 		switch (friar->hdr.type) {
 		case FAN_RESPONSE_INFO_AUDIT_RULE:
 			if (friar->hdr.len < sizeof(*friar)) {
-				audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
-					  "resp=%u fan_type=%u fan_info=(incomplete)",
-					  response, friar->hdr.type);
+				ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
+				if (ab) {
+					audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
+							 response, friar->hdr.type);
+#define INCOMPLETE "(incomplete)"
+					audit_log_n_hex(ab, INCOMPLETE, sizeof(INCOMPLETE));
+					audit_log_end(ab);
+				}
 				return;
 			}
-			audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
-				  "resp=%u fan_type=%u fan_info=%u",
-				  response, friar->hdr.type, friar->audit_rule);
+			ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
+			if (ab) {
+				audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
+						 response, friar->hdr.type);
+				audit_log_n_hex(ab, (char *)&friar->audit_rule,
+						sizeof(friar->audit_rule));
+				audit_log_end(ab);
+
+			}
 		}
 		c -= friar->hdr.len;
 		ib += friar->hdr.len;
-- 
2.27.0

