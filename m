Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC8513FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 02:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353210AbiD2AtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353332AbiD2AtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09449887AD
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 17:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651193143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jT+EfRPk1Sb20PQ6x7rYA9iqu8yoddCojDOiYo2wVZ8=;
        b=LNAdQWS/vGuSG/Qex5NgXlIw2sfwuj3i+1SatSwWWKBEBnX6i7sIcP6f5CPEoWgmhu55jM
        cYCO8aOYwAfB5NIsToFc+t1IBT0V22TQ57TD15Y5ixcPbNr5KZ6SvcFBRwiKfy6B9RZa7H
        Xot04ZhjXcxTlM2C6tiJ4ZX6wsldj6M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-I_oCY0JSNpuNL_OU8e-R0w-1; Thu, 28 Apr 2022 20:45:40 -0400
X-MC-Unique: I_oCY0JSNpuNL_OU8e-R0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83E9C2811801;
        Fri, 29 Apr 2022 00:45:39 +0000 (UTC)
Received: from madcap2.tricolour.com (ovpn-0-8.rdu2.redhat.com [10.22.0.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58DE59D42;
        Fri, 29 Apr 2022 00:45:38 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/3] fanotify: define struct members to hold response decision context
Date:   Thu, 28 Apr 2022 20:44:35 -0400
Message-Id: <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
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

This patch adds 2 structure members to the response returned from user
space on a permission event. The first field is 16 bits for the context
type.  The context type will describe what the meaning is of the second
field. The default is none. The patch defines one additional context
type which means that the second field is a 32-bit rule number. This
will allow for the creation of other context types in the future if
other users of the API identify different needs.  The second field size
is defined by the context type and can be used to pass along the data
described by the context.

To support this, there is a macro for user space to check that the data
being sent is valid. Of course, without this check, anything that
overflows the bit field will trigger an EINVAL based on the use of
FAN_INVALID_RESPONSE_MASK in process_access_response().

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Link: https://lore.kernel.org/r/17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com
---
 fs/notify/fanotify/fanotify.c      |  1 -
 fs/notify/fanotify/fanotify.h      |  4 +-
 fs/notify/fanotify/fanotify_user.c | 59 ++++++++++++++++++++----------
 include/linux/fanotify.h           |  3 ++
 include/uapi/linux/fanotify.h      | 27 +++++++++++++-
 5 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 985e995d2a39..00aff6e29bf8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -266,7 +266,6 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	case FAN_ALLOW:
 		ret = 0;
 		break;
-	case FAN_DENY:
 	default:
 		ret = -EPERM;
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 70acfd497771..87d643deabce 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -425,9 +425,11 @@ FANOTIFY_PE(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
-	__u32 response;			/* userspace answer to the event */
+	__u16 response;			/* userspace answer to the event */
+	__u16 extra_info_type;
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
+	char extra_info_buf[FANOTIFY_RESPONSE_EXTRA_LEN_MAX];
 };
 
 static inline struct fanotify_perm_event *
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 694516470660..f1ff4cf683fb 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -289,13 +289,19 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
  */
 static void finish_permission_event(struct fsnotify_group *group,
 				    struct fanotify_perm_event *event,
-				    __u32 response)
+				    struct fanotify_response *response)
 				    __releases(&group->notification_lock)
 {
 	bool destroy = false;
 
 	assert_spin_locked(&group->notification_lock);
-	event->response = response;
+	event->response = response->response;
+	event->extra_info_type = response->extra_info_type;
+	switch (event->extra_info_type) {
+	case FAN_RESPONSE_INFO_AUDIT_RULE:
+		memcpy(event->extra_info_buf, response->extra_info_buf,
+		       sizeof(struct fanotify_response_audit_rule));
+	}
 	if (event->state == FAN_EVENT_CANCELED)
 		destroy = true;
 	else
@@ -306,22 +312,29 @@ static void finish_permission_event(struct fsnotify_group *group,
 }
 
 static int process_access_response(struct fsnotify_group *group,
-				   struct fanotify_response *response_struct)
+				   struct fanotify_response *response_struct,
+				   size_t count)
 {
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
-	__u32 response = response_struct->response;
+	__u16 response = response_struct->response;
 
-	pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
-		 fd, response);
+	pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
+		 group, fd, response, response_struct->extra_info_type, count);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
 	 * timeout
 	 */
