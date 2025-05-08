Return-Path: <linux-fsdevel+bounces-48470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D781CAAF8CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FF41C0215A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62D222597;
	Thu,  8 May 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPwiN7Js"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DF1917F4
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704184; cv=none; b=bppCo6rTXNiSU9nPGoN3E6ymLq/PjiLcV9KDE5j6zwjGgOwKVikfFPkfiPPWAuXvKxex+nu5qSddzYN2QAdHK0WFV8n3Fcko0vcXLpMCZdoiU0wA7j1qRbMjVJ/qzvOCDBG2fHgMkl3U/TLyyxPPI6EyQnUMS27MXCaiKbMOJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704184; c=relaxed/simple;
	bh=4PmoL0ZlAwdfHjc2UqqNn1vJlq1Cvs31iCZp9H/DufI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxqZWMW++qOYdgGtQls2SVKNsUOsCR+kbBhXEUAyht7BifshHrMvV88IBuDvDnhkLF5bYiovicrdaiUNkK1+gSKnU4X1ItTDtCMsMor4OLNg0Ha7MAHx88n3IXJK5EwZu7vOktRsrXkqlm0y40+v5YGvsTheUbykvEFzhmAN6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPwiN7Js; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so161475366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746704181; x=1747308981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4mV5ys6pW+UVmK7bzfRB8gzxU/0ufr4nV6OdHerjJ8=;
        b=DPwiN7JsgxdygtMgz0s0q00UKrAqbeud6fCxhwu2WkW/iIlAHixTDekbkpHmXhUKre
         0D37LVIwKtxmeoBrv53YOuXKGri5jg/7bKPSP5BFUuHD1Y+y9gX3Lo96/Iqy5+HEllP+
         ccYtzCUqh/kdQw34JsT4kDN20wVfFsgr1SqCfpPY3WQgKN63XgRcSNYNzC3IAfNREutN
         6V9SB2/nTH8+9nJi43p1KljiuYw7QZF8a9CKVaJDvmk9CZRlXESMK0i7LLFHLXfw4oBM
         ZeGNgDUIv0cRyZFancK6i3obwAXAM4VX+eGDr5y/0shsIuxWCzSbXW+w2ugkjZkJl+pj
         YH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704181; x=1747308981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4mV5ys6pW+UVmK7bzfRB8gzxU/0ufr4nV6OdHerjJ8=;
        b=ITMXN8YUC2eSUPwYJNWWa6KVQnQ2yvhA+7tGiEdY+7Ltz41zr9cmu1LRextFdKsZWN
         FmRL4svmZlp1lLGLYBIm6zuFV6T5YiwMz9vRj1C/UFFV2aWeT+BKxKxZI7ww31HIioaS
         P9meU2BrXPnUxNvgJU6YJniOW1G0npEQIt8PtHDYovIu1YIE5eSIIXg5s/vzbXpY4xkN
         5BNp+8ZH59guYYAlgdb0mg4bI24U12Nf7RUpZ5g5D3PnXVuTMwBquAaeNO+6O3zPldKZ
         +6j9ieQCGIFIAVu64OiBxLhoMr0QcQ5f42b+xg8fZGFmS6jwnkxXhLq951iTVQTSGtXo
         YBGg==
X-Forwarded-Encrypted: i=1; AJvYcCW+731ICTb4RsSkxmv0QgulCXiozUYdkgOs5ZMffQKserfYjBKEIGkXitSVsiXMYxkje5uyuJE2Ox1MZBCt@vger.kernel.org
X-Gm-Message-State: AOJu0YwHF0G4Jkry1ciJb6l1l0/g6oDQwJ1dXMzOWqszSlf1U2hOu525
	fKsjFqO5U8iscrgDKeYNxIsyw9nfeRdz3WD/VY5nGrdiz5aTzngKmoPSiF3omPCMT16obUk80S3
	5x0bfJQtCl6ktYbHfkEgFIkPec1c=
X-Gm-Gg: ASbGncsYniwyWviqCsA8Snlb+UELbc+XlDQYhcQZADdeigpJPfz33cfuwONtq3Gurut
	jYw/jyRsUmdgcMrWBvN049o11f01lbMQD8WeSmzmMC732fZ1omINHRKiCfYkTpQA7tKzHK/5ifz
	gMAdzUniK/NAn+32SmxqPtkQ==
X-Google-Smtp-Source: AGHT+IFVlWbkEdA9OjIZ1uyZPrHBB4jHC2wngq21r5Jsy/8oGtdorO42QGCY9v6dYj4Pr+G54hOYGeaWOmo/EnnAEvk=
X-Received: by 2002:a17:907:d2a:b0:ace:cbe0:2d67 with SMTP id
 a640c23a62f3a-ad1e8d0d4dfmr733756566b.55.1746704180496; Thu, 08 May 2025
 04:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507204302.460913-1-amir73il@gmail.com> <20250507204302.460913-3-amir73il@gmail.com>
 <ad3c6713-1b4b-47e4-983b-d5f3903de4d0@nvidia.com>
In-Reply-To: <ad3c6713-1b4b-47e4-983b-d5f3903de4d0@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 13:36:09 +0200
X-Gm-Features: ATxdqUHLzNnxJSYAM2ZL5Fn9GYqEGNgy_NF8VkgyjCY7l38QzYEpNSFfLh5Gszs
Message-ID: <CAOQ4uxin2B+wieUaAj=CeyEn4Z0xGUvBj5yOawKiuqPp+geSGg@mail.gmail.com>
Subject: Re: [PATCH 2/5] selftests/fs/statmount: build with tools include dir
To: John Hubbard <jhubbard@nvidia.com>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forgot to CC Miklos (now added)

On Thu, May 8, 2025 at 9:31=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/7/25 1:42 PM, Amir Goldstein wrote:
> > Copy the required headers files (mount.h, nsfs.h) to the
> > tools include dir and define the statmount/listmount syscalls
> > for x86_64 to decouple dependency with headers_install for the
> > common case.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
...
> > -CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES)
> > +CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>
> Yes. :)
>
> > +
> >   TEST_GEN_PROGS :=3D statmount_test statmount_test_ns listmount_test
> >
> >   include ../../lib.mk
> > diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h =
b/tools/testing/selftests/filesystems/statmount/statmount.h
> > index a7a5289ddae9..e84d47fadd0b 100644
> > --- a/tools/testing/selftests/filesystems/statmount/statmount.h
> > +++ b/tools/testing/selftests/filesystems/statmount/statmount.h
> > @@ -7,6 +7,18 @@
> >   #include <linux/mount.h>
> >   #include <asm/unistd.h>
> >
> > +#ifndef __NR_statmount
> > +#if defined(__x86_64__)
> > +#define __NR_statmount       457
> > +#endif
> > +#endif
> > +
> > +#ifndef __NR_listmount
> > +#if defined(__x86_64__)
> > +#define __NR_listmount       458
> > +#endif
> > +#endif
>
> Yes, syscalls are the weak point for this approach, and the above is
> reasonable, given the situation, which is: we are not set up to recreate
> per-arch syscall tables for kselftests to use. But this does leave the
> other big arch out in the cold: arm64.
>
> It's easy to add, though, if and when someone wants it.

I have no problem adding || defined(__arm64__)
it's the same syscall numbers anyway.

Or I could do
#if !defined(__alpha__) && !defined(_MIPS_SIM)

but I could not bring myself to do the re-definitions that Christian
added in mount_setattr_test.c for
__NR_mount_setattr, __NR_open_tree, __NR_move_mount

Note that there are stale definitions for __ia64__ in that file
and the stale definition for __NR_move_mount is even wrong ;)

Christian,

How about moving the definitions from mount_setattr_test.c into wrappers.h
and leaving only the common !defined(__alpha__) && !defined(_MIPS_SIM)
case?

Thanks for the review!

Amir.

