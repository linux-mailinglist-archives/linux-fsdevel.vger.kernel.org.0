Return-Path: <linux-fsdevel+bounces-9258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF51183FA0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1431C21BD4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98E3C460;
	Sun, 28 Jan 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NDwh/ZsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141851DFD9
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477107; cv=none; b=HB5hYzm1Z6JwVxK54N63wMV/uV83aYGfk0iRjRAvUP5JxODpLN4hdsvw4xVd8mLn3s8lGwTQR3ZRDoShVm21du9ko2wSQ/p8v1neA6QO6D8EJdaT1v/Zarr9pqOwtw4+62PCSGPee3h5WctrJPGoBmDH++zJbyLjdAHAbHKymoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477107; c=relaxed/simple;
	bh=Ab32dIT+JGe1KR1hHoPEcNe4Z/Tjno7/Odo5mSS+wms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiyAAJLV7Yxvc6gaQ2On+eJZUlR13qiRT9SVSTgwSVCvImLlrkdbiDAMee9+vRrvVQDrq7xVtBx3ChqchqPhQUtkgkoe+2Zwc+FUhJIOh0+yyigPdncD3QpCoc6cL6E8b/P+kS8HZVC/adXt6F5XNEKlBHc7fhgS8ZZRNpUZkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NDwh/ZsH; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd562d17dcso1833225b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 13:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706477105; x=1707081905; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yFxnYNSqRJeaFLMjNAkAR1eBmkMk5OSt+lKtiwrsmCg=;
        b=NDwh/ZsHdERG/iI3CDDf/3aMtaliEDPHjOzu45k0MBqduifmaBCM3p5INpddz0b/5d
         1ubtwhOM9RpewbDIZrpSteQJ78XAf5JZk7UtJR83s8UdgLFx4d02CB0YrFnQeBQ6o7Z2
         +e4LpxAM5wJVVHP66QXwP57uVYxldN1EnYzZDqJQi4vFYKlBfogKIEbinItlFlBOvvLV
         zbG3aOM+MGB0Upu2Qe0c5b+OxVtQJREm7l6MB189o51eNt5/wt6EyClZ8HLzECnlGxZ2
         Ior7H/V0QXSKvNYTRIz8y9HwjPW61ynbL3IDQW3IhVb4BcaKajt6iThm9Oh3OLDzK0iq
         h9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706477105; x=1707081905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFxnYNSqRJeaFLMjNAkAR1eBmkMk5OSt+lKtiwrsmCg=;
        b=dXGq4Cg/13hj5ihWVkcDlBhZRJlN8lWuwIqx7rzwmuKtlTOdLnv2cHUzY7BZShkO9N
         RQXKXYFDl62iFAhG+htM7gRx/XnhGCJSvaD7t+VWqXcgt+vMArUNR8Qg7lJLriYnPebG
         BZSKIUds2eQxkTy0PGGViKW9kNxPsinumbc4rBDvCX9SDc/51gTOvOZrxYOA2lU/kXKJ
         SIth9YeGv/Tg4HELZRaAfBUikPSyEwahCxuJj9DmtnYyPo6TNsveH/AZScgZYFvMi430
         QiMGMA8fwZtL4/0nCjGQiNuZyLT7yoekq+JWg5PLSEUzbAbyx99CzDiF4/gs82cM9zMY
         0Caw==
X-Gm-Message-State: AOJu0Ywlur/UEtykyPKjOoNWtmHTFkKCYhhRTr6+keLNzTRhaXAOIvB5
	CTS+dQLFi7jpUasPpdyCZjq2VOSWmezvChjm2MSYI9aGzqbGx4Da32cJDEHQoRc=
X-Google-Smtp-Source: AGHT+IFqrJrYWS3DKZJW50dQDBsCsKhW2ARZDOnSqRTeM0ew1imAxRvFWqS4nKmfgWaynnC0I3xLYA==
X-Received: by 2002:a05:6808:3c94:b0:3be:51df:b82a with SMTP id gs20-20020a0568083c9400b003be51dfb82amr1709382oib.40.1706477104987;
        Sun, 28 Jan 2024 13:25:04 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id it3-20020a056a00458300b006db04fb3f00sm4541463pfb.28.2024.01.28.13.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 13:25:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rUCeC-00GaMn-02;
	Mon, 29 Jan 2024 08:25:00 +1100
