Return-Path: <linux-fsdevel+bounces-41432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2AA2F6C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CCD3A7003
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF52566C2;
	Mon, 10 Feb 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="4WDRM6Tf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD022257D
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211625; cv=none; b=P7fPSxtjN878v3RYoYwpp1jWijzXYg4h3g3QHfVkXKRPRB69lrptSxCCxQ+DNkVTFAtAdj941wj6jCcSXnuHe8gzKvR6KZyRrG5ZzZWjVvUtfOuciEn0r+vkCj8UhhkBlZ4l6/4ykbVnnOl65lvba1EYfIjSWBLuBj/BdO04QqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211625; c=relaxed/simple;
	bh=6R5g6JaWQPBP9GE7QbTG+6krKqKYAC1kr8IEea2TFIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxMNoO0VngR+9wvB5d0PQT0eY8pMl4JJmtGP18GpI7i/JNldVbrnNZg/ni2rYXNrElwt3EiAI/emeGUyUWmEvvTzmvu9iDU0mzlYMFjHj6gqf3qwRD+0QZIStKF0BwAzOSA+EM4HAeYWV9q96zciets6ANv3wkEQuVlYdZYiQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=4WDRM6Tf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f44353649aso6898069a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 10:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1739211623; x=1739816423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOakPTjds2Vny74GfnKgUzmZ5741L2AfZYgW15BH/Rg=;
        b=4WDRM6TfXccgFG5sV4CVA+zwgmoT+7QWUTNRLXkzT9DTVV0Q+eh3VO3LQ+EOTHR1L2
         mRmRq5PftVbvLHCt2RHvJ01tXUlIKeh7WY9MDj//P4MkpWN4mUmPpVDJnrOJ1otCinyM
         D4wtqG4HPMjmoQzfUTHe+AcUgxkbBzz9bNO4w2eBWx9DazBTKxdQSTxJcghJtJ9Z5yBJ
         BoCbjAJwq4aZWjIh793KE4k7k3CPGYurq7xeNAMvY2+dq4ZMo8GIKi40S06Q5ii+UqJe
         B2d0xj9Vo6goSGXD9FtUxbX1o3PKsQILykjsUdLH/3NygIpJAzM03wQ9aow9+HC7wtau
         aXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211623; x=1739816423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOakPTjds2Vny74GfnKgUzmZ5741L2AfZYgW15BH/Rg=;
        b=XHZlw/NPDkrEOcYqqVcd/XtJNy1MCVui9+H4blxFju9TpR4ROuXqA9uvCErkWIKMIs
         CbdfgCHnUzKzxCrlMX4gHHIcvEPUdUC5N6CGW4Kaj6D/9ZtUR/URAtIln/LvWaQfU885
         wAS4wMFsGPtFp7ZX8/IrF3MWx9NfX6zUOCWu3Hb5KFwTSbwZdVMD/J6dK9x2xf5lP6pz
         s5cJzgUFkTi90pB0ytr/6/UTJpHgzH96VeyJUqDmlhM3ccQcLmurxTyFL8hOvfwGVmaT
         dGX35J4S4nakrOw2LB5EVCvj+CiqnY0FKoA2/MEVgTzjWceWPzJO7IxZzmpx5+IMFNJd
         p7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3krS8GLjPu02uTGElonA7gLAELOlGtzKG293TseDx4zLSmIxWq0gy5IRHGiXxdYnJchK182jdSAms+Bf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Cs5sV+qmKTKAtbcH2H0HZdxKBG+ch5ctpAqFDY6ud1vWoAwl
	U6z6qZv1zwXZ4tqobKye6xNjmpvDj8BtgkgPtIZTj2E1dMzYGC6auVm0XNU5x4CxAWO1UoLdrAY
	78cIc+KSiWQ5wlDaisVLKXD67x2qcW1R+cPfwIJBodJhHVGjsxetVZ/ezjI7EEJDd5U8N/Dq2Dc
	MJ+5knX6w/1LT2+nhNOBQBXdHIUzwvxBUFeyX/x0voe2FBQx9jKjlHB5Qbwv5HCRL+p1bg1enS7
	o5MsjsrxqPHDxJU/4ugwviZZAQybujkxwpwxF+BwE9Ge3B8kbIhyTuKhdWxMt2uR34wBeeaijf1
	ba2TcLyuTf3kjDzq1EyFPG3/8k5JQbO3po5EkxH8CNAM48aUBkB9kXcSecYb2Ci7/MlOwZqTvqA
	pW15m8De7lvxyyikh4v69o+DW
