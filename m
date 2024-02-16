Return-Path: <linux-fsdevel+bounces-11810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C13857553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D6228690D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 04:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61A11C85;
	Fri, 16 Feb 2024 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYC9Fk7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0292F5A;
	Fri, 16 Feb 2024 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708057381; cv=none; b=h2rPbN5aHkmKy58740ECIt2ezD2To1EFmTGhYyRAN4NFnwx44eJ6iMYzN4W26kuNZ0ZYfg2PIkv5UjcI+2sMkLaG1IHhuXd+2cm3j8ctXzanrRZnYwSf3Z8N+dJMa7tIDYOHcsjRQiVPzSzDTcnIiAEkfifRwk5W8Qmw02AUpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708057381; c=relaxed/simple;
	bh=8VoooUBb/mpBecGbkzjkQoGSddj7h28XEUvLtHWMx/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjDwEtJn5HxzZ/SD1TNxJT5K5GVq3RHs7nLDrqZ02pb8V3eKMwvMBnbTZ7BwHTXUcNk6JKIUMM0/qdbgBpY3xmkRZmZgDrMfXV2GHtmzGoGrSVgzIYqChFbPR9OjyPab7hYTk3NISaqAXsam7CTU/AZR4KAZogBDuKVxqOLPiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYC9Fk7g; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51197ca63f5so443726e87.1;
        Thu, 15 Feb 2024 20:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708057377; x=1708662177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxLsR4QlrtsmB9WZlcxUrAeP1GHOQte70DnVGM7gu7w=;
        b=CYC9Fk7gvZgdk8BFt5JxJTV41Yurv6nWeQ0qLamvLmEg683yUgkNZVaZGAlPul3Yvz
         h5IPmz8hvd0M2EIpHrnsFs3nI4zGrq6ZVnp6s9NZ1aQ4Hqki6d7oxi3WrFiP4S/04t53
         pLcJb08yhsiUwY3hGfbRFPJ6OXG46sUDKMyYu0viZbG4INH8AM4nSFWO8ljLENaRsVRg
         GiYthFbETqpIC5mIanDMEM8jD1DF3htKU+L5KP/K9wkioewiJKPOoODHHPLMeaRM28Ln
         s0E30AavfwMlRaFpMzx4L5M7M8G8+2tjBkWs6Ej+vVlATqwszgwv8IzwCZKL/5b4lCAp
         itTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708057377; x=1708662177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxLsR4QlrtsmB9WZlcxUrAeP1GHOQte70DnVGM7gu7w=;
        b=MN9sGUVMfua9OKXBuJq9HYKVH466iNVwZq8lweEbnJXAiS6/TB3NWyaMegVrxyF3EE
         XoPd3HVhvy/pe652vVfzVFD4zHHGlYZaZDWW7K3PD2U7i9ssXRplyZQ4nO/Vtjk9FBhw
         grPN0uDvcpBfdGNPx0hyLpGvq23c0A2shhmKhvkKopKYTF9uTKc497TUoKqKEUoeCUEf
         V5yAhRy8gqeQLbOPLhPi7CMaclmO5pZR2VUM23T5tIQ8Ez7JsALOEksMZoqa0Gmw8uJG
         ieJx7CBd0uzO5NKTQvxl/Gv2xP541d/XmDF3r8TGCAKQBWrdzwh7ME3bhBcq3XIKsqlP
         lFJg==
X-Forwarded-Encrypted: i=1; AJvYcCXEL6mvCLP/diMd8QSeXZM6rawbL0FQfib/kgmP1XtnY6XJO3gbEiTrPWxj3n4YX1tEM3Hueuj/xWzPSBsDZuW2nPDrE9LMyYJdfNrIH62QwHgOliJgi+HwXOEu8/E5mxTYTksmpY+KJuQ=
X-Gm-Message-State: AOJu0Yz7LQXmrgUxDth8eU+zY/p6iNYL6RhI+aW2YA1mSJ8Q4j0TFhGJ
	f6oaSnIQdfmnNq4kfobopJaMyYqD6sgxDiVCg9xUK/DNDPiehqEkypcPLmfWbxMM0LgTn1WIUDL
	p67Dl8u3G1CZClA1PytgXzWvNQbQ=
