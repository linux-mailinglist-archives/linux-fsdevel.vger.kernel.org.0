Return-Path: <linux-fsdevel+bounces-18192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA028B65C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 00:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3377282D48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A813AEE;
	Mon, 29 Apr 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAjXYJdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6486364;
	Mon, 29 Apr 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429965; cv=none; b=vEvZa65q00ztYMoYKDvGQ7BO8TfjjwpRlIfmF0j8FmwmWbq3DHUT3ZYA+RNyWn9GKPIUO0wT/SFxxSmoIoUrayBwoc/Kwd5OhjWDdV28RFrbwPdQ9isxy6opgi+9XF7nZYSZ6YFt0e5PQSz9oBvju+Pqf0bLY1qev/GeNSUN1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429965; c=relaxed/simple;
	bh=p/iI16OA08IEgLyP0+r0CbUdvuIpdRO2lczb4WiYp4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQEcMd2yuFzEJzAP/Qa2/LJod+imooJ1Oi6nWo3eHjtctujRz9g8ebzy9mg1XKIvJZVGAh23KPuZNwgps3C84y/ifwVpqAUSnFnYLADOmnDk0r8Pkf2Edp7VBfiw8jnH+2vrYpan72iBRf/eR5q1Nxyzh5mB1h6K6EatuJHfk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAjXYJdu; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7ebe09eb289so1300028241.2;
        Mon, 29 Apr 2024 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714429962; x=1715034762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkJIofc7sCacjx+o3Bhnh3utDqU2SSgA8jzJYUliTOM=;
        b=XAjXYJduYgZKBtGSYmurzCotmI7c+0+GI0gFYdzLwWAkcmgP5AYwYNdsoXBgk6CU1a
         xB1EuTtMWI+0GRvgJactJyWvbIwR+5TM20H9Cb7IVzs712pGgCqNxEZTvDaqti4IZ2Sl
         VYFzovL8zA16AiQctftPOoSR4wMiumL38vTxHTl+9+1NTgatiIQYpRBXkZt98Z5S65Eq
         kvbRAZh1qSmDg7/5DPcL3LCuvF8SaCjAPRgAlP3OTxr6fL4dD3t+YuUU2FrX72My+V0V
         ABpyqcUTzIbNxl+gbWGfRZM2gP4fy2XMB5R9WWVLZdE18S6iYM6/en/OyZn9hLoVmNNs
         G4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429962; x=1715034762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkJIofc7sCacjx+o3Bhnh3utDqU2SSgA8jzJYUliTOM=;
        b=QOo8ykz4VofdtAWV8L9jI6SbOaMzVwKJLZHjM2Sx1bfeVmkimVY4k2eGKSi5lo22HB
         CH157YdMdja9H6L+omLO9KgwEIfGML1g60NbgYY3RgqnTiDF9lgZU4kBsbDfOY6geiIq
         zQxeSfL/tsIJ6luWBosWpnZwXIx+UPOxXaiDwjX0lv7sSZq9wCERVYf3YA0okxRl9hcm
         b6WIAE/0d/QBn5nnnyeUZaesZsVx/fKWWHtdvWaZxp0YKr68hA9Bg2UOhkFTdhyYrItb
         hND3EQFaxybqZXqwdrAz31ruZacDFB7TkzZ5Hb/dwk00xsLHCfyYsAGMRXfP+PZTGJpR
         9rcw==
X-Forwarded-Encrypted: i=1; AJvYcCUNrqlbxHH0r7Jj6aA58cJTki/OB0wDWdETjGCBAGgenu10JzykDeKmxQ+tekApRcOB6r7FkAJQ89jGR8Ra0dixku/U0WuAX3uzJJtr94sbn2AcnqOKIfp5Cx2nm9BgNchwaiuvcZr6T/eLcA==
X-Gm-Message-State: AOJu0Yye/Oajda61ntC5tXx5BFWB6nTnj8q/csSfcjwE7Vxs+ZfTf/Cn
	qcF+ewqkDKdft96JyRlenfhJFwKaam9JrgjFDStxtvAic5lRlggQ5svk0ynAAwa7J3vRmZ2l0YL
	hIhUEpeAW08eP46lvMhDtC/bbJAk=
X-Google-Smtp-Source: AGHT+IGKchtg51G2XH8ZwTYZxKRYw/SHqQw3ypfHaPs1T6l41y11+ZRLuYxdEw4Z+cOtExre4q50Kl3T+0HHClwvz3A=
X-Received: by 2002:a05:6122:2522:b0:4d8:7359:4c25 with SMTP id
 cl34-20020a056122252200b004d873594c25mr12797577vkb.12.1714429962449; Mon, 29
 Apr 2024 15:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429172128.4246-1-apais@linux.microsoft.com> <Zi_pNF0OMgKViIWe@bombadil.infradead.org>
