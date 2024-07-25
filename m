Return-Path: <linux-fsdevel+bounces-24275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9657493C846
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E04B281A6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4451C5A;
	Thu, 25 Jul 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ozy0VSdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CD4D8B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931616; cv=none; b=Lex0BtIku0gFylW4zDyW5qjVIBKYhcPUPro42w3SL8gewj7ivcgFTRt5VRA83yaKGTXDCEokpnAKKuHDxt0707rLZE1MAb+ivNNLqLgph5FnYyWuCXtNM4m9VfcVLo1AE0C0bcQHGUwj/DWCPgNekJI8WIuheQQ+sjeIfQddR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931616; c=relaxed/simple;
	bh=qSobnib1UMqZJPqLkryISi/+C25PWWR0+lf3t+hTHxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kK02dUdvohDbbjdw07rVt9e7+6VhnskjEOqPMcHuYVN4kxgZ6sCu1oWVBhB/jCu8pZcnTRn6+QOvhnvrwA0Pjc1iupMV3QJR4+6YNSl84zopeAT+r39yrhZBcrtqc6slG01qrprr91aRUNjyyg8uVtjs7K9dtYWIAv6IUFFVhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ozy0VSdY; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db145c8010so100754b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931614; x=1722536414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnJ5oPvx7cNTyoAW0ZZ+8FiB3U4eBJ+Fssv39WcDM1w=;
        b=ozy0VSdYH3sCLP8f/K0X6UCa91e0ANvkahas6DE7k4rb16JgKgQV+vJko0uyqhPujf
         630gLk+rinHI2PPyI1Mqm4LYtTJ+yZLhI2hKVFgN3TXcN8PvTs+gFd+0mVfY00LcaFWA
         CGA7Ebt15RJOfms8t3hX4fKlMZuLnzEBYFcsyXsQOr6m8flNL1flOUsaNZqDmQtOOm5s
         uAUAxg6AnrbgIaKbkjwjnHIZylYWwVLgqUVS+QQEgwLy5bCixRhHgngMBcpQmWjuQMF3
         /vnUSc/0CS6PlbEAMhK8IIBfbj7YxHgQAnpxRT4d4NSya26O/Q+PfBLWLmsu37KKw4rt
         9RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931614; x=1722536414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnJ5oPvx7cNTyoAW0ZZ+8FiB3U4eBJ+Fssv39WcDM1w=;
        b=MHYjFrYdcUy6p2Ghyq599ORUucMbPPlyyWV+x9H3MpQQj6HbyHarim/5ltvvcQiydC
         GN7SStS9TZHCfw7fnwpd87tZUf5L5+7zOnL2eh7EqekuM/GyJKyXeHge5Pj7ZxgD/dXJ
         urD0ZgmrgblsSItg43G/XUwFGhiWzRYPgXWoIhH9gOdKxlWJUXwmr+ULXpxIs9ZVa1IO
         pg7/Ej5TXqhalVZasbMYRaH4A5FcNDvhQjWA8+cgt7tnyHqd2NnllkF29xtk56ShgbQo
         +mRXzaHmDpPY4VCJb8GZj39O3ml44Ac3bsU14xM6dZIOLhW3TkPRSQymtUr7FE/taQIy
         anrA==
X-Forwarded-Encrypted: i=1; AJvYcCU6QRKZc4cK79FSzilGIFG1+q/O3lHHtpIW1dw/Gi9Pg8dNe93Txs+f6c/XiNIyhoQKMr7C9x+moJyJyEQUCtbSQnlASkCUQH8AbmIiXA==
X-Gm-Message-State: AOJu0Yy1cY/4jMa02NWE/jZV+jsSojQp8CKLM9SjECONP14JkwZipjOi
	nYeAY8qiDL4YdlWgQCakS54Bvarq1LLUVOrC1gRcpEPxtX16xBfwn3j9oi3S8jM=
X-Google-Smtp-Source: AGHT+IHE8+T0/vdmmmbelfmNpfZh6chb7MkDBY0Q9mDeC9QHjQxcAvo9vt+Go2B3fb431p+d7hferA==
X-Received: by 2002:a05:6808:1883:b0:3da:bbf9:9284 with SMTP id 5614622812f47-3db1426f00cmr2630058b6e.51.1721931614178;
        Thu, 25 Jul 2024 11:20:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe820158esm8136771cf.73.2024.07.25.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 08/10] fanotify: report file range info with pre-content events
Date: Thu, 25 Jul 2024 14:19:45 -0400
Message-ID: <1a378ca2df2ce30e5aecf7145223906a427d9037.1721931241.git.josef@toxicpanda.com>
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
index 5ece186d5c50..c3c8b2ea80b6 100644
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
+		return 0;
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
index c8dacedf73b9..7c92d0f6bf71 100644
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
+	__u32 count;
+	__u64 offset;
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
-- 
2.43.0