X-Google-Smtp-Source: AGHT+IGyPueDHvpW/h7Nw6ned5ZkN+Vg2T7PIzZzjTommdJ/hLW3CPTCCnHwVnVwsIa2kTgmJTfykFCysiF6KVcMy1o=
X-Received: by 2002:a19:5e49:0:b0:511:4fbf:2419 with SMTP id
 z9-20020a195e49000000b005114fbf2419mr2448561lfi.35.1708057376518; Thu, 15 Feb
 2024 20:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
 <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
 <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
 <CAH2r5mt9gPhUSka56yk28+nksw7=LPuS4VAMzGQyJEOfcpOc=g@mail.gmail.com>
 <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com>
 <CAH2r5mvSsmm2WzAakAKWGJMs3C-9+z0EJ-msV0Qjkt5q9ZPBzA@mail.gmail.com>
 <CAH2r5mvPz2CUyKDZv_9fYGu=9L=3UiME7xaJGBbu+iF8CH8YEQ@mail.gmail.com> <CAKAwkKu=v8GYX0Mhf1mzDYWT2v6dnLB=_zs7jk6trocAN2++4g@mail.gmail.com>
In-Reply-To: <CAKAwkKu=v8GYX0Mhf1mzDYWT2v6dnLB=_zs7jk6trocAN2++4g@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 15 Feb 2024 22:22:44 -0600
Message-ID: <CAH2r5mvdPzy8v=yzaZYemYxFJ5u29No7yWTeZKzsLmfp2Rtsow@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Shyam Prasad N <nspmangalore@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002f1138061178191b"

--0000000000002f1138061178191b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lightly updated with Shyam's modulo suggestion


On Thu, Feb 15, 2024 at 9:46=E2=80=AFPM Matthew Ruffell
<matthew.ruffell@canonical.com> wrote:
>
> Hi Steve,
>
> I tested the patch ontop of 6.8-rc4 and it works great.
>
> $ sudo mount -t cifs -o username=3Dubuntu,vers=3D1.0,wsize=3D16850
> //192.168.122.172/sambashare ~/share
> $ mount -l
> //192.168.122.172/sambashare on /home/ubuntu/share type cifs
> (rw,relatime,vers=3D1.0,cache=3Dstrict,username=3Dubuntu,uid=3D0,noforceu=
id,gid=3D0,noforcegid,
> addr=3D192.168.122.172,soft,unix,posixpaths,serverino,mapposix,acl,rsize=
=3D1048576,wsize=3D16384,bsize=3D1048576,retrans=3D1,echo_interval=3D60,act=
imeo=3D1,closetimeo=3D1)
> $ sudo dmesg | tail
> [   48.767560] Use of the less secure dialect vers=3D1.0 is not
> recommended unless required for access to very old servers
> [   48.768399] CIFS: VFS: Use of the less secure dialect vers=3D1.0 is
> not recommended unless required for access to very old servers
> [   48.769427] CIFS: VFS: wsize rounded down to 16384 to multiple of
> PAGE_SIZE 4096
> [   48.770069] CIFS: Attempting to mount //192.168.122.172/sambashare
>
> Setting the wsize=3D16850 rounds it down to 16384 like clockwork.
>
> I have built R. Diez a new distro kernel with the patch applied, and will=
 ask
