Return-Path: <linux-fsdevel+bounces-27345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E252B960752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6115FB2288C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E219D8A9;
	Tue, 27 Aug 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI4q0aUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118F199221;
	Tue, 27 Aug 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754098; cv=none; b=GV8f3mF2fGeMJhSIV2+MuI/iMI/mxK0++Gui1vAsJZOKyth2nCQreE4uMf+ms6kGam/rYM5uD8wIauwzNMX4tuBwLzH3kP68xMxMG/moVWAJlJLYRJ6M3A6kIeIRaJbkOdVJO6M43nNCqls5xlWBSaopLdNPbcLz+Uhus+jUudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754098; c=relaxed/simple;
	bh=mEw+ShUENTiPQMiz8lwRv9s4CQ4W6wDbXGGDJc7MPhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8sQoZe057CnuaiMvI0S4OU0HPZq+o4ekU14rADwiAE8Zx9Odw3Q4hTOeDActjziQ4eLzjp/bk4gzfxPuFQnJqHdaSdhmkpC3ioScgw8pjpqhBosxuOSSv2Cm8dNT6otsHzOazR2GFRX4M1qcDT7q+CidwY1BOb6fQ1C8BmR2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI4q0aUu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a868b739cd9so639465666b.2;
        Tue, 27 Aug 2024 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724754095; x=1725358895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcMmj62/kYJueOAlkDuHnCxTT/XoX1mOuafHq0pRrEg=;
        b=kI4q0aUuQpSUgF+Na9CChKAb51NVwlg2GpdhR07MWVkRoWn87udTtb2xgd/2P5hTAE
         z/toYU4qnCaPw9ktgU0DtkHPovrzDoTlcbbPrOZ+J7tnr9/YvuS3q3d3NQahrN4jug9o
         ni+n/J1Asw8p16yVjnvRCwrP6NXnbgvSuWIdGeN/vyANetWGN6iCwnKwGMZsE5VN4fln
         ab2fPtuqjgOg95ywCRdNqtMnfNQqD20JzA5yKgkT5Upy7QGM6cPVWsdBO6BNeMj/ldBc
         sVXBG+a7J+vjfiaQIdnCzEOdtOw3w43QZE7Xf5KtuzKrD7unHGAIVpCVffWPE3wx4TWY
         5UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724754095; x=1725358895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcMmj62/kYJueOAlkDuHnCxTT/XoX1mOuafHq0pRrEg=;
        b=CL59nWE21i338W6KiPXjLS9TELjuoDHriAu1tDhHVtHhQJym0bfe/vO0DVYxi1skeL
         EtX50GGRCSWI1mTsqp+iL9sEEeksORfIncZnPUUjMr6TWOxFXBzuu2TvKLJEzVjEB6ky
         tr6FI7UVChY0fqZEXPCMvIbu0iX7N7sO55YmbYRIULV5zlY/rDVORi/EtVH87WFO8q5o
         k81vh9NhcVR2/WBo+8KL59e9J2Y+GQldj6zh2burtGJd3Cihudoc7wFRltsn64xywF/+
         GBoTqvjL6Ix7YzD4zrWTc11IEeWujLSRI+rcitiO1NmxGBuuNz6uMpfwWhIZtQOLHB64
         YL0A==
X-Forwarded-Encrypted: i=1; AJvYcCWj6gl7tqqSJQKKRfydazKEtsQMYnkAI1bLgad1WaUIXhBxcntVmb0A92TXV6fgmGHlfarafwjJsIRhSjrp@vger.kernel.org, AJvYcCXGHVW2YDFcsQ7VYPYfNOTu2J9JwJF/0Iy1ipzz3CU0KlPY3E+VQk+d+xMb0oVOPCS8dRNlfMagweOje10q@vger.kernel.org
X-Gm-Message-State: AOJu0YwEF8tFtxoS06nCV8lM1QXS0QiQGpClZresVnpbHJFglLW9tu9A
	TzXqx1BbYoxw3BST5KKIF+F5HLv5gRurApIeCWJCEKEW2fo3hAJdEtw0J+B+fPIFOb6TJOyiG3b
	5ZqBuScVDahvD80VaPappKHtkA8lLPCM4
X-Google-Smtp-Source: AGHT+IEYFFmfg4892xFFGab563qHMjgekirtqG7C+GqfCTkoLOe5Y/b8uJGXiczMNw3pUHUqCdLNOAqLatC4+DhCoEQ=
X-Received: by 2002:a17:907:6d0a:b0:a86:7c5d:1856 with SMTP id
 a640c23a62f3a-a86e3be5c89mr181853866b.46.1724754094909; Tue, 27 Aug 2024
 03:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083310.3865-1-mjguzik@gmail.com> <20240827100045.m3mpko3tvmmjkmvm@quack3>
In-Reply-To: <20240827100045.m3mpko3tvmmjkmvm@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 27 Aug 2024 12:21:21 +0200
Message-ID: <CAGudoHEHzywyxVAdtB_Mg4Wh=g=QmNY=ODGmNPEWmmhc-ugwEw@mail.gmail.com>
Subject: Re: [PATCH] vfs: elide smp_mb in iversion handling in the common case
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 15-08-24 10:33:10, Mateusz Guzik wrote:
> > According to bpftrace on these routines most calls result in cmpxchg,
> > which already provides the same guarantee.
> >
> > In inode_maybe_inc_iversion elision is possible because even if the
> > wrong value was read due to now missing smp_mb fence, the issue is goin=
g
> > to correct itself after cmpxchg. If it appears cmpxchg wont be issued,
> > the fence + reload are there bringing back previous behavior.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > chances are this entire barrier guarantee is of no significance, but i'=
m
> > not signing up to review it
>
> Jeff might have a ready answer here - added to CC. I think the barrier is
> needed in principle so that you can guarantee that after a data change yo=
u
> will be able to observe an i_version change.
>

That is the description, I am saying it is unclear if anyone needs it
and that I am not interested in spending time on finding out.

> > I verified the force flag is not *always* set (but it is set in the mos=
t
> > common case).
>
> Well, I'm not convinced the more complicated code is really worth it.
> 'force' will be set when we update timestamps which happens once per tick
> (usually 1-4 ms). So that is common case on lightly / moderately loaded
> system. On heavily write(2)-loaded system, 'force' should be mostly false
> and unless you also heavily stat(2) the modified files, the common path i=
s
> exactly the "if (!force && !(cur & I_VERSION_QUERIED))" branch. So saving
> one smp_mb() on moderately loaded system per couple of ms (per inode)
> doesn't seem like a noticeable win...
>

inode_maybe_inc_iversion is used a lot and most commonly *with* the force f=
lag.

You can try it out yourself: bpftrace -e
'kprobe:inode_maybe_inc_iversion { @[kstack(), arg1] =3D count(); }'

and run your favourite fs-using workload, for example this is a top
backtrace form few seconds of building the kernel:

@[
    inode_maybe_inc_iversion+5
    inode_update_timestamps+238
    generic_update_time+19
    file_update_time+125
    shmem_file_write_iter+118
    vfs_write+599
    ksys_write+103
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
, 1]: 1670

the '1' at the end indicates 'force' flag set to 1.

This also shows up on unlink et al.

The context here is that vfs is dog slow single-threaded in part due
to spurious barriers sneaked in all over the place, here is another
example:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dvfs=
.misc&id=3D30eb7cc03875b508ce6683c8b3cf6e88442a2f87

--=20
Mateusz Guzik <mjguzik gmail.com>

