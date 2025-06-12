Return-Path: <linux-fsdevel+bounces-51407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC36AD6804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 08:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E72517E3B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19F1F2B88;
	Thu, 12 Jun 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYRRnRzP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D71F2380;
	Thu, 12 Jun 2025 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709783; cv=none; b=uzPo0DI6mkceuTYUITvbfY08+Ut1uWe+9+S8ZG5P2VyJCspVgrLXxaMOaq8QB1wb+WEWM4pcmo1eTm5sf4kX+qIl8N6QrKDp4gizDp1wLuyZsTaVlTnzkTSd9zNqpxzQqc1bCHf9PHQt4N4ecJe/Ax9lnq4pzkaH2aIoHW5WuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709783; c=relaxed/simple;
	bh=tTttWpkeJescZ1D0ou68WiGucdpJczmz+va4QdiGySY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvWHdmm3z/2zOuCctoYl/c+XcCgQE/OHvc2YzW3+7HnBgojVmR860pSaWLtf1KQMSTb4HhJKHCI27noS5u/lK8PUz1F240EHxrBoaYp1YLWYqN9YUKLm2j+rIJURyosdIMzWS1YWwBBVOJnaZgs059AH6YVMQoB/p5/4Ub6P71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYRRnRzP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad8826c05f2so110231966b.3;
        Wed, 11 Jun 2025 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749709780; x=1750314580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMnQ0lSfRFOLX5YBEHmf2SW/xC1lQce8vd8CGQzY+DU=;
        b=EYRRnRzPkGw2t7bgL4NAb3H7verwot3zD02C5+4AF9HHeJpZpZiF6lgkbS8UveZc5y
         BHdMB5SmhhMsgn5ByRBFaNzzpMBAwXY53vigMrOZw6xfCMNo3z5JWIrBjNIMV4QIRBkx
         AvuYl/9FN9m5SRJPucXj+3oImL/huoOvRQ/4FuCEcdHLeMebmmPhFKV8fAvlqydJ5AKT
         r/EoY4b2s6e9YVIqldtP3du5ebwwZL4ywE6tqtGsZMRhZaL5sd7m3Ln3boQcWbMBNpoT
         LpQUy3YUEX3KBqWtc1edsRXEYHL6a6U7K/csRF7FRLB7x1CpBkZXG+BGnUeAn/wBVwQL
         t4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749709780; x=1750314580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMnQ0lSfRFOLX5YBEHmf2SW/xC1lQce8vd8CGQzY+DU=;
        b=S0AJADYNaoW+qnoF8jlRPPVRUGBlCe/WINtLOdAxmOGE/SzbQFxJriBO4Wtez8UkAi
         ok4IYMuKwSE2BNNeMHGp/JfVChNFklW++Brl2MSwp2DbmXZGWXuX0CVQnxxjdU7C7dJy
         dJVM+NPho3oNuFb2L1OLj0rnJNOC+ORv7+Z6JjGGyoO+KqX8y/hjNE6zaW/AuunJrXt1
         irMQIxlcVU+a9I+gi9jbSbASCJ2EkjG2yimBRXZzjVD8m9ZctN3lJyYaM+Df5gVzo5kA
         X0hkh2s1TPE8G7L+7ftwtGTpM8aS1epCJ1WZ3qlPrCCFgfCghqm52qaFrAkuoIsbuGKR
         pJPg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+HnPerySOrTGV3JC08ffCzWliGACJga/gfP5nGpOLNFLJRSegxUSdyfgMiQzrnJZx+s0Onhs/CwVJu4Z@vger.kernel.org, AJvYcCWLawBe+RbI5OjU6i5/UB+24w8dNh+dUc65hcoh4DdgI3n3C5OeeDQU8O110UhkJ/ePV+yIBg09OZxg@vger.kernel.org
X-Gm-Message-State: AOJu0YwbggnH5lXbVyJqjaK8XiHdo0i2hAU9oR/D8P22BJ6yznNTGPfJ
	h5Tc/jBf+5zmnqxcDEPksEYlFNFLSHiIDL9kIO+mmE+iKAYiHjyR8EGOLwjS3ALbJD88hjMud5X
	5Cr5RKVnlMK5u4+14J6ougWgUn7wLG/f2EEhJoGE=
X-Gm-Gg: ASbGncsTkxthlixg4xWnah9+/efeH/29o28cRCuxOQHA4cpWGgpWbsb9BE7l4GOi6UF
	jRXHZWJAH8eyK2Xrs/4MOr5SBZFP1c3YYnhnWOoIZoaIYpb7rS6MsBRk0CA2YoxSIYVq1rAFAtn
	7d23jB1xkzot1hVfAJV9rgMF0iC3ZCrpE+npCawMuH4OA=
