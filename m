Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBA727EEA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 18:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgI3QMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 12:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgI3QMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601482360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4pWeov0RSK9+TLECM/VJlgZplP+7FIFKwBZxev0gn2w=;
        b=fQBrIQ4Mh5Z2ylaiCbypP1NG9G6YTFI2nOL8CKzlCb0Eai7UJHu9t0c4wzlBbCJTnD1LRT
        8jpKLvsOelGT0gaF56913+0XYVBTeZSJ7VcFWByGkLHk0g6h7eNTsWh7F2h3k5KsJ0zv6l
        pN00+gtvfk3UqaZ3BmNMYXIY5RrfJVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-hynrN2KKOsq47REOTrAs7A-1; Wed, 30 Sep 2020 12:12:38 -0400
X-MC-Unique: hynrN2KKOsq47REOTrAs7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1BF5800475;
        Wed, 30 Sep 2020 16:12:36 +0000 (UTC)
Received: from x2.localnet (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D92F60C07;
        Wed, 30 Sep 2020 16:12:33 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/3] fanotify: define bit map fields to hold response decision  context
Date:   Wed, 30 Sep 2020 12:12:28 -0400
Message-ID: <2745105.e9J7NaK4W3@x2>
Organization: Red Hat
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch defines 2 bit maps within the response variable returned from
user space on a permission event. The first field is 3 bits for the context
type. The context type will describe what the meaning is of the second bit
field. The default is none. The patch defines one additional context type
which means that the second field is a rule number. This will allow for the
creation of 6 other context types in the future if other users of the API
identify different needs. The second field is 10 bits wide and can be used
to pass along the data described by the context. Neither of these bit maps
are directly adjacent and could be expanded if the need arises.

To support this, several macros were created to facilitate storing and
retrieving the values. There is also a macro for user space to check that
the data being sent is valid. Of course, without this check, anything that
overflows the bit field will trigger an EINVAL based on the use of
of INVALID_RESPONSE_MASK in process_access_response().

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 fs/notify/fanotify/fanotify.c      |  3 +--
 fs/notify/fanotify/fanotify_user.c |  7 +------
 include/linux/fanotify.h           |  5 +++++
 include/uapi/linux/fanotify.h      | 31 ++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 85eda539b35f..e72b7e59aa24 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -178,11 +178,10 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	}
 
 	/* userspace responded, convert to something usable */
-	switch (event->response & ~FAN_AUDIT) {
+	switch (FAN_DEC_MASK(event->response)) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
-	case FAN_DENY:
 	default:
 		ret = -EPERM;
 	}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c8da9ea1e76e..3b8e515904fc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -187,13 +187,8 @@ static int process_access_response(struct fsnotify_group *group,
 	 * userspace can send a valid response or we will clean it up after the
 	 * timeout
 	 */
-	switch (response & ~FAN_AUDIT) {
-	case FAN_ALLOW:
-	case FAN_DENY:
-		break;
-	default:
+	if (FAN_INVALID_RESPONSE_MASK(response))
 		return -EINVAL;
-	}
 
 	if (fd < 0)
 		return -EINVAL;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index b79fa9bb7359..b3281d0e1b55 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -72,6 +72,11 @@
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
+/* This mask is to check for invalid bits of a user space permission response */
+#define FAN_INVALID_RESPONSE_MASK(x) ((x) & ~(FAN_ALLOW | FAN_DENY | \
+					FAN_AUDIT | FAN_DEC_CONTEXT_TYPE | \
+					FAN_DEC_CONTEXT))
+
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
 #undef FAN_ALL_INIT_FLAGS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index a88c7c6d0692..785d68ebcb58 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -152,6 +152,37 @@ struct fanotify_response {
 #define FAN_DENY	0x02
 #define FAN_AUDIT	0x10	/* Bit mask to create audit record for result */
 
+/*
+ * User space may need to record additional information about its decision.
+ * The context type records what kind of information is included. A bit mask
+ * defines the type of information included and then the context of the
+ * decision. The context type is 3 bits allowing for 8 kinds of context.
+ * The default is none. We also define 10 bits to allow up to 1024 kinds of
+ * context to be returned.
+ *
+ * If the context type is Rule, then the context following is the rule number
+ * that triggered the user space decision.
+ *
+ * There are helper macros defined so that it can be standardized across tools.
+ * A full example of how user space can use this looks like this:
+ *
+ * if (FAN_DEC_CONTEXT_VALUE_VALID(rule_number))
+ *	response.response = FAN_DENY | FAN_AUDIT | FAN_DEC_CONTEXT_TYPE_RULE |
+ *			    FAN_DEC_CONTEXT_VALUE(rule_number);
+ */
+#define FAN_DEC_MASK(x) ((x) & (FAN_ALLOW|FAN_DENY))
+#define FAN_DEC_CONTEXT_TYPE 0x70000000
+#define FAN_DEC_CONTEXT      0x00FFC000
+
+#define FAN_DEC_CONTEXT_TYPE_VALUE(x)    (((x) & 0x07) << 28)
+#define FAN_DEC_CONTEXT_TYPE_TO_VALUE(x) (((x) & FAN_DEC_CONTEXT_TYPE) >> 28)
+#define FAN_DEC_CONTEXT_VALUE(x)         (((x) & 0x3FF) << 14)
+#define FAN_DEC_CONTEXT_TO_VALUE(x)      (((x) & FAN_DEC_CONTEXT) >> 14)
+#define FAN_DEC_CONTEXT_VALUE_VALID(x)   ((x) >= 0 && (x) < 1024)
+
+#define FAN_DEC_CONTEXT_TYPE_NONE  FAN_DEC_CONTEXT_TYPE_VALUE(0)
+#define FAN_DEC_CONTEXT_TYPE_RULE  FAN_DEC_CONTEXT_TYPE_VALUE(1)
+
 /* No fd set in event */
 #define FAN_NOFD	-1
 
-- 
2.26.2




