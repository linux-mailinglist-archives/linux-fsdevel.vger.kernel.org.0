Return-Path: <linux-fsdevel+bounces-27500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7EE961CAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29976285123
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75EB14AD25;
	Wed, 28 Aug 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e81pcOe8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CC1332A1;
	Wed, 28 Aug 2024 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814285; cv=none; b=gttHFE7SjeWAZ9bwyuVy4YuBmdjcOMXkNZFxQCGBzsJnCnH4XOhAhY76wglzrrL5i77sr4FrWpqByJCaueNW+PajDQJPWnE5zkIqHla3TaAFTESZOpBw4XAmzhE2qjEBe0RUe2u6MyUi/ou0wXDpoifaGohmq5gA7AK1osNSalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814285; c=relaxed/simple;
	bh=iqRY1P34qqoNfGxtLuvfxUNzgKq34JOZhG+axK8tdYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3a99nFEzVdjc5n5gwq6oplLYyPEXwLrvJI+77i4njMPKaIV+FS1xNnG7neNcB4Rk5DCXconwRQ0fzUTgFMkVOuczcySUVgXK+u7gA+Lw/ChyKmWrNntdBS4HY0bpRIVeggv23Z5EM40Ps1Bqh2nIKrnR0hY0qFeG+T0f2U8i+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e81pcOe8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3e44b4613so4566704a91.3;
        Tue, 27 Aug 2024 20:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814283; x=1725419083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OBLeQ9F541pwxbn8dEubiWANdxJtGv9ekHxWl5Hwac=;
        b=e81pcOe8iwoPu+A0y/ykVmzG0XbGCoDPD3x1pK4ijYyA38MjqT5iPwWGRTo3gMouOq
         fORnaPq1otZXtBwWkq6Hl5NO+84dnKiddILYgBVsGXBY4EalgGUqZgR/ZseHbEUrJ+sW
         0UeGYOkLTOolfvWyKFTtJWF0KXvyN/pA2LOMU3MWc0WGl/Pif7uoAOhZLXC5mhOG97xv
         FXfCd8jf9xyTlhxinjyfDqJH4iRSnQ2YUT3w48Cu0LeiPyLMLpJ6UD3/Ws2i+XMUxZ1/
         /gZE3UV/fnsBmQBRrMKUAoVH26uISzrqxOOaSN7oPIzio093HFzDzG0dhUczUhiA1n/+
         g7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814283; x=1725419083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OBLeQ9F541pwxbn8dEubiWANdxJtGv9ekHxWl5Hwac=;
        b=hDv8YGuMVd3hIa16OeVDea+XUEnulFDjScHhfTN7+SQ0rRuXNf6yVxXAvZmfrkYs0Z
         1oIKGUUf5HyqU9Y8o5Q/AsBt6crDazMBTLnOljjV6K1fZYuooLWlLV9FW2BKl1AFNFXj
         UUfb0zrlQNSEjymlFyB5JhPmEKwMyq9haVRDt3xRL835YyoWvMjaRhulYbe/6fQ7imXP
         FBFIWf/iboK1lk8d2033BwAdKJJDO/zqC5Si632J4jTKCzZXNXrZJEbmYfAlU3FLmDhU
         NUpLT+BLe6btCQmcyuKclq6h9kbUQJ+bqq8h69uLb8JMH54nm7aUnyqwrqD4hzSES81i
         Cz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7RXAn3SnBWchTm7cn5EACoxvazW6Mqj080VvMqbhgiSDMt8T4AB13qM8lKjNLawF7ok2YKzkl9qC61VrjwQ==@vger.kernel.org, AJvYcCUDBo+MRnxSMM0hfY91EbCw3LBnVHv3pmsgOsqskFJ+M5i1tyPdeL06N/xBJFVIdDIboencYbas2w==@vger.kernel.org, AJvYcCUsg43SnC9LJHdmCikaBq7/Y2xDKt+mhIaLvx0+3TXyQhMBmIj2Dzhzh4K2Xu/xcQ91xrb2bQ==@vger.kernel.org, AJvYcCV7IeGckOCnWGu66drMWPaX6HZpP68TZq20DWo5WHVZgms+bYtrQm0ztOw12G3fgWIhOJ61FIwiSI/ufub1kO2GRN7b@vger.kernel.org, AJvYcCWBpfYGuGnH6MpDGW44zEVVIoZJe8zIF5/FbkocG3p3gNVQpRDcwg3gJtHPJ2+3z0eKFS9tjE67@vger.kernel.org, AJvYcCWz4aNoDo85wLpuY6ffxsyKkngAAl0YMzIw8jESsnMc1yyMTCjrDQ5v+mIydtykQKihoIKw@vger.kernel.org, AJvYcCXIkqS7k9zP01l+YsqGIS5eFOEG/Hzk7/dDbSX47YaRmXV3dyw5GaAcS/eIWyaZuHmnRlmM0xA2D7Q3gABPZSdOxhGP5Kha@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HGif0oSVAktneJr8j+554uz8Cw/5v+1VmErWHm5pSXcmBbkB
	uehyLe2fTHpFwGR+bL+0vSGteML7kLWDKNPtwRovks38N+3SmSGy
X-Google-Smtp-Source: AGHT+IG9WCG/sJqfIUmD5L1QkWASIgz28eaxuJrS0TfQtB7xTFo8bkGI6Rj777tc/95CgBuyWlEpcw==
X-Received: by 2002:a17:90b:390e:b0:2c8:e888:26a2 with SMTP id 98e67ed59e1d1-2d646bcd147mr17296354a91.13.1724814282792;
        Tue, 27 Aug 2024 20:04:42 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.04.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:04:42 -0700 (PDT)
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
Subject: [PATCH v8 8/8] drm: Replace strcpy() with strscpy()
Date: Wed, 28 Aug 2024 11:03:21 +0800
Message-Id: <20240828030321.20688-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240828030321.20688-1-laoar.shao@gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
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
index 96c6cafd5b9e..afa9dae39378 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1412,7 +1412,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
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


