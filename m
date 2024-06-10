Return-Path: <linux-fsdevel+bounces-21340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E5902290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8061281C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFD824AE;
	Mon, 10 Jun 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsbU8Uex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E14501B;
	Mon, 10 Jun 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025713; cv=none; b=PvYZhqCOBwG+ynHz2P6wp9zjvb6BRI/H493NDtiHAEw0A5lg2MxTOtXDL1JvoAmV0xmcIsLMo6Np5OQdnLKB3lTqAyWErn+r3+WyZnZV4FvBBnrSCiXRGKT5GQ+FdkBL80p98GLJaog/bZZ34qnYE0E0L3hE4s9p2tX9LmxTiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025713; c=relaxed/simple;
	bh=4SbC6w7LV+Y002BkaDiHjFCieigGtOeuU66oIxLwQag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpdHQbn6usb1ErrbwkVOECkN0OJaiLQETEjDACT88cWa+LR4i8Zq6ECJecw7kfQ2QYa37S+TEMl0aoREhTsdTmY2Krj2BPARMnvBu9UC3POCim65TvbRtxZeEax7sYGRqagCkxuWhhbrRDNd36Tj9lhbiC2sqY8CMDT09pobe7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsbU8Uex; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b05e504bceso23123506d6.2;
        Mon, 10 Jun 2024 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025711; x=1718630511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SbC6w7LV+Y002BkaDiHjFCieigGtOeuU66oIxLwQag=;
        b=SsbU8UexSAqcQtG7+6ZAZwtFJLNBvSod1ZoLqARiuLzLjKTAU22s0p85BBgJpYmcQ9
         rYHL/Jg1Q2dRAMXbCJl6BkTQJvpWt6L4jcUfPjCyzDlltD0aBYo1zfB60DSOJ+RHv6vQ
         TReDJV2W8tZBjK1ybq54Af6Mypv+OJjIgSuvwaREGjvCAXu0soTjVvLUDrpwcY/+yJ95
         /6NDC2TziiFu8Ir9Zn40gpBhZlao65h+YlCzJyQwAjab+UmcPOWi606jjz59HNqT6t52
         fpe6cMLO9FoEzsiR21FiLS135hHISJpz1KcfsAQdJ6riI8hWgPiMdxXisY5MAHX7b3sW
         MluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025711; x=1718630511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SbC6w7LV+Y002BkaDiHjFCieigGtOeuU66oIxLwQag=;
        b=ujuW6xO38Ilee5GuQx34pBIGaCtRHNjhKYtSeFucFmL+77l+s+6wpULHiH0ZnAa0it
         pPv9eylQU0kxHVVS9pk2AtQKYcFdF6um2nOGSC/7COILB81bTnfyTMZZA/5kDyPtq+nn
         AYIovYULutWaATxQIwXb5qlCzlTU9GTvi4PN2eAQYKD0uFp70NwwHfISoJpAcqUDy+RV
         +7pOFfEJt0Cqemid0jatFntR5cWYUk8plJy5XOyp1J0vLsnP9sBuUAdzFtqCbExRkRX3
         l3Qg/CwtqFDyL5f3Q88/LVmU7yANKixqJn/JKdlEJc6lg5FAyT748Tu0x7i+pVisb+FX
         x+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUK50qhXWlz3hccGLrGUZzkiZi3tj2wB4EUfhmIMnUBGKBYMOZbSLQjZW+1Q0/q14WR+TCR/DoweSXAGj9Fq/amJHyxyIBkanVzPs1e0GN/uDSxtKMjT9uccsgRKHSHeQiOxwyYbd3Igg==
X-Gm-Message-State: AOJu0YyWI516rbPh91wcJPTb35YqM7N5bqkw6IMKXdclpFM9WruOQmDy
	1J1l7DH5PPWkNKDD0fadtgUb01SDOnxNoZGbDeHXPB0RS/oYe97Wc2KQEAakL9NKZLSI2W9l1df
	/sFKbFdXczVLyWKFmVpp9eYKaKi8=
