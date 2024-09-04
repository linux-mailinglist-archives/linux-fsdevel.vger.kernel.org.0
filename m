Return-Path: <linux-fsdevel+bounces-28642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3517A96C879
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3861F275FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91B14A098;
	Wed,  4 Sep 2024 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Bn/qBV3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65D17A5A6
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481773; cv=none; b=YCB9tRle7gXO6JdRe4TJlkiN5HtrV67y6gomxAZTKejeAlv63XBviS7t7fzPFV+4FcxlQ/TARzDSwuRU0juYccJfJw+MkMF4RK2Rk+34cVvReccXRNNYS7nGUJj1/VQ1NIid8RpYmRkQHrb4guwgrGt7uSpc/T5BeDf8fdybbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481773; c=relaxed/simple;
	bh=rLw5E3Nr8xGnefhdw14RMig280QojdVrlp1xvQ092tU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7QgYxSwZ1Ut/99+Q4kAHRiNWcb0Wuq1jGyt4dO2LLOjGCt/T5YsawIFoO1rs3aGVqlH47Z3I8wzZCh/ZSDRnw3Itnu2ED8CvnX32lM+BXae9c5Ohtr9UtNb5yxrb1U3SfO7Lo+U4t0XbSfWNDFSwZcJVod2Au6Ub0agqrYz5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Bn/qBV3m; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27830bce86bso51895fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481769; x=1726086569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jRcB1XulXFmj7DKhtdmn8n+Hih5C6C9O3bk81xEiZw=;
        b=Bn/qBV3m7VcPstty/RD4YSBN7kabLSI9Q80EWDBXBFcc46EGxRChm5bGiFmw7ZGAR6
         1ql89+G+u2CHtuIUiLii4z29Ywf7y+s2dHcKrLbF/r1vMzrlHi1OA8uXeEVtzlQtKD6H
         tvqtRHr0a4WlJ6HQKYttJrdJh5Y4Kp5JZwHdJcZpzrJNBh0f6OrUCRmguIENUgxeyz56
         yFK1zz3+5q7ylIALHX19RhOnlpMUc4CKmsGfI7BohILpZe/A6LcaD9l1giUShev/5qYE
         eQz7Em0UgQr9EmopoH6pbzgZN66L+qUmINjaUTH5UeSg58xhvCqXjlStAhvDfOOLkml5
         u+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481769; x=1726086569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jRcB1XulXFmj7DKhtdmn8n+Hih5C6C9O3bk81xEiZw=;
        b=jawVfayCP3jJCClApyg7i41P8tt/tUnz0yh9fjfwetqzLwX76JzglhN8qLRS41rUpN
         bEz9DJ3t73koHKbA94mbdPxZwjqznul7O1wF76t1SpfOGAiSa1h/BhOrdn73whNPqmSH
         te0CMWKCKkj3fZKtOtQhbtSGvEN9WzzXxvsCXFk/OgYAdiigr/f81p0QGEcc2WrsOOaq
         Xtt19+Y6A8b8cyo/TqhCB/CfUHEAn1r6EY4uaYRJ1N/TOQz6+YJ80xvszqIcbETpw1ED
         KtoM3+mLkW4lFHWcps/g+YnwxggXBXhC33Zlx6DyW4gSpxSNXB/Iv5+2reOyh5tyJt9I
         /EGw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Xw0EllgW+BOW23uG3lLAuJT8ZB5mQ+3ZCiuYjacXUlPizNsCkSLL3nNcIVErPslmyDEkb9s4xsMRoZX0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg90fhlBQeeXJNdrdi3g/s6vHENhoL/HeV8AR5Z8qPRERQ/a/E
	/1oX716xC/aarrpu42P3y5SKbndsRLJY5vx9yczIY8FhCuoSWmLFv/W2ywr1EcQ=
