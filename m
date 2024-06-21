Return-Path: <linux-fsdevel+bounces-22125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B6912B83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 18:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2564428AC3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8D1607B4;
	Fri, 21 Jun 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VtXeSSY9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7D5D477
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987972; cv=none; b=p+DmxYPUs9KJQJAUa8Cora7OfPNjDeG+2bzZb7XKpoU+zVj+dLo5Fs/Me1GM4LUbUzRW7zJ+DSeuoagOsNY8QeOyboseMhg+no9F2X6tPza+3BsI/tG/Edds0CUN0rvnaB1o5CUAZdxaYocWt4nQjjiOAxri3gYNki00jCJn2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987972; c=relaxed/simple;
	bh=UlgFUywd2WSEjSU6xsxYFHFG7CT7Xep9ROempUMO7/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6tI1ZnQPoodqL34jSzyreYQmkGGvyciJdsZ7kg5PStLE62dVfwp3rLT5kxFTZf2XEX6/cUVhTTwndabgAx3Ux4XoiqpGZf/s0cwQ12Q514KaThb60oCmYl2s/09S1wEbflmFksXuHNZ2ZjgQoPKqit9XktDH6jwndM8yA/DFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VtXeSSY9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebd6ae2f56so2920641fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718987969; x=1719592769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+B4q6j7rnOa8lY5YGMu4l7DUBInPDPw5kUdlNxco7g=;
        b=VtXeSSY9ptdv08DJDTJ2WKmFOBfvm36uqqpB1SXvyXSjnyBwyR/YSRClM3Fekc5PEb
         dd8gQNWD9nZJ9TDZN2xK7sOY6Ng+93H+bPR3vwYwyztHQIRZ7VsPi0IMubPX9azpw0gj
         56RGX+N8Cg63P3IsX1jP8xeP/0Sw8vR5VG9e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718987969; x=1719592769;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+B4q6j7rnOa8lY5YGMu4l7DUBInPDPw5kUdlNxco7g=;
        b=wzxNAtUYMpTc/EtdrHyLwzu8zim8aj6KyB03Tq6LKOdkp5MJMjnKN7YAP4xi6xCCS6
         02sHNFNIYizcIOun9rMUQJcb5wRfhF55TP50HrLwGRQsLNL61LACCp2DZ9dgL8qVHFLc
         HGk2EGjYMlMqo6eVJEeWCN9a+9+YumaK6Xyf4oLvT2OZeVoO4jLr5286no7NkjYOjVQb
         vH0ptOqyaxzFu0bi8y5Mk96pbbjkAva0DmOMOrCmdWlxahFulESuDrt4YpkR8AYlYXjP
         aDi5Wm8F509clQt5KIxQpHzS1BVqxJhll4y2ZrlRCuWvq1FHwdDscvlo3tBsATgpzeVp
         Vvaw==
X-Forwarded-Encrypted: i=1; AJvYcCUqRKI1JUChmBEefScmXjkbKTmSVh2XwrliDn8QItJ8quKWKiwpUt76SXXLbCXJunAk/45SB94kizBpZqXnoOczzfaxlyXeLpDs3HbKHg==
X-Gm-Message-State: AOJu0YxRKLVd2dJzf6FhLoz/g2FCmHi2CmuN5ikotQtuvAap0KYmuOPB
	sekXokJsK+21p9mdbtsX3ZamjgFBdnpCOvh1v9YdUxRTUJNphmtFKRBRNK4E+ig=
X-Google-Smtp-Source: AGHT+IG0ddJjXBlSpbVZD4r9/H9u00KEsN82L79oP/i1sXbnFlr8kZL72WUFKn7R6WiFRcw1OhTvRw==
X-Received: by 2002:a05:651c:1a12:b0:2ec:5365:34d3 with SMTP id 38308e7fff4ca-2ec53653746mr3909701fa.1.1718987968916;
        Fri, 21 Jun 2024 09:39:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8960sm2247234f8f.100.2024.06.21.09.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 09:39:28 -0700 (PDT)
Date: Fri, 21 Jun 2024 18:39:26 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
	alexei.starovoitov@gmail.com, rostedt@goodmis.org,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 11/11] drm: Replace strcpy() with __get_task_comm()
Message-ID: <ZnWsvvRUonTmZG5h@phenom.ffwll.local>
Mail-Followup-To: Yafang Shao <laoar.shao@gmail.com>,
	torvalds@linux-foundation.org, ebiederm@xmission.com,
	alexei.starovoitov@gmail.com, rostedt@goodmis.org,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
 <20240621022959.9124-12-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621022959.9124-12-laoar.shao@gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Fri, Jun 21, 2024 at 10:29:59AM +0800, Yafang Shao wrote:
> To prevent erros from occurring when the src string is longer than the
> dst string in strcpy(), we should use __get_task_comm() instead. This
> approach also facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>

I guess the entire series will go in through a dedicated pull or some
other tree, so

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

for merging through whatever non-drm tree makes most sense for this.

Cheers, Sima

> ---
>  drivers/gpu/drm/drm_framebuffer.c     | 2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 888aadb6a4ac..25262b07ffaf 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -868,7 +868,7 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
>  	INIT_LIST_HEAD(&fb->filp_head);
>  
>  	fb->funcs = funcs;
> -	strcpy(fb->comm, current->comm);
> +	__get_task_comm(fb->comm, sizeof(fb->comm), current);
>  
>  	ret = __drm_mode_object_add(dev, &fb->base, DRM_MODE_OBJECT_FB,
>  				    false, drm_framebuffer_free);
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> index 625b3c024540..b2c16a53bd24 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -1411,7 +1411,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
>  	rcu_read_lock();
>  	task = pid_task(ctx->pid, PIDTYPE_PID);
>  	if (task) {
> -		strcpy(e->comm, task->comm);
> +		__get_task_comm(e->comm, sizeof(e->comm), task);
>  		e->pid = task->pid;
>  	}
>  	rcu_read_unlock();
> -- 
> 2.39.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

