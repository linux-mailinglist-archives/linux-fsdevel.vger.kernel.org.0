Return-Path: <linux-fsdevel+bounces-24276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52993C847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F1A1F22B44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086B55885;
	Thu, 25 Jul 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Q625Wimb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6B29414
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931618; cv=none; b=bPJM1lAj+e+HGtlNxouXnhqjyvYq4APPf6bVHPnXFyqlg+lOUl2/+1QGhzTNndcokJjAWFM+IYucVn52QfTObRm2wxkowcJxDgWga34VnTqhpRQlxumy/2fxEJ3yOGdBMUQL+6IdMrMqc3ORNhQCWJg69OVzpLc3yTBrqGMRkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931618; c=relaxed/simple;
	bh=kTqCTfhekdsH6P19RNTvUZFF5ZgWoXDNnnXsNdKanPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVwsulgUWn8JhXaU6IKiAlrek6T0o6m2GQoLaKEkGhOnb1/ki+rut0zA4BKRQx2H3NMoHC3xwRe9bR3LuG3Ws4ksN1wlF8myKftu+XJFDwsLgaCRgZrs4T7gtc4LM8H7KDYVWXDx/mRpiPakMpq5utKNwgNT1fZlc0miP2lRhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Q625Wimb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44931f038f9so20752521cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931615; x=1722536415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAb22f+5UyCJF3bHhMz1ReVnbOVGqqGo7ezLQ8nQVBI=;
        b=Q625Wimbaw4x8sa4hfKt0lBOs3t1nALGlfI7csnQp197RhvtJJ1EeEnhVMVdCuIpTM
         9dVCynhOBTVNijMHvrAro40D8PxkG03XSx5UOSv4WDKb4cANvv5CtczFmVl2U8IRvJ8y
         TOWRpwq6eCfnmxvhWQL562D5VjPh8TaMf2aDhyxWMU0m3nADZUyHTKfsd0ZzOSogUflK
         tZ/Vz2s9C7LAN13x5nVW+Y0wq+QCHBRS5m6TqLEOnf4AU3Zh0uwxIfbEiEz+oxIkBCp+
         tI89a3xjfe3+BYQT3YwE5H0Hw8AgYH/EVY4cMoLE7ngyAi+J3PmQVMIe5XtYYxHSfYUM
         Itmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931615; x=1722536415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAb22f+5UyCJF3bHhMz1ReVnbOVGqqGo7ezLQ8nQVBI=;
        b=o9MzAUVBXtosSVHh9Pp/5bVUHncY1QZQHlRSPcShQeNjT0cbMiGK9nkX/HnzrLl3Op
         60yZr/cTgeLoAwOf6NeMkyISjshoS7E4/iXi8vrgOjmc9K8U10nvefZ6KwH+0tBSkVKp
         45D2EFpC8nHmIhJ/2jW/jQ8nUocKnKmkpWvbQw5IZlnawRzsci9hfUK5qGlzR9Rg/Zko
         bnYXG9FitqA7TaI6GYpZ9bA269IRtqUQ1hEVcla5nRPiDBBzVtDj5ewHLGFaraWQMt89
         ocbN1HiR8sE3qETyQin5d+SKVjgs82ylSyQ7fmPM/rBCMj+rL/JOPucLgzvd3xxUutBt
         34CA==
X-Forwarded-Encrypted: i=1; AJvYcCU56V4+8AO94osY5GKgXTTbLznmpsNKnCw+/T4EjkQnn2YPRVLJD6KCH2ZnQoGZt8h7oSNmlaT1z0kpP3coIoi4vJByEu9UYnWN7fMhnw==
X-Gm-Message-State: AOJu0YwbvJ0Tx5xIgw1aFV9/wAsLg8wTRn4y1SkiBFai12/MBvY23KFl
	cSeXCNPcMjgNIPdfKMRkoacyXYG6c1/k7147JztdJ5/bFVLRw/LQBVoTJlE1N0o=
X-Google-Smtp-Source: AGHT+IHs3NVmgivA/IDe9Fy2q1QxG+D38xIy2Eui0/57t8SISYbb9HYhUGCBJxnbx5ee2DdBfNYYjQ==
X-Received: by 2002:ac8:7f88:0:b0:447:e6f9:f61c with SMTP id d75a77b69052e-44fd7b8510bmr105854151cf.22.1721931615512;
        Thu, 25 Jul 2024 11:20:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d744456fsm106528685a.108.2024.07.25.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 09/10] fanotify: allow to set errno in FAN_DENY permission response
Date: Thu, 25 Jul 2024 14:19:46 -0400
Message-ID: <fe7827974f5aec3403b07e8e70c020422126deaa.1721931241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721931241.git.josef@toxicpanda.com>
References: <cover.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

With FAN_DENY response, user trying to perform the filesystem operation
gets an error with errno set to EPERM.

