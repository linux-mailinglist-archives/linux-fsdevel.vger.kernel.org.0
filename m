Return-Path: <linux-fsdevel+bounces-9499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5E841D37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37CF28C02E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA355E6B;
	Tue, 30 Jan 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2VEpfLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3355E51
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602149; cv=none; b=GWYQZBQNjKeeT076U12W4rQRajAiRLf6AhCF2X8K4WAp1gtWqcrsFRLc9aV1me7SB0RF0//zPSrm/jKcW1pcIPgJ8DLzxjb9aUg7mWpSPgS/lIh7jr3cfM0r14YivBj40sXu1bqEaU87zmWNpqaicGNJlWaXsGCdYZPoOKdLQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602149; c=relaxed/simple;
	bh=xOIvpSWLSG5KH2twc95uP/h2F7rGQT5gWD38/lqzyYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0oTCNE54rb9teDL8WMOp6x6b38OmZe5FlTGH/F/ZW1Tex4ksPcvF0ym6NAJAhze1TtslM1EBrmtuxtGGm7I9d/we18H1JaK/Sa/H4hilv8GWaG90gCrJh8fe9ryWm4FJ/FyGFgObXqYAVMQTYBto/WySNVjFhdQJOz2P9NaGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2VEpfLL; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6933a46efso1286269276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 00:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706602147; x=1707206947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/1tzRUd9tSzYjual31QCvHFlQLKbsMDHRClyGjVUo0=;
        b=i2VEpfLLBtot7rq/H/8ZVBacvQiaH3PKQpSfbwetfXGbRlEK+yoDK6VoKL9Bg2ZrZK
         m9MLMfjpRHLQfWOBraZJsjp+XjDuMrqXKiE9RlFVFF1AgruwAr2HvIj/CkCwt8RnhLe7
         BvolOAWkiMZwZ8DUl030s2ELqMqpCXK0nPOUF3GdVPKbULskqR9o56i0+Y98MdHmaeG+
         gvGHAKsXVQfqSLSzCKG17YICkLsjY3jG7YTeNYU9aN/QROHG7Qv5ydYT0xLJ9bAuDv92
         Tj1xB7kZpAyWSN7lpz/anTRlL0P1WXl87u2m9sWMN+5+EQ0Sc7/0OqXzZi+1wnX9JEHl
         QzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602147; x=1707206947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/1tzRUd9tSzYjual31QCvHFlQLKbsMDHRClyGjVUo0=;
        b=AqWYqg3G7b5KZunNtySZamz7m/yGRqNMOwUqdBtIfzc6KfqyNd2Deh6yxSzDIN/96r
         vwYJ7rTNa29cZT8sQM+oFj39o2q8LrdJs2bfNy4eXGwpyhczyKzlRXddn7bIzAhufzho
         apyhyKCh20MYXkNL1WUbysx+vboYpciRL6PNwul+cznkzZNDujMMeCmpcGnvqgquU8bh
         F5+PyQxzqKTqOpxNtrSqBXGGQPdtzrRiiOsAI9pT+sJ3xC75tXINHwCj1I0NJLGIDKB4
         eoohrAu7/tLfDhrkeUfBijb2fXmQpxk/ZQv7PB4Zosk/+e88bSrvaKXB7LxaTyo5jShL
         yk5A==
X-Gm-Message-State: AOJu0YxBeSzLJzVdVtiXA1ydqAdZc1UlbHDUuvTbjRqiwD4U5Ps1x27i
	KmGbKOZZwETlCr5mIA7nNFFdQVx+aQMSRiLDtvcPXVZbZ2HGhRBz+yXS8pDPsHZhi4dVWcc29KP
	pamH4avdLKm1WsyjGAzKk1eAs1PQ=
X-Google-Smtp-Source: AGHT+IGjAsSExfmBhciFxYbNJA5K0QPCesj7DwMIbSOs3YaM0S3xbey1ZPrYEWYjp1EhAnhsDULpgHbFWPl8RXgVARA=
X-Received: by 2002:a25:9b41:0:b0:dc3:6990:99eb with SMTP id
 u1-20020a259b41000000b00dc3699099ebmr4171652ybo.55.1706602146892; Tue, 30 Jan
 2024 00:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1fb83b2a-38cf-4b70-8c9e-ac1c77db7080@spawn.link>
 <CAOQ4uxgoJkotsP6MVuPmO91VSG3kKWdUqXAtp37rxc0ehOSfEw@mail.gmail.com>
 <ZbbGLKeZ90fHYnRs@dread.disaster.area> <CAOQ4uxiKLYHE6KfjaZmidN1Rf3zzq8aV6WkvDB9esKo08EQuBw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiKLYHE6KfjaZmidN1Rf3zzq8aV6WkvDB9esKo08EQuBw@mail.gmail.com>