> him to test it. He did test the last one, which worked, and also rounded =
down
> the wsize that was negotiated with his old 1.0 server.
>
> When I get some time I can help try bisect and locate the folios/netfs da=
ta
> corruption, but I think this is a good solution for the time being, or un=
til
> the netfslib changeover happens.
>
> Thanks,
> Matthew
>
> On Thu, 15 Feb 2024 at 20:32, Steve French <smfrench@gmail.com> wrote:
> >
> > Minor update to patch to work around the folios/netfs data corruption.
> >
> > In addition to printing the warning if "wsize=3D" is specified on mount
> > with a size that is not a multiple of PAGE_SIZE, it also rounds the
> > wsize down to the nearest multiple of PAGE_SIZE (as it was already
> > doing if the server tried to negotiate a wsize that was not a multiple
> > of PAGE_SIZE).
> >
> > On Fri, Feb 9, 2024 at 2:25=E2=80=AFPM Steve French <smfrench@gmail.com=
> wrote:
> > >
> > > > > If the user does set their own "wsize", any value that is not a m=
ultiple of
> > > > PAGE_SIZE is dangerous right?
> > >
> > > Yes for kernels 6.3 through 6.8-rc such a write size (ie that is not =
a
> > > multiple of page size) can
> > > be dangerous - that is why I added the warning on mount if the user
> > > specifies the
> > > potentially problematic wsize, since the wsize specified on mount
> > > unlike the server
> > > negotiated maximum write size is under the user's control.  The serve=
r
> > > negotiated
> > > maximum write size can't be controlled by the user, so for this
> > > temporary fix we are
> > > forced to round it down.   The actually bug is due to a folios/netfs
> > > bug that David or
> > > one of the mm experts may be able to spot (and fix) so for this
> > > temporary workaround
> > > I wanted to do the smaller change here so we don't have to revert it
> > > later. I got close to
> > > finding the actual bug (where the offset was getting reset, rounded u=
p
> > > incorrectly
> > > inside one of the folios routines mentioned earlier in the thread) bu=
t
> > > wanted to get something
> > >
> > > On Fri, Feb 9, 2024 at 2:51=E2=80=AFAM Matthew Ruffell
> > > <matthew.ruffell@canonical.com> wrote:
> > > >
> > > > Hi Steve,
> > > >
> > > > Yes, I am specifying "wsize" on the mount in my example, as its a l=
ittle easier
> > > > to reproduce the issue that way.
> > > >
> > > > If the user does set their own "wsize", any value that is not a mul=
tiple of
> > > > PAGE_SIZE is dangerous right? Shouldn't we prevent the user from co=
rrupting
> > > > their data (un)intentionally if they happen to specify a wrong valu=
e? Especially
> > > > since we know about it now. I know there haven't been any other rep=
orts in the
> > > > year or so between 6.3 and present day, so there probably isn't any=
 users out
> > > > there actually setting their own "wsize", but it still feels bad to=
 allow users
> > > > to expose themselves to data corruption in this form.
> > > >
> > > > Please consider also rounding down "wsize" set on mount command lin=
e to a safe
> > > > multiple of PAGE_SIZE. The code will only be around until David's n=
etfslib cut
> > > > over is merged anyway.
> > > >
> > > > I built a distro kernel and sent it to R. Diez for testing, so hope=
fully we will
> > > > have some testing performed against an actual SMB server that sends=
 a dangerous
