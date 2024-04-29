Return-Path: <linux-fsdevel+bounces-18193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5B8B65C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 00:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3AD1F22712
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311E179AF;
	Mon, 29 Apr 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtVEjwaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D0364;
	Mon, 29 Apr 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430114; cv=none; b=PD3u/vKMn9GDEhMfIEovHCEWWETJQDjiBtx4yZkCzpoUsejT9wbOy3r6U3JG+2rnsng22mogV+AnRTL/K0NfdoHLBr1Q7UTfLHlI/u0/q61hrzA94lLOjO+NLIv2Hsz4SWMXMjLPM1DAXLATwa6SrBDNGjLfrvy5NI7WKT651s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430114; c=relaxed/simple;
	bh=uJHbZ7vipqgiXJox3wk/pO0u4N91l9xJKUv2D8Ybkcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICFSdJheeEVQz+sglGIsMYM+7GHw+SPcyaJ88KOwnqpWdrbRizSnb1WKLHYL2J4eZqxROa1ENMsCTeEWvK4+yixDzzcGqNV/W1cki4RYRDiUrhBx+FMVjFiNhfqsqBmTrGU4E9Od+RX6Ju1jdGgLH32btJ9K3c+c4H8JdxLHh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtVEjwaF; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4dceafca40bso1167978e0c.3;
        Mon, 29 Apr 2024 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714430112; x=1715034912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giNP6mUJZHfDuRo+cIvLi3ag8NuQrcBWgEzhMToaOic=;
        b=PtVEjwaFSkR6E9yj32LgzEQ1RvQ/nCQZiFiqh+JT5jRQeVuCbv8VUJPv4TVx8Ps3AA
         4Aqk2lPiee6PLNbYrf1nBMU0iL7MzXyF9l5JCTuoAN/iHtgp3MBITq8NeQVaym3fS9zN
         DjMGGZnWF3mtzU6gzlu2HV06xoNYDOvMtlCfdUVXzLXKZf6tUm/37XDvOLpc5w8yWXTb
         0owli3PVpZca7N+rDDXhIHjz9Ev61K7ZQ7iVWTYTritX7Ap6p4LDIVLjSyyF8Et1t7Xz
         gd86spAPKTFm/hVOkARBYAetXZ1bjOjid8kQFn/teZ5sPajzJWUCtD9t26gDQBO0XUWz
         r+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714430112; x=1715034912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giNP6mUJZHfDuRo+cIvLi3ag8NuQrcBWgEzhMToaOic=;
        b=TI1aWhpI2UaM1gfKvDdGvOyb2WTWE8Oyt2le++HOewd6jDCTyfzKYpmSiWkhLuUgWf
         pDLrugtDRtQra9cFGAOm7i+211v50Jwbd2g5TYWrlK6L68jI7W3pjJE0atGFcfm9K8FX
         mhEn8sPoUM0f0mO7yaaidQXzphMfQNbyK5dbpGz2R5yELRFYmv9R6NGWQzYNoxOm1D9O
         MPlUOIX9hUTldVzp04Qt3SHRx45VFoFa301dvIHLtC0waAe+gwtNI9kAT7XpekhuP4cq
         rsqDHZXcqWX2fgfM+S3T40BajFz+SuUXli3ThvQFc86vnJJ1q9N8kTHDVzvNmn7uwptA
         b23g==
X-Forwarded-Encrypted: i=1; AJvYcCUwteOPeITBdPEEA/9UlC/aVClxZw+rey30HkYpjjorVX2WOgPy7lWDIcTvxtN1r2kUUQ7A89G+H8RfoE+HkMu4DTjaSjghs+151USApyNh3RYw7PMp97b9W8M0sBCL+oRnZ54CZ5uHB5H3lA==
X-Gm-Message-State: AOJu0Yzu7ZWHhpuIdNIm+XDT6h9xRQ5yXhz9jhumsopiQ+l3eF9NruiS
	CS0OpCqxU0ORwLQzFBG+9nt5yX5KKvjvqIRiUSt3Z/SBWYw5XQB/w3FHSIfkzZdMpKDycj/72Qg
	mAsDoNVbwu0Nsdy5PJQCZRLeIBwM=
