Return-Path: <linux-fsdevel+bounces-48583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13114AB11BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EC052538F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519628F939;
	Fri,  9 May 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXJ8rsp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C028F537
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788919; cv=none; b=gnd4DGirEKXpWb6bushKwGsoULBr/YYLUo8NSNJAQmFXCnvdkg1xC+lyTAD4nYZdqDokgHWZmb/FPkN+PNdGhWfMBmyrJhZj9Yf9AtvV+cOUPE3vbC2y5c00oVmvYoVglQJl3/NRI1tM91M+Fo/i4IWi8ABWVCgGB3a5DXZtVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788919; c=relaxed/simple;
	bh=k5562C/7XA+1XnzUBlXwPVVC7OvIMHtCvplcg25LCrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxNl/UNvJwcqoRPxBCEpaIAEe2NCCXFOrzLzOWXidpqTCKHG7/lfE42I5fs1guEbX8b5ozxkJlcm9O9VDmUIcgCpKZh3MJ8q6/5jcBnsFgXQUL7JT2uuIzol7Z56+zzu86zBoNJPAM+UqZxF9qDpc4elI7Er6aUiH9X5q+qEhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXJ8rsp7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso3326848a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746788916; x=1747393716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVJ5KPukV9Q1VAaqSrLFayG/AnBtBGZbETwlFU4vC0M=;
        b=iXJ8rsp70vj2UyxbWCoosVVxgSMnkUr6/emk4hJ8ALkyGy5alioqWjxivOMlWB8fxj
         RBH/RKtKa8acVoEdjl23mo9pyyopzikYJKCqL/JOXDor6eEb/6j0ePzsD7Q5u/DDKe0l
         rqrPuYUq1OeZDz0DlHnfRjvATImPTa0fIId0yRGEZPbIeNpnSMSfQh6cr4bzNRwOvziO
         5fFum1yl40qIDjg3q/OiVyqYxQsis4STjlF7aLiURdddv1y9zHjIx+sKLd00XjGnnBWa
         v8Kjmvl0CcijUAj1G63AGj/2D2qizUJ/Jxmu7ukF2nbTgqC6fhj5wYnktY2g5ZS+JxeJ
         3G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788916; x=1747393716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVJ5KPukV9Q1VAaqSrLFayG/AnBtBGZbETwlFU4vC0M=;
        b=I5U/H2OMdsk5uzaFv8+v6YOWRCGJXByokqZ0MSyGR3DbGoWOFEbi3sRGAr1XS2NsYx
         is4z8Y5XC3vGgiGyeOvicTXOuRV3Z2gzh/Dawhga+c3G553o9ufJPnpkhtAUY0X0xi9Z
         eWZXUC6TJ8IDCnv3oSijVSvbPQLwkFayv6LD2l/qXiNlEHGECGEmDnyBKgIHZ1xcHD8+
         DiWpnjj3MaJn+9SN3YCyyZjAQJwEw24s+8Ruc6HoVJpY6N3dq+5fPxpOV2d2JMRD4cSp
         WJVF8z7MdACp+oeFUYjxNKmSn2AFy94UrIGB0ToeRPCRgJoXX3VNL057jwvYd8+XQB4S
         i1RA==
X-Forwarded-Encrypted: i=1; AJvYcCUqVrrHuxAN4F4kyt6OmOiosGCgr8IPXPxbrS7tboL5uZiDCHX1Ssgu5aK2wckoeHpK8SWRogfzlxQVygdd@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXmCgfdMFKR1dcZ2cP1MrAQO4l0h07yAg8d1xtzEUUQy0ePuZ
	dphnf6QGQ/MTf1hL0UZ6BkKZuDzYSh6bMvst4DYKLFTw67FjE6zvYCfa3GvWdqvANH77mCpfClZ
	yiuZvAi178XAWGVAtU3zXF7Rtwsc=
X-Gm-Gg: ASbGncuGlOAgeFv6VApWPf7LYR6vzu9m7SJkKZtSkQ9VCHgdnUILgyyhaq1k3KR/1e1
	0TeA7+XG7LTm3rm8p3k0+e5YAN8HerMVfZavmY3eQwVFocVcsre7Cd7vuhl5jwoCb1YYzgzfUkV
	ESZxKhn8euZqk+aP9sx226ig==
X-Google-Smtp-Source: AGHT+IGj6LxAT4yNG5RBRQeJcVPqKzakba0RxZtFpDNztEiSUuKYHAQI631h8NWFzjKDY1mptj5lJ7X00DWLNrqqDXc=
X-Received: by 2002:a17:907:7b04:b0:ad1:fab8:88ab with SMTP id
 a640c23a62f3a-ad219085c07mr291570866b.29.1746788915189; Fri, 09 May 2025
 04:08:35 -0700 (PDT)
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
Date: Fri, 9 May 2025 13:08:23 +0200
X-Gm-Features: ATxdqUGyUafDU4lWZUdGVCpbZG1f9hUiLrWSsRSjHV9Cd5s82Z98gsUzgaYCYmI
Message-ID: <CAOQ4uxjvJu_5r7hjcjv77eYXk+ijLn=S=Es4mE6EAvtztdBXHQ@mail.gmail.com>
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

Well, the question is, wrt this patch, do you require that listmount/statmo=
unt
syscall numbers be defined for all archs or is this acceptable to you:

+#ifndef __NR_statmount
+#if defined(__x86_64__) || defined(__arm64__)
+#define __NR_statmount 457
+#endif
+#endif
+
+#ifndef __NR_listmount
+#if defined(__x86_64__) || defined(__arm64__)
+#define __NR_listmount 458
+#endif
+#endif

Or the opt-out variant of
#if !defined(__alpha__) && !defined(_MIPS_SIM)

Please let me know what you prefer and I will post a new patch set version =
with
the fanotify test inside user ns.

Thanks,
Amir.

