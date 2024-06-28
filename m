Return-Path: <linux-fsdevel+bounces-22794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9191C3CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 18:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52811C22563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED621CB303;
	Fri, 28 Jun 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPv5Av6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13A1C9EB9;
	Fri, 28 Jun 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592599; cv=none; b=gKhEcnEQlVi1KcSWAnezGGg+2P6/YktKwE2MIpO3GTebK+US+3SL+Vwx7EvskAQm91OT2ZanVlV0+EhYWjVl0SNUXgrj+Cw1xt/QQ9r8cIIQjtKsG5T8WaMU6MyQEUj5We7bXh4PWRHyHxwGFJuWL3XZyTHVR4gceglD4zqA+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592599; c=relaxed/simple;
	bh=tiPGtjxDybxqvD1iYQ28iukxdlykxMcau75CNdk+4BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7pACzMjchy2rzwwSkWPZRsgG6C84CLEe/E9L1dlXtJAJAkxhAQkVsypRqCHQ0M/F2/C0wb6OuNKS9vwFyDzVgcOUFG6iH80Nc/BgPrcV1xN82X3BsXCOeDxCuUEQpv/CbAiMQ72KzUZMvwn1/gqIK2x+lgrpkPDzV565O0jEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPv5Av6L; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so610642a91.0;
        Fri, 28 Jun 2024 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719592597; x=1720197397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGnPoWdruisWSPdQgdSF6ZHXGVwHt0h1jI18T4eJdgs=;
        b=FPv5Av6L8UnANdQNlc1jDMYHWc9A1JyhqE1Ct+2dws5o4cGS/BARQReis2U9m8ZiSP
         f0eAqPzwKUHDSYbyzRkjIsgm2/nuTorxOnMajw9OWU+WmVO1DwzkexDG8J2aFpvvbfxJ
         zrCaLVbuivQ3TWeLVxkb+v1aqYepYjQdS3dmYJ9zgNZ7lb/pKk0M+NyeEEBiNhcj0Kj6
         ZWlgoCDq0Xv/raEyBNMnxMXagDA5aLUg+KIIwNJ/aEv96Bd+dUUkSUArjSpmp4lbNsvJ
         dEK2pjsXmGAyI5/haBLH6ZG0zepqLcL8MazlU3WuxMMAQVeVo160p8RRD3/5MByZKkQX
         ZU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592597; x=1720197397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGnPoWdruisWSPdQgdSF6ZHXGVwHt0h1jI18T4eJdgs=;
        b=p4Q07xxGeRYSya8H+uY9eML273+FygYXm50LI7FQ36Z87ISWRSBbr6Vw74kJIm2kWb
         DRk4Bz72gcAg2HME94wlZS1AYb6xdPZ7R+HqKFwz5tm85lkyeDvB0akVwx8x225c6No7
         kAluMLVj3yX05Q7U6hWeWeoDnW/IVFIuz5TXlukHyWTUaePi0TuohbZ+loIxW8b8ac2c
         YvvyVE4hKiEtMV6Xe75ubxnvd+YUqMHvPUDhvsE4Kkpi0bwvotZcjZXxN0wGaYgwi2iE
         zSEM8G0lVg2OabUsvP6JQA8fYKCXacmRuLMPpUQXJZREjthq45CaPcMI+INU1Rq0hk4+
         XGEA==
X-Forwarded-Encrypted: i=1; AJvYcCXgOqFxMsUT+7a3XDQEFb5ARD842KmKKfHfXxsF4k45tat8YjL+RdNMX+L7OVo1/IgVs2dqt6fSIkgX9JKFtL5xQleGfcq0OrhOWsN02xjSNme5Pae3W0Nw/nVwm28gCxzbn8CQeHzEWQilrK+iVAirFes1bu64CxGgd6ypON/BsA==
X-Gm-Message-State: AOJu0YxUzKdVZWSEHAm3nIYqR1Nk6l0eTVtjAjizNLrv19jl6M3X+6Yd
	1luAIphEUU7k9vdWa/BGMw+txZPdVHtnvZTiSqf6RNk3Ab7Vw7QDEVlZ2l//THaP4E+QyeAIYE3
	iTcHEfq6LinsQoHZs6Wmw/987rZMb0g==
X-Google-Smtp-Source: AGHT+IGWWJNyo0OOO0+HVTZ4yFxBFpAEh7kWeeBff+lMtE0x+3GvMgNVOp0ebiUYq9oTJECmTT22XZAYsJ0gVJy0I9o=
X-Received: by 2002:a17:90b:50c8:b0:2c0:238c:4ee6 with SMTP id
 98e67ed59e1d1-2c86121446cmr16134737a91.2.1719592596790; Fri, 28 Jun 2024
 09:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com>
