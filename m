Return-Path: <linux-fsdevel+bounces-14566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D46C87DD4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 14:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428F52813B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3C1BDCD;
	Sun, 17 Mar 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g241tepg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B28BEF
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710683686; cv=none; b=GAX5pNAid69aPT4bq8r5pX9pb/aOkI/DudtGZkTK/+9UwXZlq/wk4GDUZEX0iaJm7tVXfDLye/ebDAleMnmpaQs8w6SDC7m9YbkvDQ5iff9H5fC9/Ysnos07mOKABnlLbw6ApZ5x7caPUQphbcnha9dvg9+tzi4l2Ci0mBhK7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710683686; c=relaxed/simple;
	bh=FQ+A8PQPLvQz4o3aS0OeBUvLDT+zv7W3DrHF2cJem6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2YBfL3waWPM6udb7LvilwGmHbUo6HejjdadQg1bhFfIAfmkqCHjvUZ7w+7E02Nqwd5tPpwpgTywm+06YT6/yu8UlFwn7+oJTOMbP40di6SAlmMA6dLR8TJPXurbPtAFOwqx21OrttKc4zT27/ZO/j93gLyJliGFXkMV6kWfswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g241tepg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6918a0edcfaso13961456d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710683683; x=1711288483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcbfUtiNYnuh8oAaJ23Ac2pC9Jm58zCfxhu9gsUeB90=;
        b=g241tepgA7bH7dX1Xiiy3UoBTL+vTYzptYyw2Z6eyhm62RjfP2PBejBDlT1vBM0pqB
         xF8Ar7LniciJNGEHhf/W/XL/sVoEqOR7QVY0VPAaUZ/TP41DegnRKeRFxVS6XDWbcoX3
         qQAp1PoIifQvVJrBR/wTXvBhG9p1Px8WDi1mkHiKgzKAiv1TD9sRVA56gF3NFXkvWsHr
         Rc4zac5imghaT45aT41NUeaiABqZ7HrnrdUIphNtRvHV3xBPLB0ZWbROudjfX2fKp1eB
         ITedIgxs/Zhlm515YQbOV8jDDbG/jGUFNUA7hh743ZyZKy1An0TitRWtg3kBF4N5BZsW
         gpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710683683; x=1711288483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcbfUtiNYnuh8oAaJ23Ac2pC9Jm58zCfxhu9gsUeB90=;
        b=U80nED7ixI/arhGNEO9aoSJTU+BR8gCjjKX1wO9NhcvbDE2xaxQTomyL30LMAQSD+b
         J0/DmiBXDAqegHWFO0EWVZ4LZwyXwcAqzNOgKGVJafCREJrCvCAB0DEq+qnm5YyzfxWj
         twNi0/9QIdpyuYLIHpbieA6z7U5fzcMDt+5AtWDo21KDSYFIy2Dhq3nIkgBuBDRwi77d
         Iy0mio9OWHsk6dJGOHwcusiOgQoEypTYxgMbxGcCDQ/FzpSCs5P6g9eSTQ+brDXQx4TJ
         7OdzCNO6RzuyCECy1OoOFFbwYyXhZgC/0BdW0GHxjKqYESw/Cf6m9If+0fOJRjv6i5U8
         hHhw==
X-Forwarded-Encrypted: i=1; AJvYcCVsv3lFI38qLk4rRhq3TqSA5AAeRrOAeXt8/UM7UxouwBjKUkxK73tWerktfbF5wfQu7tOFQLmT+PLQD0NESbEHzj+36iLSXQIzUWBt6A==
X-Gm-Message-State: AOJu0YzuteRYlAM8MVg3PxBQf4FvDl3BLz4HEBeYxLUwMxE+ALxJlU8Y
	S9ExiZ4u3kn/V+qthoGPXHCXgEeEOBgJdfZGGEUiAd3R+hMa7KSEepaic5lXIZIhHxikmjywwZx
	audc7tfljSwiBsoVqA5eVYn/zjiI=
X-Google-Smtp-Source: AGHT+IHiiKD8/Z7OzoejDJP7FJk93GpvOKwtApsUQlMPO31qxdGaYbbw21ndg6ra10zQklie0o1a3KcGwlFCUy/v3OY=
X-Received: by 2002:ad4:4111:0:b0:68f:dddb:747 with SMTP id
 i17-20020ad44111000000b0068fdddb0747mr8428477qvp.58.1710683683411; Sun, 17
 Mar 2024 06:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
 <CAJfpeguKM5MHEyukHv2OE=6hce5Go2ydPMqzTiJ-MjxS0YH=DQ@mail.gmail.com> <CAOQ4uxh8+4cwfNj4Mh+=9bkFqAaJXWUpGa-3MP7vwQCo6M_EGw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh8+4cwfNj4Mh+=9bkFqAaJXWUpGa-3MP7vwQCo6M_EGw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 17 Mar 2024 15:54:32 +0200
Message-ID: <CAOQ4uxj8Az6VEZ-Ky5gs33gc0N9hjv4XqL6XC_kc+vsVpaBCOg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Feb 9, 2024 at 3:27=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Fri, 9 Feb 2024 at 13:12, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > I think this race can happen even if we remove killable_
> >
> > Without _killable, the loop will exit with iocachectr >=3D 0, hence the
> > FUSE_I_CACHE_IO_MODE will not be cleared.
> >
> > > not sure - anyway, with fuse passthrough there is another error
> > > condition:
> > >
> > >         /*
> > >          * Check if inode entered passthrough io mode while waiting f=
or parallel
> > >          * dio write completion.
> > >          */
> > >         if (fuse_inode_backing(fi))
> > >                 err =3D -ETXTBSY;
> > >
> > > But in this condition, all waiting tasks should abort the wait,
> > > so it does not seem a problem to clean the flag.
> >
> > Ah, this complicates things.  But I think it's safe to clear
> > FUSE_I_CACHE_IO_MODE in this case, since other
> > fuse_inode_get_io_cache() calls will also fail.
> >
>
> Right.
>
> > > Anyway, IMO it is better to set the flag before every wait and on
> > > success. Like below.
> >
> > This would still have  the race, since there will be a window during
> > which the FUSE_I_CACHE_IO_MODE flag has been cleared and new parallel
> > writes can start, even though there are one or more waiters for cached
> > open.
> >
> > Not that this would be a problem in practice, but I also don't see
> > removing the _killable being a big issue.
>
> ok. Remove killable.
>
> Pushed branches fuse_io_mode-090224 and fuse-backing-fd-090224
> with requested fixes.
>
> Note that I had to update libfuse fuse-backing-fd branch, because when
> removing FOPEN_CACHE_IO, I changed the constant value of
> FOPEN_PASSTHOUGH.
>
> Passes my sanity tests.
> Bernd, please verify that I did not break anything on your end.
>

Miklos,

I see that you decided to drop the waiting for parallel dio logic
in the final version. Decided to simply or found a problem?

Also, FUSE passthrough patch 9/9 ("fuse: auto-invalidate inode
attributes in passthrough mode") was not included in the final version,
so these fstests are failing on non uptodate size/mtime/ctime after
mapped write:

Failures: generic/080 generic/120 generic/207 generic/215

Was it left out by mistake or for a reason?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20240206142453.1906268-10-amir73i=
l@gmail.com/

