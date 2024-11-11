Return-Path: <linux-fsdevel+bounces-34331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C09C4812
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F8D1F242CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249617108A;
	Mon, 11 Nov 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0IDyMY2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BC150990
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360650; cv=none; b=as5pTb2aXfLmdpc9TyU/tf+pcIg560UI2u/RG1gz+omEuD2rv/hSJMBhunxAnz8zZ68kWNDYHHPIrYB33hCD8Mhji3TpzMD+E5rKUrilyJpdYXKAVyLHrfmF5EI/g15twC87V86nHM3r6yzGAgHSOv91QYux1sHeYpYq3e4CU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360650; c=relaxed/simple;
	bh=FCvVTzGnKGPiTpyb/F3hLUrX84c6ePjH/sc+8EHVO/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YA+Z3041xH/RYaeamvvpJk8K/VpR5NJyJoSz+KEKJjPSt8EYJBli+rRa9gfmzChLGnqkMYjb9YAeGB5GWM+19BoRPyU9VqS8JbACwkoUWVawIXyHsi4dSOY+Yma8qq2cRfuz0Er6O/ajXIl7LJdf327HHRYKCELbLlY5C+sDuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0IDyMY2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460b04e4b1cso37275101cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731360648; x=1731965448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmpu3R1opbEF6p+UWXlMJZk0n+2FpvEnZ1gS0fp686Q=;
        b=B0IDyMY2IlDioREbQKQuLybrfGpPllI4T6DkGghXC7BMUHG27L2OZaBRZFn053znr4
         VfgtK5l3ZZkSbmioghKlJS82jxWkXbtTgLrbvUBtFCxIZOp5i/7SNBdYZcJSJoOf1Qqg
         VHWAlf40UM76uPMJh//STzvrf+jD353NHlB03tX9cEbfBKzNtwm2Uo7tNh0gzIFhpAzq
         1wPB39qbsNkFCQ1deuoTRk/i31h+aAOM+2ydmBTNju5mfxQVwk60E6GhLdaPKzQD2OKH
         Tt5LngHQFpt9qLCyKPOnOMelLBqe6qcUk9mcGDNbad5C8tuvKy7oLkPO0n5+iKxVzuLL
         egqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360648; x=1731965448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmpu3R1opbEF6p+UWXlMJZk0n+2FpvEnZ1gS0fp686Q=;
        b=MLpVBJIquQxzxVe8tGZCdc4GVVTinxyGDS8hn5DKD8dKUsCQ0BaTPa6FGkz4ETw1Br
         mQjnaCf/GMJ0l/QvsuCXtSOA5gCYGdAJxAqvZJG0DnslAQbZb/LamEsQx4Iggsd38k3G
         +XmYFnqx8YWmXWvISfCQXzRs/F/PSB6If9VS6n44LDQE6QUXxOU1WGKpkt7s5HT2QAi0
         WigGmp7kcLS7C13f5N4A8VY9hrxzerdcTewtyj8nyXCCqJRmlOL4XXVSY7cUj7JEoOAC
         d/wOnAM9/mm5JcLxrx+Er+MBOaziHMDuQQwQ7fpvxGTvwVwMbELbceC4bIbxUuwmiYMg
         xm5w==
X-Forwarded-Encrypted: i=1; AJvYcCXIS1RZhoHt9v5MtPU95WQkdXZL4PR/4qBhPSuLHqO6W2NsTwKXZsDeh2MLck7uXM33qu+FSHvgmHa87lCD@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCVqOva07u3iJ5waMpQC0TmMuumwGf+k44jMHvAdiotE91pnT
	JutchDJZIyLXzPdUmIg6pSeg4cGUzGPyUPMljUsGhMvScZax5GxwF7gO0MaADXcomsxQuw92vDC
	7r44jRNrt75lKEdoesLM+vOk3YQc=
