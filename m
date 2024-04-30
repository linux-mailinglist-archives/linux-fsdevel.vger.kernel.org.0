Return-Path: <linux-fsdevel+bounces-18301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2138B69FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 07:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED2E1C21DAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160461774E;
	Tue, 30 Apr 2024 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kUvPO+dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166B17582
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714455411; cv=none; b=KkBfhrSRAmNWc6hzFGyR1x3SYWcORuOs61lz+9XfraDSuEyAbLODl7mKFeVonCCrUMurqSCQh1w/ED6fVauiAnAGNiayJdhLw81AfGgDLeHeBglPN5JCsE7zeTkYwxH5Od3QuJPvZZO7iVlF1qQsEJttWlGWQeF8xnz+MDG9A8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714455411; c=relaxed/simple;
	bh=ic45Ly5iOqM2hN40D+e1MnLz2cah/7zHv0WBtywKiU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNg6cPZ8Qp35AeZOA/eU+eQ2lmHqNaJJGL4eIzM+4druCQS9IF4K1Te3AXw5BBzYRIv7NUQhFlVLPzG4wNmorypgbIUwWpIa+ovUc5kE5GN1bxV+bqHxNn9TYlNjZyY5G+aNsqXF11HOnDF3+vO4hJvMnF8rlvczUadhL+OSxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kUvPO+dy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso41851805ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714455409; x=1715060209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tfcUvly+FIvb0j4uFmsdXOeKUl+PlbA1SIU5IPSmRRs=;
        b=kUvPO+dyIdUtHDCRCw+bSVBv2FNq1I4DEqiMAbE7LqxbvlX9XhLkoU/x11Z0H5eM0g
         09LOmvnCr/JFaspzk7Y/Czo/QXMif/fwLWt88ODWVO5c84y9i50lPDZI7toB5OQVGf3+
         jelFypwwof1N5v3dgB4teLsKIyc6LqXyH+uFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714455409; x=1715060209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfcUvly+FIvb0j4uFmsdXOeKUl+PlbA1SIU5IPSmRRs=;
        b=Xu+qe6EgBumr0/sJR+7Wp01qo0GzsrNkBGB1LkLCHEOwgF6100pFeYH7FU+GNzUyG0
         /JpD9qkHqDH76W4WU6g73V4IwRYHiEWyvILUnd2rHcH3pxV+AKZGC/NwaXPSJdDrnfaP
         U2TJ3+Mm+rAIUZUzJNI7d8r5gjKRKK3cBYN2tYGzBgFNlvu62OXYoy8ju7gZDcr4/dmw
         OMUyC+u5eeuEqDQ6ZzA+WQg471Qt2jxTkYIFtCXOl9piWbYz2lWM7b5ZNfQq98QRay6B
         fGp6FQE2Og8q99rMr3Whrsqd6pnnRC7cPpEI5lxlD1JWrhZBMeinuyRNLWv2k7Sx2Zoy
         TJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWKX+VdnlozXmbW06xolKNpCLfe0Zi1WoTtHrBXRX6u5NroQJ4RnA42t3ji3I8hdIO81cAkT43TM/st7UrsWB0maYc6zHXbwDX/AxAsdg==
X-Gm-Message-State: AOJu0Ywc4uKCOJ8rEMuTR2HCPNtqqqLAOS71zoYByHDavxfsyiTckO9N
	GbloJFkLuv0ZijsHEgO2+QBUp6H73SQp+SlPWp/E3t0idDlGeMkzeidt55dEsg==
X-Google-Smtp-Source: AGHT+IEI1xCl5MgJCRf5jfTPqNjC35t8O+Ee/g+Asor/wizBcjvlYPWp+LqGt/RJxxnu3iJri6Tn1w==
X-Received: by 2002:a17:903:487:b0:1dc:a605:5435 with SMTP id jj7-20020a170903048700b001dca6055435mr12028201plb.31.1714455409417;
        Mon, 29 Apr 2024 22:36:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001e2a7e90321sm21334480plc.224.2024.04.29.22.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:36:48 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:36:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Allen <allen.lkml@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, mcgrof@kernel.org, j.granados@samsung.com
