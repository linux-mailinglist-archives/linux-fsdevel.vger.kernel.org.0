Return-Path: <linux-fsdevel+bounces-11809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7E857400
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 04:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA23286B44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 03:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F483FC02;
	Fri, 16 Feb 2024 03:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dgga68XB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8A8BF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708055187; cv=none; b=XvZ6KDbPrpFaHmNyZjEaa8THmpk8ZZnTmPyvUVTH4iq3916FAcri9rxX7Rl0i7VRkk3Gkb76lN+4yRWRPtSPa5Tmij2h2sOj4jRVVvDD1Xf9A12+kyKd6xsfi7assiQVIk4G3slazknpJsATBLaesmKWxX8eNu4WWqW26DYaOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708055187; c=relaxed/simple;
	bh=yd/1AuvvJ50vwThAXABCUvrExaC4xvwRTKDpMrhTRLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q15lswAYqxFd79ffnriZFge0sMvOXcAmpRzGzMtSSwSkXrJf/5TZwjmqRj3YqoazBPRkke8EYaoQiq2Q5CScqVQaTcFsvDtLXo6qrAxQzgq/2tuwHcCjp9axUGIk1IUszdS0cvys8KS9qKMcoKuZro3fkpzel6huUWHZytwYmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dgga68XB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 21A3D3FA8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 03:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708055182;
	bh=NpKs3rrlFvfdfLylcjk/hf+qLhfwNVkba72SYiQlDGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dgga68XBeb5qBgt2Rf6rIsdq+l1Zer/MuTQuwr3fmfv74NzmfF7FASlDa2jUMTTTA
	 4JrDc6+yGeTAjud+qM0qkeFQTLOklQywbOoMCD6qHVilYCWdxquHKYtouvUQDc361H
	 aJ2gTw3YBJ0L5Bwj4ScEu61Oo6Jx/81SqJDzo/QfPWXBQHY0lvHDWbdV+PfnRapaIP
	 5124mJ9CHVrEIQb5dPGlyLHNPxrOftduPxb8En9vLPcZgYqfFKnzYzUnylNzaDNjF/
	 atbrt9mooWSFYqIMRxg7vPkGIZVhBvtyheEKHNzby4mSQkPywDHNdsRUH4h5nREapZ
	 00O2CSFFbEu3w==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-290e7a0a585so1534968a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 19:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708055181; x=1708659981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpKs3rrlFvfdfLylcjk/hf+qLhfwNVkba72SYiQlDGk=;
        b=Z8/ya6VxNV3S7zydzQ9cUxbPfk0h//qqFNw97p9zBM0tWcvRoKeEatrO41hDhz2qXA
         KOwHJJf6dITkSOodiRYIcWqCdjTrE0HJ9jWU3U44MSofb4BFsGlF3CKwctVz5LgBre80
         rl3ErEDk5C0EVM7q9y3xOvq7Gtf/xqVXsdx2kX3o4n/nTU7IsBt+nPePSI7PbdrDnFBY
         jJqXj05eRkDwcW5Y+eBhIrnfTkSJMfhi0Y5WK6ONUMKn03NbItcqYDo6/oq2Tx4MW39l
         RG75J9o7tdvTHrpobl3mrHqsP0l5UtBQ1z+SHDPAHfG56IY6mU9nt6q5+HrjLa2o6ItG
         AeSg==
X-Forwarded-Encrypted: i=1; AJvYcCVrPFJBUKJbkaDG6C4u0UFwrwdUCHDm05VkZKFud6/MCCBOow0AwzZSnekLKzIoAPEJ4x29fSpHH3IbZKC+Ie1CIwGfsmmW1HSk+UFmyw==
X-Gm-Message-State: AOJu0Yz+ukXp2sFSmMYsuLn+2S0FGA5mNjEHX8SMbX0bX/i3tQBkFL0F
	J13l24UqDJWATeg+Xu3/KBV2s4mWCng53wjFn/SEdI5jT82LySjokD+/a01fDJZrAOrymTiRbiq
	TKIgzas0ZqD5mR2BLITuZYTSXb4Az2ugTbtq4TK6XyPqqhUCw8jLksagkB4DYyd2AUhAvH6Yu+D
	RwpQTfQzpeUlQfjR2NqvKuJIOTONTZKqwfDITUKHgI7AIgylWnPLFGMg==
