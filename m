Return-Path: <linux-fsdevel+bounces-18743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90288BBE47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 23:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1951F21327
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B085274;
	Sat,  4 May 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHDbKHyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356584FAF;
	Sat,  4 May 2024 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859454; cv=none; b=knOLB3hLtjC/qF+t82FMLeLpP5G+ie09VZ1KxL0t9BNXCIdVmw/2rcKlgZpZkqkLOqJSioYM4nVYq0lbjNfRc9oLRwzRYLA1F7697D4rFZ16lVL9VRvs2LBBaQ7bbhzvpOrlYa0OVVbTA6UF31SbnSeJmqltiE5vmNfsHGC6YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859454; c=relaxed/simple;
	bh=a0aOHIvkMgWuJJUNgVDuyMPr6yqGUOevb/iI/fvcanw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOnlnErgnQd4AutQneI+uvU/eH4TPB4IKL8qBaxMgGpcO2nS2zCmSTBnng8MDgg88luKN6xAJneCZFq148p4FhGAnVieZSZzOkZiOv1Xd9t75nvLlBURTCjL1nWClnvRXHzBu9ryumno8wt+h1N90G2bQn/W6Y09Kf396IV27ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHDbKHyj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso636013b3a.3;
        Sat, 04 May 2024 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714859453; x=1715464253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRbD5K4zZTdGsoYmonQUDEJ6IC05hDKgzajoRSsce9g=;
        b=EHDbKHyjdS9kRXwB787evdo2S5i6i7v58H8yBkeKIV1VghlYJLPjKYu+qlOvqSTvg2
         pEzdtCpKEnKDiCZajdm9GadSqVWy4BmBmB4qQ+P3lexrUuxScNSP7QdNMbIj+CyeePh4
         mETGly5rFYXSXs5pVQca2CJd1u12SAEKJeFRaTsmkNZHuu9H57dGDNospIUPBQqdP3JH
         4HG+wMSgLtHDGbIINJ91wyxETE9Sy1nOkazdPnN2OQgV0zIpITPqVGucNxc+mt38Y3vc
         k1Tl/nLjUHNs0WNRViZlQ3hS2KiZzw1NdGXTZGH6TT/tXxgDQ51I+dA0j52SIMNjP/yB
         9AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714859453; x=1715464253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRbD5K4zZTdGsoYmonQUDEJ6IC05hDKgzajoRSsce9g=;
        b=ScyoSaaWkPzy1sYVOEup4/6CPOkzRfhphqLahO7GnUxnd/A5nJb9kFs11kt/HHiuId
         TK4nl+HoZDyQRT4qkMDs364vX+fi0E3eBcVaKKXdqA1gZ/9ioWjiwr1cRSb15WXfJsV4
         0mXqLfTaR+OYt/9fidY8ZGsLaqE1MOOVJGZJqjTwJR7fmxuFgpFaRy138HOFANpTksbu
         j6tfggI1uY1qqCpZyifus1qED+6mHb6RupzkZeQBjUdlaJEjmHnOiWYqew/xwPJuXmeq
         xb5ljayONH0z8lD/vR+ACYYSUjirZpcyotNkWp7IFvg/edTeqovKt6w5C1UPnmAM1cf0
         A13A==
X-Forwarded-Encrypted: i=1; AJvYcCX0BIimcWZCAOm1qJAwLXFGH8wbqiCp7fAcFXpYTwcX+HnLKF8ej6fMZrZ0ATK4frkgytXzVoQJ93n7HW5FVuKLcvvXRDJk1RpEOg520e2qbsG3hPU1tb9LqJ6bBPAFIODc8YttxIFBF0Jr0Tx5OhhIetSlBlgmyq7mDppwxsinKw==
X-Gm-Message-State: AOJu0Yyjhz/retU6vPLeaFqku/+r9o9nKoiCmdKYp8VqEWQl2gl/11PI
	t17qR1iQSdH7ljZj9JBtrcRJyW3ss8F26dKVwI9/mQR3mVYZj8+txlpsf6aTzvZS5AK51z3I3c9
	eB9ks5fFip5Ig5AOMCkm+5qGujkU=
