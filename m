Return-Path: <linux-fsdevel+bounces-40948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2AAA2978F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883623A26C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB21FC7C4;
	Wed,  5 Feb 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hktiOsha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB220DD7B;
	Wed,  5 Feb 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776822; cv=none; b=btG+lr9zHZw5VNqLmTuMN4pUSFjTVJQuuPMok/VAlwoqjUL+XTSGHXX7sz1mLFpTz/shz9x0ghFZ9FGGroREFRwJAc8u7kQpsksi564UdB7tNsVtpV1nDxqWDWERrtU4PKWlCmnaL+o1IPLW9pOwoOeqypGp99Qj9637tmYF18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776822; c=relaxed/simple;
	bh=MKPHNas19qqkBTI12sz/ovREvZMO3CKZSC9PWh2Xuls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhNe11KOZWjU+3gLhdHTPJkdyx7IXj+TGmGOZvvBpiZn1PmdKdDp++sL/tIDidq6WSKkjx5gRyMlY+tKhP7XoPvGglbv1MZ52yBnoaI5HYhQ1YacnkphLoDXsWkp61R+ruEeQwIbC2OuvP9xYnXxr7B0TxafZQbe0Jy9iyQ+D9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hktiOsha; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dca4521b95so171071a12.0;
        Wed, 05 Feb 2025 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738776815; x=1739381615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKPHNas19qqkBTI12sz/ovREvZMO3CKZSC9PWh2Xuls=;
        b=hktiOshahu+yNuhQw0z15roKBsA8L/MMt/HULZ0mJclHSIFFgyeZ0L7pjhb/c16Dp5
         +JomCY3y3WkjP8akSUYLZY+mU6XKzBPRP6zxOzGHakPcbgu670pigXO9E8vAeyqh5gGf
         MKjWwc1pcHB9rvb6jrzXLkPKdbOtf/gnnFS0WHTv6uqFFCyxGNoma05cLP+Q/l1ZrtTV
         6nyzWfwRaDdT0LMXQKuBdGe0VFtHN0Wme7YPXhMwIc7vtj8qYgIKNzlf9JK+lJV5tbke
         aaDG72GJxveDOq18/sjfiM7wwdbE7hi/hD3UjyNHFsFH/CBNi9DTE5Y/TuelfBqfRcUU
         NRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738776815; x=1739381615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKPHNas19qqkBTI12sz/ovREvZMO3CKZSC9PWh2Xuls=;
        b=KlPHzaRF/+S83kkcOJzXvXlRBwY1YoJz95TPClNxuaZ7pRqR7tgiOhsUsl4FRJlAt2
         /VGz/lJKBsLGhdrGcInfnmbkytJSM5her9u5iiFiIcjbaaABBGNQvJMnF6RbZhr+JFZi
         jbWFznkn6kx40xK6+k+5uLbJ+lDxNxdVsxiGDWUUSWNLafyykRaF7iYwZpvkJnhPNUjz
         JA7IuqEn8KbYjekTOpn1LUiWSvnrdgtixQRFAmW5J0lUJCJzCTb8RgyvfFRhon40SS4A
         az6NUzq2gqwwA7AHfp8AjmcmiGm7roBjpMsCNe+IDdSpvrs/WW73jtIJsEsas3sgG+HW
         FR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1xGD+scm16/6DavZEjJ6Bnl3N/QhXFB3f8uTde4uT/ROZbQaIL06lqte4gbh2CgHxuGo0uHhGaQIBNfF+@vger.kernel.org, AJvYcCWFhnda8O6063zy0TwlcojhiL13+wCZs/M7YYTe2+7WjQ/Etgel/60DtgVv1hbBz7A+ppE5cARgIEXDpR0iOg==@vger.kernel.org, AJvYcCXfbG3iN9pq+nRVXcDo1qYSk7gnfUqrfOkR7jW0mN4K3/HFq6q6J9Tth6C6zyPXt27ywDy75nePGLOt@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWYX+MIFiDFJ4FynVBRHEUw2i4F5krCA4TRzyt7i1fId/WnyY
	7pjbVimILtONWIecTuFF33791SSlpB9YwI3JKL9awBXcMbGqi+lPS4VbWD59jfpjps15d/22dBe
	i1dHKMz38AgJm947mkQzzmxLEFIk=
X-Gm-Gg: ASbGnct2NBruUWYcMn2WTjbTiz7FcNS3GiSxkZyWKvFEnrlRQIA/o1C6jfjIVBFua9y
	KWIyi8IB7tiQseFeL6ZtLoxeNJoI7kodh70/ibef/jFtyDAzqKK2cDEp/TGISLjRYnq6t7FE=
X-Google-Smtp-Source: AGHT+IE8NZGcazIn0O0pjPOEw6NLheDND12VRqK45Gqvfj+bTwKaxCGHt1N/jm+Alk35OWiOR5kb9ySaxfEcZpgP36U=
X-Received: by 2002:a05:6402:3707:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5dcdb732c6amr4444644a12.10.1738776815351; Wed, 05 Feb 2025
 09:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205162819.380864-1-mjguzik@gmail.com> <20250205172946.GD21791@frogsfrogsfrogs>
In-Reply-To: <20250205172946.GD21791@frogsfrogsfrogs>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Feb 2025 18:33:23 +0100
X-Gm-Features: AWEUYZk_FtZ8QbXuoj7m9fQEbQWlDe9DmnB22U0ngHlCxWb6HRWszue-hycPV2Q
Message-ID: <CAGudoHENg_G7KaJT15bE0wVOT_yXw0yiPPqTf40zm9YzuaUPkw@mail.gmail.com>
Subject: Re: [PATCH] ext4: pass strlen() of the symlink instead of i_size to inode_set_cached_link()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, tytso@mit.edu, kees@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, 
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com, 
	linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 6:29=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Wed, Feb 05, 2025 at 05:28:19PM +0100, Mateusz Guzik wrote:
> > The call to nd_terminate_link() clamps the size to min(i_size,
> > sizeof(ei->i_data) - 1), while the subsequent call to
> > inode_set_cached_link() fails the possible update.
> >
> > The kernel used to always strlen(), so do it now as well.
> >
> > Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> > Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > Per my comments in:
> > https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNk=
QoTMaDHg@mail.gmail.com/#t
> >
> > There is definitely a pre-existing bug in ext4 which the above happens
> > to run into. I suspect the nd_terminate_link thing will disappear once
> > that gets sorted out.
> >
> > In the meantime the appropriate fix for 6.14 is to restore the original
> > behavior of issuing strlen.
> >
> > syzbot verified the issue is fixed:
> > https://lore.kernel.org/linux-hardening/67a381a3.050a0220.50516.0077.GA=
E@google.com/T/#m340e6b52b9547ac85471a1da5980fe0a67c790ac
>
> Again, this is evidence of inconsistent inode metadata, which should be
> dealt with by returning EFSCORRUPTED, not arbitrarily truncating the
> contents of a bad inode.
>

I agree, rejecting the inode was something I was advocating for from the ge=
t go.

I don't know if a real patch(tm) will materialize for 6.14, so in the
meantime I can at least damage-control this back to the original
state.

If the ext4 folk do the right fix, I will be delighted to have this
patch dropped. :)

> And, seriously, cc the ext4 list on ext4 patches please.

Ye that's my bad.

--=20
Mateusz Guzik <mjguzik gmail.com>

