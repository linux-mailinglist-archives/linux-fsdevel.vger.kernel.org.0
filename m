Return-Path: <linux-fsdevel+bounces-24947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CDF946D5A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59673B210B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE421345;
	Sun,  4 Aug 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYvdakcs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F01802E;
	Sun,  4 Aug 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758350; cv=none; b=Whp+8BLwB+qNn40GrPRPSxKcUJcnS46FMCTYd5e2kkhUr9E+EiEmfPv6u9FTo1q5Ap7neWnVLRRJO2QZPe8Wv/setcONOuJ/r2fuD/cELX9mTf52USxKVno8FC22DZn4ybgXZaL1VbZ6W+1ba0nStIvsIGW9WuDHgX5YQ+pYBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758350; c=relaxed/simple;
	bh=jrG/JeyScrX8i1Juroefr8qRWmAWEGD49Vd0gv0ZMbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CENF3EioKgD2uvbhjqU6c4gBMypCfhYIghbPvXKszQvZnrjSMN3J0zFwsD4YxxHBBcWM65K+c0E/2kn90Jnu11NXLKgSdoPaFNxuRLpnWrEM4GymSamHc9QxQfqrTFH2bt1rRIZV2mrHz4viD5hDWKD6VWegsNAVpxQsCTvx7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYvdakcs; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db130a872fso6647191b6e.2;
        Sun, 04 Aug 2024 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758348; x=1723363148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leoSzvc1irTIRY4t+RZAVg9wXL8E4KK0Ycetp1tzeI4=;
        b=LYvdakcsZEIuaiD8MjbCGaB+4s11FpfIaVfqLz+mh4ElP2jUGk9zYGClOT4ZIjic/E
         b/DVM9BoPdJOTYFIMztRCDkl0Flx5NzoLn86EqDx6zZeoKYoE1r1990zVHyJXIKr+uld
         SEYiJM08BhUdo5TJNAVhZTF64AyW5Nm8jFGH59fDjFkzkyThLVNemcvPE8ykpHGOmv1U
         zLcrZfD5SRQVOggr3+5sn/22pRb7MI6AX+hrtsVCukoIg6DxB86VEozT8aiNZZpB8TJ6
         VE+1m9Z/FSNDYbeIUGWGRM82ULedjYGzRRRaqJoVRh4G+ABP85Tj6TBOOlYVopHfxUAK
         0F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758348; x=1723363148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leoSzvc1irTIRY4t+RZAVg9wXL8E4KK0Ycetp1tzeI4=;
        b=FjsaQtR/Dy2jl2QkVf+5q2Eghe0dW3U60RP+wXCENTkz2cCFNR43bUVLCysfOccotX
         c5s6NjlzzPUMf9jxDA0hLPY8P89vU8+rfUGFwpvAs8d77NgfYR1LcKy8hApVYpqGOf02
         2dHybn+ECpG9ydLlWxXsrH+iQ+vuUklFHQ0LiJC3DwCmezqYsMeA1u7eX8kRidNCkOxD
         YvUF/155QHoB66AW7PMnTSOncgp/wOoREQ0KlLOhfwBSe0oqGZfkTBIcrtnBlpI2E/VX
         BK1Y1FOrNTtIJsAlESMc4m3zGGsTAqtyPu8n2IPnQYSg4d1n0sGQID0qSVgKwqy3DvUr
         GoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLU6xAd99k/iFZF4tl8jG3tBIeKDPzxewjqh57W5OzIIuz4MgVwrCNWDUR1VuF6nQVMpxbD6dhksnmpMo1tA1y72V7LZhmbCisTIXuESocPoqClB0TBSAgoMRWpNfgpnELolDeXjWVBpPTW9K4ZFxC+IPvj3yy1AwCJBn7MQPyIEWV3S9VdA70uSIjj+OlrpfON8bFLjKDoaywcIqGQJzJqaevhH/3SBcpCLAgSZaCUd0mi9hyJv33nQrUTrf4Hu7w1Uo6lpWis1d1hMThoR8uIY1xMMow2wzXhQKBBnjjNeDE5y5cn+2Ly8+mlv9NZUhGCmRgFw==
X-Gm-Message-State: AOJu0YzaiFvTDPizdQzbSp5eC1bjPm/jdI5t22ivJ8/Dyog9PJ799pdq
	As4sI6u5M8hT3G5ZQViu6HIG7g3EAUsdgSmaC66jnVYK5JmANpuy
X-Google-Smtp-Source: AGHT+IFvxFD9i5t49STUUYBZ5sy63mPUTCqzaYfVU1LOK5V4jv+UubPbJD8tYCgFeYVMewc026EG+Q==
X-Received: by 2002:a05:6808:10d5:b0:3db:25f6:a62f with SMTP id 5614622812f47-3db5580f909mr13121118b6e.28.1722758347849;
        Sun, 04 Aug 2024 00:59:07 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.58.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:59:07 -0700 (PDT)
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
Subject: [PATCH v5 9/9] drm: Replace strcpy() with __get_task_comm()
Date: Sun,  4 Aug 2024 15:56:19 +0800
Message-Id: <20240804075619.20804-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
References: <20240804075619.20804-1-laoar.shao@gmail.com>
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
index 96c6cafd5b9e..163457a6e484 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1412,7 +1412,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
 	rcu_read_lock();
 	task = pid_task(ctx->pid, PIDTYPE_PID);
 	if (task) {
-		strcpy(e->comm, task->comm);
+		__get_task_comm(e->comm, sizeof(e->comm), task);
 		e->pid = task->pid;
 	}
 	rcu_read_unlock();
-- 
2.34.1