Subject: Re: [RFC PATCH] fs/coredump: Enable dynamic configuration of max
 file note size
Message-ID: <202404292236.568F42D3C@keescook>
References: <20240429172128.4246-1-apais@linux.microsoft.com>
 <202404291245.18281A6D@keescook>
 <CAOMdWS+k63T9TQ=Zvev-+Q3Zw-wuEUv_f63=YiTx0nK1J9Jfwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMdWS+k63T9TQ=Zvev-+Q3Zw-wuEUv_f63=YiTx0nK1J9Jfwg@mail.gmail.com>

On Mon, Apr 29, 2024 at 03:35:01PM -0700, Allen wrote:
> On Mon, Apr 29, 2024 at 12:49 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Apr 29, 2024 at 05:21:28PM +0000, Allen Pais wrote:
> > > Introduce the capability to dynamically configure the maximum file
> > > note size for ELF core dumps via sysctl. This enhancement removes
> > > the previous static limit of 4MB, allowing system administrators to
> > > adjust the size based on system-specific requirements or constraints.
> >
> > Under what conditions is this actually needed?
> 
>  I addressed this in the email I sent out before this.
> 
> >
> > > [...]
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 81cc974913bb..80cdc37f2fa2 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -63,6 +63,7 @@
> > >  #include <linux/mount.h>
> > >  #include <linux/userfaultfd_k.h>
> > >  #include <linux/pid.h>
> > > +#include <linux/coredump.h>
> > >
> > >  #include "../lib/kstrtox.h"
> > >
> > > @@ -1623,6 +1624,13 @@ static struct ctl_table kern_table[] = {
> > >               .mode           = 0644,
> > >               .proc_handler   = proc_dointvec,
> > >       },
> > > +     {
> > > +             .procname       = "max_file_note_size",
> > > +             .data           = &max_file_note_size,
> > > +             .maxlen         = sizeof(unsigned int),
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec,
> > > +     },
> >
> > Please don't add new sysctls to kernel/sysctl.c. Put this in fs/coredump.c
> > instead, and name it "core_file_note_size_max". (A "max" suffix is more
> > common than prefixes, and I'd like it clarified that it relates to the
> > coredumper with the "core" prefix that match the other coredump sysctls.
> >
> > -Kees
> 
> Makes sense. Let me know if the below looks fine,
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5397b552fbeb..6aebd062b92b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote
> *note, user_siginfo_t *csigdata,
>         fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
>  }
> 
> -#define MAX_FILE_NOTE_SIZE (4*1024*1024)
>  /*
>   * Format of NT_FILE note:
>   *
> @@ -1592,7 +1591,7 @@ static int fill_files_note(struct memelfnote
> *note, struct coredump_params *cprm
> 
>         names_ofs = (2 + 3 * count) * sizeof(data[0]);
>   alloc:
> -       if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> +       if (size >= core_file_note_size_max) /* paranoia check */
>                 return -EINVAL;
>         size = round_up(size, PAGE_SIZE);
>         /*
> diff --git a/fs/coredump.c b/fs/coredump.c
> index be6403b4b14b..2108eb93acb9 100644
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
>         char *corename;
> @@ -1020,6 +1023,13 @@ static struct ctl_table coredump_sysctls[] = {
>                 .mode           = 0644,
>                 .proc_handler   = proc_dointvec,
>         },
> +       {
> +               .procname       = "core_file_note_size_max",
> +               .data           = &core_file_note_size_max,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_douintvec,
> +       },
>  };
> 
>  static int __init init_fs_coredump_sysctls(void)
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index d3eba4360150..14c057643e7f 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -46,6 +46,7 @@ static inline void do_coredump(const
> kernel_siginfo_t *siginfo) {}
>  #endif
> 
>  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> +extern unsigned int core_file_note_size_max;
>  extern void validate_coredump_safety(void);
>  #else
>  static inline void validate_coredump_safety(void) {}

Yes; thank you! I like this naming (and sysctl location) now. :)

-Kees

-- 
Kees Cook

