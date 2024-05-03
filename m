Return-Path: <linux-fsdevel+bounces-18558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B888BA4B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4781C227CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264F0C8D7;
	Fri,  3 May 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VzUEZfcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF6BA53
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697386; cv=none; b=ojgxLEmg7iMeUB33FcLkoMZLYIHvzZsk/Rygn200HU71UaLb80jGdLvbNAyUY9HSgVAAWZSL+U2HvQL8/avGDFNT+Cikq9Cj3NSybRa0yAA70SoLa56MvHWLcxfIJl4j75eBGNj6yka74xNRjp3ITPUMj8Upf8WdZFnqRhiCRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697386; c=relaxed/simple;
	bh=lvGVASQUWqVxHMy/YIsZTMOSOIcClC1mDAbxw4IZZa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuizLzZ43Ju0AZ5A0UINweiBOING0f3MNTMAib2ot1Xs6jBsKV+OkMRXPwrjEcH5pg1dLLv2oav8VZUI5uHlFIeT+VZwJgay5cA6tSQKJ4ukDM8aVfl03zHFzLFuCaBy2gAG7TpjSt2ZLUt6kfJ6lgOEyVtdIeNgvxmuAgdiasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VzUEZfcz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eab16c8d83so71193895ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714697384; x=1715302184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa5+5n4xYY4Yi8nY/7xTIbS3mmK4Gb+jmAeiTpe6kJE=;
        b=VzUEZfczIRufbm/J4BPeBB7Jy1L5JwkDP3Mtie7p2dBgalYJpwU+N0VRY6WI2tQ183
         HR311oJCLLVgtQ5OYO4Dq2YrN0JVunYt6FJ9HMn+EcJqKZUXCraOWetqz+6/HjVzgTfB
         kGbV08KJbCrkAZuqxTq9OF83lqGjMArfT9TRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697384; x=1715302184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa5+5n4xYY4Yi8nY/7xTIbS3mmK4Gb+jmAeiTpe6kJE=;
        b=WKvrhIIK3AX/RpBRfkOSC/LcKLRYwn6eoeyQHD4fxhATrfYAVwtWgAkh4Twj8SyoeQ
         RV2ywaPSwtAZsgeabe2/fjtN+3uWVDwFFldmegld3fDqPqwB63koLCWGMW6EF913ZxBS
         aH6y5DtKRWSMo7q0uNvM8YUSvIB3l8/xaAvt3+70htPxLDTlaygZct8B09UKKWuKndOJ
         Bv0BNJWuzywUwv/xHhOJA9LpjvK3fRv6NCSEsRj5LbhWJYz33u4LMCt9k9Id3lFNnKi6
         B+j65a10aH51yMedCq28s62WMXPYXIjAMbjVBVhm6qrR5Xk7Ez4a1mJIDvR9cxxeCKU7
         ITIA==
X-Gm-Message-State: AOJu0Yz0y/o8YBEL3U4VPWYMt3d4WlhUkBW8PGUPWkDDMqgZ38nWp/HT
	+ZNOkjjIa07+mSeGX1+xDMnt3c37vcXq/yfWgDEI+Wee6TFlCd9QvxVBcQTtYA==
X-Google-Smtp-Source: AGHT+IHq2BatsIoN8JL1NJej1wjLKFWF7wnDkm/z7hPXf2k9ag32XKCjUTWE4QOSj1o4RhmRY4J24w==
X-Received: by 2002:a17:902:e890:b0:1e5:5bd7:87b4 with SMTP id w16-20020a170902e89000b001e55bd787b4mr1445942plg.18.1714697384243;
        Thu, 02 May 2024 17:49:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc22-20020a17090325d600b001e503c555afsm1978998plb.97.2024.05.02.17.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:49:43 -0700 (PDT)
Date: Thu, 2 May 2024 17:49:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org,
	j.granados@samsung.com, allen.lkml@gmail.com
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405021743.D06C96516@keescook>
References: <20240502235603.19290-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502235603.19290-1-apais@linux.microsoft.com>

On Thu, May 02, 2024 at 11:56:03PM +0000, Allen Pais wrote:
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

