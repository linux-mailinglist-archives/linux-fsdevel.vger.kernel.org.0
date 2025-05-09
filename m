Return-Path: <linux-fsdevel+bounces-48614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD5AB1551
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027324A488A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348B2749F6;
	Fri,  9 May 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlznHbtE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530933FD
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797689; cv=none; b=NLvJ2R7MbkHvmEafEWFriP+P00UwJz0fiQ+k/7XIARU/V7dTypl9IcuNfith72k0eMo2j2Hrtq8YTA3dkLO7jxU10EeGd7cvmSP/7FHguB7waAtvc55LgY6eSi1Geyt89Nk3MXZnnry462HOe3MbsXunzBulnGkTfqcRs0p5Cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797689; c=relaxed/simple;
	bh=baGoWgB3WYVQ8iyhsx6zVF+rA3dtXqW6xeeqqeCJAZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vcf3MJj1h6sCJJ95vTskspeWLvmQauE4aNkvffbySeFExW8lC+yLcdPIUibl75kfsQkQr4sln3SwXLi9HWqkF5R2rjf6IW1cMqtja/kyCUmPP9aSwWxLHkTXSnu7oGki+gQwRH4I+AugkzfACkDl290QLGHksItIyA2fPdlOyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlznHbtE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac345bd8e13so308965366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797685; x=1747402485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdosoWI29I8QL8YFsa+F5aN4gtE8ZrwhYOGZeVpoG7M=;
        b=jlznHbtEayvWjIgwFji6Ru94yhrvSM7i7rvZ7m8h3MxKJyCVJAY1X9Ow8PV0OJhXeZ
         +yOHJsnPWdg6ShWy4PbLhpLcHshlvVXoKgh0JxDpKJr+8a2aITOejfkF9F21dd8/gjk0
         Z43Ijr1UupvRUdZiEbegoVpkG9Vm+B6t1vWalq2dt9NJLgcIZZrTNpgOuTN+2YxVPSUL
         6s/aKz4aNEAzV/0rTIvWxSeeglxdXOjAaIQLY4QebDPlv/sfDurYOwxtc7UzUdSdOrFQ
         YSSTLEBb4F3IdvK0I0VkMo70kqo1kAUTvOuTQNAHOPpZWDQXiRGoL+l/FNfn/LmQBKHi
         sdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797685; x=1747402485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdosoWI29I8QL8YFsa+F5aN4gtE8ZrwhYOGZeVpoG7M=;
        b=sME6YzX1mYaTV3LD3U5sv2soH41oEwhBauqrCobjDHriF9HMOFBd2qRMBbOGjg2pZ1
         gZNILveV/eWScLv2SjhiB1MXSJ+oTnegqpJwlPIwxGpCeaIxzB0/3OEG2NYAVWuwE/zl
         XJgOImHQkLfBI4nDOU3tafd5WUnbdrWAZjNrshTxtblY2LYUt+dSnd6Ug/2T7YyAgh/B
         3J4t52M3gTzaoiB7zakxkWEhaBsBn63s9SVqMM7AKzLPdqxVljSFwXbkwdI91d57pm5r
         WESr7/7wHQGd7cGiabkLcmDl4gerIj1XF0fv+kwzM3vLaFekzd3d9vCritwXftq4hPpG
         i6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXw2TeY/pTsNta3i8hzhom8WMfnI0wv7zHnglkoF87WH6bqhIFsKpgZM9QtUMGLMuUXczyI7Vsp0AzkKOpv@vger.kernel.org
X-Gm-Message-State: AOJu0YyXV/j8p2xnsKWbko+bdma/icpXuEZd16V88IJcacf7vAoAFVBH
	m0MSSxJaMbFpkp85RmGj3WeOLMByHvoUdsCuFEqZKPxG8/+b/kqUda0cxp0pDl5AyTES6o7mOkJ
	Gp77FIMmhiAN6qRdKoZRpjnydi+I=
X-Gm-Gg: ASbGncuLbbMFVSwNdyiqT4MlzJevGYVAqYIaFmCjHnHgQm85FssH3vHgxZ+ZxKbRzHf
	eoBnlH66KImQU63L4ZKInxOTBbAHExAy0KhrazAWbW5LEyOrklpmLzFPauL1taYwOzd0wETI0Vt
	q+elFR2dRPyct+/gf+L9X34g==
X-Google-Smtp-Source: AGHT+IEq2792uSj6h/aCEFrGlfAwRVM38y7PhSdNHljnzCxxiYQXkjzyVetYcbYaFqDU4jY0kSiJpuTZgscBhNJn8VQ=
X-Received: by 2002:a17:907:7b04:b0:ace:dd20:2c25 with SMTP id
 a640c23a62f3a-ad21917afe8mr334455766b.51.1746797685164; Fri, 09 May 2025
 06:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507204302.460913-1-amir73il@gmail.com> <20250507204302.460913-3-amir73il@gmail.com>
 <ad3c6713-1b4b-47e4-983b-d5f3903de4d0@nvidia.com> <CAOQ4uxin2B+wieUaAj=CeyEn4Z0xGUvBj5yOawKiuqPp+geSGg@mail.gmail.com>
 <20250509-verhielt-hecht-4850ff585c31@brauner>
