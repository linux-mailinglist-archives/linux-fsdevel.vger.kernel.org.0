Return-Path: <linux-fsdevel+bounces-45391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E57A77054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8190B1888124
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8821C195;
	Mon, 31 Mar 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLif/QjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C021B9D1;
	Mon, 31 Mar 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457697; cv=none; b=esLA8WCniVjFzxSxu4xjx5aNEQbfjoVfMufrqoD6RU1cgxNVfdW6oB4yDMKJLUnKgayvzzNDbbNZ5SEmVs0WncZQ5r27ZB+2d0uhmq3o3jW0Q7rmZSy+CL8ImTg3koTXrxWlNpF5ldeGOjUnatc4p0uEZ+shZGfbNKCGphyKT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457697; c=relaxed/simple;
	bh=7tZiZd/j3y3N1NrmqeFd1/H8utQgf+EZTEsfLzvTK8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsbjchbYj3qK3dlJN0ML4oNvoASlHg5g3phDepvP0bZj75NKe+w32qlqSKfoHxWFgMdup6bqK20d+rFyeM8UGjp2irie6pDAdFaQS+iNz99witKNmE/B4izKYJuqq9TKWQ26jhhJVM+Gls4x9VyyDPHW9mvo2Xefr3tM3mXQKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLif/QjF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476ab588f32so70425131cf.2;
        Mon, 31 Mar 2025 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743457692; x=1744062492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad79aRTfa+0eNUhNq8HxKXJsgzRsdFq80zCNM0ZLlhc=;
        b=dLif/QjFf4pw4mjTn+X+TgGyB0KhAyxkvQSwIts1HOhvLgcGAf71ZcCx/x/QdaIskH
         +0PuLVjOrhWP94cObteRYFA2E55K5eRbJ6KjaqpbqQIePM27xR7e3TsgF9IY0hMYZEsM
         uENeh9kIc5fBWYCvhueNH7aoeXoOe1By+c57ra3jmL5YjXDRtq0L1yEE/ATB1cjYoe5D
         phK4H7Q+veC8jkAwr4aqD/BX10b+7z0bMbYLW43bJSL7sBy0AzujjA/8cWVnvhy5zmfk
         Z38UnWcb3qpIqncvrvk0q7Bej9ULcNfQ/N+DdJhOg0ar960CJRWBFBtLzgYF0RSGA4FA
         1UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457692; x=1744062492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad79aRTfa+0eNUhNq8HxKXJsgzRsdFq80zCNM0ZLlhc=;
        b=ktLG/kOR+fqFJqipcexM4R2dHRajjc5k1K8Yf67UepUIwTqIebZtm74GGJ+hrwSIBG
         vvRiwUWI0Ta//yziPmHy6rJglbG2rxdbC8CoEh3sdDJ25uxoDrT9amDiPXeuOHVPhgmb
         F4j/y4A7O538QqYC20Y6lFfQfWMEutAjEm7WfwW+229lAB39pNzYDzK9+Q0esRBcq0fM
         xAZRQHjvcWginHYeZ7zrH5wU0cgE8I/CX26AYm6tGl5xWeErt4rvF88HKkCau0kYXtgq
         l9cOX8SncNoNA4P986Ibl7+hgIXZQ9He8FsxzH+Lkhqoinb4i1BvH6Rs8RnbCfQD4HEo
         9Z8A==
X-Forwarded-Encrypted: i=1; AJvYcCW3dRZyTSang68MAKkrkPGRzDppVDiSbbP460nqnsjENKOPxMZQmPHPxLpKQudRjcjClnVoCkhJzxpzitwk@vger.kernel.org, AJvYcCWLeQsNPtkODqWPC5W2XD/rUHkhHm9FXVXIi5OXxVdf8X4/QQvo4YjDpwYrlmIMdvi9QHNjuswQA7YZ/MWN@vger.kernel.org
X-Gm-Message-State: AOJu0YzwzuS8BR/HBs331P7Hf62yV/TcEOughacutrA66aVZPMqHcHnY
	DLtEc5ezyP8bzkTdUKcxzM9nosMti7Tn3V0/TztFQkkloNwZnv8ma536Rh5udvB/i+jTkQMW1fn
	PiXO8MAyauMVrTY1RYnMTXgQ83F/DFg==
