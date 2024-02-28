Return-Path: <linux-fsdevel+bounces-13068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A659986AC68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B231F240C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146212BF22;
	Wed, 28 Feb 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Josu444R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB47E577;
	Wed, 28 Feb 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117896; cv=none; b=gQifNf0dPDdnUfsYfDRZEH4eOJaaD8VM9nCMDFTfrJmj4j40vmliX4JdNr0Yc1sQkMrwiWy9GAkpMbvEUofP6Y6ZY3u+Pgt9ukxZ1wsqMBhVifAP1S/Ue+os3IPuPaMIlhupnuBBqzWbO1kB/P+Q2DFGEK0lk5IhxG6NKoi4iOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117896; c=relaxed/simple;
	bh=+xDLnpmD1rbf6ZkQjSeuoyoIkfrysx7G2jhiz+Xp2Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJdg/a4d/qTzKBN6qVkxue1cNKkuOBXqDsjzj7bMKraIO/Cq6eB5dUQrlB+bLNsoNOBvMc/UtQxSFm6p478xNRINs9n0Iml4YEs6Qi7Sr6tjluT3oOW2opP/zpFt2ewW6LsBlka/SWcrhuGyRQOm0j5mrL2l5SeH00CKaWZWYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Josu444R; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42e8a130ebcso4483121cf.1;
        Wed, 28 Feb 2024 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709117893; x=1709722693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xDLnpmD1rbf6ZkQjSeuoyoIkfrysx7G2jhiz+Xp2Q8=;
        b=Josu444RxjowDwSYUEPj+JXAe3NXIJ8DZHqTp4aXp+K43gY6inWD07lQabWTD6O79E
         3a01ndNBfuzOD3EGH4Tgc+Gwv70rH0WsQyvKY4XqNZ5X1GCcETIzoCp0JIXVU2EXSXVo
         C0cGa4OHqwGIuy5xgezro4BvrMpt0Jvb/l0AjV6lOxk4mOZVdOzYoRXRY4UiGHKzoMTZ
         dsZCgFJ4v81HWl4Z2WvSaYjK5KhNGOg7kNkQYO8rfCPJ0oF/MCfS8tIPDDVBaIUkWpsa
         Ql0ynzxqJszAhruPk0nL7rEq1j0PLrgTaWiV3HNLp2ewUbb3y3oe4/kMMDUedLCTNZc0
         g6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709117893; x=1709722693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xDLnpmD1rbf6ZkQjSeuoyoIkfrysx7G2jhiz+Xp2Q8=;
        b=IX7uxAevoce7j3kqMGTjhGH5tVL0XuSSkJ7HDHIzz07L6CZuK46GbyUuu9uKs3pt0v
         83r20gfkfrSDJBO2J9Px1iDTYBOaDzWSoXR4WtrXXSobIhOw6771440UGhhbSZbXqV10
         i4qsjoBFAYY3nRAxdjQZyj03NoXmbW/esqsIDWR3dOTzEqLqAbZhVKKHgp4VdYV6Sn3Q
         Z+0ZJ8nXQTc1TitxTHVwc5QfCvFI2sOyN3te3k+yOg4x1+Y30EBK1t27PqVe3CCcgA+R
         17Cy601jZW2/tAh4SYUc2fA7gFYbejyi6kpWtCR9cGjgYghVGMBrbWh+Lmlw6FJtl5Wa
         6T1A==
X-Forwarded-Encrypted: i=1; AJvYcCXg+bVYsHT+/6qlW7w4h8iXp4K9fKd2MZNKB+Ktz9IMaV6nEaZ8FIKJfvclRChGzHALHWLDUUHz7qNw6KUMSsOlhlPZ1m+7EqOw44NgtHV6YkWE9jfQ+/PzwBtMmGPlzXgygH7kHvOCLQ==
X-Gm-Message-State: AOJu0YxG7CPw7Wa03X36AInQS6QCIfCWeKW7DZ+vm5ReAJGCVCIxsnv9
	aNBxnr3vIGQ726HBhn/fR29XWJQI7TBdU5ylBcrhAiUjeLoIea2e97rhALSNADUHktfHA7z+Msd
	GOdKIs3CyES2tRYjROWW8LVPzd+4=
