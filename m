Return-Path: <linux-fsdevel+bounces-60962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4FB537F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 17:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBAB3B0D21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892A343D7A;
	Thu, 11 Sep 2025 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8vwenvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9151DBB3A;
	Thu, 11 Sep 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605012; cv=none; b=eEvZQkw67ZFVg5ursmE7RAmhiRxu2uEUfgX1VcvhY7AD9XIq95qh3NrF1BZ4bLXkTilD18c364hDd+HLMG8Y+8VxmTOSUHALkeE2Qf44BNxa3yp8mnwh7Yn9BRyMOtRKWt5QUJ/TpaCKmzgB6FAmoc32vFsriM82ahZJWbY8dZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605012; c=relaxed/simple;
	bh=6aW37z9zA8qxgcUQgVdLrm9CrZ/swlo3T72/3rGKB7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nKRh+J3f6z/aVweT5v2IGEqVIJ/pvAWb1SM5hN5tlCp1dwg/rJFjI3uktpvPMHWbqOoIdx/2JUcklurKftPG8kqQMXGp+HdwBJ8EWN2gGtlbh277ni0tLtk/JfCYYSBPVTxuJcRJtKcXba2tThV/7ZKuiaiMQbzSvcGq4PCNtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8vwenvr; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6218a8a852cso176843eaf.3;
        Thu, 11 Sep 2025 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757605009; x=1758209809; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLuAkF6lIP8qqtnMtMJ+HN2hyPYZJyNPo1zT1WwIBVs=;
        b=U8vwenvrZzZKZThF8wub0wNHqn4BdCYKjbkrfU+1DmnA5E9vhWMi73CUFQCS48qrTo
         Zptlm4QhJ4GRKM0JXgwG7VG5yONuUm7wdN8lWgzYkG1JomJhI6fhQaGO7qMYYh6eqOLU
         1amBXyIuYZ6eL8Ik0Xb4Zh2fCnq6+lXDzbDv2yZ/5o9R1f3rYPXc2mdSXmQ7dAZqSIxl
         fJhiErP7JjAwwsOMseSu/4obXIhSHVWS/3WKcOpKjyUKE+gA9+3XmTEmbTzij43lu9CN
         ES3WSGGVvxqfgwyf3xV8DQ2JHiaLU1Kfgzi4Ao+cNoAmszHM+b2iBs60dLFPKvpqA0kw
         kExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605009; x=1758209809;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLuAkF6lIP8qqtnMtMJ+HN2hyPYZJyNPo1zT1WwIBVs=;
        b=BmN5RdW1UM2SxcPcjl6YCJ12k38lLDpSqkljk7utkThLlZFsdZrODwsF6Rft3wJcP5
         HnY05kcbYGMi+xMnKtfWjG5/Ji1fAl7glrR5oKfbLAXKIjnmXuBD8f4q2Hw5lUBob4Rd
         iYe1eUER0WjHf+98FQS+uCQOuG67OEFygaFabbhsRvO4sFksEtw7E2Id3QVxARmQYTl9
         XUsLMj9RxR/FgONUq0hYvIin0W0nUBV9gQXgemAaRCgBSaw+UhiVCy+0LqyDOOT7fFvp
         wY075Fz087drxs8O8z4/MtCr2w9UcFpdSYCGb1bQDJYgkd72iSAQk14y/xZPVA7acJ+u
         49Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWOb48wDY6UuQz/5GGp6U4hWljjFbbox9AGab70qGiS3iQFmmsmeBCBbDdziultyaudknuH7qz788E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0RcImbfhq7ycIH+Ql3RfUHMG+xN3d5OeOYzml4/0QnYtXGgm
	Pomap5V6vbeacBnIP0rB9iLl1RCjn3w7qE9GVEFVNvv1tUN5VFL8mV3AFqZZR17sk6VSpKH0cch
	jJ50KXXVOHcOtzyuP+QU4cwGNt3pixYiQXg==
X-Gm-Gg: ASbGncuKmPFDQKSI+0GkLmSj5JtcNGfd5cdD3jY6h/X4veVhKbPgv7LAasfZ7uQZR7Y
	RZR0baM4efBJS4xwpZdg5TSgGN2SiUKpX5sZWAKan/OTUe4qNjilLQHNgMMVuzeYy7u4IUbJsLl
	fivLyGs2l5IwqZhKkn9TWW0pmJFUbbYVJ39TdoELUULM6iCj4thG6yAk9/Vya/inn5v042gj/Uq
	jBrxVdcrzyKiRAiN/3K3qY7vGHc
