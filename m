Return-Path: <linux-fsdevel+bounces-34940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B79CF17A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B10B385BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BDF1EB9FE;
	Fri, 15 Nov 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cjESmci0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347331E884D
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684705; cv=none; b=RXKmj9UuqmdQbdk9n0wDviTyzQO7f0xC2mmMmJc7ns+dNcMMZTNvw+l0lRnOH36rqwQNqGTtrVbVVvaJer6/gUKboL/GmtEzvv1AxIMkGBh6KISq20NC6VN7mV7H5smQlX6X1FZ+2f+QOs+6sM1pGyvyAWqb1i1QQfMqCdkFQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684705; c=relaxed/simple;
	bh=S8KtXYKv5KBhFWGf/VgvN+plHsknP1dZU8l0VOqJqrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V34X2/4rM2+3BZ+zFkneBbYNfPms0PVOkH6jcUb4TP5yOoUy97ZKo+O1bJ0u23yAZumnmpn62HY8GqEQfbwW35W/F/GwVNT4oTn1DIzMO58NJ+MPDEPObRZujcIvKNqCkXHP+K6vPbXOAZRARby5WAQyI1ctyZpu8eUWyxisAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cjESmci0; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ee40e83288so24261967b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684703; x=1732289503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLlpuiMn0030yB3+s74DQOOZuZXxBi++zrJRvWIMp3o=;
        b=cjESmci0eXPgddC80zNMv3Udj7cRoLwt04JjPWZFgXE4tKyGTzGiIXhCUbbHYZ/69n
         qn0lkya+Xq+oZD3R8S8/rNjn5yQRNFm/czvtmqDhXcWfUkd79+KiJfkkphomJ3lAZZYu
         Km5G3flx5Xr/fzAiuLt7WRo/QpUlfd20+JLLfDmXL7wFdciCvHVIMgKoyJPgVpu/J5O6
         OV3oGaUHK15lyJoJN1eQDK/MWqmxEUPDFxiRFtpL28Sfi/76yjooWM3hqemO22YEwMz6
         6hDZdzNz2zC2UWbYuUwBxl7aNfehFbAPBl88uD4mRStfZWWH8MrmHitXlVNApIQFc1ge
         TBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684703; x=1732289503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLlpuiMn0030yB3+s74DQOOZuZXxBi++zrJRvWIMp3o=;
        b=jEVQjaSEa1kChLKC6RGe9UNJWghd97EjWXBpDGpK2/xzUqtn67F32ul1KxQW/i2yMU
         gT4gNLS8vRxpHbzrvg7QxFLQTuefT8CIQVh9hV7ByFwsbSr3H0nv4gw5cFPLGqOI1R9V
         FGB1conJwtiETIHL97NJxS5IusmpxyJ4l4KudzFJV9PxM4dd+O2lgEBHBpgsqlFST4Dd
         V4wXZJE2nT2vs64Hym8oCgkulkPzr8maB/EK21557IFlB2V7zoNvgw8dalYk7Iiub/RQ
         tGjXIMuT4GCnoAbvsQzvdhvI/LcdICHjMr9/Aff8toaC5Zxz+pMNdQ9HAs/P80nyzOmB
         bJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqiXW5uZ41lAqqAJi68dh2WdaMQ1Va88IqcgUoOqIP83ohSh0FlZycj/o/1CAOH0OGPzUYbnRHaw9khaFV@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZhnrWEoP01rqU2J1VpI7mC/vMs6cYi7dw+HrnU64Nms0pHUW
	vhMRNQbR0Ip1HzZwRA8Y2Xj6mVBD3EpjrTiCFtAM8FCGnGxti1cct5D15FlE2WnUqYuo+QMPYtU
	b
X-Google-Smtp-Source: AGHT+IHLmXNsFgoxeQH2zoAuWGXM6iZ0/bFoZDUBvajKhRUeKgJ2+BFXj02LrLEKz+I9Qy3GGhxCnw==
X-Received: by 2002:a05:690c:6806:b0:6dc:7877:1ea3 with SMTP id 00721157ae682-6ee55a6c9ebmr38646357b3.17.1731684703143;
        Fri, 15 Nov 2024 07:31:43 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4400c7dasm7862627b3.24.2024.11.15.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 13/19] fanotify: add a helper to check for pre content events
Date: Fri, 15 Nov 2024 10:30:26 -0500
Message-ID: <657f50e37d6d8f908c13f652129bcdd34ed7f4a9.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 08893429a818..d5a0d8648000 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -178,6 +178,11 @@ static inline void file_set_fsnotify_mode(struct file *file)
 	}
 }
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode));
+}
+
 /*
  * fsnotify_file_area_perm - permission hook before access to file range
  */
@@ -264,6 +269,11 @@ static inline void file_set_fsnotify_mode(struct file *file)
 {
 }
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
-- 
2.43.0


