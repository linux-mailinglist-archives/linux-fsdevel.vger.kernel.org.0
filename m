Return-Path: <linux-fsdevel+bounces-22422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DB916FA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264521F22C79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AFF17837E;
	Tue, 25 Jun 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPLviv+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF941448E0;
	Tue, 25 Jun 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338339; cv=none; b=NE0cE5UxBI9FMoyjRgOKML5Ko65uhXUMfDCM2WbiG5fhYePcx2RSCVMgQJxR8Y5B/0sP0aqa3RyXS70LkQD9Nn+VmrjpmJWEKlsPNuFe0p1XbVWbExc8+7Pe05m1GBQUJCqAsGx2+SRpxKOGZ9Al9ctQJ/F/+y4aoOAhKZAQmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338339; c=relaxed/simple;
	bh=dURwKATDLlehAHPXMuSR4pXYybdAuMDYGKElo4TfZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2hG5U+kVD+O/zHmK8aLWET6OJcn9O4jnFVtwWYDfkvsJ5yGo5s5uX4dQ6qJj9AZsTq+Nyq04Qo5hFtC5TK0r6e+9zGYNgmmUFYqKSEsA1Opn3B6YNPG+AevM5espl64Yu0U49k0Rw5Tf7yqSL05utLfvWOxui3pEIF4eUjNYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPLviv+o; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso10008491a12.1;
        Tue, 25 Jun 2024 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719338335; x=1719943135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/hUof0FwZxWaFMFdvkdkBcaExaL8TwdsNEmc0Yg5VU=;
        b=CPLviv+o3w2z/812PbcIPCc2bAOgevhqi4seWV2XBnE/lfvTTg1Dz3kMgQwI5TiBQc
         73RnYXIWYLkphZ1uW9Bfi4rhXfjES3twXFw4jEmdwEwNnB0KxpKp+0hA3CXgpqSAzNYM
         8AANSe11d6+rUtPe8OlnUN4YPxpcMkN11m4QC4er/U+X3oLpWahMFwa/JeHj9P8Ehs6I
         f9XnsNqFAWdkYrUZ0PqLfoJNv7XfkBAp3pBGjyn28l5bfVan5+z7uvIVFokj9UMSe8Um
         GGOFFIqDCg1zd7GMbFCmZC32CjOwlzseIaszOrr/EllyNxAPSCiV5pXs4Bo4X/MJFj8Y
         cOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719338335; x=1719943135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/hUof0FwZxWaFMFdvkdkBcaExaL8TwdsNEmc0Yg5VU=;
        b=GnZTTKVFODxieH3eDg1SVE+MVzAq92DSUc2epbeqtO7twAmbyuH68vIEIhYhpK2OUk
         Nu0vwT77dx1RAxv383HGaLHt1Lr3DSt2/GCtSHKFeSlhKOX9xEz69Ys/DH1ddzYw2Frx
         SN0lvx638ZA7HxtAPt4dKaz2FdXqHh3Ndvd7KVaRgLdAOlB/sY7YDyiLbGZqCIBfomBT
         nn2EyvOaeI87MHU9nCNZrTuGy/nIZ1783ehe6MOxCNfKbrc7UnH4VMnJUkXeNCtES3z8
         PXzKKu6yF5VlF4zfOUtZV7IKlP9uuq7/hoOIFJZsKFiB6Fo3yKsX8AhHVB8chxf9MAxr
         vjgw==
X-Forwarded-Encrypted: i=1; AJvYcCUJE+7+6qFyoaqQxh00fmMK8o0KY6c2mlEpebpCb6urkiE1oBbQBf7hzbgeeusRhMbPO1KFkwGWQft7JIru7xitowIlgWMeNWeiquPWVz9kzrJSttCmjBBTy3+aTB0TokmDXAg1MnJLW3D1ItopKU9HfmgDlVmMAIy4iW3J9XvrsnLSuEqY
X-Gm-Message-State: AOJu0Yw2iD0E7VVId085N40IPIm7r/EpcqVwcmwqMR/A+lzLAk+xcn3J
	k0lMBv+VlsemrgGybFtsDzGLF+10yWLQw8FBfapAWZM+NfNzzedi
X-Google-Smtp-Source: AGHT+IEAi1M0VgoPz+C0QjKaJyFdLmOIwZYOyn3re+rQ+6zP9uHd4uQ4Accd1s2F0IX3pMEUHIeSlQ==
X-Received: by 2002:a17:906:7250:b0:a6f:935b:8777 with SMTP id a640c23a62f3a-a700e707009mr812238966b.25.1719338335215;
        Tue, 25 Jun 2024 10:58:55 -0700 (PDT)
