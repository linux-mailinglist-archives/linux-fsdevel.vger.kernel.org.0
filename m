Return-Path: <linux-fsdevel+bounces-18696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B18BB84A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 01:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724BA282A66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981984A56;
	Fri,  3 May 2024 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EXG0EkPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A083CD8
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779118; cv=none; b=Z6/ZVcaMr+TAiQfW3F57zJuEOl046me/sWCAyTF6Z2Sv25l8r1ndhvHP7DsLoSMHDmdS2zfG18pp7Sqzq6HcSdeR5ZNv2pzAPGuglYsOzpKmI05TS5XZiIt4WdMn8+sfqFC+ybKvH8czxXfzu5jK0eK9nSSIfs5MBED8liq8isI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779118; c=relaxed/simple;
	bh=0i9mRQ/BiMsppImo4u1dj4yZCL99lCiZ0S+gM+KJXt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajAsy+zSLRaUdWHcOQ5NNMgMYro7fVbzsqO3MODfbddKskNWlVBJe4RDug++l6D79Xsk1B7nQNsyM0j04frstmWjv6eZGn81qi2QBO+sxkyUK5lLhw3PEvlNtmrth9Z+/Hyyez02pP93GS6TTyj4J4ZI5dvwXhSJvTUHXLbeboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EXG0EkPK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso101980a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714779116; x=1715383916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQWkXaFuCvDccNEejO0sjEajyPVeed872Xyd5w++i9E=;
        b=EXG0EkPKnTCP2TBOsnOpxQcUl5Z56McU27JQ6DClYaJmQouVRIuGeojxdzpn19xM2y
         UMEXJK8x1IW6onRadQbW1ZdMIMEpKSP/UQW+gPeB1k17kGn3arrUr2HTEyVP967R7pxP
         hpvCgPWaxsmiCQbw3MuX0WwWhPl0rEZuQdht0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779116; x=1715383916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQWkXaFuCvDccNEejO0sjEajyPVeed872Xyd5w++i9E=;
        b=teRZynrc7P7TvExVCTcQ1cw74f4jZPgIu67fA0PrAaw/Z2xBc+x8F2LXkYDmCXmi7q
         Vv6zECRS/3fnRd/Y/t0YcZVaRgeQ96mpvcGh/0j83i2tXh3rI50toOD2ZOX90/DJ0ZP4
         PWazTcuJDMZnsC1st9KU2kwLv2xMz+HygYY3UTU4Q1cnc/gf6KeJ5ANJc9LldwhmSlT3
         YEtODgOUgYou5zELwg2Ef4bR/5XcT9x1PLrl4z2mVP3e+rmIiXNWsdaIWIYmqFCKQ+M0
         3QWcI+LF6nWfN/jAXVs/AQF1c8PgUssVEgMjXQAh0fWIQ12Ia7HXrenFinh62Jwy0seX
         UvXw==
X-Forwarded-Encrypted: i=1; AJvYcCWjndgpO0GEtsCzC3s8DFMbNU9o89VUEEElMZNABwXV3b2ZIYpTBOvFd1hH4Z4At0HQr6EsHJqToCGPeQn4FQIMiNOfJ3rs2Po4uXxmYA==
X-Gm-Message-State: AOJu0YzByAVi/oyx2qIur5nwA+IU4YwB7avPhKFicwng7HKgYQFuW/c8
	R7XSOm8HD9Kc0BE5DF6ur9CIiNpoRUJUpBgsUtP5LJ3SGJ7V6VXVoqi305PO8Q==
X-Google-Smtp-Source: AGHT+IF+MTBM20asd8P4jmLte2hDSW6ZEMf3snsAauJ6scuYiqSJW3M/akt8KGKIOSjQ8ZRPpzsPNw==
X-Received: by 2002:a17:90b:19c1:b0:2b1:535f:c3dc with SMTP id nm1-20020a17090b19c100b002b1535fc3dcmr4598762pjb.26.1714779116508;
        Fri, 03 May 2024 16:31:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm3667938pjo.49.2024.05.03.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:31:55 -0700 (PDT)
