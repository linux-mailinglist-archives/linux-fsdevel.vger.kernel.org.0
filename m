Return-Path: <linux-fsdevel+bounces-21996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF276910C7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456771F22365
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467021B9AD2;
	Thu, 20 Jun 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMS+NiOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C721B373B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900663; cv=none; b=bENrIzb2fJdlzRoV7NG6M2+claTpDXmkh1oiXwmFhXJTPsr4u88wnHsjVls2+IwpHlfX1PD4S+UEBACOTf1hM8tdsXZw+pWYgxyNg/joKeFhrYPq6iLDkq4GTXJMrdjWSv6uj014b0UmiM42jfwdlULJa7nFY/Rtcvi9mpIFeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900663; c=relaxed/simple;
	bh=G9HKFUhajGasiqamL48YDxw+DEmI8YzmL0Uiykg5fY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0YNEZtVwX9/Ar99+QXwcsmo0oIJpIL55auxIRn1l6olFhuYk5yaHmKbG3stfHAtd67jskfh7lgQkBFd1PSvDZwMgXJvPH91u64fX+2ifXF7rQxgH4WB590CVdHzAOs5LP5GI3D8jFG1YzmSWiIQEnriyKqpW9N+fouAZow90zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YMS+NiOH; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5bafe063f35so901881eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718900661; x=1719505461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt4TaLRiigym5jbcwq/kMWuY93Qd7TBOqg1NFwNoq6E=;
        b=YMS+NiOHPFLEdu4YzN1VwDcS8pERi2TrlGLwDogh55nknPwdYDZDWK5pSdVBPEyYhw
         +yCCZriIRvEWVLCfJJjSR5/C+jqMDrxJWNRc+4J/KRPMp4xJR2PeuMmdHrjuH0nb3TcI
         p0Aj801PeKi0IbIKmfJeXFTAHW8O/muMrcDGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900661; x=1719505461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt4TaLRiigym5jbcwq/kMWuY93Qd7TBOqg1NFwNoq6E=;
        b=iuqZ2UIzFG7BmyRHN0f92E569+b7Hxh5j6kIKPGk72QCzF/+yIIKh68R3WVuf1esPq
         dkkeMkPLq+rtKKpr0BDaAC/cNKrrGyKMGN9x2qegXS5j2G/CwTINaZEg2USyAlsuMhxx
         GZCtvMWC0wcmJn5gMFaY02uqg0jjOZdyMhr+qHU47cETeBaKfgs+ip2aF252VpIjjOPd
         vcB5C9dhqbqRS8QyHct11rVWtb5YfH5WINpGMlFH5JT+GOfum3sBwV9+/RJKE8NFF63S
         gFFEBbYdk7d7R1bHrOHDCjoa3NGIe0uPI87BfEtkqCxePk5hoT1f5i7wUjANW1E5y4Mt
         Vh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYO/Yqihmb+7QsXqr0/oSl4SIjS/R2l7HUNGCDs2Vb9+6mlOEuoU4NoKEiT/xbvwFc8t7rohayV76/NM4vBraIOl5hBhy3nvgSIk1Awg==
X-Gm-Message-State: AOJu0YxZapci/6AOIHv9Sdr2s0InWl6p37L0XLQozIYHNMnM6v9E7XwU
	x4PEE8Ox3b09q4xWoblcoQow+TTP7wrkpLNT7MYQb4hJ4veU1bgvFQovTqav37Pc9c/QUGSwwfq
	+fnzbCRr+IZL68ddTUTU6k2axnEC5ePVUudXP
X-Google-Smtp-Source: AGHT+IFBpvlmEuvbahBVElIajKUVoumeP4+3qEjJukkg86pbSwvP4+dt7eZAeaxRiL+fF3GyBU2EqugxSpNNxR2hW2s=
X-Received: by 2002:a05:6870:248a:b0:254:b781:2f5e with SMTP id
 586e51a60fabf-25972de7257mr3753010fac.17.1718900660925; Thu, 20 Jun 2024
 09:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
 <20240613133937.2352724-2-adrian.ratiu@collabora.com> <CABi2SkXY20M24fcUgejAMuJpNZqsLxd0g1PZ-8RcvzxO6NO6cA@mail.gmail.com>
 <202406191336.AC7F803123@keescook>
In-Reply-To: <202406191336.AC7F803123@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 20 Jun 2024 09:24:09 -0700
Message-ID: <CABi2SkWDwAU2ARyMVTeCqFeOXyQZn3hbkdWv-1OzzgG=MNoU8Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] proc: restrict /proc/pid/mem
To: Kees Cook <kees@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, 
	inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, 
	Guenter Roeck <groeck@chromium.org>, Doug Anderson <dianders@chromium.org>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Christian Brauner <brauner@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mike Frysinger <vapier@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 1:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jun 18, 2024 at 03:39:44PM -0700, Jeff Xu wrote:
