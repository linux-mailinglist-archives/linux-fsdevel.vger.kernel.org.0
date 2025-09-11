Return-Path: <linux-fsdevel+bounces-60955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD13B536D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 17:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DD71C86408
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145B31578A;
	Thu, 11 Sep 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR43asb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717A7494;
	Thu, 11 Sep 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602926; cv=none; b=rCRwYcb2NHaH6q1Fws6jTMVOVFjGAPvk/h5g6BsEOKxhVvaxXAmlVmTcMh8JmUdsJweV+sXN20vRoDpANG+gCJF4GYpg0LwKe+BffFt9TlHESGdTyZvTKO3F7yS8chh+NcXTHgsPWEAMzZ9Y2mHlGsrgc9YcJH9STsE/63zqN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602926; c=relaxed/simple;
	bh=GJ3vineynPoT02RkTG0XTPaAtfP9PT824AwXYZTkSEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkaXhf64ifJG7m2GDJPHRcaNffDTGmhEhbOCYQGBwJUngAuA8zgB/hJnvzcaDghnZDRLRs9cJB5eK5omL1pCEBfPt17cc9MDJPR3sCAet3Ud+3YKSoUQKylxhJGMlwYrvYQ+3dzAKESfIGJZSkjv5QtLvSUH8e6QDrcuphzxym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR43asb3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so1034777a12.2;
        Thu, 11 Sep 2025 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757602923; x=1758207723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qayikoGYTOQVRYpvyO2ygr4vCmVM8+xJ0viJMtnrUL4=;
        b=gR43asb3S/EZ/gAlOuKVQPkk3ZC40qesetAEfJKB1qK2ZQbsatx7igXmuep7TJXX6o
         tIfwb8CsWdxhZn5+pz5G00e/ZZqn1ngvrJXHG13X/nDYtZ34kuZ+UJ8jmQG6KLL9OpnX
         UoL5c1PJClilBOTzCo/6xk4aihTgFGzeAlSXZ5nKaEIgUnVL+ThK3Y3sxIW/O/vaA3Ux
         Si+UHE/l83zd9wEpj9Wo511GK4QjE2jYUJMEO/zsLnUQ/ecH4o0KTwbQWtIweJOgIC8U
         frWCU849lMQ8212m+k7vHHYHS/L7rH5rmfnlNMTROupJxHZpH5OE7bhLjsFtcJnvP3Fy
         q/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602923; x=1758207723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qayikoGYTOQVRYpvyO2ygr4vCmVM8+xJ0viJMtnrUL4=;
        b=vdsF+Zo7axutOx/8fBMD5SDYW/NcYxCyz4Nd5CC9aj3QCYcB/Ra/hkq1bmnM/q8uVc
         0aOqWLl4sPTqNBGPIN6qnxkbZyEaIntq0Dj0PR1RWfTO8cVGbBcIvW52KlyENGM7P04F
         OiGUMd5wR1KLTMtd8v0tltgO+bWBKIS6Hl5AtpbhW82bl5lKdiLqidNbnz5Vr203AdWL
         vEikJL1jWpL6pvNP7B7b0JdqSI19TTRh/oVxR1pr0M3tju0PmipTh8zLpnqMJbpKH0J5
         rEj8fIdZ5s43qz+pOwtTqWy7C4WvLq9tptybzMe8NOTdvnkmQJYUyYChEuB7TBJlHryS
         yR/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMqXEFYrdJZrw40UrjGXN3MLSplGhFZnj6kdJYiV0ebj1fQf85DAnNSqSwC94JdeYQfgPL1MYgQJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwblCtOvMiBiceZ/MQ/RZNc7iPrV4B6Q9sD7f/qY1Kv9qnEFfz
	XluF5RJPWB/V0yHODvIRnbHq38brSxRnZJppm8Z3J//zX32672bHnMXBHjOS2mKrDtO6kPYWtmV
	pOKj23bcKH9ersGEE2ehKRHMwd+Ltsg==
X-Gm-Gg: ASbGncuxlpXRgzb/R6LIeupXWEUaybG/Nokp2gJfY/PW9Z956FnjdmtOfr5+/c76UKk
	kzvRKoLLtXZYuCtuU4ORzqQOrl5yiwMzDNmbM1rL7t2w86cFgwAitSRLzjl8cNF9fGrgKA5uGyh
	ilPBc369bg4/+dquBYo5AktXcEeAw3ic5yWBY2koGrZYs0B9ptxrZVdbLAscO33Ix4AKgtse+YM
	nGj7/yxRqy+SK/YTLfQtiuxwTn80zXH4ZcwnKo=
X-Google-Smtp-Source: AGHT+IG560PopTddfTVjJ8XpJbypvhFCWQs/t8z9KvYLyu/S7/8N4sMN8XH78k69/RvmZ0Oyz3fwJ6qavvAvbXTZ5L0=
X-Received: by 2002:a17:907:6d0d:b0:b04:315c:8760 with SMTP id
 a640c23a62f3a-b04b1709f61mr1811004866b.50.1757602922455; Thu, 11 Sep 2025
 08:02:02 -0700 (PDT)
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
 <CAM5tNy7w71r6WgWOz4tXtLi=yvw55t_5dFe_x-13Thy5NgjEGA@mail.gmail.com> <CALXu0Uep=q9mu1suZ0r04MGJn-xRn2twiRtQbGgtr1eZ7D_6sg@mail.gmail.com>
