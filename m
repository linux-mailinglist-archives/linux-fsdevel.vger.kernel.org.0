Return-Path: <linux-fsdevel+bounces-72702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0725D0093A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 02:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA4A3012DDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362062222C0;
	Thu,  8 Jan 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9NfiEzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758F19E97F
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836576; cv=none; b=dC1Huz2rp65JpzifTQIi1s6FOAglS5Z+cpg66SVW0sc7UDZfZsFzY1Fq6wGcTP5pyKAnIkzO6Pdhq9gGoO8nactOWqNgqd1Tfmi+G8Fm6RqzrlUbO7xd3puI8UJVI4g+D40afgrK+XFFxAdvt0DV93XXpEhD7YJ9rq7jt0C+CC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836576; c=relaxed/simple;
	bh=vGn5f8R4n5Tv+PYBxiK33McC5mMuLsCPZT6bFEZjMxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rX8WfSEZOjZHKtVeFdTJmfgP3wux9L2YObNT5KTrMideMffTrtIb5l+4XeodJVXdXRA5iM56Xw/9kv3hBHyx4tMDGW5+3JOgLkdweBaMIvuvrmZeUjunuEcMWDXUmN8te76u8xYaFT7VWbEOjxVSnePfL3BMToPeogHm8AS2cDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9NfiEzt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee1a3ef624so17241781cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 17:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767836574; x=1768441374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya7QrZjdbEPJavTH1nvKPtO5aAZi3mHQ4D+/qy8P/HU=;
        b=Z9NfiEztaQdyXNqZew0YaMFiGcJux7DqNjL09S24iajICPQx31e0H+hpC+3FKaGt/r
         QCKuQTLba/6ZIdbrGjQW7XedkdwyKoUB5+n1xXaOJs6rPLqIBRstKZD1zkNAqCnKG2yG
         mprA3jCN4vdYsc0JAAr/X7hHIf6MykDg5WD3gDXoc+Zowvpf66qWHhOkuQ6m8oTmZgbo
         mQsXX91rWTi2taXXF+MkkAuLA6nKGUU9wpSxp+Wk7O6PtCZI5D5MQQmzEM1yyVMF5reu
         cm40Vyh4B2Ja2YvY039oo+SlQwBv4AXm/IhHQ1V0Maz79mk/5Wj+slE6PiIFViX5h++L
         1exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836574; x=1768441374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ya7QrZjdbEPJavTH1nvKPtO5aAZi3mHQ4D+/qy8P/HU=;
        b=hnlAUaNCMUYhfQ0mrbylIllVJEab0VA4l2klkx2fiynxf0v3c4qlXrNB5Ks2F3HqYw
         GDLaaqO4bIbAC9xIj1Rd0rUzpS9Prh6OZh7pEylmLj+/Eu91HjEUiCeiMjkFblu+alt8
         AfeBDs7vvrE6MchkeaJ/Knm95jlGOQ3L2t7EBky50mR4xbn5fHwThBniLT8bxyzAUyKV
         UFoHoEXHcygjAHfJyCx6zu1apiWCpMV1q/2uy9Tri+aBSv6nbD+aCjV+Rz71oBTwP4+r
         oQWxpCP9fAxpznqJNZ5l1ZGfLzy+supqa87w3rf6C5qegYAvt7z1ls1nZ0YwTxXxGQFW
         2rYA==
X-Forwarded-Encrypted: i=1; AJvYcCVhvTYG1Md0krzFJl/zSyxaz6eplUCR0OyfJdTgtflw+Agx71vjPV9+eaYLE44y2Nx6uCa89RrCsnA3HrLs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Y1eTJ5zGrbXzTw/3zuPXg8rM3a0Tpu7GGlWo0w7J/wgfmb+8
	vf7FPIXawUp7kAiwkEja+5mBZq6MOAhgNVyZxrjjxbbfwRTJfccHdykGBMqF7gIfD9oEk5qUcpI
	4vb0fVkTzTl+dWuhWNrIlIXhwPrVprVgu7AWc