X-Gm-Gg: ASbGnctwOgFG+DKfrQWWmUZH6vj2TtYZl+9U6hqWlFf+8+a4xuVBrsAGWl2cHrBWrDb
	Dh+3aGEO1sGp7of8pQ+RACHN5haODRqURSCOviThK2a/aj/D+8bKdEG6YzM2oZhsIuVD4EzKM8s
	ifjZuXbYv/IAfNnwwDuUmnwnYUYeee2/FxhH9t4VL00Q==
X-Google-Smtp-Source: AGHT+IGM/dqVoDa9j5ggEk7chMrFfZiIoMyb+U/Wc91ud/PZ/ja3N9I52t+2/RfUF7hoOjpFwVMkQWJnxsO7791Hnd0=
X-Received: by 2002:ac8:5893:0:b0:476:74de:81e2 with SMTP id
 d75a77b69052e-477ed75ba4dmr175711341cf.43.1743457692478; Mon, 31 Mar 2025
 14:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727081237.18217-1-jaco@uls.co.za> <20250314221701.12509-1-jaco@uls.co.za>
 <20250314221701.12509-3-jaco@uls.co.za> <CAJnrk1YqO44P077UwJqS+nrSTNe9m9MrbKwnxsSZn2RCQsEvAQ@mail.gmail.com>
 <ffeb7915-a028-40d8-94d0-4c647ee8e184@uls.co.za>
In-Reply-To: <ffeb7915-a028-40d8-94d0-4c647ee8e184@uls.co.za>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 31 Mar 2025 14:48:01 -0700
X-Gm-Features: AQ5f1JrFlEqza0khvurwGBGniFhYg8BMDkqrK_HHWasuQlxjGlsZBHvQiGKjmbM
Message-ID: <CAJnrk1ZBDLim8ZK-Fc9gXUVht9rJOdSTKO+fb+kxoGpWuwTu9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
To: Jaco Kroon <jaco@uls.co.za>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, rdunlap@infradead.org, 
	trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 1:43=E2=80=AFPM Jaco Kroon <jaco@uls.co.za> wrote:
>
> Hi,
>
> On 2025/03/31 18:41, Joanne Koong wrote:
> > On Fri, Mar 14, 2025 at 3:39=E2=80=AFPM Jaco Kroon<jaco@uls.co.za> wrot=
e:
> >> Clamp to min 1 page (4KB) and max 128 pages (512KB).
> >>
> >> Glusterfs trial using strace ls -l.
> >>
> >> Before:
> >>
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 616
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 624
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 624
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 600
> >> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) =3D 608
> >> getdents64(3, 0x7f2d7d7a7040 /* 1 entries */, 131072) =3D 24
> >> getdents64(3, 0x7f2d7d7a7040 /* 0 entries */, 131072) =3D 0
> >>
> >> After:
> >>
> >> getdents64(3, 0x7ffae8eed040 /* 276 entries */, 131072) =3D 6696
> >> getdents64(3, 0x7ffae8eed040 /* 0 entries */, 131072) =3D 0
> >>
> >> Signed-off-by: Jaco Kroon<jaco@uls.co.za>
> >> ---
> >>   fs/fuse/readdir.c | 22 ++++++++++++++++++----
> >>   1 file changed, 18 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> >> index 17ce9636a2b1..a0ccbc84b000 100644
> >> --- a/fs/fuse/readdir.c
> >> +++ b/fs/fuse/readdir.c
> >> @@ -337,11 +337,25 @@ static int fuse_readdir_uncached(struct file *fi=
le, struct dir_context *ctx)
> >>          struct fuse_mount *fm =3D get_fuse_mount(inode);
> >>          struct fuse_io_args ia =3D {};
> >>          struct fuse_args_pages *ap =3D &ia.ap;
> >> -       struct fuse_folio_desc desc =3D { .length =3D PAGE_SIZE };
> >> +       struct fuse_folio_desc desc =3D { .length =3D ctx->count };
> >>          u64 attr_version =3D 0, evict_ctr =3D 0;
> >>          bool locked;
> >> +       int order;
> >>
> >> -       folio =3D folio_alloc(GFP_KERNEL, 0);
> >> +       if (desc.length < PAGE_SIZE)
> >> +               desc.length =3D PAGE_SIZE;
> >> +       else if (desc.length > (PAGE_SIZE << 7)) /* 128 pages, typical=
ly 512KB */
> >> +               desc.length =3D PAGE_SIZE << 7;
> >> +
> > Just wondering, how did 128 pages get decided as the upper bound? It
> > seems to me to make more sense if the upper bound is fc->max_pages.
>
> Best answer ... random/guess at something which may be sensible.
>
> > Also btw, I think you can just use the clamp() helper from
> > <linux/minmax.h> to do the clamping
>
> Thanks.  Not a regular contributor to the kernel, not often that I've
> got an itch that needs scratching here :).
>
> So something like this then:
>
> 345
> 346     desc.length =3D clamp(desc.length, PAGE_SIZE, fm->fc->max_pages <=
<
> CONFIG_PAGE_SHIFT);
> 347     order =3D get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
> 348
>

