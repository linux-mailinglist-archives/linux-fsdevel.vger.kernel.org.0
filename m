Return-Path: <linux-fsdevel+bounces-18519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1010A8BA14A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA537284524
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA481802DF;
	Thu,  2 May 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJDfhZTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4EB17334F;
	Thu,  2 May 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680245; cv=none; b=hMsbxG/rPDI679xQgvRprra0u7e7NolF3+TKKuK7v2hlbsdoWSChBqqrryABIS2j80uzSe9c+D//L36IGp3koRlLPQROF9xmzWS9JgmALjIeGZ/M+jQWMejrrD0J8xZP5W4XzrEePbzOs9MHIijKHPwUfaX13urWpDuorKmdmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680245; c=relaxed/simple;
	bh=2LiKalV3e3RB3t5fnoOKuv4rLHFNP1OOukxWuZYYBOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLWRoS2NSXBC2/XL1ITbP5OHwXaVRQzwr90Fr6HXDo+MlrLxEfo9VWh0Td+oPHEKYCPtRF6HBjTYSrEN/JyaD5tWG0GY+Na0GoO6JdM0L17I6VKm6kqt38+hJN8r9fwKRKlLLVQgVscLNwNfXjHLOUtSMiK2Ya1P+QO4ZEXUzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJDfhZTE; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c7498041cfso4786542b6e.2;
        Thu, 02 May 2024 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680243; x=1715285043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjQQjpH8NhWGNJDJapsehrY5QM3o3eHZRU+UWPn4Acs=;
        b=dJDfhZTECwq55zkaNtZkQ81Qo6K62oiWkLQqSadoZj14P2pWG29mYraHhBME9UOIv7
         eRbjaTuIUGOk7/Qneb4hyLINkjAlp/hU1l7zWRXMvOG7FztKRGlUcDgKYV+gIRgQYHsK
         jJaXZ3Ze3nLSuVcpsWUJ/2LDrn2dfm192ddcZB2xF5mGP9ivq5D34ZXX9BzwkCnhAPpb
         Jv840TgT68Mp87XB0MMehqMiBOCH/wH0mwR2qNXKjGy3SnI0mDxcTbNmquMfm7x+TA0w
         G6tzvt3KmeiuOFYJnEDgqoN2jvS06anXBLgyOWVWEFE3FUy8pSyU5rQMGQp5TGsZ9m5J
         TLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680243; x=1715285043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjQQjpH8NhWGNJDJapsehrY5QM3o3eHZRU+UWPn4Acs=;
        b=n0JuYhHBqDAhBzfGPrHgyaB/rOG775QO+L3VqOldszLrCdpzWfoSaGT6pDMUmsjXqq
         H8D56L0vkU/Lb7ixZSLYaXrUe0ncfszlFzpptdsM6gC9EzHAQYA567dyHR4YjD00MHt7
         S0mkVQp0d2JJXSa8OXfr7OYijhJkoyOKJ0yUZ1Juw5dCZ9pVQWcioF4GO9JH27TRxEQm
         2QVcVqVegKYQnO5WHFx9T1aExuOPqiswpcCquUWASfdcfpnb+5vZWioKI2x8koMR8k3C
         tpe/E2Ld9bQZuhKKc5TYNm4bAj6UPFu+kn94Y4ZDKQ+dJFm6zUbVDeVH8dSyyHjmThiB
         3MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDOmNnv5EK75yM9GFoolPftGLOaLTKvz+TwKtQqV1VKY4hq1WorjWCAggGn8YbkP7iEnsNAGYLqejBM12pzGynowTEcyoNvdx7LY+FlLJz5AmJV/2ipQx51PFUlOiddK28zvgQrNTYRqe57A==
X-Gm-Message-State: AOJu0YxGXcOvVoEPqoEVd4kgz8vGmovnOfm4+I3eTV0m3zNCAc8ZuoZ5
	TZU3QlJSknI8mFGvpdN3MYhYgWQKhPVJF17Mx/1h2GbEdHrypxucotiHeV+anCS2dh1rFCzCHD2
	MvlaaFlnEvcOHnTjgsbAeJQoHulRw+T2f
X-Google-Smtp-Source: AGHT+IF5LRau2j9XR/7D0bXq9AYjJs5NDRapLGLlplnxUEZH7AF5vTaffEWNENripCd5tT/bMf3GYCkhnbdiAwDX+Ek=
X-Received: by 2002:a05:6808:1898:b0:3c8:7599:d6a3 with SMTP id
 bi24-20020a056808189800b003c87599d6a3mr1174647oib.11.1714680243011; Thu, 02
 May 2024 13:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502145920.5011-1-apais@linux.microsoft.com> <202405021045.360F5313EA@keescook>
In-Reply-To: <202405021045.360F5313EA@keescook>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 2 May 2024 13:03:52 -0700
Message-ID: <CAOMdWSJzXiqB5tusdKaavJFTaKC-qyArT0ssRHVY-fvZVKJW+Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs/coredump: Enable dynamic configuration of max file
 note size
To: Kees Cook <keescook@chromium.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org, 
	j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:50=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, May 02, 2024 at 02:59:20PM +0000, Allen Pais wrote:
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
> >
> > $ sysctl -a | grep max_file_note_size
> > kernel.max_file_note_size =3D 4194304
> >
> > $ sysctl -n kernel.max_file_note_size
> > 4194304
> >
> > $echo 519304 > /proc/sys/kernel/max_file_note_size
> >
> > $sysctl -n kernel.max_file_note_size
> > 519304
>
> The names and paths in the commit log need a refresh here, since they've
> changed.