It is useful for hierarchical storage management (HSM) service to be able
to deny access for reasons more diverse than EPERM, for example EAGAIN,
if HSM could retry the operation later.

Allow fanotify groups with priority FAN_CLASSS_PRE_CONTENT to responsd
to permission events with the response value FAN_DENY_ERRNO(errno),
instead of FAN_DENY to return a custom error.

Limit custom error to values to some errors expected on read(2)/write(2)
and open(2) of regular files. This list could be extended in the future.
Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
writing a response to an fanotify group fd with a value of FAN_NOFD
in the fd field of the response.

The change in fanotify_response is backward compatible, because errno is
written in the high 8 bits of the 32bit response field and old kernels
reject respose value with high bits set.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 13 ++++++++++---
 fs/notify/fanotify/fanotify_user.c | 31 +++++++++++++++++++++++++++---
 include/linux/fanotify.h           |  9 ++++++++-
 include/uapi/linux/fanotify.h      |  7 +++++++
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 8fa439bd47d6..48539acc32e0 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -224,7 +224,7 @@ static int fanotify_get_response(struct fsnotify_group *group,
 				 struct fanotify_perm_event *event,
 				 struct fsnotify_iter_info *iter_info)
 {
-	int ret;
+	int ret, errno;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -258,18 +258,25 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	}
 
 	/* userspace responded, convert to something usable */
-	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (FAN_RESPONSE_ACCESS(event->response)) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
 	case FAN_DENY:
+		/* Check custom errno from pre-content events */
+		errno = FAN_RESPONSE_ERRNO(event->response);
+		if (errno) {
+			ret = -errno;
+			break;
+		}
+		fallthrough;
 	default:
 		ret = -EPERM;
 	}
 
 	/* Check if the response should be audited */
 	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT,
+		audit_fanotify(FAN_RESPONSE_ACCESS(event->response),
 			       &event->audit_rule);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c3c8b2ea80b6..b4d810168521 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -337,11 +337,12 @@ static int process_access_response(struct fsnotify_group *group,
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
 	u32 response = response_struct->response;
+	int errno = FAN_RESPONSE_ERRNO(response);
 	int ret = info_len;
 	struct fanotify_response_info_audit_rule friar;
 
-	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%zu\n", __func__,
-		 group, fd, response, info, info_len);
+	pr_debug("%s: group=%p fd=%d response=%x errno=%d buf=%p size=%zu\n",
+		 __func__, group, fd, response, errno, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
@@ -350,9 +351,33 @@ static int process_access_response(struct fsnotify_group *group,
 	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
 		return -EINVAL;
 
-	switch (response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (FAN_RESPONSE_ACCESS(response)) {
 	case FAN_ALLOW:
+		if (errno)
+			return -EINVAL;
+		break;
 	case FAN_DENY:
+		/* Custom errno is supported only for pre-content groups */
+		if (errno && group->priority != FSNOTIFY_PRIO_PRE_CONTENT)
+			return -EINVAL;
+
+		/*
+		 * Limit errno to values expected on open(2)/read(2)/write(2)
+		 * of regular files.
+		 */
+		switch (errno) {
+		case 0:
+		case EIO:
+		case EPERM:
+		case EBUSY:
+		case ETXTBSY:
+		case EAGAIN:
+		case ENOSPC:
+		case EDQUOT:
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		return -EINVAL;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index ae6cb2688d52..76d818a7d654 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -132,7 +132,14 @@
 /* These masks check for invalid bits in permission responses. */
 #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
 #define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
-#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
+#define FANOTIFY_RESPONSE_ERRNO	(FAN_ERRNO_MASK << FAN_ERRNO_SHIFT)
+#define FANOTIFY_RESPONSE_VALID_MASK \
+	(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
+	 FANOTIFY_RESPONSE_ERRNO)
+
+/* errno other than EPERM can specified in upper byte of deny response */
+#define FAN_RESPONSE_ACCESS(res)	((res) & FANOTIFY_RESPONSE_ACCESS)
+#define FAN_RESPONSE_ERRNO(res)		((int)((res) >> FAN_ERRNO_SHIFT))
 
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 7c92d0f6bf71..2206b3ec01c9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -233,6 +233,13 @@ struct fanotify_response_info_audit_rule {
 /* Legit userspace responses to a _PERM event */
 #define FAN_ALLOW	0x01
 #define FAN_DENY	0x02
+/* errno other than EPERM can specified in upper byte of deny response */
+#define FAN_ERRNO_BITS	8
+#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
+#define FAN_ERRNO_MASK	((1 << FAN_ERRNO_BITS) - 1)
+#define FAN_DENY_ERRNO(err) \
+	(FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT))
+
 #define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
 #define FAN_INFO	0x20	/* Bitmask to indicate additional information */
 
-- 
2.43.0