> > > > wsize during negotiation. I'll let you know how that goes, or R. Di=
ez, you can
> > > > tell us about how it goes here.
> > > >
> > > > Thanks,
> > > > Matthew
> > > >
> > > > On Fri, 9 Feb 2024 at 18:38, Steve French <smfrench@gmail.com> wrot=
e:
> > > > >
> > > > > Are you specifying "wsize" on the mount in your example?  The int=
ent
> > > > > of the patch is to warn the user using a non-recommended wsize (s=
ince
> > > > > the user can control and fix that) but to force round_down when t=
he
> > > > > server sends a dangerous wsize (ie one that is not a multiple of
> > > > > 4096).
> > > > >
> > > > > On Thu, Feb 8, 2024 at 3:31=E2=80=AFAM Matthew Ruffell
> > > > > <matthew.ruffell@canonical.com> wrote:
> > > > > >
> > > > > > Hi Steve,
> > > > > >
> > > > > > I built your latest patch ontop of 6.8-rc3, but the problem sti=
ll persists.
> > > > > >
> > > > > > Looking at dmesg, I see the debug statement from the second hun=
k, but not from
> > > > > > the first hunk, so I don't believe that wsize was ever rounded =
down to
> > > > > > PAGE_SIZE.
> > > > > >
> > > > > > [  541.918267] Use of the less secure dialect vers=3D1.0 is not
> > > > > > recommended unless required for access to very old servers
> > > > > > [  541.920913] CIFS: VFS: Use of the less secure dialect vers=
=3D1.0 is
> > > > > > not recommended unless required for access to very old servers
> > > > > > [  541.923533] CIFS: VFS: wsize should be a multiple of 4096 (P=
AGE_SIZE)
> > > > > > [  541.924755] CIFS: Attempting to mount //192.168.122.172/samb=
ashare
> > > > > >
> > > > > > $ sha256sum sambashare/testdata.txt
> > > > > > 9e573a0aa795f9cd4de4ac684a1c056dbc7d2ba5494d02e71b6225ff5f0fd86=
6
> > > > > > sambashare/testdata.txt
> > > > > > $ less sambashare/testdata.txt
> > > > > > ...
> > > > > > 8dc8da96f7e5de0f312a2dbcc3c5c6facbfcc2fc206e29283274582ec93daa2=
a1496ca8edd49e3c1
> > > > > > 6b^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^
> > > > > > ...
> > > > > >
> > > > > > Would you be able compile and test your patch and see if we ent=
er the logic from
> > > > > > the first hunk?
> > > > > >
> > > > > > I'll be happy to test a V2 tomorrow.
> > > > > >
> > > > > > Thanks,
> > > > > > Matthew
> > > > > >
> > > > > > On Thu, 8 Feb 2024 at 03:50, Steve French <smfrench@gmail.com> =
wrote:
> > > > > > >
> > > > > > > I had attached the wrong file - reattaching the correct patch=
 (ie that
> > > > > > > updates the previous version to use PAGE_SIZE instead of 4096=
)
> > > > > > >
> > > > > > > On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench=
@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Updated patch - now use PAGE_SIZE instead of hard coding to=
 4096.
> > > > > > > >
> > > > > > > > See attached
> > > > > > > >
> > > > > > > > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfre=
nch@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Attached updated patch which also adds check to make sure=
 max write
> > > > > > > > > size is at least 4K
> > > > > > > > >
> > > > > > > > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smf=
rench@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > > his netfslib work looks like quite a big refactor. Is=
 there any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > > > >
> > > > > > > > > > I don't object to putting them in 6.8 if there was addi=
tional review
> > > > > > > > > > (it is quite large), but I expect there would be pushba=
ck, and am
> > > > > > > > > > concerned that David's status update did still show som=
e TODOs for
> > > > > > > > > > that patch series.  I do plan to upload his most recent=
 set to
