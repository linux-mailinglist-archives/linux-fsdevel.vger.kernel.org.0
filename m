Return-Path: <linux-fsdevel+bounces-70087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0EC90557
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 00:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B034F290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF832571F;
	Thu, 27 Nov 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky/pkOTY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA0327214
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764285306; cv=none; b=bMXbJSTjYYUqmYDnsIrjpufLGlF1rHapVb9HZq+sRO3pEzb+mLn4tXEz3pdARYQFY/7NfGFqzpTj9k4NxMh2MiUFBmCQ6c//UNzFfSb4lKPA6DYFDN8fqgG3H5ghEfZxgHbqfQ8fWyw/g29l6zHSu+q4AnVvSkOWZJGBaAhaqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764285306; c=relaxed/simple;
	bh=LI5+SWpmx+GiWAVExO1k6GOWnSC+uRriACDeFWqEfCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueP8JNxIHu/v5zCUj4iy46PPax8WtHzkOE3bF2RndU93B47EP/Ux4wdeBZYB6Lg7XXmUeztjGaEJvOP7A1lTDZTPXZf43piajPFFTd3VPzKpsHdfm0tkv0qM2FsMKbFqphO8ARNT3/Z913VzeJK0jF8lDb1D0Xor/IPN9gvyiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky/pkOTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62EDC4AF0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 23:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764285304;
	bh=LI5+SWpmx+GiWAVExO1k6GOWnSC+uRriACDeFWqEfCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ky/pkOTYy5tHcC4KzEN1Aj9X92VkpQG0kHQKK6s6MnJ+TZdBHvdoSn+FygE6mMJPs
	 p58KZYW4XjtDJQ+GsLqS51TDPC9itzwYBh/p4sUPIdXfyVoo7kmO/LXBrQHv7ay4qf
	 w2wjb/Dwuc0QskAZAFSQUM91FUJmgTBrq3+kJ/uhbSURt+qUa43MpJrwmxAsxwOlZX
	 5lHFj8M9zT0ngF6ZI9Ng/pPfQXv6FJoHBqFQ6ogVQwV9CRDKTq6B1DqJdVQ6gHCWJ5
	 UPuZMogrfHoBEnxCIv0lifhqS5w50FBannjuZ446Uzzhd/sx7t7HgmCNInZhYxYw7H
	 8ZkMEG8Jy4W8w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso2672785a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 15:15:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQrxk8mqHb9+lTJxWTOOVZfB14xJRw6OMCsJlOB/OhQudSufbkpr5nGIfLb6yoOCRDd7oteXO14EYMDe/H@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdz07bPYKzU0brg3l3Fd5xA2g6Sa5PEE5oTkEb10WNjrlMNGh
	mguN7ePqV0Z519LbV49ZNZN13OiiVl02ysOuW0P2+5P7Ahy3xnh3UTZ3F8z4ordvy88+9sSQ/qe
	QGSp3chGKNwQ0Xd4bq+IwMwlHjJ0akMc=
X-Google-Smtp-Source: AGHT+IHZIHlV8LR3UcliKD8clRmy/kyfHkDo3HcNZECLaW2P13urQQIlnlZs0ESm2c139KBTj0f2MYhcRopD363GNQs=
X-Received: by 2002:a05:6402:27c8:b0:634:b7a2:3eaf with SMTP id
 4fb4d7f45d1cf-64554664dd9mr24767712a12.18.1764285302143; Thu, 27 Nov 2025
 15:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <CAOQ4uxhfxeUJnatFJxuXgSdqkMykOw+q7KZTpWXb8K2tNZCPGg@mail.gmail.com>
 <CAKYAXd98388-=qOwa++aNuggKrJbOf24BMQZrvm6Gnjp_7qOTQ@mail.gmail.com> <CAOQ4uxg26jaY3vrUnWoB=NxHTkn2a8zSbtbQKd2w3Vp25wUxAw@mail.gmail.com>
