Return-Path: <linux-fsdevel+bounces-14408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83C87C128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042DA1F229A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732CC73521;
	Thu, 14 Mar 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loHsxWyI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE07350F
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433308; cv=none; b=Wft7NozTGmMAhrZbT2zNS9uFP3A+jd45lToqOzVjjK7mjslbBCLU1NscU0m2FW9qb0jq7018c5diuymCyEFecOeG5kzSsRT6JQUd1bLfHZ/HV9qv4t7rVpDYk57hBrISAJqucp3HEcZpEXBTVGJcAG26iYQRofWdZTxfnGgmYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433308; c=relaxed/simple;
	bh=E0WHFlMETLpSJSDGXdITboRvbijf17hs+2XRjfCgCQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMdKR4/v/WgQbGqG+s6kldXngDMZnoZHwTkqdJLT/7inEIoHnVs2XbniLI2aE0PF6h93ahTv/zm0hpnIEtBWDhKP373PMx+oDmjGbZGTOeIxHYEm6u9ger7eIL5ksv7NeCZYY3nT/ewpSRzB9yHNKn+tffJ4p6R7UDssn/BCyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loHsxWyI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1deddb82b43so108975ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710433306; x=1711038106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ68UZwVcoWaT5D2Sog/IJyxkieGnJ4JStLD6iUO2SQ=;
        b=loHsxWyI5rYBPfLr2X1p0iPzcorW/aB+toK85giHSy5pD+hmyieamsfZJHqPRefrq/
         kLxna13JZXs0LHUzJryzU21XqB34e9Tsy2wuWxtyBghou70MtUUWQdfhqsKw/4GzdtOG
         rthXUj7+fiL+s2687tf68let7TuSF1MEGDVJSqZmSULeuCGF3dtpGlaxHR13U3h1Oe3f
         VWK36uTtkqC8/ghVJxXhcOsbJaMVqja/RtN6qxy82wqz9jt69b4A5CEvHGQl9mNKwWyh
         RvgpBOtjGp1rUEeu24K2E/Ub9roc8UM5tjeOVGxdWCi9I6UgfB4yQtPgDlgrwVVHauxW
         a3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710433306; x=1711038106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ68UZwVcoWaT5D2Sog/IJyxkieGnJ4JStLD6iUO2SQ=;
        b=WGGeOzaT02TLcCAYcKGVIhYBvbWAsPzLTxM32z4P12e41Ra53bY+ieWTFcyYv1lxgj
         3mt7hL6N1WE1MErQMsVKtAOIgdcfs2UrCxW9LK4NskkxNEMQAmslCkgsR/pITiFNQA6V
         cqihrdCKKo3ieuqIzssufWWByYlCN5YvxWbwNA3BCyJyjXIWvF0u77Mz03j3IiOidLd1
         YLyGYwtBLTWzcydBTHTWLCAD7e9HVGRO+HUdaqAZa4oGShXVB+0oz19mFMO8cCvkQ41I
         fco8dpFt7bU+4q/60uSgqqOSE58kuv/dsGnA/BYyS42L7dXdBc+hBrYYJE/MTzbgLAWB
         lfgA==
X-Forwarded-Encrypted: i=1; AJvYcCWb42bdlAzUXZYzx1aqNF1rLj8rgGqV/v3uyXByzZzc5U4BUtmVRbxEozioVT+pEWxNMPAXTFYvWsjcKcnzOm5fuXilLBeFUO1tUJkZWQ==
X-Gm-Message-State: AOJu0YxhaVmV+ucfv3S8fNVdFr0XYACnP2fWU3q7EySjqDd8eg7/GHeo
	Pia1yl68u0cElaPOF8mqijUbEmVndMnR0WG7yyQTNGbmUqXtPklm9NPl11PwgjBuI1DFD1Tmobp
	kiCyC0JbfiUU2X1HCTfDvFIck2Qc9sziQyAnS
X-Google-Smtp-Source: AGHT+IHH2Lvd0tJOnHJFMQBaGzTPMOuj5AlLMG9JVooxFFvkJa2rETmzm5H2FdQWDUGSrgJtHn6EzEC+i9SwF8/NTac=
X-Received: by 2002:a17:903:2449:b0:1dd:7800:94e1 with SMTP id
 l9-20020a170903244900b001dd780094e1mr236440pls.14.1710433306354; Thu, 14 Mar
 2024 09:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fcfb4a05ffe48213@google.com> <0000000000009e1b00060ea5df51@google.com>
 <20240111092147.ywwuk4vopsml3plk@quack3> <bbeeb617-6730-4159-80b1-182841925cce@I-love.SAKURA.ne.jp>
 <20240314155417.aysvaktvvqxc34zb@quack3>