In-Reply-To: <878qyqyorq.fsf@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 09:36:25 -0700
Message-ID: <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:00=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > The need to get ELF build ID reliably is an important aspect when
> > dealing with profiling and stack trace symbolization, and
> > /proc/<pid>/maps textual representation doesn't help with this.
> >
> > To get backing file's ELF build ID, application has to first resolve
> > VMA, then use it's start/end address range to follow a special
> > /proc/<pid>/map_files/<start>-<end> symlink to open the ELF file (this
> > is necessary because backing file might have been removed from the disk
> > or was already replaced with another binary in the same file path.
> >
> > Such approach, beyond just adding complexity of having to do a bunch of
> > extra work, has extra security implications. Because application opens
> > underlying ELF file and needs read access to its entire contents (as fa=
r
> > as kernel is concerned), kernel puts additional capable() checks on
> > following /proc/<pid>/map_files/<start>-<end> symlink. And that makes
> > sense in general.
>
> I was curious about this statement. It has still certainly potential
> for side channels e.g. for files that are execute only, or with
> some other special protection.
>
> But actually just looking at the parsing code it seems to fail basic
> TOCTTOU rules, and since you don't check if the VMA mapping is executable
> (I think), so there's no EBUSY checking for writes, it likely is exploita=
ble.
>
>
>         /* only supports phdr that fits in one page */
>                 if (ehdr->e_phnum >
>                    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
>                 <---------- check in memory
>                                 return -EINVAL;
>
>         phdr =3D (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
>
> <---- but page is shared in the page cache. So if anybody manages to map
> it for write
>
>
>         for (i =3D 0; i < ehdr->e_phnum; ++i) {   <----- this loop can go
>                         off into the next page.
>                         if (phdr[i].p_type =3D=3D PT_NOTE &&
>                                             !parse_build_id(page_addr, bu=
ild_id, size,
>                                                             page_addr + p=
hdr[i].p_offset,
>                                                             phdr[i].p_fil=
esz))
>                                                                          =
           return 0;
>
> Here's an untested patch
>
>

Yep, makes sense. I'm currently reworking this whole lib/buildid.c
implementation to remove all the restrictions on data being in the
first page only, and making it work in a faultable context more
reliably. I can audit the code for TOCTOU issues and incorporate your
feedback. I'll probably post the patch set next week, will cc you as
well.

> diff --git a/lib/buildid.c b/lib/buildid.c
> index 7954dd92e36c..6c022fcd03ec 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -72,19 +72,20 @@ static int get_build_id_32(const void *page_addr, uns=
igned char *build_id,
>         Elf32_Ehdr *ehdr =3D (Elf32_Ehdr *)page_addr;
>         Elf32_Phdr *phdr;
>         int i;
> +       unsigned phnum =3D READ_ONCE(ehdr->e_phnum);
>
>         /* only supports phdr that fits in one page */
> -       if (ehdr->e_phnum >
> +       if (phnum >
>             (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
>                 return -EINVAL;
>
>         phdr =3D (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
>
> -       for (i =3D 0; i < ehdr->e_phnum; ++i) {
> +       for (i =3D 0; i < phnum; ++i) {
>                 if (phdr[i].p_type =3D=3D PT_NOTE &&
>                     !parse_build_id(page_addr, build_id, size,
>                                     page_addr + phdr[i].p_offset,
> -                                   phdr[i].p_filesz))
> +                                   READ_ONCE(phdr[i].p_filesz)))
>                         return 0;
>         }
>         return -EINVAL;
> @@ -97,15 +98,16 @@ static int get_build_id_64(const void *page_addr, uns=
igned char *build_id,
>         Elf64_Ehdr *ehdr =3D (Elf64_Ehdr *)page_addr;
>         Elf64_Phdr *phdr;
>         int i;
> +       unsigned phnum =3D READ_ONCE(ehdr->e_phnum);
>
>         /* only supports phdr that fits in one page */
> -       if (ehdr->e_phnum >
> +       if (phnum >
>             (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
>                 return -EINVAL;
>
>         phdr =3D (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
>
> -       for (i =3D 0; i < ehdr->e_phnum; ++i) {
> +       for (i =3D 0; i < phnum; ++i) {
>                 if (phdr[i].p_type =3D=3D PT_NOTE &&
>                     !parse_build_id(page_addr, build_id, size,
>                                     page_addr + phdr[i].p_offset,