Will fix it in v3.
>
> >
> > Why is this being done?
> > We have observed that during a crash when there are more than 65k mmaps
> > in memory, the existing fixed limit on the size of the ELF notes sectio=
n
> > becomes a bottleneck. The notes section quickly reaches its capacity,
> > leading to incomplete memory segment information in the resulting cored=
ump.
> > This truncation compromises the utility of the coredumps, as crucial
> > information about the memory state at the time of the crash might be
> > omitted.
>
> Thanks for adding this!
>
> >
> > Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> >
> > ---
> > Changes in v2:
> >    - Move new sysctl to fs/coredump.c [Luis & Kees]
> >    - rename max_file_note_size to core_file_note_size_max [kees]
> >    - Capture "why this is being done?" int he commit message [Luis & Ke=
es]
> > ---
> >  fs/binfmt_elf.c          |  3 +--
> >  fs/coredump.c            | 10 ++++++++++
> >  include/linux/coredump.h |  1 +
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 5397b552fbeb..6aebd062b92b 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *=
note, user_siginfo_t *csigdata,
> >       fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
> >  }
> >
> > -#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> >  /*
> >   * Format of NT_FILE note:
> >   *
> > @@ -1592,7 +1591,7 @@ static int fill_files_note(struct memelfnote *not=
e, struct coredump_params *cprm
> >
> >       names_ofs =3D (2 + 3 * count) * sizeof(data[0]);
> >   alloc:
> > -     if (size >=3D MAX_FILE_NOTE_SIZE) /* paranoia check */
> > +     if (size >=3D core_file_note_size_max) /* paranoia check */
> >               return -EINVAL;
>
> I wonder, given the purpose of this sysctl, if it would be a
> discoverability improvement to include a pr_warn_once() before the
> EINVAL? Like:
>
>         /* paranoia check */
>         if (size >=3D core_file_note_size_max) {
>                 pr_warn_once("coredump Note size too large: %zu (does ker=
nel.core_file_note_size_max sysctl need adjustment?\n", size);
>                 return -EINVAL;
>         }
>
> What do folks think? (I can't imagine tracking down this problem
> originally was much fun, for example.)

 I think this would really be helpful. I will go ahead and add this if
there's no objection from anyone.

Also, I haven't received a reply from Luis, do you think we need to
add a ceiling?

+#define MAX_FILE_NOTE_SIZE (4*1024*1024)
+#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024) // Define a reasonable max ca=
p
.....

+       {
+               .procname       =3D "core_file_note_size_max",
+               .data           =3D &core_file_note_size_max,
+               .maxlen         =3D sizeof(unsigned int),
+               .mode           =3D 0644,
+               .proc_handler   =3D proc_core_file_note_size_max,
+       },
 };

+int proc_core_file_note_size_max(struct ctl_table *table, int write,
void __user *buffer, size_t *lenp, loff_t *ppos) {
+    int error =3D proc_douintvec(table, write, buffer, lenp, ppos);
+    if (write && (core_file_note_size_max < MAX_FILE_NOTE_SIZE ||
core_file_note_size_max > MAX_ALLOWED_NOTE_SIZE))
+        core_file_note_size_max =3D MAX_FILE_NOTE_SIZE;  // Revert to
default if out of bounds
+    return error;
+}


Or, should we go ahead with the current patch(with the warning added)?

Thanks,
Allen
>
> >       size =3D round_up(size, PAGE_SIZE);
> >       /*
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index be6403b4b14b..a312be48030f 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -56,10 +56,13 @@
> >  static bool dump_vma_snapshot(struct coredump_params *cprm);
> >  static void free_vma_snapshot(struct coredump_params *cprm);
> >
> > +#define MAX_FILE_NOTE_SIZE (4*1024*1024)
> > +
> >  static int core_uses_pid;
> >  static unsigned int core_pipe_limit;
> >  static char core_pattern[CORENAME_MAX_SIZE] =3D "core";
> >  static int core_name_size =3D CORENAME_MAX_SIZE;
> > +unsigned int core_file_note_size_max =3D MAX_FILE_NOTE_SIZE;
> >
> >  struct core_name {
> >       char *corename;
> > @@ -1020,6 +1023,13 @@ static struct ctl_table coredump_sysctls[] =3D {
> >               .mode           =3D 0644,
> >               .proc_handler   =3D proc_dointvec,
> >       },
> > +     {
> > +             .procname       =3D "core_file_note_size_max",
> > +             .data           =3D &core_file_note_size_max,
> > +             .maxlen         =3D sizeof(unsigned int),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_douintvec,
> > +     },
> >  };
> >
> >  static int __init init_fs_coredump_sysctls(void)
> > diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> > index d3eba4360150..14c057643e7f 100644
> > --- a/include/linux/coredump.h
> > +++ b/include/linux/coredump.h
> > @@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t=
 *siginfo) {}
> >  #endif
> >
> >  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> > +extern unsigned int core_file_note_size_max;
> >  extern void validate_coredump_safety(void);
> >  #else
> >  static inline void validate_coredump_safety(void) {}
> > --
> > 2.17.1
>
> Otherwise, yes, this looks good to me.
>
> --
> Kees Cook



--=20
       - Allen

