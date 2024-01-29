Return-Path: <linux-fsdevel+bounces-9379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D929A840786
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690921F21EF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6356F657C2;
	Mon, 29 Jan 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMPfxjU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5C657A7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536475; cv=none; b=oTIVRZCTUnViQUsknDwUGMa0O417x8CpcnrzZBcf+/sH6VY4PhqPWFQfcWQK9LkeQu5hlhQE8tiShxwLslsTyQAY/KZ+zdmGyGtH6rE48VYjriHEr7KOS31RRYAQ8bgpaLVk6biTQmBP6xmJ0DFLVgNUUk0Qwe2S82Vkuu3EYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536475; c=relaxed/simple;
	bh=sNEMcbR/X+veHUVho8W02uKranJD3jyNLlb5kfEmkys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVNWXSG3VJCJROIAdRlk2o86MdiSZx6uIiEC7/dZwbGXUz8w2w/vU4Sh1P5777uFvKCJnUr3XG05rj64bdnrRSCvrYuNFNJ9CeyXghazMspplkR50sGXRUMIrhzaLLxzd+QAFIWErevpv27DjMNcGxJ0Q202E/BDJfCRyvpfW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMPfxjU8; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c4fb9e7daso4186106d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 05:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706536473; x=1707141273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfZl/uQ+Md1x+YtMxrI8HA5Yq+CjGMp8M/RKsLRGBRo=;
        b=MMPfxjU8EiNg+PGFscKT6iQEHxqHoJyNr+v4/8UKas2gbgQu7nSnNRlhlET516MmOR
         BssoCfG/WD8yszuA1B3x2SysSUkSk6KeQIzC589brEZNK+Z1FzgdTLfq+mWyjLXoQ9Pl
         m3EI0qVaOugkYXpjYYu3Wyv/xMqn1j0s4ajofV7upubMY4Mk8O01CnDIRU3qkp1uHCI0
         4g9Enw/JuZK29W8zIGIWizhWMS26ANz5Q2yN6DyYZ3BDsHE0sh985JmVyGbFwFb1vU1z
         BHVC/i/ae3SIIhNgzlnfOleY4xJUaSs6jHUUYqnlcnNcvm/CjT/5DsmZ3yfB78fGBKQ3
         rQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536473; x=1707141273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfZl/uQ+Md1x+YtMxrI8HA5Yq+CjGMp8M/RKsLRGBRo=;
        b=V4vfns6RyV33jOswpBQHnLv+0neTH3glmTQmhcscYtxrkUgAiPBqopwZC39OVC+Ezk
         Ja2VOApXdvJmm6qcBIqh9F+BqO3mvV0c0MjYyfhQB9lVuTSoxImNtA4VO0C7EW0k7Ljr
         rdBXalwLxB5qRspB/l1An0hJWrVwfrbOW1aM7C8isw2cHiC5+XJpsT+LGGUVfqJy+4xL
         jL2g3IrYJyncUmu9RoIHDyHX3evEmYTwktTixKwirUOQcE3LTvXoY+c3ai8O7L2wIsw9
         tn+Ni8FLQ5GETUE4mp99pm8PCyAQk4MmMiZQnRYotRseemD2oA/CXeqanhs0elD76SsX
         OsKw==
X-Gm-Message-State: AOJu0YxSVfcr8939JYRMj03hXvSF6Fkvdd7EEIYo0QNvCkosQEHkqsXA
	MNOzXAKVeFQCWaDC/7rlNRxZpmxqbF2MvWkTOKEEonsz2sHfi/uq35nlf/aS6+RlxpUJ9qPsXpk
	57fosvqqURi3hwoTgqTDJjU9t7rE=
X-Google-Smtp-Source: AGHT+IEOqTqXHqL9wvNCvwhy9cxaobYBjVuxiDMV4cXeXl58Ydfb+CUwSPvhexJzrhVFsjlN16yDxc9oNvaOQdfHOr0=
X-Received: by 2002:ad4:510b:0:b0:68c:3c84:8d27 with SMTP id
 g11-20020ad4510b000000b0068c3c848d27mr6380315qvp.43.1706536472971; Mon, 29
 Jan 2024 05:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1fb83b2a-38cf-4b70-8c9e-ac1c77db7080@spawn.link>
 <CAOQ4uxgoJkotsP6MVuPmO91VSG3kKWdUqXAtp37rxc0ehOSfEw@mail.gmail.com> <ZbbGLKeZ90fHYnRs@dread.disaster.area>
In-Reply-To: <ZbbGLKeZ90fHYnRs@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jan 2024 15:54:21 +0200
Message-ID: <CAOQ4uxiKLYHE6KfjaZmidN1Rf3zzq8aV6WkvDB9esKo08EQuBw@mail.gmail.com>
Subject: Re: [fuse-devel] FICLONE / FICLONERANGE support
To: Dave Chinner <david@fromorbit.com>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, fuse-devel <fuse-devel@lists.sourceforge.net>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 11:25=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Sun, Jan 28, 2024 at 12:07:22PM +0200, Amir Goldstein wrote:
> > On Sun, Jan 28, 2024 at 2:31=E2=80=AFAM Antonio SJ Musumeci <trapexit@s=
pawn.link> wrote:
> > >
> > > Hello,
> > >
> > > Has anyone investigated adding support for FICLONE and FICLONERANGE? =
I'm
> > > not seeing any references to either on the mailinglist. I've got a
> > > passthrough filesystem and with more users taking advantage of btrfs =
and
> > > xfs w/ reflinks there has been some demand for the ability to support=
 it.
