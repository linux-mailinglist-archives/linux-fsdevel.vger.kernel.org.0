Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3348A5291EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiEPUrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344128AbiEPUpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 16:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE1C2483A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652732560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8REHGxRCTBVJChx13xBRXD9eIFYC7+P4H0f287ctuHg=;
        b=dOWoMbSE6hkSMS9/vSWzqn0Odr/UOtvUhL/rVLX0YszZrwdU5vzhPiy1Q8wGag363E0Ux+
        9/vFNyh74t9uPJv++RNkKZRnEZmZ4q+wwiOZ3Gi0MYeWiOFQMF0c+s+qJmos0dqOFCvObE
        i8Tuh79Woxc+8Kkd0FLIFBdjHecrNnk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-shmx3ctIOG-J73iNyuz9sw-1; Mon, 16 May 2022 16:22:39 -0400
X-MC-Unique: shmx3ctIOG-J73iNyuz9sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E8D080B71A;
        Mon, 16 May 2022 20:22:39 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D90EB40CF8E2;
        Mon, 16 May 2022 20:22:37 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 2/3] fanotify: define struct members to hold response decision context
Date:   Mon, 16 May 2022 16:22:23 -0400
Message-Id: <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
In-Reply-To: <cover.1652730821.git.rgb@redhat.com>
References: <cover.1652730821.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds 2 structure members to the response returned from user
space on a permission event. The first field is 32 bits for the context
type.  The context type will describe what the meaning is of the second
field. The default is none. The patch defines one additional context
type which means that the second field is a union containing a 32-bit
rule number. This will allow for the creation of other context types in
the future if other users of the API identify different needs.  The
second field size is defined by the context type and can be used to pass
along the data described by the context.

To support this, there is a macro for user space to check that the data
being sent is valid. Of course, without this check, anything that
overflows the bit field will trigger an EINVAL based on the use of
FAN_INVALID_RESPONSE_MASK in process_access_response().

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/notify/fanotify/fanotify.c      |  2 +-
 fs/notify/fanotify/fanotify.h      |  2 +
 fs/notify/fanotify/fanotify_user.c | 74 +++++++++++++++++++-----------
 include/linux/fanotify.h           |  3 ++
 include/uapi/linux/fanotify.h      | 22 ++++++++-
 5 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 985e995d2a39..ea0e60488f12 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -262,7 +262,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	}
 
 	/* userspace responded, convert to something usable */
-	switch (event->response & ~FAN_AUDIT) {
+	switch (event->response & ~(FAN_AUDIT | FAN_EXTRA)) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index d66668e06bee..eb7ec1f2a26e 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -426,8 +426,10 @@ struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
 	u32 response;			/* userspace answer to the event */
+	u32 extra_info_type;
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
+	union fanotify_response_extra	extra_info;
 };
 
 static inline struct fanotify_perm_event *
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 721e777ea90b..1c4067e29f2e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -289,13 +289,22 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
  */
 static void finish_permission_event(struct fsnotify_group *group,
 				    struct fanotify_perm_event *event,
-				    u32 response)
+				    struct fanotify_response *response)
 				    __releases(&group->notification_lock)
 {
 	bool destroy = false;
 
 	assert_spin_locked(&group->notification_lock);
-	event->response = response;
+	event->response = response->response & ~FAN_EXTRA;
+	if (response->response & FAN_EXTRA) {
+		event->extra_info_type = response->extra_info_type;
+		switch (event->extra_info_type) {
+		case FAN_RESPONSE_INFO_AUDIT_RULE:
+			event->extra_info.audit_rule = response->extra_info.audit_rule;
+		}
+	} else {
+		event->extra_info_type = FAN_RESPONSE_INFO_NONE;
+	}
 	if (event->state == FAN_EVENT_CANCELED)
 		destroy = true;
 	else
@@ -306,33 +315,40 @@ static void finish_permission_event(struct fsnotify_group *group,
 }
 
 static int process_access_response(struct fsnotify_group *group,
-				   struct fanotify_response *response_struct)
+				   struct fanotify_response *response_struct,
+				   size_t count)
 {
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
 	u32 response = response_struct->response;
 
-	pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
-		 fd, response);
+	pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
+		 group, fd, response, response_struct->extra_info_type, count);
+	if (fd < 0)
+		return -EINVAL;
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
 	 * timeout
 	 */