Received: from f (cst-prg-81-171.cust.vodafone.cz. [46.135.81.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe81449a4sm401557166b.72.2024.06.25.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:58:54 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:58:43 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, saravanak@google.com, 
	Manish Varma <varmam@google.com>, Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <4x5wsktkcwt7einzjowricl27pzusx6ggls43zionql7ixi5cz@icbegmuqqxcl>
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606172813.2755930-1-isaacmanjarres@google.com>

On Thu, Jun 06, 2024 at 10:28:11AM -0700, Isaac J. Manjarres wrote:
> From: Manish Varma <varmam@google.com>
> 
> timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> it names them after the underlying file descriptor, and since all
> timerfd file descriptors are named "[timerfd]" (which saves memory on
> systems like desktops with potentially many timerfd instances), all
> wakesources created as a result of using the eventpoll-on-timerfd idiom
> are called... "[timerfd]".
> 
> However, it becomes impossible to tell which "[timerfd]" wakesource is
> affliated with which process and hence troubleshooting is difficult.
> 
> This change addresses this problem by changing the way eventpoll
> wakesources are named:
> 
> 1) the top-level per-process eventpoll wakesource is now named
> "epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
> and P is the PID of the creating process.
> 2) individual per-underlying-file descriptor eventpoll wakesources are
> now named "epollitemN:P.F", where N is a unique ID token and P is PID
> of the creating process and F is the name of the underlying file
> descriptor.
> 
> Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
> Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
> Signed-off-by: Manish Varma <varmam@google.com>
> Co-developed-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  drivers/base/power/wakeup.c | 12 +++++++++---
>  fs/eventpoll.c              | 11 +++++++++--
>  include/linux/pm_wakeup.h   |  8 ++++----
>  3 files changed, 22 insertions(+), 9 deletions(-)
> 
>  v1 -> v2:
>  - Renamed instance count to wakesource_create_id to better describe
>    its purpose.
>  - Changed the wakeup source naming convention for wakeup sources
>    created by eventpoll to avoid changing the timerfd names.
>  - Used the PID of the process instead of the process name for the
>    sake of uniqueness when creating wakeup sources.
> 
> v2 -> v3:
>  - Changed wakeup_source_register() to take in a format string
>    and arguments to avoid duplicating code to construct wakeup
>    source names.
>  - Moved the definition of wakesource_create_id so that it is
>    always defined to fix an compilation error.
> 
> v3 -> v4:
>  - Changed the naming convention for the top-level epoll wakeup
>    sources to include an ID for uniqueness. This is needed in
>    cases where a process is using two epoll fds.
>  - Edited commit log to reflect new changes and add new tags.
> 
> v4 -> v5:
>  - Added the format attribute to the wakeup_source_register()
>    function to address a warning from the kernel test robot:
>    https://lore.kernel.org/all/202406050504.UvdlPAQ0-lkp@intel.com/
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 752b417e8129..04a808607b62 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -209,13 +209,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
>  /**
>   * wakeup_source_register - Create wakeup source and add it to the list.
>   * @dev: Device this wakeup source is associated with (or NULL if virtual).
> - * @name: Name of the wakeup source to register.
> + * @fmt: format string for the wakeup source name
>   */
> -struct wakeup_source *wakeup_source_register(struct device *dev,
> -					     const char *name)
> +__printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
> +							    const char *fmt, ...)
>  {
>  	struct wakeup_source *ws;
>  	int ret;
> +	char name[128];
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vsnprintf(name, sizeof(name), fmt, args);
> +	va_end(args);
>  
>  	ws = wakeup_source_create(name);
>  	if (ws) {
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index f53ca4f7fced..941df15208a4 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -338,6 +338,7 @@ static void __init epoll_sysctls_init(void)
>  #define epoll_sysctls_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
> +static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
>  static const struct file_operations eventpoll_fops;
>  
>  static inline int is_file_epoll(struct file *f)
> @@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epitem *epi)
>  {
>  	struct name_snapshot n;
>  	struct wakeup_source *ws;
> +	pid_t task_pid;
> +	int id;
> +
> +	task_pid = task_pid_nr(current);
>  
>  	if (!epi->ep->ws) {
> -		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
> +		id = atomic_inc_return(&wakesource_create_id);
> +		epi->ep->ws = wakeup_source_register(NULL, "epoll:%d:%d", id, task_pid);

How often does this execute? Is it at most once per task lifespan?

The var probably wants to be annotated with ____cacheline_aligned_in_smp
so that it does not accidentally mess with other stuff.

I am assuming there is no constant traffic on it.

>  		if (!epi->ep->ws)
>  			return -ENOMEM;
>  	}
>  
> +	id = atomic_inc_return(&wakesource_create_id);
>  	take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
> -	ws = wakeup_source_register(NULL, n.name.name);
> +	ws = wakeup_source_register(NULL, "epollitem%d:%d.%s", id, task_pid, n.name.name);
>  	release_dentry_name_snapshot(&n);
>  
>  	if (!ws)
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 76cd1f9f1365..1fb6dca981c2 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -99,8 +99,8 @@ extern struct wakeup_source *wakeup_source_create(const char *name);
>  extern void wakeup_source_destroy(struct wakeup_source *ws);
>  extern void wakeup_source_add(struct wakeup_source *ws);
>  extern void wakeup_source_remove(struct wakeup_source *ws);
> -extern struct wakeup_source *wakeup_source_register(struct device *dev,
> -						    const char *name);
> +extern __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
> +								   const char *fmt, ...);
>  extern void wakeup_source_unregister(struct wakeup_source *ws);
>  extern int wakeup_sources_read_lock(void);
>  extern void wakeup_sources_read_unlock(int idx);
> @@ -140,8 +140,8 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
>  
>  static inline void wakeup_source_remove(struct wakeup_source *ws) {}
>  
> -static inline struct wakeup_source *wakeup_source_register(struct device *dev,
> -							   const char *name)
> +static inline __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
> +									  const char *fmt, ...)
>  {
>  	return NULL;
>  }
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 