-	switch (response & ~FAN_AUDIT) {
-	case FAN_ALLOW:
-	case FAN_DENY:
+	if (FAN_INVALID_RESPONSE_MASK(response))
+		return -EINVAL;
+	switch (response_struct->extra_info_type) {
+	case FAN_RESPONSE_INFO_AUDIT_NONE:
+		break;
+	case FAN_RESPONSE_INFO_AUDIT_RULE:
+		if (count < offsetof(struct fanotify_response, extra_info_buf)
+			    + sizeof(struct fanotify_response_audit_rule))
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
@@ -340,7 +353,7 @@ static int process_access_response(struct fsnotify_group *group,
 			continue;
 
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, response);
+		finish_permission_event(group, event, response_struct);
 		wake_up(&group->fanotify_data.access_waitq);
 		return 0;
 	}
@@ -802,9 +815,14 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
 			if (ret <= 0) {
+				struct fanotify_response response = {
+					.fd = FAN_NOFD,
+					.response = FAN_DENY,
+					.extra_info_type = FAN_RESPONSE_INFO_AUDIT_NONE };
+
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
-					FANOTIFY_PERM(event), FAN_DENY);
+					FANOTIFY_PERM(event), &response);
 				wake_up(&group->fanotify_data.access_waitq);
 			} else {
 				spin_lock(&group->notification_lock);
@@ -827,26 +845,25 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 
 static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
 {
-	struct fanotify_response response = { .fd = -1, .response = -1 };
+	struct fanotify_response response;
 	struct fsnotify_group *group;
 	int ret;
+	size_t size = min(count, sizeof(struct fanotify_response));
 
 	if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
 		return -EINVAL;
 
 	group = file->private_data;
 
-	if (count < sizeof(response))
+	if (count < offsetof(struct fanotify_response, extra_info_buf))
 		return -EINVAL;
 
-	count = sizeof(response);
-
 	pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
 
-	if (copy_from_user(&response, buf, count))
+	if (copy_from_user(&response, buf, size))
 		return -EFAULT;
 
-	ret = process_access_response(group, &response);
+	ret = process_access_response(group, &response, count);
 	if (ret < 0)
 		count = ret;
 
@@ -857,6 +874,10 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group = file->private_data;
 	struct fsnotify_event *fsn_event;
+	struct fanotify_response response = {
+		.fd = FAN_NOFD,
+		.response = FAN_ALLOW,
+		.extra_info_type = FAN_RESPONSE_INFO_AUDIT_NONE };
 
 	/*
 	 * Stop new events from arriving in the notification queue. since
@@ -876,7 +897,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 		event = list_first_entry(&group->fanotify_data.access_list,
 				struct fanotify_perm_event, fae.fse.list);
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW);
+		finish_permission_event(group, event, &response);
 		spin_lock(&group->notification_lock);
 	}
 
@@ -893,7 +914,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
 			finish_permission_event(group, FANOTIFY_PERM(event),
-						FAN_ALLOW);
+						&response);
 		}
 		spin_lock(&group->notification_lock);
 	}
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 419cadcd7ff5..dc3722749d52 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -113,6 +113,9 @@
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
+/* This mask is to check for invalid bits of a user space permission response */
+#define FAN_INVALID_RESPONSE_MASK(x) ((x) & ~(FAN_ALLOW | FAN_DENY | FAN_AUDIT))
+
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
 #undef FAN_ALL_INIT_FLAGS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e8ac38cc2fd6..efb5a3a6f814 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -179,9 +179,34 @@ struct fanotify_event_info_error {
 	__u32 error_count;
 };
 
+/*
+ * User space may need to record additional information about its decision.
+ * The extra information type records what kind of information is included.
+ * The default is none. We also define an extra informaion buffer whose
+ * size is determined by the extra information type.
+ *
+ * If the context type is Rule, then the context following is the rule number
+ * that triggered the user space decision.
+ */
+
+#define FAN_RESPONSE_INFO_AUDIT_NONE	0
+#define FAN_RESPONSE_INFO_AUDIT_RULE	1
+
+struct fanotify_response_audit_rule {
+	__u32 rule;
+};
+
+#define FANOTIFY_RESPONSE_EXTRA_LEN_MAX	\
+	(sizeof(union { \
+		struct fanotify_response_audit_rule r; \
+		/* add other extra info structures here */ \
+	}))
+
 struct fanotify_response {
 	__s32 fd;
-	__u32 response;
+	__u16 response;
+	__u16 extra_info_type;
+	char extra_info_buf[FANOTIFY_RESPONSE_EXTRA_LEN_MAX];
 };
 
 /* Legit userspace responses to a _PERM event */
-- 
2.27.0

