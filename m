Return-Path: <linux-fsdevel+bounces-70013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE8EC8E493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9922B344425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0BD330B02;
	Thu, 27 Nov 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOJ70o8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C422256F
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247220; cv=none; b=GqRx5h2AXOHCFTo6UDSOGYt2+9jj8Y8cQD89ldxiquF+DcXtnMZHtRv4GM80TFn3hXEeDk1HKZkNt5RaHzzac06eCOV7bo9j4+PDx5RuDLB9VlvzgHZ3j/guZmuAlemyI/hPLY7IESVT+6E69U1kg4yf/Ti6StLw2jhT3ByPL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247220; c=relaxed/simple;
	bh=hBULKftqR7lsAwoJC7zen7ukZUv6esNNC31L/n1mOMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwDzy3EhkI0CmRMfHpkLwuhDUb8QokZK5fX0Jl0E16fcuVqjzEAwH2s9NzVb+Xrzg7Eo9Sn3Be0nWgYJv/hj4zfMi6Ynx2iBILFITVCT3sdtugARB58dz16v8Ji5nT+eTd3K65LrtLz3mgBKbE4oC746QNxTfflKQ7GAO0X9SNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOJ70o8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33423C2BCB1
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764247220;
	bh=hBULKftqR7lsAwoJC7zen7ukZUv6esNNC31L/n1mOMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rOJ70o8+xOoJAhwhhUmcCJyH17bFPkgNABOmD91keJhn/dxOPO6UOSOXG3DsjMxRy
	 74yhAZDQVYgXXTv0GiZw9GHcyaHYfFZ3UhZcUBNB1b4apQgqFSSwtRZw8FD0biAdj+
	 plq2MU6zcWq2qbrD9mAN2LUbc/YslR9VrwfWMCH9ecY9Bb4g83Eu1ziP6TljOfk7DD
	 L+7rxYPRlj/oc2Bawbgplr5UbgR8jV90jYMKTdtfPiKdukNlwZ4UdBYzsmSlPg3xUR
	 +xCuIFBFjOiL7/yGyg0HqvVIgOCV/3SGibBzkZlaJfFL+J3Yyk1GxeUqTjEfgW2ZTz
	 y01IQzFZiSlpA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so1304797a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 04:40:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOplgyhKHyOaIgDpvRjpPTmqkLx1r2L8Yy3ndMiDOWkGkwdKgDtI3U+0OQCL9M9izFPOZoB+SZjtZLqZWV@vger.kernel.org
X-Gm-Message-State: AOJu0YyDd79GeG5iGHJPA5N15OnaPmIR/F6KpyWVSmzvF3CDhHOG8CtQ
	Dks9mtspF6ubqfMQb4alGru4CoDt+KcX3PKkqOkw43AQiYUrY/10CJjSbkj3ny/b8qaUMC/m9VQ
	qaxcgpAzU26G5q3ey81AraXLLNBFfhbc=
X-Google-Smtp-Source: AGHT+IFaAu8mNvQwVm4qovXUaFIyIh4UsavB10t1+6QWLZ4Kj7xFYBjoN0T9ZY53uk6qWwDkYARGgzwZeceFH9cQRQY=
X-Received: by 2002:a05:6402:26c3:b0:63c:2d72:56e3 with SMTP id
 4fb4d7f45d1cf-6455469be57mr18178013a12.23.1764247218679; Thu, 27 Nov 2025
 04:40:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-12-linkinjeon@kernel.org>
 <CAOQ4uxhwy1a+dtkoTkMp5LLJ5m4FzvQefJXfZ2JzrUZiZn7w0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhwy1a+dtkoTkMp5LLJ5m4FzvQefJXfZ2JzrUZiZn7w0w@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 27 Nov 2025 21:40:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd99CJOeH=nZg_iLb+q5F5N+xxbZm-4Uwxas_tAR3e_xVA@mail.gmail.com>
X-Gm-Features: AWmQ_bkMnjkD6-ifjb7N_WOG4zjxWCP-lkyTNOH147VCeADJbEVejGpmf19bYWE
Message-ID: <CAKYAXd99CJOeH=nZg_iLb+q5F5N+xxbZm-4Uwxas_tAR3e_xVA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 8:22=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > This adds the Kconfig and Makefile for ntfsplus.
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  fs/Kconfig           |  1 +
> >  fs/Makefile          |  1 +
> >  fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfsplus/Makefile | 18 ++++++++++++++++++
> >  4 files changed, 65 insertions(+)
> >  create mode 100644 fs/ntfsplus/Kconfig
> >  create mode 100644 fs/ntfsplus/Makefile
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 0bfdaecaa877..70d596b99c8b 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
> >  source "fs/fat/Kconfig"
> >  source "fs/exfat/Kconfig"
> >  source "fs/ntfs3/Kconfig"
> > +source "fs/ntfsplus/Kconfig"
> >
> >  endmenu
> >  endif # BLOCK
> > diff --git a/fs/Makefile b/fs/Makefile
> > index e3523ab2e587..2e2473451508 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -91,6 +91,7 @@ obj-y                         +=3D unicode/
> >  obj-$(CONFIG_SMBFS)            +=3D smb/
> >  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
> >  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
> > +obj-$(CONFIG_NTFSPLUS_FS)      +=3D ntfsplus/
>
> I suggested in another reply to keep the original ntfs name
>
> More important is to keep your driver linked before the unmaintained
> ntfs3, so that it hopefully gets picked up before ntfs3 for auto mount ty=
pe
> if both drivers are built-in.
Okay, I will check it:)
>
> I am not sure if keeping the order here would guarantee the link/registra=
tion
> order. If not, it may make sense to mutually exclude them as built-in dri=
vers.
Okay, I am leaning towards the latter. If you have no objection, I
will add the patch to mutually excluding the two ntfs implementation.
Thanks!
>
> Thanks,
> Amir.

