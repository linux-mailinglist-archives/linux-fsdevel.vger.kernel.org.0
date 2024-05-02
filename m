Return-Path: <linux-fsdevel+bounces-18512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6348B9FCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939D6B226DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734D172BCE;
	Thu,  2 May 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LrVzlPHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC3171064
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672243; cv=none; b=AqM4m7OXR6X1BExl0ZV1G9jNXGrU5QWVuB4ORb/oh+85LUzJmPA7/7/Gm0XCMZYjUJfGWbIZBf8vlC+DSQKR473I4yKFmFQsGEl68wVrvfUb5F3cQtVyWAcGgtmyQe3Hd88vtdyA5b002vtiJ8amMdC2qSR0j++tCwXH6o9RrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672243; c=relaxed/simple;
	bh=HrgFyTGrENLhznRwHqGjk8BqKyptnIBvF/Bip8ApHXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXt8fkl8/mZQBNf5HQmlwX6O0kuczXKaHyiVfoOeso8CwrrpGwTsl7W26VnPiFdCQedp6izFHF96+XwZ4KquUsRUwGdU5bQgfvEvEWk6XgnebQRcfeX0/9nf19YuTpNjkqywlQWol/VT/PkNohBfVNZ/oGgd7jROHbatj32H0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LrVzlPHg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so5356849a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714672241; x=1715277041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uaF0GOsku/Enw0IBZ0DNja/DdL69X77dW5yUv4AwZo=;
        b=LrVzlPHgfYp6e1p7pVOzsYrKD3NT0Vn+qteZ8ecmIrn9eUMcJd3Kc8m7oqsI9BXkVo
         4sQE8NUd+FgckbKNS2A4VNSVkhgf2p7WHC42gPv2cc7PSeZhfXWkMGwnZGyNXavs3qsG
         8zrgj9tmPdP4s8gBWqB5PhJcghAkSF/dudQRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672241; x=1715277041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uaF0GOsku/Enw0IBZ0DNja/DdL69X77dW5yUv4AwZo=;
        b=P1UEMxG8JvEE55nTpgCYRMy0ODiDlipXlFItFW5+o7Atkw0UuTfIB1b9Sth/ypfpqH
         RNDUanWASrHu4+Wh8N5XOxgE1NtjDQyNLrR8VXqorHKkYakI+5UiZz32OLcChbcXFqG6
         gPNBPH5WeeFmytpNOpCGmt7Dv83O6SwvVPeaUn925vcbEatAMHijuJmuUAdgQHbQE9t9
         G59ZGbaBo+ltciHcUOvUDFT6akAXW4qVFSZKjUqP/Y841f1UMIQEmLYde4e8tHwXHKff
         JHRxeMDIibkUS6if+f8cWZewFRP4qW7gU17qwBoUGzkIuF1xIKbeft5vb1nO+rU3y4ST
         hxxA==
X-Gm-Message-State: AOJu0YxVGUgjFYzHws/wupxEKC41DVtKgkWE4hWs4Te4Znyrze0rCVOJ
	uAexZVhyFeJ1mQxQv9m07zhxp3hpN5Y5hXKvhPfZYSd0141g/81emqBP7P0GKg==
X-Google-Smtp-Source: AGHT+IEopB5Z+Ot/+/0juPZG0PnqSIGb9G/R6G3qibniQnQojE/g26Yasy+fM+manPwub9pyTkHN6Q==
X-Received: by 2002:a17:90a:890d:b0:2af:8fa4:40e with SMTP id u13-20020a17090a890d00b002af8fa4040emr559066pjn.1.1714672240673;
        Thu, 02 May 2024 10:50:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090a828500b0029df9355e79sm1540941pjn.13.2024.05.02.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:50:40 -0700 (PDT)
Date: Thu, 2 May 2024 10:50:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org,
	j.granados@samsung.com
Subject: Re: [PATCH v2] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405021045.360F5313EA@keescook>
References: <20240502145920.5011-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502145920.5011-1-apais@linux.microsoft.com>

