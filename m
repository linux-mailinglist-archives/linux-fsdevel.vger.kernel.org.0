Return-Path: <linux-fsdevel+bounces-40059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF3A1BC85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D81E3AAB84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83152248AE;
	Fri, 24 Jan 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKixgm6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF427726
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745013; cv=none; b=AXdmdm9WubL0ysyJ55uKWbAxTyi0TerXrl1ZtN+2dqof89tSouNDisD906Fj/fMB7JefWyKBy312mZ5s3YkSVtRTfRk8NTADrv84j9X9FzLl701UaVLDVW15X7NJ/AEnvGD5uRTYUTFPU601GHc5GBMqo/Oag6nupYpfjHIz4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745013; c=relaxed/simple;
	bh=zV/rDMl7fMbsbuMMveScKSDJOUxIec0UwUkOkNXR52Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksUztnZLfg5lQfml9Y5npXeWsrvr6O44wo3V5aeLU5G5od09WEBpmDIbZBm4yh0UOJABAKguV6cen4Ijq2BRkZI8F5JvqsE/4brOfDZCPRK6vbSK6EN0PWGNsf2mMjxQwz/E3U5Y/mRkV8Ge5wtR70ht2FY2vE1RIAdSh6dmOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKixgm6w; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a3f1e667so15176961cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737745010; x=1738349810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9FmX6nMu0ZVW9zrkPT8e5zPTBbHeoYyB7PiLvpkcRA=;
        b=IKixgm6wn+E9vi/otqu0TQeFDDRhgTaKxmtYLgU97NWn0z0ljwMv+G5aNjSOOCLC0t
         ZtVNXZDXpFA1k1rsvFkKwidjbwNtqSATnxEpxMkFWWylr76JxAxHZ/po+HDUpPoy7NIf
         SqqZ3q/BWJEbhmuMnN0a71k1Y85boQ5xzGtHpJb0Mm2e7OFaX6xZI92tP8MXlI8/8f11
         aqh5lIKmnf9GTHVlkurpiVYdpqFD2kcU5e8pk/1CQ39A9mJPOvAmJKcR9LDBz6QvHOXW
         J55Vvc75LRBdj3F1hr3bU1hdS1/mmhIPI9ixjhC8jIsEh3scoYTCZ9MSrUlX0GZzWhX5
         4IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737745010; x=1738349810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9FmX6nMu0ZVW9zrkPT8e5zPTBbHeoYyB7PiLvpkcRA=;
        b=FD8C30vuw2LOUOzJrgXhzTsl3E8elf/wT3YA+benq6VWsFKaeBZqqlYR0d0sWxgBFH
         TMV3JGg3JEUm7SwScHxVfVAxCgSEY5t3YZy3auYypKKbDPmf4p8nJAfMTxEoXJeCCSSr
         lXawZq5dcnEhztpTdlm8c7ZfZvFhPq5jBrnYZhnnvfaI3/6baNhzG+lPATwRYYecISPU
         GiVCQxXPr6p2xiGx0cXhcd4hehgLRvDYuT7CJfTMqFnbeJzo+fIcVTRyckfDhyjA8GTz
         3pCj8dpstfPn2+Ts7hGG34sKCfh4YiueC+rybuxtfhhgWHjXQwdHlxK4Y79/nAN4S62Q
         vKjw==
X-Forwarded-Encrypted: i=1; AJvYcCWy/qyGqzvWTQcH6c1A8CFLqv4EcEM4dvD80lSwh3pMTZWHOSSmrAyFLnerSWOcNclA3KUn03Izw46Y7YHo@vger.kernel.org
X-Gm-Message-State: AOJu0YyMv+Zzq1NwRpimczZSzxksPNySA5OfVtvZwmhUuA+a4pthxtNI
	7IDBsuCvyn01/exXb+Bqmo4MzzMIf7M4eu+A1UphgWUe/aXiKhdK5OAYyJOTGDS9olTqYrNmCYg
	o4yWbDP3wauQOE1JcVejDdAja9o/Wzwpl
X-Gm-Gg: ASbGncssT3w0J+QqRy8QQOiIpbJ6GaAcqghDYbRsIaANM7TRrRRjlC3vWpkFdjOnpkI
	XAN7ovq52nbrTacuUWSqYwu6UPUL5BFQxWK9mhJegPs3CmnVz/2W/MCY+hMCEEz0=
X-Google-Smtp-Source: AGHT+IGEbzB90TI5ocONyuGYHDeTR5nMihcidkteC/ovcv/5ZNR2d2ekuEwcQ7GSB2CUr9+s5f9V/3XgMYiET49cwps=
X-Received: by 2002:a05:622a:1496:b0:467:6375:6884 with SMTP id
 d75a77b69052e-46e12bb3e97mr384938781cf.48.1737745010283; Fri, 24 Jan 2025
 10:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
 <8734h8poxi.fsf@igalia.com>
In-Reply-To: <8734h8poxi.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jan 2025 10:56:39 -0800
X-Gm-Features: AWEUYZmX29PAWSUyWtiFNrlWlKkpLrBH2QwWfBAr83nW9H73cEOTIHaEX-AMtC8
Message-ID: <CAJnrk1Ztw2-sq1NSR5G4YrEx-7dFFK=Yu_-QQDY7Jy1tajqDWg@mail.gmail.com>
Subject: Re: [PATCH 0/5] fuse: over-io-uring fixes
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 1:00=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> Hi Bernd,
>
> On Thu, Jan 23 2025, Bernd Schubert wrote:
>
> > This is a list of fixes that came up from review of Luis
> > and smatch run from Dan.
> > I didn't put in commit id in the "Fixes:" line, as it is
> > fuse-io-uring is in linux next only and might get rebases
> > with new IDs.
>
> Thank you for this, Bernd.  And sorry for the extra work -- I should have
> sent these patches myself instead of simply sending review comments. :-(

Sorry for the delay, I haven't gotten to looking at the latter
io-uring patches (10 to 17) yet in v10.
If there are any minor fixes, Bernd do you prefer that we send review
comments or that we send patches on top of the for-next tree? Thanks
for your hard work on this io-uring series.


Thanks,
Joanne

>
> Anyway, they all look good, and probably they should simply be squashed
> into the respective patches they are fixing.  If they are kept separately=
,
> feel free to add my
>
> Reviewed-by: Luis Henriques <luis@igalia.com>
>
> Cheers,
> --
> Lu=C3=ADs
>
> > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> > Bernd Schubert (5):
> >       fuse: Fix copy_from_user error return code in fuse_uring_commit
> >       fuse: Remove an err=3D assignment and move a comment
> >       fuse: prevent disabling io-uring on active connections
> >       fuse: Remove unneeded include in fuse_dev_i.h
> >       fuse: Fix the struct fuse_args->in_args array size
> >
> >  fs/fuse/dev_uring.c  | 23 ++++++++++++-----------
> >  fs/fuse/fuse_dev_i.h |  1 -
> >  fs/fuse/fuse_i.h     |  2 +-
> >  3 files changed, 13 insertions(+), 13 deletions(-)
> > ---
> > base-commit: a5ca7ba2e604b5d4eb54e1e2746851fdd5d9e98f
> > change-id: 20250123-fuse-uring-for-6-14-incremental-to-v10-b6b916b77720
> >
> > Best regards,
> > --
> > Bernd Schubert <bschubert@ddn.com>
> >

