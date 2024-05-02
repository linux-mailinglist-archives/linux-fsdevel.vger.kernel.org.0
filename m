Return-Path: <linux-fsdevel+bounces-18537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD88BA374
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351321F24D4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD71BDCD;
	Thu,  2 May 2024 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4lPAkip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A251BC43
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690052; cv=none; b=RWUbw1ythSRblEvxdCbeldtms0lvj0nDeZo30StJsYQykT3OLqGV2GolzehmPne/WpTyg8wv0OHlC1MFusuJ0JJSA+lb6ol1Q/CWQib9WEotXY3itqlDstfv3lvpCpyvmvhKf3Jwae3GD2I0/Dvy7tDu784zkn5hsNaz4rfru08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690052; c=relaxed/simple;
	bh=MJJwatBneGbQvS95q/E5NzUx6xQig2VQFamIP+L0rYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBB9OswHRHXZU+1Gm/VV11w8E/TuAGqGxnbVhAo0/pv9DUaPd10n3UlGZ9uE6/rDnk1dmgZIX+NNIKM0JKmPaETJOR4QiBzPwIofFy8XWfT4l+luUWBSdfYbCaxw5x4LT3LehLJmo2l1J0EYmNEI0anEYBBzq2UMiLjtbh3G04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f4lPAkip; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b338460546so1525175a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690050; x=1715294850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qMDOwJlnqLjVTDrfPZW0Iu5hD97JbrHipMX/GW9VxEA=;
        b=f4lPAkipX7Zl8HmkSUo+rCCW+DmlqFijmXA7Szam4DSgcSdmfXXogieOTh+tAguefj
         auTsyDVjZlAAAp0CeHZ/s8tpuTupXqnxGHw7f906yCXDLaHsgN1jbOX+xHPu6wGcNYrW
         z9hkrVMbBBXhiSoGRbnrKIFafD+84wb2kAdvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690050; x=1715294850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMDOwJlnqLjVTDrfPZW0Iu5hD97JbrHipMX/GW9VxEA=;
        b=ZYyAQg4inbS1E69XbfeR7/wPDietzLiI/89WEX7hQ7z/za4ZBzjT565p+QkNxnmW3K
         MYSzzfAlwlaFiDp4XoCliYVkQHWlPYuC56bNgy0dXM/wh9XmfMF1r6oo/X54u/ZOUDsl
         WBcHe9XZcIbrVeVEMzqrbQCfF/8/gK3wcvbc+0H05OUY1rkcbTkQ21CkEc0l9lATmnsD
         lnz4/NtkrT+fCPrI9duPBisl79B4ivhUS33YPOSv2MQLClvpTZLOCMxbohrW32CUlh7P
         4N/kthfqDZq4M6iY03OaFTizzpq2XLDHgZZmR3zAGqNeJGpOom4bb1pQy3sEHqdA4scK
         Tgag==
X-Forwarded-Encrypted: i=1; AJvYcCWK5DgH9KNHqfoIb09JMjdZEzszn4ij7ydzST7bxHNXCeipsTChtBR9173uTEk+1W/J0Wqk5vPyc0qtnF5mJMhhDRPjoQxyeju5U6SNfQ==
X-Gm-Message-State: AOJu0YxOElTbXHPkeLR8KMMPvjog1q3/th2gidM6PWwI2130PolWLKws
	mx0hLSJTOWP2QjJlRQzzOxNEp75pqjM3gcqclPxoL3aOhvmmkIf6um4nYZvk4eGEP+3fQUk46dE
	=
X-Google-Smtp-Source: AGHT+IHD0FBpS56EdsfC3+XKdOjNxpAQUA2NXZ5FFtInn2XZKWCGioJvIGY86CTQK3kPpRVrkEePfg==
X-Received: by 2002:a17:90b:149:b0:2b3:70d4:15fb with SMTP id em9-20020a17090b014900b002b370d415fbmr1053056pjb.24.1714690049899;
        Thu, 02 May 2024 15:47:29 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001e446490072sm1905831plb.25.2024.05.02.15.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:47:29 -0700 (PDT)
