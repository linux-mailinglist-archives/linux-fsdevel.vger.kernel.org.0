Return-Path: <linux-fsdevel+bounces-52920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A206CAE873C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A9189349F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96226156E;
	Wed, 25 Jun 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+g9nXoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB025DD15;
	Wed, 25 Jun 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863376; cv=none; b=Agw4OI/owF0TclJqeVJ3ocBAmZkTL2T2NGNrl7o7Quv42GUvsm9CP2E9vdK3ea/D71zkc79cEYJggTZ3dY8zetDY9Rku/2jh9pLeL8cKIpY5lo2veUpmyZk5AxF17IlHt8epNf8i/ouQUqDfaFcA/BeDSSHb8j2qR5UwKSJC4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863376; c=relaxed/simple;
	bh=4YFawUVoqBzt7IIR/YZHYOlOwxU3d+7MmZ4pEcQJbOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcUf8oH/KAOq6o9Jz5z69tof8JtDJe5ydWhPqXjopX02Cqw3koKvh8Va2EMm//liWO07RU26E0atO9zuOzzYe94/TPCidM95YI84oH+Ndgwlztq3rgx9KB/tPnU8tOOpX+266yctErt+bri396OsBIX9JWolwhHjgmURMrebW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+g9nXoV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so11701706a12.2;
        Wed, 25 Jun 2025 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750863372; x=1751468172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1NFe2OD8RXw0DBdy1L6IAuhiiBghvMPfFLj13S/cQ0=;
        b=f+g9nXoVBPp+8IKJCSjY3Pa1hCPs5HhT9tXA2kcg7AbqLv0C7a2nRILl5i0NNKdtB4
         w/SN4IHgSxpuWdXiDmVzMXUZhfVv+5lZ4FKKQYzRWZU7jPC+iRpwzE8+epeIc8Z3uChH
         B52UJLOlO0gMYzJ5HdQp3Bo257HuojJgiHVSKS4371L0t1JmPbsnjzBgmScY0wWyfSUm
         PjvuFeYg8XlbhGE+FkFxS7nzP7KXPs7Y0X2AI9N7yB9pgWBH2+6FweQa/7wksK2ECLO4
         2ecPwUxQP3q8slE461bqhiVCWYzsKlliDGjxvLc+q1a2xh6Riz3mEgnZxIO/dseD6LTt
         gfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750863372; x=1751468172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1NFe2OD8RXw0DBdy1L6IAuhiiBghvMPfFLj13S/cQ0=;
        b=f8JZ541shZfgPBxGnus64rwg9c1wHc2u5MK5KbSFgYKxE+cx/dT/Y2hgrFL1Ndikqh
         X/KHHasErR/258SsUG9E0EcGG/Pq4CHmq2uc9xcyHV9yAOoZQYeYyzokwxvZMppMJhwb
         TIkjvNKeYjcyfedRMsD2PDpaIxXYUfUG4Bmi8TbWogrLKFcdXwGbhnmgqGbc4CStctAl
         2Dq45Qt1ECvuqAUe0eRrXn9E3KWBKOMAxTwJTzzSN7Ox0nL6bE4U/T3N2WGyYt3bV2Qk
         VKkQ9ZeALRN+gW/JNzWH4lY3UD+gpGyRHa01z2k8i04yXAw1cw2GGNrpGJy7DgptOR/c
         tNXg==
X-Forwarded-Encrypted: i=1; AJvYcCXan5YncgM8LXbm0J6KVCXbyRX5jTRSQNTQOTKqTVr/+payQ/olyFB+xeHQLKcf5onn/10vvhazpTDgzFnELQ==@vger.kernel.org, AJvYcCXuCCW+sMeWS5gPY6tvUSb0XnETrZX11OKdw32FD1QouKHzJXdysJ7AJGUHfmeDenpxk4rxnaOLW38N3djy@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBYR0jZVG64Gf5aQB1W46xSD9uYz0Wuebj+Vg4KgLJ7COdaqF
	GxzXmbc0wnZw/7kBoygVnTTRGGeiF13tSMftEa5N0zvNg+AxKoYOQIbXiifF7yyLo+mVhAPvH4O
	Qdm7gHJNHYu50FTs9obFksMkFZXiiCwM=
X-Gm-Gg: ASbGncsUwTHtoWosMrPsWMLIy3X4d5wsaCrGQzzcu/LrCnqV983zb9s6BnMZ9HxjXE/
	+Ajp6Avp+55SDBSmmp7Ssl8TkCqQFlBzk0YoPCcKr2mCDEKAOvqpEnO8lVo/y8IzqT9LJbTn2Va
	ii36BzbXiiD2aozeXfbpnYVihFskANLyRcfqGGSMgJ0ws=
X-Google-Smtp-Source: AGHT+IFpYOcWfJux8aILmTSnFUQEk2ijoPgqqfwc6BzFUZwbhaMX5RtSJ3jw8nXaldnHBjx6eY6OTBbMFOjfjqI9xgw=
X-Received: by 2002:a17:907:7b89:b0:ad8:9257:573d with SMTP id
 a640c23a62f3a-ae0be9aecf5mr331163866b.24.1750863371762; Wed, 25 Jun 2025
 07:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name>
In-Reply-To: <20250624230636.3233059-1-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 16:56:00 +0200
X-Gm-Features: Ac12FXz21jSouxp4b9F6qhHNNJWWFoNgIoLOCS-AwqUzfNdiZAi82XjulkcJb6c
Message-ID: <CAOQ4uxhZbfg-u0w8uRVYPkNe+GXcragA5hwtZrc1_RJ5qznVeg@mail.gmail.com>
Subject: Re: [PATCH 00/12] ovl: narrow regions protected by directory i_rw_sem
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> This series of patches for overlayfs is primarily focussed on preparing
> for some proposed changes to directory locking.  In the new scheme we
> wil lock individual dentries in a directory rather than the whole
> directory.
>
> ovl currently will sometimes lock a directory on the upper filesystem
> and do a few different things while holding the lock.  This is
> incompatible with the new scheme.
>
> This series narrows the region of code protected by the directory lock,
> taking it multiple times when necessary.  This theoretically open up the
> possibilty of other changes happening on the upper filesytem between the
> unlock and the lock.  To some extent the patches guard against that by
> checking the dentries still have the expect parent after retaking the
> lock.  In general, I think ovl would have trouble if upperfs were being
> changed independantly, and I don't think the changes here increase the
> problem in any important way.
>
> The first patch in this series doesn't exactly match the above, but it
> does relate to directory locking and I think it is a sensible
> simplificaiton.
>
> I have tested this with fstests, both generic and unionfs tests.  I
> wouldn't be surprised if I missed something though, so please review
> carefully.

Can you share a git branch for me to pull and test?

Thanks,
Amir.

