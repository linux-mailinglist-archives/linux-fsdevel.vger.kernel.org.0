Return-Path: <linux-fsdevel+bounces-45892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A1A7E369
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E427A85F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962861EB5FB;
	Mon,  7 Apr 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai8ZGwTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416ED1D5AB8
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038226; cv=none; b=JdGHgdYQQfxQYgw7HaMMEhGfKmrj1hpNnH/HxB8by5ygeEY+CsewpC5N97SoUDmYBr0z3npI4KMsEiNSCpoFPUyEUtXQ8JR5dS8YJZmGf5MUVzCkHlNMfomtjiD81dKmvQDQ+GVKWV+XteaVAA/Z4xQUCFc52rtJE7IrptIKhJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038226; c=relaxed/simple;
	bh=ZkzKgBtVnXhC0u3nRk5kh0mdncLkbXCSTVcfy47EVlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEvlUPOH8uLPskse76c3LmlZpvFhodW8bAxqsr9oGAwR0R5EgvTVrrgyrUcvw5zDrcDrA0Jvjs5NXqK0l4i+9a9Yrul7QzMVuGmx/Ue46yFDIOLozaRvnldxnQkwuDhpq6awQWbWAPETb0lEQhxgosBjN1V0wQsBVov75C8E1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai8ZGwTv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3098537f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Apr 2025 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744038222; x=1744643022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkzKgBtVnXhC0u3nRk5kh0mdncLkbXCSTVcfy47EVlg=;
        b=Ai8ZGwTvXXknFE3ko0i2+/XVS/8VtlAh+QdItnahkwuH+M6cqRZTy8fsxlp53KoLTt
         Oozk8LwjPANwSlGyTD5J34ueZclaPIFC9AkapZbTxWQf1nMAknnN6hU4ToMtkr9fa6+t
         UWH4Zwhk2oCAkXOtg0u/xFd81giecw/vC7rK2+JQmjoGfKna6SyAD5N2sUAwdYHVDKzk
         KYCbLMJ0+mkc0ndWFwtI6Qv0hI+CmraPNVHn6EzFmExj+YHos32WH3uwQg7+bGjhe5/d
         SmYhD5XDtVe5Yc1fQ2YCZNwtmzNM22Yhlm3FccMu5BhogzPkKnuIuzZ5M31/4FOZuVIj
         9qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744038222; x=1744643022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkzKgBtVnXhC0u3nRk5kh0mdncLkbXCSTVcfy47EVlg=;
        b=d3mzi/SlWscZpB3Ooze2mQHSc/qbRnjor4pioWrqFHfCMSwPlAUzpm8YS03O+fAw7t
         xhHzPgO3DFSXwlzkbqeJSgV/Rryw+jZ283KQOKdquv3HapzA0kQuDW/fAiUqzdLkx9An
         T0pqdhgR2XiKZEQqo0m9VEIgulVG+IbM1BE+nTo/GBWZ1XX32KOWKzqYp6ijnooEtCSg
         td4cbqbL4RNb2Vk4vY7kO+4QUhTc8iLXA/ZvFOW3zCqnHcdc40CUbz0vzytJ/LWi+Pc7
         fk6zKHdlq5SCodN/fw9Lrz/u85h00G1nM9UgJwsCG4AZJaM3NgKk5TtxkSk6pWQwXcyv
         DvIg==
X-Forwarded-Encrypted: i=1; AJvYcCVrg9IJcJBvsM1slPz2QKQ159a1/qMIo8CoFAt/RAZ2un7++bSvl5txvHgTqcIhvo7qnYFUT6cMpIw8cFpS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iISoKj1XrCt265J+AhbGS1dKab+dnnagvblZoeWqt1LW7POy
	f+PcKZ3ErOH0DEUxPvb31pZ0ZMb9UVL9fsog/P1Rggm2KyfCKuT39c9wDvR0g+Npr8BZ8dAlmul
	nkmOsw5Fcls1Q+vG7CQNXnk72kyI=
X-Gm-Gg: ASbGncsJlJuZeNHUH8vXIxos9t3R0t8fDex0Ct4j+3b6M3d2j/cRfe1DWATEo95o5O+
	uGpqAaIBKu90XRYL3i5v+B0D3QPgLpSc7Ss1TUXKznIv5I9BGjYSJWFtj0Jh4+4Cm/1tThX4Wwn
	DJb1UsQj2vEmit0Asp/wlqPg3iOw==
