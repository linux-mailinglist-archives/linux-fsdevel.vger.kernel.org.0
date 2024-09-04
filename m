Return-Path: <linux-fsdevel+bounces-28640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC796C873
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC56B24696
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D141F148FEC;
	Wed,  4 Sep 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="baH9sSF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0218158DD9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481768; cv=none; b=WtdEZ6eiu5zXtfLPZ1wOYmGwS14DjHLEsGCGBGnf/67v9ZbmF431M9uN6fQxvJVl/iC01tG51Wei1Jq0lbgD1GnpvZDUSfxbL8ipiLhrbt67XldWCfWDiwVtUq/ScjS7bvq7RvdfWrNlidxth2Hw/QzbyVj5Hz0wI8f7Uq7z9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481768; c=relaxed/simple;
	bh=qausY9NaTn1Dmt/1fWvpjV6gSoo0TkpL7RjFx1j8ing=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRyBgSaz/+pvCNJAlLAHSQh3VMBh6IegZ5Xb9B1xjDW6hzRCU9f5m0JQCwVMqWFzlULixPdOT1fPGdkd0RDxoq4a2KlGEvYpSE3UOk2d1XgiX1xgXviaKJ5582pE3ZFW5XBsmGuvO6xTqLIBQ810LQiKlFdfdwSu8qN1LpP3lNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=baH9sSF2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso85026d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481766; x=1726086566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=baH9sSF25BC9MoGa72zssTgL4tSh4NUw65xw5uzBY1Ah2S3c/4aaV3+ZPuuFsEo+vz
         VXOTNl8x4jAy0C7ecGAirSYKAmWXv4NzHV6yQJM4PqZS7aFREYL3eblUgynJY6L6nH0M
         szpM6SmlHWi42JXLOjCtPwA4gboAwY9v+R76KatEPunSWuj1G6RaiQmQxjS9CMR9Q6MP
         NodiiVjHaC/rxBfv9eRQNWQBW6wEgUWwwGtZxTjZFkwAMC3/h2lj3UuiMEE2Bl2lX8jW
         GXnrodJQ+MbQichckjWC8x+4m2knti2kBzLIR0r0GFkvkLQ69rbfn/lDMg6rWA8fS5Ws
         LoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481766; x=1726086566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=cJ7i/Kh+lKFqqlOICJ8N19UeOLpx+37UhyHB91FUXcgBirwo1Qz/iM2SsLUbGvkwYt
         Lxoh+6VNpr7L08aIYqImvdauXRV1vMMPg2GVbJEz9/3wPxWnNS4Dgp0Dz+4yFb+Aug/M
         wqRP4jhN53Wi1sWTjn4sJn3+Z65ut05yT4a5zj7vtiITTDwSy5qzX8tZNexAC32Y+LQa
         hUNDEpGPkiGTtsFbiQrDyEkUrnonXmDi5d+e3GvwZgCnslJnDqfQme2fQ+628oKMrpYB
         uF4cIN8Zke4TMRr3dD9fI2cUJ2Y9jMV+kqKUjyrM/TWS0z+w5tBVsfa/PrYrSoKK2+TZ
         bAGg==
X-Forwarded-Encrypted: i=1; AJvYcCVHcAsC7QCLR9x0VXybk4vxOKMDAYG1pxURrrsEfHPOSp4AquLda5OJOuWOuMvXjn573dvPHJLHlbRFYtG3@vger.kernel.org
X-Gm-Message-State: AOJu0YzkeB5ep58wEQZV3iyB6xeaaMz6JbjKLsMyIlkBx0LcBOTRbId6
	GkdQwZEM6NrWRLd2ViaC4d03t+CnM7uOHchrCPS+l41HXN/IOmIIWgU73bTwnIg=
X-Google-Smtp-Source: AGHT+IFz/IUidwqQ59xRLvRnlzpJcJ1KGg9KuPmXBEEett+13VoyzgSnYGWxrufSaJ5p3j4xy3X2+w==
X-Received: by 2002:a05:6214:4b09:b0:6c3:54fe:ebef with SMTP id 6a1803df08f44-6c3558359fbmr194853636d6.43.1725481765951;
        Wed, 04 Sep 2024 13:29:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201dedd8sm1621726d6.7.2024.09.04.13.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:25 -0700 (PDT)
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
Subject: [PATCH v5 07/18] fanotify: rename a misnamed constant
Date: Wed,  4 Sep 2024 16:27:57 -0400
Message-ID: <13c1df955c0e8af0aee2afce78b1ea1f2e3f8f66.1725481503.git.josef@toxicpanda.com>
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

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
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


