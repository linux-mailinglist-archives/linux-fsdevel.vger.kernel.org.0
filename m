Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C258DD0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 19:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbiHIRXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbiHIRXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 632ED25289
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660065796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eNVlNSl7mS7dQb4vrymRAcWuVHCTVFJMbOs2Jsc4cw=;
        b=Zj3scTyR5jaX2E4ZpqPyrBquaBErX5uMzvSNaxm0M/FEw78JTjBYB5DQH0U/uIHcm1jeen
        cZ1d3wiMLVyYT7SZcUFsui/Utm0l4An6obsDfo5U2AW3r+8H5cv1/A3fAfv7BafJwRHEHa
        wjtR3vWD0DeKfBEY+0X/bgLMRQidTHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-lXf5mROQOgyRUSJBijv-aA-1; Tue, 09 Aug 2022 13:23:14 -0400
X-MC-Unique: lXf5mROQOgyRUSJBijv-aA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16A7519705A9;
        Tue,  9 Aug 2022 17:23:14 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9F3B9458A;
        Tue,  9 Aug 2022 17:23:12 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 2/4] fanotify: define struct members to hold response decision context
Date:   Tue,  9 Aug 2022 13:22:53 -0400
Message-Id: <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
In-Reply-To: <cover.1659996830.git.rgb@redhat.com>
References: <cover.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a flag, FAN_INFO and an extensible buffer to provide
additional information about response decisions.  The buffer contains
one or more headers defining the information type and the length of the
following information.  The patch defines one additional information
type, FAN_RESPONSE_INFO_AUDIT_RULE, an audit rule number.  This will
allow for the creation of other information types in the future if other
users of the API identify different needs.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/notify/fanotify/fanotify.c      |  10 ++-
 fs/notify/fanotify/fanotify.h      |   2 +
 fs/notify/fanotify/fanotify_user.c | 104 +++++++++++++++++++++++------
 include/linux/fanotify.h           |   5 ++
 include/uapi/linux/fanotify.h      |  27 +++++++-
 5 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4f897e109547..0f36062521f4 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -262,13 +262,16 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	}
 
 	/* userspace responded, convert to something usable */
-	switch (event->response & ~FAN_AUDIT) {
+	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
 	case FAN_DENY:
-	default:
 		ret = -EPERM;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 	/* Check if the response should be audited */
@@ -560,6 +563,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 
 	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH_PERM;
 	pevent->response = 0;
+	pevent->info_len = 0;
+	pevent->info_buf = NULL;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
 	path_get(path);
@@ -996,6 +1001,7 @@ static void fanotify_free_path_event(struct fanotify_event *event)
 static void fanotify_free_perm_event(struct fanotify_event *event)
 {
 	path_put(fanotify_event_path(event));
+	kfree(FANOTIFY_PERM(event)->info_buf);
 	kmem_cache_free(fanotify_perm_event_cachep, FANOTIFY_PERM(event));
 }
 
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index abfa3712c185..14c30e173632 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -428,6 +428,8 @@ struct fanotify_perm_event {
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
+	size_t info_len;
+	char *info_buf;
 };
 
 static inline struct fanotify_perm_event *
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ff67ca0d25cc..a4ae953f0e62 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -289,13 +289,18 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
  */
 static void finish_permission_event(struct fsnotify_group *group,
 				    struct fanotify_perm_event *event,
-				    u32 response)
+				    struct fanotify_response *response,
+				    size_t info_len, char *info_buf)
 				    __releases(&group->notification_lock)
 {
 	bool destroy = false;
 
 	assert_spin_locked(&group->notification_lock);
-	event->response = response;
+	event->response = response->response & ~FAN_INFO;
+	if (response->response & FAN_INFO) {
+		event->info_len = info_len;
+		event->info_buf = info_buf;
+	}
 	if (event->state == FAN_EVENT_CANCELED)
 		destroy = true;
 	else
@@ -306,33 +311,71 @@ static void finish_permission_event(struct fsnotify_group *group,
 }
 
 static int process_access_response(struct fsnotify_group *group,
-				   struct fanotify_response *response_struct)
+				   struct fanotify_response *response_struct,
+				   const char __user *buf,
+				   size_t count)
 {
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
 	u32 response = response_struct->response;
+	struct fanotify_response_info_header info_hdr;
+	char *info_buf = NULL;
 
-	pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
-		 fd, response);
+	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%lu\n", __func__,
+		 group, fd, response, info_buf, count);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
 	 * timeout
 	 */