Date: Mon, 29 Jan 2024 08:25:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>,
	fuse-devel <fuse-devel@lists.sourceforge.net>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [fuse-devel] FICLONE / FICLONERANGE support
Message-ID: <ZbbGLKeZ90fHYnRs@dread.disaster.area>
References: <1fb83b2a-38cf-4b70-8c9e-ac1c77db7080@spawn.link>
 <CAOQ4uxgoJkotsP6MVuPmO91VSG3kKWdUqXAtp37rxc0ehOSfEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgoJkotsP6MVuPmO91VSG3kKWdUqXAtp37rxc0ehOSfEw@mail.gmail.com>

On Sun, Jan 28, 2024 at 12:07:22PM +0200, Amir Goldstein wrote:
> On Sun, Jan 28, 2024 at 2:31 AM Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> >
> > Hello,
> >
> > Has anyone investigated adding support for FICLONE and FICLONERANGE? I'm
> > not seeing any references to either on the mailinglist. I've got a
> > passthrough filesystem and with more users taking advantage of btrfs and
> > xfs w/ reflinks there has been some demand for the ability to support it.
> >
> 
> [CC fsdevel because my answer's scope is wider than just FUSE]
> 
> FWIW, the kernel implementation of copy_file_range() calls remap_file_range()
> (a.k.a. clone_file_range()) for both xfs and btrfs, so if your users control the
> application they are using, calling copy_file_range() will propagate via your
> fuse filesystem correctly to underlying xfs/btrfs and will effectively result in
> clone_file_range().
> 
> Thus using tools like cp --reflink, on your passthrough filesystem should yield
> the expected result.
> 
> For a more practical example see:
> https://bugzilla.samba.org/show_bug.cgi?id=12033
> Since Samba 4.1, server-side-copy is implemented as copy_file_range()
> 
> API-wise, there are two main differences between copy_file_range() and
> FICLONERANGE:
> 1. copy_file_range() can result in partial copy
> 2. copy_file_range() can results in more used disk space
> 
> Other API differences are minor, but the fact that copy_file_range()
> is a syscall with a @flags argument makes it a candidate for being
> a super-set of both functionalities.
> 
> The question is, for your users, are you actually looking for
> clone_file_range() support? or is best-effort copy_file_range() with
> clone_file_range() fallback enough?
> 
> If your users are looking for the atomic clone_file_range() behavior,
> then a single flag in fuse_copy_file_range_in::flags is enough to
> indicate to the server that the "atomic clone" behavior is wanted.
> 
> Note that the @flags argument to copy_file_range() syscall does not
> support any flags at all at the moment.
> 
> The only flag defined in the kernel COPY_FILE_SPLICE is for
> internal use only.
> 
> We can define a flag COPY_FILE_CLONE to use either only
> internally in kernel and in FUSE protocol or even also in
> copy_file_range() syscall.

I don't care how fuse implements ->remap_file_range(), but no change
to syscall behaviour, please.

copy_file_range() is supposed to select the best available method
for copying the data based on kernel side technology awareness that
the application knows nothing about (e.g. clone, server-side copy,
block device copy offload, etc). The API is technology agnostic and
largely future proof because of this; adding flags to say "use this
specific technology to copy data or fail" is the exact opposite of
how we want copy_file_range() to work.

i.e. if you want a specific type of "copy" to be done (i.e. clone
rather than data copy) then call FICLONE or copy the data yourself
to do exactly what you need. If you just want it done fast as
possible and don't care about implementation (99% of cases), then
just call copy_file_range().

> Sure, we can also add a new FUSE protocol command for
> FUSE_CLONE_FILE_RANGE, but I don't think that is
> necessary.
> It is certainly not necessary if there is agreement to extend the
> copy_file_range() syscall to support COPY_FILE_CLONE flag.

We have already have FICLONE/FICLONERANGE for this operation. Fuse
just needs to implement ->remap_file_range() server stubs, and then
the back end driver  can choose to implement it if it's storage
mechanisms support such functionality. Then it will get used
automatically for copy_file_range() for those FUSE drivers, the rest
will just copy the data in the kernel using splice as they currently
do...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

