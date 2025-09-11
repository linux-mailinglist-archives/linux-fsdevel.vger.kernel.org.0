Return-Path: <linux-fsdevel+bounces-60965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB08B538C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 18:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2813A64DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E6353365;
	Thu, 11 Sep 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/qmrX0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE432A821
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606967; cv=none; b=vCRhgDZmJHa3PSNBYrOTewzKUGo6F4ksctYadNBdXFzmxRr0So1pSaORM2KQ/HnE2G62xZN1MGeNlgjw3jpEWZ/zUYbzPKlyKP52ImulLLPcDJzEm0nmOTas/cDF/rUNrfiuqZUdMaXm1XPmHUBj7FJTv28np8LX1niJi8KIc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606967; c=relaxed/simple;
	bh=CBqNgo4KH+p9fH6qjtSCtI69mHPwAHipthlnWRYs8dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RFAFEeA5FKDB9yLcxeAAfdpTU3odJy1scCZLGkOYi49kU0cKbrQIG643DMNbBvx90lKWFlu8xPDnIELC2D1TqZuiAL2MOgcXjK4ctM0A4WwD4MvwhGQqHxdwWwmN5vLtA151iYxQVekno2A5GctIUYuJGIcz9jKV1PEvTZjH3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/qmrX0z; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccec59b4bso655605fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757606965; x=1758211765; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzFC/Ho3mFCRQiv8Fb7T80A5TSv6mikU2Z99IvPwzIQ=;
        b=a/qmrX0zgdbCWdCkS3POCCDfHubaltryaQx+PbKQPH8HNlXvHHhugVnVC8xUG5fPQo
         sBucvh7eZxUWROMLleUHs2dnRT8eNTXetWkDnovkS36Cp4hjGUoPF4ihoYaOZ3HE4rgl
         1aBUmgSiMxWMOavXY6jyaDfb7BAiLy995oyc3DV0vXRfxHZPUd1FBxJOvQ5BrKMJF38R
         nJ16zC4Ifmcsiwlfy38BwbDjiYrnjMZk4t2O1N0Oem3OOV/L6uXDa8NZBtipFEk+6U26
         9sYBXlHOlPkLIrjQGrH86BtG4Zh4hwzV3ZqpgPWFKLK0EH3bCA3oTg8Hfq7+yu4ngFal
         5JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606965; x=1758211765;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzFC/Ho3mFCRQiv8Fb7T80A5TSv6mikU2Z99IvPwzIQ=;
        b=oY2tUMrcml6vKZXYPr/T5rENp8t6VbzrigdNwINpWseAHaYrKx0fZYYbdxPbFNUA26
         OUgL4xNGcscFE4LvsbjxplVcd7Vz/gUbE9RoYeI0jKzqpXtRErF+MSHuKtL4TGzMTIxg
         i/NmwZ8PhDdV4aJEPDIVVHvYzsJkfKfSlq9Joqe8ZfI4QQa6eg+JF898IRTXNFq2QQyN
         jKsLKlMIT10WwF6KIYPXeXMBx30o1ElrygGlHAFZW0YSx0ylJUVafMECzb6EnEE1Bbno
         SFQ30AsIMC6ysAUih/zfgO02N66bkGOj9Xq5RiM84moGCPPPpcRUAyy2KrZsQFv95auX
         g2Ug==
X-Gm-Message-State: AOJu0Yx9GHLz7V4jmC9el72VSyy2WpdNI87N2vNGyDhkDnqHeKHSktJb
	uOZDvNSHVtGFSGHKkv53LF8VruVB9Iia2o3ArJJHrHGHLlMToP1p4r8NGsMTkRvvyzu3ryIiGLy
	Z3IfmwyACQZEFWuy3Cz29rbosiNs2aiLr9Q==
