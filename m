Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7127EEA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgI3QMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 12:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgI3QMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:12:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601482364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wZ7hKbJIHYqalK4WOUAGK/bFKZtga8tBuJ3icBPBGgc=;
        b=d2p9z/F5ZdYPI9iMabDkle2qsUK7ggehXUn3h6Ijp02AcVDnMfXNPuQBBp6foCUeZJgXi2
        zyW7EICyJrem7z0GqSQ2Icv2BQkMsz0PADV1M1VS8vUXd1lWkpi69cxVo9AcJDAoeNZpUP
        M/ETT3E4I55GbEhnKYEAdrWIQKDk7sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-SJaR17A5PUeqQT0hzkX90A-1; Wed, 30 Sep 2020 12:12:42 -0400
X-MC-Unique: SJaR17A5PUeqQT0hzkX90A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0671364080;
        Wed, 30 Sep 2020 16:12:41 +0000 (UTC)
Received: from x2.localnet (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F33D5C1CF;
        Wed, 30 Sep 2020 16:12:37 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Eric Paris <eparis@redhat.com>
Subject: [PATCH 3/3] fanotify: Allow audit to use the full permission event  response
Date:   Wed, 30 Sep 2020 12:12:33 -0400
Message-ID: <3075502.aeNJFYEL58@x2>
Organization: Red Hat
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch unmasks the full value so that the audit function can use all
of it. The audit function was updated to log the additional information in
the AUDIT_FANOTIFY record. The following is an example of the new record
format:

type=FANOTIFY msg=audit(1600385147.372:590): resp=2 ctx_type=1 fan_ctx=17

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 fs/notify/fanotify/fanotify.c | 2 +-
 kernel/auditsc.c              | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e72b7e59aa24..a9278e983e30 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -188,7 +188,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	/* Check if the response should be audited */
 	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT);
+		audit_fanotify(event->response);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
 		 group, event, ret);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index fd840c40abf7..9d6a3ad2037d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -75,6 +75,7 @@
 #include <linux/uaccess.h>
 #include <linux/fsnotify_backend.h>
 #include <uapi/linux/limits.h>
+#include <uapi/linux/fanotify.h>
 
 #include "audit.h"
 
@@ -2523,8 +2524,10 @@ void __audit_log_kern_module(char *name)
 
 void __audit_fanotify(unsigned int response)
 {
-	audit_log(audit_context(), GFP_KERNEL,
-		AUDIT_FANOTIFY,	"resp=%u", response);
+	audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
+		"resp=%u ctx_type=%u fan_ctx=%u", FAN_DEC_MASK(response),
+		FAN_DEC_CONTEXT_TYPE_TO_VALUE(response),
+		FAN_DEC_CONTEXT_TO_VALUE(response));
 }
 
 void __audit_tk_injoffset(struct timespec64 offset)
-- 
2.26.2




