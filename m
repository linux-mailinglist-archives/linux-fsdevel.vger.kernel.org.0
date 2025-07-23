Return-Path: <linux-fsdevel+bounces-55911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A40B0FD38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 01:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB14E1C28956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B92550A3;
	Wed, 23 Jul 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghOWXwiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C11853;
	Wed, 23 Jul 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312547; cv=none; b=IUe0ZiIHDTE3wvwklKZAZaz6OjSlRyd1SEu8y19Xi2q6AgBfph63hWaJwqql/P4cWELlJbAPOmGc9Vw/UblULLN1bgRNJLQQJQ2nk2hHmcSq9fU+TL4RnvHZTMksuz+uZMWxN1PuI9RyC+j23vJUdKHgRrFe4xtZTN01XFRkaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312547; c=relaxed/simple;
	bh=E5cSYP9Df+TljGPWXIKBw0DaiY/s25HdMasFrgai4/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/qCNHWXXNf2XQlDLDep9w4tq3DOJ+ZFn6Q0VBkb97pKVzI72DZSs4zj6PMjMvawgO38KtkIS4lnqxCjgoD73a6sZfr68J7p25Q4PUbsSRJmv1H3FVGLjvCYknRo7VdLbFGjdbMzHiUKqk7ryLQ2DsVH6DFEuDdxRB6F7hMVDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghOWXwiq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab39fb71dbso4804781cf.3;
        Wed, 23 Jul 2025 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753312545; x=1753917345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxqvVKjKnRdjeHonK2NyXvcj4D2dnGAOtk2uNs8xY1k=;
        b=ghOWXwiqcWFLuO4TSu1YaI5zN4A6GCEVFR/FhT0xsJPTN/FdC+M82gWwXHtCp97pD3
         vI7pnMYTZ4VB7Dd9fkFUVl/yLW6rcwzR7MXHIROo41OW7ukaB2d7RnPsXB9pFpB/Hogf
         zaKjYVA/Gl7czs81fOMPG4Ywh6jFW15YVsG4dEWHKmikMjFpUM9UXP+57uwxoqrQerZt
         7459RBJ+QrOCvPimQ6KKvQBDfzFTdWtQeifSNphxPjSmkxhl/6ViXBLfAT3xyZJyvit3
         yQC/3On277miRLWhTTeVceieVZ0zopr7x8JzMr9xxleKRBiH6SQ2Dv06FIpI8bW5mnFf
         Tlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312545; x=1753917345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxqvVKjKnRdjeHonK2NyXvcj4D2dnGAOtk2uNs8xY1k=;
        b=t2rBbNKE9tE5ZwMciinhP5loWWCMM9SZW1HqiEmbqi3u5k/JxuAWzsadsgqdhT6HKB
         tVn3lofO+I4zetPHgh/Y6C2VaLuu2oZKuYtHmDEsGmtrQLy/3ACoG2qoaFygEoNAOk3c
         /q97gvqA8jsUCn9cUAEE63hhvv2lJL5Q2/vbXG6g+4PTvv9pyMIAc6O547l6O8SFo57H
         258wmSlFs4Yf7a2tyCbXdEqUPntsbh+svcT90QvD0i/dHfthXXbnXj74v3gmlK9Xc+By
         CjmdQDIp/dLztuJqYneqTqhrvvt6SzAvo4nC9STZCKRZOONMkkOVmnF0YuxYqPrgRPY2
         zwKg==
X-Forwarded-Encrypted: i=1; AJvYcCVqJeejnmlfmPw+qX/uvlYiM1/cHUCNDYvO7N1gaqMmKTnCgq2qwxdC/SEhhN1jk6EA2EG4TrvBAb74NXNH@vger.kernel.org, AJvYcCW+NPMBaU1rbZEqbeOzblGmsEqwnLuzf+rWD0PSA8m1vrEFykcWB97h8X8DgBhmA9j/nDfYXUg2k+YT@vger.kernel.org, AJvYcCX8OJm97RLT8DjtHYSchbDRaeicfv/gZav6bIxoTUbKPswzAmtmDqXW9IzDriibHFEQbd16a8saQ+kug6/t@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0fgtJWQbMoHRSZMf/xm/cL4HXLwpwjzxZIpbJsNagcajOKfZ
	GpHS/hNG25QxLk3Q6rKQir6w56HLKUnpWRS5S0dOMzHvgS7vvNR2IDyfObcHVgphRZZNjZghG6p
	S4XGvkN+8XqBS+2+wWQNJxdBAlbRBTHU=