X-Google-Smtp-Source: AGHT+IFXdAJ4P0gih9diJ3CnyRV7VCkCqNa4qGRUx3JH0L6l6+4eFkuUBOqmNinoaN9CPr9WH3zwLmeQrnr7YE8wLRs=
X-Received: by 2002:a05:6214:588a:b0:6b0:7747:be42 with SMTP id
 6a1803df08f44-6b07747c007mr41935976d6.55.1718025711164; Mon, 10 Jun 2024
 06:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531145204.GJ52987@frogsfrogsfrogs> <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs> <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs> <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area> <tnj5nqca7ewg5igfvhwhmjigpg3nxeic4pdqecac3azjsvcdev@plebr5ozlvmb>
 <CAOQ4uxg6qihDRS1c11KUrrANrxJ2XvFUtC2gHY0Bf3TQjS0y4A@mail.gmail.com> <kh5z3o4wj2mxx45cx3v2p6osbgn5bd2sdexksmwio5ad5biiru@wglky7rxvj6l>
In-Reply-To: <kh5z3o4wj2mxx45cx3v2p6osbgn5bd2sdexksmwio5ad5biiru@wglky7rxvj6l>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Jun 2024 16:21:39 +0300
Message-ID: <CAOQ4uxgLbXHYxhgtLByDyMcEwFGfg548AmJj7A99kwFkS_qTmw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 2:50=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> On 2024-06-10 12:19:50, Amir Goldstein wrote:
> > On Mon, Jun 10, 2024 at 11:17=E2=80=AFAM Andrey Albershteyn <aalbersh@r=
edhat.com> wrote:
> > >
> > > On 2024-06-06 12:27:38, Dave Chinner wrote:
> > ...
> > > >
> > > > The only reason XFS returns -EXDEV to rename across project IDs is
> > > > because nobody wanted to spend the time to work out how to do the
> > > > quota accounting of the metadata changed in the rename operation
> > > > accurately. So for that rare case (not something that would happen
> > > > on the NAS product) we returned -EXDEV to trigger the mv command to
> > > > copy the file to the destination and then unlink the source instead=
,
> > > > thereby handling all the quota accounting correctly.
> > > >
> > > > IOWs, this whole "-EXDEV on rename across parent project quota
> > > > boundaries" is an implementation detail and nothing more.
> > > > Filesystems that implement project quotas and the directory tree
> > > > sub-variant don't need to behave like this if they can accurately
> > > > account for the quota ID changes during an atomic rename operation.
> > > > If that's too hard, then the fallback is to return -EXDEV and let
> > > > userspace do it the slow way which will always acocunt the resource
> > > > usage correctly to the individual projects.
> > > >
> > > > Hence I think we should just fix the XFS kernel behaviour to do the
> > > > right thing in this special file case rather than return -EXDEV and
> > > > then forget about the rest of it.
> > >
> > > I see, I will look into that, this should solve the original issue.
> >
> > I see that you already got Darrick's RVB on the original patch:
> > https://lore.kernel.org/linux-xfs/20240315024826.GA1927156@frogsfrogsfr=
ogs/
> >
> > What is missing then?
> > A similar patch for rename() that allows rename of zero projid special
> > file as long as (target_dp->i_projid =3D=3D src_dp->i_projid)?
> >
> > In theory, it would have been nice to fix the zero projid during the
> > above link() and rename() operations, but it would be more challenging
> > and I see no reason to do that if all the other files remain with zero
> > projid after initial project setup (i.e. if not implementing the syscal=
ls).
>
> I think Dave suggests to get rid of this if-guard and allow
> link()/rename() for special files but with correct quota calculation.
>
> >
> > >
> > > But those special file's inodes still will not be accounted by the
> > > quota during initial project setup (xfs_quota will skip them), would
> > > it worth it adding new syscalls anyway?
> > >
> >
> > Is it worth it to you?
> >
> > Adding those new syscalls means adding tests and documentation
> > and handle all the bugs later.
> >
> > If nobody cared about accounting of special files inodes so far,
> > there is no proof that anyone will care that you put in all this work.
>
> I already have patch and some simple man-pages prepared, I'm
> wondering if this would be useful for any other usecases

Yes, I personally find it useful.
I have applications that query the fsx_xflags and would rather
be able to use O_PATH to query/set those flags, since
internally in vfs, fileattr_[gs]et() do not really need an open file.

> which would
> require setting extended attributes on spec indodes.

Please do not use the terminology "extended attributes" in the man page
to describe struct fsxattr.
Better follow the "additional attributes" terminology of xfs ioctl man page=
 [1],
even though it is already confusing enough w.r.t "extended attributes" IMO.

Thanks,
Amir.

[1] https://man7.org/linux/man-pages/man2/ioctl_xfs_fsgetxattr.2.html

