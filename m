Return-Path: <linux-fsdevel+bounces-22266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FD91557C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 19:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292991C21EE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5419F460;
	Mon, 24 Jun 2024 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXaaW3Za"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806D19E826
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250619; cv=none; b=aa1fuYLbanzZiUTY1lZrYaVvZO3m/JZekJlbRxppJW+eAa0dq3H6HVAmXttgbuc7WLKN0sokt5WeVq4CJnXuqCtHbGIsb1BQrYUvAdSD7Lok/Gp7i8T/E+WYLhtXkDycnKAB5khhrZcU1rqD4RVOxqYqD1ByDQRowyve9Ymg8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250619; c=relaxed/simple;
	bh=Z8RV4KLQH2j4iyUNWLyQmfx41L70bYNWwxtcqM9Iuh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgHvIPvenfmIYWEV8wnrTvvFocfP8D01thArBz9Kqi9srDrhN0Ploe2462EkbCexiirv+b5Bu4UFW65mV3x5o16W/kpJx69ktm9nPk9sdysmwkKnJoFqdTd08jlhKaEjF97fOd0QGwQGmxM3T/7CpmnksI3Fr1TD9QlNBzUQiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXaaW3Za; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa3086cf25so6755ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719250617; x=1719855417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDbuFFojQbQ1cWQ1Z1sjb6UPmriOMAqL2B/o7eafWKI=;
        b=lXaaW3Zag2wNv9ZUYybMaaZlIvW43ZzjLQvcgIzfC/zQC0TEc6HH6deDM4WDVvzf5E
         zI5wLgjOaCX+LRiTsqJ5++zd25Am+EjRrUJEEEbS9uvY/+Lad0+9JTzlfxoDd4lHIslN
         9wLCefw5S5/CVSSDINiW/bf22ehsCh+WUmr3g0XQA4ZceCUJdm8LqMmHf8Gs/1pfPtyZ
         z4uG7PgcNe9re+ZOj5kST1qI+4Ufm4wUQyQ5BLjn8w2Ieu583qr5hQoPpNbJzlpsShES
         Jal5cvXDHO3nd1rCWbmYsaaOxIuVkm1uu7R7qfRx9j1LSnLSei3blpgOeE9w/53kJewN
         oI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250617; x=1719855417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDbuFFojQbQ1cWQ1Z1sjb6UPmriOMAqL2B/o7eafWKI=;
        b=tgYAA+SB0HcGXQUlqwiRB4ZlhrZKeOJ5yNVDgvXm4+E5KNbRa4z9eshrUQpGtcPRDC
         XzljYF4Shx4AItiwCyKBZz4rtig9jjS9eIRerMNxmGUGc9dU123vW+59eP204VKu6vvK
         mZVkhXb+CT1BCNe5dNvd075tlnYcmmgB89nLdFMPjZrifeETMXCs2nzD8ZJBlttuZH2G
         L5qOFf3JK5VujeG/h4ZzrseVLns2a3RLevWpkIoeTpAQ0wFFndyWZNvgcBs4sk+F4/+y
         xaWXRj+Js2ZSV/25L8OhpvAyeGJxChsYoOaImHHppQlN1drQ/dp2DCEv5+lPuLMcIa6H
         ZX8w==
X-Forwarded-Encrypted: i=1; AJvYcCW04k3jstkOXIFHNzmmHGHd+SzLln8HqX/TfTODYxe7CS2QcJhL07w6IfH/AM1bimI6BbClX6mnYtD7Sr4jvoanTMPVktkTPHoigZCaQA==
X-Gm-Message-State: AOJu0YzHss6DCelxo4nQxsxrw+5MCkfRXLh+LJL9IIQcT+46Xtxn+woW
	g4pXmmyW6CwFBH2a0jJ5Hi+o5vv8uyETepWupb2ibEr1x2kbkIquLnSQ6MUMMA==
X-Google-Smtp-Source: AGHT+IEffgcc1CDKXfaru3DYqtwmxHxZRE1FVPe37ONAe/j62kFRSoU9UsTv9pVfgvp62t1U72/ubQ==
X-Received: by 2002:a17:902:bd47:b0:1f7:1c96:d2e8 with SMTP id d9443c01a7336-1fa68fb23efmr74105ad.10.1719250616920;
        Mon, 24 Jun 2024 10:36:56 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:e865:e9d2:536d:9a82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066ed4d7e7sm4223577b3a.9.2024.06.24.10.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:36:56 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:36:51 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: saravanak@google.com, Manish Varma <varmam@google.com>,
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <Znmus6VSijni-em4@google.com>
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Hello,

Just following up to see if there are comments or concerns with
this patch?

Thanks,
Isaac

