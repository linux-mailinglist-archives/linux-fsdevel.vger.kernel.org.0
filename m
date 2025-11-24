Return-Path: <linux-fsdevel+bounces-69710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71BC824A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 20:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 862374E8B7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DBA323416;
	Mon, 24 Nov 2025 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5hN0JFP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFVEnn8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89D2DC79B
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011949; cv=none; b=qf3nYGfpHnJ1vBbnwndWJjjka3iy6vT+1X/nJj6SClunDOjTqb5mw/ty5ADPtY/C5KnTwagnNHjpiyXrAS4GoZCfHVXF7zG+uYwoMMi7Zaz0syErNJ6lCtciOE3RbxQr0lo4QWxBkB+Uw/9C+GJr+Pm34nw9H8Jz9fFtK28p86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011949; c=relaxed/simple;
	bh=vBm7RLM6wfIISpfen117+q2SCMHRC4UzDYuNT0quLCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMlsfKsL4GpAmLEYUS0v3T+cVRBjCX3kyCCxT+4GM9Jv/erYvPx/zPPwttXMzcHfiwAvMswG28Kflt1Sd0QUy8geKqOEUO1fuQp5Ec++wDmc0dQEMqraCPE8eqlYRMxQZl8FdGGzo7+vUDO7bqs9GjAm/jtC2dy3u17jgoCAvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5hN0JFP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFVEnn8I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764011944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnp71hbfNCi8S/QOQBBkmu7q5kBfrRZEv9t85gsvOl8=;
	b=U5hN0JFPQLNgk636n4d2vUJkFR10Qn5+G7+9mernymf7deyVCtYfgUOyZU5qcZEhOb3v6H
	eVFMI62pKqtUvwglsLboMcAp6P+FSZGHTYZaRqw7Ca/eJvgRh47nKrO8a2/Y7PttFvyprW
	rDuT5uLSyZQs2DS9KnIgF/dbCxY+zZI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ej9i1uDINjGFLRwQ-QV7Dg-1; Mon, 24 Nov 2025 14:19:01 -0500
X-MC-Unique: ej9i1uDINjGFLRwQ-QV7Dg-1
X-Mimecast-MFC-AGG-ID: ej9i1uDINjGFLRwQ-QV7Dg_1764011940
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3436e9e3569so9819051a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764011940; x=1764616740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnp71hbfNCi8S/QOQBBkmu7q5kBfrRZEv9t85gsvOl8=;
        b=SFVEnn8IuIJDTuXFf0mGIb6NSJxM70Bx7t4ph0ugzekK4A5xNsbBnPhO7Te/E/kXr+
         J/fkIGKuEYNtu68BLq3CgSRvRk1K0B4B4R9Idd9BJVuMkmQMv5oQD2CImVAFXOcMJC4Q
         W/IM9D4TX9sS2EzKVYPenN9VbE4WGFZHHMyGZqL0QQgdi6b+vtrwTvquAd1xcQAxbHhP
         4VIjYWjAcPpT7bwAXjeEO19dNrFwtTkn6qacFvOBAvXmHxUoYsIVq9kvity+l9gZWyc4
         6hol4jdKMOOa4EZdt8GvjyaRA0OaKl33lxErRSb7Td01I3zuYjprZl6ij5roDoF5p2Lk
         mLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764011940; x=1764616740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qnp71hbfNCi8S/QOQBBkmu7q5kBfrRZEv9t85gsvOl8=;
        b=l5ofsiHLi643KQpUyKQFdFubS/A93ApF8J0SHfMAO34W7CPzpov3hUOxH1nRrl7ho5
         DlMVl+lDvglr9XAdpzXUqGugCxpXT1huc/LxwULow7u1ZRNZOPiLuSuU4OnBFQcqYvla
         u3V3BqO9R9j3Rm+L4RYPfRFuMtYrVEUfaGSlRNEAx+H1YlMuyIwvg2g/6T7XyAeVWofB
         GjrBNd6fUdeqIqnAo7p31vQCUzKKRexfHW6oCV3jzEi4ZhAZ7Z1gUgLT4SWHwVcRA4cM
         0zBRLEmD6CRVr0EzMZ/GSJnnOnmhsWzY0NH7agVvF/RL/YUFtjwqMpc8QfwWA22wJ6S6
         HglA==
