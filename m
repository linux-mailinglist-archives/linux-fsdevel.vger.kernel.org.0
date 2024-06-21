Return-Path: <linux-fsdevel+bounces-22056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEE19118C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBF11C214CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C73139CF3;
	Fri, 21 Jun 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwMGlm/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4F84A3B;
	Fri, 21 Jun 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937172; cv=none; b=JfUWyuh39EWSOs4uj2dh8hNgyonTX0HwwcAcIWS/liYt0/c/w0JI9sX/U5ViFjxkJejef0mllOEB3gtQvro0wLn3jdTlx7WfCCDC5sY5RrmgY2eKsn5yv9VSZoPR+e5wkxJZVV0ZmfEA6mMtBRsPSpOC8sI9ZYpPWug33kJQdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937172; c=relaxed/simple;
	bh=TrtFPtQa1k97XzAC7EiU7HM1PNrmylMnQBNN3TI+v6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1Ht26nTHrabQanIqf50GICzGhA+/jagUnwptKO+jpElIn3/XzGRTPSb352ESzPwYIyLl9eQSyWRb+Qk+hNKRp3VV/TWucebhpJDNDe3aEIg1UjOZE6fEq1H6hApK+tXIoC8IHVtTzakAL5QCO7Q0S/eSVAt+XLStrNM2e/msKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwMGlm/Q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706354409e1so1413987b3a.2;
        Thu, 20 Jun 2024 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937170; x=1719541970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByPZqEdQZBBtzQ6Ut5Ro8SR1Vw4SYts83oZvgSR+UR8=;
        b=AwMGlm/QaSabm+eVByh6dNVRZnCGZIRYMA3RIkMITjLC7GOs7mMvCUR8Sggcb4oTnl
         T0lDbCJE7LWXeoIjhost5Gt+zbaU5PBeBsXnFimIdQasoJHbIKGnOElO4obmW+zvEdlB
         jpae5l1gz2xVxL2E3SSS03ubCygdmCf+rrelZydI7RP5CroVPSIa7wZvy8izH6QJNZ4M
         bV2keBigldkjYs67RBZB7SXVYqgUngL6+gRob4i/i84omfeHlSt80DRJwKWJ4gLX+9xR
         uSckTWFvIgtnaoK6WB3Kk3qt5SrqacFJXby2nyuu8ZZjUXqjGVLDnofolpu5rXWJ80SY
         CbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937170; x=1719541970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByPZqEdQZBBtzQ6Ut5Ro8SR1Vw4SYts83oZvgSR+UR8=;
        b=Gn8ABcPjsNFf+usy2XO/qTVV8Y6KrVPcc1s8ku8AhRMvMMGbN9PTgshUZ6YlciOKUe
         pv0ArKjS1f8Z5p29UEQJptVlTp+iCxjJ0nVBahAWHGthG+ULd43pJ1Ou6HGDSTFf/OFZ
         T/AtZ4cMO5ef3+TYz0CGO5PIQ9I01rZZEcuJp1gFoArkbM5wjUS37aeNHhBfY17YGl0J
         PbN/qEb6zYKdxAmWnUFLQOzcEmPGc4ensX/roSbVPSxfnyglzZZ31gB3W4aMc89iUJbK
         muVRMK/sy6iCvHVJShT+Uj99XUfox7t4upwALMjp/44hNBSj532s6DO7d5QwpwAQDWpS
         /Pfg==
X-Forwarded-Encrypted: i=1; AJvYcCXUUX8c8aBsXY0RmBQijfrHl5m68VII6PU3yLiNXV6FhqTBx30uYvsI2lenhhfYkEo0/2LX97/WsOrrydh71x0zV/e/LjbLcxajWlxMI6Htdsg699KDD3gFnv+UPQhonVIeBHq0GvV3/Wzhwk+6ZxjUVxhWiag2/e6m1bs2KvjrKpzGgvIf1Nk3//hmPd6nEiNzTpfnjqCoKXYwpEiIBztkxyhVM7YTDWF+MaQEurT20C2MqYSSz67341PyzkF8dMkUwo34UFCQ4ufZXiQkYQlIiDvhIYP9kMsIKSOjuO1vp0v/wAzFSTgtZIvcVz9zi0B2FLhG/A==
X-Gm-Message-State: AOJu0YyNz3YDYyL++Vdubaj4CY0qVi/vw2Gsz2j6Xnq6SS8kBuX/gfpB
	tAy2bhFXBhYrJuDri05Rtyv+WOFSxmjzJEv5GSfwD9tgKliOfdxq
X-Google-Smtp-Source: AGHT+IHwLzKazOZk9J+TnuaENF2GrO7T5JApXVTdzZDurk6fW60Sg+sw/brS6M3qBlKISuVvI9yc+A==
X-Received: by 2002:a05:6a00:4d91:b0:6e7:20a7:9fc0 with SMTP id d2e1a72fcca58-70629d0d58cmr6849890b3a.34.1718937169948;
        Thu, 20 Jun 2024 19:32:49 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.32.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:32:49 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 11/11] drm: Replace strcpy() with __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:59 +0800
Message-Id: <20240621022959.9124-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240621022959.9124-1-laoar.shao@gmail.com>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent erros from occurring when the src string is longer than the
dst string in strcpy(), we should use __get_task_comm() instead. This
approach also facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_framebuffer.c     | 2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 888aadb6a4ac..25262b07ffaf 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -868,7 +868,7 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 	INIT_LIST_HEAD(&fb->filp_head);
 
 	fb->funcs = funcs;
-	strcpy(fb->comm, current->comm);
+	__get_task_comm(fb->comm, sizeof(fb->comm), current);
 
 	ret = __drm_mode_object_add(dev, &fb->base, DRM_MODE_OBJECT_FB,
 				    false, drm_framebuffer_free);
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 625b3c024540..b2c16a53bd24 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1411,7 +1411,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
 	rcu_read_lock();
 	task = pid_task(ctx->pid, PIDTYPE_PID);
 	if (task) {
-		strcpy(e->comm, task->comm);
+		__get_task_comm(e->comm, sizeof(e->comm), task);
 		e->pid = task->pid;
 	}
 	rcu_read_unlock();
-- 
2.39.1


