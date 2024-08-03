Return-Path: <linux-fsdevel+bounces-24923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9A946A8E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 18:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D6E1C20AF7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367C14265;
	Sat,  3 Aug 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ply8VB/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45417995
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704019; cv=none; b=sIlGkjFZdc0lq7B1XZ1Zh4o64ghMhFij70amK65yKACWSzRinHdZX3+ORNtW+rJkMHdh3cQm5NiIfzluRSQa399AUQ05OQo1RAgmt+pbIZz1o3VouLMYH3/POa6RYGte3//qU+h4jB7IoxEvaIIfMGirPLrJ8OIynGIDvtPo6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704019; c=relaxed/simple;
	bh=faCMAib9K7w+uNvM28d91BG9QiXqsLo6XDAZ01eDTb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCbWpJ4xp9cxJd1w3APgHuHZJg206ewM31B8bK6F7pMCy+7QMqnGANup1WKCbhLo3QWWmfhfLPuo/cgDszTcYh6S+DiSVWTCxBl6l1LqwiFdZK0RWREqhtGiUl9dAXm6xNhNFOi92gONLeQ/neKOvirRn1fGFIwBn32uHnXEkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ply8VB/P; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e026a2238d8so4705549276.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722704017; x=1723308817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUSFevkIywKgVCwCiKZRbR6Bs38oKHmIXY4Hoi9mCe4=;
        b=Ply8VB/PpWfn1aNgFhn5g0+8GoFPSVJw7jLaNk8moxoxEOPEYnpVG7t2/gjn3x9o1F
         MyVoO+j83Pvz/j11YmRLaYsFXXN0r4Yfr5j6spv8fo0J27M9M2xEjgJsFz2mBCoOdEUI
         rO9QBZC7Fb9iUvjTQT8HR9kfC29KDHSK/yIR+Jl1OMKowZh32ljpga1SZ+xZ0H5c+NI8
         UWvZI6oKHc4b11q6esOUkbXj/7VyUt7Lggy/Fb00yTnFbevUpBEaUwJ2j0sIpG39YM0C
         vFANZ4AEZZSz/FOdt95MH+X23EqTvoUgDxtRZTjt1PZ2a4G1TtUw7fC+DzQ98SGMYcVo
         J+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704017; x=1723308817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUSFevkIywKgVCwCiKZRbR6Bs38oKHmIXY4Hoi9mCe4=;
        b=kYC3vwIx4gPbpoOMUpUrVZQfprECovsc2qM9paJkSk4MmE3uOwSVH8crSgkK1iwKrh
         qB03IOx/oSQ5bpcDoJiDno26/s1vspIdClupk+pwq9nDQ41+Qao+tIOxOOqOi5XFlUr3
         7u0yQv9XCiUtxHpnEiGvjVNCnT+WbRY/gCuJJDUw3y3XP/widzSrJxub7qUPVde3ON9S
         Ygi7XHo3Cc1eQdoy3CrRtfQ93BS1YD3lbo10GwzMjSnIY7Jzo7ijj+wB3HRouSjPrxRm
         OVIMKI5WbiihLcO9SRX26Wmls1/TmX5pGImoWJ0HWrG7CrTzS7CSJd2kPxLa+GAy/coT
         p9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUvre5eR8Ko8UrjGBpHnQkcNBG1IeSXO8utTpUVREUvbd8glhpGpOVx9kv2j6BFtkqgmOgsDPFPbzvLvbWEW6dSrZbd/c1MALQwArnw7w==
X-Gm-Message-State: AOJu0YyMzR6BDJeacfhjq0c2J5mfi845DzaZqPNZR5kA8fOZtI6r64Tf
	Uvr+khiZue3/k+NH/ci5GNnsA2RSfMXtcAaPVcv6yVNRzMHfNgBptSR3R/7zcFuE/2dpGGNAUpx
	bj8sDrilnDGYzc+VRB4toW/teSDQ=
X-Google-Smtp-Source: AGHT+IHCQDjAmwV6ONzcJnVCoe0ZJXCcxyIsZEB71nTgqsFrT4p/OXiHiE4wvBXdkN8dMnOwh1nzy7VLHs3cqB4hS1Q=
X-Received: by 2002:a05:6902:1546:b0:e0b:aa99:ecc7 with SMTP id
 3f1490d57ef6-e0bde303a98mr7725517276.17.1722704017115; Sat, 03 Aug 2024
 09:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <c105b804f1f6e14d7536b98fea428211b131473a.1721931241.git.josef@toxicpanda.com>
 <20240801170125.uimwmtbt4s6y7a5x@quack3>
In-Reply-To: <20240801170125.uimwmtbt4s6y7a5x@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 3 Aug 2024 18:53:26 +0200
Message-ID: <CAOQ4uxhHg=OQ4jWvSCD1LchmsVQ4pnqkwBkAYjpFmxgja8xnow@mail.gmail.com>
Subject: Re: [PATCH 03/10] fsnotify: generate pre-content permission event on open
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 7:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 25-07-24 14:19:40, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on open depending on
> > file open mode.  The pre-content event will be generated in addition to
> > FS_OPEN_PERM, but without sb_writers held and after file was truncated
> > in case file was opened with O_CREAT and/or O_TRUNC.
> >
> > The event will have a range info of (0..0) to provide an opportunity
> > to fill entire file content on open.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > @@ -176,10 +180,14 @@ static inline int fsnotify_file_area_perm(struct =
file *file, int perm_mask,
> >
> >  /*
> >   * fsnotify_file_perm - permission hook before file access
> > + *
> > + * Called from read()/write() with perm_mas MAY_READ/MAY_WRITE.
>                                         ^^^ perm_mask
>
> > + * Called from open() with MAY_OPEN in addition to fsnotify_open_perm(=
),
> > + * but without sb_writers held and after the file was truncated.
>
> This sentence is a bit confusing to me (although I think I understand wha=
t
> you want to say). How about just:
>
>  * Called from open() with MAY_OPEN without sb_writers held and after the
>  * file was truncated. Note that this is a different event from
>  * fsnotify_open_perm().

sounds good.

Thanks,
Amir,

