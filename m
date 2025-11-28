Return-Path: <linux-fsdevel+bounces-70128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 716ABC91977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB2CA34B2BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103E309EFB;
	Fri, 28 Nov 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLVNsf5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177471FF5E3
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325102; cv=none; b=nK1RIMTrkC9mGR70utOolCe8Xh2aECVaxXrbcCKnns5O1Bs7IXK2EsSnT6IifDlAQeXLRuFNCfRD1bz4W11hebfZScrBSai+9quVUHviP2FpgUz705Iu1KhLh+f6iKJe5rxBOAWGqQ3z49hd6d5nYA716/J8s963hGMs6gYBj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325102; c=relaxed/simple;
	bh=PjmG0xaWd42rkWi6yMwDIBbUaVkgKTX07rG2csxPtwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFC0c3zTF51ycHqH7SWQL3sbwgA/x6Lq8FBXfoZyCGRrTWjCNWHkhuSK8J2hgaaL+6r50NH8NJ9UJcD2Bi9RQ4UV49BxSxb0XqX3T/vk9EnmUwxXPN5A++yTfkeqmwY/AdVcnJVjM+loD8aDGvWu0waqjtj10OpKYHAxh2lSn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLVNsf5d; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7633027cb2so90309966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 02:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764325099; x=1764929899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5klg2JAmQdVXm6DWGJJqcZOfHSZ2L1atog23dJPbA8=;
        b=LLVNsf5dACHMY62MOInTqvfu0q/rPmDu+RG9Av2r0kFO8PCRImdavX0clWh5dtFCVi
         sxbY/w9ALfZb1HjUJDLunZkkMfQc6ycJsa6chKv6LzUc0Gin5RF235rmYFTR6RAZZrav
         AaCX/PidThMQG0Mx/1xc/azLYYL11I8nrNvVX+kMkss1bsGaOG8D8QcUDluXWmoUCkp9
         x/HaDwwvj41cnusg8YNXUxVJUCN5L7ojfcV44H6D88rjNwFl0WvhxfqtapOwy0ZIXICr
         wjk05luCNVs8frHkbFxdyjCk4q3mVG+2UcnX1ms37DG7Sjy/NO/q372+qJrAxDh7LDRz
         qB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764325099; x=1764929899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5klg2JAmQdVXm6DWGJJqcZOfHSZ2L1atog23dJPbA8=;
        b=xOm9zIijSwIz6tqVJHfdn36fY0EvM1c5VwvCe3ETWpZBVVprjbawcOkh/p7fxor1V5
         ervj7SDZoHzI1XpcCgy3fP9o9t4VxudIjUHT6IOa5cF/KV7B100k4APb9WYkzZB/Nory
         pj8SdsLyLbeI/KDBmyGyHZprZmP7Isk/D7jKDgDJ4/c+tWHSKW6ceN7ebBmdgTJZJmdn
         07/cG9A6FcGZDA6gZuALCqQ8Pg5IRpOIMGRoOCU3qqcnA7uZUFs/jd/wd/kQVt9/L07C
         I81a77ce5QS8Q+gFWzhu79JyBPf+DpoPnmuJ4rUWNo0ZbB+6yHxe0XZsxZxlZSDLFaGd
         FT7A==
X-Forwarded-Encrypted: i=1; AJvYcCXqCtrJLmjTgAhy9L/6EuAQ+9mHJXfCCIAYd6mqXfpEEgm7j/8+RiF6l1aGgSeXgXDzGIDZtC/aGzcK0mm8@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQTFYw+8nOVt8Ptcad2nmAuMPTTBXK6QKQahPLKcV9JUOJmmc
	Aem0WYENaaJ0TW51yJhegFJRXg/K9Gm5F40qNgzz1LKuMMa9QVqJonWL
X-Gm-Gg: ASbGncvlynLcr7cpTFYulEEIcAJZ91PXbzFbtQah0I/HvM6kFbtERfiVkPDwJmoZMnV
	xWRl9ER1R6ikw1GSHThoiVSfmkL7tQJ6Uj/cOa8hzxGoF9BaxIkCHCMZ3RFCJgJwmsl/Gx1KQxj
	QpzMdqR4fIdGA+RqBMjlLOw1d9MjFaRHni8F4cXys4e8AzYO9AWrAd1LMaJ+BYGijfh216n69LC
	m7HWQKx1R/RwoOMpcSXm4KPBUGlTZx9oaQpnVCgcRkRYounaUaHanKjFkq0OK8A4Y9JhMj8U5d+
	RUbdOpKDk/mt6OOp3ewsAq5lB5OZ5VB6OurHQcIEq6UT9VEJPyQyajfLmwJH7zf2uZxUMXS69P7
	LXae9WhFR1SmkwPmMrbOrDxgHhMyfQoa09C0a61Ln2B6qcEKXttCeAnUbN9vuli8YKbBuIPRQQO
	H7GbMZe/NuWqcLQASVEY+e5+HgQ4iTTbRpELZr9wG/+ioepSpznFFZ46Cs0L8r4m3fjbuQPZndU
	1Xdv27YEl01uNX+U1R/ocdXpgs=