From: Shachar Sharon <synarete@gmail.com>
Date: Tue, 30 Jan 2024 10:08:55 +0200
Message-ID: <CAL_uBtdcc-ajzfGrrx04JG=G71-W-43awn2NdeMUMtrJFHGiyA@mail.gmail.com>
Subject: Re: [fuse-devel] FICLONE / FICLONERANGE support
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Antonio SJ Musumeci <trapexit@spawn.link>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:54=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sun, Jan 28, 2024 at 11:25=E2=80=AFPM Dave Chinner <david@fromorbit.co=
m> wrote:
> >
> > On Sun, Jan 28, 2024 at 12:07:22PM +0200, Amir Goldstein wrote:
> > > On Sun, Jan 28, 2024 at 2:31=E2=80=AFAM Antonio SJ Musumeci <trapexit=
@spawn.link> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Has anyone investigated adding support for FICLONE and FICLONERANGE=
? I'm
> > > > not seeing any references to either on the mailinglist. I've got a
> > > > passthrough filesystem and with more users taking advantage of btrf=
s and
> > > > xfs w/ reflinks there has been some demand for the ability to suppo=
rt it.
> > > >
> > >
> > > [CC fsdevel because my answer's scope is wider than just FUSE]
> > >
> > > FWIW, the kernel implementation of copy_file_range() calls remap_file=
_range()
> > > (a.k.a. clone_file_range()) for both xfs and btrfs, so if your users =
control the
> > > application they are using, calling copy_file_range() will propagate =
via your
> > > fuse filesystem correctly to underlying xfs/btrfs and will effectivel=
y result in
> > > clone_file_range().
> > >
> > > Thus using tools like cp --reflink, on your passthrough filesystem sh=
ould yield
> > > the expected result.
>
> Sorry, cp --reflink indeed uses clone
>
> > >
> > > For a more practical example see:
> > > https://bugzilla.samba.org/show_bug.cgi?id=3D12033
> > > Since Samba 4.1, server-side-copy is implemented as copy_file_range()
> > >
> > > API-wise, there are two main differences between copy_file_range() an=
d
> > > FICLONERANGE:
> > > 1. copy_file_range() can result in partial copy
> > > 2. copy_file_range() can results in more used disk space
> > >
> > > Other API differences are minor, but the fact that copy_file_range()
> > > is a syscall with a @flags argument makes it a candidate for being
> > > a super-set of both functionalities.
> > >
> > > The question is, for your users, are you actually looking for
> > > clone_file_range() support? or is best-effort copy_file_range() with
> > > clone_file_range() fallback enough?
> > >
> > > If your users are looking for the atomic clone_file_range() behavior,
> > > then a single flag in fuse_copy_file_range_in::flags is enough to
> > > indicate to the server that the "atomic clone" behavior is wanted.
> > >
> > > Note that the @flags argument to copy_file_range() syscall does not
> > > support any flags at all at the moment.
> > >
> > > The only flag defined in the kernel COPY_FILE_SPLICE is for
> > > internal use only.
> > >
> > > We can define a flag COPY_FILE_CLONE to use either only
> > > internally in kernel and in FUSE protocol or even also in
> > > copy_file_range() syscall.
> >
> > I don't care how fuse implements ->remap_file_range(), but no change
> > to syscall behaviour, please.
> >
>
> ok.
>
> > copy_file_range() is supposed to select the best available method
> > for copying the data based on kernel side technology awareness that
> > the application knows nothing about (e.g. clone, server-side copy,
> > block device copy offload, etc). The API is technology agnostic and
> > largely future proof because of this; adding flags to say "use this
> > specific technology to copy data or fail" is the exact opposite of
> > how we want copy_file_range() to work.
> >
> > i.e. if you want a specific type of "copy" to be done (i.e. clone
> > rather than data copy) then call FICLONE or copy the data yourself
> > to do exactly what you need. If you just want it done fast as
> > possible and don't care about implementation (99% of cases), then
> > just call copy_file_range().
> >
>
> Technically, a flag COPY_FILE_ATOMIC would be a requirement
> not an implementation detail, but this requirement could currently be
> fulfilled only by fs that implement remap_file_range(), but nevermind,
> I won't be trying to push a syscall API change myself.
>
> > > Sure, we can also add a new FUSE protocol command for
> > > FUSE_CLONE_FILE_RANGE, but I don't think that is
> > > necessary.
> > > It is certainly not necessary if there is agreement to extend the
> > > copy_file_range() syscall to support COPY_FILE_CLONE flag.
> >
> > We have already have FICLONE/FICLONERANGE for this operation. Fuse
> > just needs to implement ->remap_file_range() server stubs, and then
> > the back end driver  can choose to implement it if it's storage
> > mechanisms support such functionality.
>
> For Antonio's request to support FICLONERANGE with FUSE,
> that would be enough using a new protocol command.
>
> > Then it will get used
> > automatically for copy_file_range() for those FUSE drivers, the rest
> > will just copy the data in the kernel using splice as they currently
> > do...
>
> This is not the current behavior of FUSE as far as I can tell.
> The reason is that vfs_copy_file_range() checks if fs implement
> ->copy_file_range(), if it does, it will not fallback to ->remap_file_ran=
ge()
> nor to splice. This is intentional - fs with ->copy_file_range() has full
> control including the decision to return whatever error code to userspace=
.
>
> The problem is that the FUSE kernel driver always implements
> ->copy_file_range(), regardless whether the FUSE server implements
> FUSE_COPY_FILE_RANGE. So for a FUSE server that does not
> implement FUSE_COPY_FILE_RANGE, fc->no_copy_file_range is
> true and copy_file_range() returns -EOPNOTSUPP.
>
> So either the fallback from FUSE_COPY_FILE_RANGE to
> FUSE_CLONE_FILE_RANGE will be done internally by FUSE,
> or clone/copy support will need to be advertised during FUSE_INIT
> and a different set of fuse_file_operations will need to be used
> accordingly, which seems overly complicated.
>
Note that FUSE_COPY_FILE_RANGE uses struct fuse_write_out to report
the number of bytes copied between files (uint32_t size), and therefore it =
can
not copy more than 2^32-1 bytes at each call. For example, a call to
cp --reflink
of 1T file yields multiple calls to copy_file_range() by userspace.

- Shachar.

> Thanks,
> Amir.
>