X-Google-Smtp-Source: AGHT+IFJG7mKnewTXcss2FhclEbK/u9dvFW2JvKWtk8LfLNNgKCzHSL2ouZ3o44Ga0XaN3kS1y+lKBfVqXyjDamvMVs=
X-Received: by 2002:a05:6a21:33a6:b0:1ad:7e4d:2ea6 with SMTP id
 yy38-20020a056a2133a600b001ad7e4d2ea6mr6833735pzb.20.1714859452765; Sat, 04
 May 2024 14:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504-rasch-gekrochen-3d577084beda@brauner>
In-Reply-To: <20240504-rasch-gekrochen-3d577084beda@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 4 May 2024 14:50:40 -0700
Message-ID: <CAEf4Bzb39_nuiB2DGLG3=2Vo+_qj9Ni2ooCpQyRx8BjZyYmOBg@mail.gmail.com>
Subject: Re: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 4:24=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, May 03, 2024 at 05:30:01PM -0700, Andrii Nakryiko wrote:
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file to al=
low
> > applications to query VMA information more efficiently than through tex=
tual
> > processing of /proc/<pid>/maps contents. See patch #2 for the context,
> > justification, and nuances of the API design.
> >
> > Patch #1 is a refactoring to keep VMA name logic determination in one p=
lace.
> > Patch #2 is the meat of kernel-side API.
> > Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
> > Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid>/=
maps to
> > optionally use this new ioctl()-based API, if supported.
> > Patch #5 implements a simple C tool to demonstrate intended efficient u=
se (for
> > both textual and binary interfaces) and allows benchmarking them. Patch=
 itself
> > also has performance numbers of a test based on one of the medium-sized
> > internal applications taken from production.
>
> I don't have anything against adding a binary interface for this. But
> it's somewhat odd to do ioctls based on /proc files. I wonder if there
> isn't a more suitable place for this. prctl()? New vmstat() system call
> using a pidfd/pid as reference? ioctl() on fs/pidfs.c?

I did ioctl() on /proc/<pid>/maps because that's the file that's used
for the same use cases and it can be opened from other processes for
any target PID. I'm open to any suggestions that make more sense, this
v1 is mostly to start the conversation.

prctl() probably doesn't make sense, as according to man page:

       prctl() manipulates various aspects of the behavior of the
       calling thread or process.

And this facility is most often used from another (profiler or
symbolizer) process.

New syscall feels like an overkill, but if that's the only way, so be it.

I do like the idea of ioctl() on top of pidfd (I assume that's what
you mean by "fs/pidfs.c", right)? This seems most promising. One
question/nuance. If I understand correctly, pidfd won't hold
task_struct (and its mm_struct) reference, right? So if the process
exits, even if I have pidfd, that task is gone and so we won't be able
to query it. Is that right?

If yes, then it's still workable in a lot of situations, but it would
be nice to have an ability to query VMAs (at least for binary's own
text segments) even if the process exits. This is the case for
short-lived processes that profilers capture some stack traces from,
but by the time these stack traces are processed they are gone.

This might be a stupid idea and question, but what if ioctl() on pidfd
itself would create another FD that would represent mm_struct of that
process, and then we have ioctl() on *that* soft-of-mm-struct-fd to
query VMA. Would that work at all? This approach would allow
long-running profiler application to open pidfd and this other "mm fd"
once, cache it, and then just query it. Meanwhile we can epoll() pidfd
itself to know when the process exits so that these mm_structs are not
referenced for longer than necessary.

Is this pushing too far or you think that would work and be acceptable?

But in any case, I think ioctl() on top of pidfd makes total sense for
this, thanks.