X-Forwarded-Encrypted: i=1; AJvYcCVAGaaaLv6QmqZRbXJsFe3VEAq9WEIeYHk2MjvU9fVjFEB6owZp7x8qj4S+qtbLMZNpZXIYQfZ3OeEgZuUZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzFikqPVuwX8atkVpjkJ8rpkks7xxd9WHxhhVuH/gDMBRgyuMg+
	h83g7AR7UAkNJadMLXY2S5eItN4ihIQndhO2JAB8XeY0NsBc8ynanIESW4YnzXWlnRIhL5OI1YW
	mDHM1DeXYxD+FDkIRWj1IdSDL+J/nFt45sPp1BgZ2aIe4ydPU/MQsPoughT5l7QandVQlk8+Cwr
	3luIm4zXgTELMu8Nozry4h5uSfVOkIYz9QrcBDmFMy
X-Gm-Gg: ASbGncvE1zadnxgH3DhJYoxFagEi+Ppi2rqGDsgfX5HsHsFktqSbLfxPsv3uAc+WNnY
	7k44GWg+v8z5+irVuBRzzyc3bhwtHC4+gRMEgkbiCSF3/sx/TmYMz04m+z45tAV8kSdx5XsfhON
	OfWeRj7tTC9M8AqCXV4xO285/nqgKr1VPF0vKH6AVqRR45U1s4a90iyJ3B2bfohFpjlLhqaAO6W
	H1yFM3Zn48hR0/6izABQoTofQ==
X-Received: by 2002:a17:90b:2d4c:b0:33b:dbdc:65f2 with SMTP id 98e67ed59e1d1-34733f0fee5mr12667741a91.22.1764011940222;
        Mon, 24 Nov 2025 11:19:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbfNicAQk0rLUqvPiVav6SHWDsaxqgxNifyYZ0+rC3DRE0m36GZIS+vOY1kMJTXoqBK8ejaiJvuGavZRuTQc8=
X-Received: by 2002:a17:90b:2d4c:b0:33b:dbdc:65f2 with SMTP id
 98e67ed59e1d1-34733f0fee5mr12667715a91.22.1764011939684; Mon, 24 Nov 2025
 11:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119193745.595930-2-slava@dubeyko.com> <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com> <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com> <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
 <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com>
In-Reply-To: <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com>
From: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Date: Tue, 25 Nov 2025 00:48:48 +0530
X-Gm-Features: AWmQ_bnJUKOQJVwLZam_DvpnhSZCmxYxt30ahcwm8I4Qk5_1Dq7DoOWz41pBXdo
Message-ID: <CAPgWtC7AvW994O38x4gA7LW9gX+hd1htzjnjJ8xn-tJgP2a8WA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 1:47=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Thu, 2025-11-20 at 19:50 +0530, Kotresh Hiremath Ravishankar wrote:
> > Hi All,
> >
> > I think the patch is necessary and fixes the crash. There is no harm
> > in taking this patch as it behaves like an old kernel with this
> > particular scenario.
> >
> > When does the issue happen:
> >    - The issue happens only when the old mount syntax is used where
> > passing the file system name is optional in which case, it chooses the
> > default mds namespace but doesn't get filled in the
> > mdsc->fsc->mount_options->mds_namespace.
> >    - Along with the above, the mount user should be non admin.
> > Does it break the earlier fix ?
> >    - Not fully!!! Though the open does succeed, the subsequent
> > operation like write would get EPERM. I am not exactly able to
> > recollect but this was discussed before writing the fix 22c73d52a6d0
> > ("ceph: fix multifs mds auth caps issue"), it's guarded by another
> > check before actual operation like write.
> >
> > I think there are a couple of options to fix this cleanly.
> >  1. Use the default fsname when
> > mdsc->fsc->mount_options->mds_namespace is NULL during comparison.
> >  2. Mandate passing the fsname with old syntax ?
> >
>
> Anyway, we should be ready operate correctly if fsname or/and auth-
> >match.fs_name are NULL. And if we need to make the fix more cleanly, the=
n we
> can introduce another patch with nicer fix.
>
> I am not completely sure how default fsname can be applicable here. If I
> understood the CephFS mount logic correctly, then fsname can be NULL duri=
ng some
> initial steps. But, finally, we will have the real fsname for comparison.=
 But I