X-Received: by 2002:a17:90a:cb11:b0:297:efb:c33d with SMTP id z17-20020a17090acb1100b002970efbc33dmr3144179pjt.47.1708055180715;
        Thu, 15 Feb 2024 19:46:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfWx0b28tpTAKEAuv8o+ylZknwr9EjymNvf10lq7gjJQeoajAW/wyKcBAZegdJ73clO+Bl5D9nhdTF1P0UKjI=
X-Received: by 2002:a17:90a:cb11:b0:297:efb:c33d with SMTP id
 z17-20020a17090acb1100b002970efbc33dmr3144169pjt.47.1708055180305; Thu, 15
 Feb 2024 19:46:20 -0800 (PST)
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
 <CAH2r5mvSsmm2WzAakAKWGJMs3C-9+z0EJ-msV0Qjkt5q9ZPBzA@mail.gmail.com> <CAH2r5mvPz2CUyKDZv_9fYGu=9L=3UiME7xaJGBbu+iF8CH8YEQ@mail.gmail.com>
In-Reply-To: <CAH2r5mvPz2CUyKDZv_9fYGu=9L=3UiME7xaJGBbu+iF8CH8YEQ@mail.gmail.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Fri, 16 Feb 2024 16:46:08 +1300
Message-ID: <CAKAwkKu=v8GYX0Mhf1mzDYWT2v6dnLB=_zs7jk6trocAN2++4g@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

I tested the patch ontop of 6.8-rc4 and it works great.

$ sudo mount -t cifs -o username=3Dubuntu,vers=3D1.0,wsize=3D16850
//192.168.122.172/sambashare ~/share
$ mount -l
//192.168.122.172/sambashare on /home/ubuntu/share type cifs
(rw,relatime,vers=3D1.0,cache=3Dstrict,username=3Dubuntu,uid=3D0,noforceuid=
,gid=3D0,noforcegid,
addr=3D192.168.122.172,soft,unix,posixpaths,serverino,mapposix,acl,rsize=3D=
1048576,wsize=3D16384,bsize=3D1048576,retrans=3D1,echo_interval=3D60,actime=
o=3D1,closetimeo=3D1)
$ sudo dmesg | tail
[   48.767560] Use of the less secure dialect vers=3D1.0 is not
recommended unless required for access to very old servers
[   48.768399] CIFS: VFS: Use of the less secure dialect vers=3D1.0 is
not recommended unless required for access to very old servers
[   48.769427] CIFS: VFS: wsize rounded down to 16384 to multiple of
PAGE_SIZE 4096
[   48.770069] CIFS: Attempting to mount //192.168.122.172/sambashare

Setting the wsize=3D16850 rounds it down to 16384 like clockwork.

I have built R. Diez a new distro kernel with the patch applied, and will a=
sk
him to test it. He did test the last one, which worked, and also rounded do=
wn
the wsize that was negotiated with his old 1.0 server.

When I get some time I can help try bisect and locate the folios/netfs data
corruption, but I think this is a good solution for the time being, or unti=
l
the netfslib changeover happens.

Thanks,
Matthew

