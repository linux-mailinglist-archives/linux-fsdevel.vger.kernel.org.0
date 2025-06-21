Return-Path: <linux-fsdevel+bounces-52382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C8AE2C89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3559E178BA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 21:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F44271453;
	Sat, 21 Jun 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkZSqp5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD671922F5;
	Sat, 21 Jun 2025 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750540087; cv=none; b=rA4iFyeIgL2/MKbOc7hTXaaRhJ+8ezUItEw7a7IYIT2lN+CU36GrltdsFF0ziORpCClEeI+iUphR36arh+vQEufY9P2Ad/1w7G0Y8mjXdaF4FTUC9dG/ELDSuWxUDSSy9j4FtEshxnptHmGcE2pNThwYmhgT+AX++jZ9A8+B3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750540087; c=relaxed/simple;
	bh=uPDd/tkXLBy6YrHz+vlFMwbnMsgJeHXQAl7bLYKRZDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPhtJT57XLjYBfkwlDzBH3J+jcnaaAak+Q+DwKTHkNig7cfopwyDR6liShSibikooSFPSIIlkmT4dBw6nGMR0wdL35PMzBG2s9UsytsTAm33bwgSfcM+vTLGXqYEdt4NmPW4Z5cfFaPvawhl9P+2K6YkCm2iX+82089W9IStXmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkZSqp5l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450dd065828so20517045e9.2;
        Sat, 21 Jun 2025 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750540084; x=1751144884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riSivno+40WkCPg3f0KCZEq+ljs5At6s0yvmxVtoNPo=;
        b=LkZSqp5lDpxHqoDrOv5AfSwC//p2c5xvu33vzdPriErO7a3r5QABKz3PtCrqxtICQp
         ms3Fn/u1um7EFOt94I1xRQftylpHWQlzW/bb7HxlmtCxCO01TPObSkuDOiRSQATND4RW
         Xx6N8biTXLzotiSsNqhHfUfNwJTGLIuWLf9Lp04N/Lv4ilDu75L3I6VISgcLmRVjsEfi
         vo9ZdpyMCKnHc8DN7d8BJq2pf5Bm2nzmkPEDUz0qywUVvfVwNmJi3mGmGVkq/awz+f/C
         j78KoC7ZIMJzjrjh7TW2aYplG+CeXtQiLBNW0VlblfoOpS/51ZXoFRzjemOit/x2LYlO
         7k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750540084; x=1751144884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riSivno+40WkCPg3f0KCZEq+ljs5At6s0yvmxVtoNPo=;
        b=K9O7OfC+YSYQlnUDd42ehDmVnE/mujs9fAk6L+wxU8IIJHGOYpYLukBdBHcaiq9l/E
         yCwd8HAmsI+gLQ5fkSapyo1SiPduPFyerFHqOhCxjkB87hj4YbWYa39WdzS3xPnHa5S1
         PfJ6TmNAIa/Al+acgBYwiU1NG166Ue8YtTPEDEx3ukRGxEaAhk7MLWSAIc3boMLccgUC
         krdnt/EgQ20z00oAFrcNm28YBfFf9u39gXCF5Ajq21uMfblHvdkFBXfM4F9whcPZ0MIX
         zU/DpERJTp3kh5vcAra9io27uWCJlvcrKrZ1LQWKIIPiedBx8ADk44goXlkPizON7cEv
         kXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlij/i0EEeJomjxf6DoezbYWvrjl9sVGyD3GOWBLwbau+6rU8ugdNO6ElybHJ1NF2lcqTAUXtcbQEB6Zll@vger.kernel.org, AJvYcCXaAcmJAYAb2lBDk6kfTA3cOzJP2RLfsL0bV1OatNOYR3JQXzPHWYRJmbisTj6KS08iPnKAlq/KXrRwxF/D@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpbre6zzuYFoA8/khOPxZSQu59xMV6vV6n61wbQsK2h7EtBgt1
	IVv58cFfshsiQ5UYhChwkuw8cMFO5waBxTBZk0LrZzeOVqFlZNF6VtzFaBdM8KZ38/8kaq2DfE3
	HOvQzF9xjDrElz4rZDf0fWKLFi2pwbqrN3nu2YMY=
X-Gm-Gg: ASbGncsXHeSA7smWh3DGYFy80wmmTplPFnG4+086OyHXwVAYzctxFcNIm8LlTvz5PwE
	IBIhCtHLH3r4vVq50utIl+qx+4VlrUSiJAG4/eqFzaBQKcrUQESg8Z4iBtrXLgtCuF1TSAizDHX
	woIISzflC3PHUDBzlUG+/FQaTBW3pyfyKK4S064dheuubqC60qr1+WPxFtwRbdb08gCq8=
