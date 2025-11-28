Return-Path: <linux-fsdevel+bounces-70139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CBDC91FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 13:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98B8234B2EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F06329C40;
	Fri, 28 Nov 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSKeeIBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD043329379
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332918; cv=none; b=tbLWfLmztBRyW/iEYMvWbCEdS4XfjNjSqThc85f5MNGpzPPIeCescg31TCUCklNueLZ4NEeS26DK3fH3Ae30DnUy1XK5+9rq6ibjlLSit9UWZf9JSbjyRm8G+0fd8sjeAC+y9cTim6Hl6P10zxVRj+X9rN+BLmkvtu+w6DdNtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332918; c=relaxed/simple;
	bh=fL5ESIo6c6L1WG2V6bMoBjvE9NCFb8upWn5gFw1NFSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJNSdnoiAeNbjo12+/ZLm9nc5QFIWdX6JASZFkb3CVCl0VARJbO1X0fqxWIW76wp0eESRIDEkHvGfKNU899vLjvbJenAahtIeNhaqxZJeg588N6LxsmLA5VfALBvmqI/OG/T8czAgmL118khlPMNxDlE7J5tR2yceWWPWGX95PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSKeeIBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773E1C19422
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764332918;
	bh=fL5ESIo6c6L1WG2V6bMoBjvE9NCFb8upWn5gFw1NFSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hSKeeIBH6PQsT3swlBhNNNSnxkKaSVdh6QKuIVDl0+WXIMv/I/2mPQISABfBYfHxX
	 jA39UWzvuoTnHtCczjIGjbDBvyrMTeJzjes9HSYksBIx1SNCXo8LXgqTxwfDNf1REC
	 SHTFnBjJzGrgIAqGnH98FJnnPACHw7rzQzJ2+Y0DsavK6GBT4Ukq/MSbQupR2e+yHy
	 dL/O8ggpiLmvI7oY1Euvr569Pi3pC2T3dWnmUaxRwRP7q/gXOtlIkqYakdBvwrt0S9
	 aNLIipt1Oqy3LIrBzyJ1hbTriD756jCBIL2xEKDElEnDJrZrPhQtQga42C0MxuLPHZ
	 QdVnNTTeeVNKQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so2885750a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 04:28:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX3pZOZT7oTlc3e1oMYVKOxG2oBvik+gzEIMoh3Mp7fV0gL6xnbVc+t/ca+3LR6aaz8HcBj1pacNpDciQT@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrHRP8YvYF71RLHs5SuRtbTbIRsNod3vlvKxL24hpB7XvLN4K
	nV15UgZEG8PAolm8cPPQgh3PR/rUnFAccmk6N51RMh5mL9HUCV54XZcxdYCTRKzcDPM4BqFH8oE
	bc/cAb8KYIshG0HLezHFCv0b3xHFfIHA=
X-Google-Smtp-Source: AGHT+IFUWR/IDlUlhhaqkhcLgKgwYjhwwo7Orva9Zo+w+hmfZfIMhm4hVh1hsd7dza7jTNzngxJi0WMddD9jb2IUITw=
X-Received: by 2002:a05:6402:4311:b0:640:c454:e9 with SMTP id
 4fb4d7f45d1cf-64555b86b59mr23584838a12.4.1764332916810; Fri, 28 Nov 2025
 04:28:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-12-linkinjeon@kernel.org>
 <CAOQ4uxhwy1a+dtkoTkMp5LLJ5m4FzvQefJXfZ2JzrUZiZn7w0w@mail.gmail.com>
 <CAKYAXd99CJOeH=nZg_iLb+q5F5N+xxbZm-4Uwxas_tAR3e_xVA@mail.gmail.com>
 <CAOQ4uxiGMLe=FD72BBCLnk6kmOTrqSQ5wM4mVHSshKc+TN14TQ@mail.gmail.com>
 <CAKYAXd8K76CeQNtR-QOMSJ_JjuoiibuQkd4NhkPPM_CQNdNajw@mail.gmail.com> <aSl26bbeD4-Ev1ky@amir-ThinkPad-T480>