In-Reply-To: <20250509-verhielt-hecht-4850ff585c31@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 15:34:33 +0200
X-Gm-Features: ATxdqUH2MXU8CHpeTUtKvSteBwUifATjvkF3tYwH1jhvW-qxZ1uxA3kS9mSMzEw
Message-ID: <CAOQ4uxjHbMDb2MRQyJujx6p230wWRM_FOfSQVgqGOiZJpyzDHw@mail.gmail.com>
Subject: Re: [PATCH 2/5] selftests/fs/statmount: build with tools include dir
To: Christian Brauner <brauner@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 12:57=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, May 08, 2025 at 01:36:09PM +0200, Amir Goldstein wrote:
> > Forgot to CC Miklos (now added)
> >
> > On Thu, May 8, 2025 at 9:31=E2=80=AFAM John Hubbard <jhubbard@nvidia.co=
m> wrote:
> > >
> > > On 5/7/25 1:42 PM, Amir Goldstein wrote:
> > > > Copy the required headers files (mount.h, nsfs.h) to the
> > > > tools include dir and define the statmount/listmount syscalls
> > > > for x86_64 to decouple dependency with headers_install for the
> > > > common case.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > ...
> > > > -CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES)
> > > > +CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> > >
> > > Yes. :)
> > >
> > > > +
> > > >   TEST_GEN_PROGS :=3D statmount_test statmount_test_ns listmount_te=
st
> > > >
> > > >   include ../../lib.mk
> > > > diff --git a/tools/testing/selftests/filesystems/statmount/statmoun=
t.h b/tools/testing/selftests/filesystems/statmount/statmount.h
> > > > index a7a5289ddae9..e84d47fadd0b 100644
> > > > --- a/tools/testing/selftests/filesystems/statmount/statmount.h
> > > > +++ b/tools/testing/selftests/filesystems/statmount/statmount.h
> > > > @@ -7,6 +7,18 @@
> > > >   #include <linux/mount.h>
> > > >   #include <asm/unistd.h>
> > > >
> > > > +#ifndef __NR_statmount
> > > > +#if defined(__x86_64__)
> > > > +#define __NR_statmount       457
> > > > +#endif
> > > > +#endif
> > > > +
> > > > +#ifndef __NR_listmount
> > > > +#if defined(__x86_64__)
> > > > +#define __NR_listmount       458
> > > > +#endif
> > > > +#endif
> > >
> > > Yes, syscalls are the weak point for this approach, and the above is
> > > reasonable, given the situation, which is: we are not set up to recre=
ate
> > > per-arch syscall tables for kselftests to use. But this does leave th=
e
> > > other big arch out in the cold: arm64.
> > >
> > > It's easy to add, though, if and when someone wants it.
> >
> > I have no problem adding || defined(__arm64__)
> > it's the same syscall numbers anyway.
> >
> > Or I could do
> > #if !defined(__alpha__) && !defined(_MIPS_SIM)
> >
> > but I could not bring myself to do the re-definitions that Christian
> > added in mount_setattr_test.c for
> > __NR_mount_setattr, __NR_open_tree, __NR_move_mount
> >
> > Note that there are stale definitions for __ia64__ in that file
> > and the stale definition for __NR_move_mount is even wrong ;)
> >
> > Christian,
> >
> > How about moving the definitions from mount_setattr_test.c into wrapper=
s.h
> > and leaving only the common !defined(__alpha__) && !defined(_MIPS_SIM)
> > case?
> >
> > Thanks for the review!
>
> For new system calls this covers all arches and is what I usually use:
>
> #ifndef __NR_open_tree
>         #if defined __alpha__
>                 #define __NR_open_tree 538
>         #elif defined _MIPS_SIM
>                 #if _MIPS_SIM =3D=3D _MIPS_SIM_ABI32        /* o32 */
>                         #define __NR_open_tree 4428
>                 #endif
>                 #if _MIPS_SIM =3D=3D _MIPS_SIM_NABI32       /* n32 */
>                         #define __NR_open_tree 6428
>                 #endif
>                 #if _MIPS_SIM =3D=3D _MIPS_SIM_ABI64        /* n64 */
>                         #define __NR_open_tree 5428
>                 #endif
>         #elif defined __ia64__
>                 #define __NR_open_tree (428 + 1024)
>         #else
>                 #define __NR_open_tree 428
>         #endif
> #endif
>
> where the ia64 stuff can obviously be removed now.

All right.
Sent v2 with all those defs for listmount/statmount.

Thanks,
Amir.

