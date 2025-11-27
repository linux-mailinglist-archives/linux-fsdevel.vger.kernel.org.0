Return-Path: <linux-fsdevel+bounces-70019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF3AC8E64F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83EAD34FF5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374E1E0B9C;
	Thu, 27 Nov 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRHeWPZz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159713A244
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249397; cv=none; b=VuhajFLv6zPUohgyfHlVkgP9ST2+Y775bF69AF49acP1dG7mW8F7/p6Nh0luqsoqT8jM2Nle3TtOdIg+/fW4m63waT/K0Z2b9R3J7qzdK+MKKo1U5VB/JhOdAAsn5/u00+z3ey8PM+kKU+2+ggQdeaOjxaIhF82/LAjpfzUe4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249397; c=relaxed/simple;
	bh=ny+MrchSDMcrXVnz93h+B6NFkIrSiIjsV3sm3ZTIeLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBVRU8WrAgK7Xdn5pxa+sgVqGnIlNP1Ew7wPduN1yABNiFFlQE5/Yk49CqFD4UV9iHxZojsxVwrc3Ksfv8ohRoLRR2grrWGs/td37qmmZnt5Y8pYU+jCB7a4QqRRG1yuKY1pZHJUW3OFZVhSOuUpucjWf/V6nEGA9BmBaRuaItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRHeWPZz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso1531278a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764249393; x=1764854193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdLF6yAUjV4jBaQBf7Dys3LjH7dYAKSZKmrdbucYC7I=;
        b=kRHeWPZzrN7xfa/5TQXg1StxJXOA/7QMGnCev1jBzkvb2aAyrrjIbHZdNtISRyH7E7
         BLS0pHYuvI9xqpHbgjxl3+r97eVxet/OAIB1yI2/3ROM/IRErxHeMpNYX8i6Rzkz/Gjg
         cANtL+kUoow0eCgciAOlaocWH0BwNIyEVtd21VXx2bbaY11mfabZ0s0sIoqvseMxVzyz
         QxYdb9F0CXzbwq5Nkyeqps4JOiBxaYzihhyRy8Jzh1gjCXGIrG5noKT6A7Ab/kCipuxF
         f7AX4J4hZwsJZXG11oXE468akz6OuHtOqPKPK42S7TSz3Cf3S/pPz/xo858zY6Y8Gcrd
         fyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764249393; x=1764854193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KdLF6yAUjV4jBaQBf7Dys3LjH7dYAKSZKmrdbucYC7I=;
        b=qf7rh1B7AIcjE7o827Jyem/aIzIbzQe8YCY6EMkhWc2cuLd3IGdqrZh/VGfNNC/kUr
         dO/vFnX5ehF+XdGHKsZe+EAxHufyth+xbIpy5iBxmgEo6HuF7Cq9IoiZuUjEMv399GhU
         OX3+qnG5LGxyuLjZ5DNS3aGIr1vUKZGxY5KLnq2vSSXgw8slPtdzLiUT45AUDHtZam7T
         AOCqjRFoRFa8iPAvbJsjbFhZlhRHdLZuiV9KcaCYvm+qzLglWnE0maeGlosh7s9o2l8L
         qUf5FugQHsX00NXq+ldoAX4TbItmdT8kwd4gfNVCxES6ycOi+LPg4jaHEuIEBWz53uyg
         fxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhszL2vKcyGmZ3ExgIv3A+UX76aCSWD4qlBz6pKt30W9bqEhCMKck7DHCjZdTiR/KFAVd3LfXUZwSEQnvM@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHhk01k8p5/ftsxxP/U6Z20EY9sydHOXp1gSlH40alg1s1GMX
	VXSXdi1VBLatDExUuJcUwl7VxKyiWCXe13lpRmUZO8RLmsuuljrtA3oSKW1Ql3a+jQdEto7k3Vb
	zJ0AkUCWHehu/PvNEcwgGRafOvUOc1Ps=
X-Gm-Gg: ASbGncvCiDElmpweeGTKeOUlRigPumWAKM/u6R6UJcdMdt3aGKutQTqYhu2IliS1ZqS
	6A2zWYSMh2mMCnwhaYT0fEJW0Abj80EcTz9i15hEpIL+Xb0ClLHfbohZnmPFJoMHVlJw+bjeENj
	l0b6JjqT38Nle1pQT0dQ4rGYXr82DdBtknSpIu2KtJyTy46/sUBRs7d73yC6EpN0MuG1jmsC4np
	onUB14M4VljI8k8tjm0ctq2ciiEr22ABfTHy2RXDKkqO7dbeFDW/YJuVaYLRh9QwsdygfTjD0Hm
	DzNrijFc3xzaGRotfMgNv0Sd8uE=
