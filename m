Return-Path: <linux-fsdevel+bounces-41568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D6A3211B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 09:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CB63A2601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 08:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D65A205500;
	Wed, 12 Feb 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOk/F4H3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D7204F9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348978; cv=none; b=m2Q3cHtnj0Bl4YBJCbqEdux676Um+vJgx6w9NRx5fOi8YcoAMj7NOHsiTtzJIP3kw5cIJzM30QX2iHiVmZEbADrdCBgRauG297WIjpGE/AiKos7koNGuVfuUndyLgZ//qHpEGPL6KHXZPk4dCObxQEjX5PJyr6dJ8uAunOFLW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348978; c=relaxed/simple;
	bh=umv2DRYQJsuu7rvZ7Kv88UypslAIDD7Yh1a2iZVi6lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6XpPZR7UuAkpYiXbUdrX+EJhZ3bGPG+Wm73YdLC/mEMYE3gzdsVAXn2Z2BU8MZMQ0ZGOY6ZkZMF0/IGKXRJrQyBUbVjzgR3/t5NVvbfrhuq+/NTH7CZjzD3+eQbr8ldJ9TuWi1EgSsD3kBWUnShIpAxbjY2l49b0H3gwBPCxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOk/F4H3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso10512604a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 00:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739348974; x=1739953774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAbqNqFqxSbO5dFVFkBsj4amCT9ZLrmoWiMfS41IojE=;
        b=FOk/F4H3RrNwAzyWIMEmbFZFoMRG002Nt5WAEByA7lR3Rc/KtmAT0A5COvxhzqquq9
         HCbMDnucybXYJ5BXiix3sXYjMEbKEkpGfiTEFfvRC/epc2DpogxJ9Qe+9PHq7Fh8c+Oi
         GW+Gk3F06BUhmRaeqUH9HgXwn5t4tlip6YuNEDzZPETs2iRQ5wAHbMtu6wJ9WSB3UIA3
         wVxiMRbMThkFPruPRy1s3upH/F4GOOk6ArlekyvQFlW56LqUtXSwCLqUzN0WNfLCip+m
         4c64rdQerWBru/qJgZSdYhECLqw/0ZDV/XwbfCXA57ukfHE2ZaI9PwubTWh7Y1Ohbvh+
         +WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348974; x=1739953774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAbqNqFqxSbO5dFVFkBsj4amCT9ZLrmoWiMfS41IojE=;
        b=kDW/1osbOZsjjh8qH+HuwDkyj7IHPU688uYHjJpmyoGn0TXY1nUWoddzA6MhTN5LQt
         EV6BOZ+pgRlNexdXdkyZyOjA0vBAoglSSwb0WbLpLdMHD0rQPhTyI4rLGeYXpTcYB+g9
         KlL9T1yqiaKWD/UZLuxWL41sSlNsyyURYuJ6boHQ97l/CCZeGoQxY+8gnl4f0gv2TPZQ
         bKNiq2dO3WQbUeNi1MLLHEvpJRc+Kz2FWEhbtyA7MewnZbZH+BQlRsIWdydplm4Inxgu
         dM5SKdJ6hsc/kmdMgDSxMsB5uI+1tCRj3/50y2cUgXMKgH1zHtxaIivf6S/BBFTIAgFU
         C8Xg==
X-Gm-Message-State: AOJu0YywBXRQFD5B7HC3oN5zs+a0y2z1EBt406tQXAfTizQr688xPe7O
	i7GsCPRwN3RCujl+tBs0OsDOPrV2sJfBONf6C29/0OnYMjJ9GgHn8Ij1G8BDx5qbH+w6RB23zy1
	4Gop19yYCaqX0lSaFRpnGEqUseaKETXGBm8I=
X-Gm-Gg: ASbGnctz/zGoI8MsneFAZHWaPF59T45BX3ih7ocXdtaXcIwXDFaEFNjcIiovhdKpqta
	xcxKnK2DRdk3ob1Sbs7QzyAflSD7unZsYO+yPfH8jUMiY6sIoff46aCOOwR+SkLAiOXeUXnxh
X-Google-Smtp-Source: AGHT+IG2bLnR7dCm+1Zpk7i6T8Y7qY2kobvFCTWZzJM5mfEAsNobSftR/TKQi+5SvhTX/CDFvuCoE4v3gfD0vUnPxhs=
X-Received: by 2002:a05:6402:2087:b0:5d0:b2c8:8d04 with SMTP id
 4fb4d7f45d1cf-5deaddba538mr1915106a12.18.1739348973993; Wed, 12 Feb 2025
 00:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area> <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <Z5gX7hTPhTtxam1g@dread.disaster.area> <CAOQ4uxj6k1TbeHgcP8yeMGQ2SaVscDe8SGYk8U3Liy02CBdC4A@mail.gmail.com>
 <Z6u9I5L3LqCOtf7C@dread.disaster.area>
In-Reply-To: <Z6u9I5L3LqCOtf7C@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 12 Feb 2025 09:29:22 +0100
X-Gm-Features: AWEUYZlWgDt2u6DSNf_gIRfC5oojDnzNKGFbx4IJhm2zbUnNiinh9g2UZrG3B3M
Message-ID: <CAOQ4uxgq9zajSrKMph8L7zH9sFbsDf8vp5W-XZAu48f8gmPY2g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:12=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Wed, Jan 29, 2025 at 02:39:56AM +0100, Amir Goldstein wrote:
> > On Tue, Jan 28, 2025 at 12:34=E2=80=AFAM Dave Chinner <david@fromorbit.=
com> wrote:
> > >
> > > On Mon, Jan 20, 2025 at 12:41:33PM +0100, Amir Goldstein wrote:
> > > > On Sun, Jan 19, 2025 at 10:15=E2=80=AFPM Dave Chinner <david@fromor=
bit.com> wrote:
> > > > > This proposed write barrier does not seem capable of providing an=
y
> > > > > sort of physical data or metadata/data write ordering guarantees,=
 so
