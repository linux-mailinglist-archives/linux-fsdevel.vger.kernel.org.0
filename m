Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE553670D3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 00:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjAQXYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 18:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAQXXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDB41B5F
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 13:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673990066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fU3YDk0jf8S0aGpxUM4Sk1CAnSXITio6PrYxXjAFih4=;
        b=h6L6eBMRokP7BPrvsdiJb7BZtyGm2NOZHggEzBTvopFEAAUlOOx5Ap+JWfoDU59qryaXut
        kRmaORkdeHSjKreewUQ05tYOJ5nFpK8S/+Y7P+62exevrlwfAEUNgkwyrzrK8tlO/1q86H
        IeUDnIzfXrYt4xQT/BXX9TmZsRsDmcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-WbVBjxO1Oqe6EZXTSJ6Lrw-1; Tue, 17 Jan 2023 16:14:22 -0500
X-MC-Unique: WbVBjxO1Oqe6EZXTSJ6Lrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 476B885A588;
        Tue, 17 Jan 2023 21:14:22 +0000 (UTC)
Received: from madcap2.tricolour.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2DEBC15BAD;
        Tue, 17 Jan 2023 21:14:20 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v6 2/3] fanotify: define struct members to hold response decision context
Date:   Tue, 17 Jan 2023 16:14:06 -0500
Message-Id: <10177cfcae5480926b7176321a28d9da6835b667.1673989212.git.rgb@redhat.com>
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

This patch adds a flag, FAN_INFO and an extensible buffer to provide
additional information about response decisions.  The buffer contains
one or more headers defining the information type and the length of the
following information.  The patch defines one additional information
type, FAN_RESPONSE_INFO_AUDIT_RULE, to audit a rule number.  This will
allow for the creation of other information types in the future if other
users of the API identify different needs.

The kernel can be tested if it supports a given info type by supplying
the complete info extension but setting fd to FAN_NOFD.  It will return
the expected size but not issue an audit record.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/notify/fanotify/fanotify.c      |  5 +-
 fs/notify/fanotify/fanotify.h      |  4 ++
 fs/notify/fanotify/fanotify_user.c | 86 ++++++++++++++++++++++--------
 include/linux/fanotify.h           |  5 ++
 include/uapi/linux/fanotify.h      | 30 ++++++++++-
 5 files changed, 107 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a2a15bc4df28..24ec1d66d5a8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -262,7 +262,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	}
 
 	/* userspace responded, convert to something usable */
-	switch (event->response & ~FAN_AUDIT) {
+	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
@@ -563,6 +563,9 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 
 	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH_PERM;
 	pevent->response = 0;
+	pevent->hdr.type = FAN_RESPONSE_INFO_NONE;
+	pevent->hdr.pad = 0;
+	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
 	path_get(path);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index f899d610bc08..e8a3c28c5d12 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -428,6 +428,10 @@ struct fanotify_perm_event {
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
+	union {
+		struct fanotify_response_info_header hdr;
+		struct fanotify_response_info_audit_rule audit_rule;
+	};
 };
 
 static inline struct fanotify_perm_event *
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index caa1211bac8c..8f430bfad487 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -283,19 +283,42 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
 	return client_fd;
 }
 
+static int process_access_response_info(const char __user *info,
+					size_t info_len,
+				struct fanotify_response_info_audit_rule *friar)
+{
+	if (info_len != sizeof(*friar))
+		return -EINVAL;
+
+	if (copy_from_user(friar, info, sizeof(*friar)))
+		return -EFAULT;
+
+	if (friar->hdr.type != FAN_RESPONSE_INFO_AUDIT_RULE)
+		return -EINVAL;
+	if (friar->hdr.pad != 0)
+		return -EINVAL;
+	if (friar->hdr.len != sizeof(*friar))
+		return -EINVAL;
+
+	return info_len;
+}
+
 /*
  * Finish processing of permission event by setting it to ANSWERED state and
  * drop group->notification_lock.
  */
 static void finish_permission_event(struct fsnotify_group *group,
-				    struct fanotify_perm_event *event,
-				    u32 response)
+				    struct fanotify_perm_event *event, u32 response,
+				    struct fanotify_response_info_audit_rule *friar)
 				    __releases(&group->notification_lock)
 {
 	bool destroy = false;
 
 	assert_spin_locked(&group->notification_lock);
-	event->response = response;
+	event->response = response & ~FAN_INFO;
+	if (response & FAN_INFO)
+		memcpy(&event->audit_rule, friar, sizeof(*friar));
+
 	if (event->state == FAN_EVENT_CANCELED)
 		destroy = true;
 	else
@@ -306,20 +329,27 @@ static void finish_permission_event(struct fsnotify_group *group,
 }
 
 static int process_access_response(struct fsnotify_group *group,
-				   struct fanotify_response *response_struct)
+				   struct fanotify_response *response_struct,
+				   const char __user *info,
+				   size_t info_len)
 {
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
 	u32 response = response_struct->response;
+	int ret = info_len;
+	struct fanotify_response_info_audit_rule friar;
 
-	pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
-		 fd, response);
+	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%zu\n", __func__,
+		 group, fd, response, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
 	 * timeout
 	 */