In-Reply-To: <CAOQ4uxg26jaY3vrUnWoB=NxHTkn2a8zSbtbQKd2w3Vp25wUxAw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Nov 2025 08:14:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_CZHyhPKGvXXYVuGqUQqDJOurxF=m4DJG_ndknPuNSCQ@mail.gmail.com>
X-Gm-Features: AWmQ_blFgHyaYIOuu4jsspCHhjqJd_nY4tcwppuvLerQzTrSewyp5N5ZghOYa4E
Message-ID: <CAKYAXd_CZHyhPKGvXXYVuGqUQqDJOurxF=m4DJG_ndknPuNSCQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:16=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Nov 27, 2025 at 1:18=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > On Thu, Nov 27, 2025 at 8:10=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Thu, Nov 27, 2025 at 6:00=E2=80=AFAM Namjae Jeon <linkinjeon@kerne=
l.org> wrote:
> > > >
> > > > Introduction
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > The NTFS filesystem[1] still remains the default filesystem for Win=
dows
> > > > and The well-maintained NTFS driver in the Linux kernel enhances
> > > > interoperability with Windows devices, making it easier for Linux u=
sers
> > > > to work with NTFS-formatted drives. Currently, ntfs support in Linu=
x was
> > > > the long-neglected NTFS Classic (read-only), which has been removed=
 from
> > > > the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still =
has
> > > > many problems and is poorly maintained, so users and distributions =
are
> > > > still using the old legacy ntfs-3g.
> > >
> > Hi Amir,
> > > May I suggest that you add a patch to your series to add a deprecatio=
n
> > > message to ntfs3?
> > >
> > > See for example eb103a51640ee ("reiserfs: Deprecate reiserfs")
> > Okay, I'll add it in the next version, referring to this reiserfs patch=
.
> > >
>
> There is no need to refer to this patch, there is nothing special about i=
t.
> It's just an example for you of past deprecation procedures.
>
> Unlike resierfs, the deprecation warning and help text for ntfs3 should r=
efer
> users to the better in-tree alternative.
Okay, I will do that.
Thanks!
>
> Thanks,
> Amir.
>
> > > >
> > > >
> > > > What is ntfsplus?
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > The remade ntfs called ntfsplus is an implementation that supports =
write
> > > > and the essential requirements(iomap, no buffer-head, utilities, xf=
stests
> > > > test result) based on read-only classic NTFS.
> > > > The old read-only ntfs code is much cleaner, with extensive comment=
s,
> > > > offers readability that makes understanding NTFS easier. This is wh=
y
> > > > ntfsplus was developed on old read-only NTFS base.
> > > > The target is to provide current trends(iomap, no buffer head, foli=
o),
> > > > enhanced performance, stable maintenance, utility support including=
 fsck.
> > > >
> > >
> > > You are bringing back the old ntfs driver code from the dead, preserv=
ing the
> > > code and Copyrights and everything to bring it up to speed with moder=
n vfs
> > > API and to add super nice features. Right?
> > Yes.
> > >
> > > Apart from its history, the new refurbished ntfs driver is also fully=
 backward
