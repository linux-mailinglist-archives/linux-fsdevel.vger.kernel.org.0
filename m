Return-Path: <linux-fsdevel+bounces-36664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F39E779E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4165018825F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D02206B4;
	Fri,  6 Dec 2024 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWhT8UMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3622068A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506899; cv=none; b=jAMP//L7xTAS05u8fQyaCeU1cAFyBZ6WeZsMFoFS2FWSxHY1yxlcjLGazwsHtCBiJB6lJ3VG16kR4SWE6gtcnSBC1hqUC9RkgKfo8yVMiROQhIj9O7xVNQP433Y2aT4inPrHNm7Q6DRY5Y20yk/o6u9rmgCm97els9x+jKh25wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506899; c=relaxed/simple;
	bh=xxAy4ciuvxp0YTNkWFM4SdfbS9E+y6HlFygZ5DLbmz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvEXswt5PQ9zWqona7ezj5kO90JqiTz/J7/01PNLCWzx5yz8D1dGJSxdQQAENZ6Rabf6sHUWO61UUgH2ZINKwUQ6fwhE5k5w78v3VZZpkBE5ci73lew6MUBwG4oeeymIZA3CSmgMIWICWQuLq9hjL2ebJuo4FABaifczR/GbcDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWhT8UMv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46684744173so39128301cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 09:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733506896; x=1734111696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyjP/GZioFa8MfFmN9Ox+T0qE2SZIwtsZCU0mPe/YMc=;
        b=gWhT8UMvuv1dDVx//fAmI8tIXc2nSoRiLSoQGCXbuJr6XgoVYYv5HcBcE2MhQO/4U3
         Rt4bsWLJxkD+4DoffHmhP+fUuZrvcgcASEPNb0r3NHoaIVundFyKF44ShJoYcJGMRLN5
         PWJdtS0TAXvae+PAfSXO2gjchBV3GX5VfxfGRPXoNc6dFZQp0mkd5VFhEyUwQov8wnOK
         lwsmMIRGt49WDk81Ll6AFqb93+NjWobwa0tdx3OnoK5FfQYEIHy2U6T4HtmLeYp3JpCk
         sHLR7qJMkIK+eNAACrqTKD1ppzojdCrGLFQwJzOf30Wr45CDzIeWdcx2rtJkIo6tf6ZY
         bb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506896; x=1734111696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyjP/GZioFa8MfFmN9Ox+T0qE2SZIwtsZCU0mPe/YMc=;
        b=t2FaRL6sF5Un/jjN1tAnps/3Cg2lgYf0+qXvcBee+KAz+k/SjV9deCwVsiVplmKY/G
         iMN29X2fz56XPSa2eyIW3hZlVZSoZskHneJEc5q90rnzZ5xvrD6MME8udvJ6NsbBXkJA
         iotigMLFc99QAgPrgAZKIur8Ur+wZ2OqWCTua6nHEGG3Xf7Xqgpd43LJ0QLaGcmfIssD
         TYafucHjawwt8OKT0X1RCnB9XkMRmd2nHWbbucyqAWlW4YTeJ6JWkCrAmkdsQJdIOLZd
         v0kCZXlBYZUqr880WmsBsUpS5re4BUcbnu+HGigiUwnSBj7CCv0PMgp6P8eSAiWIXf5q
         DF+w==
X-Forwarded-Encrypted: i=1; AJvYcCUw7tkl3riYGA+wflm+V+cTVxcAbEwDFmGbb1Lt/u8ea2p/6eTGwoqkbMJ8VcH6yAFECOnStnynDLbPzThp@vger.kernel.org
X-Gm-Message-State: AOJu0YwvV/iSgJJlHnkYAhBq8x4416Z8iRupugpZ0yUgv01HkGNGb3S/
	W6YW+CnaROQQvfGLrlpFDcF4jvoaOxZxurBlZHFS21l8FOXLIdFJ8NzuF7RoWOuXBnTF/55DeES
	3yZmDGay8cWmMRrHuUZibhMXW1Ec=
X-Gm-Gg: ASbGncsmeKAf7fbk9yWJH6h0o8wcR331wQqCpc2qrVw1EUPewJZ/7Brc3zV/y+X6eel
	obBjZt9Lq+A9sxS7GiRka97QBE8vA67+XKCNi3idItr9xZEA=
X-Google-Smtp-Source: AGHT+IGbUl7r9wMF+JVOKNk5FN4J7l57p/bJzELYZXqzLI1v0+6yV9bgPRnuVNHL9avYdK3xq6QbUi2j+vADZ1TPIaE=
X-Received: by 2002:a05:622a:56:b0:466:9a2a:d2a with SMTP id
 d75a77b69052e-46734f7444amr81689421cf.55.1733506896338; Fri, 06 Dec 2024
 09:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125220537.3663725-1-joannelkoong@gmail.com> <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com>