X-Gm-Gg: AY/fxX7/VpMeZVsYLMFtssZIYIHAYs6LyPhkodYubDf5mEj0xW7c8cgM4WlRW/+7k+1
	eK8mw1okXSgAmdxET/gYl/LAF+z+jOJV2DcEYlcV5KQ5pMQngdYk0xlZ3FEF/zQPSds/o5cplG0
	JHeBxcHHUinZtR4Jz6fpWiAhZRf24gyylsyia/sgsNArk50jAC9MlJyQXHuPIUkFx/9ICJ1WmYo
	Cf9VaeeJ0Twl1tMqQH0UC5RkGO0jVp2qRsHPZLL7L5vcvuG2XiZvI0kSJHrP2grfLhsHA==
X-Google-Smtp-Source: AGHT+IFCo6wsTDLXrSciTG1+8i26J1JxpB1AOA4ukqpTaP5lIt3+5cOoXADkVGASqCpwV6KnXQQ8gu8lSwQFW9bfaQc=
X-Received: by 2002:a05:622a:5888:b0:4e8:a850:e7db with SMTP id
 d75a77b69052e-4ffb4abf07fmr59235521cf.71.1767836574171; Wed, 07 Jan 2026
 17:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
 <20251223-fuse-compounds-upstream-v2-1-0f7b4451c85e@ddn.com>
 <CAJnrk1b-7zqqDG+vROx=eALGkrM3oU-KDx1zHZtj=F5zP+oaLQ@mail.gmail.com> <aV5l5OxMuyYs8mzQ@fedora.fritz.box>
In-Reply-To: <aV5l5OxMuyYs8mzQ@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 7 Jan 2026 17:42:42 -0800
X-Gm-Features: AQt7F2pBjdqkO2hx5o_Ok4RrYeA3jgPp3diWHoARm4LFMLmzUgMNKPCcoEzk8mE
Message-ID: <CAJnrk1ZanYaUymGnU83imfAu-FQ-qQHRX_ys5B=5daoWvbp-gw@mail.gmail.com>
Subject: Re: Re: [PATCH RFC v2 1/2] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <hbirthelmer@googlemail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:03=E2=80=AFAM Horst Birthelmer <horst@birthelmer.d=
e> wrote:
>
> On Tue, Jan 06, 2026 at 05:40:52PM -0800, Joanne Koong wrote:
> > On Tue, Dec 23, 2025 at 2:13=E2=80=AFPM Horst Birthelmer
> > <hbirthelmer@googlemail.com> wrote:
> > >
> > > For a FUSE_COMPOUND we add a header that contains information
> > > about how many commands there are in the compound and about the
> > > size of the expected result. This will make the interpretation
> > > in libfuse easier, since we can preallocate the whole result.
> > > Then we append the requests that belong to this compound.
> > >
> > > The API for the compound command has:
> > >   fuse_compound_alloc()
> > >   fuse_compound_add()
> > >   fuse_compound_request()
> > >   fuse_compound_free()
> > >
> ...
> > > +
> > > +       if (compound->buffer_pos + needed_size > compound->buffer_siz=
e) {
> > > +               size_t new_size =3D max(compound->buffer_size * 2,
> > > +                                     compound->buffer_pos + needed_s=
ize);
> > > +               char *new_buffer;
> > > +
> > > +               new_size =3D round_up(new_size, PAGE_SIZE);
> > > +               new_buffer =3D kvrealloc(compound->buffer, new_size,
> > > +                                      GFP_KERNEL);
> > > +               if (!new_buffer)
> > > +                       return -ENOMEM;
> > > +               compound->buffer =3D new_buffer;
> > > +               compound->buffer_size =3D new_size;
> >
> > Hmm... when we're setting up a compound request, we already know the
> > size that will be needed to hold all the requests, right? Do you think
> > it makes sense to allocate that from the get-go in
> > fuse_compound_alloc() and then not have to do any buffer reallocation?
> > I think that also gets rid of fuse_compound_req->total_size, as that
> > would just be the same as fuse_compound_req->buffer_size.
> >
> After looking at this again, I realized it would be more efficient to not=
 do any allocation
> in fuse_compound_alloc() at all except for the fuse_compound_req, of cour=
se, and then
> do all the work in fuse_compound_send().
> We keep pointers to the fuse_args given to the compound command anyway si=
nce we need
> to fill out the result, so why not keep just the fuse args and don't copy=
 anything
> except when actually sending it out?
>
> I will test this version a bit and make a simplified v3.

Awesome, looking forward to seeing v3.

Thanks,
Joanne
>
> ...
> >
> > Thanks,
> > Joanne
>
> Thanks,
> Horst