> > > compact to the old read-only driver. Right?
> > Yes.
> > >
> > > Why is the rebranding to ntfsplus useful then?
> > >
> > > I can understand that you want a new name for a new ntfsprogs-plus pr=
oject
> > > which is a fork of ntfs-3g, but I don't think that the new name for t=
he kernel
> > > driver is useful or welcome.
> > Right, I wanted to rebrand ntfsprogs-plus and ntfsplus into a paired
> > set of names. Also, ntfs3 was already used as an alias for ntfs, so I
> > couldn't touch ntfs3 driver without consensus from the fs maintainers.
> > >
> > > Do you have any objections to leaving its original ntfs name?
> > I have no objection to using ntfsplus as an alias for ntfs if we add a
> > deprecation message to ntfs3.
> > >
> > > You can also do:
> > > MODULE_ALIAS_FS("ntfs");
> > > MODULE_ALIAS_FS("ntfsplus");
> > I will add this in the next version with ntfs3 deprecation patch.
> > >
> > > If that is useful for ntfsprogs-plus somehow.
> > That is very useful and thanks for your review!
> > >
> > > Thanks,
> > > Amir.
> > >
> > > >
> > > > Key Features
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > - Write support:
> > > >    Implement write support on classic read-only NTFS. Additionally,
> > > >    integrate delayed allocation to enhance write performance throug=
h
> > > >    multi-cluster allocation and minimized fragmentation of cluster =
bitmap.
> > > >
> > > > - Switch to using iomap:
> > > >    Use iomap for buffered IO writes, reads, direct IO, file extent =
mapping,
> > > >    readpages, writepages operations.
> > > >
> > > > - Stop using the buffer head:
> > > >    The use of buffer head in old ntfs and switched to use folio ins=
tead.
> > > >    As a result, CONFIG_BUFFER_HEAD option enable is removed in Kcon=
fig also.
> > > >
> > > > - Public utilities include fsck[2]:
> > > >    While ntfs-3g includes ntfsprogs as a component, it notably lack=
s
> > > >    the fsck implementation. So we have launched a new ntfs utilitii=
es
> > > >    project called ntfsprogs-plus by forking from ntfs-3g after remo=
ving
> > > >    unnecessary ntfs fuse implementation. fsck.ntfs can be used for =
ntfs
> > > >    testing with xfstests as well as for recovering corrupted NTFS d=
evice.
> > > >
> > > > - Performance Enhancements:
> > > >
> > > >    - ntfsplus vs. ntfs3:
> > > >
> > > >      * Performance was benchmarked using iozone with various chunk =
size.
> > > >         - In single-thread(1T) write tests, ntfsplus show approxima=
tely
> > > >           3~5% better performance.
> > > >         - In multi-thread(4T) write tests, ntfsplus show approximat=
ely
> > > >           35~110% better performance.
> > > >         - Read throughput is identical for both ntfs implementation=
s.
> > > >
> > > >      1GB file      size:4096           size:16384           size:65=
536
> > > >      MB/sec   ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | nt=
fs3
> > > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > > >      read          399 | 399           426 | 424           429 | 43=
0
> > > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > > >      write(1T)     291 | 276           325 | 305           333 | 31=
7
> > > >      write(4T)     105 | 50            113 | 78            114 | 99=
.6
> > > >
> > > >
> > > >      * File list browsing performance. (about 12~14% faster)
> > > >
> > > >                   files:100000        files:200000        files:400=
000
> > > >      Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | nt=
fs3
> > > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > > >      ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32=
.86
> > > >
> > > >
> > > >      * mount time.
> > > >
> > > >              parti_size:1TB      parti_size:2TB      parti_size:4TB
> > > >      Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | nt=
fs3
> > > >      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > > >      mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.=
51
> > > >
> > > >    The following are the reasons why ntfsplus performance is higher
> > > >     compared to ntfs3:
> > > >      - Use iomap aops.
> > > >      - Delayed allocation support.
> > > >      - Optimize zero out for newly allocated clusters.
> > > >      - Optimize runlist merge overhead with small chunck size.
> > > >      - pre-load mft(inode) blocks and index(dentry) blocks to impro=
ve
> > > >        readdir + stat performance.
> > > >      - Load lcn bitmap on background.
> > > >
> > > > - Stability improvement:
> > > >    a. Pass more xfstests tests:
> > > >       ntfsplus passed 287 tests, significantly higher than ntfs3's =
218.
> > > >       ntfsplus implement fallocate, idmapped mount and permission, =
etc,
> > > >       resulting in a significantly high number of xfstests passing =
compared
> > > >       to ntfs3.
> > > >    b. Bonnie++ issue[3]:
> > > >       The Bonnie++ benchmark fails on ntfs3 with a "Directory not e=
mpty"
> > > >       error during file deletion. ntfs3 currently iterates director=
y
> > > >       entries by reading index blocks one by one. When entries are =
deleted
> > > >       concurrently, index block merging or entry relocation can cau=
se
> > > >       readdir() to skip some entries, leaving files undeleted in
> > > >       workloads(bonnie++) that mix unlink and directory scans.
> > > >       ntfsplus implement leaf chain traversal in readdir to avoid e=
ntry skip
> > > >       on deletion.
> > > >
> > > > - Journaling support:
> > > >    ntfs3 does not provide full journaling support. It only implemen=
t journal
> > > >    replay[4], which in our testing did not function correctly. My n=
ext task
> > > >    after upstreaming will be to add full journal support to ntfsplu=
s.
> > > >
> > > >
> > > > The feature comparison summary
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Feature                               ntfsplus   ntfs3
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Write support                         Yes        Yes
> > > > iomap support                         Yes        No
> > > > No buffer head                        Yes        No
> > > > Public utilities(mkfs, fsck, etc.)    Yes        No
> > > > xfstests passed                       287        218
> > > > Idmapped mount                        Yes        No
> > > > Delayed allocation                    Yes        No
> > > > Bonnie++                              Pass       Fail
> > > > Journaling                            Planned    Inoperative
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >
> > > > References
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [1] https://en.wikipedia.org/wiki/NTFS
> > > > [2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
> > > > [3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHB=
oj4WwTy3Qe4Bqm6V0g@mail.gmail.com/
> > > > [4] https://marc.info/?l=3Dlinux-fsdevel&m=3D161738417018673&q=3Dmb=
ox
> > > >
> > > >
> > > > Available in the Git repository at:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git n=
tfs-next
> > > >
> > > >
> > > > v2:
> > > >  - Add ntfs3-compatible mount options(sys_immutable, nohidden,
> > > >    hide_dot_files, nocase, acl, windows_names, disable_sparse, disc=
ard).
> > > >  - Add iocharset mount option.
> > > >  - Add ntfs3-compatible dos attribute and ntfs attribute load/store
> > > >    in setxattr/getattr().
> > > >  - Add support for FS_IOC_{GET,SET}FSLABEL ioctl.
> > > >  - Add support for FITRIM ioctl.
> > > >  - Fix the warnings(duplicate symbol, __divdi3, etc) from kernel te=
st robot.
> > > >  - Prefix pr_xxx() with ntfsplus.
> > > >  - Add support for $MFT File extension.
> > > >  - Add Documentation/filesystems/ntfsplus.rst.
> > > >  - Mark experimental.
> > > >  - Remove BUG traps warnings from checkpatch.pl.
> > > >
> > > > Namjae Jeon (11):
> > > >   ntfsplus: in-memory, on-disk structures and headers
> > > >   ntfsplus: add super block operations
> > > >   ntfsplus: add inode operations
> > > >   ntfsplus: add directory operations
> > > >   ntfsplus: add file operations
> > > >   ntfsplus: add iomap and address space operations
> > > >   ntfsplus: add attrib operatrions
> > > >   ntfsplus: add runlist handling and cluster allocator
> > > >   ntfsplus: add reparse and ea operations
> > > >   ntfsplus: add misc operations
> > > >   ntfsplus: add Kconfig and Makefile
> > > >
> > > >  Documentation/filesystems/index.rst    |    1 +
> > > >  Documentation/filesystems/ntfsplus.rst |  199 +
> > > >  fs/Kconfig                             |    1 +
> > > >  fs/Makefile                            |    1 +
> > > >  fs/ntfsplus/Kconfig                    |   45 +
> > > >  fs/ntfsplus/Makefile                   |   18 +
> > > >  fs/ntfsplus/aops.c                     |  617 +++
> > > >  fs/ntfsplus/aops.h                     |   92 +
> > > >  fs/ntfsplus/attrib.c                   | 5377 ++++++++++++++++++++=
++++
> > > >  fs/ntfsplus/attrib.h                   |  159 +
> > > >  fs/ntfsplus/attrlist.c                 |  285 ++
> > > >  fs/ntfsplus/attrlist.h                 |   21 +
> > > >  fs/ntfsplus/bitmap.c                   |  290 ++
> > > >  fs/ntfsplus/bitmap.h                   |   93 +
> > > >  fs/ntfsplus/collate.c                  |  178 +
> > > >  fs/ntfsplus/collate.h                  |   37 +
> > > >  fs/ntfsplus/compress.c                 | 1564 +++++++
> > > >  fs/ntfsplus/dir.c                      | 1230 ++++++
> > > >  fs/ntfsplus/dir.h                      |   33 +
> > > >  fs/ntfsplus/ea.c                       |  931 ++++
> > > >  fs/ntfsplus/ea.h                       |   25 +
> > > >  fs/ntfsplus/file.c                     | 1142 +++++
> > > >  fs/ntfsplus/index.c                    | 2112 ++++++++++
> > > >  fs/ntfsplus/index.h                    |  127 +
> > > >  fs/ntfsplus/inode.c                    | 3729 ++++++++++++++++
> > > >  fs/ntfsplus/inode.h                    |  353 ++
> > > >  fs/ntfsplus/layout.h                   | 2288 ++++++++++
> > > >  fs/ntfsplus/lcnalloc.c                 | 1012 +++++
> > > >  fs/ntfsplus/lcnalloc.h                 |  127 +
> > > >  fs/ntfsplus/logfile.c                  |  770 ++++
> > > >  fs/ntfsplus/logfile.h                  |  316 ++
> > > >  fs/ntfsplus/mft.c                      | 2698 ++++++++++++
> > > >  fs/ntfsplus/mft.h                      |   92 +
> > > >  fs/ntfsplus/misc.c                     |  213 +
> > > >  fs/ntfsplus/misc.h                     |  218 +
> > > >  fs/ntfsplus/mst.c                      |  195 +
> > > >  fs/ntfsplus/namei.c                    | 1677 ++++++++
> > > >  fs/ntfsplus/ntfs.h                     |  180 +
> > > >  fs/ntfsplus/ntfs_iomap.c               |  700 +++
> > > >  fs/ntfsplus/ntfs_iomap.h               |   22 +
> > > >  fs/ntfsplus/reparse.c                  |  550 +++
> > > >  fs/ntfsplus/reparse.h                  |   15 +
> > > >  fs/ntfsplus/runlist.c                  | 1983 +++++++++
> > > >  fs/ntfsplus/runlist.h                  |   91 +
> > > >  fs/ntfsplus/super.c                    | 2865 +++++++++++++
> > > >  fs/ntfsplus/unistr.c                   |  473 +++
> > > >  fs/ntfsplus/upcase.c                   |   73 +
> > > >  fs/ntfsplus/volume.h                   |  254 ++
> > > >  include/uapi/linux/ntfs.h              |   23 +
> > > >  49 files changed, 35495 insertions(+)
> > > >  create mode 100644 Documentation/filesystems/ntfsplus.rst
> > > >  create mode 100644 fs/ntfsplus/Kconfig
> > > >  create mode 100644 fs/ntfsplus/Makefile
> > > >  create mode 100644 fs/ntfsplus/aops.c
> > > >  create mode 100644 fs/ntfsplus/aops.h
> > > >  create mode 100644 fs/ntfsplus/attrib.c
> > > >  create mode 100644 fs/ntfsplus/attrib.h
> > > >  create mode 100644 fs/ntfsplus/attrlist.c
> > > >  create mode 100644 fs/ntfsplus/attrlist.h
> > > >  create mode 100644 fs/ntfsplus/bitmap.c
> > > >  create mode 100644 fs/ntfsplus/bitmap.h
> > > >  create mode 100644 fs/ntfsplus/collate.c
> > > >  create mode 100644 fs/ntfsplus/collate.h
> > > >  create mode 100644 fs/ntfsplus/compress.c
> > > >  create mode 100644 fs/ntfsplus/dir.c
> > > >  create mode 100644 fs/ntfsplus/dir.h
> > > >  create mode 100644 fs/ntfsplus/ea.c
> > > >  create mode 100644 fs/ntfsplus/ea.h
> > > >  create mode 100644 fs/ntfsplus/file.c
> > > >  create mode 100644 fs/ntfsplus/index.c
> > > >  create mode 100644 fs/ntfsplus/index.h
> > > >  create mode 100644 fs/ntfsplus/inode.c
> > > >  create mode 100644 fs/ntfsplus/inode.h
> > > >  create mode 100644 fs/ntfsplus/layout.h
> > > >  create mode 100644 fs/ntfsplus/lcnalloc.c
> > > >  create mode 100644 fs/ntfsplus/lcnalloc.h
> > > >  create mode 100644 fs/ntfsplus/logfile.c
> > > >  create mode 100644 fs/ntfsplus/logfile.h
> > > >  create mode 100644 fs/ntfsplus/mft.c
> > > >  create mode 100644 fs/ntfsplus/mft.h
> > > >  create mode 100644 fs/ntfsplus/misc.c
> > > >  create mode 100644 fs/ntfsplus/misc.h
> > > >  create mode 100644 fs/ntfsplus/mst.c
> > > >  create mode 100644 fs/ntfsplus/namei.c
> > > >  create mode 100644 fs/ntfsplus/ntfs.h
> > > >  create mode 100644 fs/ntfsplus/ntfs_iomap.c
> > > >  create mode 100644 fs/ntfsplus/ntfs_iomap.h
> > > >  create mode 100644 fs/ntfsplus/reparse.c
> > > >  create mode 100644 fs/ntfsplus/reparse.h
> > > >  create mode 100644 fs/ntfsplus/runlist.c
> > > >  create mode 100644 fs/ntfsplus/runlist.h
> > > >  create mode 100644 fs/ntfsplus/super.c
> > > >  create mode 100644 fs/ntfsplus/unistr.c
> > > >  create mode 100644 fs/ntfsplus/upcase.c
> > > >  create mode 100644 fs/ntfsplus/volume.h
> > > >  create mode 100644 include/uapi/linux/ntfs.h
> > > >
> > > > --
> > > > 2.25.1
> > > >

