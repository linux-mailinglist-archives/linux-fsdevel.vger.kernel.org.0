Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031BA361618
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 01:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhDOXXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 19:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhDOXXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:23:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4EEC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 16:22:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j7so8548469pgi.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WV1tQd4rQZcDnw0vtk2IUswb5g2bOa/mFVib+HRpvkc=;
        b=hwAYg9KyEkz8i3RpAvX6+7fBhDbyqMAEMBW5YmNmV0cj9+53f7ITUPxUa3PUv69mSo
         M+iiZ3kPoxokzDuIywCs4/SUkwlu8vhJn05fgDea7GDSiK2tnejITh2wv0oR4fAdt1s4
         yYidioaVvVP/75DArvMZ/Z52Rzd+X/HM6BWAD0cvd8vJ5icHI5Sc9CoBpSAW/9n9fUFt
         inCWlv3cFX+VxGu9pxwxgWSNCokm9ahqVaqXW9bXQTQESkopW5Lwep1o595muWgG3ISI
         GP2HFU17eMu3pxh+pF0o6VDZCLQD5AvRIt5cAWNRbEm3OI3fKND3QHn4Y9dEuA6wuIhc
         o+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WV1tQd4rQZcDnw0vtk2IUswb5g2bOa/mFVib+HRpvkc=;
        b=lY4vIhrBZscTUNM0CW+vUinPLugcuXuytBVdeORzzGjocbKYsGq5wBHUjt2tmi5woS
         wZRe11oCEBNPIXq3zFMNbYvTt0ZgSYZViwxas++/nJPnxi7/AE0pPhSAcQB5lUBvWbg1
         VLMrkcBVhJzO24f8pGeLL6X2zDZ8JDeULMZhzA+SH4gPD31NUbppk2x5+/yLVyvkGZar
         1ecdCZKz9+G7A8dfhMFfGnDzGbo66tojzlMmHeQEk2RNMlikTdIoBaFPfOPJrYyKTdna
         9xDj85/KH0/4NaVCMZMTrdifjiuvVkcgycJoB3JtJ3hNYU8eomn1sbrZZzIPQHj9fNNS
         JVAg==
X-Gm-Message-State: AOAM533zqJchGlF5ep9woJBeCIgMhK6R539z1OM3XAs9sgDc3jSGGTBD
        rCSVEJFsoAqyoZ2iXLoKnzLB5Q==
X-Google-Smtp-Source: ABdhPJwY5gj/6yNI4YnwV7krZwZoZFOtlC+XmnzX2phexnBeX2DUb0nUbl2uT9BZdzzkXT5E6Wt1VQ==
X-Received: by 2002:aa7:9108:0:b029:251:7caf:cec with SMTP id 8-20020aa791080000b02902517caf0cecmr5216762pfh.13.1618528957987;
        Thu, 15 Apr 2021 16:22:37 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3d18:8baf:8ab:7dd5])
        by smtp.gmail.com with ESMTPSA id z1sm2491090pgz.94.2021.04.15.16.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:22:37 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:22:25 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
References: <cover.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618527437.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
allows userspace applications to control whether a pidfd is to be
returned instead of a pid for `struct fanotify_event_metadata.pid`.

FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
pidfd API is currently restricted to only support pidfd generation for
thread-group leaders. Attempting to set them both when calling
fanotify_init(2) will result in -EINVAL being returned to the
caller. As the pidfd API evolves and support is added for tids, this
is something that could be relaxed in the future.

If pidfd creation fails, the pid in struct fanotify_event_metadata is
set to FAN_NOPIDFD(-1). Falling back and providing a pid instead of a
pidfd on pidfd creation failures was considered, although this could
possibly lead to confusion and unpredictability within userspace
applications as distinguishing between whether an actual pidfd or pid
was returned could be difficult, so it's best to be explicit.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9e0c1afac8bd..fd8ae88796a8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct fanotify_info *info = fanotify_event_info(event);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct file *f = NULL;
-	int ret, fd = FAN_NOFD;
+	int ret, pidfd, fd = FAN_NOFD;
 	int info_type = 0;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
@@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
 	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
-	metadata.pid = pid_vnr(event->pid);
+
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
+		pid_has_task(event->pid, PIDTYPE_TGID)) {
+		/*
+		 * Given FAN_REPORT_PIDFD is to be mutually exclusive with
+		 * FAN_REPORT_TID, panic here if the mutual exclusion is ever
+		 * blindly lifted without pidfds for threads actually being
+		 * supported.
+		 */
+		WARN_ON(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+
+		pidfd = pidfd_create(event->pid, 0);
+		if (unlikely(pidfd < 0))
+			metadata.pid = FAN_NOPIDFD;
+		else
+			metadata.pid = pidfd;
+	} else {
+		metadata.pid = pid_vnr(event->pid);
+	}
 
 	if (path && path->mnt && path->dentry) {
 		fd = create_fd(group, path, &f);
@@ -941,6 +959,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 #endif
 		return -EINVAL;
 
+	/*
+	 * A pidfd can only be returned for a thread-group leader; thus
+	 * FAN_REPORT_TID and FAN_REPORT_PIDFD need to be mutually
+	 * exclusive. Once the pidfd API supports the creation of pidfds on
+	 * individual threads, then we can look at removing this conditional.
+	 */
+	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
+		return -EINVAL;
+
 	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
 		return -EINVAL;
 
@@ -1312,7 +1339,7 @@ SYSCALL32_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 3e9c56ee651f..894740a6f4e0 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -21,7 +21,7 @@
 #define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
-				 FAN_REPORT_TID | \
+				 FAN_REPORT_TID | FAN_REPORT_PIDFD | \
 				 FAN_CLOEXEC | FAN_NONBLOCK | \
 				 FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index fbf9c5c7dd59..369392644d4e 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -55,6 +55,7 @@
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+#define FAN_REPORT_PIDFD	0x00001000	/* Return a pidfd for event->pid */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -160,6 +161,7 @@ struct fanotify_response {
 
 /* No fd set in event */
 #define FAN_NOFD	-1
+#define FAN_NOPIDFD	FAN_NOFD
 
 /* Helper functions to deal with fanotify_event_metadata buffers */
 #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
-- 
2.31.1.368.gbe11c130af-goog

/M