X-Gm-Gg: ASbGnctTkagifKX99aog0nNb64o2QZltx57uqsOuOQfmXIeecvn5Ua1dBZmD4LcKbIF
	3HIt7PVGC2Z01W4+/TJkhAjWnNYB+YuYxEZIjaz46ojlo+KnhnA1QGfjDCu7PE+fphHUCA42kKD
	8o0JLRdJOmfoFqUQ==
X-Google-Smtp-Source: AGHT+IES0N77qvzcJtQZFftGFxaIrmeG33luUazN6PR5H62VH0z3F7hFvA9Uxf2dGfsVCUNFZXSuOyKKaBrn/Ohuu9Y=
X-Received: by 2002:a17:90b:254c:b0:2ee:bbd8:2b9d with SMTP id
 98e67ed59e1d1-2fa9ee316admr610096a91.34.1739211622603; Mon, 10 Feb 2025
 10:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com>
In-Reply-To: <CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 10 Feb 2025 15:20:05 -0300
X-Gm-Features: AWEUYZlaNfgWAlrdAqnecIoKMZd2mPUiHOPzsiVqRukK2TNDyCFtDrcVxLyPl_4
Message-ID: <CAKhLTr08CK1pPbnahvwJWu-k1wnwVV4ztVMGrmXRY5Yuz03YeA@mail.gmail.com>
Subject: Re: Possible regression with buffered writes + NOWAIT behavior, under
 memory pressure
To: linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org, Dave Chinner <david@fromorbit.com>, hch@lst.de, 
	Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 10, 2025 at 3:12=E2=80=AFPM Raphael S. Carvalho
