Return-Path: <linux-fsdevel+bounces-34288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE39C469B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB851F25972
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE41C32FF;
	Mon, 11 Nov 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1mPvJ8G1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E51B86EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356369; cv=none; b=eo+EbrbAwnjeyAmZa04RSTeS/23AVm76sAf2JOxkCd4kFvbb0DT1Eyoy3X3p2qhPYg59eF3IyK9GMWhi4xaq3/8YNa7iZvy6dzhNmVklRiAsQNWMBfngAwUdBJpquUOtKjdLuqK0Dgvex0aDibd+KfvCaqQz624paWEXT+f/aBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356369; c=relaxed/simple;
	bh=MUz256iX41IVbMlPbLtNiUl9+PcD0bwfdnjYH0KeBmo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngJJS7Obi/UH+uOlhV49pGqDhdN5zvPeTajDBGseA+bzV+8LrvTPGQeK5L+0RC4BhmjYNG5IToj2TR0IM5SzPDdW9yi3uTPT7Mh6/2FUCKYostLTRFsWpXJWFoUIkaiTp7WIuADvZ5jMAiZAShSpuSdz7QVnz/vk3buXyNl9Row=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1mPvJ8G1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46090640f0cso40335211cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356366; x=1731961166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnm9HoX75xrhKnowV+mgCQOJIE5h2IvV5FM7hUYuNNY=;
        b=1mPvJ8G1OlyrXhsd29QIcwP93TIzi5amxtpKcnL7v5BzB2hNR2IMImlKtqiZ+SER/Q
         dUQOxytG3YC96/Rw+kvNbjQB1x700Hv4naaUxPha2jvl6pDxvCm3/lWwkX2tvNyZTiYT
         bGRQDdoksm/8oBgKMWn9sTOMZCaGRT1oN0v3d+N9mnLP72Tcz0zBYdC/zgI7atO+Abeg
         +ycMWfef01Sp8PLdT+eUs6bXfWkyuv4I/ZXW5qLusM9KsmHovLbfQhX48RLCgDJ8ww2H
         ss2qQRCkKUGv3+8uygXDNM38sY4KGXB4Ar3bMqG/1OkGybyad41dJ4/qGlPWeGfr1Jou
         +msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356366; x=1731961166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnm9HoX75xrhKnowV+mgCQOJIE5h2IvV5FM7hUYuNNY=;
        b=J2F8ADXidwIFsvanuxTWzXsLWUZk+jwTlQ+eiiSaRT5JsaB0F4WrpIXblMqiXKDI2P
         c94juYIwXsMEFRIC2bIiRoUhdtzDQ/qQHyqFEpTHHn8KmahEhc9hrZVcpCOxDWwbCnL4
         /7GPB4Qp828OCO9qP5IfvMC95ejMmmrqmbrzdALBF5JOTzANBiqhdwllhpkcJitURihK
         gFzwJRATPt9uPTq/ElSqLSsoh0jYbmIOfhPk40xNN7C+M35GGczWK3XYPX8FAxR/Dl2H
         pdKHKZqWr34Kz16pZQTxvCaZc87sw/0Dr6JM6qFjbplzCdhbaopSBtgjJOiHfnuLd8kS
         d6kg==
X-Forwarded-Encrypted: i=1; AJvYcCXxusI0QrNAIiXsDNu5ZoOeupURoLhL4qvJN323YDsuhVPhhZ/RzvHXXkHN+c7xC8PLd7+pTwTmZ+sAUAVa@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJE9IP1M91OClBKsVnPOw0lBP8wdXtSQlDiL6oPeLwEYCFnb4
	f/PrWSuBlJGLDbXzJzae81/Lr68Oxl1h1r5HcqVuFnFePnMSyjLIg2fI6DNlZaU=
X-Google-Smtp-Source: AGHT+IEMnK5byD6bzAeE8nnbH3/s1NiwYi6YVeXR6nrdTlyrutHvVhB1PYsiGKz3eP2xCUnFM1iy+Q==
X-Received: by 2002:a05:622a:1a15:b0:460:ac6f:477a with SMTP id d75a77b69052e-46309396323mr199480931cf.33.1731356365794;
        Mon, 11 Nov 2024 12:19:25 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff57e935sm66717941cf.57.2024.11.11.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:25 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v6 10/17] fanotify: allow to set errno in FAN_DENY permission response
Date: Mon, 11 Nov 2024 15:17:59 -0500
Message-ID: <a8322f5e45a257f7e21552d3e108d21061cc4a94.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
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
index 5e05410ddb9f..17af1b822791 100644
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
index 17402f9e8609..ca8cc2103b5d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -330,11 +330,14 @@ static int process_access_response(struct fsnotify_group *group,
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
@@ -343,18 +346,42 @@ static int process_access_response(struct fsnotify_group *group,
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
index c747af064d2c..d9bb48976b53 100644
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
index 0636a9c85dd0..bd8167979707 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -235,6 +235,13 @@ struct fanotify_response_info_audit_rule {
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


