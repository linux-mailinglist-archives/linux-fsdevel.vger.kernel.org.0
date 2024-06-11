Return-Path: <linux-fsdevel+bounces-21385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689FC90347D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 09:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139A1288711
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADFA173340;
	Tue, 11 Jun 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nILq6SaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73439172BCF;
	Tue, 11 Jun 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092664; cv=none; b=cY92taIgIWEb2ouo0YIniwew7hCKcNwNuteTkegFhZooO0wgi0j3vjNjDKPM6gWQppB/60hBon0UFh8qILVU2YSC0WoCblrZM/wC0Si9m+mT7OQj7Q9MQz1GFLbbZSNrTWPu33HX6uE0T/wxCb/xtp4L9UaacZRLi5Ag1pFL6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092664; c=relaxed/simple;
	bh=yYQGLfAsLFY8TL8Qjc1uRMl9s9ciTMenVf1hsx0j8Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyZhGn2OS0+sDWAsRUBsqSTowIT3q/8YXEjryHL28pcXmhLz8F0WvlysZ2I0xMU6yNshHzeQGCORorBMgWOgjvBbC/6QCGobmE8WHdeEMBgw8PvQZ0Yu1d504Dq8L/AgzgDRIHOeFmVjLhYsKm//C2IJmzGyQz5C2ub344wxrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nILq6SaX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-797a7f9b52eso80279685a.2;
        Tue, 11 Jun 2024 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718092661; x=1718697461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYQGLfAsLFY8TL8Qjc1uRMl9s9ciTMenVf1hsx0j8Kk=;
        b=nILq6SaXnuPkaQ/QCKwkAVJqN5H6jVa8oxHH+SrVUIR3ntgHE/OV1t/Pk8ojg6TKK5
         G0YYiWYPICyZVUyBea5riGFn/4RzBrmFKUzosHYPIS6WrUYnhgRL4DShC+h2h7j5+7/5
         jtlrJG8wUO9pxdJan7r/c20Hj8vjLI6GbKTcAWJdLRiQousp4YentkSuRjUaiJrCXVNH
         nbOJHmlLjnylr0PhrgigaGEGvqXuJTZUtxPmXluQuO31zxuqmEiP8GVAMlxUEWHnYnOm
         8Atj0UuvDaOoOY1b9O5a+r/noJpfjbfC7VUvVmzGUU4xvTtJVhwjJ7Qlq/AwZMyS4HkG
         qlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092661; x=1718697461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYQGLfAsLFY8TL8Qjc1uRMl9s9ciTMenVf1hsx0j8Kk=;
        b=Eo5IXOty3u8jT41kx1AKRKY/xpFosI5lvdmogqjoRxbtRglCMF6t+bhwkSMv/madue
         o+R7HBhbyvlf2fsygv3r3giIHbYzcA8V29IFOMdQvkaUaFuQhwwKXCuibbXNDcMOWiY1
         u+X7qgIqtDiLnJWRhG24ow3NQkEofr2j3OihlwP7sKoHtt1TpW/O73neFe5RJIZgci8c
         Q9yMsxKuv2RVzQyeoXHJFyQZ22W7n3aEKBicDPq/hOAG386THfSVcSS4osjNgSMtL4Wq
         YrQqyxV0W70vatztlgqWwQJ2Lg0VWL8HjykHfyrY+WJqKQeqKI6xDDKtL6ZFr7r6ZzZJ
         bb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3kktXme/EeMLekeK5a1tKUZ2FH0xPDnereEYYpQjqtKAIRPRdilj4xLHLlvXxN19J22TZZIQ0vsFLpz8cwnWMSfRqMbZ86PPMsyxQQPMFr5MjNQxkUEecOnnACRAIJ/VK2Tv7sBMN1g==
X-Gm-Message-State: AOJu0YzeOUnmZDGafKwTv/Ya9CfFa2Hbn3JdrTHRztz9LrpRxy63aizs
	GrMwkxc4p5jE1Q/MSht3eR41q/i9QF8IOdqCsEOstmY8sEkticEt9uf1Ve+yOSpmQJJG4QD5602
	WhqHG/1xO5uB3mj6r7POIJ94W/Yk=
X-Google-Smtp-Source: AGHT+IEJWGeEL559GTLXLIcq0GoArtl5OAHGmWCJzSW6blozh8XQgTug+80vXiPMCf0ESO6Xv1zxS2n2Kl5b5bXaGEc=
X-Received: by 2002:a05:620a:1929:b0:795:4e6a:d43e with SMTP id
 af79cd13be357-7954e6ada9dmr1008569785a.31.1718092660996; Tue, 11 Jun 2024
 00:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs> <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs> <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area> <tnj5nqca7ewg5igfvhwhmjigpg3nxeic4pdqecac3azjsvcdev@plebr5ozlvmb>
 <CAOQ4uxg6qihDRS1c11KUrrANrxJ2XvFUtC2gHY0Bf3TQjS0y4A@mail.gmail.com>
 <kh5z3o4wj2mxx45cx3v2p6osbgn5bd2sdexksmwio5ad5biiru@wglky7rxvj6l>
 <CAOQ4uxgLbXHYxhgtLByDyMcEwFGfg548AmJj7A99kwFkS_qTmw@mail.gmail.com> <20240610202631.GE52973@frogsfrogsfrogs>