X-Google-Smtp-Source: AGHT+IHUyA5f1Y7RZ2PUJ+kCQxeimZ7hInc35srFX72lIU5BCzyzYVLKGQj3beoG0HJAYpFqvZuuag==
X-Received: by 2002:a17:907:3ea1:b0:b73:8639:cd8e with SMTP id a640c23a62f3a-b767153edd9mr3000691466b.4.1764325098968;
        Fri, 28 Nov 2025 02:18:18 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-496b-7a85-725c-34fb.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:496b:7a85:725c:34fb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162c5csm420931366b.6.2025.11.28.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 02:18:18 -0800 (PST)
Date: Fri, 28 Nov 2025 11:18:17 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
Message-ID: <aSl26bbeD4-Ev1ky@amir-ThinkPad-T480>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-12-linkinjeon@kernel.org>
 <CAOQ4uxhwy1a+dtkoTkMp5LLJ5m4FzvQefJXfZ2JzrUZiZn7w0w@mail.gmail.com>
 <CAKYAXd99CJOeH=nZg_iLb+q5F5N+xxbZm-4Uwxas_tAR3e_xVA@mail.gmail.com>
 <CAOQ4uxiGMLe=FD72BBCLnk6kmOTrqSQ5wM4mVHSshKc+TN14TQ@mail.gmail.com>
 <CAKYAXd8K76CeQNtR-QOMSJ_JjuoiibuQkd4NhkPPM_CQNdNajw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd8K76CeQNtR-QOMSJ_JjuoiibuQkd4NhkPPM_CQNdNajw@mail.gmail.com>

On Fri, Nov 28, 2025 at 12:02:25PM +0900, Namjae Jeon wrote:
> On Thu, Nov 27, 2025 at 10:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Nov 27, 2025 at 1:40 PM Namjae Jeon <linkinjeon@kernel.org> wrote:
> > >
> > > On Thu, Nov 27, 2025 at 8:22 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Thu, Nov 27, 2025 at 6:01 AM Namjae Jeon <linkinjeon@kernel.org> wrote:
> > > > >
> > > > > This adds the Kconfig and Makefile for ntfsplus.
> > > > >
> > > > > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > > > > ---
> > > > >  fs/Kconfig           |  1 +
> > > > >  fs/Makefile          |  1 +
> > > > >  fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > > > >  fs/ntfsplus/Makefile | 18 ++++++++++++++++++
> > > > >  4 files changed, 65 insertions(+)
> > > > >  create mode 100644 fs/ntfsplus/Kconfig
> > > > >  create mode 100644 fs/ntfsplus/Makefile
> > > > >
> > > > > diff --git a/fs/Kconfig b/fs/Kconfig
> > > > > index 0bfdaecaa877..70d596b99c8b 100644
> > > > > --- a/fs/Kconfig
> > > > > +++ b/fs/Kconfig
> > > > > @@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
> > > > >  source "fs/fat/Kconfig"
> > > > >  source "fs/exfat/Kconfig"
> > > > >  source "fs/ntfs3/Kconfig"
> > > > > +source "fs/ntfsplus/Kconfig"
> > > > >
> > > > >  endmenu
> > > > >  endif # BLOCK
> > > > > diff --git a/fs/Makefile b/fs/Makefile
> > > > > index e3523ab2e587..2e2473451508 100644
> > > > > --- a/fs/Makefile
> > > > > +++ b/fs/Makefile
> > > > > @@ -91,6 +91,7 @@ obj-y                         += unicode/
> > > > >  obj-$(CONFIG_SMBFS)            += smb/
> > > > >  obj-$(CONFIG_HPFS_FS)          += hpfs/
> > > > >  obj-$(CONFIG_NTFS3_FS)         += ntfs3/
> > > > > +obj-$(CONFIG_NTFSPLUS_FS)      += ntfsplus/
> > > >
> > > > I suggested in another reply to keep the original ntfs name
> > > >
> > > > More important is to keep your driver linked before the unmaintained
> > > > ntfs3, so that it hopefully gets picked up before ntfs3 for auto mount type
> > > > if both drivers are built-in.
> > > Okay, I will check it:)
> > > >
> > > > I am not sure if keeping the order here would guarantee the link/registration
> > > > order. If not, it may make sense to mutually exclude them as built-in drivers.
> > > Okay, I am leaning towards the latter.
> >
> > Well it's not this OR that.
> > please add you driver as the original was before ntfs3
> >
> > obj-$(CONFIG_NTFS_FS)      += ntfs/
> > obj-$(CONFIG_NTFS3_FS)         += ntfs3/
> Okay.
> >
> > > If you have no objection, I will add the patch to mutually exclude the two ntfs implementation.
> >
> > You should definitely allow them both if at least one is built as a module
> > I think it would be valuable for testing.
> >
> > Just that
> > CONFIG_NTFS_FS=y
> > CONFIG_NTFS3_FS=y
> >
> > I don't see the usefulness in allowing that.
> > (other people may disagree)
> >
> > I think that the way to implement it is using an auxiliary choice config var
> > in fs/Kconfig (i.e. CONFIG_DEFAULT_NTFS) and select/depends statements
> > to only allow the default ntfs driver to be configured as 'y',
> > but couldn't find a good example to point you at.
> Okay. Could you please check whether the attached patch matches what
> you described ?

