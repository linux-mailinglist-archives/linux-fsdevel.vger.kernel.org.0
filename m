Return-Path: <linux-fsdevel+bounces-31863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A499C48B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4B61C223AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0440154439;
	Mon, 14 Oct 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwTh0uIY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E691BC58
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896527; cv=none; b=Vrtq9VoXQIlLX0R15lWCrc4bBYlOoES/LRm7mzxE8EiMv8RK3lgC59W1JXC7nAQBY6qoSkZ7cl8WWedrpEXZMOp7ofl+xo2d9+KOgIFybB6BvfRwUz1cIQ/Y/iahOyWx2NIbCaZfhWDrzo6Squv/OUwOY1oLwA+jN9/ZRSmKCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896527; c=relaxed/simple;
	bh=Bh2Js8LMsu4AGlz1XApcZDI8Vn/4leVuA4ecTZi24oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/BctbRM9MEdahE1t+xRdxFRDU9GJWF9DmWC6OyYVtw3pFKEdMrvixkR8NPhAa/wLoBKn3ah7rmZNO8Yut5urW3nDyT9d8aF/eGlhN69ennIysv4tIHXAwg0C82D3ZRSoR9GqZGjVFCbB0MabBpWerFM92o48/8btycVViZdMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwTh0uIY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b02420b600so410527985a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728896524; x=1729501324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhubmrQFPlYDQh+IfA/4kn7p33DK3tumliihQ4oC7bs=;
        b=gwTh0uIYiRq6ItvaYPKk+/W/B8mmejs324e9a+QC1Yrd9gnxQ7Z19Q40de53mwU7tw
         dQt0lWC9Dx/L2I6dTvVjf7dLx7OWv7pHsFKyLmsusAuF4FIZ8mZ4xL6KqeTAwgNvqknl
         8zw12IeUvFczUVTjE7K/eKxNSGTUb60lIu221ElVhuL/2tjs8vIq5J7oY54nexZK3iU6
         wpIP32q0RPjyS4VCiVO8XTjQiHVpTPwb3hR8k3yEWcY2VA12Hsc1EH6TiHGbNrO9y8/6
         i9pvUZdx3pzs5m17PCyc5XbEkIEDT1ji6+YBeL1qB4LklUbKNdKVHbxZ+fypts7vtD/H
         NxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896524; x=1729501324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhubmrQFPlYDQh+IfA/4kn7p33DK3tumliihQ4oC7bs=;
        b=bb9v8eByHoTXMB1Ly8xDNBi+om1vBsNR//BHSDsDMO67Y6qQ8BmG1E049UhGWGC9+l
         a5HN/434k9J3R2RliUFDZdLRa7S+wdW2m3Js7m/0gw9tdxczpsFHwG7e+ECEGohtIQfK
         UBF+6wmZ9Drg+7SnTtoUlrAMUrjH0YU+GO6oSuH/AbnRudV/IV2CE2S6OObNuUAliFGn
         ONytr7lMrYCnFldVoCZRmK50fNcyx4lZlV5oo+G4nTPLsh/mIILsdCBmGFv0GqUp1TH4
         C27GQXD+j1pl4RgDK2zkCTalEooJShCVP2eE3my7JZ6ajpZHO9lZPTMaIxBRzVAIoRzS
         pkZw==
X-Forwarded-Encrypted: i=1; AJvYcCWbFFl6boCqxAm0Fjll9vXHY7HEFyaFPe/dfxsaz1YoGLWsv0xgypHyb52j4tn0rAy60LJ3gz993xNXpwuz@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrkPbjdJXwy3ymsQBToriSupfWQwrX6OpOs1Q3nBVl1V39h51
	B/4a4ZXmhQfTvfNrhHHnpIGngMzOn5D0psNqWlG6ZSK9gFmRLjKUKUOuy0UAIU/3zsbnPFxzD1t
	N3Dc2lJYWv74myDZpWYrnecD6Hh8=
X-Google-Smtp-Source: AGHT+IGEJCuoMCwRp0jRxYcQR/IOSk0voEOrfOnv4EK2+Af/sw2vvoQRE7vGbNRvcS4XzG1QdXdZAztMGs1Vyug+P8g=
X-Received: by 2002:a05:620a:3f85:b0:7a9:a63a:9f48 with SMTP id
 af79cd13be357-7b11a342f72mr1507166485a.11.1728896524424; Mon, 14 Oct 2024
 02:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011135326.667781-1-amir73il@gmail.com> <CAJfpegsvwqo8N+bOyWaO1+HxoYvSOSdHH=OCLfwj6dcqNqED-A@mail.gmail.com>
 <CAOQ4uxj1LjzF0GyG3pb+TYHy+L1N+PD59FzBUuy0uuyNLgW+og@mail.gmail.com> <CAJfpegs=cvZ_NYy6Q_D42XhYS=Sjj5poM1b5TzXzOVvX=R36aA@mail.gmail.com>
In-Reply-To: <CAJfpegs=cvZ_NYy6Q_D42XhYS=Sjj5poM1b5TzXzOVvX=R36aA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Oct 2024 11:01:53 +0200
Message-ID: <CAOQ4uxjU+wkOwVqVFb2ECrLmdbTPJLaAoymbV1Xc9a3C4wT4Ug@mail.gmail.com>
Subject: Re: [PATCH] fuse: update inode size after extending passthrough write
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	yangyun <yangyun50@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:40=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 11 Oct 2024 at 19:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > But why do we want to avoid copying attributes from the underlying inod=
e?
>
> Because that's just a special case.   The general case is that backing
> data is mapped into fuse file data, possibly using more than one
> extent and not necessarily starting at zero offset.  In this case
> using the backing file's size doesn't make sense generally.
>

I see.

> And because it's easy to avoid, I don't see why we'd need to force
> using the backing inode attributes at this point.
>
> Your work on directory tree passthrough is related, but I think it's
> separate enough to not mix their traits.  When that is finalized we
> can possibly add back mirroring of i_size on write, but I think the
> general case shouldn't have that.
>

OK. I'll make it generic.

Thanks,
Amir.

