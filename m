Return-Path: <linux-fsdevel+bounces-31205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52823993010
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F721F235F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99E1DACAB;
	Mon,  7 Oct 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJQXWdP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFC1D88C2;
	Mon,  7 Oct 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312655; cv=none; b=IpHl58Dv+U6xLP8qW7ilh6Y5stKl0S0FXt1k5q8RBN+zB0xWtBl08D4BAVeoMBFbwzyHhUmEXuQ2P6GjKWrRTYVEPAwED73sPkpzBHM4TznswAYpOmGeMlIYiZnSGbhCuOV2Ytod4Fn2PvvWBL4q/Pz8Cqc4pcaqx/72EHwPFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312655; c=relaxed/simple;
	bh=OZEyX4n+Td0PTF363pltBKc8zrr6moif+9ekNUxMXtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMpfJMhrpy8HKw08YoOOwk6IhkGvpV15owebjtep+64JhEmDZVmPQ4HYyIm2S29tYj4meRb5nlO402UL0k6KK60W/U98GbGleksOhZb8pqiauJoXIIN7L9b8hcsrm0+MIzceO+p3vTMdaDGIXdTxUTwbLxdkzLfyJjxmlqvoH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJQXWdP4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3101987a12.0;
        Mon, 07 Oct 2024 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312654; x=1728917454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VwBx3mFnKYzOzVHPezqvf6E6t3GSTY/lMuePwrb08s=;
        b=MJQXWdP4MsNAqlLA0QbrgUBdjt08l3YS6AzWq5ETPtfLyKyne2WUcWiPLKAY3wAxav
         HAQOPFUvrrz41lRTcWrzn/fEMzmZkwhghjIz7hkVm4V69mEfMXKmvpFeUUR1o4d3aYrX
         DSUkWMUo63N+Cm9+5bcJBEZY6++m7nqznUBtMVnDQRJwnAbcYaaJpmdNLGcHzv0TYIdp
         +DOqCF0CY6plmxbLNLDkpIaY8qO1nGBwmhla9R4HPiHKpG5EuDXKmNOrXl68mF/wSDL9
         0SXYmBW2lIPb5LCzcy8cGBhhYbenskBZ0GqRQf/mNskrSq3koSGkwhHZ2PgJFYNhXJc6
         80OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312654; x=1728917454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VwBx3mFnKYzOzVHPezqvf6E6t3GSTY/lMuePwrb08s=;
        b=EiNWMT/7Mx3eEtSsqiNzOyNdXK4CGgMw1XlCLaLt3Gu41m0/v8dYBptOTpjk8/PnG3
         AkRYzCi2H6OjbTYv7Bhg5XPylaBO5FI4nU9oaleVFmwc8ldTWeg9cGfpHRiaxkJqkq7D
         9+Y9+nAPUvkhxkS1lYS1/UKz22AoTHPeF2CNb8rHwX74mQfdYGy1u8O9uZpHp5jdx69t
         cwJ/nCCj0iFfZzBZQTJD/k52sV+Onhx5YaDgmnpDta3/sURismVZxAUgOoVKXI/lTZ9T
         xGI1Tb4aEqc46mlmxyBOROhPCfAs8ndPWef28u9PK/CKZhPZ4k5lc2oyAKzYgy2RsM1B
         kmrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFcmtv0nPk/2kbzMZLdbCivUQYVDVu2Ism6CPLMhJFFj2YnsMNGhxlEuH1wvupT1qksq9y6y0PtT80UEeHwRusb1gx@vger.kernel.org, AJvYcCVNBL4YrxGfhiKiuS05hFFtHulQjI/KzAjTtAPuaHVcr7tzQpnfLfmAs1QMEVQ5CUqLxTiSBv7l4Q==@vger.kernel.org, AJvYcCW1v8eWRHzeY8mW1qLl4+ucpdAF6XTAm9EJiRMg6EaseZ7miH9euPhvOppCKkUjlZCbG8E9Yw==@vger.kernel.org, AJvYcCW9FBrv/mAQFSVgkZ+8z7TN8Swcu9eNF1tOlSw42VU/Lf7UqhKolHuR9dkkgVQ9GOyLsfTd@vger.kernel.org, AJvYcCWVG9XJrU5gHYsBwK7pUzElLVRkNKz3y9pkHtlvE0deoU2BrjExN91z6P9EOESh6uv8yI5Di2ax@vger.kernel.org, AJvYcCXRx7qJImsHnNmvO9nfwzvIDD8r5dINlCE2STez3GP9tFaA26FEylcG2JU+bMLxhfOunb/f1ZUbc3LgUR4xtQ==@vger.kernel.org, AJvYcCXloclypBpq5EwXkwttAFV/aGSXcqB2gGk3OD5PU5DUrV/drAPM1fGf/aLVB6GOi/W6Lc1D+dCXF7d2+CLMYIb0DHjO8wRi@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQ3oDKDUJm0r57JyMgURZP60sBTnlmT9/hyj8/ZIPEj5C8E6I
	AgSR8IZhrNe/AyfCrNz8Dsihv6VDBSr+5349ggO7eIRCZn8VBt1N
X-Google-Smtp-Source: AGHT+IEwpXCzalPlyOY9Cdfli1GLzxvFvEupvvujLKDDOEy0H0EsRpGoLeoHLvpBbBHNCnkbeHqgcw==
X-Received: by 2002:a05:6a20:9f8f:b0:1d2:eb9d:997d with SMTP id adf61e73a8af0-1d6dfa23bccmr18227823637.7.1728312653634;
        Mon, 07 Oct 2024 07:50:53 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:50:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
	alx@kernel.org,
	justinstitt@google.com,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Subject: [PATCH v9 7/7] drm: Replace strcpy() with strscpy()
Date: Mon,  7 Oct 2024 22:49:11 +0800
Message-Id: <20241007144911.27693-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241007144911.27693-1-laoar.shao@gmail.com>
References: <20241007144911.27693-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent errors from occurring when the src string is longer than the
dst string in strcpy(), we should use strscpy() instead. This
approach also facilitates future extensions to the task comm.

Suggested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
---
 drivers/gpu/drm/drm_framebuffer.c     | 2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 888aadb6a4ac..2d6993539474 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -868,7 +868,7 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 	INIT_LIST_HEAD(&fb->filp_head);
 
 	fb->funcs = funcs;
-	strcpy(fb->comm, current->comm);
+	strscpy(fb->comm, current->comm);
 
 	ret = __drm_mode_object_add(dev, &fb->base, DRM_MODE_OBJECT_FB,
 				    false, drm_framebuffer_free);
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 6469b9bcf2ec..9d4b25b2cd39 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1113,7 +1113,7 @@ i915_vma_coredump_create(const struct intel_gt *gt,
 	}
 
 	INIT_LIST_HEAD(&dst->page_list);
-	strcpy(dst->name, name);
+	strscpy(dst->name, name);
 	dst->next = NULL;
 
 	dst->gtt_offset = vma_res->start;
@@ -1413,7 +1413,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
 	rcu_read_lock();
 	task = pid_task(ctx->pid, PIDTYPE_PID);
 	if (task) {
-		strcpy(e->comm, task->comm);
+		strscpy(e->comm, task->comm);
 		e->pid = task->pid;
 	}
 	rcu_read_unlock();
@@ -1459,7 +1459,7 @@ capture_vma_snapshot(struct intel_engine_capture_vma *next,
 		return next;
 	}
 
-	strcpy(c->name, name);
+	strscpy(c->name, name);
 	c->vma_res = i915_vma_resource_get(vma_res);
 
 	c->next = next;
-- 
2.43.5