X-Google-Smtp-Source: AGHT+IGAidHhzJgZDTYVPdUmRbZ85pI78YhjnVm5RF+Vq8q3bA5AcZHNL9Idhn0RkrdxhkxLSASnS8lMMZCDurT49/g=
X-Received: by 2002:ac8:7c4b:0:b0:42e:6783:a491 with SMTP id
 o11-20020ac87c4b000000b0042e6783a491mr3182988qtv.20.1709117893543; Wed, 28
 Feb 2024 02:58:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com>
 <4e29a0395b3963e6a48f916baaf16394acd017ca.camel@kernel.org>
 <Zd50P9TH5TAdqFyU@dread.disaster.area> <4f15410284805166ee39d831adb3f492d2ef2937.camel@kernel.org>
In-Reply-To: <4f15410284805166ee39d831adb3f492d2ef2937.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Feb 2024 12:58:02 +0200
Message-ID: <CAOQ4uxjK5ekTHWYAcACb_wx3Y-k03YqrjdzFjkHZbBabVojXNA@mail.gmail.com>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Wed, 2024-02-28 at 10:46 +1100, Dave Chinner wrote:
> > On Tue, Feb 27, 2024 at 05:53:46AM -0500, Jeff Layton wrote:
> > > On Tue, 2024-02-27 at 11:23 +0200, Amir Goldstein wrote:
> > > > On Tue, Feb 27, 2024 at 4:18=E2=80=AFAM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > And for a new API, wouldn't it be better to use change_cookie (a.k.=
a i_version)?
> >
> > Like xfs_fsr doing online defrag, we really only care about explicit
> > user data changes here, not internal layout and metadata changes to
> > the files...
> >
> > > > Even if this API is designed to be hoisted out of XFS at some futur=
e time,
> > > > Is there a real need to support it on filesystems that do not suppo=
rt
> > > > i_version(?)
> > > >
> > > > Not to mention the fact that POSIX does not explicitly define how c=
time should
> > > > behave with changes to fiemap (uninitialized extent and all), so wh=
o knows
> > > > how other filesystems may update ctime in those cases.
> > > >
> > > > I realize that STATX_CHANGE_COOKIE is currently kernel internal, bu=
t
> > > > it seems that XFS_IOC_EXCHANGE_RANGE is a case where userspace
> > > > really explicitly requests a bump of i_version on the next change.
> > > >
> > >
> > >
> > > I agree. Using an opaque change cookie would be a lot nicer from an A=
PI
> > > standpoint, and shouldn't be subject to timestamp granularity issues.
> > >
> > > That said, XFS's change cookie is currently broken. Dave C. said he h=
ad
> > > some patches in progress to fix that however.
> >
> > By "fix", I meant "remove".
> >
> > i.e. the patches I was proposing were to remove SB_I_VERSION support
> > from XFS so NFS just uses the ctime on XFS because the recent
> > changes to i_version make it a ctime change counter, not an inode
> > change counter.
> >
> > Then patches were posted for finer grained inode timestamps to allow
> > everything to use ctime instead of i_version, and with that I
> > thought NFS was just going to change to ctime for everyone with that
> > the whole change cookie issue was going away.
> >
> > It now sounds like that isn't happening, so I'll just ressurect the
> > patch to remove published SB_I_VERSION and STATX_CHANGE_COOKIE
> > support from XFS for now and us XFS people can just go back to
> > ignoring this problem again.
>
>
> I must have misunderstood what you said when we were at LPC this year:
>
> After the multigrain ctime patches were reverted, you mentioned that you
> were working on a patchset that used the unused bits in the tv_nsec
> field as counter for counting changes that have occurred within the same
> tv_nsec value.
>
> Did those not pan out for some reason?

Jeff,

Could I trouble you to suggest a topic for LSFMM to summarize
everything that has been going on this year wrt change cookie/time
at xfs/vfs level and try to set a clear roadmap?

Thanks,
Amir.