> don't know if it's right of assuming that fsname =3D=3D NULL is equal to =
fsname =3D=3D
> default_name.

We are pretty sure fsname is NULL only if the old mount syntax is used
without providing the
fsname in the optional arg. I believe kclient knows the fsname that's
mounted somewhere in this case ?
I am not sure though. If so, it can be used. If not, then can we rely
on what mds sends as part
of the mdsmap?

With this fix, did the tests run fine ? Aren't you hitting this error
https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mdsmap.c#L365
?

>
> And I am not sure that we can mandate anyone to use the old syntax. If th=
ere is
> some other opportunity, then someone could use it. But, maybe, I am missi=
ng the
> point. :) What do you mean by "Mandate passing the fsname with old syntax=
"?

In the old mount syntax, the fsname is passed as on optional argument
using 'mds_namespace'.
I was suggesting to mandate it if possible. But I guess it breaks
backward compatibility.

>
> Thanks,
> Slava.
>
> >
> > Thanks,
> > Kotresh H R
> >
> >
> >
> > On Thu, Nov 20, 2025 at 4:47=E2=80=AFAM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Wed, 2025-11-19 at 15:02 -0800, Gregory Farnum wrote:
> > > >
> > > > That doesn=E2=80=99t sound right =E2=80=94 this is authentication c=
ode. If the authorization is supplied for a namespace and we are mounting w=
ithout a namespace at all, isn=E2=80=99t that a jailbreak? So the NULL poin=
ter should be accepted in one direction, but denied in the other?
> > >
> > > What is your particular suggestion? I am simply fixing the kernel cra=
sh after
> > > the 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"). We didn't=
 have any