In-Reply-To: <CALXu0Uep=q9mu1suZ0r04MGJn-xRn2twiRtQbGgtr1eZ7D_6sg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 11 Sep 2025 08:01:51 -0700
X-Gm-Features: AS18NWDU9JZwG9due3rXJq2BquiqzldZ4nQYH6Qxcx17T4rDAh7VrHXiodCfXxQ
Message-ID: <CAM5tNy5=k9_5GsZkbV225ZmMw7S38o30Zt3RDoBC8UKcoxYGbg@mail.gmail.com>
Subject: Re: fattr4_archive "deprecated" ? Re: NFSv4.x export options to mark
 export as case-insensitive, case-preserving? Re: LInux NFSv4.1 client and
 server- case insensitive filesystems supported?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:08=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
> On Wed, 10 Sept 2025 at 15:38, Rick Macklem <rick.macklem@gmail.com> wrot=
e:
> >
> > On Wed, Sep 10, 2025 at 3:47=E2=80=AFAM Roland Mainz <roland.mainz@nrub=
sig.org> wrote:
> > >
> > > On Tue, Sep 9, 2025 at 9:32=E2=80=AFPM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> > > >
> > > > On 9/9/25 12:33 PM, Cedric Blancher wrote:
> > > > > On Tue, 9 Sept 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com=
> wrote:
> > > > >>
> > > > >> On 9/9/25 12:06 PM, Cedric Blancher wrote:
> > > > >>> Due lack of a VFS interface and the urgend use case of needing =
to
> > > > >>> export a case-insensitive filesystem via NFSv4.x, could we plea=
se get
> > > > >>> two /etc/exports options, one setting the case-insensitive bool=
ean
> > > > >>> (true, false, get-default-from-fs) and one for case-preserving =
(true,
> > > > >>> false, get-default-from-fs)?
> > > > >>>
> > > > >>> So far LInux nfsd does the WRONG thing here, and exports even
> > > > >>> case-insensitive filesystems as case-sensitive. The Windows NFS=
v4.1
> > > > >>> server does it correctly.
> > > >
> > > > As always, I encourage you to, first, prototype in NFSD the hard-co=
ding
> > > > of these settings as returned to NFS clients to see if that does wh=
at
> > > > you really need with Linux-native file systems.
> > >
> > > If Cedric wants just case-insensitive mounts for a Windows NFSv4
> > > (Exceed, OpenText, ms-nfs41-client, ms-nfs42-client, ...), then the
> > > only thing needed is ext4fs or NTFS in case-insensitive mode, and tha=
t
> > > the Linux NFSv4.1 server sets FATTR4_WORD0_CASE_INSENSITIVE=3D=3Dtrue=
 and
> > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dtrue (for FAT
> > > FATTR4_WORD0_CASE_PRESERVING=3D=3Dfalse). Only applications using ADS
> > > (Alternate Data Streams) will not work, because the Linux NFS server
> > > does not support "OPENATTR"&co ops.
> > >
> > > If Cedric wants Windows home dirs:
> > > This is not working with the Linux NFSv4.1 server, because it must su=
pport:
> > > - FATTR4_WORD1_SYSTEM
> > > - FATTR4_WORD0_ARCHIVE
> > > - FATTR4_WORD0_HIDDEN
> > > - Full ACL support, the current draft POSIX-ACLs in Linux NFSv4.1
> > > server&&{ ext4fs, btrfs, xfs etc. } causes malfunctions in the Window=
s
> > > "New User" profile setup (and gets you a temporary profile in
> > > C:\Users\*.temp+lots of warnings and a note to log out immediately
> > > because your user profile dir has been "corrupted")
> > >
> > > Windows home dirs with NFSv4 only work so far with the
> > > Solaris&&Illumos NFS servers, and maybe the FreeBSD >=3D 14 NFS serve=
r
> > > (not tested yet).
> > I'll just note that the named attribute support (the windows client
> > folk like the name)
> > along with Hidden and System are in 15 only.
> > And Archive is not supported because it is listed as "deprecated" in th=
e RFC.
> > (If this case really needs it, someone should try to get it "undeprecat=
ed" on
> > nfsv4@ietf.org. I could add Archive easily. All of these are for ZFS on=
ly.
> > ZFS also knows case insensitive, although I have not tried it.)
>
> Who (name!) had the idea to declare fattr4_archive as "deprecated"? It
> was explicitly added for Windows and DOS compatibility in NFSv4, and
> unlike Windows EAs (which are depreciated, and were superseded by
> "named streams") the "archive" attribute is still in use.
I have no idea who would have done this, but here is the snippet from
RFC5661 (which started being edited in 2005 and was published in 2010,
so it has been like this for a long time). The same words are in RFC8881
and currently in the RFC8881bis draft. Can this be changed?
I'd say yes, but it will take time and effort on someone's part.
Posting to nfsv4@ietf.org, noting that this attribute is needed
by the Windows client (and at least a suggestion that time_backup
is not a satisfactory replacement) would be a good start.

5.8.2.1.  Attribute 14: archive

   TRUE, if this file has been archived since the time of last
   modification (deprecated in favor of time_backup).

The problem has been a serious lack of Windows expertise in the NFSv4
working group. Long ago (20+ years) the Hummingbird developers were
actively involved (Hummingbird became Open Network Solutions, which
became a division of OpenText, if I recall it correctly).

But there has been no one with Windows expertise involved more recently.

My suggestion (I'll repeat it) is to have someone participate in the Bakeat=
hon
testing events (the next one is in about one month and can be attended
remotely using a tailscale VPN). When someone tests at the event and
finds an issue, the server developers are there and can discussion what
it takes to fix it.

Also, participation on the nfsv4@ietf.org mailing list (some working group
members will not be reading this Linux list) and attendance at working
group meetings would help. (The working group meetings can
also be attended remotely and there is an automatic fee waiver for
remote attendance if you, like me, are not funded to do the work.)

With no involvement from people with Windows expertise, the testing
has become basically a bunch of servers being tested against by
various versions of the Linux client (with me being at outlier, testing
the FreeBSD client).

rick

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>