X-Google-Smtp-Source: AGHT+IHZk7tjDFiREsVqU/a9clYRf3wAOlGSNhsjyaGFAw+IAuGXaohAEn0ihq0CzA0RNkU21ZK7EYfmyPzQG5PeL60=
X-Received: by 2002:a5d:5e88:0:b0:3a4:f63b:4bfc with SMTP id
 ffacd0b85a97d-3a6d12d909bmr6895994f8f.34.1750540083273; Sat, 21 Jun 2025
 14:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi> <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
 <3366564.44csPzL39Z@lichtvoll.de> <hewwxyayvr33fcu5nzq4c2zqbyhcvg5ryev42cayh2gukvdiqj@vi36wbwxzhtr>
 <20250620124346.GB3571269@mit.edu> <bwhemajjrh7hao5nzs5t2jwcgit6bwyw42ycjbdi5nobjgyj7n@4nscl4fp6cjo>
 <ztqfbkxiuuvsp7r66kqxlnedca3h5ckm5wscopzo2e4z33rrjg@lyundluol5qq>
In-Reply-To: <ztqfbkxiuuvsp7r66kqxlnedca3h5ckm5wscopzo2e4z33rrjg@lyundluol5qq>
From: =?UTF-8?B?SsOpcsO0bWUgUG91bGlu?= <jeromepoulin@gmail.com>
Date: Sat, 21 Jun 2025 17:07:51 -0400
X-Gm-Features: AX0GCFs2T-tl-RzeUPoPS_vHTQdbWDsrtUBVVK2vC0_8Ocbm9nuxqiLN1W58aeg
Message-ID: <CALJXSJrWjsAgN8HDUAhr5WYB97_YS57PuAhwpRctpNFU6=4AKQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
To: linux-bcachefs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "Theodore Ts'o" <tytso@mit.edu>, 
	Martin Steigerwald <martin@lichtvoll.de>, Jani Partanen <jiipee@sotapeli.fi>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As a bcachefs user who has been following this discussion, I'd like to
share my perspective on the current state of the filesystem and the
path forward.

I'm currently using this filesystem for a backup staging server so it
is easy for me to make sure data isn't getting lost and can verify
checksums at the application levels from time to time. The solution
uses snapshots extensively as well as replication, reflinks and
background compression.

I really like this filesystem for multiple reasons, it fills the gap
for missing features of traditional filesystems, it allows integrating
cache devices almost seamlessly, it allows having metadata on local
devices while still pushing to slow HDD, SMR or network devices
without having to setup something like Ceph or a stack like Btrfs,
mdadm and nbd/iSCSI.  I've seen all the features appear one by one on
Bcachefs and it is growing fast.

I migrated from Btrfs after an incident with a RAID controller losing
its cache that caused the filesystem to be unmountable and
unrepairable.  Btrfs restore was able to recover *most* of the files
on that server except a couple subvolumes which had to be recreated by
the backup system.  And again, since this is a staging area for
backups, I don't need 100% uptime or a guarantee that my files won't
be lost so I felt pretty confident in using Bcachefs to speed up
operations there.

Bcachefs was able to triple the speed of the backup system by having
metadata stored in NVMe + passively caching all writes to NVMe.  The
last part of the backup is now blazing fast since everything is in
NVMe.

At this point in time, I do believe Bcachefs has solid foundations, as
of now, the only data corruption that lost me some files were related
to a snapshot deletion bug for a feature that was not yet published to
mainline.

It hasn't been without its downsides, many times I had to take the
filesystem for offline repair and Kent was always able to figure out
the root cause of issues causing the FS not to mount read-write and
issue a patch for the FS and for fsck.  We found many weird bugs
together, ARM specific bugs, reflink causing corruption, resize not
allocating buckets, many races and lock ups, upgrade not finishing
correctly, corruption from weird interactions, data not staying cached
when there's no promote_target.  All of this was fixed without much
more damage than the last operations being lost and most were fixed
really quickly from cat'ing a couple diagnostic files, using perf or
worst case metadata image.

The filesystem is very resilient at being rebooted anywhere, anytime.
It went through many random resets during any of..  fsck repairs, fsck
rebuilding the btree from scratch, upgrades, in the middle of snapshot
operations, while replaying journal.  It just always recovers at
places I wouldn't expect to be able to hit the power switch. Worst
case, it mounted read-only and needed fsck but could always be mounted
read-only.

It also went through losing 6 devices and the write-back cache (that
defective controller, again).  Fsck could repair it with minimal loss
related to recent data. A lot of scary messages in fsck, but it
finished and I could run scrub+rereplicate to finish it off (which
fixed a couple more files).

Where things get a bit more touchy is when combining all those
features together;  operations tend to be a bit "racy" between each
other and tend to lock up when there's multiple features running/being
used in parallel.  I think this is where we get to the "move fast
break things" part of the filesystem.  The foundation is solid, read,
write, inode creations/suppression, bucket management, all basic posix
operations, checksums, scrub, device addition. Many of the
bcachefs-specific operations are stable, being able to set compression
and replication level and data target per folder is awesome stuff and
works well.