X-Google-Smtp-Source: AGHT+IHX/+80m5nmjI7MIZ2fnac0XJxNAdPreeN9+Uuyjo79dLZS0LGtNIlleMjmpPGJZvaX4kp7GxnNAXgbh6kPIo8=
X-Received: by 2002:a05:6870:e391:b0:322:5c2d:58c9 with SMTP id
 586e51a60fabf-32264e1f1a7mr8251987fac.24.1757605009189; Thu, 11 Sep 2025
 08:36:49 -0700 (PDT)
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
 <e0da383964e9f398854e70c51e15c02faaf009b9.camel@kernel.org> <CALXu0UcT1USQinz4qxDwhETdxRLJ1zCMRjw1iPExYES+qdJROA@mail.gmail.com>
In-Reply-To: <CALXu0UcT1USQinz4qxDwhETdxRLJ1zCMRjw1iPExYES+qdJROA@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 11 Sep 2025 17:36:13 +0200
X-Gm-Features: Ac12FXxfKIDuHXI6lOi5EuKSPeLUPdyQDTHs8ChzItp4ggTFfofAimQlK3p_uts
Message-ID: <CALXu0UchAhzimREouJpGoP9=3zKghb-WVuvFTX7Vj8J5Uj2o8Q@mail.gmail.com>
Subject: Re: fattr4_archive "deprecated" ? Re: NFSv4.x export options to mark
 export as case-insensitive, case-preserving? Re: LInux NFSv4.1 client and
 server- case insensitive filesystems supported?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sept 2025 at 17:33, Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Thu, 11 Sept 2025 at 17:26, Trond Myklebust <trondmy@kernel.org> wrote=
