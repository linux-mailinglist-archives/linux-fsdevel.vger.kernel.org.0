Return-Path: <linux-fsdevel+bounces-15025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EECC886149
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 20:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A401F21F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5C13443F;
	Thu, 21 Mar 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8sRqRSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF133997;
	Thu, 21 Mar 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050750; cv=none; b=jRglM07eaZg3X+ZaMhKDQJ2nqePQg25WXGLqLk73wu4W5sNJd8r0T7aY3hEyIOcDveMRWtX2DMtXyYO6p3T+OQ3ICqj+G3xwPMLT4Y5C9IZFpHmSxeZs+ckMKYpD+J+q7Ry945fd039dpLyq5UFNhLceVMLyN6HpnB1FpryMC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050750; c=relaxed/simple;
	bh=zHyKqEmeTxvw8dg11FT8bhX85OPIH4GvobQHVZQABxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAsXOCLCtTUT3I4dG++MNjgoVxU8P+EXaGnR3OVsS/N6gEIhuHl0Hdni9RsyAK+/X+gD3lqAnmNk3qSazMI4CJUDXv3mGZfRgqwiKdrOPEPDY+qyVkFTaaGLln3xMEsU0X2I5f0Gh5XlboDURYriBYQ9TiWQDNwUEjdf4TXJwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8sRqRSw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dde26f7e1dso10188705ad.1;
        Thu, 21 Mar 2024 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711050748; x=1711655548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g9NCGY01ymluNhJoggsG8hQO99YWuEg4encn9wbinI=;
        b=U8sRqRSwiCW9ESh0lgqQLbdwL+S4b4uOtERLJ+6rRt8mkp/r7Y0SEAveS1QSTs7FBN
         iWpYF18JM2I0WZjKzaBBACVt5yJw5OWNgNxe75NTcS2DR7WgvgpCPfvZaMsdySijf1Cx
         gp/bZGesZedbiW3j3fdXpADPh3ca23m+C+11WZfc/LWtlcPC0vRTACyEpSs5bEEr/rJm
         lA3YHZluXjArBL+IOAM5LeLjBPqh5mF4cEds3kFg5MuaAn16yz0ugWx/DACfgEm0owE0
         qn/dY8sq0CFhDq5oV5dcu6mXzxeMdLF7ZGVu4nJu8evChy7jfsQaDwp5BEj1o5zlskwW
         EncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711050748; x=1711655548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g9NCGY01ymluNhJoggsG8hQO99YWuEg4encn9wbinI=;
        b=Xi5k7GsZqee7T7UX9+lCcUbAxuuK5RkIl8BkLV+aNjiz4bgt5WX/BCZOHhi/jUNudN
         os6bo/zQFzrGiNHlcwqfNu9VHHiEAyXZXdlbpnnVA2UFoQi9GCQPmbyWRi5vMef7uzcI
         LM7GT52GXn41narLqiQSq1ndR1Z3prKb9A6j0AupwFKRX0sNRbSJJtPcT2uaJzKucRmd
         i9z/KVnJc9nb9n/feZGISRHD8P5QUMxKFukxws/MrVd5b0GrD/u0vUWIaeS8+0db63Ll
         Xr2z4Lnpa3u/jvOtDBT2IHzWmOggdWoQRGay8jSqCazFS2xdTRxNwpQZWzPWwo7uoP8A
         PXbg==
X-Forwarded-Encrypted: i=1; AJvYcCXEXNyC3YZ0dCHaYacMEGL2zdE4jtjjuKfNzexe268PouRj+L0TdswztoQryW36o2Sn9R/+vaNcxo4bCdgEJLgkXpmqFt1HP02XUIxKwskrgdSYnFHmg5IapITPt7a6POaxPmdzVA==
X-Gm-Message-State: AOJu0YwHCjWDQHVtl5Gi/EQi5FBRx2XcT9hLExr93YJzwo0mNx6R0t7C
	U8w8WJccBNTCNarFU6gIfX42ZvwhgHowR7cx8hH0SQZdSbxhoxArZSUGzQJSFwH4Gp4n0r5ZgyV
	WJjxANH2Ua2O72ugvpBv5R9z1a98=
X-Google-Smtp-Source: AGHT+IHeRGYnu8OY3eiPPYKq0YGvx2izwmmbVrGCsmBFaLYt0yE8OEZ9pzFlZGLmywWhWPikpexuKk1/hqI8uulgA4o=
X-Received: by 2002:a17:903:230f:b0:1dc:51ac:88f5 with SMTP id
 d15-20020a170903230f00b001dc51ac88f5mr434224plh.65.1711050747888; Thu, 21 Mar
 2024 12:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com> <202403211004.19F5EE27F@keescook>
In-Reply-To: <202403211004.19F5EE27F@keescook>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 21 Mar 2024 12:52:16 -0700
Message-ID: <CAMo8Bf+jbsnok=zy3gT2Z-F8=LCMVVFhAoiJ8sjwaEBSbbJXzw@mail.gmail.com>
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Rich Felker <dalias@libc.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:05=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Wed, Mar 20, 2024 at 11:26:07AM -0700, Max Filippov wrote:
> > In NUMMU kernel the value of linux_binprm::p is the offset inside the
> > temporary program arguments array maintained in separate pages in the
> > linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
> > thus must be adjusted when that array is copied to the user stack.
> > Without that adjustment the value passed by the NOMMU kernel to the ELF
> > program in the AT_EXECFN entry of the aux array doesn't make any sense
> > and it may break programs that try to access memory pointed to by that
> > entry.
> >
> > Adjust linux_binprm::exec before the successful return from the
> > transfer_args_to_stack().
>
> What's the best way to test this? (Is there a qemu setup I can use to
> see the before/after of AT_EXECFN?)

I put a readme with the steps to build such system here:
  http://jcmvbkbc.org/~dumb/tmp/202403211236/README
it uses a prebuilt rootfs image and a 6.8 kernel branch with two
patches on top of it: one adds a dts and a defconfig and the other
is this fix. The rootfs boots successfully with this fix, but panics
if this fix is removed.
The easiest way to actually see the AT_EXECFN is, I guess, to
do something like that:
---8<---
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index fefc642541cb..22d34272a570 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -659,6 +659,7 @@ static int create_elf_fdpic_tables(struct
linux_binprm *bprm,
       NEW_AUX_ENT(AT_EGID,    (elf_addr_t)
from_kgid_munged(cred->user_ns, cred->egid));
       NEW_AUX_ENT(AT_SECURE,  bprm->secureexec);
       NEW_AUX_ENT(AT_EXECFN,  bprm->exec);
+       pr_info("%s: AT_EXECFN =3D %#lx\n", __func__, bprm->exec);

#ifdef ARCH_DLINFO
       nr =3D 0;
---8<---

> How did you encounter the problem?

I'm doing xtensa FDPIC port of musl libc and this issue popped up when
I began testing it on qemu-system-xtensa with the real linux kernel.
Related post to the musl ML:
  https://www.openwall.com/lists/musl/2024/03/20/2

--
Thanks.
-- Max

