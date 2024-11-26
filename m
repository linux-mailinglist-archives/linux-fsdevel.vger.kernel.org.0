Return-Path: <linux-fsdevel+bounces-35943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B057E9D9F39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF8616516A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792D1DFDBF;
	Tue, 26 Nov 2024 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+dGqiBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767F1CBE9D;
	Tue, 26 Nov 2024 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660446; cv=none; b=tNA3F8iXUMCS6Ic4e5VBJ1Dj3gfu20sloGHYvdK0WOe/Yjx+HYmVW1R8Q0XZJH9s6GLN1ofsxxgXDyzJBpVx16vQO6Z3BfHlUc4zF+2dHOAiM8sSRVe4P/bN5XHuOSlGULuBJt70wc50QnFQYwmuU0e96d/3A7ozrFsErZZ/yok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660446; c=relaxed/simple;
	bh=4vrbf3mKf+jSzEqVixBjqytq08FEluiMcVcJeXf93+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwZOhDfqtNTV/wflaBeWzvNX7roevtRmul0FXjbkRhV/Y1VO/CPUZRndi18TigzOhpqtPRNGEeYnwdtzxCdftcw8eMYgU4pZvrDBA/RgiI0PeoU9IFhwpqkXEyzpk76roTW+UIhazIaq3s0sn1kovPjmRgbMU2CC07gOi4TKB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+dGqiBS; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-84194e90c0fso123116939f.2;
        Tue, 26 Nov 2024 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732660444; x=1733265244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vrbf3mKf+jSzEqVixBjqytq08FEluiMcVcJeXf93+8=;
        b=D+dGqiBSEFePukhT5RaWzIgRT8o5/VgaMFzLgevJTwRXsimCm6abaWhwzfbfK+6mIZ
         QwJss65RHgap6hWcXfvZ2pz1+jVyMOK2XAzNvQ9o1fWsRq72KYQBgu/eWBeSO8YU/qNH
         B7sCFUyYiMMBRgJJtQ8vmHxT73tfURmYvDJyITg7kbYaWdQW07OwJ2WMUa8GCgfm/Ruj
         TIdZQIxqTC/uuH0EqD1TWophSOC/aHDCKT53WwKcLMp5AdNdXe3uXZB8TOctgBWhOCNh
         HsYySkj1HXiFoLrZySaAGMEjUVdiagzLp9UpEy4lHmd+H7TyBL9QgUsZM5v0Zhsom/ey
         3Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660444; x=1733265244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vrbf3mKf+jSzEqVixBjqytq08FEluiMcVcJeXf93+8=;
        b=R9szL1+YGBIoCgiJ/lxXqoM1YPOacWeYOtuBnFZlOGC/IXrrlyXNXKQsqO5BNn0A6m
         z1f8KtzRA+U1+ZdNdz8Oo4FE/bIZOtkoXGWljTZH6TqEv1cPIE24I+W8NRZsHJnwbM3z
         GSMN8B3py/mLsAi8EWdJHBOqxfk/ocMtSAWbWO0HnIlDhYPAmm/6l4sHqtH4/NB2uBLr
         EPFGPfR8i4629TjhI5rNqVuHKyder4bnszLZXoGayJb5VSDzJ+m7RspqM8cjMMEXLZVt
         ZBO4pqSvwv/i0KWG7sqB4M7UBG/8xjxBvJ01RgT18458LHrpQthejssPex9SGJfNLQGZ
         FpFg==