You can just use PAGE_SHIFT here instead of CONFIG_PAGE_SHIFT

> Note:  Can use ctx->count here in clamp directly due to it being signed,
> where desc.length is unsigned.
>
> I'm *assuming* get_count_order will round-up, so if max_pages is 7 (if
> non-power of two is even possible) we will really get 8 pages here?

Yes, if you have a max_pages of 7, this will round up and return to
you an order of 3

>
> Compile tested only.  Will perform basic run-time test before re-submit.
>
> >> +       order =3D get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
> >> +
> >> +       do {
> >> +               folio =3D folio_alloc(GFP_KERNEL, order);
> > Folios can now be larger than one page size for readdir requests with
> > your change but I don't believe the current page copying code in fuse
> > supports this yet. For example, I think the kmapping will be
> > insufficient in fuse_copy_page() where in the current code we kmap
> > only the first page in the folio. I sent a patch for supporting large
> > folios page copying [1] and am trying to get this merged in but
> > haven't heard back about this patchset yet. In your local tests that
> > used multiple pages for the readdir request, did you run into any
> > issues or it worked fine?
>
> My tests boiled down to running strace as per above, and then some basic
> time trials using find /path/to/mount/point with and without the patch
> over a fairly large structure containing about 170m inodes.  No problems
> observed.  That said ... I've done similar before, and then introduced a
> major memory leak that under load destroyed 100GB of RAM in minutes.
> Thus why I'm looking for a few eyeballs on this before going to
> production (what we have works, it's just on an older kernel).
>
> If further improvements are possible that would be great, but based on
> testing this is already at least a 10x improvement on readdir() performan=
ce.
>

I think you need the patch I linked to or this could cause crashes.
The patch adds support for copying folios larger than 1 page size in
fuse. Maybe you're not running into the crash because it's going
through splice which will circumvent copying, but in the non-splice
case, I believe the kmap is insufficient when you go to do the actual
copying. IOW, I think that patch is a dependency for this one.

Thanks,
Joanne

> > [1]https://lore.kernel.org/linux-fsdevel/20250123012448.2479372-2-joann=
elkoong@gmail.com/
> Took a quick look, wish I could provide you some feedback but that's
> beyond my kernel skill set to just eyeball.
>
> Looks like you're primarily getting rid of the code that references the
> pages inside the folio's and just operating on the folio's directly? A
> side effect of which (your goal) is to enable larger copies rather than
> small ones?
>
> Thank you,
> Jaco