> > >
> >
> > [CC fsdevel because my answer's scope is wider than just FUSE]
> >
> > FWIW, the kernel implementation of copy_file_range() calls remap_file_r=
ange()
> > (a.k.a. clone_file_range()) for both xfs and btrfs, so if your users co=
ntrol the
> > application they are using, calling copy_file_range() will propagate vi=
a your
> > fuse filesystem correctly to underlying xfs/btrfs and will effectively =
result in
> > clone_file_range().
> >
> > Thus using tools like cp --reflink, on your passthrough filesystem shou=
ld yield
> > the expected result.

Sorry, cp --reflink indeed uses clone

> >
> > For a more practical example see:
> > https://bugzilla.samba.org/show_bug.cgi?id=3D12033
> > Since Samba 4.1, server-side-copy is implemented as copy_file_range()
> >
> > API-wise, there are two main differences between copy_file_range() and
> > FICLONERANGE:
> > 1. copy_file_range() can result in partial copy
> > 2. copy_file_range() can results in more used disk space
> >
> > Other API differences are minor, but the fact that copy_file_range()
> > is a syscall with a @flags argument makes it a candidate for being
> > a super-set of both functionalities.
> >
> > The question is, for your users, are you actually looking for
> > clone_file_range() support? or is best-effort copy_file_range() with
> > clone_file_range() fallback enough?
> >
> > If your users are looking for the atomic clone_file_range() behavior,
> > then a single flag in fuse_copy_file_range_in::flags is enough to
> > indicate to the server that the "atomic clone" behavior is wanted.
> >
> > Note that the @flags argument to copy_file_range() syscall does not
> > support any flags at all at the moment.
> >
> > The only flag defined in the kernel COPY_FILE_SPLICE is for
> > internal use only.
> >
> > We can define a flag COPY_FILE_CLONE to use either only
> > internally in kernel and in FUSE protocol or even also in
> > copy_file_range() syscall.
>
> I don't care how fuse implements ->remap_file_range(), but no change
> to syscall behaviour, please.
>

ok.

> copy_file_range() is supposed to select the best available method
> for copying the data based on kernel side technology awareness that
> the application knows nothing about (e.g. clone, server-side copy,
> block device copy offload, etc). The API is technology agnostic and
> largely future proof because of this; adding flags to say "use this
> specific technology to copy data or fail" is the exact opposite of
> how we want copy_file_range() to work.
>
> i.e. if you want a specific type of "copy" to be done (i.e. clone
> rather than data copy) then call FICLONE or copy the data yourself
> to do exactly what you need. If you just want it done fast as
> possible and don't care about implementation (99% of cases), then
> just call copy_file_range().
>

Technically, a flag COPY_FILE_ATOMIC would be a requirement
not an implementation detail, but this requirement could currently be
fulfilled only by fs that implement remap_file_range(), but nevermind,
I won't be trying to push a syscall API change myself.

> > Sure, we can also add a new FUSE protocol command for
> > FUSE_CLONE_FILE_RANGE, but I don't think that is
> > necessary.
> > It is certainly not necessary if there is agreement to extend the
> > copy_file_range() syscall to support COPY_FILE_CLONE flag.
>
> We have already have FICLONE/FICLONERANGE for this operation. Fuse
> just needs to implement ->remap_file_range() server stubs, and then
> the back end driver  can choose to implement it if it's storage
> mechanisms support such functionality.

For Antonio's request to support FICLONERANGE with FUSE,
that would be enough using a new protocol command.

> Then it will get used
> automatically for copy_file_range() for those FUSE drivers, the rest
> will just copy the data in the kernel using splice as they currently
> do...

This is not the current behavior of FUSE as far as I can tell.
The reason is that vfs_copy_file_range() checks if fs implement
->copy_file_range(), if it does, it will not fallback to ->remap_file_range=
()
nor to splice. This is intentional - fs with ->copy_file_range() has full
control including the decision to return whatever error code to userspace.

The problem is that the FUSE kernel driver always implements
->copy_file_range(), regardless whether the FUSE server implements
FUSE_COPY_FILE_RANGE. So for a FUSE server that does not
implement FUSE_COPY_FILE_RANGE, fc->no_copy_file_range is
true and copy_file_range() returns -EOPNOTSUPP.

So either the fallback from FUSE_COPY_FILE_RANGE to
FUSE_CLONE_FILE_RANGE will be done internally by FUSE,
or clone/copy support will need to be advertised during FUSE_INIT
and a different set of fuse_file_operations will need to be used
accordingly, which seems overly complicated.

Thanks,
Amir.