-	switch (response & ~FAN_AUDIT) {
+	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
+		return -EINVAL;
+	switch (response & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
 	case FAN_DENY:
 		break;
 	default:
 		return -EINVAL;
 	}
-
-	if (fd < 0)
-		return -EINVAL;
-
 	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
 		return -EINVAL;
+	if (fd < 0)
+		return -EINVAL;
+	if (response & FAN_INFO) {
+		size_t c = count;
+		const char __user *ib = buf;
 
+		if (c <= 0)
+			return -EINVAL;
+		while (c >= sizeof(info_hdr)) {
+			if (copy_from_user(&info_hdr, ib, sizeof(info_hdr)))
+				return -EFAULT;
+			if (info_hdr.pad != 0)
+				return -EINVAL;
+			if (c < info_hdr.len)
+				return -EINVAL;
+			switch (info_hdr.type) {
+			case FAN_RESPONSE_INFO_AUDIT_RULE:
+				break;
+			case FAN_RESPONSE_INFO_NONE:
+			default:
+				return -EINVAL;
+			}
+			c -= info_hdr.len;
+			ib += info_hdr.len;
+		}
+		if (c != 0)
+			return -EINVAL;
+		/* Simplistic check for now */
+		if (count != sizeof(struct fanotify_response_info_audit_rule))
+			return -EINVAL;
+		info_buf = kmalloc(sizeof(struct fanotify_response_info_audit_rule),
+				   GFP_KERNEL);
+		if (!info_buf)
+			return -ENOMEM;
+		if (copy_from_user(info_buf, buf, count))
+			return -EFAULT;
+	}
 	spin_lock(&group->notification_lock);
 	list_for_each_entry(event, &group->fanotify_data.access_list,
 			    fae.fse.list) {
@@ -340,7 +383,9 @@ static int process_access_response(struct fsnotify_group *group,
 			continue;
 
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, response);
+		/* finish_permission_event() eats info_buf */
+		finish_permission_event(group, event, response_struct,
+					count, info_buf);
 		wake_up(&group->fanotify_data.access_waitq);
 		return 0;
 	}
@@ -802,9 +847,14 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
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
+					FANOTIFY_PERM(event), &response,
+					0, NULL);
 				wake_up(&group->fanotify_data.access_waitq);
 			} else {
 				spin_lock(&group->notification_lock);
@@ -827,26 +877,33 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 
 static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
 {
-	struct fanotify_response response = { .fd = -1, .response = -1 };
+	struct fanotify_response response;
 	struct fsnotify_group *group;
 	int ret;
+	const char __user *info_buf = buf + sizeof(struct fanotify_response);
+	size_t c;
 
 	if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
 		return -EINVAL;
 
 	group = file->private_data;
 
-	if (count < sizeof(response))
-		return -EINVAL;
-
-	count = sizeof(response);
-
 	pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
 
-	if (copy_from_user(&response, buf, count))
+	if (count < sizeof(response))
+		return -EINVAL;
+	if (copy_from_user(&response, buf, sizeof(response)))
 		return -EFAULT;
 
-	ret = process_access_response(group, &response);
+	c = count - sizeof(response);
+	if (response.response & FAN_INFO) {
+		if (c < sizeof(struct fanotify_response_info_header))
+			return -EINVAL;
+	} else {
+		if (c != 0)
+			return -EINVAL;
+	}
+	ret = process_access_response(group, &response, info_buf, c);
 	if (ret < 0)
 		count = ret;
 
@@ -857,6 +914,9 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group = file->private_data;
 	struct fsnotify_event *fsn_event;
+	struct fanotify_response response = {
+		.fd = FAN_NOFD,
+		.response = FAN_ALLOW };
 
 	/*
 	 * Stop new events from arriving in the notification queue. since
@@ -876,7 +936,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 		event = list_first_entry(&group->fanotify_data.access_list,
 				struct fanotify_perm_event, fae.fse.list);
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW);
+		finish_permission_event(group, event, &response, 0, NULL);
 		spin_lock(&group->notification_lock);
 	}
 
@@ -893,7 +953,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
 			finish_permission_event(group, FANOTIFY_PERM(event),
-						FAN_ALLOW);
+						&response, 0, NULL);
 		}
 		spin_lock(&group->notification_lock);
 	}
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index edc28555814c..ce9f97eb69f2 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -114,6 +114,11 @@
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
+/* This mask is to check for invalid bits of a user space permission response */
+#define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
+#define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
+#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
+
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
 #undef FAN_ALL_INIT_FLAGS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index f1f89132d60e..4d08823a5698 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -180,15 +180,40 @@ struct fanotify_event_info_error {
 	__u32 error_count;
 };
 
+/*
+ * User space may need to record additional information about its decision.
+ * The extra information type records what kind of information is included.
+ * The default is none. We also define an extra information buffer whose
+ * size is determined by the extra information type.
+ *
+ * If the context type is Rule, then the context following is the rule number
+ * that triggered the user space decision.
+ */
+
+#define FAN_RESPONSE_INFO_NONE		0
+#define FAN_RESPONSE_INFO_AUDIT_RULE	1
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
 };
 
+struct fanotify_response_info_header {
+	__u8 type;
+	__u8 pad;
+	__u16 len;
+};
+
+struct fanotify_response_info_audit_rule {
+	struct fanotify_response_info_header hdr;
+	__u32 audit_rule;
+};
+
 /* Legit userspace responses to a _PERM event */
 #define FAN_ALLOW	0x01
 #define FAN_DENY	0x02
-#define FAN_AUDIT	0x10	/* Bit mask to create audit record for result */
+#define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
+#define FAN_INFO	0x20	/* Bitmask to indicate additional information */
 
 /* No fd set in event */
 #define FAN_NOFD	-1
-- 
2.27.0