From my experience, what is less polished are; snapshots and snapshot
operations, reflink, nocow, multiprocess heavy workloads, those seem
to be where the "experimental" part of the filesystem goes into the
spotlight.  I've been running rotating snapshots on many machines, it
works well until it doesn't and I need to reboot or fsck. Reflink
before 6.14 seemed a bit hacky and can result in errors. Nocow tends
to lock up but isn't really useful with bcachefs anyway. Maybe
casefolding which might not be fully tested yet. Those are the true
experimental features and aren't really labelled as such.

We can always say "yes, this is fixed in master, this is fixed in
6.XX-rc4" but it is still experimental and tends to be what causes the
most pain right now.  I think this needs to be communicated more
clearly. If the filesystem goes off experimental, I think a subset of
features should be gated by filesystem options to reduce the need for
big and urgent rc patches.

The problem is...  when the experimental label is removed, it needs to
be very clear that users aren't expected to be running the latest rc
and master branch.  All the features marked as stable should have
settled enough that there won't be 6 users requiring a developer to
mount their filesystem read-write or recover files from a catastrophic
race condition.

This is where communication needs to be clear, bcachefs website,
tools, options; should all clearly label features that might require
someone to ask a developer's help or to run the latest release
candidate or a debug version of the kernel.

Bcachefs has very nice unit and integration testing with ktest, but it
isn't enough to represent real-world usage yet and that's why I think
some features should still be marked just as experimental as erasure
coding.  Bcachefs filesystem where I do not use reflink, snapshot or
anything wild, only multiple devices with foreground/promote_target,
replication, compression, never experience weird issues or lockups for
many kernel versions now.  Mind you, I'm not using bcachefs on any
rootfs yet, only specific use-case and patterns that can be
documented.

I care about the future and success of bcachefs to be my go-to
filesystem for anything that requires CoW features, robust repair
tools, caching and flexible RAID-like features.  I just don't want it
to get kicked out of the kernel because of huge changesets to fix bugs
on features that shouldn't be used by someone who expects the
filesystem to behave.

It might slow down development a bit to mark some features as
experimental, but it'll remove the pressure of having to push so many
bug fixes that are critical to make sure users don't experience
critical failures or blindly try to repair their FS using fsck -y
without reporting issues. It reduces the experimental surface to a
subset of features, it also makes the user aware of what they should
do if enabled, eg.: contact dev before fsck -y, run a recent kernel at
all time, etc.

One more thing that I think is missing, many patches submitted, even
if it doesn't show up, should have a Reported-By and Tested-By tag to
help show how many people in the community are working and helping
make Bcachefs great, it would also make people on the ML aware that
patches aren't just thrown in there; it usually has been a reported
bug from a community member which had to test the resulting patch.

Anyway, that message is bigger than I expected and I hope brings some
light on how I perceive bcachefs from a user standpoint.

Have a great weekend!

On Fri, Jun 20, 2025 at 8:15=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Jun 20, 2025 at 07:35:04PM -0400, Kent Overstreet wrote:
> > So it's hard to fathom what's going on here.
>
> I also need to add that this kind of drama, and these responses to pull
> requests - second guessing technical decisions, outright trash talk -
> have done an incredible amount of damage, and I think it's time to make
> you guys aware of that since it's directly relevant to the story of this
> pull request.
>
> I've put a lot of work into building a real community around bcachefs,
> because that's critical to making it the rock solid, dependable
> filesystem, for eeryone, that I intend it to be: building a community
> where people feel free to share observations, bug reports, and where
> people trust that those will be acted on responsibly.
>
> That all gets set back whenever drama like this happens. Last time, the
> casefolding bugfix pull request, ignited a whole vi. vs. emacs holy war.
> Every time this happens, the calm, thoughtful people pull back, and all
> I hear from are the angry, dramatic voices.
>
> More than that, I lost a hire because of Linus's constant,
> every-other-pull-request "I'm thinking about removing bcachefs from the
> kernel". It turns out, smart, thoughtful engineers with stable jobs
> become very hesitant about leaving those jobs when that happens, and
> that's all their co-workers are seeing.
>
> And the first thing that got cancelled/put aside because of that - work
> that was in progress, and hasn't been completed - was tooling for
> comprehensive programatic fault injection for on disk format errors.
> IOW - the tooling and test coverage that would have caught the subvolume
> deletion bug.
>
> That's a really painful loss right now.
>
> Even despite that, bcachefs development has been going incredibly
> smoothly, and it's shaping up fast. Like I mentioned before, 100+ TB
> filesystems are commonplace, users are commenting every release on how
> much smoother is getting. We are, I hope, only a year or less from being
> able to take the experimental label off, based on the decline in
> critical bug reports I'm seeing.
>
> The only area that gives me cause for concern - and it causes a _lot_ of
> concern - is upstream.
>