X-Google-Smtp-Source: AGHT+IFoYQ642qkKuExSytuNUNWixnfWZVdQeQJbbZQYaCIiz49LSrMOCDXhk72ndfsIcHq/1SqsvI7PVE8MEXQgmLY=
X-Received: by 2002:a05:6000:240a:b0:391:bc8:564a with SMTP id
 ffacd0b85a97d-39c2e6510f0mr15240823f8f.22.1744038221590; Mon, 07 Apr 2025
 08:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331165231.1466680-1-amir73il@gmail.com> <aqagpfsdqt3prcruoypvcehtvux3qbzbz22wbirgftnp66i7ig@or2ntpsizmri>
In-Reply-To: <aqagpfsdqt3prcruoypvcehtvux3qbzbz22wbirgftnp66i7ig@or2ntpsizmri>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Apr 2025 17:03:30 +0200
X-Gm-Features: ATxdqUFmReN2LRoRfuAgpJxd4MJMjpN8Q3OX2zZQrW4AmAPnUgNSikWBHQgYSX8
Message-ID: <CAOQ4uxh0N-zQ2VXHZ1ahpr_ej3EAB6fiO3Lftc0XUYoRmsCbMQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: report FAN_PRE_MODIFY event before write to
 file range
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:39=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 31-03-25 18:52:31, Amir Goldstein wrote:
> > In addition to FAN_PRE_ACCESS event before any access to a file range,
> > also report the FAN_PRE_MODIFY event in case of a write access.
> >
> > This will allow userspace to subscribe only to pre-write access
> > notifications and to respond with error codes associated with write
> > operations using the FAN_DENY_ERRNO macro.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > I was looking on th list for the reason we decided to drop FAN_PRE_MODI=
FY
> > from the pre-content patch set and I couldn't find it. It may have been
> > related to complications ot page fault hooks that are not not relevant?
>
> Two reasons really:
> 1) Defining semantics of FAN_PRE_MODIFY when it is generated on page faul=
t
> was hard and was making the changes even more complex.
>
> 2) Without a real user of the event in userspace, I have doubts we'll get
> the semantics right.
>

Good now we have the reasons documented :)

> > I did find the decision to generate FAN_PRE_ACCESS on both read()/write=
(),
> > so maybe we thought there was no clear value for the FAN_PRE_MODIFY eve=
nt?
> >
> > In any case, I realized that we allowed returning custom errors with
> > FAN_DENY_ERRNO(ENOSPC), but that chosing the right error does require
> > knowing whether the call was read() or write().
>
> I see your point but if someone wants to read a file, your HSM server
> fetches the data and wants to store them in the filesystem and gets ENOSP=
C,
> then what do you want to return? I agree returning ENOSPC is confusing bu=
t
> OTOH anything else will be confusing even more (in the sense "why did I g=
et
> this error?")?
>

Good question.

One option (ENOSPC) may confuse applications and another option (EIO)
will lack the information of the real underlying reason.

I guess the only way would be to leave this decision to userspace, only
userspace cannot make that decision now :-/

But overall, I agree that this is probably not a very urgent issue and that
we can deal with it later and backport FAN_PRE_MODIFY if people really
need it.

I mostly wanted to make sure that we all understood why FAN_PRE_MODIFY
was postponed for now and that it wasn't just a page fault hook left over.

> > Becaue mmap() cannot return write() errors like ENOSPC, I decided not
> > to generate FAN_PRE_MODIFY for writably-shared maps, but maybe we shoul=
d
> > consider this.
>
> Generally, the semantics of events for mmap needs a careful thinking so
> that we provide all the needed events while maintaining sensible
> performance. And for that I think we need a better formulated understandi=
ng
> of what is the event going to be used for? For example for FAN_PRE_ACCESS
> event we now generate the event on mmap(2). Now what should userspace do =
if
> it wants to move some file to "slow tier" and get the event again when th=
e
> file is used again? Is that even something we plan to support?

I don't think that we should.

My HSM POC takes an exclusive write lease on a file before evicting its con=
tent
so any read/write refcount on the inode would keep the content on the
file pinned.

I did have a problem with another use case - for change tracking, generatin=
g
FAN_PRE_MODIFY on mmap() of writably shared mem does not quite cut it.
For that use case, it may make more sense to generate one FAN_PRE_ACCESS
range event on mmap() and page range FAN_PRE_MODIFY on write faults.

I am starting to remember why we dropped FAN_PRE_MODIFY...

Thanks,
Amir.

