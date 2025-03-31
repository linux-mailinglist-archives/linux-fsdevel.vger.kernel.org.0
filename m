Return-Path: <linux-fsdevel+bounces-45392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B7FA77135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 01:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC86716B360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF821D3EA;
	Mon, 31 Mar 2025 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjiVoJPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4621D3D4;
	Mon, 31 Mar 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743462104; cv=none; b=GMnvh4ufjU70cJDk2e0YqP8oqxLatnsJrZLRI/lwwA0VHJunQiZvcw0ogP5yM+0Gi9Hiq6El+lZhBf7nVq+IWUjiDnG4HivJLJgwzWMulKFcFOnIsq1Hu/YFa0hZxxKFK6vfUsGLVzs7WV+Xl+nLdtkHp6yPIROaeVaKFeNCIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743462104; c=relaxed/simple;
	bh=ZhirJrPIEa5vpGoBEvV8akVFOVaqBqY58VZHrY8RCO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OudL9A/C1ndxDbF62Vma5uUZZAZqxVHR1HlX1NRIydHLo/1LuYomeHex8D7quXkXxOooNwfxvo26cQCPp2V2pdyerJrMPaZv78pYFqrwFqQV5Hsjdvz1gkSvijRwzulaajj8bBBLs6YneoFo4A4MNAkYw0RZM+3B4awKMjuEE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjiVoJPf; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769b16d4fbso27794921cf.2;
        Mon, 31 Mar 2025 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743462101; x=1744066901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVaYm28D5zNUaE2vv7tWW2bqSNQ/yymD8eBRduIxumU=;
        b=SjiVoJPfxX6yqr9AM7Ycrf8lx6EZQJWlU4TKsHNJPiedNZ7K9ZRYUvK8huDuf/71fa
         jk7HnWKzexJfrJ78OhBrjxs/atx8r2fAbB+J4f5/n3U8U5zUqLjhmaA+xMv2OQXolhV1
         OpLjnN+l++njh3PFNEkoN56hs8bZmqiJ5LBRzQDOj/X7JZi4ZtqE8Bo101G/oGsdkzwI
         aYdPR9HdzZ8iwp4QwDX659dVBxm0r7Ruvo6/z/hdWv21yCtzBMvNbCHDbo/S3MwEkRfu
         4Ug6EkXWdBXxWOsYPsXeCO4/NoHb9MTLfZfSGJCw7BNyeska37o4EKtXV5Q7KxXX5mVU
         gjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743462101; x=1744066901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVaYm28D5zNUaE2vv7tWW2bqSNQ/yymD8eBRduIxumU=;
        b=Dr7Rx0sscO01Pg/ewmBJJ+4tr9eEoQBEKrzEw1yjNQRAbSH8uBEk7d3OPIOPqVfJys
         lnNW4jiwdk5agL2VllakE+bIHWBwf02gIFE0XeWomXOZvwyotTlNUNcjpBGNUHB9brUv
         mRQOLfuJTyjCjogldTz+CprI9uqU1P8ZVnakpuM4JPqrfWBQgNCOVGzTdQR9qOes1UaD
         bZseGmU0xSKuN3Q3Io+gWwzh7q4SZfqbzKEpxKKyhRTXRMCzy+wWKS3efCfjxi1kt2jA
         GosTkrsWUORkMrB3F+spPcPaPdzYCFJMXCCa/ATlYaabLQq0qbQM/lYeWJ/hysyioKEz
         wThQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEjkoeZ60A0/xMwEwpE/XG2U+AqS4hxo38ntr71KUrF5WWKuJ4VsUBsXalk4iS1GrBixFpNUr0mZMoosmK@vger.kernel.org, AJvYcCXGoexC+WgL7JEQ9WBdJkZhnxLCt5bxzxu+fON72s7ko39TrlkA2MMHChrPJ4QJI0yf/q4MrEsglEl5Z7nB@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkj1DtlWFhjVVXKYPySK7bUR1sOuLJXbS5NJwzd0dDvgqXo7t
	aY84+1KGi8Vso6+ou2//0NIKpZFECyf/+wTJOZ8cfNJtumxRk8CI/tkT/9/qrS1Y1bz0nHzRMxy
	0Jmkoaru8BvqOJ8hYv9JnA2nR47c=
