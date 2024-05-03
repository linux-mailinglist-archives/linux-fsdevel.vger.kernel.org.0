Return-Path: <linux-fsdevel+bounces-18559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98308BA4CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 03:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5448D1F22DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F3DDB8;
	Fri,  3 May 2024 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuFOdcV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40361BE6C;
	Fri,  3 May 2024 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698614; cv=none; b=t1lB63ArvcpvjtutqkSX0DlStxxLP1yK69v1kBuw3w0F8MuRBT4BIZYHAFRfiwbaXH0esXsQJYXtpj1IRgzcgK7V+udqHWWHK/J0ukPxbCpKM5bBsaPU59wogIWz5mNdowSfCQC2QVPcWbCd7vAbzd57mLu5iFAPbhfEvGXwiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698614; c=relaxed/simple;
	bh=bllATCqOkezyCUUmIt1YXRRfWvmtRkwcPpnrWbVJDuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibdjP5r9iG72yWga8icD4JZ2/M/gbFJMVks2IuyqqN0EMY6xFEWwj2NmiCbz0BLYzmZwZTd8NDy2zBzRxvBBCgMBDoPRyjDi4gXJ4nwcBVLDmRSiXe9usXK7ZWITfB2NiVbLtT5+5d4rlz3huXGPyanwTv8WB14J+Ntkq8VECH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuFOdcV1; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7f17efe79a1so1066773241.2;
        Thu, 02 May 2024 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714698612; x=1715303412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcivoYXjhNV3GkTXLRXF43T/wLWOG6MyPhRAIhBIkA4=;
        b=ZuFOdcV1sh+NfUB2hAmS4ohiYOzxJ9QDvLqDa4bNw42zfv4Ugc4l1qnvoNh/J53/QC
         gLyysAxli7C4R3ns+dcn4C5tFQ7H4leTaWRuOGEjYmfEhLApgGeePT5Kq0G6qSb91qM0
         XM+GGKZzHZU51NkujGDOz3DpKZhDsUppaMXFJFoE+ge0u4HTVmcToq28vsi3/zeBinpN
         vjA1jq9UwHxCdyQGhKswpCDXY3D+hu3WWXSYZPvn273rkNF3P1D99YUAadXaMKNRGUae
         Oih4iW3+uLDn9fKYF9TDaKX6+T3715LEZplyHe62thOgjDFLZX0nEXWYEqHY/6BMbzty
         zdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714698612; x=1715303412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcivoYXjhNV3GkTXLRXF43T/wLWOG6MyPhRAIhBIkA4=;
        b=PPhp1ZD8mmRbG6aDXP0a7mH3g/FpcXPUrIlDbADyk1FSPBiz9L25HhVSeuEgRH/QpJ
         2b2OS6VKw5+1MYMq/Sd6FY3wbksblViw9Wge/SweYnK6yYSyJdkdhbVU/KGrd7p/0PtD
         5odomngF86M3atfSuoqFQl36QguIzkvx1XjIFYfrhuDzFZNAsgm1ec3XWmsVaPnw5fA9
         QIzrRjpukm5WGE3JElSsi62JXanQBlf2H/QQkA4REuc/FvOBAc0+hcfo8DT6MyEZRt8w
         fFlKPg+vq4UE/tybeu80+RIoY8+IrKkIb/fvuDDIhV6cAO9Pv2vhmFqM8iJbLBljeaLg
         80ig==
X-Forwarded-Encrypted: i=1; AJvYcCWSgFpV3upOuH8t2lKD1/ZQXSMxWI0fvSXBZ5gpk0pq9xv7LXwscjwQwceTHfV9cG0iNHtNBCXWuZuvnJVIay+67SDifuDfpCrtEBHMg/3gY163BgImW+ptPIchfpov0HU5zcvpVE2R+8Gc7Q==
X-Gm-Message-State: AOJu0YxQCfQD5rWoazTkBfm1IALhLbYOkAnWuTQ2W6aOexbwkFL50f6V
	q7wsZLUq5z340WN+iamDhCAwi3sSIb41IKqkW2Pv2FFk8TcO8uB2NpcG7c+AXr34yKPPYvdEody
	Y08KrDm+SrHRjPGewwlBzqG2IO1c=