It's what I meant, but now I think it could be simpler...

> 
> Thanks!
> >
> > Thanks,
> > Amir.

> From 11154917ff53d6cf218ac58e6776e603246587b6 Mon Sep 17 00:00:00 2001
> From: Namjae Jeon <linkinjeon@kernel.org>
> Date: Fri, 28 Nov 2025 11:44:45 +0900
> Subject: [PATCH] ntfs: restrict built-in NTFS seclection to one driver, allow
>  both as modules
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/Kconfig          | 11 +++++++++++
>  fs/ntfs3/Kconfig    |  2 ++
>  fs/ntfsplus/Kconfig |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 70d596b99c8b..c379383cb4ff 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -155,6 +155,17 @@ source "fs/exfat/Kconfig"
>  source "fs/ntfs3/Kconfig"
>  source "fs/ntfsplus/Kconfig"
>  
> +choice
> +   prompt "Select built-in NTFS filesystem (only one can be built-in)"
Usually for choice vars there should be a default and usually
there should be a DEFAULT_NTFS_NONE

> +   help
> +     Only one NTFS can be built into the kernel(y).
> +     Both can still be built as modules(m).
> +
> +   config DEFAULT_NTFSPLUS
> +       bool "NTFS+"
Usually, this would also 'select NTFS_FS'

> +   config DEFAULT_NTFS3
> +       bool "NTFS3"
> +endchoice
>  endmenu
>  endif # BLOCK
>  
> diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> index 7bc31d69f680..18bd6c98c6eb 100644
> --- a/fs/ntfs3/Kconfig
> +++ b/fs/ntfs3/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config NTFS3_FS
>  	tristate "NTFS Read-Write file system support"
> +	depends on !DEFAULT_NTFSPLUS || m

So seeing how this condition looks, instead of aux var,
it could be directly

	depends on NTFS_FS != y || m

>  	select BUFFER_HEAD
>  	select NLS
>  	select LEGACY_DIRECT_IO
> @@ -49,6 +50,7 @@ config NTFS3_FS_POSIX_ACL
>  
>  config NTFS_FS

This alias should definitely go a way when you add back
the original NTFS_FS.

Preferably revert the commit that added the alias at the
start of your series.

>  	tristate "NTFS file system support"
> +	depends on !DEFAULT_NTFSPLUS || m
>  	select NTFS3_FS
>  	select BUFFER_HEAD
>  	select NLS
> diff --git a/fs/ntfsplus/Kconfig b/fs/ntfsplus/Kconfig
> index 78bc34840463..c8d1ab99113c 100644
> --- a/fs/ntfsplus/Kconfig
> +++ b/fs/ntfsplus/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config NTFSPLUS_FS
>  	tristate "NTFS+ file system support (EXPERIMENTAL)"
> +	depends on !DEFAULT_NTFS3 || m

Likewise:
	depends on NTFS3_FS != y || m

Obviously, not tested.

If this works, I don't think there is a need for the choice variable

As long as you keep the order in fs/Kconfig correct (ntfs before ntfs3)
I assume that an oldconfig with both set to y NTFS_FS will win?
Please verify that.

Thanks,
Amir.