<raphaelsc@scylladb.com> wrote:
>
> While running scylladb test suite, which uses io_uring + buffered
> writes + XFS, the system was spuriously returning ENOMEM, despite
> there being plenty of available memory to be reclaimed from the page
> cache. FWIW, I am running: 6.12.9-100.fc40.x86_64
>
> Tracing showed io_uring_complete failing the request with ENOMEM:
> # cat /sys/kernel/debug/tracing/trace | grep "result -12" -B 100 |
> grep "0000000065b91cd1"
>        reactor-1-707139  [000] ..... 46737.358518:
> io_uring_submit_req: ring 00000000e52339b8, req 0000000065b91cd1,
> user_data 0x50f0001e4000, opcode WRITE, flags 0x200000, sq_thread 0
>        reactor-1-707139  [000] ..... 46737.358526: io_uring_file_get:
> ring 00000000e52339b8, req 0000000065b91cd1, user_data 0x50f0001e4000,
> fd 45
>        reactor-1-707139  [000] ...1. 46737.358560: io_uring_complete:
> ring 00000000e52339b8, req 0000000065b91cd1, user_data 0x50f0001e4000,
> result -12, cflags 0x0 extra1 0 extra2 0
>
> That puzzled me.
>
> Using retsnoop, it pointed to iomap_get_folio:
>
> 00:34:16.180612 -> 00:34:16.180651 TID/PID 253786/253721
> (reactor-1/combined_tests):
>
>                     entry_SYSCALL_64_after_hwframe+0x76
>                     do_syscall_64+0x82
>                     __do_sys_io_uring_enter+0x265
>                     io_submit_sqes+0x209
>                     io_issue_sqe+0x5b
>                     io_write+0xdd
>                     xfs_file_buffered_write+0x84
>                     iomap_file_buffered_write+0x1a6
>     32us [-ENOMEM]  iomap_write_begin+0x408
> iter=3D&{.inode=3D0xffff8c67aa031138,.len=3D4096,.flags=3D33,.iomap=3D{.a=
ddr=3D0xffffffffffffffff,.length=3D4096,.type=3D1,.flags=3D3,.bdev=3D0x=E2=
=80=A6
> pos=3D0 len=3D4096 foliop=3D0xffffb32c296b7b80
> !    4us [-ENOMEM]  iomap_get_folio
> iter=3D&{.inode=3D0xffff8c67aa031138,.len=3D4096,.flags=3D33,.iomap=3D{.a=
ddr=3D0xffffffffffffffff,.length=3D4096,.type=3D1,.flags=3D3,.bdev=3D0x=E2=
=80=A6
> pos=3D0 len=3D4096
>
> Another trace shows iomap_file_buffered_write with ki_flags 2359304,
> which translate into (IOCB_WRITE & IOCB_ALLOC_CACHE & IOCB_NOWAIT)
> And flags 33 in iomap_get_folio means IOMAP_NOWAIT, which makes sense
> since XFS translates IOCB_NOWAIT into IOMAP_NOWAIT for performing the
> buffered write through iomap subsystem:
>
> fs/iomap/buffered-io.c- if (iocb->ki_flags & IOCB_NOWAIT)
> fs/iomap/buffered-io.c: iter.flags |=3D IOMAP_NOWAIT;
>
>
> We know io_uring works by first attempting to write with IOCB_NOWAIT,
> and if it fails with EAGAIN, it falls back to worker thread without
> the NOWAIT semantics.
>
> iomap_get_folio(), once called with IOMAP_NOWAIT, will request the
> allocation to follow GFP_NOWAIT behavior, so allocation can
> potentially fail under pressure.
>
> Coming across 'iomap: Add async buffered write support', I see Darrick wr=
ote:
>
> "FGP_NOWAIT can cause __filemap_get_folio to return a NULL folio, which
> makes iomap_write_begin return -ENOMEM.  If nothing has been written
> yet, won't that cause the ENOMEM to escape to userspace?  Why do we want
> that instead of EAGAIN?"
>
> In the patch ''mm: return an ERR_PTR from __filemap_get_folio', I see
> the following changes:
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -468,19 +468,12 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
>  {
>         unsigned fgp =3D FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | =
FGP_NOFS;
> -       struct folio *folio;
>
>         if (iter->flags & IOMAP_NOWAIT)
>                 fgp |=3D FGP_NOWAIT;
>
> -       folio =3D __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE=
_SHIFT,
> +       return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SH=
IFT,
>                         fgp, mapping_gfp_mask(iter->inode->i_mapping));
> -       if (folio)
> -               return folio;
> -
> -       if (iter->flags & IOMAP_NOWAIT)
> -               return ERR_PTR(-EAGAIN);
> -       return ERR_PTR(-ENOMEM);
>  }
>
> This leads to me believe we have a regression in this area, after that
> patch, since iomap_get_folio() is no longer returning EAGAIN with
> IOMAP_NOWAIT, if __filemap_get_folio() failed to get a folio. Now it
> returns ENOMEM unconditionally.
>
> Since we pushed the error picking decision to __filemap_get_folio, I
> think it makes sense for us to patch it such that it returns EAGAIN if
> allocation failed (under pressure) because IOMAP_NOWAIT was requested
> by its caller and allocation is not allowed to block waiting for
> reclaimer to do its thing.
>
> A possible way to fix it is this one-liner, but I am not well versed
> in this area, so someone may end up suggesting a better fix:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 804d7365680c..9e698a619545 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1964,7 +1964,7 @@ struct folio *__filemap_get_folio(struct
> address_space *mapping, pgoff_t index,
>                 do {
>                         gfp_t alloc_gfp =3D gfp;
>
> -                       err =3D -ENOMEM;
> +                       err =3D (fgp_flags & FGP_NOWAIT) ? -ENOMEM : -EAG=
AIN;

Sorry, I actually meant this:
+                       err =3D (fgp_flags & FGP_NOWAIT) ? -EAGAIN : -ENOME=
M;