> > > > > > > > > > cifs-2.6.git for-next later in the week and target woul=
d be for
> > > > > > > > > > merging the patch series would be 6.9-rc1 unless major =
issues were
> > > > > > > > > > found in review or testing
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > > > > > > > <matthew.ruffell@canonical.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > I have bisected the issue, and found the commit that =
introduces the problem:
> > > > > > > > > > >
> > > > > > > > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > > > > > > > Subject: cifs: Change the I/O paths to use an iterato=
r rather than a page list
> > > > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git=
/torvalds/linux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > > > >
> > > > > > > > > > > $ git describe --contains d08089f649a0cfb2099c8551ac4=
7eef0cc23fdf2
> > > > > > > > > > > v6.3-rc1~136^2~7
> > > > > > > > > > >
> > > > > > > > > > > David, I also tried your cifs-netfs tree available he=
re:
> > > > > > > > > > >
> > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowe=
lls/linux-fs.git/log/?h=3Dcifs-netfs
> > > > > > > > > > >
> > > > > > > > > > > This tree solves the issue. Specifically:
> > > > > > > > > > >
> > > > > > > > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > > > > > > > Subject: cifs: Cut over to using netfslib
> > > > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git=
/dhowells/linux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c=
2e8a54db119fd0d8
> > > > > > > > > > >
> > > > > > > > > > > This netfslib work looks like quite a big refactor. I=
s there any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > > > > >
> > > > > > > > > > > Do you have any suggestions on how to fix this with a=
 smaller delta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Matthew
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Thanks,
> > > > > > > > > >
> > > > > > > > > > Steve
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Thanks,
> > > > > > > > >
> > > > > > > > > Steve
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Steve
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Steve
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > >
> > > > > Steve
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve



--=20
Thanks,

Steve

--0000000000002f1138061178191b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Disposition: attachment; 
	filename="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lso592b80>
X-Attachment-Id: f_lso592b80