In-Reply-To: <20240610202631.GE52973@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Jun 2024 10:57:29 +0300
Message-ID: <CAOQ4uxhd9UG1F3oiEg0NWOXjPFyd1Y4G2SNO5kU09kEUVX4zEw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Jun 10, 2024 at 04:21:39PM +0300, Amir Goldstein wrote:
> > On Mon, Jun 10, 2024 at 2:50=E2=80=AFPM Andrey Albershteyn <aalbersh@re=
dhat.com> wrote:
> > >
> > > On 2024-06-10 12:19:50, Amir Goldstein wrote:
> > > > On Mon, Jun 10, 2024 at 11:17=E2=80=AFAM Andrey Albershteyn <aalber=
sh@redhat.com> wrote:
> > > > >
> > > > > On 2024-06-06 12:27:38, Dave Chinner wrote:
> > > > ...
> > > > > >
> > > > > > The only reason XFS returns -EXDEV to rename across project IDs=
 is
> > > > > > because nobody wanted to spend the time to work out how to do t=
he
> > > > > > quota accounting of the metadata changed in the rename operatio=
n
> > > > > > accurately. So for that rare case (not something that would hap=
pen
> > > > > > on the NAS product) we returned -EXDEV to trigger the mv comman=
d to
> > > > > > copy the file to the destination and then unlink the source ins=
tead,
> > > > > > thereby handling all the quota accounting correctly.
> > > > > >
> > > > > > IOWs, this whole "-EXDEV on rename across parent project quota
> > > > > > boundaries" is an implementation detail and nothing more.
> > > > > > Filesystems that implement project quotas and the directory tre=
e
> > > > > > sub-variant don't need to behave like this if they can accurate=
ly
> > > > > > account for the quota ID changes during an atomic rename operat=
ion.
> > > > > > If that's too hard, then the fallback is to return -EXDEV and l=
et
> > > > > > userspace do it the slow way which will always acocunt the reso=
urce
> > > > > > usage correctly to the individual projects.
> > > > > >
> > > > > > Hence I think we should just fix the XFS kernel behaviour to do=
 the
> > > > > > right thing in this special file case rather than return -EXDEV=
 and
> > > > > > then forget about the rest of it.
> > > > >
> > > > > I see, I will look into that, this should solve the original issu=
e.
> > > >
> > > > I see that you already got Darrick's RVB on the original patch:
> > > > https://lore.kernel.org/linux-xfs/20240315024826.GA1927156@frogsfro=
gsfrogs/
> > > >
> > > > What is missing then?
> > > > A similar patch for rename() that allows rename of zero projid spec=
ial
> > > > file as long as (target_dp->i_projid =3D=3D src_dp->i_projid)?
> > > >
> > > > In theory, it would have been nice to fix the zero projid during th=
e
> > > > above link() and rename() operations, but it would be more challeng=
ing
> > > > and I see no reason to do that if all the other files remain with z=
ero
> > > > projid after initial project setup (i.e. if not implementing the sy=
scalls).
> > >
> > > I think Dave suggests to get rid of this if-guard and allow
> > > link()/rename() for special files but with correct quota calculation.
> > >
> > > >
> > > > >
> > > > > But those special file's inodes still will not be accounted by th=
e
> > > > > quota during initial project setup (xfs_quota will skip them), wo=
uld
> > > > > it worth it adding new syscalls anyway?
> > > > >
> > > >
> > > > Is it worth it to you?
> > > >
> > > > Adding those new syscalls means adding tests and documentation
> > > > and handle all the bugs later.
> > > >
> > > > If nobody cared about accounting of special files inodes so far,
> > > > there is no proof that anyone will care that you put in all this wo=
rk.
> > >
> > > I already have patch and some simple man-pages prepared, I'm
> > > wondering if this would be useful for any other usecases
> >
> > Yes, I personally find it useful.
> > I have applications that query the fsx_xflags and would rather
> > be able to use O_PATH to query/set those flags, since
> > internally in vfs, fileattr_[gs]et() do not really need an open file.
> >
> > > which would
> > > require setting extended attributes on spec indodes.
> >
> > Please do not use the terminology "extended attributes" in the man page
> > to describe struct fsxattr.
>
> "XFS file attributes" perhaps?
>
> Though that's anachronistic since ext4 supports /some/ of them now.
>

Technically, it's all the filesystems that support ->fileattr_[gs]et(),
which is a lot.

Since the feature has matured into a vfs feature with planned new syscalls,
the XFS ioctl man page could be referenced for historic perspective and
for explaining the reason for the X in fsxattr, but I don't think that
the official
name of those attributes should include "XFS".

Maybe TAFKAXFA (The attributes formerly known as XFS file attributes) :-p

Also, adding a syscall to perform FS_IOC_FS[GS]ETXATTR, without
being able to perform FS_IOC_[GS]ETFLAGS would be a bit odd IMO.
It is possible to multiplex both in the same syscall.
For example, let the syscall return the size of the attributes, like getxat=
tr().
Not sure whether it is smart to do it.

Then again, not sure if this was already mentioned as an option, besides
the more generic proposal by Miklos [1], but we could bind generic xattr
handlers for "system.fs.attr" and "system.fs.flags".
API-wise, ->fileattr_[gs]et() would become very similar to ->[gs]et_acl(),
which are also get/set via "system.*" xattr.

The added benefit is that we avoid the confusing distinctions between
"additional attributes" and "extended attributes" -
"additional file attributes/flags" are a private case of "extended attribut=
es".

Implementation wise it should be pretty simple, but I agree with Jan that
the question of credentials needed for these syscalls needs to be
addressed first and get Christian's blessing.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/YnEeuw6fd1A8usjj@miu.piliscsaba.r=
edhat.com/