X-Google-Smtp-Source: AGHT+IHV/JyqMtFI4SIoKeOeebYTCGXh/AlqJqvdhixK6R1v5aKusI5M8c2blSVBEvX8DSv1bO5NqGoyeqca8p0QAI0=
X-Received: by 2002:a05:622a:138e:b0:460:aa51:840a with SMTP id
 d75a77b69052e-46309430898mr222924151cf.45.1731360647815; Mon, 11 Nov 2024
 13:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com> <9c0dbdac-0aed-467c-86c7-5b9a9f96d89d@linux.alibaba.com>
In-Reply-To: <9c0dbdac-0aed-467c-86c7-5b9a9f96d89d@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 11 Nov 2024 13:30:37 -0800
Message-ID: <CAJnrk1YUPZhCUhGqu+bBngzrG-yCCRLZc7fiOfXQZ0dxCHJV8Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> Hi, Joanne and Miklos,
>
> On 11/8/24 7:56 AM, Joanne Koong wrote:
> > Currently, we allocate and copy data to a temporary folio when
> > handling writeback in order to mitigate the following deadlock scenario
> > that may arise if reclaim waits on writeback to complete:
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> >
> > To work around this, we allocate a temporary folio and copy over the
> > original folio to the temporary folio so that writeback can be
> > immediately cleared on the original folio. This additionally requires u=
s
> > to maintain an internal rb tree to keep track of writeback state on the
> > temporary folios.
> >
> > A recent change prevents reclaim logic from waiting on writeback for
> > folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> > This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> > will prevent FUSE folios from running into the reclaim deadlock describ=
ed
> > above) and removes the temporary folio + extra copying and the internal
> > rb tree.
> >
> > fio benchmarks --
> > (using averages observed from 10 runs, throwing away outliers)
> >
> > Setup:
> > sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=3D4=
 -o source=3D~/tmp_mount ~/fuse_mount
> >
> > fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1M}=
 --size=3D2G
> > --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/roo=
t/fuse_mount
> >
> >         bs =3D  1k          4k            1M
> > Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> > After   341 MiB/s     2246 MiB/s     2685 MiB/s
> > % diff        -3%          23%         45%
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
>
> IIUC this patch seems to break commit
> 8b284dc47291daf72fe300e1138a2e7ed56f38ab ("fuse: writepages: handle same
> page rewrites").
>

Interesting!  My understanding was that we only needed that commit
because we were clearing writeback on the original folio before
writeback had actually finished.

Now that folio writeback state is accounted for normally (eg through
writeback being set/cleared on the original folio), does the
folio_wait_writeback() call we do in fuse_page_mkwrite() not mitigate
this?

> > -     /*
> > -      * Being under writeback is unlikely but possible.  For example d=
irect
> > -      * read to an mmaped fuse file will set the page dirty twice; onc=
e when
> > -      * the pages are faulted with get_user_pages(), and then after th=
e read
> > -      * completed.
> > -      */
>
> In short, the target scenario is like:
>
> ```
> # open a fuse file and mmap
> fd1 =3D open("fuse-file-path", ...)
> uaddr =3D mmap(fd1, ...)
>
> # DIRECT read to the mmaped fuse file
> fd2 =3D open("ext4-file-path", O_DIRECT, ...)
> read(fd2, uaddr, ...)
>     # get_user_pages() of uaddr, and triggers faultin
>     # a_ops->dirty_folio() <--- mark PG_dirty
>
>     # when DIRECT IO completed:
>     # a_ops->dirty_folio() <--- mark PG_dirty

If you have the direct io function call stack at hand, could you point
me to the function where the direct io completion marks this folio as
dirty?

> ```
>
> The auxiliary write request list was introduced to fix this.
>
> I'm not sure if there's an alternative other than the auxiliary list to
> fix it, e.g. calling folio_wait_writeback() in a_ops->dirty_folio() so
> that the same folio won't get dirtied when the writeback has not
> completed yet?
>

I'm curious how other filesystems solve for this - this seems like a
generic situation other filesystems would run into as well.


Thanks,
Joanne

>
>
> --
> Thanks,
> Jingbo