RnJvbSA0ODYwYWJiOTFmM2Q3ZmJhZjgxNDdkNTQ3ODIxNDliYjFmYzQ1ODkyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgNiBGZWIgMjAyNCAxNjozNDoyMiAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBzbWI6IEZpeCByZWdyZXNzaW9uIGluIHdyaXRlcyB3aGVuIG5vbi1zdGFuZGFyZCBtYXhpbXVt
CiB3cml0ZSBzaXplIG5lZ290aWF0ZWQKClRoZSBjb252ZXJzaW9uIHRvIG5ldGZzIGluIHRoZSA2
LjMga2VybmVsIGNhdXNlZCBhIHJlZ3Jlc3Npb24gd2hlbgptYXhpbXVtIHdyaXRlIHNpemUgaXMg
c2V0IGJ5IHRoZSBzZXJ2ZXIgdG8gYW4gdW5leHBlY3RlZCB2YWx1ZSB3aGljaCBpcwpub3QgYSBt
dWx0aXBsZSBvZiA0MDk2IChzaW1pbGFybHkgaWYgdGhlIHVzZXIgb3ZlcnJpZGVzIHRoZSBtYXhp
bXVtCndyaXRlIHNpemUgYnkgc2V0dGluZyBtb3VudCBwYXJtICJ3c2l6ZSIsIGJ1dCBzZXRzIGl0
IHRvIGEgdmFsdWUgdGhhdAppcyBub3QgYSBtdWx0aXBsZSBvZiA0MDk2KS4gIFdoZW4gbmVnb3Rp
YXRlZCB3cml0ZSBzaXplIGlzIG5vdCBhCm11bHRpcGxlIG9mIDQwOTYgdGhlIG5ldGZzIGNvZGUg
Y2FuIHNraXAgdGhlIGVuZCBvZiB0aGUgZmluYWwKcGFnZSB3aGVuIGRvaW5nIGxhcmdlIHNlcXVl
bnRpYWwgd3JpdGVzLCBjYXVzaW5nIGRhdGEgY29ycnVwdGlvbi4KClRoaXMgc2VjdGlvbiBvZiBj
b2RlIGlzIGJlaW5nIHJld3JpdHRlbi9yZW1vdmVkIGR1ZSB0byBhIGxhcmdlCm5ldGZzIGNoYW5n
ZSwgYnV0IHVudGlsIHRoYXQgcG9pbnQgKGllIGZvciB0aGUgNi4zIGtlcm5lbCB1bnRpbCBub3cp
CndlIGNhbiBub3Qgc3VwcG9ydCBub24tc3RhbmRhcmQgbWF4aW11bSB3cml0ZSBzaXplcy4KCkFk
ZCBhIHdhcm5pbmcgaWYgYSB1c2VyIHNwZWNpZmllcyBhIHdzaXplIG9uIG1vdW50IHRoYXQgaXMg
bm90CmEgbXVsdGlwbGUgb2YgNDA5NiAoYW5kIHJvdW5kIGRvd24pLCBhbHNvIGFkZCBhIGNoYW5n
ZSB3aGVyZSB3ZQpyb3VuZCBkb3duIHRoZSBtYXhpbXVtIHdyaXRlIHNpemUgaWYgdGhlIHNlcnZl
ciBuZWdvdGlhdGVzIGEgdmFsdWUKdGhhdCBpcyBub3QgYSBtdWx0aXBsZSBvZiA0MDk2ICh3ZSBh
bHNvIGhhdmUgdG8gY2hlY2sgdG8gbWFrZSBzdXJlIHRoYXQKd2UgZG8gbm90IHJvdW5kIGl0IGRv
d24gdG8gemVybykuCgpSZXBvcnRlZC1ieTogUi4gRGlleiIgPHJkaWV6LTIwMDZAcmQxMC5kZT4K
Rml4ZXM6IGQwODA4OWY2NDlhMCAoImNpZnM6IENoYW5nZSB0aGUgSS9PIHBhdGhzIHRvIHVzZSBh
biBpdGVyYXRvciByYXRoZXIgdGhhbiBhIHBhZ2UgbGlzdCIpClN1Z2dlc3RlZC1ieTogUm9ubmll
IFNhaGxiZXJnIDxyb25uaWVzYWhsYmVyZ0BnbWFpbC5jb20+CkFja2VkLWJ5OiBSb25uaWUgU2Fo
bGJlcmcgPHJvbm5pZXNhaGxiZXJnQGdtYWlsLmNvbT4KVGVzdGVkLWJ5OiBNYXR0aGV3IFJ1ZmZl
bGwgPG1hdHRoZXcucnVmZmVsbEBjYW5vbmljYWwuY29tPgpSZXZpZXdlZC1ieTogU2h5YW0gUHJh
c2FkIE4gPHNwcmFzYWRAbWljcm9zb2Z0LmNvbT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcg
IyB2Ni4zKwpDYzogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4KU2lnbmVkLW9m
Zi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9j
bGllbnQvY29ubmVjdC5jICAgIHwgMTQgKysrKysrKysrKysrLS0KIGZzL3NtYi9jbGllbnQvZnNf
Y29udGV4dC5jIHwgMTEgKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2Nvbm5lY3Qu
YyBiL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCmluZGV4IGQwMzI1M2Y4ZjE0NS4uYWM5NTk1NTA0
ZjRiIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2Nvbm5lY3QuYworKysgYi9mcy9zbWIvY2xp
ZW50L2Nvbm5lY3QuYwpAQCAtMzQ0NCw4ICszNDQ0LDE4IEBAIGludCBjaWZzX21vdW50X2dldF90
Y29uKHN0cnVjdCBjaWZzX21vdW50X2N0eCAqbW50X2N0eCkKIAkgKiB0aGUgdXNlciBvbiBtb3Vu
dAogCSAqLwogCWlmICgoY2lmc19zYi0+Y3R4LT53c2l6ZSA9PSAwKSB8fAotCSAgICAoY2lmc19z
Yi0+Y3R4LT53c2l6ZSA+IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfd3NpemUodGNvbiwgY3R4KSkp
Ci0JCWNpZnNfc2ItPmN0eC0+d3NpemUgPSBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3dzaXplKHRj
b24sIGN0eCk7CisJICAgIChjaWZzX3NiLT5jdHgtPndzaXplID4gc2VydmVyLT5vcHMtPm5lZ290
aWF0ZV93c2l6ZSh0Y29uLCBjdHgpKSkgeworCQljaWZzX3NiLT5jdHgtPndzaXplID0KKwkJCXJv
dW5kX2Rvd24oc2VydmVyLT5vcHMtPm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpLCBQQUdFX1NJ
WkUpOworCQkvKgorCQkgKiBpbiB0aGUgdmVyeSB1bmxpa2VseSBldmVudCB0aGF0IHRoZSBzZXJ2
ZXIgc2VudCBhIG1heCB3cml0ZSBzaXplIHVuZGVyIFBBR0VfU0laRSwKKwkJICogKHdoaWNoIHdv
dWxkIGdldCByb3VuZGVkIGRvd24gdG8gMCkgdGhlbiByZXNldCB3c2l6ZSB0byBhYnNvbHV0ZSBt
aW5pbXVtIGVnIDQwOTYKKwkJICovCisJCWlmIChjaWZzX3NiLT5jdHgtPndzaXplID09IDApIHsK
KwkJCWNpZnNfc2ItPmN0eC0+d3NpemUgPSBQQUdFX1NJWkU7CisJCQljaWZzX2RiZyhWRlMsICJ3
c2l6ZSB0b28gc21hbGwsIHJlc2V0IHRvIG1pbmltdW0gaWUgUEFHRV9TSVpFLCB1c3VhbGx5IDQw
OTZcbiIpOworCQl9CisJfQogCWlmICgoY2lmc19zYi0+Y3R4LT5yc2l6ZSA9PSAwKSB8fAogCSAg
ICAoY2lmc19zYi0+Y3R4LT5yc2l6ZSA+IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfcnNpemUodGNv
biwgY3R4KSkpCiAJCWNpZnNfc2ItPmN0eC0+cnNpemUgPSBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRl
X3JzaXplKHRjb24sIGN0eCk7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQu
YyBiL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jCmluZGV4IGFlYzhkYmQxZjlkYi4uNGIyZjVh
YTJlYTBlIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYworKysgYi9mcy9z
bWIvY2xpZW50L2ZzX2NvbnRleHQuYwpAQCAtMTExMSw2ICsxMTExLDE3IEBAIHN0YXRpYyBpbnQg
c21iM19mc19jb250ZXh0X3BhcnNlX3BhcmFtKHN0cnVjdCBmc19jb250ZXh0ICpmYywKIAljYXNl
IE9wdF93c2l6ZToKIAkJY3R4LT53c2l6ZSA9IHJlc3VsdC51aW50XzMyOwogCQljdHgtPmdvdF93
c2l6ZSA9IHRydWU7CisJCWlmIChjdHgtPndzaXplICUgUEFHRV9TSVpFICE9IDApIHsKKwkJCWN0
eC0+d3NpemUgPSByb3VuZF9kb3duKGN0eC0+d3NpemUsIFBBR0VfU0laRSk7CisJCQlpZiAoY3R4
LT53c2l6ZSA9PSAwKSB7CisJCQkJY3R4LT53c2l6ZSA9IFBBR0VfU0laRTsKKwkJCQljaWZzX2Ri
ZyhWRlMsICJ3c2l6ZSB0b28gc21hbGwsIHJlc2V0IHRvIG1pbmltdW0gJWxkXG4iLCBQQUdFX1NJ
WkUpOworCQkJfSBlbHNlIHsKKwkJCQljaWZzX2RiZyhWRlMsCisJCQkJCSAid3NpemUgcm91bmRl
ZCBkb3duIHRvICVkIHRvIG11bHRpcGxlIG9mIFBBR0VfU0laRSAlbGRcbiIsCisJCQkJCSBjdHgt
PndzaXplLCBQQUdFX1NJWkUpOworCQkJfQorCQl9CiAJCWJyZWFrOwogCWNhc2UgT3B0X2FjcmVn
bWF4OgogCQljdHgtPmFjcmVnbWF4ID0gSFogKiByZXN1bHQudWludF8zMjsKLS0gCjIuNDAuMQoK
--0000000000002f1138061178191b--

