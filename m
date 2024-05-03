Return-Path: <linux-fsdevel+bounces-18560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5A8BA4FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 03:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF2284AE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 01:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4C17556;
	Fri,  3 May 2024 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeYICMz5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACC13FF9;
	Fri,  3 May 2024 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700476; cv=none; b=f52OMS99CD6g6Zxn/jl66TAqYkfWCPJ1Ipz4tXG+qwk+IzAVjMj4zEMJldY66oU+LzqRzx1YVDmvKO2e4YYgURWT5/TRHeRwJo9WBFHclXQi6GjFtZRMoL8Nj08g+7FDdq70k4nCk0KO88QFyMYwcSeBeR+tRULwV2jcuT1nU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700476; c=relaxed/simple;
	bh=DbzoiEyfXukURI2KnddVlRQjElhA8rvJYcCRelBLuaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVzoP882hJccqhqSnn4oCCnzwWCAsbdlEFpi0azFaCcqt49729RwAg0aEyuzBqbbYm7W9ILKyBaXJ1m+sTrqag8YIXAFAElAfa2Ge+xxt9j4kTHsPo7RBPfFJl+QL6UYMwbyF5tlvkG8uU9Dzp32NpQAb6Wjca76L35b4ga9PsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeYICMz5; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7efcdc89872so2095149241.3;
        Thu, 02 May 2024 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714700473; x=1715305273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VlRJGegZy6w5LS1pjceiS9E4YpXz8vFlDYvpW3ED23Q=;
        b=OeYICMz5RF5MsbJihAh91blsue7nOVQ37AmIMNF1Da4K7Sb9WKkb0z+i3kNkskIb+g
         ookMVZoZktqGLnqQWUnWLrYRPBmjWtuyOUiZiFWs+C3bgKfRKTyqEnekP/6SaIVMhqlD
         1iGnFiqRhjOmYn6A1EI2bT6+TucX9aZ9jvzrVWkPnQY2KUt4mmUnixDBQdfiv4C77do2
         tqxHtAymtY1Hggul+6o0KxJm7bVmaSNLZRSXFvQv0tmQU85qet5pykY+FXnmQohPah6l
         jTjrl3M5z5WK2q4Xip8z1y9UMg+xxV+m8mYLPZtdJrHbZVxq/AfyHVClGO/Uc1r4qnck
         JIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714700473; x=1715305273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlRJGegZy6w5LS1pjceiS9E4YpXz8vFlDYvpW3ED23Q=;
        b=noqnkdr8dLwTltkHHkoEySjwTEme/jhSVFKCHC7wJnmJZuGbUlLNCrddmPbb+TT2+Y
         8lrIjzwAQAjez1URruPDdSNG8PpzcJsZX9xED+JR37TgRofUH7Jx5UiDg1xojn6miFb8
         WjvRH9Bdr5c2Lm2wmFNYH2jSWuMy1yyy7Yw9AKZsOE1NO7AOpo/9GY9xCriB/+XOy8Pv
         O+gbx4wUhGvela/fPluGgp0pkxHmTTZHME0Qa/X/5eNtZzSAF/4RCFQcSZBLBI1GjGpu
         yQWJC7LxVvqnIMitOA4Pnu9foKjhnQU/spC9qLRokaGR91qFGsVGiUg/nxNsY1YfUSbQ
         Us3g==
X-Forwarded-Encrypted: i=1; AJvYcCVoLkpSmz1jImNuSwOQJcP/zwzEy9RCD4UH9C6RcCtrwwW18G2x3AZvrY26Jx2gl46mTRc/bqfIvNX0655ZH7QGOOvEbyP6TugS/APRRgghfvNP1ehxw9Rt27e6yC/1en2TtI/sKL0N9MREOQ==
X-Gm-Message-State: AOJu0YylkohIMmu/HkgdufcaTbTQzZKH2lxbzdrEagTZyREooBBoKbik
	cz+oCIL8ttcZIU3EU35WnFvQp0RZz03kBl5YmRwnILNCvwEKmpcu7TF3mbjiu0VTmb6LeKtFZMQ
	e4WRHfCi8lVhvDHctY82UMb6l/hM=
