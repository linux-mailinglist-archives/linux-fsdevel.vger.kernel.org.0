Return-Path: <linux-fsdevel+bounces-24400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE693EBAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725081F21167
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC5081ACA;
	Mon, 29 Jul 2024 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9lsDSIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4480633;
	Mon, 29 Jul 2024 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221295; cv=none; b=hh5ICYjqkfv7BXPzQYDkhRPRgM/oFAnR1sEp2b7LNtOGEdODYnOISnRrwEdzQlAFc2MqhCEKfSp8/0HZka/u2uZBFz2EEnvZhzCZbd3G463ArnZQ4szv5asunCZvqpXkn5rf1aRhzGBZa6/w+v+eAdJDatHhBW2oMqfgF7C9ybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221295; c=relaxed/simple;
	bh=KFR6O5apdaE005aia/eSIy/aDnoPWMXgYn13tfLkB8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NidKtHo6gsMpXLzeBZjBLcPU5m9ujV5N5PHO6oKqkPhB6Fo+Xwz2UQd97avGmCAP2faOOEcmMqK6SB3x1fPPChVZmGBjn+Pdn3cjKULJlpyEMeOcnd3PA4LU+KB4hBC0RzQGhYXjWiI9enRVRFpfiq6+wLSSq98tSVI3V6e1WNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9lsDSIt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso2146126a91.0;
        Sun, 28 Jul 2024 19:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722221294; x=1722826094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uws88M38Us6mZwthahlWUK7fM6+CMa7f0lHdNpc5/ec=;
        b=B9lsDSIt3kPWhwb1rmbg7ZOkxPXGtOIGQSSGs1KNQlCHQPIjBdi9qxOxi533gdKPeU
         oK3p0XEHR7r8JJNx/mFPvMH26c1HX7LuRq6ZiaW54ONHbf0J54TK+4rKbzf227xsjWOi
         o/DlEOR1hyKBO+B94cXPKCzmnMreOBr6gJ+cQI6MRHwBcB1YLak4Vq7IhXOaVZOteFiP
         svMS2geFmg4wJcjlZ/QNGeIu9rARXfrYqjjJHink3MMzqOnjRJfJLt9mlzJKxvfVO/hP
         FlS6Uzxx/8zGdhMQIq+nRdPOoxUVZvfnlt1mwolgn0QI2kgChxML6ka9c/eQqI3wfG8Z
         1DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722221294; x=1722826094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uws88M38Us6mZwthahlWUK7fM6+CMa7f0lHdNpc5/ec=;
        b=ZwbChy4sV//p3zAHNDAeL98jBTsRi3YHY4It4NjpEUZBKPsqhHrDH/++Sd2A9c7mOJ
         dPk8/0RysG6za2ylXLoySMYLUJA8kUp0r0ysEzd+Xlv/jDv1SODzRWgDmKR5Srwr+Q1E
         hSW7poC3ZIQjXlpq/X+kdjbuO0JMHiq1dOCf/SVJnxjm/yVAkPwqfM8MtSEUMD8uksvZ
         Vx0w9le+4GSLcxMxtMJUqeUMiE966WSFzD4IEBy8iVGpBJR0YGFHWMbWazssGgA4JJmp
         BXRG9d+p7tvIjiM05ChH46gIh8/FGW7/bix96n6iziChUqZhyLy5GLPJ6+giXPu4Vp/J
         jk4A==
X-Forwarded-Encrypted: i=1; AJvYcCWY/BzFN4gMaxXa+/EjxIxb1y0aMk76mDb3BIwu7p/95UTWqCyi/PjiYzzhdjju7suoubMHdidvO3CczTPw7/8V/dmLblrQBx+ZtbuihRg1uH7/GB4ZrdgIhMUHstqUSl2J5ycqENJVaznk03+xmr+MEtb4uK5Bmc6xMK3OFFfWf7nxnZ9KVYZ5GpGcaOZdxhCjo9qpYCbufOXeEtTPcz6HaAsIkdKQcGJFJOLV2nxfcL4u90KTNhUgNQOJdCnHiPpAXzmxWaR1L6oiYuvV0tB0IuEcFB588epAsOD1lgikAkYPh46YemJMA6Lpp5yk+VUGi27mug==
X-Gm-Message-State: AOJu0YzWEwkOBho51D5p5Ce0hWustFYoKMZhzv3ftu6SlarGmBJu/ths
	6kvTbUYXz/2RvWAtQrTi2jq3qGr+xy4EMVr5ie473OYZizsH7BI5
X-Google-Smtp-Source: AGHT+IGofcCeds74VK5yzpBY91R2MnaRyI1ieEFwQ1nBe/Bs8+j0QLJHRaMLwHU9stQw4nuIemwGyw==
X-Received: by 2002:a17:90a:888:b0:2cb:55f9:b7c5 with SMTP id 98e67ed59e1d1-2cf7e1df02dmr7584677a91.12.1722221293603;
        Sun, 28 Jul 2024 19:48:13 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.47.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:48:13 -0700 (PDT)
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
Subject: [PATCH v4 11/11] drm: Replace strcpy() with __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:19 +0800
Message-Id: <20240729023719.1933-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
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
2.43.5