X-Gm-Gg: ASbGnctIvIhMxmB1JAy36pL4S2zJZ9wJAU8zMDVs6I0osTkJtJQUjMjuPDfKy7hwb+C
	lVsDfEzQxj0cEpAToR0S80iLgr1wCJ7+9eGasQfjI0HknDUPTmp8Q/hnhZIAVjGyQ+rZwtReDDg
	4hAsOxQ/Hb1ieR9JGeS1sC0HH+jDLZcfHLf096O4st/KzUCB1+r4r3mt5jR7PN4uWOv4KhYDx3v
	c2BHvs=
X-Google-Smtp-Source: AGHT+IHlNadpmRVQnR9L5YwWXi/1q37lybj6swrt7fqmXQJSoFTFUz5IAk16c+9UoZdKYXY5a3Cl5vtnEtFqYipHQyY=
X-Received: by 2002:a05:622a:4d1:b0:4a7:a8a:eed with SMTP id
 d75a77b69052e-4ae6dfc2323mr97483581cf.39.1753312544328; Wed, 23 Jul 2025
 16:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs> <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 16:15:33 -0700
X-Gm-Features: Ac12FXzF2620xp8RVAUCjDRQn0A4HBT9-5mF3yOk4tFXX3gskarUrR9Z58ZmyE8
Message-ID: <CAJnrk1ZREcrd=FNUYLVWwXUeJ3mJz9J+aqyEvoHkyG3RrJ2QkA@mail.gmail.com>
Subject: Re: next-20250721 arm64 16K and 64K page size WARNING fs fuse file.c
 at fuse_iomap_writeback_range
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, linux-xfs@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <liam.howlett@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:42=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > [cc Joanne]
> >
> > On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > > Regressions found while running LTP msync04 tests on qemu-arm64 runni=
ng
> > > Linux next-20250721, next-20250722 and next-20250723 with 16K and 64K
> > > page size enabled builds.
> > >
> > > CONFIG_ARM64_64K_PAGES=3Dy ( kernel warning as below )
> > > CONFIG_ARM64_16K_PAGES=3Dy ( kernel warning as below )
> > >
> > > No warning noticed with 4K page size.
> > > CONFIG_ARM64_4K_PAGES=3Dy works as expected
> >
> > You might want to cc Joanne since she's been working on large folio
> > support in fuse.
> >
> > > First seen on the tag next-20250721.
> > > Good: next-20250718
> > > Bad:  next-20250721 to next-20250723
>
> Thanks for the report. Is there a link to the script that mounts the
> fuse server for these tests? I'm curious whether this was mounted as a
> fuseblk filesystem.
>
> > >
> > > Regression Analysis:
> > > - New regression? Yes
> > > - Reproducibility? Yes
> > >
> > > Test regression: next-20250721 arm64 16K and 64K page size WARNING fs
> > > fuse file.c at fuse_iomap_writeback_range
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > ## Test log
> > > ------------[ cut here ]------------
> > > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4190
> >
> >         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> >
> > /me speculates that this might be triggered by an attempt to write back
> > some 4k fsblock within a 16/64k base page?
> >
>
> I think this can happen on 4k base pages as well actually. On the
> iomap side, the length passed is always block-aligned and in fuse, we
> set blkbits to be PAGE_SHIFT so theoretically block-aligned is always
> page-aligned, but I missed that if it's a "fuseblk" filesystem, that
> isn't true and the blocksize is initialized to a default size of 512
> or whatever block size is passed in when it's mounted.
>
> I'll send out a patch to remove this line. It doesn't make any
> difference for fuse_iomap_writeback_range() logic whether len is
> page-aligned or not; I had added it as a sanity-check against sketchy
> ranges.
>

https://lore.kernel.org/linux-fsdevel/20250723230850.2395561-1-joannelkoong=
@gmail.com/T/#u
is the patch for removing this