X-Google-Smtp-Source: AGHT+IGQuUbN3qIwl8Y0J9GY/pX9vDj5/9GMce0s9P+xLlRsaNlRD6am8i0nfaOWGEBADNEEsGR+8lUuXCazrT+nr6U=
X-Received: by 2002:a05:6122:546:b0:4df:1ef7:ac92 with SMTP id
 y6-20020a056122054600b004df1ef7ac92mr1457417vko.6.1714698611929; Thu, 02 May
 2024 18:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502235603.19290-1-apais@linux.microsoft.com> <202405021743.D06C96516@keescook>
In-Reply-To: <202405021743.D06C96516@keescook>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 2 May 2024 18:10:00 -0700
Message-ID: <CAOMdWSLa-dp34aq3RepQABpnGs-TnyQgUxFm--MHVHFuVYTgFg@mail.gmail.com>
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
To: Kees Cook <keescook@chromium.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org, 
	j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"

> > Introduce the capability to dynamically configure the maximum file
> > note size for ELF core dumps via sysctl. This enhancement removes
> > the previous static limit of 4MB, allowing system administrators to
> > adjust the size based on system-specific requirements or constraints.
> >
> > - Remove hardcoded `MAX_FILE_NOTE_SIZE` from `fs/binfmt_elf.c`.
> > - Define `max_file_note_size` in `fs/coredump.c` with an initial value
> >   set to 4MB.
> > - Declare `max_file_note_size` as an external variable in
> >   `include/linux/coredump.h`.
> > - Add a new sysctl entry in `kernel/sysctl.c` to manage this setting
> >   at runtime.
>
> The above bullet points should be clear from the patch itself. The
> commit is really more about rationale and examples (which you have
> below). I'd remove the bullets.

Sure, I have it modified to:

fs/coredump: Enable dynamic configuration of max file note size

    Introduce the capability to dynamically configure the maximum file
    note size for ELF core dumps via sysctl.

    Why is this being done?
    We have observed that during a crash when there are more than 65k mmaps
    in memory, the existing fixed limit on the size of the ELF notes section
    becomes a bottleneck. The notes section quickly reaches its capacity,
    leading to incomplete memory segment information in the resulting coredump.
    This truncation compromises the utility of the coredumps, as crucial
    information about the memory state at the time of the crash might be
    omitted.

    This enhancement removes the previous static limit of 4MB, allowing
    system administrators to adjust the size based on system-specific
    requirements or constraints.

    Eg:
    $ sysctl -a | grep core_file_note_size_max
    kernel.core_file_note_size_max = 4194304
.......
>
> >
> > $ sysctl -a | grep core_file_note_size_max
> > kernel.core_file_note_size_max = 4194304
> >
> > $ sysctl -n kernel.core_file_note_size_max
> > 4194304
> >
> > $echo 519304 > /proc/sys/kernel/core_file_note_size_max
> >
> > $sysctl -n kernel.core_file_note_size_max
> > 519304
> >
> > Attempting to write beyond the ceiling value of 16MB
> > $echo 17194304 > /proc/sys/kernel/core_file_note_size_max
> > bash: echo: write error: Invalid argument
> >
> > Why is this being done?
> > We have observed that during a crash when there are more than 65k mmaps
> > in memory, the existing fixed limit on the size of the ELF notes section
> > becomes a bottleneck. The notes section quickly reaches its capacity,
> > leading to incomplete memory segment information in the resulting coredump.
> > This truncation compromises the utility of the coredumps, as crucial
> > information about the memory state at the time of the crash might be
> > omitted.
>
> I'd make this the first paragraph of the commit log. "We have this
> problem" goes first, then "Here's what we did to deal with it", then you
> examples. :)
>
 Done.