> > Hi
> >
> > Thanks for the patch !
> >
> > On Thu, Jun 13, 2024 at 6:40=E2=80=AFAM Adrian Ratiu <adrian.ratiu@coll=
abora.com> wrote:
> > >
> > > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > > writing to /proc/pid/mem"). Famous last words from that patch:
> > > "no longer a security hazard". :)
> > >
> > > Afterwards exploits started causing drama like [1]. The exploits
> > > using /proc/*/mem can be rather sophisticated like [2] which
> > > installed an arbitrary payload from noexec storage into a running
> > > process then exec'd it, which itself could include an ELF loader
> > > to run arbitrary code off noexec storage.
> > >
> > > One of the well-known problems with /proc/*/mem writes is they
> > > ignore page permissions via FOLL_FORCE, as opposed to writes via
> > > process_vm_writev which respect page permissions. These writes can
> > > also be used to bypass mode bits.
> > >
> > > To harden against these types of attacks, distrbutions might want
> > > to restrict /proc/pid/mem accesses, either entirely or partially,
> > > for eg. to restrict FOLL_FORCE usage.
> > >
> > > Known valid use-cases which still need these accesses are:
> > >
> > > * Debuggers which also have ptrace permissions, so they can access
> > > memory anyway via PTRACE_POKEDATA & co. Some debuggers like GDB
> > > are designed to write /proc/pid/mem for basic functionality.
> > >
> > > * Container supervisors using the seccomp notifier to intercept
> > > syscalls and rewrite memory of calling processes by passing
> > > around /proc/pid/mem file descriptors.
> > >
> > > There might be more, that's why these params default to disabled.
> > >
> > > Regarding other mechanisms which can block these accesses:
> > >
> > > * seccomp filters can be used to block mmap/mprotect calls with W|X
> > > perms, but they often can't block open calls as daemons want to
> > > read/write their runtime state and seccomp filters cannot check
> > > file paths, so plain write calls can't be easily blocked.
> > >
> > > * Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > > can't run chmod once at boot to restrict it (and trying to react
> > > to every process and run chmod doesn't scale, and the kernel no
> > > longer allows chmod on any of these paths).
> > >
> > > * SELinux could be used with a rule to cover all /proc/*/mem files,
> > > but even then having multiple ways to deny an attack is useful in
> > > case one layer fails.
> > >
> > > Thus we introduce four kernel parameters to restrict /proc/*/mem
> > > access: open-read, open-write, write and foll_force. All these can
> > > be independently set to the following values:
> > >
> > > all     =3D> restrict all access unconditionally.
> > > ptracer =3D> restrict all access except for ptracer processes.
> > >
> > > If left unset, the existing behaviour is preserved, i.e. access
> > > is governed by basic file permissions.
> > >
> > > Examples which can be passed by bootloaders:
> > >
> > > proc_mem.restrict_foll_force=3Dall
> > > proc_mem.restrict_open_write=3Dptracer
> > > proc_mem.restrict_open_read=3Dptracer
> > > proc_mem.restrict_write=3Dall
> > >
> > > These knobs can also be enabled via Kconfig like for eg:
> > >
> > > CONFIG_PROC_MEM_RESTRICT_WRITE_PTRACE_DEFAULT=3Dy
> > > CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT=3Dy
> > >
> > > Each distribution needs to decide what restrictions to apply,
> > > depending on its use-cases. Embedded systems might want to do
> > > more, while general-purpouse distros might want a more relaxed
> > > policy, because for e.g. foll_force=3Dall and write=3Dall both break
> > > break GDB, so it might be a bit excessive.
> > >
> > > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> > >
> > It is noteworthy that ChromeOS has benefited from blocking
> > /proc/pid/mem write since 2017 [1], owing to the patch implemented by
> > Mike Frysinger.
> >
> > It is great that upstream can consider this patch, ChromeOS will use
> > the solution once it is accepted.
> >
> > > Link: https://lwn.net/Articles/476947/ [1]
> > > Link: https://issues.chromium.org/issues/40089045 [2]
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jeff Xu <jeffxu@google.com>
> > > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> >
> > Reviewed-by: Jeff Xu <jeffxu@chromium.org>
> > Tested-by: Jeff Xu <jeffxu@chromium.org>
> > [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/k=
ernel/+/764773
>
> Thanks for the testing! What settings did you use? I think Chrome OS was
> effectively doing this?
>
> PROC_MEM_RESTRICT_OPEN_READ_OFF=3Dy
> CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_ALL=3Dy
> CONFIG_PROC_MEM_RESTRICT_WRITE_ALL=3Dy
> CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_ALL=3Dy
>
> Though I don't see the FOLL_FORCE changes in the linked Chrome OS patch,
> but I suspect it's unreachable with
> CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_ALL=3Dy.
>
I use CONFIG_PROC_MEM_RESTRICT_WRITE_ALL=3Dy and
did manual test writing to /proc/pid/mem using code similar to [1]

The __mem_rw_block_writes check is placed ahead of
__mem_rw_get_foll_force_flag, so it doesn't need
CONFIG_PROC_MEM_RESTRICT_FOLL_FORCE_DEFAULT. It might be nice to call
this out in kernel-parameters.txt.

I didn't restrict_open_read and restrict_open_write, ChromeOS doesn't
use those two.

-Jeff

[1] https://offlinemark.com/an-obscure-quirk-of-proc/

> -Kees

>
> --
> Kees Cook

