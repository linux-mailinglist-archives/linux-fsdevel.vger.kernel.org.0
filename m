Return-Path: <linux-fsdevel+bounces-25562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A7694D692
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC71F22D91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431B15FA85;
	Fri,  9 Aug 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XN36WxsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13B15FCEB
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229102; cv=none; b=UW+lMmCRU8MBkJnyAQuY23CD24PgPuao303OyX+hVl2ElB+DbB7ffJ+SQxlDvcBCDr1rYHmLdxWV7IqAEfcAPJs7xNrunCmqjl1ob4B82gHV4ESOy0KpJ186LlkLbxEMhLzPsRfDVRRLGqsNie+0fE+OCwTAwua/BE1CNr5o3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229102; c=relaxed/simple;
	bh=pD+LVjuiFGqxiYXNcE7SFfWih4a6NzbE/J64a1HUTSE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKeX1bPLuVruVjqMF+2+/UDAeRKXQXfIcHICyhJVk43noSXxKOTC3eBPv0lMlZr6lHxQbTHBgT4HwjGAvCcy7YUQLjqu72avocJFdYRDdBVzFfOXV8Ghkr8nZtkE+Zw6Y4JY7vxarCoBUoNj8F7+y/zcDXbnfEUko4FL6OlZc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XN36WxsB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b95b710e2cso14698096d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229100; x=1723833900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03GJ1k40z8a5Psi/RqpgoqHfW5s1FJwp4eQtJBRMqtc=;
        b=XN36WxsBa7bcB9lDAbFL614ahuxlOqSZLgD7qdoEZjFaRNq5J0S8mSZ0SzRsBzwJY9
         JHll02O+dXdVTugTAxWCpnJqfashkztO5abPWM3pDWeNmAuBuGhOv+q6/EvAx+E35gAT
         uUOStGQDlwfAXIBInzJ5PqILzvOVJ8Y0WHM/gHyHAtoExYr9tA2dfill1X9Jwb/dfzms
         gaimN6w6s6TcYpGxdn0Zdpfy+4CYfoegj8McxvUcdFAKUqspBy882BAgLH0S1JvP8wwb
         hLclCLDvF4qGb/sj383PuuprEXn4Gts2t6m0SXNUgek5P0qrSk0Oy8Ynn764nwkcqQuA
         oysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229100; x=1723833900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03GJ1k40z8a5Psi/RqpgoqHfW5s1FJwp4eQtJBRMqtc=;
        b=eRQtrjN0MQmpV+wZ0Q16xAko4XCJIFUBf+mYC2/vFJfaQlU4Zgc+Vw1xOecpQ/Vp21
         YP9/ICABu4TOJaxnH71aAZGNHjltP2fCKPUiSJcLqvtKvLSrDODYmnlYKLaWUzUmSTyY
         p/wmstsue8yJP6PJ+NpH7/Tat/13yYBM4SGDPI+zg8pwmV9op95dmXR5T3FG3Abr7mFZ
         ESHDnj/Czsotg2e2Cib+wgY9GZC6VQTX1hGHnpU+ixFvDoW1TMtzyxrSz+btqd+w5lOq
         9dP0Gw5pId3saar+9a6Af6zG8nV0n5xx6Zo9dbqitidiT2eOZ31Mke6vgZwbjLqNhxVV
         fhZw==
X-Forwarded-Encrypted: i=1; AJvYcCVyWzjzsrQrgSt6c1DeR/KByODpKABjCZVBRTYtG92ebLl3PwtD843I8/MIp148kTj8aArA55WXSlmq8wp3j0WbHMJhKh/bHUo5E52/FA==
X-Gm-Message-State: AOJu0Yz14qb+E0aA1BhfudKUztKBW3Y40TfChmBKZzGhHnfNq3gKOuVc
	wjMcBIfUy6Uwf8NjYqHi0srjEktTFZE/5uRYrObieg81TlV/M9UJlOp1PAlWUui5NYQdG2PIlIm
	1
X-Google-Smtp-Source: AGHT+IHlnQ04SgS9lQxLdw6VzxymwZfW94QmXLorvLaS9f6ij+QaZXP+kambXPe4m94icEfxDbwukw==
X-Received: by 2002:a0c:f411:0:b0:6b2:dd54:b634 with SMTP id 6a1803df08f44-6bd78e4f120mr27068616d6.39.1723229099638;
        Fri, 09 Aug 2024 11:44:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e6c62asm560826d6.142.2024.08.09.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:44:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 05/16] fanotify: introduce FAN_PRE_MODIFY permission event
Date: Fri,  9 Aug 2024 14:44:13 -0400
Message-ID: <5142d1715dfecf58bc0a77eb410ca21d95e71cfc.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723228772.git.josef@toxicpanda.com>
References: <cover.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Generate FAN_PRE_MODIFY permission event from fsnotify_file_perm()
pre-write hook to notify fanotify listeners on an intent to make
modification to a file.

Like FAN_PRE_ACCESS, it is only allowed with FAN_CLASS_PRE_CONTENT
and unlike FAN_MODIFY, it is only allowed on regular files.

Like FAN_PRE_ACCESS, it is generated without sb_start_write() held,
so it is safe to perform filesystem modifications in the context of
event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first write access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify.c      | 3 ++-
 fs/notify/fanotify/fanotify_user.c | 2 ++
 include/linux/fanotify.h           | 3 ++-
 include/uapi/linux/fanotify.h      | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7dac8e4486df..b163594843f5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -911,8 +911,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
+	BUILD_BUG_ON(FAN_PRE_MODIFY != FS_PRE_MODIFY);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c294849e474f..3a7101544f30 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1673,6 +1673,8 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
 		if (!is_dir && !d_is_reg(path->dentry))
 			return -EINVAL;
+		if (is_dir && mask & FAN_PRE_MODIFY)
+			return -EISDIR;
 	}
 
 	return 0;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 5c811baf44d2..ae6cb2688d52 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -92,7 +92,8 @@
 #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
 				      FAN_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
+#define FANOTIFY_PRE_MODIFY_EVENTS   (FAN_PRE_MODIFY)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index bcada21a3a2e..ac00fad66416 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,7 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 
 #define FAN_PRE_ACCESS		0x00080000	/* Pre-content access hook */
+#define FAN_PRE_MODIFY		0x00100000	/* Pre-content modify hook */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.43.0