X-Google-Smtp-Source: AGHT+IGa/i0nN98GS2VsTjzVAvr2RQG96odo51ftlshRyGhUf4qNiggjj+2ZkACUlKbkr16pF6t6A2UJFj4H8SmmVeo=
X-Received: by 2002:a05:6122:1695:b0:4d4:2931:7d4d with SMTP id
 21-20020a056122169500b004d429317d4dmr12138191vkl.5.1714430111799; Mon, 29 Apr
 2024 15:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429172128.4246-1-apais@linux.microsoft.com> <202404291245.18281A6D@keescook>
In-Reply-To: <202404291245.18281A6D@keescook>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 29 Apr 2024 15:35:01 -0700
Message-ID: <CAOMdWS+k63T9TQ=Zvev-+Q3Zw-wuEUv_f63=YiTx0nK1J9Jfwg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/coredump: Enable dynamic configuration of max file
 note size
To: Kees Cook <keescook@chromium.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org, 
	j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:49=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Mon, Apr 29, 2024 at 05:21:28PM +0000, Allen Pais wrote:
> > Introduce the capability to dynamically configure the maximum file
> > note size for ELF core dumps via sysctl. This enhancement removes
> > the previous static limit of 4MB, allowing system administrators to
> > adjust the size based on system-specific requirements or constraints.
>
> Under what conditions is this actually needed?

 I addressed this in the email I sent out before this.

>
> > [...]
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
>
> Please don't add new sysctls to kernel/sysctl.c. Put this in fs/coredump.=
c
> instead, and name it "core_file_note_size_max". (A "max" suffix is more
> common than prefixes, and I'd like it clarified that it relates to the
> coredumper with the "core" prefix that match the other coredump sysctls.
>
> -Kees

Makes sense. Let me know if the below looks fine,

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..6aebd062b92b 100644
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
@@ -1592,7 +1591,7 @@ static int fill_files_note(struct memelfnote
*note, struct coredump_params *cprm

        names_ofs =3D (2 + 3 * count) * sizeof(data[0]);
  alloc:
-       if (size >=3D MAX_FILE_NOTE_SIZE) /* paranoia check */
+       if (size >=3D core_file_note_size_max) /* paranoia check */
                return -EINVAL;
        size =3D round_up(size, PAGE_SIZE);
        /*
diff --git a/fs/coredump.c b/fs/coredump.c
index be6403b4b14b..2108eb93acb9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -56,10 +56,13 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);

+#define MAX_FILE_NOTE_SIZE (4*1024*1024)
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] =3D "core";
 static int core_name_size =3D CORENAME_MAX_SIZE;
+unsigned int core_file_note_size_max =3D MAX_FILE_NOTE_SIZE;

 struct core_name {
        char *corename;
@@ -1020,6 +1023,13 @@ static struct ctl_table coredump_sysctls[] =3D {
                .mode           =3D 0644,
                .proc_handler   =3D proc_dointvec,
        },
+       {
+               .procname       =3D "core_file_note_size_max",
+               .data           =3D &core_file_note_size_max,
+               .maxlen         =3D sizeof(unsigned int),
+               .mode           =3D 0644,
+               .proc_handler   =3D proc_douintvec,
+       },
 };

 static int __init init_fs_coredump_sysctls(void)
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d3eba4360150..14c057643e7f 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -46,6 +46,7 @@ static inline void do_coredump(const
kernel_siginfo_t *siginfo) {}
 #endif

 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
+extern unsigned int core_file_note_size_max;
 extern void validate_coredump_safety(void);
 #else
 static inline void validate_coredump_safety(void) {}

Thanks,
Allen