X-Google-Smtp-Source: AGHT+IG3LonvR+sfNu+2F/GDxn1VY2DTI4KMBaNhb8qWTwk393yuRI//EfQ5oOt9xAtDKNosRTcmYsGzFtPuGCK6aVo=
X-Received: by 2002:a05:6402:2708:b0:63c:334c:fbc7 with SMTP id
 4fb4d7f45d1cf-64554675419mr21539732a12.19.1764249393354; Thu, 27 Nov 2025
 05:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <CAOQ4uxhfxeUJnatFJxuXgSdqkMykOw+q7KZTpWXb8K2tNZCPGg@mail.gmail.com>
 <CAKYAXd98388-=qOwa++aNuggKrJbOf24BMQZrvm6Gnjp_7qOTQ@mail.gmail.com>
In-Reply-To: <CAKYAXd98388-=qOwa++aNuggKrJbOf24BMQZrvm6Gnjp_7qOTQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Nov 2025 14:16:22 +0100
X-Gm-Features: AWmQ_bl-4awwl6Rpvcu5z_U681-BZyVX9sOR3EnWGUT7j7XXiV9LmLL13Nw3NEE
Message-ID: <CAOQ4uxg26jaY3vrUnWoB=NxHTkn2a8zSbtbQKd2w3Vp25wUxAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:18=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> On Thu, Nov 27, 2025 at 8:10=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Thu, Nov 27, 2025 at 6:00=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.=
org> wrote:
> > >
> > > Introduction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The NTFS filesystem[1] still remains the default filesystem for Windo=
ws
> > > and The well-maintained NTFS driver in the Linux kernel enhances
> > > interoperability with Windows devices, making it easier for Linux use=
rs
> > > to work with NTFS-formatted drives. Currently, ntfs support in Linux =
was
> > > the long-neglected NTFS Classic (read-only), which has been removed f=
rom
> > > the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still ha=
s
> > > many problems and is poorly maintained, so users and distributions ar=
e
> > > still using the old legacy ntfs-3g.
> >
> Hi Amir,
> > May I suggest that you add a patch to your series to add a deprecation
> > message to ntfs3?
> >
> > See for example eb103a51640ee ("reiserfs: Deprecate reiserfs")
> Okay, I'll add it in the next version, referring to this reiserfs patch.
> >

There is no need to refer to this patch, there is nothing special about it.
It's just an example for you of past deprecation procedures.

Unlike resierfs, the deprecation warning and help text for ntfs3 should ref=
er
users to the better in-tree alternative.

Thanks,
Amir.

> > >
> > >
> > > What is ntfsplus?
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The remade ntfs called ntfsplus is an implementation that supports wr=
ite
> > > and the essential requirements(iomap, no buffer-head, utilities, xfst=
ests
> > > test result) based on read-only classic NTFS.
> > > The old read-only ntfs code is much cleaner, with extensive comments,
> > > offers readability that makes understanding NTFS easier. This is why
> > > ntfsplus was developed on old read-only NTFS base.
> > > The target is to provide current trends(iomap, no buffer head, folio)=
,
> > > enhanced performance, stable maintenance, utility support including f=
sck.
> > >
> >
> > You are bringing back the old ntfs driver code from the dead, preservin=
g the
> > code and Copyrights and everything to bring it up to speed with modern =
vfs
> > API and to add super nice features. Right?
> Yes.
> >
> > Apart from its history, the new refurbished ntfs driver is also fully b=
ackward
> > compact to the old read-only driver. Right?
> Yes.
> >
> > Why is the rebranding to ntfsplus useful then?
> >
> > I can understand that you want a new name for a new ntfsprogs-plus proj=
ect
> > which is a fork of ntfs-3g, but I don't think that the new name for the=
 kernel