In-Reply-To: <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Dec 2024 09:41:25 -0800
Message-ID: <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fuse: support large folios
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:50=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
> Hi Joanne,
>
> Have no checked the whole series yet, but I just spent some time on the
> testing, attempting to find some statistics on the performance improvemen=
t.
>
> At least we need:
>
> @@ -2212,7 +2213,7 @@ static int fuse_write_begin(struct file *file,
> struct address_space *mapping,
>
>         WARN_ON(!fc->writeback_cache);
>
> -       folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> +       folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN |
> fgf_set_order(len),
>
> Otherwise the large folio is not enabled on the buffer write path.
>
>
> Besides, when applying the above diff, the large folio is indeed enabled
> but it suffers severe performance regression:
>
> fio 1 job buffer write:
> 2GB/s BW w/o large folio, and 200MB/s BW w/ large folio
>
> Have not figured it out yet.
>

Hi Jingbo,

Thanks for running some benchmarks / tests on your end.

>
> On 11/26/24 6:05 AM, Joanne Koong wrote:
> > This patchset adds support for folios larger than one page size in FUSE=
.
> >
> > This patchset is rebased on top of the (unmerged) patchset that removes=
 temp
> > folios in writeback [1]. (There is also a version of this patchset that=
 is
> > independent from that change, but that version has two additional patch=
es
> > needed to account for temp folios and temp folio copying, which may req=
uire
> > some debate to get the API right for as these two patches add generic
> > (non-FUSE) helpers. For simplicity's sake for now, I sent out this patc=
hset
> > version rebased on top of the patchset that removes temp pages)
> >
> > This patchset was tested by running it through fstests on passthrough_h=
p.
> >
> > Benchmarks show roughly a ~45% improvement in read throughput.
> >
> > Benchmark setup:
> >
> > -- Set up server --
> >  ./libfuse/build/example/passthrough_hp --bypass-rw=3D1 ~/libfuse
> > ~/mounts/fuse/ --nopassthrough
> > (using libfuse patched with https://github.com/libfuse/libfuse/pull/807=
)
> >
> > -- Run fio --
> >  fio --name=3Dread --ioengine=3Dsync --rw=3Dread --bs=3D1M --size=3D1G
> > --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
> > --directory=3Dmounts/fuse/
> >
> > Machine 1:
> >     No large folios:     ~4400 MiB/s
> >     Large folios:        ~7100 MiB/s
> >
> > Machine 2:
> >     No large folios:     ~3700 MiB/s
> >     Large folios:        ~6400 MiB/s
> >
> > Writes are still effectively one page size. Benchmarks showed that tryi=
ng to get
> > the largest folios possible from __filemap_get_folio() is an over-optim=
ization
> > and ends up being significantly more expensive. Fine-tuning for the opt=
imal
> > order size for the __filemap_get_folio() calls can be done in a future =
patchset.

This is the behavior I noticed as well when running some benchmarks on
v1 [1]. I think it's because when we call into __filemap_get_folio(),
we hit the FGP_CREAT path and if the order we set is too high, the
internal call to filemap_alloc_folio() will repeatedly fail until it
finds an order it's able to allocate (eg the do { ... } while (order--
> min_order) loop).


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1aPVwNmv2uxYLwtdwGqe=3DQURO=
UXmZc8BiLAV=3DuqrnCrrw@mail.gmail.com/

> >
> > [1] https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joan=
nelkoong@gmail.com/
> >
> > Changelog:
> > v1: https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joan=
nelkoong@gmail.com/
> > v1 -> v2:
> > * Change naming from "non-writeback write" to "writethrough write"
> > * Fix deadlock for writethrough writes by calling fault_in_iov_iter_rea=
dable() first
> >   before __filemap_get_folio() (Josef)
> > * For readahead, retain original folio_size() for descs.length (Josef)
> > * Use folio_zero_range() api in fuse_copy_folio() (Josef)
> > * Add Josef's reviewed-bys
> >
> > Joanne Koong (12):
> >   fuse: support copying large folios
> >   fuse: support large folios for retrieves
> >   fuse: refactor fuse_fill_write_pages()
> >   fuse: support large folios for writethrough writes
> >   fuse: support large folios for folio reads
> >   fuse: support large folios for symlinks
> >   fuse: support large folios for stores
> >   fuse: support large folios for queued writes
> >   fuse: support large folios for readahead
> >   fuse: support large folios for direct io
> >   fuse: support large folios for writeback
> >   fuse: enable large folios
> >
> >  fs/fuse/dev.c  | 128 ++++++++++++++++++++++++-------------------------
> >  fs/fuse/dir.c  |   8 ++--
> >  fs/fuse/file.c | 126 +++++++++++++++++++++++++++++++-----------------
> >  3 files changed, 149 insertions(+), 113 deletions(-)
> >
>
> --
> Thanks,
> Jingbo