The above bullet points should be clear from the patch itself. The
commit is really more about rationale and examples (which you have
below). I'd remove the bullets.

> 
> $ sysctl -a | grep core_file_note_size_max
> kernel.core_file_note_size_max = 4194304
> 
> $ sysctl -n kernel.core_file_note_size_max
> 4194304
> 
> $echo 519304 > /proc/sys/kernel/core_file_note_size_max
> 
> $sysctl -n kernel.core_file_note_size_max
> 519304
> 
> Attempting to write beyond the ceiling value of 16MB
> $echo 17194304 > /proc/sys/kernel/core_file_note_size_max
> bash: echo: write error: Invalid argument
> 
> Why is this being done?
> We have observed that during a crash when there are more than 65k mmaps
> in memory, the existing fixed limit on the size of the ELF notes section
> becomes a bottleneck. The notes section quickly reaches its capacity,
> leading to incomplete memory segment information in the resulting coredump.
> This truncation compromises the utility of the coredumps, as crucial
> information about the memory state at the time of the crash might be
> omitted.

I'd make this the first paragraph of the commit log. "We have this
problem" goes first, then "Here's what we did to deal with it", then you
examples. :)

> 
> Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> 
> ---
> Chagnes in v3:
>    - Fix commit message to reflect the correct sysctl knob [Kees]
>    - Add a ceiling for maximum pssible note size(16M) [Allen]
>    - Add a pr_warn_once() [Kees]
> Changes in v2:
>    - Move new sysctl to fs/coredump.c [Luis & Kees]
>    - rename max_file_note_size to core_file_note_size_max [kees]
>    - Capture "why this is being done?" int he commit message [Luis & Kees]
> ---
>  fs/binfmt_elf.c          |  8 ++++++--
>  fs/coredump.c            | 15 +++++++++++++++
>  include/linux/coredump.h |  1 +
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5397b552fbeb..5294f8f3a9a8 100644
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
> @@ -1592,8 +1591,13 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
>  
>  	names_ofs = (2 + 3 * count) * sizeof(data[0]);
>   alloc:
> -	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> +	/* paranoia check */
> +	if (size >= core_file_note_size_max) {
> +		pr_warn_once("coredump Note size too large: %u "
> +		"(does kernel.core_file_note_size_max sysctl need adjustment?)\n",

The string can be on a single line (I think scripts/check_patch.pl will
warn about this, as well as the indentation of "size" below...

> +		size);
>  		return -EINVAL;
> +	}
>  	size = round_up(size, PAGE_SIZE);
>  	/*
>  	 * "size" can be 0 here legitimately.
> diff --git a/fs/coredump.c b/fs/coredump.c
> index be6403b4b14b..ffaed8c1b3b0 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -56,10 +56,16 @@
>  static bool dump_vma_snapshot(struct coredump_params *cprm);
>  static void free_vma_snapshot(struct coredump_params *cprm);
>  
> +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> +/* Define a reasonable max cap */
> +#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024)

Let's call this CORE_FILE_NOTE_SIZE_DEFAULT and
CORE_FILE_NOTE_SIZE_MAX to match the sysctl.

> +
>  static int core_uses_pid;
>  static unsigned int core_pipe_limit;
>  static char core_pattern[CORENAME_MAX_SIZE] = "core";
>  static int core_name_size = CORENAME_MAX_SIZE;
> +unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;
> +unsigned int core_file_note_size_allowed = MAX_ALLOWED_NOTE_SIZE;

The latter can be static and const.

For the note below, perhaps add:

static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;

>  
>  struct core_name {
>  	char *corename;
> @@ -1020,6 +1026,15 @@ static struct ctl_table coredump_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname       = "core_file_note_size_max",
> +		.data           = &core_file_note_size_max,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler	= proc_douintvec_minmax,
> +		.extra1		= &core_file_note_size_max,

This means you can never shrink it if you raise it from the default.
Let's use the core_file_note_size_min above.

> +		.extra2		= &core_file_note_size_allowed,
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
> 

I think v4 will be all good to go, assuming no one else pops up. :)
Thanks for the changes!

-Kees

-- 
Kees Cook

