Return-Path: <linux-fsdevel+bounces-34498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBC9C5F9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2802866FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699A215C47;
	Tue, 12 Nov 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jBB1u7L0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B732170D3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434195; cv=none; b=Z//l8WRj+0cWSl/JW5HwFBwEvRx46y0Ut0HiJhsQV4nTdxxhMD7oQ0hduy8khI3TjL+4OnmparnTMgcSco2dzOqgzqBKvxx9fvVfEuhc7G9PgPPtzwu8/VkSnHX02DjtCp7hNIKfK9lqOdzCbsTMtGpigqLk0LlLJo8WLpNPZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434195; c=relaxed/simple;
	bh=S9iJZLC3kW1AcdAAZXs7jDb7QSsAWUdTUn2Xw7khTW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY9jy0iWZoWOjGgrbbH8PhyhD/qo9zMGLftCvbou7XHM7pKmX/7DeXTQoyp0wlhdl+mNSxLQj8OZNJj3rIuFZpKuWQnkoKMgqqTYzXJYs0OQ2vGyyk7t+GuvS/emwVcxt9x9QDwTud6W+PbyxYmXrLl2+Dm9a5IJFutGz9xE2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jBB1u7L0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29218d34f8so4302648276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434193; x=1732038993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLBk0eY4CldnJ4xEhkKNTvdMfXwQixnxnwnrlcZUems=;
        b=jBB1u7L0m/LXhuHZy7gUl97BSCkPWmsm6cmMadOwA3Q9sCbO19IBQiwGfczMHlLYM/
         pt/ZN9enORDmu5aGJ1uJA8I9EJ/1A+nta39bndgKZUIu6fPgWxX9nPHtGpFOWMJg6zOy
         /HsJO4vPQidrvQ1UmCQq2uiUp6XuitdYzUK18G2NQ0gfFTCUomGcX7SJprfijVvF1GOl
         6i1mkff/dasrrqrYcZYOlpkSQQhTAGANco3MyjxxqSchtOXAv0uV/HC/1KOdutlb+qAB
         Vq3B2BquxBbiwtYALc8qUKvHbogG3TI56LC9kaERQ3vdjYYJDc3hTXhoyEKHhU1+q3NL
         0orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434193; x=1732038993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLBk0eY4CldnJ4xEhkKNTvdMfXwQixnxnwnrlcZUems=;
        b=v1WyGugNYvHgsswZ4SWyzux8tqL8GLDtun7WjMNpBnfi2ItHBsqjevuXNOQbFe9W9y
         9QsIUrlA3vBZuzA6RthhtsvgpJCPMFC0jdYkAx9qXTNIcHnE2OhuyXKhIQHOb+spGzNo
         ZICeWPfRmMcoigy5mKg2KZgeb6305OJnkXct5be4G74dMzpqyDleEKY/dIkaHpKvhuIL
         yrnrFbp2fnZj66EFIfFBgTkjQWaF/YmtZQhUjzcgmlzfRHWPdZRAQ1wJaRI+svMw8T/C
         5NjEQFHxfcTTl8wlIMMol5NmsHo/ueXZnl7BkIhZZv0Lz0IaakEJzII5pQWds0xPnMmF
         TdjA==
X-Forwarded-Encrypted: i=1; AJvYcCVdcFz4U6XDqV24ANFS90X6p3oWPKuBghs8PbYQm7SMPN06GUNEqcUqTdVCVeC0662C9wUeBin6tEreH14l@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ccXf9gCTfLkr55uBTkV+B/S1AypZ/DkRUhPrjeXwsVcP4Ar0
	EsHpoBtEXCMJRytLOT9r+oI5kp9MecwcM5xbfN9N34ATStuyGYVnC0/Ritx5QCY=
X-Google-Smtp-Source: AGHT+IGq9atUwLu6yRfGGU3gZisyi+y0UAqwpKFwzP1csSwnkEjcF1T1CgCueeohLnBc8+4LN1Gtbg==
X-Received: by 2002:a25:8481:0:b0:e29:2988:ecf0 with SMTP id 3f1490d57ef6-e337e102bdfmr14488297276.10.1731434192790;
        Tue, 12 Nov 2024 09:56:32 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee1526dsm2752624276.2.2024.11.12.09.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:31 -0800 (PST)
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
Subject: [PATCH v7 03/18] fanotify: rename a misnamed constant
Date: Tue, 12 Nov 2024 12:55:18 -0500
Message-ID: <2142cdfd0bce931024cb715b6e178f3f5c49e797.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
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
index 8528c1bfee7d..9cc4a9ac1515 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -118,7 +118,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -173,14 +173,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
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
 
@@ -503,7 +503,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0


