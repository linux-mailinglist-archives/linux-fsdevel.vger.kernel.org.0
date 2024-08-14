Return-Path: <linux-fsdevel+bounces-25999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C09524B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211EF28143E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287541C8240;
	Wed, 14 Aug 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="en+qEQiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE71C7B98
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670775; cv=none; b=RmM5fQ9lbne7uNi7KknoDMNMX16AoSfrEJsOmIQf3gU5n7soKT/t8TGywONYEmKxvgoIpeoF1yp+5j1v3dGhNrrSzNm25vIvK2DkwuWopxPaaehOeXhPdpWLPEgOxdz6mGL14QU5ngmLG2AX6Orwlz1ppic1Uu/DFiQNHUWZYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670775; c=relaxed/simple;
	bh=x/zxNttmCT+y0dOsXy0tvMYfEvnIhvz+MK7V5Zr+cWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iY/vVDuXsQCTgSmX+q3+qVoBm9Eni+eOO8MPN9ixEwC4bzaeNRc3W2e/d0ex4XsqyOTGCDGVXgQ02JHdblcwbHm2E4RgJ8y9PPOpA4PwXRaUD4X5IKatgpvU2bgpp6+TQtLwZj5fw3AssKanKrUJ/DEo9QujGa7UVwoJh2y3p3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=en+qEQiO; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-810177d1760so105651241.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670773; x=1724275573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/Hz6ZhLh0CWwWHWSWJMj1KvT9KtOfMKuwzMM3GJFXM=;
        b=en+qEQiOETr3SYLmlzGaTW8td+fupQSJfA5ALa/ZpPCgoL/KymuDIrrW4ZL3ZM8RKs
         Y6BZf90ZpT9z4gUXfQEisEoMZOp8xeMLNYM7WDZAyo2HJ/2H5ZA25T20uH5yQhyCJoxL
         E22rBWBqqUpE7U565sQuVT6sL7GWEuIFmS4pdJinGK4zbHJci8OR9L+0/9SujHvHXjrU
         V7oJlPqe/pZspkoGYu1Bofrskkb1ZFoxJP34D7rqrB32Li32R1N/SuIa3/1PCwxeayil
         l186EMeikpBxDEcF3zrXa2J8pxBIOcK6nygtCvCEa9KJ0KyrJruQjesS/Gh1/Rgg5MjQ
         FE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670773; x=1724275573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Hz6ZhLh0CWwWHWSWJMj1KvT9KtOfMKuwzMM3GJFXM=;
        b=XLwOF0cZPWko+tGtwFUWCofBxJDOk84a37kbRiqCi/GYjKEdwVjipZJ8YFTut0Hy0Y
         AYh4K38sTu7a6VROxIgcu+WBxZwlp5rV9IsbIuQtFffmZ312G0VfCicJFTCOH0qMjc7B
         n8F07IYyFRujA/mecLCAl99Sa/Zk4o8XGfKIooOw2p+G8880uOV2iFy63oKOolQ8S2I6
         vwrTy2Nohs/RudkBur0h8SrPmwMmR3fxuRvaex0+BHfCUOVnATWaWHIZVEM9H/1yP8oc
         93cc8QYJGh13sTyHTGplJH+qS7Kx40ZRD+orD3HIRxhtMraBPfjqjmRzdCWhXZNklcYM
         OeuA==
X-Forwarded-Encrypted: i=1; AJvYcCXw5FnpBlhphd7kx/H8MQcphaqZ8CtQvmHOHV6MLPU1DZr52oPFvpzBOU+B+l2NjYIm9TU2N3jLpwRcchgdLZPlekISRO/c+S0/klH2aQ==
X-Gm-Message-State: AOJu0YzLn3F+J4rgQpPM2WxQJSsMqndnao3p5GGagNM4NOh6G4e1HcrK
	k2teCWh7LUEprozI1sCG92xlnX2sfGuttFjUVxQdpndSrABbWjqaGIgao6W/57I=
X-Google-Smtp-Source: AGHT+IEgvzETar+HRop8OxZM9BBYNdvV/dcg/BqJjJoXGsdJI9+RkgFTa2pKDMrLYqGGS3MRLjx9Ew==
X-Received: by 2002:a05:6122:4699:b0:4f2:f2e1:5f04 with SMTP id 71dfb90a1353d-4fad1ea4056mr4448238e0c.8.1723670772920;
        Wed, 14 Aug 2024 14:26:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff11d9sm557421cf.21.2024.08.14.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 08/16] fanotify: report file range info with pre-content events
Date: Wed, 14 Aug 2024 17:25:26 -0400
Message-ID: <b72ac7d8171570eaa9adf05e5a55f6ea8ba41ac2.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
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