X-Google-Smtp-Source: AGHT+IFBeWjdtaBlerRRX5wmmVtg2RU/hEPFQQBEd4Yx452buoaBo5IsvlOtb3rX30HdP6R0GMkt8aPyuEQNfNrCIUw=
X-Received: by 2002:a05:6122:99d:b0:4d3:398f:8633 with SMTP id
 g29-20020a056122099d00b004d3398f8633mr1485097vkd.10.1714700471440; Thu, 02
 May 2024 18:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502235603.19290-1-apais@linux.microsoft.com>
 <202405021743.D06C96516@keescook> <CAOMdWSLa-dp34aq3RepQABpnGs-TnyQgUxFm--MHVHFuVYTgFg@mail.gmail.com>
In-Reply-To: <CAOMdWSLa-dp34aq3RepQABpnGs-TnyQgUxFm--MHVHFuVYTgFg@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 2 May 2024 18:40:58 -0700
Message-ID: <CAOMdWSLh80OHx=som1WeK_L_=2LVK1rehXH88t3Ew--4dSE4ew@mail.gmail.com>
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
To: Kees Cook <keescook@chromium.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org, 
	j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"

> > > Introduce the capability to dynamically configure the maximum file
> > > note size for ELF core dumps via sysctl. This enhancement removes
> > > the previous static limit of 4MB, allowing system administrators to
> > > adjust the size based on system-specific requirements or constraints.
> > >
> > > - Remove hardcoded `MAX_FILE_NOTE_SIZE` from `fs/binfmt_elf.c`.
> > > - Define `max_file_note_size` in `fs/coredump.c` with an initial value
> > >   set to 4MB.
> > > - Declare `max_file_note_size` as an external variable in
> > >   `include/linux/coredump.h`.
> > > - Add a new sysctl entry in `kernel/sysctl.c` to manage this setting
> > >   at runtime.
> >
> > The above bullet points should be clear from the patch itself. The
> > commit is really more about rationale and examples (which you have
> > below). I'd remove the bullets.
>
> Sure, I have it modified to:
>
> fs/coredump: Enable dynamic configuration of max file note size
>
>     Introduce the capability to dynamically configure the maximum file
>     note size for ELF core dumps via sysctl.
>
>     Why is this being done?
>     We have observed that during a crash when there are more than 65k mmaps
>     in memory, the existing fixed limit on the size of the ELF notes section
>     becomes a bottleneck. The notes section quickly reaches its capacity,
>     leading to incomplete memory segment information in the resulting coredump.
>     This truncation compromises the utility of the coredumps, as crucial
>     information about the memory state at the time of the crash might be
>     omitted.
>
>     This enhancement removes the previous static limit of 4MB, allowing
>     system administrators to adjust the size based on system-specific
>     requirements or constraints.
>
>     Eg:
>     $ sysctl -a | grep core_file_note_size_max
>     kernel.core_file_note_size_max = 4194304
> .......
> >
> > >
> > > $ sysctl -a | grep core_file_note_size_max
> > > kernel.core_file_note_size_max = 4194304
> > >
> > > $ sysctl -n kernel.core_file_note_size_max
> > > 4194304
> > >
> > > $echo 519304 > /proc/sys/kernel/core_file_note_size_max
> > >
> > > $sysctl -n kernel.core_file_note_size_max
> > > 519304
> > >
> > > Attempting to write beyond the ceiling value of 16MB
> > > $echo 17194304 > /proc/sys/kernel/core_file_note_size_max
> > > bash: echo: write error: Invalid argument
> > >
> > > Why is this being done?
> > > We have observed that during a crash when there are more than 65k mmaps
> > > in memory, the existing fixed limit on the size of the ELF notes section
> > > becomes a bottleneck. The notes section quickly reaches its capacity,
> > > leading to incomplete memory segment information in the resulting coredump.
> > > This truncation compromises the utility of the coredumps, as crucial
> > > information about the memory state at the time of the crash might be
> > > omitted.
> >
> > I'd make this the first paragraph of the commit log. "We have this
> > problem" goes first, then "Here's what we did to deal with it", then you
> > examples. :)
> >
>  Done.
>
> > >
> > > Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> > > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > >
> > > ---
> > > Chagnes in v3:
> > >    - Fix commit message to reflect the correct sysctl knob [Kees]
> > >    - Add a ceiling for maximum pssible note size(16M) [Allen]
> > >    - Add a pr_warn_once() [Kees]
> > > Changes in v2:
> > >    - Move new sysctl to fs/coredump.c [Luis & Kees]
> > >    - rename max_file_note_size to core_file_note_size_max [kees]
> > >    - Capture "why this is being done?" int he commit message [Luis & Kees]
> > > ---
> > >  fs/binfmt_elf.c          |  8 ++++++--
> > >  fs/coredump.c            | 15 +++++++++++++++
> > >  include/linux/coredump.h |  1 +
> > >  3 files changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index 5397b552fbeb..5294f8f3a9a8 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
> > >       fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
> > >  }
> > >
> > > -#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> > >  /*
> > >   * Format of NT_FILE note:
> > >   *
> > > @@ -1592,8 +1591,13 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
> > >
> > >       names_ofs = (2 + 3 * count) * sizeof(data[0]);
> > >   alloc:
> > > -     if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> > > +     /* paranoia check */
> > > +     if (size >= core_file_note_size_max) {
> > > +             pr_warn_once("coredump Note size too large: %u "
> > > +             "(does kernel.core_file_note_size_max sysctl need adjustment?)\n",
> >
> > The string can be on a single line (I think scripts/check_patch.pl will
> > warn about this, as well as the indentation of "size" below...
>
>  It does warn, but if I leave it as a single line, there's still a warning:
> WARNING: line length of 135 exceeds 100 columns, which is why I
> split it into multiple lines.
>
> >
> > > +             size);
> > >               return -EINVAL;
> > > +     }
> > >       size = round_up(size, PAGE_SIZE);
> > >       /*
> > >        * "size" can be 0 here legitimately.
> > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > index be6403b4b14b..ffaed8c1b3b0 100644
> > > --- a/fs/coredump.c
> > > +++ b/fs/coredump.c
> > > @@ -56,10 +56,16 @@
> > >  static bool dump_vma_snapshot(struct coredump_params *cprm);
> > >  static void free_vma_snapshot(struct coredump_params *cprm);
> > >
> > > +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> > > +/* Define a reasonable max cap */
> > > +#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024)
> >
> > Let's call this CORE_FILE_NOTE_SIZE_DEFAULT and
> > CORE_FILE_NOTE_SIZE_MAX to match the sysctl.
> >
>
>  Sure, will update it in v4.
>
> > > +
> > >  static int core_uses_pid;
> > >  static unsigned int core_pipe_limit;
> > >  static char core_pattern[CORENAME_MAX_SIZE] = "core";
> > >  static int core_name_size = CORENAME_MAX_SIZE;
> > > +unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;
> > > +unsigned int core_file_note_size_allowed = MAX_ALLOWED_NOTE_SIZE;
> >
> > The latter can be static and const.
> >
> > For the note below, perhaps add:
> >
> > static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
> >
>
>  core_file_note_size_min will be used in fs/binfmt_elf.c at:
>
>     if (size >= core_file_note_size_min) ,
> did you mean
> static const unsigned int core_file_note_size_allowed =
> CORE_FILE_NOTE_SIZE_MAX;??
> > >

Kees,

 My bad, I misunderstood what you asked for. Here is the final diff,
if it looks fine,
i can send out a v4.

Note, there is a warning issued by checkpatch.pl (WARNING: line length
of 134 exceeds 100 columns)
for the pr_warn_once() and adding const trigger a build
warning(warning: initialization discards
 'const' qualifier from pointer target type), which is why i dropped it.

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..19bd85d1e42e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote
*note, user_siginfo_t *csigdata,
        fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
 }