In-Reply-To: <aSl26bbeD4-Ev1ky@amir-ThinkPad-T480>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Nov 2025 21:28:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8RFwBfvWb=mjg+_nq=B1E=g8JURjAiQnjt4jK+rXcXtQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnXTPg8odBgUFQvM_xtzj987rEap7QrLjf9q38icTR1sfTEmdSVwWT78UA
Message-ID: <CAKYAXd8RFwBfvWb=mjg+_nq=B1E=g8JURjAiQnjt4jK+rXcXtQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"

> > > I think that the way to implement it is using an auxiliary choice config var
> > > in fs/Kconfig (i.e. CONFIG_DEFAULT_NTFS) and select/depends statements
> > > to only allow the default ntfs driver to be configured as 'y',
> > > but couldn't find a good example to point you at.
> > Okay. Could you please check whether the attached patch matches what
> > you described ?
>
> It's what I meant, but now I think it could be simpler...
>
> >
> > Thanks!
> > >
> > > Thanks,
> > > Amir.
>
> > From 11154917ff53d6cf218ac58e6776e603246587b6 Mon Sep 17 00:00:00 2001
> > From: Namjae Jeon <linkinjeon@kernel.org>
> > Date: Fri, 28 Nov 2025 11:44:45 +0900
> > Subject: [PATCH] ntfs: restrict built-in NTFS seclection to one driver, allow
> >  both as modules
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  fs/Kconfig          | 11 +++++++++++
> >  fs/ntfs3/Kconfig    |  2 ++
> >  fs/ntfsplus/Kconfig |  1 +
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 70d596b99c8b..c379383cb4ff 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -155,6 +155,17 @@ source "fs/exfat/Kconfig"
> >  source "fs/ntfs3/Kconfig"
> >  source "fs/ntfsplus/Kconfig"
> >
> > +choice
> > +   prompt "Select built-in NTFS filesystem (only one can be built-in)"
> Usually for choice vars there should be a default and usually
> there should be a DEFAULT_NTFS_NONE
Okay.
>
> > +   help
> > +     Only one NTFS can be built into the kernel(y).
> > +     Both can still be built as modules(m).
> > +
> > +   config DEFAULT_NTFSPLUS
> > +       bool "NTFS+"
> Usually, this would also 'select NTFS_FS'
Okay.
>
> > +   config DEFAULT_NTFS3
> > +       bool "NTFS3"
> > +endchoice
> >  endmenu
> >  endif # BLOCK
> >
> > diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> > index 7bc31d69f680..18bd6c98c6eb 100644
> > --- a/fs/ntfs3/Kconfig
> > +++ b/fs/ntfs3/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config NTFS3_FS
> >       tristate "NTFS Read-Write file system support"
> > +     depends on !DEFAULT_NTFSPLUS || m
>
> So seeing how this condition looks, instead of aux var,
> it could be directly
>
>         depends on NTFS_FS != y || m
Okay.
>
> >       select BUFFER_HEAD
> >       select NLS
> >       select LEGACY_DIRECT_IO
> > @@ -49,6 +50,7 @@ config NTFS3_FS_POSIX_ACL
> >
> >  config NTFS_FS
>
> This alias should definitely go a way when you add back
> the original NTFS_FS.
>
> Preferably revert the commit that added the alias at the
> start of your series.
Okay.
>
> >       tristate "NTFS file system support"
> > +     depends on !DEFAULT_NTFSPLUS || m
> >       select NTFS3_FS
> >       select BUFFER_HEAD
> >       select NLS
> > diff --git a/fs/ntfsplus/Kconfig b/fs/ntfsplus/Kconfig
> > index 78bc34840463..c8d1ab99113c 100644
> > --- a/fs/ntfsplus/Kconfig
> > +++ b/fs/ntfsplus/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config NTFSPLUS_FS
> >       tristate "NTFS+ file system support (EXPERIMENTAL)"
> > +     depends on !DEFAULT_NTFS3 || m
>
> Likewise:
>         depends on NTFS3_FS != y || m
>
> Obviously, not tested.
>
> If this works, I don't think there is a need for the choice variable
>
> As long as you keep the order in fs/Kconfig correct (ntfs before ntfs3)
> I assume that an oldconfig with both set to y NTFS_FS will win?
> Please verify that.
Okay, I will check it.
Thanks for your review!
>
> Thanks,
> Amir.

