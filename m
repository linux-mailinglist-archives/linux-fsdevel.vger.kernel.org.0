Return-Path: <linux-fsdevel+bounces-25461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506994C53D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7ED0B24432
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F20156257;
	Thu,  8 Aug 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kEHDaZ0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73415A876
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145310; cv=none; b=e+XOrjZdIs9Jdbu9nV16vfkUZL2a3ADD/jbwyHguqTCOc9kA83vUYjvj8bsJxFkp5RI1FnH8jW8I+/34wh/kygxM97caLPHc+lpZfNbKVHDMxXKd5IY0CUsjyQ4OE7uGrlVOYwNWxJxzlXvI1RnTcSErqY9WTjxFaYxLTKJsJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145310; c=relaxed/simple;
	bh=x/zxNttmCT+y0dOsXy0tvMYfEvnIhvz+MK7V5Zr+cWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPxnCtD+YthdiHpTpPgWmLW7zeQxvJG7VuIErLfXqyCSbMjdMST+B8l5OJUYXU16tRJt3A/ZD5RNsf+67HwLk+TONuCYqHB+isgwRZiocrvcXTtIiKrg5j/moNlYQ7z5q3DbSbCm5HWw3qIMguqkS3JQUM7r4P+9FmX98D9QSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kEHDaZ0c; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d3959ad5so118297685a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145307; x=1723750107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/Hz6ZhLh0CWwWHWSWJMj1KvT9KtOfMKuwzMM3GJFXM=;
        b=kEHDaZ0cqQhrlEz/TWdEvjdXA1jictnrSbSJj9gyZk9fdKC9pQ84ihJUpjkzWO3YfQ
         BbvmSuSwNiUT0rmOk9SB75Y6YK3qmMnRqIn+kx9g3KIApG0Vm8p2UMeMhdXt8VD5QjUD
         rP2FcCE1IDSWicZIHgOD3tNQq27kzNwxKcuhnXrv/hI2/xXgE5dw34c5HZH3Uixjtmd8
         uXCHNhOQgAUZHzhNqqR2nCa0GSSCgggxFZ0sqZeEGEyB0V6h2aEwpZNIG9CBhIRY8Twv
         +3QLPN9aqi2TVCrB9SA4+GEIIziqS+dROtY/Cl5rog5oWE+Z1szuLg+TjC6sruZcpwYY
         qGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145307; x=1723750107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Hz6ZhLh0CWwWHWSWJMj1KvT9KtOfMKuwzMM3GJFXM=;
        b=hZwogZ0eVERdp2g+e9aVFJU3ELZpeIEMxRaXuQnbH2EE7EYVbSxnmR3uMBvOkRzriy
         M/h6szKfYVMr3x1Zequ4YX/P+ZAJV0DP18O11NCz8CLdq2RhqeXdUpdFAAzw6K8ZAIeR
         h4xvKmLs+4hFg2Dwc5wn+dD04MbGZnDfL108Xg08RvXAxB3NyQd2hVZPAeBLSOFdmEqb
         0nNsJxq1Nn7iJr2sLkSCvSgnLPOlrrqkCqCaB4nUccERcBUypzgi6tb9B6+2km8encvA
         lJTVPivrxuRvav6CCUGS7xVlNC0JoFx8XWJd2Z3y4hJEyRwMI6fzqMh1as8CW66mUCqo
         RfdA==
X-Forwarded-Encrypted: i=1; AJvYcCW2kHZCnN9jfpUa01PeaaKHwzPiWuoXMEiFUPxij9EPxIvsoUYKljI8tDaBHSpfAVCiyJiI4DlbnAd13iHKyD2nJIt60JRfluOB2450sw==
X-Gm-Message-State: AOJu0Yxc2jccvn38KDu2ZXtt81IDtJAS6Afc7FfKpfzSVEJ7lH6sNOW9
	ENmYnMx2bXqXayw7F5bXFvXVS6apkw47iD60JKyP/9ahr7r2zGnzs0+Ot6eaRoE=
X-Google-Smtp-Source: AGHT+IHevrYqSvfIR9PpV+71TzE1Gr09+Eeauvh798vi19CUyPqYAs9+KzCuXWncrkXC8qcitERfHg==
X-Received: by 2002:a05:620a:2443:b0:79b:a8df:7829 with SMTP id af79cd13be357-7a38247641bmr454452485a.14.1723145307425;
        Thu, 08 Aug 2024 12:28:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785cfbebsm189000985a.14.2024.08.08.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 08/16] fanotify: report file range info with pre-content events
Date: Thu,  8 Aug 2024 15:27:10 -0400
Message-ID: <3c49d7ebc450ceae5433fc28535274fee23b2c01.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>
References: <cover.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

With group class FAN_CLASS_PRE_CONTENT, report offset and length info
along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.

This information is meant to be used by hierarchical storage managers
that want to fill partial content of files on first access to range.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      |  8 +++++++
 fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      |  7 ++++++
 3 files changed, 53 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 93598b7d5952..7f06355afa1f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 mask)
 		mask & FANOTIFY_PERM_EVENTS;
 }
 
+static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
+{
+	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
+		return false;
+
+	return FANOTIFY_PERM(event)->ppos;
+}
+
 static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 {
 	return container_of(fse, struct fanotify_event, fse);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 5ece186d5c50..ed56fe6f5ec7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -123,6 +123,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
+#define FANOTIFY_RANGE_INFO_LEN \
+	(sizeof(struct fanotify_event_info_range))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -182,6 +184,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_LEN;
 
+	if (fanotify_event_has_access_range(event))
+		event_len += FANOTIFY_RANGE_INFO_LEN;
+
 	return event_len;
 }
 
@@ -526,6 +531,30 @@ static int copy_pidfd_info_to_user(int pidfd,
 	return info_len;
 }
 
+static size_t copy_range_info_to_user(struct fanotify_event *event,
+				      char __user *buf, int count)
+{
+	struct fanotify_perm_event *pevent = FANOTIFY_PERM(event);
+	struct fanotify_event_info_range info = { };
+	size_t info_len = FANOTIFY_RANGE_INFO_LEN;
+
+	if (WARN_ON_ONCE(info_len > count))
+		return -EFAULT;
+
+	if (WARN_ON_ONCE(!pevent->ppos))
+		return -EINVAL;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_RANGE;
+	info.hdr.len = info_len;
+	info.offset = *(pevent->ppos);
+	info.count = pevent->count;
+
+	if (copy_to_user(buf, &info, info_len))
+		return -EFAULT;
+
+	return info_len;
+}
+
 static int copy_info_records_to_user(struct fanotify_event *event,
 				     struct fanotify_info *info,
 				     unsigned int info_mode, int pidfd,
@@ -647,6 +676,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_event_has_access_range(event)) {
+		ret = copy_range_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index ac00fad66416..cc28dce5f744 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -145,6 +145,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_RANGE	6
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -191,6 +192,12 @@ struct fanotify_event_info_error {
 	__u32 error_count;
 };
 
+struct fanotify_event_info_range {
+	struct fanotify_event_info_header hdr;
+	__u64 offset;
+	__u64 count;
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
-- 
2.43.0


