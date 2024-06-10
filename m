Return-Path: <linux-fsdevel+bounces-21315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E9C901CC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 10:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3CCB230DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF896F30D;
	Mon, 10 Jun 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd4vuO7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370655885;
	Mon, 10 Jun 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007478; cv=none; b=au27ndr9o+I+rOwfzYOkavZmZ19dHgIDn6srQT5kXaQvoq85BPdmsU4wn41ppEvMEGIlXVwykep+XBnAHG2jfwTtf0n6JQ7tb1tzJtWRNku+A9lj3S42Kg/UhSIVws2tU5oi/eCuHKWKDtLZcOHwiPv/fR8EPyF/tMz7BROWix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007478; c=relaxed/simple;
	bh=pX55hZgAslFU347Mp/z056R6oguHdC5TccmaX2t/iog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J74TFdlnIBcYxsgW11rC9S5PhDia7b+ZuplXacEMvBsvwLloRU+yvTUBgfiqZH3gB5B6K9gjACErw7O8gxTUhh8HehBShgmmUCLXonHY8sNFMxriPX+jAhEXMTI3Zr499NbcLYKAppT2USE+aX+B/HZfKX4qvHljZOxNQgkKyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd4vuO7J; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c31144881eso372605a91.1;
        Mon, 10 Jun 2024 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718007476; x=1718612276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boO2l3vZN7nH3KvrAr9prlBUcFPwMQHcvTnj1oW/1V8=;
        b=Qd4vuO7J7pOSzPSTR04IvrxjsOaAJQYOlOgb9umlg3/ECvlDW+6xQgzkGfNtck5Hbk
         qZs3ED5sJroIpReIpJqODmixSLJ90bkH2QHXYOI0dwrO20DYYJXsyOXe2S3KtVy15UYn
         UuxKKQGjYI031S5MmNLioFQbUzd3kmJYRrNzF+Rn9yXxHtKR5e7brna3wEWUK8JdkYtw
         Vqin4HbPRldzYL/+HopnK23/XQQpdbYCRnOeQeFji15Y3WIOklPPHnErsi7neL1DH+Ys
         rPDkfvL/+9yr6C3+nhx1XH91RsI8bgk8LBn30xtWluLIL9P/v1uf02IHOZdFtZfCqmLa
         NkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718007476; x=1718612276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boO2l3vZN7nH3KvrAr9prlBUcFPwMQHcvTnj1oW/1V8=;
        b=EYqyJlXbIphDPvfgps06LMd5lmqmpFLD9vnnxdW/Sshd3j2DHgq0abH/uX59L7jiQV
         BSaVI9vFrFFbmyYLal8qECY67lVjiAKAhAlFSxHtmZGp6taNdTb+Gddxwd7ysheQ1MhZ
         bYhgqlODQ5yK3U6ba78i63Z7Dh1Ybt1Cjkr12V2bmKtz6x6JYhu48CmQUWyk0affBhMK
         7Jy3fLuW7mmQ6GR0FqyOEXHjhsChbsKygdF9KsSiyMxxtFxJl44BaJuuw9drnnUkKciG
         NJbQRtgbJXaQockdNAqcK4TefoH6X8evmxZ20zAy+zO+vK9FW132Q6+78ZUo0I3vma3o
         c6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfG/8ELR9vu0D4ezaUDuREOU9vtl9ou/NJMp7QaA0AKOvYQJfCRUohM9gRGB2Pomz29zpopyRG3esBMGduMFHRYCKqSrBDr1ZmEPVymus9Ci6D/jqrMqQ/v6568mTlGMQpoINJHR/3Ueu32Qj1vQ3gj9qvxqj0/O6xMD1GNtlzkQ==
X-Gm-Message-State: AOJu0YyFQ/g/NO0HmaBaxnyr82Ff+GWBnLAH7LncE6P/HG8HiuqEA/5c
	6tFVO37nhiv6IT/Qjl67IFOIKaB8HZleVZPlu/GPdkCVDNy7Vf7bx+OUirmUoeUKC3bPDEQPNGR
	tCqiQcDiOo5Jr9iIW32gK5WB8eT8=
X-Google-Smtp-Source: AGHT+IH0FNZaeJCNfSLD4WEifC4IPCYbk21g97wqXKFaiT0J77VYQN7/t7VgnP5Uc4iC2YUAA8yNQ8/3tWb10uQonKk=
X-Received: by 2002:a17:90b:b15:b0:2c2:fe3d:3453 with SMTP id
 98e67ed59e1d1-2c2fe3d3560mr2157855a91.18.1718007475751; Mon, 10 Jun 2024
 01:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-4-andrii@kernel.org>
 <ZmOKMgZn_ki17UYM@gmail.com>
In-Reply-To: <ZmOKMgZn_ki17UYM@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jun 2024 09:17:43 +0100
Message-ID: <CAEf4BzYAQwX0AQ_fbcB9kVBj3vpx0-5pPPZNYKL4VjnX_eYKpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] fs/procfs: implement efficient VMA querying API
 for /proc/<pid>/maps
