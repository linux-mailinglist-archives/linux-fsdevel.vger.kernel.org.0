Return-Path: <linux-fsdevel+bounces-51185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA373AD425C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A58B16FA5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F61256C84;
	Tue, 10 Jun 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moEFz2gl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73020A5EC;
	Tue, 10 Jun 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581935; cv=none; b=WroenDr0vWzQcW6Hn+sT1zmFJ9j0JE82o8AdHvIZQcOa/Sy3x++pDHu6GyKbj3ryDgV85cVje+H/fi/FFDY/hvYTCZyc4i85yQ3WWhkQ0gpHT04roWP1HcMoqmTnjrHDDTJGK2mGSXv7o0n4mdLFoLtSB7Qb6PP6DcelciI2gCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581935; c=relaxed/simple;
	bh=D+1hELWANpxNWxU1ev75dZ8d/Wvj1f0H958b6AgOt1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtWv3LO1Fr2xD9Yi9NhEhtdLJZC1+YOxO2sHGZCqZbIGJkeaIdANQuC9RX6vv22YY31qLMRmk4f5ndxAfnCvVlu2TNrauqgtNN+OqDugaLRa+sShnzoDUJmb/IFLlu8LZayBM9OC0OioSU8Iy3LZI5KaQIw/QV/SQw6X7kyjrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moEFz2gl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso1858211cf.0;
        Tue, 10 Jun 2025 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749581933; x=1750186733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APy6IsiaxStLeex8yxExQ4OFXguE9K4A7CnbkvjJZp4=;
        b=moEFz2glw3KxXCXtL6+8wlJ79msGHexxfITyN4GGm87PXWXWqStyXzO+bD0m14WHMC
         o1j6J3HvoO7X8sbPx2noULSITckAm4XWbQDqvm0W54dTTQqi/1gxXoQa3D/J1Dxi4AjW
         MN78UtngiQKjbHlOMvfUYfLjOjl4s8SFq/uPk3v+QkbvoOYMK8RQVb25KsmDuXvOBMCJ
         1eVx2P2PGuXDNY6UWih6AvhJ0W3NK6bAyL2m7XkemSec7Yu0xGhVAe1TQKEGAQzSPEzU
         zctPay0faTDP0ubjuls3ugFXRwicE0QoBx3nZjSmlipYtMd1oYYdyje1L6h0DOP6x7x6
         gi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749581933; x=1750186733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APy6IsiaxStLeex8yxExQ4OFXguE9K4A7CnbkvjJZp4=;
        b=Jwib/vLgxHkZcfV03vmA47mSPaH8KNjxtk8xU2bNp9Ff957sfa0HEWSsFfERgzuorV
         EjdqhaVSQFiXxFXaXex6dqUyYCJ7wghPmXXHgKfqFPVabAZS+NczBbjvoI/RlPfrITjP
         3LQGEJjiLpOiTqncTA12Nr/H9lKhzstYAb2asB97omtT/gpLka/OhNLl+BMdLZdMweEc
         mo/f8qyDnv8yOYLmxc2NuNX7CQN8jRImIXuevatRADn3wSWfycPFvsq/h06N+NvlKbXO
         ux4a7zdkA7L8JOL0Z61RcGnTi1omFDPcCEBPv9+aAeQ2HidXAM+sdCQwBcCeTSBpy05f
         UFhw==
X-Forwarded-Encrypted: i=1; AJvYcCVwPVmmSC9MKmoaLVGLDqgMVbmZ3qLMHP0cnlg+9UY/mUFjx699FmfL+uNy7KXJCDy6K4YGaZ+M3ikBB5go@vger.kernel.org, AJvYcCXMSPLgCN8ZQ85vp+UZZf4Pl/Y5ITA8pU9uZ3PhjjGBA3QcHeWPbkXf1KODU58pY5F+G2srM6nkNhzx@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSF5B5p9icJhs8lwgOE+nIJW1XoLYoOxpay+dae/U5iAZNeFo
	fUDHk+ePUAeC3ufoDKIuC8PFXYXZ8VPC9qSXHXxh74ZziGV0GV5v7ebOCDek3tlNQaaH5UihESC
	2sXAX8cYyaLA5rR1PPfYoskLN7pBN1Gk=
X-Gm-Gg: ASbGncu6gNrTm47qekIOYjpEkGBRMQXW91tkL/TLUI+PkeJvozS22CThktEbp6pEUVY
	HI41NtAt5tvBzTZII8dX85F6HWDOq8bVOjIaBUjMqZATkVk4k/U/ZMW5fwsHmAsUyg5wmoHn65j
	Hxy5UHs4VNW5AAP/Vge932+lW9e4gg8OUIzUmBBfJr5x7D/vNTcJ5wmQ==