X-Gm-Gg: ASbGnctTtLtoG0p4ftEkCFSRh+Hu3R40VYUi7jIHaI8Uo3RVZdqTptzdbg1qNQkYbzy
	f46rpbJpUjnFyHNrZyUXOTfuE/bg253wMlEJ8RnkLkUMa+hFPhCvEYPo/CIZcOSSlSZUk4E81qu
	JErqHRbUlt51qlDxVrav3lkPEt/VM=
X-Google-Smtp-Source: AGHT+IEIBKsOj9l0I422L9+eb2XNbT7W9CCghbQDaIzOrw1vo6zOvtMhxj+Yra4MPrgRZRBXp7TKAIz8bfWzHocE4Ig=
X-Received: by 2002:a05:622a:2d5:b0:477:704a:a580 with SMTP id
 d75a77b69052e-477ed7cbb71mr213429211cf.13.1743462100610; Mon, 31 Mar 2025
 16:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727081237.18217-1-jaco@uls.co.za> <20250314221701.12509-1-jaco@uls.co.za>
 <20250314221701.12509-3-jaco@uls.co.za> <CAJnrk1YqO44P077UwJqS+nrSTNe9m9MrbKwnxsSZn2RCQsEvAQ@mail.gmail.com>
 <ffeb7915-a028-40d8-94d0-4c647ee8e184@uls.co.za> <CAJnrk1ZBDLim8ZK-Fc9gXUVht9rJOdSTKO+fb+kxoGpWuwTu9w@mail.gmail.com>
In-Reply-To: <CAJnrk1ZBDLim8ZK-Fc9gXUVht9rJOdSTKO+fb+kxoGpWuwTu9w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 31 Mar 2025 16:01:30 -0700
X-Gm-Features: AQ5f1Jp-9X404Bnii3t66H6JOeF4-XX1uA6KFvYyw5npspXYkM8vL2mADGzMTRI
Message-ID: <CAJnrk1bKkzqVv1HkRFVTWJOp-w=HMb6tvY5r=9RHtKj39EBRRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
To: Jaco Kroon <jaco@uls.co.za>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, rdunlap@infradead.org, 
	trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 2:48=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Mar 31, 2025 at 1:43=E2=80=AFPM Jaco Kroon <jaco@uls.co.za> wrote=