-#define MAX_FILE_NOTE_SIZE (4*1024*1024)
 /*
  * Format of NT_FILE note:
  *
@@ -1592,8 +1591,11 @@ static int fill_files_note(struct memelfnote
*note, struct coredump_params *cprm

        names_ofs = (2 + 3 * count) * sizeof(data[0]);
  alloc:
-       if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
+       /* paranoia check */
+       if (size >= core_file_note_size_allowed) {
+               pr_warn_once("coredump Note size too large: %u (does
kernel.core_file_note_size_min sysctl need adjustment?\n", size);
                return -EINVAL;
+       }
        size = round_up(size, PAGE_SIZE);
        /*
         * "size" can be 0 here legitimately.
diff --git a/fs/coredump.c b/fs/coredump.c
index be6403b4b14b..69085bb494dc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -56,10 +56,16 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);

+#define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
+/* Define a reasonable max cap */
+#define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
+static unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
+unsigned int core_file_note_size_allowed = CORE_FILE_NOTE_SIZE_MAX;

 struct core_name {
        char *corename;
@@ -1020,6 +1026,15 @@ static struct ctl_table coredump_sysctls[] = {
                .mode           = 0644,
                .proc_handler   = proc_dointvec,
        },
+       {
+               .procname       = "core_file_note_size_min",
+               .data           = &core_file_note_size_min,
+               .maxlen         = sizeof(unsigned int),
+               .mode           = 0644,
+               .proc_handler   = proc_douintvec_minmax,
+               .extra1         = &core_file_note_size_min,
+               .extra2         = &core_file_note_size_allowed,
+       },
 };

 static int __init init_fs_coredump_sysctls(void)
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d3eba4360150..776bde5f9752 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -46,6 +46,7 @@ static inline void do_coredump(const
kernel_siginfo_t *siginfo) {}
 #endif

 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
+extern unsigned int core_file_note_size_allowed;
 extern void validate_coredump_safety(void);
 #else
 static inline void validate_coredump_safety(void) {}


Thanks,
Allen
> > >  struct core_name {
> > >       char *corename;
> > > @@ -1020,6 +1026,15 @@ static struct ctl_table coredump_sysctls[] = {
> > >               .mode           = 0644,
> > >               .proc_handler   = proc_dointvec,
> > >       },
> > > +     {
> > > +             .procname       = "core_file_note_size_max",
> > > +             .data           = &core_file_note_size_max,
> > > +             .maxlen         = sizeof(unsigned int),
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_douintvec_minmax,
> > > +             .extra1         = &core_file_note_size_max,
> >
> > This means you can never shrink it if you raise it from the default.
> > Let's use the core_file_note_size_min above.
>
> Sure, will fix it in v4.
> >
> > > +             .extra2         = &core_file_note_size_allowed,
> > > +     },
> > >  };
> > >
> > >  static int __init init_fs_coredump_sysctls(void)
> > > diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> > > index d3eba4360150..14c057643e7f 100644
> > > --- a/include/linux/coredump.h
> > > +++ b/include/linux/coredump.h
> > > @@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
> > >  #endif
> > >
> > >  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> > > +extern unsigned int core_file_note_size_max;
> > >  extern void validate_coredump_safety(void);
> > >  #else
> > >  static inline void validate_coredump_safety(void) {}
> > > --
> > > 2.17.1
> > >
> >
> > I think v4 will be all good to go, assuming no one else pops up. :)
> > Thanks for the changes!
>
> Thank you for the reviews. Will send out v4 soon.
>
> --
>        - Allen



-- 
       - Allen

