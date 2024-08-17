Return-Path: <linux-fsdevel+bounces-26168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35562955529
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EF8B22F4F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD1646;
	Sat, 17 Aug 2024 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2sXuh7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11C1119A;
	Sat, 17 Aug 2024 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863483; cv=none; b=ZYdBXLA7CYVxAuof8YR1U+hYovn5F/q71B+KnYAvPJe4hK4qsaa4ghaSjeb0AFzKa9PlJ4iW9l+JrcLRcnWqbS0U4k2imV69eAyVCabQ+eHpIZKkaD2eGchE0ZQbtN8yKqfbHyl2k7wFpuvjdHINuHIwbk6Uhevoa5PKqQT4HZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863483; c=relaxed/simple;
	bh=nYbscEvIPy0tfqXRvpq3fWIe2dCm3O45KAx2hY5jY7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C73bRweAdID/dGT1JgJFKUArk5XFM8qQIdTW/ZyHZa/lZ/jzBeuD5W+CmV7VaAGv2QJqIno6uoQOwQepz4kgkS1VLoHaisrsABbWpmcAXlF8b4xuMw3GATJeHKFCxDE1vSUr4TpmDWqfQlTv4V6ojhlWXnyQpH5Cl+6Qtudr/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2sXuh7Q; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-691c85525ebso24260017b3.0;
        Fri, 16 Aug 2024 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863481; x=1724468281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIeMfVPvNi2mFgQGi33u0WiVQIXgvCVnP/JNmg1PAVg=;
        b=H2sXuh7QC6pRONah8ItkAbnRM7IYiyQA0XAowOdn8Tx6zPFY+Iz7X+SD1nVB1i/IE/
         H2Qnp73U4aCrhO8j0a4h0ZNeV9UD2faSrpoGtqqEdcIExVi0iONQkFIkUJx8+A00hedd
         dtun6Reb4qoSA4xDykOyy1N8PMTq/KE6gw5I3Ad97ciC5bhezO8DvIS9fq3N508xATA1
         FJyMK57SAgr72feqNiKV9Sipw14bHfC/ReJi6rmD6U1PhONG/8BtgGUncDn/YrQZeJ5W
         VKHmxj/WW301ulTH1EGxjBbJ09yYuYhfSxRCNouqke3NgVHivsCnt4no+s4KvyaG0hfJ
         revw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863481; x=1724468281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIeMfVPvNi2mFgQGi33u0WiVQIXgvCVnP/JNmg1PAVg=;
        b=fogkPgNTB5vhpv8R1DbutJ8rlLOoIoGMAZJXBcfRJOfOe1Fl4QjIULCh72dTGwfhje
         yshDQRaLAGjeLFwGbbgZ93eYyukgOXTj9gmOuWn20EgT3yxlU8OBX4L9Q7z2eumdXpQP
         5rl+vgFE6P7IKUeN7k3wOSTlQCm0oD0M617rCHasHnBe8VrwuMNdtijVf4ilLTMAM0oZ
         yr+WRzjf+zEBb6m8h9hmPjJ+rbgnzIwVJbirCDLluHGg9CEE2U1eSjIGCj4MMNC6Ph0r
         834T5xflpIxYYf44sW1tbLovAsJMULNYGuGW17xYbDkTLJpTN6yWn8rMUdgCygA4fTRP
         zR+w==
X-Forwarded-Encrypted: i=1; AJvYcCVw9Nny1iuphVbx/5QWU4qK/dP++q+j219+gBvG21TovRaDQW/zIJZKWpoCwGf48LYJRCwkB6cSpW3NgqsNrE9ofR3VSKamKTML2uXrCigC2cDYiMVYRBh8Q2pQdCfm8HL80mChRsSd5srxW0zAAWf6mqSq18DYPLpn85X2YNoiEaLs9v8KLkMnmQAeRmYRId0/RC8lHagvff0cI4ClbTtHUbhKHhXeiKWgApmR17xfBVnTIBb15Om51qc9BhRSHH72tbZL0v8A4uW6NwmV4k9IL4o3gC3dY1yW6vO2vgF194BJyu2ux+voTYHk0GjYlnwkHDQ3bw==
X-Gm-Message-State: AOJu0YywP5zavDycJ6nbfg6zZrAQZiF/Tlb0luC0S9CXnqVJwbARDcTw
	CTtbmxWgHXuy4G/bYsA05APEJvMaMjF4il5jwaNeMORG6mDY89U0
X-Google-Smtp-Source: AGHT+IHIEqe/Cmg7s9PimPuB+lj47WHhB9AJi/MthWBlVJ6PrU4Dd47Rx7cTZURpMhIAboN0X1uK+w==
X-Received: by 2002:a05:690c:f01:b0:62f:f535:f38 with SMTP id 00721157ae682-6b1b9a64059mr67878767b3.8.1723863481074;
        Fri, 16 Aug 2024 19:58:01 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.57.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:58:00 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
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
Subject: [PATCH v7 8/8] drm: Replace strcpy() with strscpy()
Date: Sat, 17 Aug 2024 10:56:24 +0800
Message-Id: <20240817025624.13157-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240817025624.13157-1-laoar.shao@gmail.com>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent erros from occurring when the src string is longer than the
dst string in strcpy(), we should use strscpy() instead. This
approach also facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
---
 drivers/gpu/drm/drm_framebuffer.c     | 2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index 625b3c024540..374378ac7c85 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1411,7 +1411,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
 	rcu_read_lock();
 	task = pid_task(ctx->pid, PIDTYPE_PID);
 	if (task) {
-		strcpy(e->comm, task->comm);
+		strscpy(e->comm, task->comm);
 		e->pid = task->pid;
 	}
 	rcu_read_unlock();
-- 
2.43.5