To: Andrei Vagin <avagin@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:31=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wro=
te:
>
> On Tue, Jun 04, 2024 at 05:24:48PM -0700, Andrii Nakryiko wrote:
> > /proc/<pid>/maps file is extremely useful in practice for various tasks
> > involving figuring out process memory layout, what files are backing an=
y
> > given memory range, etc. One important class of applications that
> > absolutely rely on this are profilers/stack symbolizers (perf tool bein=
g one
> > of them). Patterns of use differ, but they generally would fall into tw=
o
> > categories.
> >
> > In on-demand pattern, a profiler/symbolizer would normally capture stac=
k
> > trace containing absolute memory addresses of some functions, and would
> > then use /proc/<pid>/maps file to find corresponding backing ELF files
> > (normally, only executable VMAs are of interest), file offsets within
> > them, and then continue from there to get yet more information (ELF
> > symbols, DWARF information) to get human-readable symbolic information.
> > This pattern is used by Meta's fleet-wide profiler, as one example.
> >
> > In preprocessing pattern, application doesn't know the set of addresses
> > of interest, so it has to fetch all relevant VMAs (again, probably only
> > executable ones), store or cache them, then proceed with profiling and
> > stack trace capture. Once done, it would do symbolization based on
> > stored VMA information. This can happen at much later point in time.
> > This patterns is used by perf tool, as an example.
> >
> > In either case, there are both performance and correctness requirement
> > involved. This address to VMA information translation has to be done as
> > efficiently as possible, but also not miss any VMA (especially in the
> > case of loading/unloading shared libraries). In practice, correctness
> > can't be guaranteed (due to process dying before VMA data can be
> > captured, or shared library being unloaded, etc), but any effort to
> > maximize the chance of finding the VMA is appreciated.
> >
> > Unfortunately, for all the /proc/<pid>/maps file universality and
> > usefulness, it doesn't fit the above use cases 100%.
> >
> > First, it's main purpose is to emit all VMAs sequentially, but in
> > practice captured addresses would fall only into a smaller subset of al=
l
> > process' VMAs, mainly containing executable text. Yet, library would
> > need to parse most or all of the contents to find needed VMAs, as there
> > is no way to skip VMAs that are of no use. Efficient library can do the
> > linear pass and it is still relatively efficient, but it's definitely a=
n
> > overhead that can be avoided, if there was a way to do more targeted
> > querying of the relevant VMA information.
> >
> > Second, it's a text based interface, which makes its programmatic use f=
rom
> > applications and libraries more cumbersome and inefficient due to the
> > need to handle text parsing to get necessary pieces of information. The
> > overhead is actually payed both by kernel, formatting originally binary
> > VMA data into text, and then by user space application, parsing it back
> > into binary data for further use.
>
> I was trying to solve all these issues in a more generic way:
> https://lwn.net/Articles/683371/
>

Can you please provide a tl;dr summary of that effort?

> We definitely interested in this new interface to use it in CRIU.
>
> <snip>
>
> > +
> > +     if (karg.vma_name_size) {
> > +             size_t name_buf_sz =3D min_t(size_t, PATH_MAX, karg.vma_n=
ame_size);
> > +             const struct path *path;
> > +             const char *name_fmt;
> > +             size_t name_sz =3D 0;
> > +
> > +             get_vma_name(vma, &path, &name, &name_fmt);
> > +
> > +             if (path || name_fmt || name) {
> > +                     name_buf =3D kmalloc(name_buf_sz, GFP_KERNEL);
> > +                     if (!name_buf) {
> > +                             err =3D -ENOMEM;
> > +                             goto out;
> > +                     }
> > +             }
> > +             if (path) {
> > +                     name =3D d_path(path, name_buf, name_buf_sz);
> > +                     if (IS_ERR(name)) {
> > +                             err =3D PTR_ERR(name);
> > +                             goto out;
>
> It always fails if a file path name is longer than PATH_MAX.
>
> Can we add a flag to indicate whether file names are needed to be

It's already supported. Getting a VMA name is optional. See a big
comment next to the vma_name_size field in the UAPI header. If
vma_name_size is set to zero, VMA name is not retrieved at all,
avoiding the overhead and this issue with PATH_MAX.

> resolved? In criu, we use special names like "vvar", "vdso", but we dump
> files via /proc/pid/map_files.
>
> > +                     }
> > +                     name_sz =3D name_buf + name_buf_sz - name;
> > +             } else if (name || name_fmt) {
> > +                     name_sz =3D 1 + snprintf(name_buf, name_buf_sz, n=
ame_fmt ?: "%s", name);
> > +                     name =3D name_buf;
> > +             }
> > +             if (name_sz > name_buf_sz) {
> > +                     err =3D -ENAMETOOLONG;
> > +                     goto out;
> > +             }
> > +             karg.vma_name_size =3D name_sz;
> > +     }
>
> Thanks,
> Andrei

