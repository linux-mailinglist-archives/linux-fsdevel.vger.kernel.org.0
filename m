Return-Path: <linux-fsdevel+bounces-24274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66D93C845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913171C21B63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D50A26286;
	Thu, 25 Jul 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="l1uTIwj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BE4D131
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931615; cv=none; b=j/Qdni9asvmUG8BRP138YArmigt2lRsCbFgV9bzCoHuBWKUVYCS+o3pGQVg7N+FGHAgFqB/6/Rcb3Dc7oWvmtiilCQEr8dcjJJIbyD4AtLHPTy+ItZA3O560AxUzUHGpKRM/9g88H6HXVc6P9fMxQh+P3nUkkBxt46QN1Bo+1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931615; c=relaxed/simple;
	bh=lM4E+0QDfWeiHiQEc8/d7xk75Z3XLq+R4ATU188GEVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4NLE9lX7KVHXRZI+hVpHzF6vVHe7gBxZTzswV963H5WdRxUCEfnyJz/oudlOkVgdN/rlsfEOjXu2DJ8W0FJM3LarCy8NBzGVXRuZub8zRSruOSDudxvm4haEj/ivWgHEFY/nkcMSDBj7m5OCsdeauruwJ02sqWmyt5BWs5Sry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=l1uTIwj4; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b798e07246so8774616d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931613; x=1722536413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjfT3NMblUo7sZTNjknqk3yM6nPmAl4UxLqtdr8jd/U=;
        b=l1uTIwj4WY8fy3xNo4jAI5aMBjn3QmtBe4NFPu2J5+wmXTfvd5xAfOt6lHsOaRdUrw
         YMkMHSOmiLvNE8dqsVMCX+G/wHe4AxV8iRl2qe069x4vJWRCKk/6iU0J5N5PDZ5XKFda
         XqwuWo59gq86xpG97l7W+DjRaoLBU5JGdEZ5+kaVzU+LLEOrcc8S6kGZ6mJQkjpnT656
         PDx7QYMBdh04NrxI0UX8114nK54u/0uxA5fdmdr/xl6nFCrgIpXfCxlXL3cLvCyAa8BS
         YoIbwB0jxAIKgBXv44DNrZxYD3nPYAD8C4Zrn8bvN8SNKYXFE+j73VMlrq8yXUIJGq1O
         E+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931613; x=1722536413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjfT3NMblUo7sZTNjknqk3yM6nPmAl4UxLqtdr8jd/U=;
        b=YC0BQ5zm8DZOqBKaxoiY8m3p/7zCfixhJoor+X8Dm4gKvT4NoFr4GnsFpk0uZ6NPdR
         +neqdATMzBD9wU7CF42wQUNK0Kna0ZYyxfeJNcllcVfL9XbEPaxo2ZYDfTVqT6z9GQbi
         uAD6DX5k6VZHzBS7kTGwlj9nPJPvfAB64VlKZZeKY2eL3hme5uFQYqsydH24V7q3thzr
         o6mM+x1Z9rKPMUSFB31f/KW4tJAvy6F8buYOVqoPx2fQIs9jZAz5oFfVGbR6oCoZoJc6
         sphEa+cftEEcYY3iw0gigKDg9W6j728z9kfouwabM0dO2yUONa1my4VcfJ51SHRGJG+y
         Z/7g==
X-Forwarded-Encrypted: i=1; AJvYcCW8ycL4HmeqqsitfjLjPtkoV1urB6z2EhhbC9ZY0p3AMJ0fmLKX1vALGC0U3009eeI7YIt3HhBTsRd4aI4DINSaXGboXlMwtyikywBN8w==
X-Gm-Message-State: AOJu0Yxlzi5RaNkYstqAngVbR6DgBoQSWEcbMBn15QYgeHoxpR8LGMCX
	k9MAwbxJgwpurEo6LES8uxuNTSLU0j6himMQvKYLEKbhLWEh3JIXmtTFlygOmU675o4+TfyEDHo
	4Fok=
X-Google-Smtp-Source: AGHT+IFFfvbHF/C1laqvOMe2uYaaZuz/eC8g0YkT5+sgQOImF086WDQgk/iY58n25Las+sOth7hX6g==
X-Received: by 2002:a05:6214:762:b0:6b5:4aa9:9682 with SMTP id 6a1803df08f44-6bb4085e2d3mr29316516d6.41.1721931612958;
        Thu, 25 Jul 2024 11:20:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac47f7sm9567776d6.115.2024.07.25.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 07/10] fanotify: rename a misnamed constant
Date: Thu, 25 Jul 2024 14:19:44 -0400
Message-ID: <20137566913a612692aaa0a9c79bb0345e94c26d.1721931241.git.josef@toxicpanda.com>
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

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3a7101544f30..5ece186d5c50 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -119,7 +119,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -174,14 +174,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
-	if (info_mode & FAN_REPORT_PIDFD)
-		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
-
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		event_len += FANOTIFY_PIDFD_INFO_LEN;
+
 	return event_len;
 }
 
@@ -511,7 +511,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0


