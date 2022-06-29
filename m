Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B301560377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiF2Om0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiF2OmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:42:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C239148;
        Wed, 29 Jun 2022 07:42:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n1so22788359wrg.12;
        Wed, 29 Jun 2022 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTefUEs3d/k59ba09os1wAXR8cwC15Sw8uQiUoB441k=;
        b=KwJQvL5kQPgTYdiy0m8WHjtFF2Tz1mBsMU1r0iKWYqWVIlsEi6jUwXwIMnNbgexhxz
         n9BqIMjK7FX16lr2F0QJKVAapYPY9LWy4jUwaj0vV19T/KX6MLTRqvxMe7eTwZVH9egP
         kahMsN4jhGxkZskf0xBYf2PZznuKePs1vBd3s/qoYfW4ZtzWfdETfvbspPrZLP/cFtdU
         4nU2qY0QpvUK/2kyeiORtfQvqBmvh+b3Pv1LQQCkVhHXrymD9FWjnD8uP2f3oI7AnTf7
         ZkfiniQXZhRVkZDyMkcv2OFjP4GK2AIbP0k8s910IoHlPGwdVzWyidohzBgTEHAty6UY
         rgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTefUEs3d/k59ba09os1wAXR8cwC15Sw8uQiUoB441k=;
        b=6kiEENdaFj5WVslV9gTgEBXyE0Hmc3265pC84/3PV6ZeYiP/xrQVFeUGu6HCBserhM
         1rEBqXoXJphRboIrH/tBSj8kETxRfxd2kVQmDhG2SdrvYANrk8ysjfBqHVOtlDIpStWf
         dTa5Tqq1bYo7Spaz9ae4qtkD23EF2rdvx1Q2X1UivmgrtTMGMao1ubnl0Kj+COtw4AVX
         Ztyzs3YoFZHhciLL0PZEXGGMFUhGr4aiokbwYRSTo/klDkU9UJAvcf0gdMzY1/s6LBms
         KztD4VXEQbCqP2bcFLRjUb3LRKJ0zKq2J25BIbZZIJ05j7R7uQQZWj4t+uSD4RyenaHe
         nULQ==
X-Gm-Message-State: AJIora9zHHpBsnBjffhCgcEBu5jPTndoLWzAt6QZ0ScHZ05o0mfSyo8S
        J8VhH6Vp9Kjkg6VMEAQcRY0=
X-Google-Smtp-Source: AGRyM1tKVomHmnUnX3b1kDYrcRCMpchb825hVHSHILW306Daeb6jwO5GaamNzOBzKfT7Pq+Waw00mQ==
X-Received: by 2002:a05:6000:3c6:b0:21b:9d00:db29 with SMTP id b6-20020a05600003c600b0021b9d00db29mr3641748wrg.338.1656513738694;
        Wed, 29 Jun 2022 07:42:18 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b0039c747a1e8fsm3562085wmq.7.2022.06.29.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:42:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 2/3] fanotify: cleanups for fanotify_mark() input validations
Date:   Wed, 29 Jun 2022 17:42:09 +0300
Message-Id: <20220629144210.2983229-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629144210.2983229-1-amir73il@gmail.com>
References: <20220629144210.2983229-1-amir73il@gmail.com>
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

Create helper fanotify_may_update_existing_mark() for checking for
conflicts between existing mark flags and fanotify_mark() flags.

Use variable mark_cmd to make the checks for mark command bits
cleaner.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 30 +++++++++++++++++++++---------
 include/linux/fanotify.h           |  9 +++++----
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a9eea037fee9..6781d46cd37c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1187,6 +1187,19 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 					 sizeof(struct fanotify_error_event));
 }
 
+static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
+					      unsigned int fan_flags)
+{
+	/*
+	 * Non evictable mark cannot be downgraded to evictable mark.
+	 */
+	if (fan_flags & FAN_MARK_EVICTABLE &&
+	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
+		return -EEXIST;
+
+	return 0;
+}
+
 static int fanotify_add_mark(struct fsnotify_group *group,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     __u32 mask, unsigned int fan_flags,
@@ -1208,13 +1221,11 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	}
 
 	/*
-	 * Non evictable mark cannot be downgraded to evictable mark.
+	 * Check if requested mark flags conflict with an existing mark flags.
 	 */
-	if (fan_flags & FAN_MARK_EVICTABLE &&
-	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF)) {
-		ret = -EEXIST;
+	ret = fanotify_may_update_existing_mark(fsn_mark, fan_flags);
+	if (ret)
 		goto out;
-	}
 
 	/*
 	 * Error events are pre-allocated per group, only if strictly
@@ -1557,6 +1568,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	bool ignore = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
@@ -1586,7 +1598,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	}
 
-	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE | FAN_MARK_FLUSH)) {
+	switch (mark_cmd) {
 	case FAN_MARK_ADD:
 	case FAN_MARK_REMOVE:
 		if (!mask)
@@ -1675,7 +1687,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
 		goto fput_and_out;
 
-	if (flags & FAN_MARK_FLUSH) {
+	if (mark_cmd == FAN_MARK_FLUSH) {
 		ret = 0;
 		if (mark_type == FAN_MARK_MOUNT)
 			fsnotify_clear_vfsmount_marks_by_group(group);
@@ -1691,7 +1703,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (ret)
 		goto fput_and_out;
 
-	if (flags & FAN_MARK_ADD) {
+	if (mark_cmd == FAN_MARK_ADD) {
 		ret = fanotify_events_supported(group, &path, mask, flags);
 		if (ret)
 			goto path_put_and_out;
@@ -1729,7 +1741,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* create/update an inode mark */
-	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE)) {
+	switch (mark_cmd) {
 	case FAN_MARK_ADD:
 		if (mark_type == FAN_MARK_MOUNT)
 			ret = fanotify_add_vfsmount_mark(group, mnt, mask,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index e517dbcf74ed..a7207f092fd1 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -59,15 +59,16 @@
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
-				 FAN_MARK_EVICTABLE | \
-				 FAN_MARK_FLUSH)
+				 FAN_MARK_EVICTABLE)
 
 /*
  * Events that can be reported with data type FSNOTIFY_EVENT_PATH.
-- 
2.25.1

