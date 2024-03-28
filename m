Return-Path: <linux-fsdevel+bounces-15525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735F788FFD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 14:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110DE1F23D2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 13:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D280600;
	Thu, 28 Mar 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="StnZw3hT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1A7F488
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631307; cv=none; b=DW379czLuboD2JzVOndF+5oqlaUqYLr8FZK5IGwbkQh1x7q7nj93xUD4KmmOVdnrhamQkr+/jKpr6T5rQKEbjKoX1qX9gkoXypPHEvZAOL2ILMYGsESRyIx0op9b72EDXRshV76yg3qo/vdnakEbrlk06wrz8mJC6T8eeV4iLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631307; c=relaxed/simple;
	bh=Q9iWHX0IPpMbeqcoJRikaJ89gnv80sbp3IhpzuI1ttI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fX42AaOXEM+1/n/wN+TQnKJNO83FZ7Q/L94mTX73G0UX+ah4jFE++OsZAkOuTQWj2XcwFb56lEliCkwzIYai/cK6Kx3qTYWLWVLZO1un0V6ZnLP2+gCZXN25FT3eOEdcbrNZ66Vq9n8vnortXXWAXPLrEELVAOAesi/ESN/2Ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=StnZw3hT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a0a1bd04eso10219077b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711631305; x=1712236105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAwB5SvUtfOc0OQIFY/17yabinsU0l79BDMDWApoFk8=;
        b=StnZw3hTN81BdznuS1JyepqwYYfxBIzAg5cXgQoH4rvuYG9ID672i7xTjeM3oCIAHU
         bUzMMHFkt9Wr/GTZU3iTGV6HwKgv2WvpwJanQFu8QYK5TKn4yWliFQ009pWuwAYiuvK2
         v3PEJ64Y3x6NSy0uZnwEslWREu7eU5pZH/djx9af6m+lC+aQq7kpTEXSUU2BZi2EsgrR
         R/4Zmp56GwOM8X8lLh4Y6bJl5Tuf3jdBMkEJxvXjTnk+F2MPq/N2grY1dD3AVb2+HZFW
         iWx0Ytp9n35YvsBTqTD9RFWG7M5fDsyf2TOR8SQtEZKz/TJGaOdF8B+L+PrcMI5hsom1
         w3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711631305; x=1712236105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAwB5SvUtfOc0OQIFY/17yabinsU0l79BDMDWApoFk8=;
        b=OdWXbGbgZACf9wEcNUGNvLgUl0QCfYk0236l4s8T+rbdD9K/vtSrhHZcig6bVPnST7
         28ycTJm7krVZMdTqLMS87CgpvlyIX0ifuwfpzzjy4o5ehLUx9kt7pndSQmLl5oPH2MZB
         bEENu0tHedVAf+IpSu7aQalSMsvxuSJpthwpzeE+n8PFUCzhXmRiX2h71y3vafqVvCzB
         MP4f0iPq1Rapd7Yg/jdwDP2QfLjt71oOpS5e+0eLtiDyv50DRdrkHwrNRcxCH78pt/Kc
         zzepsNaZDMu8GWcMoAM18DWKKZaxnbB5ItHpPOiDsCY3SyvgrrtA5Uk6dDfyxb5gH7NL
         jTFA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSPX5Y9AqYdQ2biWN9sV8VbW8CjeBvVXfkCpCkM0DRpDyLc7DAbv7xeW29BlVpi/P488Ntq4tF/w1ZpGKN5nKirVwbcD9xEQo2itufQ==
X-Gm-Message-State: AOJu0YzOs/V/jukwwU2dcONDlL/iZ2Nd5IUrJCH5EG6bibubpkja5aDT
	HgfarJ7IdjqhYJ6IcPkNLfC1Atzst5EqjUcfzSid2IMVYjWXJHNtw2fpOlXnSRGUuAdIUN64b7V
	cuCbb+JcSFqAG9HQlG5cMj3bHm9pRvzGQN8hY
X-Google-Smtp-Source: AGHT+IEaZ/DWaB9kQfke/Wt9K0JwNig6IYkR1JcE7UM+nBmZeQHmNqKMp6t+dN1gP2Ldf62K+SXrioH8t4S9zT6UhRU=
X-Received: by 2002:a25:8452:0:b0:dd6:82e2:47d1 with SMTP id
 r18-20020a258452000000b00dd682e247d1mr2862330ybm.53.1711631305121; Thu, 28
 Mar 2024 06:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-11-gnoack@google.com>
 <20240328.ahgh8EiLahpa@digikod.net>
In-Reply-To: <20240328.ahgh8EiLahpa@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 09:08:13 -0400
Message-ID: <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:11=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Mar 27, 2024 at 01:10:40PM +0000, G=C3=BCnther Noack wrote:
> > Landlock's IOCTL support needs to partially replicate the list of
> > IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> > do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.
> >
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  fs/ioctl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 1d5abfdf0f22..661b46125669 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *fil=
e, void __user *argp)
> >   *
> >   * When you add any new common ioctls to the switches above and below,
> >   * please ensure they have compatible arguments in compat mode.
> > + *
> > + * The commands which are implemented here should be kept in sync with=
 the IOCTL
> > + * security policies in the Landlock LSM.
>
> Suggestion:
> "with the Landlock IOCTL security policy defined in security/landlock/fs.=
c"

We really shouldn't have any comments or code outside of the security/
directory that reference a specific LSM implementation.  I'm sure
there are probably a few old comments referring to SELinux, but those
are bugs as far as I'm concerned (if anyone spots one, please let me
know or send me a patch!).

How about the following?

"The LSM list should also be notified of any command additions or
changes as specific LSMs may be affected."

--=20
paul-moore.com

