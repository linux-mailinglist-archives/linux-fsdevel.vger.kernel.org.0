Return-Path: <linux-fsdevel+bounces-22756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97191BB0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562D92862DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55C152798;
	Fri, 28 Jun 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXPZhHWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616914E2E3;
	Fri, 28 Jun 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565598; cv=none; b=S4Vpm5hZQGboXCkSmbF1OG+DqlmybGP3f8Knf4DNlCT0XbA8YgnNj9LNs+fYzGlAm36smi2tJ2dSYfK0nL95ICExdZuKDU5aj1BLwsMyIgC+8oGYhgTcKEaQxU+kO92GmatbAb4bbUxDUcQInQpWa96UAFRVlWvt5sqbYa02EPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565598; c=relaxed/simple;
	bh=KFR6O5apdaE005aia/eSIy/aDnoPWMXgYn13tfLkB8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKRfcSsidmOIy6o9QYj676pssnQcSPNpF+5xmJwnzFXvVN+YMaqyW0kLXLczpjC9cC8N7nLiRyE6yeK9NZX79A68wRJ2iZL0UW4T4AM1fqgqFtcOVnAxSgWtMLWONuraGXsdgszA4M+Q/t/T+C62eOfOJgEmfBY9o63CWtaHCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXPZhHWP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1faad409ca7so10102195ad.1;
        Fri, 28 Jun 2024 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565596; x=1720170396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uws88M38Us6mZwthahlWUK7fM6+CMa7f0lHdNpc5/ec=;
        b=XXPZhHWP5QwN57uWYOpdmk6Gaux3myKKOf3nc9dvHIPRKclvO1+9Bv6SRs4YWb7fXo
         99EJL8IXsa2NhD6TX9su8uf2+VXgFECijWlmsYBqEkQC3V4qk7sBRah3P9K0lQoY08qR
         FRMkgJn677sRYGlrGnajHFdUnES0aNh7IShdXt+EBd4d0AwJD5dWIzi8spLy7SHjZPPz
         lhSQpPjRJhRh2XdMNQ/ZOfUt4MQ0JdHtyreGG9HPT3aPYcg+sakQ0VUlPj3twOvSiPKb
         H+rhtadKLFnNIPb/r34KiYaHYtwn0ErFhTd8mAQ4vOZUnL43BJ9s79G3bQ6hKgtbK6dV
         OZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565596; x=1720170396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uws88M38Us6mZwthahlWUK7fM6+CMa7f0lHdNpc5/ec=;
        b=U70QX8udI8MELd5FeBLkaMmLRTUDQwJ+HGSVw2w3rOVeL4gxykvXAG636bi6XK/ipy
         Uz5iyzCRcllVrDNRVtBQEXfhBLeauvOnyl5SQKf6LCXK+z84MH6KH8yz6tiL5zZPuQ+W
         vUKO1HiLe6ODqTrsYY2cLpdUmFryN+iTOKqHa+QU/h4QNA+MU5GVlsg+aRdBO4WVl/XR
         GduIoGC0Cnn3owemaG36ZRFLDu/Lbcb8r1KWertNPtbdR2TDQcb2IF2DH5LZukJqNR4e
         0l7zdJuj/p61WztsnkYijsXdrTz6x9tldcTiSpBljfut1FTPdY9VqL/uOCihrJujhWS0
         7k4w==
X-Forwarded-Encrypted: i=1; AJvYcCV1GP4aohZ1kgG3orBrbhNMaf6kI3Cx4ta4OQT20zzEXOk40ls63sluWp1QE0mm4VHCbnWuuByiiHmsSxSW7kTP/GwzpaLPmWzFLluOYxsW6XgtnGsAFf+cGPsSP7G79VE5eB5x0+AI4mQJHD51cfgWteCOw1n2m4NzN2ruqdC23WcqHok4hMvYdihEMFnKSYMo7lP2CHrWQ8bU5XuquYi6mGNMZSDTXKgI8vC0+0Uz2RtCctXOhxM4eC/WnmsSg849BVYoVLhggiea6YOcnQnx9BsPGmuoArKSnQBMoIBFswo1BBWO+NNUNnmUNvqgdN5s/q+7+g==
X-Gm-Message-State: AOJu0YyujdauGEAtCS0+BhclUwfeWFn0NvbDEs6EV7KY3SXwmWSpyL29
	deWd3CozyCvRoYLBFZHiha0cGmHJNWl7wL9LtyMN2/yXZezq6+wObRpE8D1kBLg=
X-Google-Smtp-Source: AGHT+IFavdIVLnysCQZL38ewD7/CaBekji3/EpakpMEZSkmUhyVQ9iiqTWsp/YgBhmvk5fMqdYz2hg==
X-Received: by 2002:a17:903:244a:b0:1f9:e3fa:d932 with SMTP id d9443c01a7336-1fac7e975ffmr17035345ad.9.1719565596545;
        Fri, 28 Jun 2024 02:06:36 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.06.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:06:36 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Subject: [PATCH v4 11/11] drm: Replace strcpy() with __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:17 +0800
Message-Id: <20240628090517.17994-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
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