X-Google-Smtp-Source: AGHT+IH2tqYWLgnR1Egf0f5MrMl/H6jtwy+ptDHqBI3mVeE6Wy6cvK8/ye8gzcEnLr4CjkXnXZrWvT3Erw1ybY+ST6Q=
X-Received: by 2002:a17:907:3ea4:b0:ad8:9428:6a3c with SMTP id
 a640c23a62f3a-adea2e356d9mr219291366b.11.1749709779759; Wed, 11 Jun 2025
 23:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs> <20250530-ahnen-relaxen-917e3bba8e2d@brauner>
 <20250530153847.GC8328@frogsfrogsfrogs> <aDuKgfi-CCykPuhD@dread.disaster.area>
 <20250603000327.GM8328@frogsfrogsfrogs> <20250606-zickig-wirft-6c61ba630e2c@brauner>
 <20250612034324.GG6138@frogsfrogsfrogs>
In-Reply-To: <20250612034324.GG6138@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Jun 2025 08:29:28 +0200
X-Gm-Features: AX0GCFvDjuEqQBSU8IqmA6NSuBlOST-snvSGSn8O2xPLNvSBD8H71tf4-5EVQPQ
Message-ID: <CAOQ4uxiEi2mGNNqYwPyJt-j=Ho0xrp5_c5wwg74eAT7A9GvCXA@mail.gmail.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	Yafang Shao <laoar.shao@gmail.com>, cem@kernel.org, linux-xfs@vger.kernel.org, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:43=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jun 06, 2025 at 12:43:20PM +0200, Christian Brauner wrote:
> > On Mon, Jun 02, 2025 at 05:03:27PM -0700, Darrick J. Wong wrote:
> > > On Sun, Jun 01, 2025 at 09:02:25AM +1000, Dave Chinner wrote:
> > > > On Fri, May 30, 2025 at 08:38:47AM -0700, Darrick J. Wong wrote:
> > > > > On Fri, May 30, 2025 at 07:17:00AM +0200, Christian Brauner wrote=
:
> > > > > > On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote=
:
> > > > > > > On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > Recently, we encountered data loss when using XFS on an HDD=
 with bad
> > > > > > > > blocks. After investigation, we determined that the issue w=
as related
> > > > > > > > to writeback errors. The details are as follows:
> > > > > > > >
> > > > > > > > 1. Process-A writes data to a file using buffered I/O and c=
ompletes
> > > > > > > > without errors.
> > > > > > > > 2. However, during the writeback of the dirtied pagecache p=
ages, an
> > > > > > > > I/O error occurs, causing the data to fail to reach the dis=
k.
> > > > > > > > 3. Later, the pagecache pages may be reclaimed due to memor=
y pressure,
> > > > > > > > since they are already clean pages.
> > > > > > > > 4. When Process-B reads the same file, it retrieves zeroed =
data from
> > > > > > > > the bad blocks, as the original data was never successfully=
 written
> > > > > > > > (IOMAP_UNWRITTEN).
> > > > > > > >
> > > > > > > > We reviewed the related discussion [0] and confirmed that t=
his is a
> > > > > > > > known writeback error issue. While using fsync() after buff=
ered
> > > > > > > > write() could mitigate the problem, this approach is imprac=
tical for
> > > > > > > > our services.
> > > > > > > >
> > > > > > > > Instead, we propose introducing configurable options to not=
ify users
> > > > > > > > of writeback errors immediately and prevent further operati=
ons on
> > > > > > > > affected files or disks. Possible solutions include:
> > > > > > > >
> > > > > > > > - Option A: Immediately shut down the filesystem upon write=
back errors.
> > > > > > > > - Option B: Mark the affected file as inaccessible if a wri=
teback error occurs.
> > > > > > > >
> > > > > > > > These options could be controlled via mount options or sysf=
s
> > > > > > > > configurations. Both solutions would be preferable to silen=
tly
> > > > > > > > returning corrupted data, as they ensure users are aware of=
 disk
> > > > > > > > issues and can take corrective action.
> > > > > > > >
> > > > > > > > Any suggestions ?
> > > > > > >
> > > > > > > Option C: report all those write errors (direct and buffered)=
 to a