> >
> > Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> >
> > ---
> > Chagnes in v3:
> >    - Fix commit message to reflect the correct sysctl knob [Kees]
> >    - Add a ceiling for maximum pssible note size(16M) [Allen]
> >    - Add a pr_warn_once() [Kees]
> > Changes in v2:
> >    - Move new sysctl to fs/coredump.c [Luis & Kees]
> >    - rename max_file_note_size to core_file_note_size_max [kees]
> >    - Capture "why this is being done?" int he commit message [Luis & Kees]
> > ---
> >  fs/binfmt_elf.c          |  8 ++++++--
> >  fs/coredump.c            | 15 +++++++++++++++
> >  include/linux/coredump.h |  1 +
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 5397b552fbeb..5294f8f3a9a8 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
> >       fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
> >  }
> >
> > -#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> >  /*
> >   * Format of NT_FILE note:
> >   *
> > @@ -1592,8 +1591,13 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
> >
> >       names_ofs = (2 + 3 * count) * sizeof(data[0]);
> >   alloc:
> > -     if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> > +     /* paranoia check */
> > +     if (size >= core_file_note_size_max) {
> > +             pr_warn_once("coredump Note size too large: %u "
> > +             "(does kernel.core_file_note_size_max sysctl need adjustment?)\n",
>
> The string can be on a single line (I think scripts/check_patch.pl will
> warn about this, as well as the indentation of "size" below...

 It does warn, but if I leave it as a single line, there's still a warning:
WARNING: line length of 135 exceeds 100 columns, which is why I
split it into multiple lines.

>
> > +             size);
> >               return -EINVAL;
> > +     }
> >       size = round_up(size, PAGE_SIZE);
> >       /*
> >        * "size" can be 0 here legitimately.
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index be6403b4b14b..ffaed8c1b3b0 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -56,10 +56,16 @@
> >  static bool dump_vma_snapshot(struct coredump_params *cprm);
> >  static void free_vma_snapshot(struct coredump_params *cprm);
> >
> > +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> > +/* Define a reasonable max cap */
> > +#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024)
>
> Let's call this CORE_FILE_NOTE_SIZE_DEFAULT and
> CORE_FILE_NOTE_SIZE_MAX to match the sysctl.
>

 Sure, will update it in v4.

> > +
> >  static int core_uses_pid;
> >  static unsigned int core_pipe_limit;
> >  static char core_pattern[CORENAME_MAX_SIZE] = "core";
> >  static int core_name_size = CORENAME_MAX_SIZE;
> > +unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;
> > +unsigned int core_file_note_size_allowed = MAX_ALLOWED_NOTE_SIZE;
>
> The latter can be static and const.
>
> For the note below, perhaps add:
>
> static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
>

 core_file_note_size_min will be used in fs/binfmt_elf.c at:

    if (size >= core_file_note_size_min) ,
did you mean
static const unsigned int core_file_note_size_allowed =
CORE_FILE_NOTE_SIZE_MAX;??
> >
> >  struct core_name {
> >       char *corename;
> > @@ -1020,6 +1026,15 @@ static struct ctl_table coredump_sysctls[] = {
> >               .mode           = 0644,
> >               .proc_handler   = proc_dointvec,
> >       },
> > +     {
> > +             .procname       = "core_file_note_size_max",
> > +             .data           = &core_file_note_size_max,
> > +             .maxlen         = sizeof(unsigned int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_douintvec_minmax,
> > +             .extra1         = &core_file_note_size_max,
>
> This means you can never shrink it if you raise it from the default.
> Let's use the core_file_note_size_min above.

Sure, will fix it in v4.
>
> > +             .extra2         = &core_file_note_size_allowed,
> > +     },
> >  };
> >
> >  static int __init init_fs_coredump_sysctls(void)
> > diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> > index d3eba4360150..14c057643e7f 100644
> > --- a/include/linux/coredump.h
> > +++ b/include/linux/coredump.h
> > @@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
> >  #endif
> >
> >  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> > +extern unsigned int core_file_note_size_max;
> >  extern void validate_coredump_safety(void);
> >  #else
> >  static inline void validate_coredump_safety(void) {}
> > --
> > 2.17.1
> >
>
> I think v4 will be all good to go, assuming no one else pops up. :)
> Thanks for the changes!

Thank you for the reviews. Will send out v4 soon.

-- 
       - Allen

