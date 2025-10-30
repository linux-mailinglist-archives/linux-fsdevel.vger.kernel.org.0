Return-Path: <linux-fsdevel+bounces-66474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEF6C2046C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BC774EC254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942A25A333;
	Thu, 30 Oct 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb9hYRce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A5258EC1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831543; cv=none; b=bMNlfJidUhBV7jb0dgSpUkoNiJRCXCfNnUy7h4s55hoTx2c+BfZycVofEYQ+znebAeQ0dWfLFrnnMpjw9HXA3lTkUKzEzHqO0Xfv1JJdl1hT3fD3D3eAijkQEcwBBtBze59LbfolD7t0ltvK1FDnk+dtMrUY+pOXiJazilKA5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831543; c=relaxed/simple;
	bh=RZeQGMHFOH8IQEd+QAFU2HEJjBeOnS7QbhpbX49cPFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAkM85c+PhPlfelBD29juGksuYGtCDVemud+jTBN8kriFi72mFFz31wORRu1u7OVo6zQWnz6D7XXWjL/lg8Cu3CBiJtZGSrjgPujKiPHThU4B6Ft0LFgbSZFaxd7C/5cTbuMsSP7y5gBmYANDvjdjAjaRf9P5xpM7zJ2SvNjcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb9hYRce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1577EC4AF0C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761831543;
	bh=RZeQGMHFOH8IQEd+QAFU2HEJjBeOnS7QbhpbX49cPFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nb9hYRceUk4W4O5p6nhZrodzLSDCg8SsMQbXPWNYvvDYZnusWNRjM6KboL8KOM2IG
	 q5/GtAicLgoXVOhY/NZTW0rfpNwuHHMrf4bi1BNZJHl5dHgxNHZd24K/hPItkEloyA
	 XDm1NwYVPHwsUESuIIcoF2JEtrW3lOLC0laqsDCcCjOOg23+Yb4EOsQP1c5IVf9TiX
	 swb0AfldRuGM4uJ3UIIX784TrHoHYSV2cTEVEfKK8ykC+DRKJt2+zKEhMfsd+Egnng
	 wyz4BvU0uA4wZB6bF22hafMDQLnG67sVe7ALTrreMyurTzTY/nzQLkhViIasmHhOPQ
	 en/rM3RnlpQJA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592ff1d80feso235106e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 06:39:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWSsqVM66QiU4rgFaBEQ8XOSS7X22TCb9m76yEkMfKGdkXfnBocsNBCZ7ldP97e1EN9iUbRGT0ZNXOzTao@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+o3gxdMV2scsUe1XLStsNHxaKbieZKduLyAH+Q0NjKIL4UMx
	M8LuPrQn1GCm7rhLc2C4g2r2/uYl0I6wP5ED3l0t0oufT0/3jZcHXfQtRIozkpQ84SGH0e9hgqr
	jgPdNtaFT5NbyxCqybJ/hd8KkWpW1yks=
X-Google-Smtp-Source: AGHT+IHJDdIvykMw+qJaXdyYIgiRY+DnHc+mIPN9yuvhEb417CvySaFKQBQhUVYBR40vSqzm7Jpnk2FtJN3WqXDoG3k=
X-Received: by 2002:a05:6512:3d27:b0:592:eea5:fa43 with SMTP id
 2adb3069b0e04-5941286ace8mr2039646e87.22.1761831541434; Thu, 30 Oct 2025
 06:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner> <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner> <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
 <20251030-zuruf-linken-d20795719609@brauner> <20251029233057.GA3441561@ax162> <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
In-Reply-To: <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 30 Oct 2025 14:38:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHP14_F1xUYHfUzvtoNJjPEQM9yLaoKQX=v4j3-YyAn=A@mail.gmail.com>
X-Gm-Features: AWmQ_bliKhnn90c2eiWfm-ZlkCUlsnCwA4TiK8TvhwYvM10GpQouQ-ssEgWtCxg
Message-ID: <CAMj1kXHP14_F1xUYHfUzvtoNJjPEQM9yLaoKQX=v4j3-YyAn=A@mail.gmail.com>
Subject: Re: fms extension (Was: [PATCH] fs/pipe: stop duplicating union
 pipe_index declaration)
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-efi@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 14:23, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Oct 29, 2025 at 04:30:57PM -0700, Nathan Chancellor wrote:
> > On Thu, Oct 30, 2025 at 12:13:11AM +0100, Christian Brauner wrote:
> > > I'm fine either way. @Nathan, if you just want to give Linus the patch
> > > if it's small enough or just want to give me a stable branch I can pull
> > > I'll be content. Thanks!
> >
> > I do not care either way but I created a shared branch/tag since it was
> > easy enough to do. If Linus wants to take these directly for -rc4, I am
> > fine with that as well.
> >
> > Cheers,
> > Nathan
> >
> > The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> >
> >   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-ms-extensions-6.19
>
> Thanks, I pulled this and placed it into a branch that I can base other
> branches on.
>
> _But_, I'm already running into problems. :)
>
...
>
> Because struct cgroup_namespace embeddds struct ns_common and it
> proliferates via mm stuff into the efi code.
>
> So the EFI cod has it's own KBUILD_CFLAGS. It does:
>
> # non-x86 reuses KBUILD_CFLAGS, x86 does not
> cflags-y                        := $(KBUILD_CFLAGS)
>
> <snip>
>
> KBUILD_CFLAGS                   := $(subst $(CC_FLAGS_FTRACE),,$(cflags-y)) \
>                                    -Os -DDISABLE_BRANCH_PROFILING \
>                                    -include $(srctree)/include/linux/hidden.h \
>                                    -D__NO_FORTIFY \
>                                    -ffreestanding \
>                                    -fno-stack-protector \
>                                    $(call cc-option,-fno-addrsig) \
>                                    -D__DISABLE_EXPORTS
>
> which means x86 doesn't get -fms-extension breaking the build. If I
> manually insert:
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 94b05e4451dd..4ad2f8f42134 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -42,6 +42,8 @@ KBUILD_CFLAGS                 := $(subst $(CC_FLAGS_FTRACE),,$(cflags-y)) \
>                                    -ffreestanding \
>                                    -fno-stack-protector \
>                                    $(call cc-option,-fno-addrsig) \
> +                                  -fms-extensions \
> +                                  -Wno-microsoft-anon-tag \
>                                    -D__DISABLE_EXPORTS
>
> The build works...
>
> I think we need to decide how to fix this now because as soon as someone
> makes use of the extension that is indirectly included by that libstub
> thing we're fscked.

Unless anyone is feeling brave and wants to untangle the x86 command
line delta between the stub and core kernel, I suggest we just add
these flags just like you proposed (assuming all supported compilers
tolerate their presence)

