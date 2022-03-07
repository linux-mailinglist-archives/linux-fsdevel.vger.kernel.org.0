Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083384D038C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiCGP7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiCGP7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:59:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4731523
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 07:58:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l10so5618671wmb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAmgRFeCNQIyxVKMrZdhVGWCuIC+16jUJaEcAePpDzg=;
        b=VYUdGOlaujQujuOJ0nh4bdW0/3aDsi+dw/hSfOWplC2rj1L/Xtu19ytJt1Pmu41FJQ
         k/nJ7K2gvm4NZvjX8UNYcDbFfDjC+cSEpnWCz0Ng1PLEh1qhHHTj+aR9m5BcsJwfb0/A
         AeHbKDDnOch/zW7moj01Q7Z0pWxuELtqqEMZ7xyty7r3yYAh2NGEj58bdW3m8szSUYnA
         GdC0vwYrB1+7fsFAU+K6dgGbzeAMvM9WQoAUe928U3x/v8ilg8DuYmnovC9yX8mfjWot
         vw7DCYvwi2vcmmm+1IOBjCqsJnSpOJB1qWVEjTnYrcsHet6sDXbCk0fz9Ne2PhmAyGTe
         DW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAmgRFeCNQIyxVKMrZdhVGWCuIC+16jUJaEcAePpDzg=;
        b=N+hlZQC6+k5GdW3utbjRL7Qdz8KPUa8XFkqLfY93/fZXptCUylV+QVp4qC+tnbQJI9
         n6Ybmv33N3gsfWJkSUQ89QuNrAk04pKx+Yy31RhfwrERaS0lV07FO9axYwF26bYMY/2F
         eOAXYYaa6zyA//pYbzpix5C1JMgc0IVaiLfx4s5g5FTR5/fAGf/zAfjmLmUlRtKKGdWl
         kH2e4Vyo3BNvIpzexpT8Xrkbf0dhHLd0JITPy/Rd1DcXpcDn4lI3mYqsGsrxvy9yVGgu
         OV+EZXdRrfiq6Pa9VPKoTpuGJrnjnIbjT9Sh1zY65njADYaA2hY9C7Kex0gNQm40xTbD
         7ykw==
X-Gm-Message-State: AOAM531pqiBr0glhvQVW/ftG9+lk3pFo8OLtDAbqY1IT9TkXoR4ZQ1a1
        HUILIxqIXF3hBr7YUDQgmy8b0QZvtyQ=
X-Google-Smtp-Source: ABdhPJx7GYUEnWLZtQ3xugcvMBOyyOQQswtYBFrEfoX52TBaHYo7AEc0JZFy925A2tS3+gH4ugrXjA==
X-Received: by 2002:a05:600c:4611:b0:389:9f47:30cd with SMTP id m17-20020a05600c461100b003899f4730cdmr6709394wmo.185.1646668684406;
        Mon, 07 Mar 2022 07:58:04 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm11686591wrv.79.2022.03.07.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:58:04 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] fanotify: add support for exclusive create of mark
Date:   Mon,  7 Mar 2022 17:57:40 +0200
Message-Id: <20220307155741.1352405-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307155741.1352405-1-amir73il@gmail.com>
References: <20220307155741.1352405-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to inotify's IN_MARK_CREATE, adding an fanotify mark with flag
FAN_MARK_CREATE will fail with error EEXIST if an fanotify mark already
exists on the object.

Unlike inotify's IN_MARK_CREATE, FAN_MARK_CREATE has to supplied in
combination with FAN_MARK_ADD (FAN_MARK_ADD is like inotify_add_watch()
and the behavior of IN_MARK_ADD is the default for fanotify_mark()).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++++++++---
 include/linux/fanotify.h           |  8 +++++---
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9b32b76a9c30..99c5ced6abd8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1185,6 +1185,9 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
 		}
+	} else if (flags & FAN_MARK_CREATE) {
+		ret = -EEXIST;
+		goto out;
 	}
 
 	/*
@@ -1510,6 +1513,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	bool ignored = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
@@ -1539,7 +1543,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	}
 
-	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE | FAN_MARK_FLUSH)) {
+	if (flags & FAN_MARK_CREATE && mark_cmd != FAN_MARK_ADD)
+		return -EINVAL;
+
+	switch (mark_cmd) {
 	case FAN_MARK_ADD:
 	case FAN_MARK_REMOVE:
 		if (!mask)
@@ -1671,7 +1678,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* create/update an inode mark */
-	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE)) {
+	switch (mark_cmd) {
 	case FAN_MARK_ADD:
 		if (mark_type == FAN_MARK_MOUNT)
 			ret = fanotify_add_vfsmount_mark(group, mnt, mask,
@@ -1749,7 +1756,7 @@ static int __init fanotify_user_setup(void)
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 10);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 419cadcd7ff5..780f4b17d4c9 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -59,14 +59,16 @@
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
 				 FAN_MARK_FILESYSTEM)
 
+#define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
+				 FAN_MARK_FLUSH)
+
 #define FANOTIFY_MARK_FLAGS	(FANOTIFY_MARK_TYPE_BITS | \
-				 FAN_MARK_ADD | \
-				 FAN_MARK_REMOVE | \
+				 FANOTIFY_MARK_CMD_BITS | \
 				 FAN_MARK_DONT_FOLLOW | \
 				 FAN_MARK_ONLYDIR | \
 				 FAN_MARK_IGNORED_MASK | \
 				 FAN_MARK_IGNORED_SURV_MODIFY | \
-				 FAN_MARK_FLUSH)
+				 FAN_MARK_CREATE)
 
 /*
  * Events that can be reported with data type FSNOTIFY_EVENT_PATH.
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e8ac38cc2fd6..c41feac21fe9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -82,6 +82,7 @@
 #define FAN_MARK_IGNORED_SURV_MODIFY	0x00000040
 #define FAN_MARK_FLUSH		0x00000080
 /* FAN_MARK_FILESYSTEM is	0x00000100 */
+#define FAN_MARK_CREATE		0x00000200
 
 /* These are NOT bitwise flags.  Both bits can be used togther.  */
 #define FAN_MARK_INODE		0x00000000
-- 
2.25.1