In-Reply-To: <Zi_pNF0OMgKViIWe@bombadil.infradead.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 29 Apr 2024 15:32:31 -0700
Message-ID: <CAOMdWS+u3WkB5yiwTjNKOD1sMSQP-F22FSpkq0R8TCPhihp=2w@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/coredump: Enable dynamic configuration of max file
 note size
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, 
	keescook@chromium.org, j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:38=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Mon, Apr 29, 2024 at 05:21:28PM +0000, Allen Pais wrote:
> > Introduce the capability to dynamically configure the maximum file
> > note size for ELF core dumps via sysctl. This enhancement removes
> > the previous static limit of 4MB, allowing system administrators to
> > adjust the size based on system-specific requirements or constraints.
> >
> > - Remove hardcoded `MAX_FILE_NOTE_SIZE` from `fs/binfmt_elf.c`.
> > - Define `max_file_note_size` in `fs/coredump.c` with an initial value =
set to 4MB.
> > - Declare `max_file_note_size` as an external variable in `include/linu=
x/coredump.h`.
> > - Add a new sysctl entry in `kernel/sysctl.c` to manage this setting at=
 runtime.
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
> This doesn't highlight anything about *why*. So in practice you must've
> hit a use case where ELF notes are huge, can you give an example of
> that? The commit should also describe that this is only used in the path
> of a coredump on ELF binaries via elf_core_dump().
>

 Yes, I should have captured it. We have observed that during a crash
when there are more than 65k mmaps in memory, the existing fixed limit on t=
he
size of the ELF notes section becomes a bottleneck. The notes section quick=
ly
reaches its capacity, leading to incomplete memory segment information in t=
he
resulting coredump. This truncation compromises the utility of the coredump=
s,
as crucial information about the memory state at the time of the crash
might be omitted.

I will add the above to the commit message. Hope that addresses your concer=
n.

> More below.
>
> > Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > ---
> >  fs/binfmt_elf.c          | 3 +--
> >  fs/coredump.c            | 3 +++
> >  include/linux/coredump.h | 1 +
> >  kernel/sysctl.c          | 8 ++++++++
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 5397b552fbeb..5fc7baa9ebf2 100644
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
> > +     if (size >=3D max_file_note_size) /* paranoia check */
> >               return -EINVAL;
> >       size =3D round_up(size, PAGE_SIZE);
> >       /*
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index be6403b4b14b..a83c6cc893fc 100644
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
> > +unsigned int max_file_note_size =3D MAX_FILE_NOTE_SIZE;
> >
> >  struct core_name {
> >       char *corename;
> > diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> > index d3eba4360150..e1ae7ab33d76 100644
> > --- a/include/linux/coredump.h
> > +++ b/include/linux/coredump.h
> > @@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t=
 *siginfo) {}
> >  #endif
> >
> >  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> > +extern unsigned int max_file_note_size;
> >  extern void validate_coredump_safety(void);
> >  #else
> >  static inline void validate_coredump_safety(void) {}
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 81cc974913bb..80cdc37f2fa2 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -63,6 +63,7 @@
> >  #include <linux/mount.h>
> >  #include <linux/userfaultfd_k.h>
> >  #include <linux/pid.h>
> > +#include <linux/coredump.h>
> >
> >  #include "../lib/kstrtox.h"
> >
> > @@ -1623,6 +1624,13 @@ static struct ctl_table kern_table[] =3D {
> >               .mode           =3D 0644,
> >               .proc_handler   =3D proc_dointvec,
> >       },
> > +     {
> > +             .procname       =3D "max_file_note_size",
> > +             .data           =3D &max_file_note_size,
> > +             .maxlen         =3D sizeof(unsigned int),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec,
> > +     },
> >  #ifdef CONFIG_PROC_SYSCTL
>
> No, please move this to coredump_sysctls in fs/coredump.c. And there is
> no point in supporting int, this is unisgned int right? So use the right
> proc handler for it.
>

 Will address it in v2.

> If we're gonna do this, it makes sense to document the ELF note binary
> limiations. Then, consider a defense too, what if a specially crafted
> binary with a huge elf note are core dumped many times, what then?
> Lifting to 4 MiB puts in a situation where abuse can lead to many silly
> insane kvmalloc()s. Is that what we want? Why?
>
  You raise a good point. I need to see how we can safely handle this case.

Thanks,
Allen


>   Luis



--=20
       - Allen