-	switch (response & ~FAN_AUDIT) {
+	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
+		return -EINVAL;
+
+	switch (response & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
 	case FAN_DENY:
 		break;
@@ -327,10 +357,20 @@ static int process_access_response(struct fsnotify_group *group,
 		return -EINVAL;
 	}
 
-	if (fd < 0)
+	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
 		return -EINVAL;
 
-	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
+	if (response & FAN_INFO) {
+		ret = process_access_response_info(info, info_len, &friar);
+		if (ret < 0)
+			return ret;
+		if (fd == FAN_NOFD)
+			return ret;
+	} else {
+		ret = 0;
+	}
+
+	if (fd < 0)
 		return -EINVAL;
 
 	spin_lock(&group->notification_lock);
@@ -340,9 +380,9 @@ static int process_access_response(struct fsnotify_group *group,
 			continue;
 
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, response);
+		finish_permission_event(group, event, response, &friar);
 		wake_up(&group->fanotify_data.access_waitq);
-		return 0;
+		return ret;
 	}
 	spin_unlock(&group->notification_lock);
 
@@ -804,7 +844,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 			if (ret <= 0) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
-					FANOTIFY_PERM(event), FAN_DENY);
+					FANOTIFY_PERM(event), FAN_DENY, NULL);
 				wake_up(&group->fanotify_data.access_waitq);
 			} else {
 				spin_lock(&group->notification_lock);
@@ -827,28 +867,32 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 
 static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
 {
-	struct fanotify_response response = { .fd = -1, .response = -1 };
+	struct fanotify_response response;
 	struct fsnotify_group *group;
 	int ret;
+	const char __user *info_buf = buf + sizeof(struct fanotify_response);
+	size_t info_len;
 
 	if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
 		return -EINVAL;
 
 	group = file->private_data;
 
+	pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
+
 	if (count < sizeof(response))
 		return -EINVAL;
 
-	count = sizeof(response);
-
-	pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
-
-	if (copy_from_user(&response, buf, count))
+	if (copy_from_user(&response, buf, sizeof(response)))
 		return -EFAULT;
 
-	ret = process_access_response(group, &response);
+	info_len = count - sizeof(response);
+
+	ret = process_access_response(group, &response, info_buf, info_len);
 	if (ret < 0)
 		count = ret;
+	else
+		count = sizeof(response) + ret;
 
 	return count;
 }
@@ -876,7 +920,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 		event = list_first_entry(&group->fanotify_data.access_list,
 				struct fanotify_perm_event, fae.fse.list);
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW);
+		finish_permission_event(group, event, FAN_ALLOW, NULL);
 		spin_lock(&group->notification_lock);
 	}
 
@@ -893,7 +937,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
 			finish_permission_event(group, FANOTIFY_PERM(event),
-						FAN_ALLOW);
+						FAN_ALLOW, NULL);
 		}
 		spin_lock(&group->notification_lock);
 	}
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 8ad743def6f3..4f1c4f603118 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -122,6 +122,11 @@
 #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
+/* These masks check for invalid bits in permission responses. */
+#define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
+#define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
+#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
+
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
 #undef FAN_ALL_INIT_FLAGS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 436258214bb0..cd14c94e9a1e 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -188,15 +188,43 @@ struct fanotify_event_info_error {
 	__u32 error_count;
 };
 
+/*
+ * User space may need to record additional information about its decision.
+ * The extra information type records what kind of information is included.
+ * The default is none. We also define an extra information buffer whose
+ * size is determined by the extra information type.
+ *
+ * If the information type is Audit Rule, then the information following
+ * is the rule number that triggered the user space decision that
+ * requires auditing.
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
+	__u32 rule_number;
+	__u32 subj_trust;
+	__u32 obj_trust;
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

