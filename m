Return-Path: <linux-fsdevel+bounces-35987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54D9DA8A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 14:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886E0161F3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B01FCF74;
	Wed, 27 Nov 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvIKN2P4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1D1FCD18;
	Wed, 27 Nov 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714807; cv=none; b=ZaoyB5rWfsMWDuPwD9R4fTwDdBSOgIv545g/xUeY2NNJuL8nspsEtKnNnPrIxhdmW1WPlvyxnGeaYmCqC9YoAttQHhGIi25yGL0vwy+OifiiRpBQP8FdPhoi4BbidfUDd3CCbEvAAeWFLqZx99z45VR+5jo/S/FL6lnOrHF2KWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714807; c=relaxed/simple;
	bh=XybhIwlptG3RWjD6dLrxMlzRYFTvMb5ZDn2ZOdLmhW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLgI1F/aS6u2YvqyXs7QZ8WP3Xhz+CfHlS18452GZqx2ooY8M/M3cfiGBZOAyiwm7p94POIS7nACdj7U9ZqYVNfrExWBTlB5yBZXcmoTjbwcC3Ecn8n/JKWUoNUMXhI/X0gKgVJnsgILD+nfqG1abv5LosWzxfzM7npOhIk4zhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvIKN2P4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-84198253281so119808539f.0;
        Wed, 27 Nov 2024 05:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732714804; x=1733319604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0OvxuddvI1D8zzGSyN9DJ1VP3rgYrJg8KBeyIV2RRc=;
        b=JvIKN2P4jbYhDX1TkkLNz9U0LvRqXQgOtTWBV3wRTy5+hPmHob8ws4DU8vzHIAfsJ7
         7ZBQM/j51qjgx0OrfYv2SifnmL/OQPb+dt2VcMkdXdUpaoXFE9GN62Tu2rpRhKPIU9OT
         DenaUt9dOJcUJiRKyC1hDjq2cs4HBhz0dSXqy5yGwKVypWTZYLpaXBZhwQ6VtvxvQeyg
         L04xzVoW5y+XJhZbE8ynAfQQHoJP0vJDnddxoQGiGDOvQSA4goKpvtm5ehdJqfFMR9Cl
         33U8x6Ej08qe9BJdnTkYIzCJhVCaJ3XWOKcHAqJmqtQrvG4EcH1fnbM4XQ+9pDept1a1
         y/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714804; x=1733319604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0OvxuddvI1D8zzGSyN9DJ1VP3rgYrJg8KBeyIV2RRc=;
        b=gSYeZFaZNqCCI6472ZHQb9C7LymbVRjAs+iCSLeKSz5ds0ZbIndQ6iwUxw/aLI7aOH
         9VtnI/syLxijXykRUoNDV721gs3z2kbk3KLm0k3M4ez3HeUZHhJBDWoTDoP5zABrJcuq
         n5QXgp6xghr4Z6dxiyGa1aHmU840Y1afntlpnlefRbJYENap1jvJR3D74AiUz3OnMc2q
         +3cIo6qni65lPe9ltl+oLQu7b6u98MOqBfABnwgUfPu2VJ+oNAeHz8gu4BnFHjsMgBE3
         19Zf3EDy5zErI4Dl3iEPM+V5ctzULLfhOqhat2+m9h9t89ztFlAnrjws7Lf9BWSRU204
         CKCw==
X-Forwarded-Encrypted: i=1; AJvYcCWTvRRSqULrjtf2+bLM91CLPQcXlTl7/ZkW0ZZ+fr9ZdXkSpPRmpuIfHpdzrh+Su505qPnmdLE08i4uApGK@vger.kernel.org, AJvYcCWkrxR/iGvLl3B/c0gLFCHUNpwe279QkiqRkuEXRiF+pwE6tPhpSyHoOJ+KlQJOcDFojB/fgKAg5FaH7bgy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17BcLr8/1iSic6fWlIhlyj+1sNcFhdFmdX/4Cnt3TnVwe4fSS
	a3fhvFETlAHf6pQVw5cqJY1ONIU6a5OjbdUk/2n26SRv8tyM9FfUEoBmW8GTt7+RgGCPK8eBb7u
	R/GoVRaReXI8joy4OLKpFdNTE/LA=
X-Gm-Gg: ASbGncutJl2+5588BY4rkPRMt9Bez2figLoWMzKkfUP+uUGfmXvrhtOejsSfHFuWhjv
	YIVcyZpIlKnj5JRImzDahodcX1n5KCZEj8a/tFfUoP/Dchs+CFgdkYR8H7DN0w9Hw
X-Google-Smtp-Source: AGHT+IFw+Hy3debmQQWfB5c82VSTFahHQVa4B5dF8Vi5vW9WtYDtqXgFvQqyvh8tCLVLPi7bEbWqP5yucfD+Cnpi3AM=
X-Received: by 2002:a05:6602:641b:b0:83b:2c8e:c4 with SMTP id
 ca18e2360f4ac-843ecf7adabmr385607039f.9.1732714804645; Wed, 27 Nov 2024
 05:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
 <4a2bc207-76be-4715-8e12-7fc45a76a125@leemhuis.info> <CACKH++YYM2uCOrFwELeJZzHuTn5UozE-=7PS3DiVnsJfXg1SDw@mail.gmail.com>
 <20241127-frisst-anekdote-3e6d724cb311@brauner>