X-Gm-Gg: ASbGncuUnfSfyF1x2I3dhCTztFlfyolJc/k7/7jf1FA8Q5eKn6tTeYWMeZFpKHTQguE
	A8XgswCndfq0g9p6ykZlNC/R46OqulqmIjs/oKfitti1TBqUUS4D2N3xxhP0ykYxLo3SceZX3GN
	ymq4V0K21sfdOTCcYju1rDDSBHOfU4hKH9tUudULh2NYBn2JND6+hmVUU09W3V78Brrqhk8JOZ9
	S6y/4n9MLimk26TMA==
X-Google-Smtp-Source: AGHT+IHxyYwQh6GNytxL/VxJaCTBR3HMatdZ4Skd7lB1DkWR8Jik/BZGjYPAOkZT52KK+0UPUyYoyaZvVPD0MFlZeRw=
X-Received: by 2002:a05:6870:2e09:b0:314:9683:3759 with SMTP id
 586e51a60fabf-32265437abcmr9350132fac.50.1757606964792; Thu, 11 Sep 2025
 09:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com> <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com> <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
 <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com> <CALXu0Uc9WGU8QfKwuLHMvNrq3oAftV+41K5vbGSkDrbXJftbPw@mail.gmail.com>
 <47ece316-6ca6-4d5d-9826-08bb793a7361@oracle.com> <CAKAoaQ=RNxx4RpjdjTVUKOa+mg-=bJqb3d1wtLKMFL-dDaXgCA@mail.gmail.com>
 <CAM5tNy7w71r6WgWOz4tXtLi=yvw55t_5dFe_x-13Thy5NgjEGA@mail.gmail.com>
 <CALXu0Uep=q9mu1suZ0r04MGJn-xRn2twiRtQbGgtr1eZ7D_6sg@mail.gmail.com>
 <CAM5tNy5=k9_5GsZkbV225ZmMw7S38o30Zt3RDoBC8UKcoxYGbg@mail.gmail.com>
 <e0da383964e9f398854e70c51e15c02faaf009b9.camel@kernel.org>
 <CALXu0UcT1USQinz4qxDwhETdxRLJ1zCMRjw1iPExYES+qdJROA@mail.gmail.com> <CALXu0UchAhzimREouJpGoP9=3zKghb-WVuvFTX7Vj8J5Uj2o8Q@mail.gmail.com>
In-Reply-To: <CALXu0UchAhzimREouJpGoP9=3zKghb-WVuvFTX7Vj8J5Uj2o8Q@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 11 Sep 2025 18:08:48 +0200
X-Gm-Features: Ac12FXzh86WkM6XJmKMmOrQDU_Lwo8_aWjI91TM0DB92WnfXTpBOMiicGAVfwPg
Message-ID: <CALXu0UcBNgPrazhqOxqHA0WjQyx7jWa09k=rvnMBJM1ot1iHmg@mail.gmail.com>
Subject: Re: fattr4_archive "deprecated" ? Re: NFSv4.x export options to mark
 export as case-insensitive, case-preserving? Re: LInux NFSv4.1 client and
 server- case insensitive filesystems supported?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sept 2025 at 17:36, Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Thu, 11 Sept 2025 at 17:33, Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > On Thu, 11 Sept 2025 at 17:26, Trond Myklebust <trondmy@kernel.org> wro=