On Thu, 15 Feb 2024 at 20:32, Steve French <smfrench@gmail.com> wrote:
>
> Minor update to patch to work around the folios/netfs data corruption.
>
> In addition to printing the warning if "wsize=3D" is specified on mount
> with a size that is not a multiple of PAGE_SIZE, it also rounds the
> wsize down to the nearest multiple of PAGE_SIZE (as it was already
> doing if the server tried to negotiate a wsize that was not a multiple
> of PAGE_SIZE).
>
> On Fri, Feb 9, 2024 at 2:25=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
> >
> > > > If the user does set their own "wsize", any value that is not a mul=
tiple of
> > > PAGE_SIZE is dangerous right?
> >
> > Yes for kernels 6.3 through 6.8-rc such a write size (ie that is not a
> > multiple of page size) can
> > be dangerous - that is why I added the warning on mount if the user
> > specifies the
> > potentially problematic wsize, since the wsize specified on mount
> > unlike the server
> > negotiated maximum write size is under the user's control.  The server
> > negotiated
> > maximum write size can't be controlled by the user, so for this
> > temporary fix we are
> > forced to round it down.   The actually bug is due to a folios/netfs
> > bug that David or
> > one of the mm experts may be able to spot (and fix) so for this
> > temporary workaround
> > I wanted to do the smaller change here so we don't have to revert it
> > later. I got close to
> > finding the actual bug (where the offset was getting reset, rounded up
> > incorrectly
> > inside one of the folios routines mentioned earlier in the thread) but
> > wanted to get something
> >
> > On Fri, Feb 9, 2024 at 2:51=E2=80=AFAM Matthew Ruffell
> > <matthew.ruffell@canonical.com> wrote:
> > >
> > > Hi Steve,
> > >
> > > Yes, I am specifying "wsize" on the mount in my example, as its a lit=
tle easier
> > > to reproduce the issue that way.
> > >
> > > If the user does set their own "wsize", any value that is not a multi=
ple of
> > > PAGE_SIZE is dangerous right? Shouldn't we prevent the user from corr=
upting
> > > their data (un)intentionally if they happen to specify a wrong value?=
 Especially
> > > since we know about it now. I know there haven't been any other repor=
ts in the
> > > year or so between 6.3 and present day, so there probably isn't any u=
sers out
> > > there actually setting their own "wsize", but it still feels bad to a=
llow users
> > > to expose themselves to data corruption in this form.
> > >
> > > Please consider also rounding down "wsize" set on mount command line =
to a safe
> > > multiple of PAGE_SIZE. The code will only be around until David's net=
fslib cut
> > > over is merged anyway.
> > >
> > > I built a distro kernel and sent it to R. Diez for testing, so hopefu=
lly we will
> > > have some testing performed against an actual SMB server that sends a=
 dangerous
> > > wsize during negotiation. I'll let you know how that goes, or R. Diez=
, you can
> > > tell us about how it goes here.
> > >
> > > Thanks,
> > > Matthew
> > >
> > > On Fri, 9 Feb 2024 at 18:38, Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > Are you specifying "wsize" on the mount in your example?  The inten=
t
> > > > of the patch is to warn the user using a non-recommended wsize (sin=
ce
> > > > the user can control and fix that) but to force round_down when the
> > > > server sends a dangerous wsize (ie one that is not a multiple of
> > > > 4096).
> > > >
> > > > On Thu, Feb 8, 2024 at 3:31=E2=80=AFAM Matthew Ruffell
> > > > <matthew.ruffell@canonical.com> wrote:
> > > > >
> > > > > Hi Steve,
> > > > >
> > > > > I built your latest patch ontop of 6.8-rc3, but the problem still=
 persists.
> > > > >
> > > > > Looking at dmesg, I see the debug statement from the second hunk,=
 but not from
