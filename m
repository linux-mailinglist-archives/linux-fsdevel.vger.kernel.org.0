Return-Path: <linux-fsdevel+bounces-16497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FFD89E4F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6BDB21079
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB936158A28;
	Tue,  9 Apr 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GkNdKHWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2399158A00
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698142; cv=none; b=ha0mc+v9qJKexT1G5nOwwDMAxhlKkETZ9bmfGM/RCA5gRK/Bq26aUD3U1Wtu8ETjHYoVpKTbRZYPfSIuU69Vjq+fFDMK65XrBgFmXHTR2mGUU/5b+EZnuvLuZap0gexBo7p41eNiWw0WMgypJBGy6nK9IpynaXTj2p81qm1f1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698142; c=relaxed/simple;
	bh=cpqL+Hl6DXpr8zMLQSAXCRUte3LWhQQIiqBnOCk+8q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKki1t9Vcjsgi8+Sg/508YuXSrl97fGN487g8LLKKyoSVEXgOayrLRD3mNHNGaXveyUgMyf+0H/KYC5T1VCkcA9RBMXVjGKta/OXGqf58DClel24gw24Pe0vIH6q++tptTAmSFe4ZETbKPPMU59w+hARKhCUlVo+OIQhFvvwOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GkNdKHWp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3dda73192so22333345ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712698140; x=1713302940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1EckUdhv2S0vsLHXrSpPAoBKrsnqtVxE+FzPaDR/vQ=;
        b=GkNdKHWpHzVRjHUHYaa4Dz17qLR3IeF9Tm3SDpo2v/aWhb7gJnJGowGCG4ac0B+LJ4
         YYpujhGFRCPEt/Mmc3jdRKWklWg1gtLO+oOS9PNMAfUmAetioAxVQN7FesJtnQQ8Vx4v
         ochJCC9jTAVkYqqudrXye+NxGkAK0vkfJyqpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698140; x=1713302940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1EckUdhv2S0vsLHXrSpPAoBKrsnqtVxE+FzPaDR/vQ=;
        b=snLvRIpisf3WCnyEYBmWicsyGZf4awil4TU7gIZ3KRY9LuWp26yetrrh2HuxGhxeM8
         ctXxKcqc/hlJmUKmj88PQyAj9ZjI49/0I51KiPU8Ygqi+xUpyVJe1WJZlhFvJTekmOUD
         ZVuieKZDqf42sxG739GVmTBml2vat7jhc4ButC2R/pC5hPOnjhAbWyqAm5l5G3kFUXRH
         fS9yC92MRUN+1sFVJAh3pdDGZ4uoV+UAar1G+9Bu/AuAfLuL0dsiLZEGC0HGXQokqB2+
         gRZkcbFc5d7gYXMvnyr+yqJUJe8wETRGnnWWdhyqfMBj5i51diPv13Hb4m4U2kTNewqD
         Xo0A==
X-Forwarded-Encrypted: i=1; AJvYcCXMe5M7OaUyHv1K3FYGBMsQWSXkxC31AkqqDvtQHKZPT90jjb6PE3onJlCmjm01rpCiQkvKAQkKscSXkvukefUCbAPb5qhQe3dbQl38qw==
X-Gm-Message-State: AOJu0YyG1jKLn+CzydwsmcJPAwFisjFJFB/rO8Od7RZJpeMduwIC1UUZ
	TREq3TloWK43IyIJkgFUesQnyJ7wVuXjXR/lDcKmGroCgSBYMMO6L7seTIhgHQ==
X-Google-Smtp-Source: AGHT+IGp1vHyVN9Of3ONnBmhGBURnZ2ozCtASZrjhYok6bINm0BBVqQzRg5525pvfv09CAPY6RG2ng==
X-Received: by 2002:a17:902:a5cb:b0:1e2:adad:75f4 with SMTP id t11-20020a170902a5cb00b001e2adad75f4mr907671plq.28.1712698139910;
        Tue, 09 Apr 2024 14:28:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e35200b001e2461c52c6sm9401985plc.149.2024.04.09.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:28:59 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:28:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-ID: <202404091428.B95127B72@keescook>
References: <20240408090205.3714934-1-elver@google.com>
 <202404090840.E09789B66@keescook>
 <ZhWIKeZuWfPOU91D@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhWIKeZuWfPOU91D@elver.google.com>

On Tue, Apr 09, 2024 at 08:25:45PM +0200, Marco Elver wrote:
> On Tue, Apr 09, 2024 at 08:46AM -0700, Kees Cook wrote:
> [...]
> > > +	trace_new_exec(current, bprm);
> > > +
> > 
> > All other steps in this function have explicit comments about
> > what/why/etc. Please add some kind of comment describing why the
> > tracepoint is where it is, etc.
> 
> I beefed up the tracepoint documentation, and wrote a little paragraph
> above where it's called to reinforce what we want.
> 
> [...]
> > What about binfmt_misc, and binfmt_script? You may want bprm->interp
> > too?
> 
> Good points. I'll make the below changes for v2:
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index ab778ae1fc06..472b9f7b40e8 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1268,6 +1268,12 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		return retval;
>  
> +	/*
> +	 * This tracepoint marks the point before flushing the old exec where
> +	 * the current task is still unchanged, but errors are fatal (point of
> +	 * no return). The later "sched_process_exec" tracepoint is called after
> +	 * the current task has successfully switched to the new exec.
> +	 */
>  	trace_new_exec(current, bprm);
>  
>  	/*
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 8853dc44783d..623d9af777c1 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -61,8 +61,11 @@ TRACE_EVENT(task_rename,
>   * @task:	pointer to the current task
>   * @bprm:	pointer to linux_binprm used for new exec
>   *
> - * Called before flushing the old exec, but at the point of no return during
> - * switching to the new exec.
> + * Called before flushing the old exec, where @task is still unchanged, but at
> + * the point of no return during switching to the new exec. At the point it is
> + * called the exec will either succeed, or on failure terminate the task. Also
> + * see the "sched_process_exec" tracepoint, which is called right after @task
> + * has successfully switched to the new exec.
>   */
>  TRACE_EVENT(new_exec,
>  
> @@ -71,19 +74,22 @@ TRACE_EVENT(new_exec,
>  	TP_ARGS(task, bprm),
>  
>  	TP_STRUCT__entry(
> +		__string(	interp,		bprm->interp	)
>  		__string(	filename,	bprm->filename	)
>  		__field(	pid_t,		pid		)
>  		__string(	comm,		task->comm	)
>  	),
>  
>  	TP_fast_assign(
> +		__assign_str(interp, bprm->interp);
>  		__assign_str(filename, bprm->filename);
>  		__entry->pid = task->pid;
>  		__assign_str(comm, task->comm);
>  	),
>  
> -	TP_printk("filename=%s pid=%d comm=%s",
> -		  __get_str(filename), __entry->pid, __get_str(comm))
> +	TP_printk("interp=%s filename=%s pid=%d comm=%s",
> +		  __get_str(interp), __get_str(filename),
> +		  __entry->pid, __get_str(comm))
>  );
>  
>  #endif

Looks good; I await v2, and Steven's Ack. :)

-- 
Kees Cook