-	switch (response & ~FAN_AUDIT) {
-	case FAN_ALLOW:
-	case FAN_DENY:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (fd < 0)
+	if (FAN_INVALID_RESPONSE_MASK(response))
 		return -EINVAL;
-
 	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
 		return -EINVAL;
-
+	if (response & FAN_EXTRA) {
+		if (count < offsetofend(struct fanotify_response, extra_info_type))
+			return -EINVAL;
+		switch (response_struct->extra_info_type) {
+		case FAN_RESPONSE_INFO_NONE:
+			break;
+		case FAN_RESPONSE_INFO_AUDIT_RULE:
+			if (count < offsetofend(struct fanotify_response, extra_info))
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 	spin_lock(&group->notification_lock);
 	list_for_each_entry(event, &group->fanotify_data.access_list,
 			    fae.fse.list) {
@@ -340,7 +356,7 @@ static int process_access_response(struct fsnotify_group *group,
 			continue;
 
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, response);
+		finish_permission_event(group, event, response_struct);
 		wake_up(&group->fanotify_data.access_waitq);
 		return 0;
 	}
@@ -802,9 +818,13 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
 			if (ret <= 0) {
+				struct fanotify_response response = {
+					.fd = FAN_NOFD,
+					.response = FAN_DENY };
+
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
-					FANOTIFY_PERM(event), FAN_DENY);
+					FANOTIFY_PERM(event), &response);
 				wake_up(&group->fanotify_data.access_waitq);
 			} else {
 				spin_lock(&group->notification_lock);
@@ -827,26 +847,25 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 
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
+	if (count < offsetofend(struct fanotify_response, response))
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
 
@@ -857,6 +876,9 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group = file->private_data;
 	struct fsnotify_event *fsn_event;
+	struct fanotify_response response = {
+		.fd = FAN_NOFD,
+		.response = FAN_ALLOW };
 
 	/*
 	 * Stop new events from arriving in the notification queue. since
@@ -876,7 +898,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 		event = list_first_entry(&group->fanotify_data.access_list,
 				struct fanotify_perm_event, fae.fse.list);
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW);
+		finish_permission_event(group, event, &response);
 		spin_lock(&group->notification_lock);
 	}
 
@@ -893,7 +915,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
 			finish_permission_event(group, FANOTIFY_PERM(event),
-						FAN_ALLOW);
+						&response);
 		}
 		spin_lock(&group->notification_lock);
 	}
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 419cadcd7ff5..63a8494e782e 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -113,6 +113,9 @@
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
+/* This mask is to check for invalid bits of a user space permission response */
+#define FAN_INVALID_RESPONSE_MASK(x) ((x) & ~(FAN_ALLOW | FAN_DENY | FAN_AUDIT | FAN_EXTRA))
+
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
 #undef FAN_ALL_INIT_FLAGS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e8ac38cc2fd6..a94f4143601f 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -179,15 +179,35 @@ struct fanotify_event_info_error {
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
+#define FAN_RESPONSE_INFO_NONE		0
+#define FAN_RESPONSE_INFO_AUDIT_RULE	1
+
+union fanotify_response_extra {
+	__u32 audit_rule;
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
+	__u32 extra_info_type;
+	union fanotify_response_extra extra_info;
 };
 
 /* Legit userspace responses to a _PERM event */
 #define FAN_ALLOW	0x01
 #define FAN_DENY	0x02
-#define FAN_AUDIT	0x10	/* Bit mask to create audit record for result */
+#define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
+#define FAN_EXTRA	0x20	/* Bitmask to indicate additional information */
 
 /* No fd set in event */
 #define FAN_NOFD	-1
-- 
2.27.0