Date: Fri, 3 May 2024 16:31:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Allen <allen.lkml@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, mcgrof@kernel.org, j.granados@samsung.com
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405031629.D95BE0F@keescook>
References: <20240502235603.19290-1-apais@linux.microsoft.com>
 <202405021743.D06C96516@keescook>
 <CAOMdWSLa-dp34aq3RepQABpnGs-TnyQgUxFm--MHVHFuVYTgFg@mail.gmail.com>
 <CAOMdWSLh80OHx=som1WeK_L_=2LVK1rehXH88t3Ew--4dSE4ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSLh80OHx=som1WeK_L_=2LVK1rehXH88t3Ew--4dSE4ew@mail.gmail.com>

On Thu, May 02, 2024 at 06:40:58PM -0700, Allen wrote:
> > > > Introduce the capability to dynamically configure the maximum file
> > > > note size for ELF core dumps via sysctl. This enhancement removes
> > > > the previous static limit of 4MB, allowing system administrators to
> > > > adjust the size based on system-specific requirements or constraints.
> > > >
> > > > - Remove hardcoded `MAX_FILE_NOTE_SIZE` from `fs/binfmt_elf.c`.
> > > > - Define `max_file_note_size` in `fs/coredump.c` with an initial value
> > > >   set to 4MB.
> > > > - Declare `max_file_note_size` as an external variable in
> > > >   `include/linux/coredump.h`.
> > > > - Add a new sysctl entry in `kernel/sysctl.c` to manage this setting
> > > >   at runtime.
> > >
> > > The above bullet points should be clear from the patch itself. The
> > > commit is really more about rationale and examples (which you have
> > > below). I'd remove the bullets.
> >
> > Sure, I have it modified to:
> >
> > fs/coredump: Enable dynamic configuration of max file note size
> >
> >     Introduce the capability to dynamically configure the maximum file
> >     note size for ELF core dumps via sysctl.
> >
> >     Why is this being done?
> >     We have observed that during a crash when there are more than 65k mmaps
> >     in memory, the existing fixed limit on the size of the ELF notes section
> >     becomes a bottleneck. The notes section quickly reaches its capacity,
> >     leading to incomplete memory segment information in the resulting coredump.
> >     This truncation compromises the utility of the coredumps, as crucial
> >     information about the memory state at the time of the crash might be
> >     omitted.
> >
> >     This enhancement removes the previous static limit of 4MB, allowing
> >     system administrators to adjust the size based on system-specific
> >     requirements or constraints.
> >
> >     Eg:
> >     $ sysctl -a | grep core_file_note_size_max
> >     kernel.core_file_note_size_max = 4194304
> > .......
> > >
> > > >
> > > > $ sysctl -a | grep core_file_note_size_max
> > > > kernel.core_file_note_size_max = 4194304
> > > >
> > > > $ sysctl -n kernel.core_file_note_size_max
> > > > 4194304
> > > >
> > > > $echo 519304 > /proc/sys/kernel/core_file_note_size_max
> > > >
> > > > $sysctl -n kernel.core_file_note_size_max
> > > > 519304
> > > >
> > > > Attempting to write beyond the ceiling value of 16MB
> > > > $echo 17194304 > /proc/sys/kernel/core_file_note_size_max
> > > > bash: echo: write error: Invalid argument
> > > >
> > > > Why is this being done?
> > > > We have observed that during a crash when there are more than 65k mmaps
> > > > in memory, the existing fixed limit on the size of the ELF notes section
> > > > becomes a bottleneck. The notes section quickly reaches its capacity,
> > > > leading to incomplete memory segment information in the resulting coredump.
> > > > This truncation compromises the utility of the coredumps, as crucial
> > > > information about the memory state at the time of the crash might be
> > > > omitted.
> > >
> > > I'd make this the first paragraph of the commit log. "We have this
> > > problem" goes first, then "Here's what we did to deal with it", then you
> > > examples. :)
> > >
> >  Done.
> >
> > > >
> > > > Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> > > > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > > >
> > > > ---
> > > > Chagnes in v3:
> > > >    - Fix commit message to reflect the correct sysctl knob [Kees]
> > > >    - Add a ceiling for maximum pssible note size(16M) [Allen]
> > > >    - Add a pr_warn_once() [Kees]
> > > > Changes in v2:
> > > >    - Move new sysctl to fs/coredump.c [Luis & Kees]
> > > >    - rename max_file_note_size to core_file_note_size_max [kees]
> > > >    - Capture "why this is being done?" int he commit message [Luis & Kees]
> > > > ---
> > > >  fs/binfmt_elf.c          |  8 ++++++--
> > > >  fs/coredump.c            | 15 +++++++++++++++
> > > >  include/linux/coredump.h |  1 +
> > > >  3 files changed, 22 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > > index 5397b552fbeb..5294f8f3a9a8 100644
> > > > --- a/fs/binfmt_elf.c
> > > > +++ b/fs/binfmt_elf.c
> > > > @@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
> > > >       fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
> > > >  }
> > > >
> > > > -#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> > > >  /*
> > > >   * Format of NT_FILE note:
> > > >   *
> > > > @@ -1592,8 +1591,13 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
> > > >
> > > >       names_ofs = (2 + 3 * count) * sizeof(data[0]);
> > > >   alloc:
> > > > -     if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> > > > +     /* paranoia check */
> > > > +     if (size >= core_file_note_size_max) {
> > > > +             pr_warn_once("coredump Note size too large: %u "
> > > > +             "(does kernel.core_file_note_size_max sysctl need adjustment?)\n",
> > >
> > > The string can be on a single line (I think scripts/check_patch.pl will
> > > warn about this, as well as the indentation of "size" below...
> >
> >  It does warn, but if I leave it as a single line, there's still a warning:
> > WARNING: line length of 135 exceeds 100 columns, which is why I
> > split it into multiple lines.
> >
> > >
> > > > +             size);
> > > >               return -EINVAL;
> > > > +     }
> > > >       size = round_up(size, PAGE_SIZE);
> > > >       /*
> > > >        * "size" can be 0 here legitimately.
> > > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > > index be6403b4b14b..ffaed8c1b3b0 100644
> > > > --- a/fs/coredump.c
> > > > +++ b/fs/coredump.c
> > > > @@ -56,10 +56,16 @@
> > > >  static bool dump_vma_snapshot(struct coredump_params *cprm);
> > > >  static void free_vma_snapshot(struct coredump_params *cprm);
> > > >
> > > > +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> > > > +/* Define a reasonable max cap */
> > > > +#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024)
> > >
> > > Let's call this CORE_FILE_NOTE_SIZE_DEFAULT and
> > > CORE_FILE_NOTE_SIZE_MAX to match the sysctl.
> > >
> >
> >  Sure, will update it in v4.
> >
> > > > +
> > > >  static int core_uses_pid;
> > > >  static unsigned int core_pipe_limit;
> > > >  static char core_pattern[CORENAME_MAX_SIZE] = "core";
> > > >  static int core_name_size = CORENAME_MAX_SIZE;
> > > > +unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;
> > > > +unsigned int core_file_note_size_allowed = MAX_ALLOWED_NOTE_SIZE;
> > >
> > > The latter can be static and const.
> > >
> > > For the note below, perhaps add:
> > >
> > > static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
> > >
> >
> >  core_file_note_size_min will be used in fs/binfmt_elf.c at:
> >
> >     if (size >= core_file_note_size_min) ,
> > did you mean
> > static const unsigned int core_file_note_size_allowed =
> > CORE_FILE_NOTE_SIZE_MAX;??
> > > >
> 
> Kees,
> 
>  My bad, I misunderstood what you asked for. Here is the final diff,
> if it looks fine,
> i can send out a v4.
> 
> Note, there is a warning issued by checkpatch.pl (WARNING: line length
> of 134 exceeds 100 columns)

For strings that should be fine. You'll want the ", size);" part on the
next line though.

> for the pr_warn_once() and adding const trigger a build
> warning(warning: initialization discards
>  'const' qualifier from pointer target type), which is why i dropped it.

Yeah, that's a common pattern for sysctl. You can fix it with a cast.
For example:

static const unsigned long      nlm_grace_period_min = 0;
static const unsigned long      nlm_grace_period_max = 240;
...
                .proc_handler   = proc_doulongvec_minmax,
                .extra1         = (unsigned long *) &nlm_grace_period_min,
                .extra2         = (unsigned long *) &nlm_grace_period_max,


But yeah, looks good.

-- 
Kees Cook