On Thu, May 02, 2024 at 02:59:20PM +0000, Allen Pais wrote:
> Introduce the capability to dynamically configure the maximum file
> note size for ELF core dumps via sysctl. This enhancement removes
> the previous static limit of 4MB, allowing system administrators to
> adjust the size based on system-specific requirements or constraints.
> 
> - Remove hardcoded `MAX_FILE_NOTE_SIZE` from `fs/binfmt_elf.c`.
> - Define `max_file_note_size` in `fs/coredump.c` with an initial value
>   set to 4MB.
> - Declare `max_file_note_size` as an external variable in
>   `include/linux/coredump.h`.
> - Add a new sysctl entry in `kernel/sysctl.c` to manage this setting
>   at runtime.
> 
> $ sysctl -a | grep max_file_note_size
> kernel.max_file_note_size = 4194304
> 
> $ sysctl -n kernel.max_file_note_size
> 4194304
> 
> $echo 519304 > /proc/sys/kernel/max_file_note_size
> 
> $sysctl -n kernel.max_file_note_size
> 519304

The names and paths in the commit log need a refresh here, since they've
changed.

> 
> Why is this being done?
> We have observed that during a crash when there are more than 65k mmaps
> in memory, the existing fixed limit on the size of the ELF notes section
> becomes a bottleneck. The notes section quickly reaches its capacity,
> leading to incomplete memory segment information in the resulting coredump.
> This truncation compromises the utility of the coredumps, as crucial
> information about the memory state at the time of the crash might be
> omitted.

Thanks for adding this!

> 
> Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> 
> ---
> Changes in v2:
>    - Move new sysctl to fs/coredump.c [Luis & Kees]
>    - rename max_file_note_size to core_file_note_size_max [kees]
>    - Capture "why this is being done?" int he commit message [Luis & Kees]
> ---
>  fs/binfmt_elf.c          |  3 +--
>  fs/coredump.c            | 10 ++++++++++
>  include/linux/coredump.h |  1 +
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5397b552fbeb..6aebd062b92b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
>  	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
>  }
>  
> -#define MAX_FILE_NOTE_SIZE (4*1024*1024)
>  /*
>   * Format of NT_FILE note:
>   *
> @@ -1592,7 +1591,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
>  
>  	names_ofs = (2 + 3 * count) * sizeof(data[0]);
>   alloc:
> -	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> +	if (size >= core_file_note_size_max) /* paranoia check */
>  		return -EINVAL;

I wonder, given the purpose of this sysctl, if it would be a
discoverability improvement to include a pr_warn_once() before the
EINVAL? Like:

	/* paranoia check */
	if (size >= core_file_note_size_max) {
		pr_warn_once("coredump Note size too large: %zu (does kernel.core_file_note_size_max sysctl need adjustment?\n", size);
  		return -EINVAL;
	}

What do folks think? (I can't imagine tracking down this problem
originally was much fun, for example.)

>  	size = round_up(size, PAGE_SIZE);
>  	/*
> diff --git a/fs/coredump.c b/fs/coredump.c
> index be6403b4b14b..a312be48030f 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -56,10 +56,13 @@
>  static bool dump_vma_snapshot(struct coredump_params *cprm);
>  static void free_vma_snapshot(struct coredump_params *cprm);
>  
> +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> +
>  static int core_uses_pid;
>  static unsigned int core_pipe_limit;
>  static char core_pattern[CORENAME_MAX_SIZE] = "core";
>  static int core_name_size = CORENAME_MAX_SIZE;
> +unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;
>  
>  struct core_name {
>  	char *corename;
> @@ -1020,6 +1023,13 @@ static struct ctl_table coredump_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname       = "core_file_note_size_max",
> +		.data           = &core_file_note_size_max,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler   = proc_douintvec,
> +	},
>  };
>  
>  static int __init init_fs_coredump_sysctls(void)
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index d3eba4360150..14c057643e7f 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
>  #endif
>  
>  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> +extern unsigned int core_file_note_size_max;
>  extern void validate_coredump_safety(void);
>  #else
>  static inline void validate_coredump_safety(void) {}
> -- 
> 2.17.1

Otherwise, yes, this looks good to me.

-- 
Kees Cook