In-Reply-To: <20240314155417.aysvaktvvqxc34zb@quack3>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 14 Mar 2024 17:21:30 +0100
Message-ID: <CANp29Y6uevNW1SmXi_5muEeruP0TVh9Y9xwhgKO==J3fh8oa=w@mail.gmail.com>
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	brauner@kernel.org, jmorris@namei.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Yes, the CONFIG_BLK_DEV_WRITE_MOUNTED=3Dn change did indeed break our C
executor code (and therefore our C reproducers). I posted a fix[1]
soon afterwards, but the problem is that syzbot will keep on using old
reproducers for old bugs. Syzkaller descriptions change over time, so
during bisection and patch testing we have to use the exact syzkaller
revision that detected the original bug. All older syzkaller revisions
now neither find nor reproduce fs bugs on newer Linux kernel revisions
with CONFIG_BLK_DEV_WRITE_MOUNTED=3Dn.

If the stream of such bisection results is already bothering you and
other fs people, a very quick fix could be to ban this commit from the
possible bisection results (it's just a one line change in the syzbot
config). Then such bugs would just get gradually obsoleted by syzbot
without any noise.

[1] https://github.com/google/syzkaller/commit/551587c192ecb4df26fcdab775ed=
145ee69c07d4

--=20
Aleksandr

On Thu, Mar 14, 2024 at 4:54=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 10-03-24 09:52:01, Tetsuo Handa wrote:
> > On 2024/01/11 18:21, Jan Kara wrote:
> > > On Wed 10-01-24 22:44:04, syzbot wrote:
> > >> syzbot suspects this issue was fixed by commit:
> > >>
> > >> commit 6f861765464f43a71462d52026fbddfc858239a5
> > >> Author: Jan Kara <jack@suse.cz>
> > >> Date:   Wed Nov 1 17:43:10 2023 +0000
> > >>
> > >>     fs: Block writes to mounted block devices
> > >>
> > >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15135=
c0be80000
> > >> start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://=
git.ke..
> > >> git tree:       upstream
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7406f415=
f386e786
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D28aaddd5a3=
221d7fd709
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17b5bb=
80a80000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10193ee7=
280000
> > >>
> > >> If the result looks correct, please mark the issue as fixed by reply=
ing with:
> > >
> > > Makes some sense since fs cannot be corrupted by anybody while it is
> > > mounted. I just don't see how the reproducer would be corrupting the
> > > image... Still probably:
> > >
> > > #syz fix: fs: Block writes to mounted block devices
> > >
> > > and we'll see if syzbot can find new ways to tickle some similar prob=
lem.
> > >
> > >                                                             Honza
> >
> > Since the reproducer is doing open(O_RDWR) before switching loop device=
s
> > using ioctl(LOOP_SET_FD/LOOP_CLR_FD), I think that that commit converte=
d
> > a run many times, multi threaded program into a run once, single thread=
ed
> > program. That will likely hide all race bugs.
> >
> > Does that commit also affect open(3) (i.e. open for ioctl only) case?
> > If that commit does not affect open(3) case, the reproducer could conti=
nue
> > behaving as run many times, multi threaded program that overwrites
> > filesystem images using ioctl(LOOP_SET_FD/LOOP_CLR_FD), by replacing
> > open(O_RDWR) with open(3) ?
>
> Hum, that's a good point. I had a look into details how syskaller sets up
> loop devices and indeed it gets broken by CONFIG_BLK_DEV_WRITE_MOUNTED=3D=
n.
> Strace confirms that:
>
> openat(AT_FDCWD, "/dev/loop0", O_RDWR)  =3D 4
> ioctl(4, LOOP_SET_FD, 3)                =3D 0
> close(3)                                =3D 0
> mkdir("./file0", 0777)                  =3D -1 EEXIST (File exists)
> mount("/dev/loop0", "./file0", "reiserfs", 0, "") =3D -1 EBUSY (Device or=
 resource busy)
> ioctl(4, LOOP_CLR_FD)                   =3D 0
> close(4)                                =3D 0
>
> which explains why syzbot was not able to reproduce some problems for whi=
ch
> CONFIG_BLK_DEV_WRITE_MOUNTED=3Dn should have made no difference (I wanted=
 to
> have a look into that but other things kept getting higher priority).
>
> It should be easily fixable by opening /dev/loop0 with O_RDONLY instead o=
f
> O_RDWR. Aleksandr?
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

