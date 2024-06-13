Return-Path: <linux-fsdevel+bounces-21593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD6906202
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA8282834
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2A12DD83;
	Thu, 13 Jun 2024 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNz+sP19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADE12BF1B;
	Thu, 13 Jun 2024 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245946; cv=none; b=cLeBHX6oYEJCwkm8KrUPIeX+5rgvyOawVg+/t++Jkq+J9dKdoC0T+2iGuKVR2Hw/KMAh3L9gj1gbHkDvphBL6AViV+zEGDbiEaEHTj0R2KDaYp4d6b74rpADWxRYVLlL2Engp5/xuv1l9eki8Y7rFaQGnyQHaAVnQMZW33vQJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245946; c=relaxed/simple;
	bh=TrtFPtQa1k97XzAC7EiU7HM1PNrmylMnQBNN3TI+v6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dgADylTPRDdYfQdybrUMlpojp+fHiBR4xGg50ixYYXMd16ETtBkhkAg+K44CrVfOQtL5RdRTz/3LfoRYRA5D+ri+ZhyiO10+PwzHbSTTRioFo3nJ7Ca1nXZuzwsPUBmScL5vl7UwGytTiCTP69owRyWEIew+SD5CHwe+IcO8Ko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNz+sP19; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so384166a12.1;
        Wed, 12 Jun 2024 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245945; x=1718850745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByPZqEdQZBBtzQ6Ut5Ro8SR1Vw4SYts83oZvgSR+UR8=;
        b=KNz+sP19rR/J1QPCoy92dk++7ImDyANr9pg1B+U6haVHH2QtXuC0SR2+ExDKA3SCHu
         VSj/azb+VYMlOi/bO2c3fqiKJ9XSHUvUYRFsvNjON9CvLk4j7tzcM9kvarV/z4VoakDg
         yltVoBq2qp4g1VY48Wipz1i8bmJPCSiIo7/F/RB7KVCmDEekDwzkBlmHr0ZzE8JZy683
         inFxaX9bqLhXnbVikHlr1E5N53mcgLGolzphRxyo2Nh1VXk8qZ+B7PsVL8OoWyxhI1Au
         5uqUy3A+V0pPWAlpu1CYnSLsBERNZPMeXnejh3vIY/SAMZJUa7jjr0jaNiuztKBcagoG
         4yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245945; x=1718850745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByPZqEdQZBBtzQ6Ut5Ro8SR1Vw4SYts83oZvgSR+UR8=;
        b=PBeD76lnxPiT8QiEGU77oFM+AysSRYVtOOJtVxSxzVU1QbmAMHGWyE1Ayqr9clIESX
         CZ2bA1jMVcMQDW4oieFVJ6MwbddFtHZuGXXj4ql1Snylb76Nz7QO0yCLW2M+hrxDjmA9
         JaCiWtgMCG2PwX8lnm47O92L/1lhNY9EBYQm7vBcDYrraq6Ge0gDgDfLRITOIMQtlelo
         Nhmfv5ZZ0+guZ3El0iqFsnIe2hpo9kk17kqKm6GHfOih+7ghTwbiFj0e/4ggndFvSjdM
         WcYzZyjUPQgv0Bx0vAF8viircENBdvn5nNb5z7UQ0vjFwuM7w+loMsJ+gc1eG3bFtIbP
         Xv0w==
X-Forwarded-Encrypted: i=1; AJvYcCXF11T/XjWHaHCZwDrMzO4Z9DFIusqpXbC8T3D0vP5/Y3FzQ9La+1p9Xmzqisxo3bHOUYtRWVur25gwdrXqv2cX2YONxP8+5g/jLnAp3FZwIZ4ci/frp9KzhqxqwAkKiXXeyt/8ZA89p1ep5trhViGK6lkWz9TkKHCXqXLh9DJJ8hsfc6xXjERXqpCTziXHFZjLpjzSSFlByQW7JaCgkA3a4nrcEuyahYM3YbKze4ESe2ENd+tn/hcb9ir2cPuACIMBDn5BgViXb9UMertILWKSeeg38Fj0azexPjd3uNlINDg7qK0St+1cFY1E/uJkGoALp3dOgQ==
X-Gm-Message-State: AOJu0YxGGxbzhhxH+g1cXH2+sMi6gri5mWQ/ZACw0/PdlBGl33bzRnxS
	8O4TBZEdtAJU7N071vumg5wq0PtUmW5UfT81KfdA+8xDJnUR8Sh2QAgSexPPjAU=
X-Google-Smtp-Source: AGHT+IE+I63Tcz7mU3dbe4p80REUOFhGXlU1vxQyrrx4b613sOPf+IM/heFPON96TqCsfc2pgVpt6g==
X-Received: by 2002:a05:6a20:840c:b0:1b6:c527:7e42 with SMTP id adf61e73a8af0-1b8a9b1eb09mr4050153637.3.1718245944827;
        Wed, 12 Jun 2024 19:32:24 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:32:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
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
Subject: [PATCH v2 10/10] drm: Replace strcpy() with __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:44 +0800
Message-Id: <20240613023044.45873-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
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