:
> >
> > Hi,
> >
> > On 2025/03/31 18:41, Joanne Koong wrote:
> > > On Fri, Mar 14, 2025 at 3:39=E2=80=AFPM Jaco Kroon<jaco@uls.co.za> wr=
ote:
> > >> Clamp to min 1 page (4KB) and max 128 pages (512KB).
> > >>
> > >> Glusterfs trial using strace ls -l.
> > >>
> > >> Before:
> > >>
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 616
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 624
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 624
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> > >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 608
> > >> getdents64(3, 0x7f2d7d7a7040 /* 1 entries */, 131072) =3D 24
> > >> getdents64(3, 0x7f2d7d7a7040 /* 0 entries */, 131072) =3D 0
> > >>
> > >> After:
> > >>
> > >> getdents64(3, 0x7ffae8eed040 /* 276 entries */, 131072) =3D 6696
> > >> getdents64(3, 0x7ffae8eed040 /* 0 entries */, 131072) =3D 0
> > >>
> > >> Signed-off-by: Jaco Kroon<jaco@uls.co.za>
> > >> ---
> > >>   fs/fuse/readdir.c | 22 ++++++++++++++++++----
> > >>   1 file changed, 18 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> > >> index 17ce9636a2b1..a0ccbc84b000 100644
> > >> --- a/fs/fuse/readdir.c
> > >> +++ b/fs/fuse/readdir.c
> > >> @@ -337,11 +337,25 @@ static int fuse_readdir_uncached(struct file *=
file, struct dir_context *ctx)
> > >>          struct fuse_mount *fm =3D get_fuse_mount(inode);
> > >>          struct fuse_io_args ia =3D {};
> > >>          struct fuse_args_pages *ap =3D &ia.ap;
> > >> -       struct fuse_folio_desc desc =3D { .length =3D PAGE_SIZE };
> > >> +       struct fuse_folio_desc desc =3D { .length =3D ctx->count };
> > >>          u64 attr_version =3D 0, evict_ctr =3D 0;
> > >>          bool locked;
> > >> +       int order;
> > >>
> > >> -       folio =3D folio_alloc(GFP_KERNEL, 0);
> > >> +       if (desc.length < PAGE_SIZE)
> > >> +               desc.length =3D PAGE_SIZE;
> > >> +       else if (desc.length > (PAGE_SIZE << 7)) /* 128 pages, typic=
ally 512KB */
> > >> +               desc.length =3D PAGE_SIZE << 7;
> > >> +
> > > Just wondering, how did 128 pages get decided as the upper bound? It
> > > seems to me to make more sense if the upper bound is fc->max_pages.
> >
> > Best answer ... random/guess at something which may be sensible.
> >
> > > Also btw, I think you can just use the clamp() helper from
> > > <linux/minmax.h> to do the clamping
> >
> > Thanks.  Not a regular contributor to the kernel, not often that I've
> > got an itch that needs scratching here :).
> >
> > So something like this then:
> >
> > 345
> > 346     desc.length =3D clamp(desc.length, PAGE_SIZE, fm->fc->max_pages=
 <<
> > CONFIG_PAGE_SHIFT);
> > 347     order =3D get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
> > 348
> >
>
> You can just use PAGE_SHIFT here instead of CONFIG_PAGE_SHIFT
>
> > Note:  Can use ctx->count here in clamp directly due to it being signed=
,
> > where desc.length is unsigned.
> >
> > I'm *assuming* get_count_order will round-up, so if max_pages is 7 (if
> > non-power of two is even possible) we will really get 8 pages here?
>
> Yes, if you have a max_pages of 7, this will round up and return to
> you an order of 3
>
> >
> > Compile tested only.  Will perform basic run-time test before re-submit=
.
> >
> > >> +       order =3D get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
> > >> +
> > >> +       do {
> > >> +               folio =3D folio_alloc(GFP_KERNEL, order);
> > > Folios can now be larger than one page size for readdir requests with
> > > your change but I don't believe the current page copying code in fuse
> > > supports this yet. For example, I think the kmapping will be
> > > insufficient in fuse_copy_page() where in the current code we kmap
> > > only the first page in the folio. I sent a patch for supporting large
> > > folios page copying [1] and am trying to get this merged in but
> > > haven't heard back about this patchset yet. In your local tests that
> > > used multiple pages for the readdir request, did you run into any
> > > issues or it worked fine?
> >
> > My tests boiled down to running strace as per above, and then some basi=
c
> > time trials using find /path/to/mount/point with and without the patch
> > over a fairly large structure containing about 170m inodes.  No problem=
s
> > observed.  That said ... I've done similar before, and then introduced =
a
> > major memory leak that under load destroyed 100GB of RAM in minutes.
> > Thus why I'm looking for a few eyeballs on this before going to
> > production (what we have works, it's just on an older kernel).
> >
> > If further improvements are possible that would be great, but based on
> > testing this is already at least a 10x improvement on readdir() perform=
ance.
> >
>
> I think you need the patch I linked to or this could cause crashes.
> The patch adds support for copying folios larger than 1 page size in
> fuse. Maybe you're not running into the crash because it's going
> through splice which will circumvent copying, but in the non-splice
> case, I believe the kmap is insufficient when you go to do the actual
> copying. IOW, I think that patch is a dependency for this one.
>

Update: I looked more into this and I was wrong, you don't need that
patch as a dependency. In fuse_copy_do(), the number of bytes copied
is still done page by page regardless of how large the folio is (eg
see ncpy =3D min(*size, cs->len)). So please ignore my earlier comment
about this potentially accessing memory that hasn't been kmapped
properly.


Thanks,
Joanne

> Thanks,
> Joanne
>
> > > [1]https://lore.kernel.org/linux-fsdevel/20250123012448.2479372-2-joa=
nnelkoong@gmail.com/
> > Took a quick look, wish I could provide you some feedback but that's
> > beyond my kernel skill set to just eyeball.
> >
> > Looks like you're primarily getting rid of the code that references the
> > pages inside the folio's and just operating on the folio's directly? A
> > side effect of which (your goal) is to enable larger copies rather than
> > small ones?
> >
> > Thank you,
> > Jaco