In-Reply-To: <20241127-frisst-anekdote-3e6d724cb311@brauner>
From: Rui Ueyama <rui314@gmail.com>
Date: Wed, 27 Nov 2024 22:39:53 +0900
Message-ID: <CACKH++ZXsLOhtReCucvxkqUATcXNtuW3A=idjskOt+fdme35Jg@mail.gmail.com>
Subject: Re: [REGRESSION] mold linker depends on ETXTBSY, but open(2) no
 longer returns it
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 9:11=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Nov 27, 2024 at 07:33:53AM +0900, Rui Ueyama wrote:
> > On Mon, Nov 11, 2024 at 9:02=E2=80=AFPM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> > >
> > > [adding a few CCs, dropping stable]
> > >
> > > On 28.10.24 12:15, Rui Ueyama wrote:
> > > > I'm the creator and the maintainer of the mold linker
> > > > (https://github.com/rui314/mold). Recently, we discovered that mold
> > > > started causing process crashes in certain situations due to a chan=
ge
> > > > in the Linux kernel. Here are the details:
> > > >
> > > > - In general, overwriting an existing file is much faster than
> > > > creating an empty file and writing to it on Linux, so mold attempts=
 to
> > > > reuse an existing executable file if it exists.
> > > >
> > > > - If a program is running, opening the executable file for writing
> > > > previously failed with ETXTBSY. If that happens, mold falls back to
> > > > creating a new file.
> > > >
> > > > - However, the Linux kernel recently changed the behavior so that
> > > > writing to an executable file is now always permitted
> > > > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3D2a010c412853).
> > >
> > > FWIW, that is 2a010c41285345 ("fs: don't block i_writecount during
> > > exec") [v6.11-rc1] from Christian Brauner.
> > >
> > > > That caused mold to write to an executable file even if there's a
> > > > process running that file. Since changes to mmap'ed files are
> > > > immediately visible to other processes, any processes running that
> > > > file would almost certainly crash in a very mysterious way.
> > > > Identifying the cause of these random crashes took us a few days.
> > > >
> > > > Rejecting writes to an executable file that is currently running is=
 a
> > > > well-known behavior, and Linux had operated that way for a very lon=
g
> > > > time. So, I don=E2=80=99t believe relying on this behavior was our =
mistake;
> > > > rather, I see this as a regression in the Linux kernel.
> > > >
> > > > Here is a bug report to the mold linker:
> > > > https://github.com/rui314/mold/issues/1361
> > >
> > > Thx for the report. I might be missing something, but from here it lo=
oks
> > > like nothing happened. So please allow me to ask:
> > >
> > > What's the status? Did anyone look into this? Is this sill happening?
>
> Linus, it seems that the mold linker relies on the deny_write_access()
> mechanism for executables. The mold linker tries to open a file for
> writing and if ETXTBSY is returned mold falls back to creating a new
> file.
>
> There is now a fix in mold upstream in
> https://github.com/rui314/mold/commit/8e4f7b53832d8af4f48a633a8385cbc932d=
1944e
>
> However, mold upstream still insists on a revert (no judgement on my
> part in case that sentence is misinterpreted).

I don't have a strong opinion on whether returning ETXTBSY is
desirable or not. We can cooperate to make a smooth transition to the
new behavior of open(2). That being said, making an abrupt kernel
change that breaks userland in a very mysterious way is, in my
opinion, not acceptable. I'm not personally affected by this issue,
but I needed to speak for our users who may upgrade their kernels
before upgrading their linker.

> Note, that the revert will cause issues for the fanotify pre-content
> hook patch series in [1] which was the cause for the removal of the
> deny_write_access() protection for executables so that on page faults
> the contents of executables could be filled-in by userspace. This is
> useful when dealing with very large executables and is apparently used
> by Meta.
>
> [1]: https://lore.kernel.org/r/20241121112218.8249-1-jack@suse.cz
>
> While Amir tells me that they may have a way around this I expect this
> to be hacky.
>
> This will also trigger a revert/rework of the LTP testsuite which has
> adapted various tests to the deny_write_access() removal for
> executables.
>
> There's been some delay in responding to this after my initial comment
> on Github because I entered into a month of sickness. So I just got
> reminded of this issue now. In any case, here's a tag that you can pull
> if you agree with the revert.
>
> The following changes since commit 7eef7e306d3c40a0c5b9ff6adc9b273cc894db=
d5:
>
>   Merge tag 'for-6.13/dm-changes' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/device-mapper/linux-dm (2024-11-25 18:54:00 -0800)
>
> are available in the Git repository at:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.=
exec.deny_write_access.revert
>
> for you to fetch changes up to 3b832035387ff508fdcf0fba66701afc78f79e3d:
>
>   Revert "fs: don't block i_writecount during exec" (2024-11-27 12:51:30 =
+0100)
>
> ----------------------------------------------------------------
> vfs-6.13.exec.deny_write_access.revert
>
> ----------------------------------------------------------------
> Christian Brauner (1):
>       Revert "fs: don't block i_writecount during exec"
>
>  fs/binfmt_elf.c       |  2 ++
>  fs/binfmt_elf_fdpic.c |  5 ++++-
>  fs/binfmt_misc.c      |  7 +++++--
>  fs/exec.c             | 23 +++++++++++++++--------
>  kernel/fork.c         | 26 +++++++++++++++++++++++---
>  5 files changed, 49 insertions(+), 14 deletions(-)