> > driver is useful or welcome.
> Right, I wanted to rebrand ntfsprogs-plus and ntfsplus into a paired
> set of names. Also, ntfs3 was already used as an alias for ntfs, so I
> couldn't touch ntfs3 driver without consensus from the fs maintainers.
> >
> > Do you have any objections to leaving its original ntfs name?
> I have no objection to using ntfsplus as an alias for ntfs if we add a
> deprecation message to ntfs3.
> >
> > You can also do:
> > MODULE_ALIAS_FS("ntfs");
> > MODULE_ALIAS_FS("ntfsplus");
> I will add this in the next version with ntfs3 deprecation patch.
> >
> > If that is useful for ntfsprogs-plus somehow.
> That is very useful and thanks for your review!
> >
> > Thanks,
> > Amir.
> >
> > >
> > > Key Features
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - Write support:
> > >    Implement write support on classic read-only NTFS. Additionally,
> > >    integrate delayed allocation to enhance write performance through
> > >    multi-cluster allocation and minimized fragmentation of cluster bi=
tmap.
> > >
> > > - Switch to using iomap:
> > >    Use iomap for buffered IO writes, reads, direct IO, file extent ma=
pping,
> > >    readpages, writepages operations.
> > >
> > > - Stop using the buffer head:
> > >    The use of buffer head in old ntfs and switched to use folio inste=
ad.
> > >    As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfi=
g also.
> > >
> > > - Public utilities include fsck[2]:
> > >    While ntfs-3g includes ntfsprogs as a component, it notably lacks
> > >    the fsck implementation. So we have launched a new ntfs utilitiies
> > >    project called ntfsprogs-plus by forking from ntfs-3g after removi=
ng
> > >    unnecessary ntfs fuse implementation. fsck.ntfs can be used for nt=
fs
> > >    testing with xfstests as well as for recovering corrupted NTFS dev=
ice.
> > >
> > > - Performance Enhancements:
> > >
> > >    - ntfsplus vs. ntfs3:
> > >
> > >      * Performance was benchmarked using iozone with various chunk si=
ze.
> > >         - In single-thread(1T) write tests, ntfsplus show approximate=
ly
> > >           3~5% better performance.
> > >         - In multi-thread(4T) write tests, ntfsplus show approximatel=
y
> > >           35~110% better performance.
> > >         - Read throughput is identical for both ntfs implementations.
> > >
> > >      1GB file      size:4096           size:16384           size:6553=
6
> > >      MB/sec   ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs=
3
> > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > >      read          399 | 399           426 | 424           429 | 430
> > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > >      write(1T)     291 | 276           325 | 305           333 | 317
> > >      write(4T)     105 | 50            113 | 78            114 | 99.6
> > >
> > >
> > >      * File list browsing performance. (about 12~14% faster)
> > >
> > >                   files:100000        files:200000        files:40000=
0
> > >      Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs=
3
> > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > >      ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.8=
6
> > >
> > >
> > >      * mount time.
> > >
> > >              parti_size:1TB      parti_size:2TB      parti_size:4TB
> > >      Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs=
3
> > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > >      mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51
> > >
> > >    The following are the reasons why ntfsplus performance is higher
> > >     compared to ntfs3:
> > >      - Use iomap aops.
> > >      - Delayed allocation support.
> > >      - Optimize zero out for newly allocated clusters.
> > >      - Optimize runlist merge overhead with small chunck size.
> > >      - pre-load mft(inode) blocks and index(dentry) blocks to improve
> > >        readdir + stat performance.
> > >      - Load lcn bitmap on background.
> > >
> > > - Stability improvement:
> > >    a. Pass more xfstests tests:
> > >       ntfsplus passed 287 tests, significantly higher than ntfs3's 21=
8.
> > >       ntfsplus implement fallocate, idmapped mount and permission, et=
c,
> > >       resulting in a significantly high number of xfstests passing co=
mpared
> > >       to ntfs3.
> > >    b. Bonnie++ issue[3]:
> > >       The Bonnie++ benchmark fails on ntfs3 with a "Directory not emp=
ty"
> > >       error during file deletion. ntfs3 currently iterates directory
> > >       entries by reading index blocks one by one. When entries are de=
leted
> > >       concurrently, index block merging or entry relocation can cause
> > >       readdir() to skip some entries, leaving files undeleted in
> > >       workloads(bonnie++) that mix unlink and directory scans.
> > >       ntfsplus implement leaf chain traversal in readdir to avoid ent=
ry skip
> > >       on deletion.
> > >
> > > - Journaling support:
> > >    ntfs3 does not provide full journaling support. It only implement =
journal
> > >    replay[4], which in our testing did not function correctly. My nex=
t task
> > >    after upstreaming will be to add full journal support to ntfsplus.
> > >
> > >
> > > The feature comparison summary
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Feature                               ntfsplus   ntfs3
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > Write support                         Yes        Yes
> > > iomap support                         Yes        No
> > > No buffer head                        Yes        No
> > > Public utilities(mkfs, fsck, etc.)    Yes        No
> > > xfstests passed                       287        218
> > > Idmapped mount                        Yes        No
> > > Delayed allocation                    Yes        No
> > > Bonnie++                              Pass       Fail
> > > Journaling                            Planned    Inoperative
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >
> > > References
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [1] https://en.wikipedia.org/wiki/NTFS
> > > [2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
> > > [3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHBoj=
4WwTy3Qe4Bqm6V0g@mail.gmail.com/
> > > [4] https://marc.info/?l=3Dlinux-fsdevel&m=3D161738417018673&q=3Dmbox
> > >
> > >
> > > Available in the Git repository at:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git ntf=
s-next
> > >
> > >
> > > v2:
> > >  - Add ntfs3-compatible mount options(sys_immutable, nohidden,
> > >    hide_dot_files, nocase, acl, windows_names, disable_sparse, discar=
d).
> > >  - Add iocharset mount option.
> > >  - Add ntfs3-compatible dos attribute and ntfs attribute load/store
> > >    in setxattr/getattr().
> > >  - Add support for FS_IOC_{GET,SET}FSLABEL ioctl.
> > >  - Add support for FITRIM ioctl.
> > >  - Fix the warnings(duplicate symbol, __divdi3, etc) from kernel test=
 robot.
> > >  - Prefix pr_xxx() with ntfsplus.
> > >  - Add support for $MFT File extension.
> > >  - Add Documentation/filesystems/ntfsplus.rst.
> > >  - Mark experimental.
> > >  - Remove BUG traps warnings from checkpatch.pl.
> > >
> > > Namjae Jeon (11):
> > >   ntfsplus: in-memory, on-disk structures and headers
> > >   ntfsplus: add super block operations
> > >   ntfsplus: add inode operations
> > >   ntfsplus: add directory operations
> > >   ntfsplus: add file operations
> > >   ntfsplus: add iomap and address space operations
> > >   ntfsplus: add attrib operatrions
> > >   ntfsplus: add runlist handling and cluster allocator
> > >   ntfsplus: add reparse and ea operations
> > >   ntfsplus: add misc operations
> > >   ntfsplus: add Kconfig and Makefile
> > >
> > >  Documentation/filesystems/index.rst    |    1 +
> > >  Documentation/filesystems/ntfsplus.rst |  199 +
> > >  fs/Kconfig                             |    1 +
> > >  fs/Makefile                            |    1 +
> > >  fs/ntfsplus/Kconfig                    |   45 +
> > >  fs/ntfsplus/Makefile                   |   18 +
> > >  fs/ntfsplus/aops.c                     |  617 +++
> > >  fs/ntfsplus/aops.h                     |   92 +
> > >  fs/ntfsplus/attrib.c                   | 5377 ++++++++++++++++++++++=
++
> > >  fs/ntfsplus/attrib.h                   |  159 +
> > >  fs/ntfsplus/attrlist.c                 |  285 ++
> > >  fs/ntfsplus/attrlist.h                 |   21 +
> > >  fs/ntfsplus/bitmap.c                   |  290 ++
> > >  fs/ntfsplus/bitmap.h                   |   93 +
> > >  fs/ntfsplus/collate.c                  |  178 +
> > >  fs/ntfsplus/collate.h                  |   37 +
> > >  fs/ntfsplus/compress.c                 | 1564 +++++++
> > >  fs/ntfsplus/dir.c                      | 1230 ++++++
> > >  fs/ntfsplus/dir.h                      |   33 +
> > >  fs/ntfsplus/ea.c                       |  931 ++++
> > >  fs/ntfsplus/ea.h                       |   25 +
> > >  fs/ntfsplus/file.c                     | 1142 +++++
> > >  fs/ntfsplus/index.c                    | 2112 ++++++++++
> > >  fs/ntfsplus/index.h                    |  127 +
> > >  fs/ntfsplus/inode.c                    | 3729 ++++++++++++++++
> > >  fs/ntfsplus/inode.h                    |  353 ++
> > >  fs/ntfsplus/layout.h                   | 2288 ++++++++++
> > >  fs/ntfsplus/lcnalloc.c                 | 1012 +++++
> > >  fs/ntfsplus/lcnalloc.h                 |  127 +
> > >  fs/ntfsplus/logfile.c                  |  770 ++++
> > >  fs/ntfsplus/logfile.h                  |  316 ++
> > >  fs/ntfsplus/mft.c                      | 2698 ++++++++++++
> > >  fs/ntfsplus/mft.h                      |   92 +
> > >  fs/ntfsplus/misc.c                     |  213 +
> > >  fs/ntfsplus/misc.h                     |  218 +
> > >  fs/ntfsplus/mst.c                      |  195 +
> > >  fs/ntfsplus/namei.c                    | 1677 ++++++++
> > >  fs/ntfsplus/ntfs.h                     |  180 +
> > >  fs/ntfsplus/ntfs_iomap.c               |  700 +++
> > >  fs/ntfsplus/ntfs_iomap.h               |   22 +
> > >  fs/ntfsplus/reparse.c                  |  550 +++
> > >  fs/ntfsplus/reparse.h                  |   15 +
> > >  fs/ntfsplus/runlist.c                  | 1983 +++++++++
> > >  fs/ntfsplus/runlist.h                  |   91 +
> > >  fs/ntfsplus/super.c                    | 2865 +++++++++++++
> > >  fs/ntfsplus/unistr.c                   |  473 +++
> > >  fs/ntfsplus/upcase.c                   |   73 +
> > >  fs/ntfsplus/volume.h                   |  254 ++
> > >  include/uapi/linux/ntfs.h              |   23 +
> > >  49 files changed, 35495 insertions(+)
> > >  create mode 100644 Documentation/filesystems/ntfsplus.rst
> > >  create mode 100644 fs/ntfsplus/Kconfig
> > >  create mode 100644 fs/ntfsplus/Makefile
> > >  create mode 100644 fs/ntfsplus/aops.c
> > >  create mode 100644 fs/ntfsplus/aops.h
> > >  create mode 100644 fs/ntfsplus/attrib.c
> > >  create mode 100644 fs/ntfsplus/attrib.h
> > >  create mode 100644 fs/ntfsplus/attrlist.c
> > >  create mode 100644 fs/ntfsplus/attrlist.h
> > >  create mode 100644 fs/ntfsplus/bitmap.c
> > >  create mode 100644 fs/ntfsplus/bitmap.h
> > >  create mode 100644 fs/ntfsplus/collate.c
> > >  create mode 100644 fs/ntfsplus/collate.h
> > >  create mode 100644 fs/ntfsplus/compress.c
> > >  create mode 100644 fs/ntfsplus/dir.c
> > >  create mode 100644 fs/ntfsplus/dir.h
> > >  create mode 100644 fs/ntfsplus/ea.c
> > >  create mode 100644 fs/ntfsplus/ea.h
> > >  create mode 100644 fs/ntfsplus/file.c
> > >  create mode 100644 fs/ntfsplus/index.c
> > >  create mode 100644 fs/ntfsplus/index.h
> > >  create mode 100644 fs/ntfsplus/inode.c
> > >  create mode 100644 fs/ntfsplus/inode.h
> > >  create mode 100644 fs/ntfsplus/layout.h
> > >  create mode 100644 fs/ntfsplus/lcnalloc.c
> > >  create mode 100644 fs/ntfsplus/lcnalloc.h
> > >  create mode 100644 fs/ntfsplus/logfile.c
> > >  create mode 100644 fs/ntfsplus/logfile.h
> > >  create mode 100644 fs/ntfsplus/mft.c
> > >  create mode 100644 fs/ntfsplus/mft.h
> > >  create mode 100644 fs/ntfsplus/misc.c
> > >  create mode 100644 fs/ntfsplus/misc.h
> > >  create mode 100644 fs/ntfsplus/mst.c
> > >  create mode 100644 fs/ntfsplus/namei.c
> > >  create mode 100644 fs/ntfsplus/ntfs.h
> > >  create mode 100644 fs/ntfsplus/ntfs_iomap.c
> > >  create mode 100644 fs/ntfsplus/ntfs_iomap.h
> > >  create mode 100644 fs/ntfsplus/reparse.c
> > >  create mode 100644 fs/ntfsplus/reparse.h
> > >  create mode 100644 fs/ntfsplus/runlist.c
> > >  create mode 100644 fs/ntfsplus/runlist.h
> > >  create mode 100644 fs/ntfsplus/super.c
> > >  create mode 100644 fs/ntfsplus/unistr.c
> > >  create mode 100644 fs/ntfsplus/upcase.c
> > >  create mode 100644 fs/ntfsplus/volume.h
> > >  create mode 100644 include/uapi/linux/ntfs.h
> > >
> > > --
> > > 2.25.1
> > >