te:
> > >
> > > On Thu, 2025-09-11 at 08:01 -0700, Rick Macklem wrote:
> > > > On Thu, Sep 11, 2025 at 1:08=E2=80=AFAM Cedric Blancher
> > > > <cedric.blancher@gmail.com> wrote:
> > > > >
> > > > > CAUTION: This email originated from outside of the University of
> > > > > Guelph. Do not click links or open attachments unless you recogni=
ze
> > > > > the sender and know the content is safe. If in doubt, forward
> > > > > suspicious emails to IThelp@uoguelph.ca.
> > > > >
> > > > > On Wed, 10 Sept 2025 at 15:38, Rick Macklem
> > > > > <rick.macklem@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 10, 2025 at 3:47=E2=80=AFAM Roland Mainz
> > > > > > <roland.mainz@nrubsig.org> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 9, 2025 at 9:32=E2=80=AFPM Chuck Lever
> > > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > > >
> > > > > > > > On 9/9/25 12:33 PM, Cedric Blancher wrote:
> > > > > > > > > On Tue, 9 Sept 2025 at 18:12, Chuck Lever
> > > > > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On 9/9/25 12:06 PM, Cedric Blancher wrote:
> > > > > > > > > > > Due lack of a VFS interface and the urgend use case o=
f
> > > > > > > > > > > needing to
> > > > > > > > > > > export a case-insensitive filesystem via NFSv4.x, cou=
ld
> > > > > > > > > > > we please get
> > > > > > > > > > > two /etc/exports options, one setting the case-
> > > > > > > > > > > insensitive boolean
> > > > > > > > > > > (true, false, get-default-from-fs) and one for case-
> > > > > > > > > > > preserving (true,
> > > > > > > > > > > false, get-default-from-fs)?
> > > > > > > > > > >
> > > > > > > > > > > So far LInux nfsd does the WRONG thing here, and
> > > > > > > > > > > exports even
> > > > > > > > > > > case-insensitive filesystems as case-sensitive. The
> > > > > > > > > > > Windows NFSv4.1
> > > > > > > > > > > server does it correctly.
> > > > > > > >
> > > > > > > > As always, I encourage you to, first, prototype in NFSD the
> > > > > > > > hard-coding
> > > > > > > > of these settings as returned to NFS clients to see if that
> > > > > > > > does what
> > > > > > > > you really need with Linux-native file systems.
> > > > > > >
> > > > > > > If Cedric wants just case-insensitive mounts for a Windows
> > > > > > > NFSv4
> > > > > > > (Exceed, OpenText, ms-nfs41-client, ms-nfs42-client, ...), th=
en
> > > > > > > the
> > > > > > > only thing needed is ext4fs or NTFS in case-insensitive mode,
> > > > > > > and that
> > > > > > > the Linux NFSv4.1 server sets
> > > > > > > FATTR4_WORD0_CASE_INSENSITIVE=3D=3Dtrue and
> > > > > > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dtrue (for FAT
> > > > > > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dfalse). Only applications u=
sing
> > > > > > > ADS
> > > > > > > (Alternate Data Streams) will not work, because the Linux NFS
> > > > > > > server
> > > > > > > does not support "OPENATTR"&co ops.
> > > > > > >
> > > > > > > If Cedric wants Windows home dirs:
> > > > > > > This is not working with the Linux NFSv4.1 server, because it
> > > > > > > must support:
> > > > > > > - FATTR4_WORD1_SYSTEM
> > > > > > > - FATTR4_WORD0_ARCHIVE
> > > > > > > - FATTR4_WORD0_HIDDEN
> > > > > > > - Full ACL support, the current draft POSIX-ACLs in Linux
> > > > > > > NFSv4.1
> > > > > > > server&&{ ext4fs, btrfs, xfs etc. } causes malfunctions in th=
e
> > > > > > > Windows
> > > > > > > "New User" profile setup (and gets you a temporary profile in
> > > > > > > C:\Users\*.temp+lots of warnings and a note to log out
> > > > > > > immediately
> > > > > > > because your user profile dir has been "corrupted")
> > > > > > >
> > > > > > > Windows home dirs with NFSv4 only work so far with the
> > > > > > > Solaris&&Illumos NFS servers, and maybe the FreeBSD >=3D 14 N=
FS
> > > > > > > server
> > > > > > > (not tested yet).
> > > > > > I'll just note that the named attribute support (the windows
> > > > > > client
> > > > > > folk like the name)
> > > > > > along with Hidden and System are in 15 only.
> > > > > > And Archive is not supported because it is listed as "deprecate=
d"
> > > > > > in the RFC.
> > > > > > (If this case really needs it, someone should try to get it
> > > > > > "undeprecated" on
> > > > > > nfsv4@ietf.org. I could add Archive easily. All of these are fo=
r
> > > > > > ZFS only.
> > > > > > ZFS also knows case insensitive, although I have not tried it.)
> > > > >
> > > > > Who (name!) had the idea to declare fattr4_archive as "deprecated=
"?
> > > > > It
> > > > > was explicitly added for Windows and DOS compatibility in NFSv4,
> > > > > and
> > > > > unlike Windows EAs (which are depreciated, and were superseded by
> > > > > "named streams") the "archive" attribute is still in use.
> > > > I have no idea who would have done this, but here is the snippet fr=
om
> > > > RFC5661 (which started being edited in 2005 and was published in
> > > > 2010,
> > > > so it has been like this for a long time). The same words are in
> > > > RFC8881
> > > > and currently in the RFC8881bis draft. Can this be changed?
> > > > I'd say yes, but it will take time and effort on someone's part.
> > > > Posting to nfsv4@ietf.org, noting that this attribute is needed
> > > > by the Windows client (and at least a suggestion that time_backup
> > > > is not a satisfactory replacement) would be a good start.
> > > >
> > > > 5.8.2.1.  Attribute 14: archive
> > > >
> > > >    TRUE, if this file has been archived since the time of last
> > > >    modification (deprecated in favor of time_backup).
> > > >
> > > > The problem has been a serious lack of Windows expertise in the NFS=
v4
> > > > working group. Long ago (20+ years) the Hummingbird developers were
> > > > actively involved (Hummingbird became Open Network Solutions, which
> > > > became a division of OpenText, if I recall it correctly).
> > > >
> > > > But there has been no one with Windows expertise involved more
> > > > recently.
> > > >
> > > > My suggestion (I'll repeat it) is to have someone participate in th=
e
> > > > Bakeathon
> > > > testing events (the next one is in about one month and can be
> > > > attended
> > > > remotely using a tailscale VPN). When someone tests at the event an=
d
> > > > finds an issue, the server developers are there and can discussion
> > > > what
> > > > it takes to fix it.
> > > >
> > > > Also, participation on the nfsv4@ietf.org mailing list (some workin=
g
> > > > group
> > > > members will not be reading this Linux list) and attendance at
> > > > working
> > > > group meetings would help. (The working group meetings can
> > > > also be attended remotely and there is an automatic fee waiver for
> > > > remote attendance if you, like me, are not funded to do the work.)
> > > >
> > > > With no involvement from people with Windows expertise, the testing
> > > > has become basically a bunch of servers being tested against by
> > > > various versions of the Linux client (with me being at outlier,
> > > > testing
> > > > the FreeBSD client).
> > >
> > > As stated in the line you quote, it is listed as being deprecated in
> > > favour of the backup time because the latter provides a superset of t=
he
> > > same functionality: by comparing the value of the backup time to the
> > > value of the mtime, you can determine the value of the archive bit (i=
t
> > > is set if the backup time is newer than the mtime).
> > >
> > > In addition, the backup time also tells you exactly when the file was
> > > last backed up.
> > >
> > > So no, this is not about people who don't understand Windows. It's
> > > about repackaging the same functionality in a way that is more useful
> > > to people who understand backups.
> >
> > fattr4_archive was added long ago by SUN and CITI for NFS4, for
> > feature parity with SMB, and to accurately map Windows and DOS
> > features (the "A" flag). It cannot be replaced by a timestamp, because
> > neither Windows nor DOS have a "backup timestamp", except in
> > specialised software.
> > It might have made sense from a Linux point of view, but that
> > literally disables the "archive" flag for Windows and DOS, with
> > chaotic consequences. An additional "backup timestamp" is nice, but in
> > this specific case it damages a platform.
>
> I hit <SEND> too early. The backup timestamp is fine, just declaring
> "fattr4_archive"

...as obsolete...

> is premature, unless Windows as a platform is
> considered no longer supported by IETF. But then NFS should be renamed
> to LFS (linux file system)

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