X-Google-Smtp-Source: AGHT+IFNiync1q8ex7/+948MBgzHp8mLIc8coPj4LmCOl8GV3le+khfr3G81wYr2HCsDbuX+llTAfC+4EeHuxVj0Dg8=
X-Received: by 2002:a05:622a:1c0c:b0:47c:fefb:a5a with SMTP id
 d75a77b69052e-4a713c7929amr8086671cf.11.1749581932997; Tue, 10 Jun 2025
 11:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com> <aEZx5FKK13v36wRv@infradead.org>
 <CAJnrk1ZuuE9HKa0OWRjrt6qaPvP5R4DTPBA90PV8M3ke+zqNnw@mail.gmail.com>
 <aEetTojb-DbXpllw@infradead.org> <CAJnrk1YNM5fotdoRmmHi3ZTig_3GDb-kcSce9haZDxG97insKw@mail.gmail.com>
In-Reply-To: <CAJnrk1YNM5fotdoRmmHi3ZTig_3GDb-kcSce9haZDxG97insKw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Jun 2025 11:58:42 -0700
X-Gm-Features: AX0GCFvfosFWf-7jWIAI9O3VGbR3YJwjOI2QpoBmVzv1LKoDt8_wwb_OegIpNYo
Message-ID: <CAJnrk1a4VmaBhmjAjhBtcjFoa0hUgOQLj7dQc0x0C70a-Ms+5g@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM iomaps
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 11:23=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Mon, Jun 9, 2025 at 8:58=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> >
> > On Mon, Jun 09, 2025 at 04:15:27PM -0700, Joanne Koong wrote:
> > > ioends are used in fuse for cleaning up state. fuse implements a
> > > ->submit_ioend() callback in fuse_iomap_submit_ioend() (in patch 7/8)=
.
> >
> > But do you use struct iomap_ioend at all?  (Sorry, still don't have a
> > whole tree with the patches applied in front of me).
>
> I don't use struct iomap_ioend at all and I'm realizing now that I
> should just have fuse manually do the end-of-io submission after it
> calls iomap_writepages() / iomap_writeback_dirty_folio() instead of
> defining a ->submit_ioend(). Then, we can get rid of this
>
>  int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
>  {
> +    if (wpc->iomap.type =3D=3D IOMAP_IN_MEM) {
> +       if (wpc->ops->submit_ioend)
> +          error =3D wpc->ops->submit_ioend(wpc, error);
> +       return error;
> +    }
>
> that was added and leave the iomap_submit_ioend() logic untouched.

Actually, nvm. You're right, it's cleaner to just have ioend stuff be total=
ly
abstracted away like you suggested below. I'll make that change for
v2.

>
> >
> > > > Given that the patch that moved things around already wrapped the
> > > > error propagation to the bio into a helpr, how does this differ
> > > > from the main path in the function now?
> > > >
> > >
> > > If we don't add this special casing for IOMAP_IN_MEM here, then in
> > > this function it'll hit the "if (!wpc->ioend)" case right in the
> > > beginning and return error without calling the ->submit_ioend()
> >
> > So this suggests you don't use struct iomap_ioend at all.  Given that
> > you add a private field to iomap_writepage_ctx I guess that is where
> > you chain the fuse requests?
> >
> > Either way I think we should clean this up one way or another.  If the
> > non-block iomap writeback code doesn't use ioends we should probably mo=
ve
> > the ioend chain into the private field, and hide everything using it (o=
r
> > even the ioend name) in proper abstraction.  In this case this means
> > finding another way to check for a non-empty wpc.  One way would be to
> > check nr_folios as any non-empty wbc must have a number of folios
> > attached to it, the other would be to move the check into the
> > ->submit_ioend method including the block fallback.  For a proper split
> > the method should probably be renamed, and we'd probably want to requir=
e
> > every use to provide the submit method, even if the trivial block
> > users set it to the default one provided.
> >
> > > > > -             if (!count)
> > > > > +             /*
> > > > > +              * If wpc->ops->writeback_folio is set, then it is =
responsible
> > > > > +              * for ending the writeback itself.
> > > > > +              */
> > > > > +             if (!count && !wpc->ops->writeback_folio)
> > > > >                       folio_end_writeback(folio);
> > > >
> > > > This fails to explain why writeback_folio does the unlocking itself=
.
> > >
> > > writeback_folio needs to do the unlocking itself because the writebac=
k
> > > may be done asynchronously (as in the case for fuse). I'll add that a=
s
> > > a comment in v2.
> >
> > So how do you end up with a zero count here and still want
> > the fuse code to unlock?
> >
>
> count is unused by ->writeback_folio(), so it's always just zero. But
> I see what you're saying now. I should just increment count after
> doing the ->writeback_folio() call and then we could just leave the
> "if (!count)" check untouched. I like this suggestion a lot, i'll make
> this change in v2.