X-Google-Smtp-Source: AGHT+IFWlV+ptqOFoXLlPgR/wzgAif5CenGcM7a3jH83CCzPXpqmv1KE+P96IBtwqQpEGOVQpckR6A==
X-Received: by 2002:a05:6870:a1a1:b0:270:5f17:b34 with SMTP id 586e51a60fabf-277900b31a5mr23054551fac.11.1725481769655;
        Wed, 04 Sep 2024 13:29:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efed964sm15316985a.73.2024.09.04.13.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 09/18] fanotify: allow to set errno in FAN_DENY permission response
Date: Wed,  4 Sep 2024 16:27:59 -0400
Message-ID: <8c5ace4661500573fdc078b5e595b9397c13b859.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
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

Limit custom error values to errors expected on read(2)/write(2) and
open(2) of regular files. This list could be extended in the future.
Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
writing a response to an fanotify group fd with a value of FAN_NOFD in
the fd field of the response.

The change in fanotify_response is backward compatible, because errno is
written in the high 8 bits of the 32bit response field and old kernels
reject respose value with high bits set.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 19 +++++++++++----
 fs/notify/fanotify/fanotify.h      |  5 ++++
 fs/notify/fanotify/fanotify_user.c | 37 ++++++++++++++++++++++++++----
 include/linux/fanotify.h           |  5 +++-
 include/uapi/linux/fanotify.h      |  7 ++++++
 5 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4e8dce39fa8f..2969f45a08dc 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -224,7 +224,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
 				 struct fanotify_perm_event *event,
 				 struct fsnotify_iter_info *iter_info)
 {
-	int ret;
+	int ret, errno;
+	u32 decision;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -257,20 +258,28 @@ static int fanotify_get_response(struct fsnotify_group *group,
 		goto out;
 	}
 
+	decision = event->response &
+		(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS);
 	/* userspace responded, convert to something usable */
-	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (decision & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
 	case FAN_DENY:
+		/* Check custom errno from pre-content events */
+		errno = fanotify_get_response_errno(event->response);
+		if (errno) {
+			ret = -errno;
+			break;
+		}
+		fallthrough;
 	default:
 		ret = -EPERM;
 	}
 
 	/* Check if the response should be audited */
-	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT,
-			       &event->audit_rule);
+	if (decision & FAN_AUDIT)
+		audit_fanotify(decision & ~FAN_AUDIT, &event->audit_rule);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
 		 group, event, ret);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 7f06355afa1f..9e93aba210c9 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -528,3 +528,8 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 
 	return mflags;
 }
+
+static inline u32 fanotify_get_response_errno(int res)
+{
+	return res >> FAN_ERRNO_SHIFT;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ed56fe6f5ec7..53eee8af34a0 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -337,11 +337,14 @@ static int process_access_response(struct fsnotify_group *group,
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
 	u32 response = response_struct->response;
+	u32 decision = response &
+		(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS);
+	int errno = fanotify_get_response_errno(response);
 	int ret = info_len;
 	struct fanotify_response_info_audit_rule friar;
 
-	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%zu\n", __func__,
-		 group, fd, response, info, info_len);
+	pr_debug("%s: group=%p fd=%d response=%x errno=%d buf=%p size=%zu\n",
+		 __func__, group, fd, response, errno, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
@@ -350,18 +353,42 @@ static int process_access_response(struct fsnotify_group *group,
 	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
 		return -EINVAL;
 
-	switch (response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (decision & FANOTIFY_RESPONSE_ACCESS) {
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
 	}
 
-	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
+	if ((decision & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
 		return -EINVAL;
 
-	if (response & FAN_INFO) {
+	if (decision & FAN_INFO) {
 		ret = process_access_response_info(info, info_len, &friar);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index ae6cb2688d52..547514542669 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -132,7 +132,10 @@
 /* These masks check for invalid bits in permission responses. */
 #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
 #define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
-#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
+#define FANOTIFY_RESPONSE_ERRNO	(FAN_ERRNO_MASK << FAN_ERRNO_SHIFT)
+#define FANOTIFY_RESPONSE_VALID_MASK \
+	(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
+	 FANOTIFY_RESPONSE_ERRNO)
 
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 6136e8a9f9f3..34b5d634de1f 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -234,6 +234,13 @@ struct fanotify_response_info_audit_rule {
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


