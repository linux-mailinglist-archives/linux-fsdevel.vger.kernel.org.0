Return-Path: <linux-fsdevel+bounces-25623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7C194E50B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1D3280C30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691DC14E2D4;
	Mon, 12 Aug 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMf+uBW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60445130495;
	Mon, 12 Aug 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429896; cv=none; b=apZYoQEn3MAuMhHc4DMM/0cHlkLbRR+yDriCX6IvIK0sCpljxCcZ+zbrRwVeIgs6Dk8ITfbHHSqJ/CPaQ30TkA4z5/6h/m/1m1f5rQHr+KON85kc66BgoAHYo6RPsbU9uZj2OwudtWVs6O2B6pke0vyZbUNLCRg2+G4KB+BZSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429896; c=relaxed/simple;
	bh=jPqIfx5S0Qm/nWYbQ6kouB0I6PeJnKoCsF8vfwSHWTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8/tFK3R8ZZoxPUTp4W/yYp2IL4hHqH3rZUG0njtrWNeWhWjsy380jI0Mulj2xd04Z60X1zV/e7DhmhYaodf8fgF2fvi/p79I+YYnRapRexTFWHeJiQoHZxInhjkZ5KfE6LnsNqZFqeKTTU2WplqrTlYhrbaengWwpI1T7Duzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMf+uBW4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so2473385a12.1;
        Sun, 11 Aug 2024 19:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429895; x=1724034695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZu3KZG3iOINXwUvnWcZKbey2aLH0BWohtl6uQ29mP4=;
        b=RMf+uBW4sxFLUX3cCivR3zxx3+1yfKOe8+fM959PJO8tvrt7gNLao9QJfguSbAqcI5
         yNsRW/IQN6LLwSelbbg9jzI5k9ticQxNPuPN0UqC5YxnUeWlT6KUJP4fdMW08ILVeSsZ
         ws7Fc+JD5BW2aiV2NlGnTuUMPfLIncdd7YSFvhxGAB7x3x2OwQsOV4niS41JKFLgvC/U
         BRJ2cHnv/DX7TGro2w7f3TaXjNlRxHqIiLX14x5ogqoGA1yyW4PTtTOgmRTUaB63Vrqq
         6yxxKp1VGS5A0n0Kx/iK/3uOdOhy09Q+nO4chgguTokpVRioqd4cSVurT5YosoAZvObK
         475g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429895; x=1724034695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZu3KZG3iOINXwUvnWcZKbey2aLH0BWohtl6uQ29mP4=;
        b=FfEs/nmh2WS4OuXPUmTpgMlUZEVEvxjKOIGuc+bcbfhE8aa6AH+A2cpoFzLALe+HTO
         hAiGbKfyyhUNpdJ+InylZATxphT9plFDGmsDp/Dm5/qRCtoF6d+ocj1Jw+StOBLvlrdW
         xxglr19iIdn8vtiKZ62pbW4SwkWPbh/ynImSc4eV9v6lPdqOh8niqSX9/h6TlVt55W2z
         1OSnkgwE/i613LEd5DzCiLxMFiTiepinigEmy5RaQioJR5aAiDFwvpfik5Txo9z1mW0j
         NastlsQIFKTGwyNhh7avL7YLpymzuE5wGPdOnYaHCqD/8tIqjTvZCxUKlNresFcmBxav
         E4AA==
X-Forwarded-Encrypted: i=1; AJvYcCW1VrkdGCs5o9Khy6/twURfh/c13Xcx8HFvPjbYP4HJ1ABb64b/MHGVxkp9jvxoUgnjN0gzq0u0idBTwMj+2pdz7x01QYApwcGoO+MBULPsK4djkv5fOgj4f5zAjardzQ1/VS5MTs+TZb0WJ1XH/bcEUrQ4apofrVG/kFN334QqvbYTDSmlVotP/YMRGkI0trXa+bM4vhcZbmcdHn29CxzpNFxbV6TlQuzRthwsjaTkHAfSsPpCR+4sWV7ySbqRJXcmZAffYLwrUSt5V9RdkLJeeoL5GKkkvPt5dzZsAD8dJrenQQwFygOZuqngf1xRAxBNOpj3jQ==
X-Gm-Message-State: AOJu0Yzx/mD1uDSjswVpgxOaumRS32vNat8kKlXMajeZcxR6uE92cC80
	I8l9r4Tly4m8YWjRK8xQYjuE27ySuT1dYrBMw+lYH4L6uAy+znOx
X-Google-Smtp-Source: AGHT+IHdX1dJ6B1gxMt4DoIS5gsxO+K0m5bSRRhjzARSl7z6wL1zfkA/bgMgo4cA342XfY8E/QA2Rw==
X-Received: by 2002:a05:6a21:b85:b0:1c6:fc56:744 with SMTP id adf61e73a8af0-1c89fd26229mr6526380637.31.1723429894568;
        Sun, 11 Aug 2024 19:31:34 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:31:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
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
Subject: [PATCH v6 9/9] drm: Replace strcpy() with strscpy()
Date: Mon, 12 Aug 2024 10:29:33 +0800
Message-Id: <20240812022933.69850-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
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
index 888aadb6a4ac..71bf8997eddf 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -868,7 +868,7 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
 	INIT_LIST_HEAD(&fb->filp_head);
 
 	fb->funcs = funcs;
-	strcpy(fb->comm, current->comm);
+	strscpy(fb->comm, current->comm, sizeof(fb->comm));
 
 	ret = __drm_mode_object_add(dev, &fb->base, DRM_MODE_OBJECT_FB,
 				    false, drm_framebuffer_free);
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 625b3c024540..97424a53bf9e 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1411,7 +1411,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
 	rcu_read_lock();
 	task = pid_task(ctx->pid, PIDTYPE_PID);
 	if (task) {
-		strcpy(e->comm, task->comm);
+		strscpy(e->comm, task->comm, sizeof(e->comm));
 		e->pid = task->pid;
 	}
 	rcu_read_unlock();
-- 
2.43.5