> > > > > > > daemon and let it figure out what it wants to do:
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-li=
nux.git/log/?h=3Dhealth-monitoring_2025-05-21
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfspro=
gs-dev.git/log/?h=3Dhealth-monitoring-rust_2025-05-21
> > > > > > >
> > > > > > > Yes this is a long term option since it involves adding upcal=
ls from the
> > > > > >
> > > > > > I hope you don't mean actual usermodehelper upcalls here becaus=
e we
> > > > > > should not add any new ones. If you just mean a way to call up =
from a
> > > > > > lower layer than that's obviously fine.
> > > > >
> > > > > Correct.  The VFS upcalls to XFS on some event, then XFS queues t=
he
> > > > > event data (or drops it) and waits for userspace to read the queu=
ed
> > > > > events.  We're not directly invoking a helper program from deep i=
n the
> > > > > guts, that's too wild even for me. ;)
> > > > >
> > > > > > Fwiw, have you considered building this on top of a fanotify ex=
tension
> > > > > > instead of inventing your own mechanism for this?
> > > > >
> > > > > I have, at various stages of this experiment.
> > > > >
> > > > > Originally, I was only going to export xfs-specific metadata even=
ts
> > > > > (e.g. this AG's inode btree index is bad) so that the userspace p=
rogram
> > > > > (xfs_healer) could initiate a repair against the broken pieces.
> > > > >
> > > > > At the time I thought it would be fun to experiment with an anonf=
d file
> > > > > that emitted jsonp objects so that I could avoid the usual C stru=
ct ABI
> > > > > mess because json is easily parsed into key-value mapping objects=
 in a
> > > > > lot of languages (that aren't C).  It later turned out that forma=
tting
> > > > > the json is rather more costly than I thought even with seq_bufs,=
 so I
> > > > > added an alternate format that emits boring C structures.
> > > > >
> > > > > Having gone back to C structs, it would be possibly (and possibly=
 quite
> > > > > nice) to migrate to fanotify so that I don't have to maintain a b=
unch of
> > > > > queuing code.  But that can have its own drawbacks, as Ted and I
> > > > > discovered when we discussed his patches that pushed ext4 error e=
vents
> > > > > through fanotify:
> > > > >
> > > > > For filesystem metadata events, the fine details of representing =
that
> > > > > metadata in a generic interface gets really messy because each
> > > > > filesystem has a different design.
> > > >
> > > > Perhaps that is the wrong approach. The event just needs to tell
> > > > userspace that there is a metadata error, and the fs specific agent
> > > > that receives the event can then pull the failure information from
> > > > the filesystem through a fs specific ioctl interface.
> > > >
> > > > i.e. the fanotify event could simply be a unique error, and that
> > > > gets passed back into the ioctl to retreive the fs specific details
> > > > of the failure. We might not even need fanotify for this - I suspec=
t
> > > > that we could use udev events to punch error ID notifications out t=
o
> > > > userspace to trigger a fs specific helper to go find out what went
> > > > wrong.
> > >
> > > I'm not sure if you're addressing me or brauner, but I think it would=
 be
> > > even simpler to retain the current design where events are queued to =
our
> > > special xfs anonfd and read out by userspace.  Using fanotify as a "d=
oor
> > > bell" to go look at another fd is ... basically poll() but far more
> > > complicated than it ought to be.  Pounding udev with events can resul=
t
> > > in userspace burning a lot of energy walking the entire rule chain.
> >
> > I don't think we need to rush any of this. My main concern is that if w=
e
> > come up with something then I want it to be able to be used by other
> > filesystems as this seems something that is generally very useful. By
> > using fanotify we implicitly enable this which is why I'm asking.
> >
> > I don't want the outcome to be that there's a filesystem with a very
> > elaborate and detailed scheme that cannot be used by another one and
> > then we end up with slightly different implementations of the same
> > underlying concept. And so it will be impossible for userspace to
> > consume correctly even if abstracted in multiple libraries.
>
> Hrm.  I 60% agree and 60% disagree with you. :D
>
> 60% disagree: for describing problems with internal filesystem metadata,
> I don't think there's a generic way to expose that outside of ugly
> stringly-parsing things like json.  Frankly I don't think any fs project
> is going to want a piece of that cake.  Maybe we can share the mechanism
> for returning fs-specific metadata error information to a daemon, but
> the structure of the data is going to be per-filesystem.  And I think
> the only clients are going to be written by the same fs folks for
> internal purposes like starting online fsck.
>
> 60% agree: for telling most programs that "hey, something went wrong
> with this file range", I think it's completely appropriate to fling that
> out via the existing generic fsnotify mechanisms that ext4 wired up.
> I think the same applies to sending a "your fs is broken" event via
> fsnotify too, in case regular user programs decide they want to nope
> out.  IIRC there's already a generic notification for that too.
>
> Fortunately the vfs hooks I wrote for xfs_healer are general enough that
> I don't think it'd be difficult to wire them up to fsnotify.
>
> > I think udev is the wrong medium for this and I'm pretty sure that the
> > udev maintainers agree with me on this.
> >
> > I think this specific type of API would really benefit from gathering
> > feedback from userspace. There's All Systems Go in Berlin in September
> > and that might not be the worst time to present what you did and give a
> > little demo. I'm not sure how fond you are of traveling though rn:
> > https://all-systems-go.io/
>
> I like travelling!  But happily, I'll be travelling for most of
> September already.
>
> But yeah, I've wondered if it would be useful to write a generic service
> that would hang around on dbus, listen for the fsnotify events, and
> broadcast them to clients.  I suspect that sifting through all the
> containerization and idmapping stuff so that app A can't hear about
> errors in app B's container might be a lot of work though.
>

FWIW, I would like to endorse the creation of systemd-fsnotifyd
regardless of whether it is being used to report fs errors.

If https://man.archlinux.org/man/core/systemd/systemd-mountfsd.8.en
can mount a filesystem for an unpriv container, then this container
also needs a way to request a watch on this filesystem, to be
notified on either changes, access or errors.

Thanks,
Amir.