> > > > > the first hunk, so I don't believe that wsize was ever rounded do=
wn to
> > > > > PAGE_SIZE.
> > > > >
> > > > > [  541.918267] Use of the less secure dialect vers=3D1.0 is not
> > > > > recommended unless required for access to very old servers
> > > > > [  541.920913] CIFS: VFS: Use of the less secure dialect vers=3D1=
.0 is
> > > > > not recommended unless required for access to very old servers
> > > > > [  541.923533] CIFS: VFS: wsize should be a multiple of 4096 (PAG=
E_SIZE)
> > > > > [  541.924755] CIFS: Attempting to mount //192.168.122.172/sambas=
hare
> > > > >
> > > > > $ sha256sum sambashare/testdata.txt
> > > > > 9e573a0aa795f9cd4de4ac684a1c056dbc7d2ba5494d02e71b6225ff5f0fd866
> > > > > sambashare/testdata.txt
> > > > > $ less sambashare/testdata.txt
> > > > > ...
> > > > > 8dc8da96f7e5de0f312a2dbcc3c5c6facbfcc2fc206e29283274582ec93daa2a1=
496ca8edd49e3c1
> > > > > 6b^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^
> > > > > ...
> > > > >
> > > > > Would you be able compile and test your patch and see if we enter=
 the logic from
> > > > > the first hunk?
> > > > >
> > > > > I'll be happy to test a V2 tomorrow.
> > > > >
> > > > > Thanks,
> > > > > Matthew
> > > > >
> > > > > On Thu, 8 Feb 2024 at 03:50, Steve French <smfrench@gmail.com> wr=
ote:
> > > > > >
> > > > > > I had attached the wrong file - reattaching the correct patch (=
ie that
> > > > > > updates the previous version to use PAGE_SIZE instead of 4096)
> > > > > >
> > > > > > On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@g=
mail.com> wrote:
> > > > > > >
> > > > > > > Updated patch - now use PAGE_SIZE instead of hard coding to 4=
096.
> > > > > > >
> > > > > > > See attached
> > > > > > >
> > > > > > > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrenc=
h@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Attached updated patch which also adds check to make sure m=
ax write
> > > > > > > > size is at least 4K
> > > > > > > >
> > > > > > > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfre=
nch@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > > his netfslib work looks like quite a big refactor. Is t=
here any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > > >
> > > > > > > > > I don't object to putting them in 6.8 if there was additi=
onal review
> > > > > > > > > (it is quite large), but I expect there would be pushback=
, and am
> > > > > > > > > concerned that David's status update did still show some =
TODOs for
> > > > > > > > > that patch series.  I do plan to upload his most recent s=
et to
> > > > > > > > > cifs-2.6.git for-next later in the week and target would =
be for
> > > > > > > > > merging the patch series would be 6.9-rc1 unless major is=
sues were
> > > > > > > > > found in review or testing
> > > > > > > > >
> > > > > > > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > > > > > > <matthew.ruffell@canonical.com> wrote:
> > > > > > > > > >
> > > > > > > > > > I have bisected the issue, and found the commit that in=
troduces the problem:
> > > > > > > > > >
> > > > > > > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > > > > > > Subject: cifs: Change the I/O paths to use an iterator =
rather than a page list
> > > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > > > > > >
> > > > > > > > > > $ git describe --contains d08089f649a0cfb2099c8551ac47e=
ef0cc23fdf2
> > > > > > > > > > v6.3-rc1~136^2~7
> > > > > > > > > >
> > > > > > > > > > David, I also tried your cifs-netfs tree available here=
:
> > > > > > > > > >
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowell=
s/linux-fs.git/log/?h=3Dcifs-netfs
> > > > > > > > > >
> > > > > > > > > > This tree solves the issue. Specifically:
> > > > > > > > > >
> > > > > > > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > > > > > > Author: David Howells <dhowells@redhat.com>
> > > > > > > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > > > > > > Subject: cifs: Cut over to using netfslib
> > > > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/d=
howells/linux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e=
8a54db119fd0d8
> > > > > > > > > >
> > > > > > > > > > This netfslib work looks like quite a big refactor. Is =
there any plans to land this in 6.8? Or will this be 6.9 / later?
> > > > > > > > > >
> > > > > > > > > > Do you have any suggestions on how to fix this with a s=
maller delta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Matthew
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
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > >
> > > > > > Steve
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve

