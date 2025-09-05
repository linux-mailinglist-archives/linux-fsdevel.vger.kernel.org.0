Return-Path: <linux-fsdevel+bounces-60340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD26B452FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D31885E83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD33054D6;
	Fri,  5 Sep 2025 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1sead0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34C2DF71F;
	Fri,  5 Sep 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063865; cv=none; b=e/N8cJ9ITDu8fCKIIRZRPwyFpcUh3sY4HwXXNYK52VWo2cExmdcmOF++9J6EgKLMmO+ospt5w0sRllFlg0J8mMHopsYRqZEkAP4LH1Ai7oud2UimB6yXydd6lh5fgxkXD16+dAKqdSv2moBBkxpPvDiiJom4Ciho3EdZcZsVto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063865; c=relaxed/simple;
	bh=psuRtuDnLxsx2zTSnT8LTOpiP2Bg5UgPAZ21S5KZ9ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=natop0uT8t+8n+2d6ioN8Fpx5V4FCGYDvKlH7NpjwiC4HoKPYSEHK1GwOZxQQW2QdUJIr3yBgg2nrlyuxCRz79kEDgsfgcvHubWzmGmtbIRR5cAillF2P/VIhAsFodpw9RXWx/JT/+25oLXGNw07dMBGvuOzvmmaKrCee2vVgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1sead0z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61ded2712f4so3320970a12.1;
        Fri, 05 Sep 2025 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757063862; x=1757668662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpYKGDOGRX34/ZVwlfuxW6/l5mMjJNcLqlSvourbEHE=;
        b=k1sead0zT/b0GZ8fjBc8Uu3TnFivZtU1/MakpyqHW1oTlgqRa6Sn3xU9+VosBa10Or
         srsA+FYlAdf+OERgv08vaKspmRS6HCi5TGXclO5FJ6b+sLnK62but7/FGoeP0AZ981aC
         pyDreHX6SujwxEF8JQwF56JKTjvDNED1kvJ0a1L/pJhFHz4MiG6fYYWAfntzbTP4Itvt
         BbXwbTbXmVyfd2YgNR6lJv50PeJ7PBLrK5F3DP9HZNoJ0jQ2Ay9+HpFT+mj95dDxXzg5
         LCcmNoMUykRGy0wKVxDWefORZcZ2mIF/u80xP+LzlRe/RP80M3oEQ+4qu712YdttmoV7
         p4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063862; x=1757668662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpYKGDOGRX34/ZVwlfuxW6/l5mMjJNcLqlSvourbEHE=;
        b=bSGowSPny4eY+9LnmUWHupnye4o5CW271YUz/x3qVgXSGPmloljzBncMH7dd4rjoQw
         /0x5zkhxa/GIQ0Kp/xDkdFDqGKQxc0VMkyfnjTFP9zaCJ1P4ewC8SAA54HOrO+uUU5JJ
         D/ulKzsaAJA52W91lvzTaw9LUHt+x9rso3hUKjU72Q8vbz4oe1vOu2F6YvhtURzNxHHI
         n9aOCMCs1ttHeNh8PWI8A7FtdHqekJlHTTorPS/4ayz/95LnDsevxPpmXvgCtd6JvmDa
         Olnhf/w+NuOf9UmGkBX6gjmziPmmTj3yWiHOr2M/uW7SZezfNyn5yh2zTXQiZxaPsQ9D
         AAxg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ynam5NFGSqh4div0hlPWVCaG4LKDF6QSNSXjESsjxyOghQ5FYpxQ35kzs5Xr0umNqjkf+HzH4QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzl1n3KUYGeVSXDbB8M31yDwjdwf8k6D5W++XmqhE3AYNaPxzm
	sKGpSEdfhD+sx90eII4PwCsoB8DRYoM7UPXzKn77R/CF0yv0f+FKO2PX+YYF8ygNewcLB2XlxOP
	9y+9WHQSChdb0wzo+IOTIrRnyoAZrh3k=
X-Gm-Gg: ASbGncunjdYanGyZXnC405Op1nGlx4AnzfGfopyFgmU90jnaOM3/3eNvqT8oLqcVCK5
	ZdooonE0KzOG76+SxfnRL+yTggYfB4yds90ptbtvyG0lB1fp3qokAY1Xjifeo6YwI3YSwI9R+Ss
	TJnQpb44Z9T7ZgOFLdp+t+uN3ckHE2g6jCA5COAD7Z02sfDkZAgoWe7Td7kEFu5ARvNa3FT4f53
	JgfkgQ=
X-Google-Smtp-Source: AGHT+IES5bHXVwwaG+UT3PZF9koe60lkGexHaaugyBfBkOCbmGhuG2IpfWaupdbGphiJ7C5ES7/SXREbKVdmWgFyNyY=
X-Received: by 2002:a05:6402:2693:b0:61c:9cd7:e5b3 with SMTP id
 4fb4d7f45d1cf-61d26d8059bmr18837198a12.28.1757063862016; Fri, 05 Sep 2025
 02:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904062215.2362311-1-rdunlap@infradead.org>
 <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com> <2025-09-05-armless-uneaten-venture-denizen-HnoIhR@cyphar.com>
In-Reply-To: <2025-09-05-armless-uneaten-venture-denizen-HnoIhR@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Sep 2025 11:17:30 +0200
X-Gm-Features: Ac12FXxQK5szfMOAenSrWFNpnXBYxkFiCvA4oKLkvz9HD9t1tvSGVoQuegPVJgU
Message-ID: <CAOQ4uxjcLDUcfdp72cpQcDQEtZaaR4G+P8oPXL_HbotFirGrKQ@mail.gmail.com>
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
To: Aleksa Sarai <cyphar@cyphar.com>, Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:11=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2025-09-04, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Thu, Sep 4, 2025 at 8:22=E2=80=AFAM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> > >
> > > Don't define the AT_RENAME_* macros at all since the kernel does not
> > > use them nor does the kernel need to provide them for userspace.
> > > Leave them as comments in <uapi/linux/fcntl.h> only as an example.
> > >
> > > The AT_RENAME_* macros have recently been added to glibc's <stdio.h>.
> > > For a kernel allmodconfig build, this made the macros be defined
> > > differently in 2 places (same values but different macro text),
> > > causing build errors/warnings (duplicate definitions) in both
> > > samples/watch_queue/watch_test.c and samples/vfs/test-statx.c.
> > > (<linux/fcntl.h> is included indirecty in both programs above.)
> > >
> > > Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should=
 be allocated")
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > ---
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Jeff Layton <jlayton@kernel.org>
> > > Cc: Chuck Lever <chuck.lever@oracle.com>
> > > Cc: Alexander Aring <alex.aring@gmail.com>
> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: David Howells <dhowells@redhat.com>
> > > CC: linux-api@vger.kernel.org
> > > To: linux-fsdevel@vger.kernel.org
> > > ---
> > >  include/uapi/linux/fcntl.h |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
> > > +++ linux-next-20250819/include/uapi/linux/fcntl.h
> > > @@ -155,10 +155,16 @@
> > >   * as possible, so we can use them for generic bits in the future if=
 necessary.
> > >   */
> > >
> > > +/*
> > > + * Note: This is an example of how the AT_RENAME_* flags could be de=
fined,
> > > + * but the kernel has no need to define them, so leave them as comme=
nts.
> > > + */
> > >  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> > > +/*
> > >  #define AT_RENAME_NOREPLACE    0x0001
> > >  #define AT_RENAME_EXCHANGE     0x0002
> > >  #define AT_RENAME_WHITEOUT     0x0004
> > > +*/
> > >
> >
> > I find this end result a bit odd, but I don't want to suggest another v=
ariant
> > I already proposed one in v2 review [1] that maybe you did not like.
> > It's fine.
> > I'll let Aleksa and Christian chime in to decide on if and how they wan=
t this
> > comment to look or if we should just delete these definitions and be do=
ne with
> > this episode.
>
> For my part, I'm fine with these becoming comments or even removing them
> outright. I think that defining them as AT_* flags would've been useful
> examples of how these flags should be used, but it is what it is.
>
> Then again, AT_EXECVE_CHECK went in and used a higher-level bit despite
> the comments describing that this was unfavourable and what should be
> done instead, so maybe attempting to avoid conflicts is an exercise in
> futility...

That's a bummer :-/
but to be fair, AT_EXECVE_CHECK was merged after v23, so I guess
the patch set started way before this comment and got rebased
after the comment was added, so it was easier to miss it.

>
> If it's too much effort to synchronise them between glibc then it's
> better to just close the book on this whole chapter (even though my
> impression is that glibc made a mistake or two when adding the
> definitions).

Considering that glibc has this fix lined up:
https://inbox.sourceware.org/libc-alpha/lhubjnpv03o.fsf@oldenburg.str.redha=
t.com/

Do we need to do anything at all?

Florian,

I am not that familiar with packaging and distributions of glibc
headers and kernel headers to downstream users.

What are the chances that us removing these definitions from the
current kernel header is going to help any downstream user in the future?

Thanks,
Amir.