:
> >
> > On Thu, 2025-09-11 at 08:01 -0700, Rick Macklem wrote:
> > > On Thu, Sep 11, 2025 at 1:08=E2=80=AFAM Cedric Blancher
> > > <cedric.blancher@gmail.com> wrote:
> > > >
> > > > CAUTION: This email originated from outside of the University of
> > > > Guelph. Do not click links or open attachments unless you recognize
> > > > the sender and know the content is safe. If in doubt, forward
> > > > suspicious emails to IThelp@uoguelph.ca.
> > > >
> > > > On Wed, 10 Sept 2025 at 15:38, Rick Macklem
> > > > <rick.macklem@gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 10, 2025 at 3:47=E2=80=AFAM Roland Mainz
> > > > > <roland.mainz@nrubsig.org> wrote:
> > > > > >
> > > > > > On Tue, Sep 9, 2025 at 9:32=E2=80=AFPM Chuck Lever
> > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > >
> > > > > > > On 9/9/25 12:33 PM, Cedric Blancher wrote:
> > > > > > > > On Tue, 9 Sept 2025 at 18:12, Chuck Lever
> > > > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > > > >
> > > > > > > > > On 9/9/25 12:06 PM, Cedric Blancher wrote:
> > > > > > > > > > Due lack of a VFS interface and the urgend use case of
> > > > > > > > > > needing to
> > > > > > > > > > export a case-insensitive filesystem via NFSv4.x, could
> > > > > > > > > > we please get
> > > > > > > > > > two /etc/exports options, one setting the case-
> > > > > > > > > > insensitive boolean
> > > > > > > > > > (true, false, get-default-from-fs) and one for case-
> > > > > > > > > > preserving (true,
> > > > > > > > > > false, get-default-from-fs)?
> > > > > > > > > >
> > > > > > > > > > So far LInux nfsd does the WRONG thing here, and
> > > > > > > > > > exports even
> > > > > > > > > > case-insensitive filesystems as case-sensitive. The
> > > > > > > > > > Windows NFSv4.1
> > > > > > > > > > server does it correctly.
> > > > > > >
> > > > > > > As always, I encourage you to, first, prototype in NFSD the
> > > > > > > hard-coding
> > > > > > > of these settings as returned to NFS clients to see if that
> > > > > > > does what
> > > > > > > you really need with Linux-native file systems.
> > > > > >
> > > > > > If Cedric wants just case-insensitive mounts for a Windows
> > > > > > NFSv4
> > > > > > (Exceed, OpenText, ms-nfs41-client, ms-nfs42-client, ...), then
> > > > > > the
> > > > > > only thing needed is ext4fs or NTFS in case-insensitive mode,
> > > > > > and that
> > > > > > the Linux NFSv4.1 server sets
> > > > > > FATTR4_WORD0_CASE_INSENSITIVE=3D=3Dtrue and
> > > > > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dtrue (for FAT
> > > > > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dfalse). Only applications usi=
ng
> > > > > > ADS
> > > > > > (Alternate Data Streams) will not work, because the Linux NFS
> > > > > > server
> > > > > > does not support "OPENATTR"&co ops.
> > > > > >
> > > > > > If Cedric wants Windows home dirs:
> > > > > > This is not working with the Linux NFSv4.1 server, because it
> > > > > > must support:
> > > > > > - FATTR4_WORD1_SYSTEM
> > > > > > - FATTR4_WORD0_ARCHIVE
> > > > > > - FATTR4_WORD0_HIDDEN
> > > > > > - Full ACL support, the current draft POSIX-ACLs in Linux
> > > > > > NFSv4.1
> > > > > > server&&{ ext4fs, btrfs, xfs etc. } causes malfunctions in the
> > > > > > Windows
> > > > > > "New User" profile setup (and gets you a temporary profile in
> > > > > > C:\Users\*.temp+lots of warnings and a note to log out
> > > > > > immediately
> > > > > > because your user profile dir has been "corrupted")
> > > > > >
> > > > > > Windows home dirs with NFSv4 only work so far with the
> > > > > > Solaris&&Illumos NFS servers, and maybe the FreeBSD >=3D 14 NFS
> > > > > > server
> > > > > > (not tested yet).
> > > > > I'll just note that the named attribute support (the windows
> > > > > client
> > > > > folk like the name)
> > > > > along with Hidden and System are in 15 only.
> > > > > And Archive is not supported because it is listed as "deprecated"
> > > > > in the RFC.
> > > > > (If this case really needs it, someone should try to get it
> > > > > "undeprecated" on
> > > > > nfsv4@ietf.org. I could add Archive easily. All of these are for
> > > > > ZFS only.
> > > > > ZFS also knows case insensitive, although I have not tried it.)
> > > >
> > > > Who (name!) had the idea to declare fattr4_archive as "deprecated"?
> > > > It
> > > > was explicitly added for Windows and DOS compatibility in NFSv4,
> > > > and
> > > > unlike Windows EAs (which are depreciated, and were superseded by
> > > > "named streams") the "archive" attribute is still in use.
> > > I have no idea who would have done this, but here is the snippet from
> > > RFC5661 (which started being edited in 2005 and was published in
> > > 2010,
> > > so it has been like this for a long time). The same words are in
> > > RFC8881
> > > and currently in the RFC8881bis draft. Can this be changed?
> > > I'd say yes, but it will take time and effort on someone's part.
> > > Posting to nfsv4@ietf.org, noting that this attribute is needed
> > > by the Windows client (and at least a suggestion that time_backup
> > > is not a satisfactory replacement) would be a good start.
> > >
> > > 5.8.2.1.  Attribute 14: archive
> > >
> > >    TRUE, if this file has been archived since the time of last
> > >    modification (deprecated in favor of time_backup).
> > >
> > > The problem has been a serious lack of Windows expertise in the NFSv4
> > > working group. Long ago (20+ years) the Hummingbird developers were
> > > actively involved (Hummingbird became Open Network Solutions, which
> > > became a division of OpenText, if I recall it correctly).
> > >
> > > But there has been no one with Windows expertise involved more
> > > recently.
> > >
> > > My suggestion (I'll repeat it) is to have someone participate in the
> > > Bakeathon
> > > testing events (the next one is in about one month and can be
> > > attended
> > > remotely using a tailscale VPN). When someone tests at the event and
> > > finds an issue, the server developers are there and can discussion
> > > what
> > > it takes to fix it.
> > >
> > > Also, participation on the nfsv4@ietf.org mailing list (some working
> > > group
> > > members will not be reading this Linux list) and attendance at
> > > working
> > > group meetings would help. (The working group meetings can
> > > also be attended remotely and there is an automatic fee waiver for
> > > remote attendance if you, like me, are not funded to do the work.)
> > >
> > > With no involvement from people with Windows expertise, the testing
> > > has become basically a bunch of servers being tested against by
> > > various versions of the Linux client (with me being at outlier,
> > > testing
> > > the FreeBSD client).
> >
> > As stated in the line you quote, it is listed as being deprecated in
> > favour of the backup time because the latter provides a superset of the
> > same functionality: by comparing the value of the backup time to the
> > value of the mtime, you can determine the value of the archive bit (it
> > is set if the backup time is newer than the mtime).
> >
> > In addition, the backup time also tells you exactly when the file was
> > last backed up.
> >
> > So no, this is not about people who don't understand Windows. It's
> > about repackaging the same functionality in a way that is more useful
> > to people who understand backups.
>
> fattr4_archive was added long ago by SUN and CITI for NFS4, for
> feature parity with SMB, and to accurately map Windows and DOS
> features (the "A" flag). It cannot be replaced by a timestamp, because
> neither Windows nor DOS have a "backup timestamp", except in
> specialised software.
> It might have made sense from a Linux point of view, but that
> literally disables the "archive" flag for Windows and DOS, with
> chaotic consequences. An additional "backup timestamp" is nice, but in
> this specific case it damages a platform.

I hit <SEND> too early. The backup timestamp is fine, just declaring
"fattr4_archive" is premature, unless Windows as a platform is
considered no longer supported by IETF. But then NFS should be renamed
to LFS (linux file system)

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