Date: Thu, 2 May 2024 15:47:28 -0700
From: Kees Cook <keescook@chromium.org>
To: Allen <allen.lkml@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, mcgrof@kernel.org, j.granados@samsung.com
Subject: Re: [PATCH v2] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405021545.4A3ACDED0@keescook>
References: <20240502145920.5011-1-apais@linux.microsoft.com>
 <202405021045.360F5313EA@keescook>
 <CAOMdWSJzXiqB5tusdKaavJFTaKC-qyArT0ssRHVY-fvZVKJW+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMdWSJzXiqB5tusdKaavJFTaKC-qyArT0ssRHVY-fvZVKJW+Q@mail.gmail.com>

On Thu, May 02, 2024 at 01:03:52PM -0700, Allen wrote:
> On Thu, May 2, 2024 at 10:50 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, May 02, 2024 at 02:59:20PM +0000, Allen Pais wrote:
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
> > >
> > > $ sysctl -a | grep max_file_note_size
> > > kernel.max_file_note_size = 4194304
> > >
> > > $ sysctl -n kernel.max_file_note_size
> > > 4194304
> > >
> > > $echo 519304 > /proc/sys/kernel/max_file_note_size
> > >
> > > $sysctl -n kernel.max_file_note_size
> > > 519304
> >
> > The names and paths in the commit log need a refresh here, since they've
> > changed.
> 
> Will fix it in v3.
> >
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
> > Thanks for adding this!
> >
> > >
> > > Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> > > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > >
> > > ---
> > > Changes in v2:
> > >    - Move new sysctl to fs/coredump.c [Luis & Kees]
> > >    - rename max_file_note_size to core_file_note_size_max [kees]
> > >    - Capture "why this is being done?" int he commit message [Luis & Kees]
> > > ---
> > >  fs/binfmt_elf.c          |  3 +--
> > >  fs/coredump.c            | 10 ++++++++++
> > >  include/linux/coredump.h |  1 +
> > >  3 files changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index 5397b552fbeb..6aebd062b92b 100644
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
> > > @@ -1592,7 +1591,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
> > >
> > >       names_ofs = (2 + 3 * count) * sizeof(data[0]);
> > >   alloc:
> > > -     if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
> > > +     if (size >= core_file_note_size_max) /* paranoia check */
> > >               return -EINVAL;
> >
> > I wonder, given the purpose of this sysctl, if it would be a
> > discoverability improvement to include a pr_warn_once() before the
> > EINVAL? Like:
> >
> >         /* paranoia check */
> >         if (size >= core_file_note_size_max) {
> >                 pr_warn_once("coredump Note size too large: %zu (does kernel.core_file_note_size_max sysctl need adjustment?\n", size);
> >                 return -EINVAL;
> >         }
> >
> > What do folks think? (I can't imagine tracking down this problem
> > originally was much fun, for example.)
> 
>  I think this would really be helpful. I will go ahead and add this if
> there's no objection from anyone.
> 
> Also, I haven't received a reply from Luis, do you think we need to
> add a ceiling?
> 
> +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> +#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024) // Define a reasonable max cap
> .....
> 
> +       {
> +               .procname       = "core_file_note_size_max",
> +               .data           = &core_file_note_size_max,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_core_file_note_size_max,
> +       },
>  };
> 
> +int proc_core_file_note_size_max(struct ctl_table *table, int write,
> void __user *buffer, size_t *lenp, loff_t *ppos) {
> +    int error = proc_douintvec(table, write, buffer, lenp, ppos);
> +    if (write && (core_file_note_size_max < MAX_FILE_NOTE_SIZE ||
> core_file_note_size_max > MAX_ALLOWED_NOTE_SIZE))
> +        core_file_note_size_max = MAX_FILE_NOTE_SIZE;  // Revert to
> default if out of bounds
> +    return error;
> +}
> 
> 
> Or, should we go ahead with the current patch(with the warning added)?

Let's add a ceiling just to avoid really pathological behavior. We got
this far with 4M, so having a new ceiling seems reasonable. And for
implementing it, see proc_douintvec_minmax.

-Kees

-- 
Kees Cook