> > > check before. Do you imply that 22c73d52a6d0 ("ceph: fix multifs mds =
auth caps
> > > issue") fix is incorrect and we need to rework it somehow?
> > >
> > > If we will not have any fix, then 6.18 release will have broken CephF=
S kernel
> > > client.
> > >
> > > Thanks,
> > > Slava.
> > >
> > > >
> > > > On Wed, Nov 19, 2025 at 2:54=E2=80=AFPM Viacheslav Dubeyko <Slava.D=
ubeyko@ibm.com> wrote:
> > > > > On Wed, 2025-11-19 at 23:40 +0100, Ilya Dryomov wrote:
> > > > > > On Wed, Nov 19, 2025 at 8:38=E2=80=AFPM Viacheslav Dubeyko <sla=
va@dubeyko.com> wrote:
> > > > > > >
> > > > > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > >
> > > > > > > The CephFS kernel client has regression starting from 6.18-rc=
1.
> > > > > > >
> > > > > > > sudo ./check -g quick
> > > > > > > FSTYP         -- ceph
> > > > > > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP P=
REEMPT_DYNAMIC Fri
> > > > > > > Nov 14 11:26:14 PST 2025
> > > > > > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > > > > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.2=
13:3300:/scratch
> > > > > > > /mnt/cephfs/scratch
> > > > > > >
> > > > > > > Killed
> > > > > > >
> > > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon=
0
> > > > > > > (2)192.168.1.213:3300 session established
> > > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: cli=
ent167616
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel =
NULL pointer
> > > > > > > dereference, address: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervi=
sor read access in
> > > > > > > kernel mode
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_c=
ode(0x0000) - not-
> > > > > > > present page
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: =
0000 [#1] SMP KASAN
> > > > > > > NOPTI
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: =
0 PID: 3453 Comm:
> > > > > > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware nam=
e: QEMU Standard PC
> > > > > > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:st=
rcmp+0x1c/0x40
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 =
90 90 90 90 90 90
> > > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 0=
0 90 48 83 c0 01 84
> > > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31=
 f6 31 ff c3 cc cc
> > > > > > > cc cc 31
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ff=
ff8881536875c0
> > > > > > > EFLAGS: 00010246
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000=
000000000 RBX:
> > > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000=
000000063 RSI:
> > > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff888=
1536876a8 R08:
> > > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000=
000000000 R11:
> > > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff888=
1061d0000 R14:
> > > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a=
85c082840(0000)
> > > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS=
: 0000 ES: 0000
> > > > > > > CR0: 0000000080050033
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000=
000000000 CR3:
> > > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 555555=
54
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > > > > > ceph_mds_check_access+0x348/0x1760
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > > > > > __kasan_check_write+0x14/0x30
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_g=
et+0xb1/0x170
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0=
x322/0xef0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_cep=
h_open+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > > > > > __pfx_apparmor_file_open+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > > > > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_o=
pen+0x7bf/0x10e0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_cep=
h_open+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x=
6d/0x450
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+=
0xec/0x370
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat=
+0x2017/0x50a0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_pat=
h_openat+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > > > > > __pfx_stack_trace_save+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > > > > > stack_depot_save_flags+0x28/0x8f0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_dep=
ot_save+0xe/0x20
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_ope=
n+0x1b4/0x450
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > > > > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_=
filp_open+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_ob=
ject+0x13d/0x2b0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > > > > > __check_object_size+0x453/0x600
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin=
_unlock+0xe/0x40
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_open=
at2+0xe6/0x180
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > > > > > __pfx_do_sys_openat2+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_o=
penat+0x108/0x240
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > > > > > __pfx___x64_sys_openat+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > > > > > __pfx___handle_mm_fault+0x10/0x10
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_cal=
l+0x134f/0x2350
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_=
64+0x82/0xd50
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscal=
l_64+0xba/0xd50
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_c=
heck_read+0x11/0x20
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > > > > > count_memcg_events+0x25b/0x400
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm=
_fault+0x38b/0x6a0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_c=
heck_read+0x11/0x20
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > > > > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_=
exit+0x43/0x50
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_=
fault+0x95/0x100
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x=
74a85bf145ab
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 =
00 41 00 3d 00 00
> > > > > > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 8=
9 ee bf 9c ff ff ff
> > > > > > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48=
 8b 54 24 28 64 48
> > > > > > > 2b 14 25
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00=
007ffc77d316d0
> > > > > > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: fffffff=
fffffffda RBX:
> > > > > > > 0000000000000002 RCX: 000074a85bf145ab
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000=
000000000 RSI:
> > > > > > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ff=
c77d32789 R08:
> > > > > > > 00007ffc77d31980 R09: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000=
000000000 R11:
> > > > > > > 0000000000000246 R12: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 0000000=
0ffffffff R14:
> > > > > > > 0000000000000180 R15: 0000000000000001
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules link=
ed in:
> > > > > > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_commo=
n intel_pmc_core
> > > > > > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemet=
ry intel_vsec
> > > > > > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_=
intel aesni_intel
> > > > > > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_=
smbus vgastate
> > > > > > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr pa=
rport_pc ppdev lp
> > > > > > > parport efi_pstore
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000=
000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end tra=
ce 0000000000000000
> > > > > > > ]---
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:st=
rcmp+0x1c/0x40
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 =
90 90 90 90 90 90
> > > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 0=
0 90 48 83 c0 01 84
> > > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31=
 f6 31 ff c3 cc cc
> > > > > > > cc cc 31
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ff=
ff8881536875c0
> > > > > > > EFLAGS: 00010246
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000=
000000000 RBX:
> > > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000=
000000063 RSI:
> > > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff888=
1536876a8 R08:
> > > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000=
000000000 R11:
> > > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff888=
1061d0000 R14:
> > > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a=
85c082840(0000)
> > > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS=
: 0000 ES: 0000
> > > > > > > CR0: 0000000080050033
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000=
000000000 CR3:
> > > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 555555=
54
> > > > > > >
> > > > > > > We have issue here [1] if fs_name =3D=3D NULL:
> > > > > > >
> > > > > > > const char fs_name =3D mdsc->fsc->mount_options->mds_namespac=
e;
> > > > > > >      ...
> > > > > > >      if (auth->match.fs_name && strcmp(auth->match.fs_name, f=
s_name)) {
> > > > > > >              / fsname mismatch, try next one */
> > > > > > >              return 0;
> > > > > > >      }
> > > > > > >
> > > > > > > The patch fixes the issue by introducing is_fsname_mismatch()=
 method
> > > > > > > that checks auth->match.fs_name and fs_name pointers validity=
, and
> > > > > > > compares the file system names.
> > > > > > >
> > > > > > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph=
/mds_client.c#L5666
> > > > > > >
> > > > > > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > > > > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > > > > > cc: Alex Markuze <amarkuze@redhat.com>
> > > > > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > > > > > ---
> > > > > > >   fs/ceph/mds_client.c | 20 +++++++++++++++++---
> > > > > > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > > > > index 1740047aef0f..19c75e206300 100644
> > > > > > > --- a/fs/ceph/mds_client.c
> > > > > > > +++ b/fs/ceph/mds_client.c
> > > > > > > @@ -5647,6 +5647,22 @@ void send_flush_mdlog(struct ceph_mds_=
session *s)
> > > > > > >          mutex_unlock(&s->s_mutex);
> > > > > > >   }
> > > > > > >
> > > > > > > +static inline
> > > > > > > +bool is_fsname_mismatch(struct ceph_client *cl,
> > > > > > > +                       const char *fs_name1, const char *fs_=
name2)
> > > > > > > +{
> > > > > > > +       if (!fs_name1 || !fs_name2)
> > > > > > > +               return false;
> > > > > >
> > > > > > Hi Slava,
> > > > > >
> > > > > > It looks like this would declare a match (return false for "mis=
match")
> > > > > > in case ceph_mds_cap_auth is defined to require a particular fs=
_name but
> > > > > > no mds_namespace was passed on mount.  Is that the desired beha=
vior?
> > > > > >
> > > > >
> > > > > Hi Ilya,
> > > > >
> > > > > Before 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"), we=
 had no such
> > > > > check in the logic of ceph_mds_auth_match(). So, if auth->match.f=
s_name or
> > > > > fs_name is NULL, then we cannot say that they match or not. It me=
ans that we
> > > > > need to continue logic, this is why is_fsname_mismatch() returns =
false.
> > > > > Otherwise, if we stop logic by returning true, then we have bunch=
 of xfstests
> > > > > failures.
> > > > >
> > > > > Thanks,
> > > > > Slava.
> > > > >
> > > > > > > +
> > > > > > > +       doutc(cl, "fsname check fs_name1=3D%s fs_name2=3D%s\n=
",
> > > > > > > +             fs_name1, fs_name2);
> > > > > > > +
> > > > > > > +       if (strcmp(fs_name1, fs_name2))
> > > > > > > +               return true;
> > > > > > > +
> > > > > > > +       return false;
> > > > > > > +}
> > > > > > > +
> > > > > > >   static int ceph_mds_auth_match(struct ceph_mds_client *mdsc=
,
> > > > > > >                                 struct ceph_mds_cap_auth *aut=
h,
> > > > > > >                                 const struct cred *cred,
> > > > > > > @@ -5661,9 +5677,7 @@ static int ceph_mds_auth_match(struct c=
eph_mds_client *mdsc,
> > > > > > >          u32 gid, tlen, len;
> > > > > > >          int i, j;
> > > > > > >
> > > > > > > -       doutc(cl, "fsname check fs_name=3D%s  match.fs_name=
=3D%s\n",
> > > > > > > -             fs_name, auth->match.fs_name ? auth->match.fs_n=
ame : "");
> > > > > > > -       if (auth->match.fs_name && strcmp(auth->match.fs_name=
, fs_name)) {
> > > > > > > +       if (is_fsname_mismatch(cl, auth->match.fs_name, fs_na=
me)) {
> > > > > > >                  /* fsname mismatch, try next one */
> > > > > > >                  return 0;
> > > > > > >          }
> > > > > > > --
> > > > > > > 2.51.1
> > > > > > >
> > > > >
> > >
>