X-Forwarded-Encrypted: i=1; AJvYcCUvJTIwyAfuivX2kdDdpah/Kxl7jGDdL8bnp5eevLtsZpqgGhHgOqAt/Vc48XABowFn9xowasGaqH4W5/tI@vger.kernel.org, AJvYcCXK68E93Ev/BwLkhzzcWNdQbABfTfR/STxs6M3nEgsl8MEI4RLtzGFS4cQ5EyUrPfF+aP9V7igZEYpk3hCn@vger.kernel.org
X-Gm-Message-State: AOJu0YxOm8DW/W8h+I9MvZ0exT00V/c95/FElx2oUqsbjtTggetZPkoM
	Pr2BhoPuDL3jeIZBOoT/7DU47LXzcX2luYpmji4i7g6PY+z47nApdIcft0jn3YlE85nD/SEBzLQ
	g9UYbrvGpSqVJer7OTLu0EZKc3SI=
X-Gm-Gg: ASbGnctmp1tttNVzL1Mq2VEVjqFqrLszxOLWEyU7WD/W9dA0Ep9W0uRSu+y0Tswngsh
	adiwuNMedPvCFmmeBvEnDvsEHGcMalYpQxg4EjrWRywK8VP35Ip55n5OSh+CSSMaDOg==
X-Google-Smtp-Source: AGHT+IE+KUQpYGQR7ThM04qKSHGTtBIabX470BMpqzPPr8fqZPNqxQz01x1yzva22I6zYbnxaT+nJXD+77U1WbkVJHo=
X-Received: by 2002:a05:6602:3416:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-843eceaecf4mr113347839f.2.1732660444317; Tue, 26 Nov 2024
 14:34:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
 <4a2bc207-76be-4715-8e12-7fc45a76a125@leemhuis.info>
In-Reply-To: <4a2bc207-76be-4715-8e12-7fc45a76a125@leemhuis.info>
From: Rui Ueyama <rui314@gmail.com>
Date: Wed, 27 Nov 2024 07:33:53 +0900
Message-ID: <CACKH++YYM2uCOrFwELeJZzHuTn5UozE-=7PS3DiVnsJfXg1SDw@mail.gmail.com>
Subject: Re: [REGRESSION] mold linker depends on ETXTBSY, but open(2) no
 longer returns it
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: brauner@kernel.org, regressions@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:02=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [adding a few CCs, dropping stable]
>
> On 28.10.24 12:15, Rui Ueyama wrote:
> > I'm the creator and the maintainer of the mold linker
> > (https://github.com/rui314/mold). Recently, we discovered that mold
> > started causing process crashes in certain situations due to a change
> > in the Linux kernel. Here are the details:
> >
> > - In general, overwriting an existing file is much faster than
> > creating an empty file and writing to it on Linux, so mold attempts to
> > reuse an existing executable file if it exists.
> >
> > - If a program is running, opening the executable file for writing
> > previously failed with ETXTBSY. If that happens, mold falls back to
> > creating a new file.
> >
> > - However, the Linux kernel recently changed the behavior so that
> > writing to an executable file is now always permitted
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D2a010c412853).
>
> FWIW, that is 2a010c41285345 ("fs: don't block i_writecount during
> exec") [v6.11-rc1] from Christian Brauner.
>
> > That caused mold to write to an executable file even if there's a
> > process running that file. Since changes to mmap'ed files are
> > immediately visible to other processes, any processes running that
> > file would almost certainly crash in a very mysterious way.
> > Identifying the cause of these random crashes took us a few days.
> >
> > Rejecting writes to an executable file that is currently running is a
> > well-known behavior, and Linux had operated that way for a very long
> > time. So, I don=E2=80=99t believe relying on this behavior was our mist=
ake;
> > rather, I see this as a regression in the Linux kernel.
> >
> > Here is a bug report to the mold linker:
> > https://github.com/rui314/mold/issues/1361
>
> Thx for the report. I might be missing something, but from here it looks
> like nothing happened. So please allow me to ask:
>
> What's the status? Did anyone look into this? Is this sill happening?

Ping? I think this is a fairly major kernel regression. We can't ask
all our mold linker users to upgrade their linker before upgrading
their kernel. Isn't "Never break userland" the kernel's policy? I
wonder why no action or even a discussion has taken place so far.