> > > > > I'm a bit lost in how it can be used to provide reliable "crash
> > > > > consistent change tracking" when there is no relationship between
> > > > > the data/metadata in memory and data/metadata on disk...
> > > >
> > > > That's a good question. A bit hard to explain but I will try.
> > > >
> > > > The short answer is that the vfs write barrier does *not* by itself
> > > > provide the guarantee for "crash consistent change tracking".
> > > >
> > > > In the prototype, the "crash consistent change tracking" guarantee
> > > > is provided by the fact that the change records are recorded as
> > > > as metadata in the same filesystem, prior to the modification and
> > > > those metadata records are strictly ordered by the filesystem befor=
e
> > > > the actual change.
> > >
> > > Uh, ok.
> > >
> > > I've read the docco and I think I understand what the prototype
> > > you've pointed me at is doing.
> > >
> > > It is using a separate chunk of the filesystem as a database to
> > > persist change records for data in the filesystem. It is doing this
> > > by creating an empty(?) file per change record in a per time
> > > period (T) directory instance.
> > >
> > > i.e.
> > >
> > > write()
> > >  -> pre-modify
> > >   -> fanotify
> > >    -> userspace HSM
> > >     -> create file in dir T named "<filehandle-other-stuff>"
> > >
> > > And then you're relying on the filesystem to make that directory
> > > entry T/<filehandle-other-stuff> stable before the data the
> > > pre-modify record was generated for ever gets written.
> > >
> >
> > Yes.
> >
> > > IOWs, you've specifically relying on *all unrelated metadata changes
> > > in the filesystem* having strict global ordering *and* being
> > > persisted before any data written after the metadata was created
> > > is persisted.
> > >
> > > Sure, this might work right now on XFS because the journalling
> > > implementation -currently- provides global metadata ordering and
> > > data/metadata ordering based on IO completion to submission
> > > ordering.
> > >
> >
> > Yes.
>
> [....]
>
> > > > I would love to discuss the merits and pitfalls of this method, but=
 the
> > > > main thing I wanted to get feedback on is whether anyone finds the
> > > > described vfs API useful for anything other that the change trackin=
g
> > > > system that I described.
> > >
> > > If my understanding is correct, then this HSM prototype change
> > > tracking mechanism seems like a fragile, unsupportable architecture.
> > > I don't think we should be trying to add new VFS infrastructure to
> > > make it work, because I think the underlying behaviours it requires
> > > from filesystems are simply not guaranteed to exist.
> > >
> >
> > That's a valid opinion.
> >
> > Do you have an idea for a better design for fs agnostic change tracking=
?
>
> Store your HSM metadata in a database on a different storage device
> and only signal the pre-modification notification as complete once
> the database has completed it's update transaction.
>

Yes, naturally.
This was exactly my point in saying that on-disk persistence
is completely orthogonal to the purpose for which sb_write_barrier()
API is being proposed.

> > I mean, sure, we can re-implement DMAPI in specific fs, but I don't thi=
nk
> > anyone would like that.
>
> DMAPI pre-modification notifications didn't rely on side effects of
> filesystem behaviour for correctness.

Neither does fanotify.
My HSM prototype is relying on some XFS side effects.
A production HSM using the same fanotify API could store
changes in a db on another fs or on persistent memory.

> The HSM had to guarantee that
> it's recording of events were stable before it allowed the
> modification to be done.

No change in methodology here.

> Lots of dmapi modification notifications
> used pre- and post- event notifications so the HSM could keep track
> of modifications that were in flight at any given point in time.
>

OK, now we are talking about the relevant point.
Persistent "recording" an intent to change on pre- is fine.
"Notifying" the application that change has been done in pre- is racy,
because the application may wrongly believe that it has already
consumed the notified/recorded change.

Complementing every single pre- event with a matching post-
event is one possible solution and I think Jan and I discussed it as well.
sb_write_barrier() is a much easier API for HSM, because HSM
rarely needs to consume a single change, it is much more likely
to consume a large batch of changes, so the sb_write_barrier() API
is a much more efficient way of getting the same guarantee that
"All the changes recorded with pre- events are observable".

> That way the HSM recovery process knew after a crash which files it
> needed to go look at to determine if the operation in progress had
> completed or not once the system came back up....
>

Yes, exactly what we need and what sb_write_barrier() helps to achieve.

> > IMO The metadata ordering contract is a technical matter that could be =
fixed.
> >
> > I still hold the opinion that the in-core changes order w.r.t readers
> > is a problem
> > regardless of persistence to disk, but I may need to come up with more
> > compelling
> > use cases to demonstrate this problem.
>
> IIRC, the XFS DMAPI implementation solved that problem by blocking
> read notifications whilst there was a pending modification
> notification outstanding. The problem with the Linux DMAPI
> implementation of this (one of the show stoppers that prevented
> merge) was that it held a rwsem across syscall contexts to provide
> this functionality.....
>

sb_write_barrier() allows HSM to archive the same end result without
holding rwsem across syscalls context.
It's literally SRCU instead of the DMAPI rwsem. Not more, not less:

sb_start_write_srcu() --> notify change intent --> HSM record to changes db
               <-- ack change intent recorded <--
...
make in-core changes
...
               <-- wait for changes in-flight <-- sb_write_barrier()
sb_end_write_srcu() --> ack changes in-flight -->
                 <-- persist recorded changes <-- syncfs()
persist in-core changes
                      --> ack persist changes --> HSM notify change consume=
rs

Thanks,
Amir.

