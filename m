Return-Path: <linux-fsdevel+bounces-40638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47049A2614D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CE11656EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAACA20E315;
	Mon,  3 Feb 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwxppG1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91120E320
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738603206; cv=none; b=XcrrncHushl86GF8pGNG7XtmJ/DNkW9u3ZSCDRtnGl8cnz+yTmQcUbZJRg/3EpcGtFCOM39XZn2l4eIQSBEM9POu7KF5FSP3ld7JZxTTwqi/rwSGJyPyN5Df3RLB2EP5RHXhkb0noA5cQ2TISwhWEBbrez2DBmuBmG6gxrGPWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738603206; c=relaxed/simple;
	bh=oyiuh8CDw2U/BQGkhv0tSo9vkzrdE8++PILaBRqFCcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKM6NX48adA+qY/VM9I5c330ntAxkJ5fADwHhDO2DDtu+fC+0d60Ez8Y+Gn14eAeKquNoQ43Nji6F9MmKYUNEECGlnwY+AdMGieK7nFDbZUiAZ2SzqkjUGrsOy9sErNmKiq8cuTnVC7e6Jv+rGRwm74Z9V+XShCwTTt4BmqbpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwxppG1M; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e384e3481so4280047e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738603202; x=1739208002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyA5hNwlXVppOkiknLaPca0P0B98Q1U6jHcR33IM4Zk=;
        b=LwxppG1M9uCCWOorc+f9Ke0En9/L1jO05fP1vtIUZbgmmwwWccEDszAnLswOXzj2QZ
         HShHn/YzzNLrzb1yyh6vCwvbWcvjpO+CvZppACdZGTeuY7AEyQxFbdmDlDvHghwUCjlQ
         Vse2GtMRHUVcGpdW87OZF4E0XgLj0XBXJpvabqOa2Z5KAXJ6r+yTgVbjKyAjx4myvQzh
         Tl7qtxCnZY6Ju6gTppHcvNM+SfYJ50t1HU/4LLNcj4+okuQlg6H0L+l+fKqE75HgNaWD
         Rskth8iahG9ZNNygQqJBKXbZkWZyHagWDPBW4lG3mm+Xy+GHu8x+/XoJBjHO+cHse+gg
         HTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738603202; x=1739208002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyA5hNwlXVppOkiknLaPca0P0B98Q1U6jHcR33IM4Zk=;
        b=pDdlU+jPzz2TkxFfdhfgSMfFZzfwjot0O8By8q6qFGQcv7nL3zQq7yE3pVzBT6xt8T
         Z204fN6pZXOtQiiMm7aToy8jGTClr32U1F4xWJ01z59GKXzLqx76qUqVhBdZClCXa85/
         +ePYL5VyJ7iV2Yvp1/Cju1JPE6IHUvl5zIzb8TD77wygTnhU21ngfhIeeSAP3HV+Ip8c
         Gw3vYrLqV/iQajjWoPIUaNQMWn7sGOVaFIRRnrp5lsTRXum6Q+fUjogUvVgEwmDW6TsK
         dRJ9b3NGrASy8xpCnqz4pQbnZORqbBheHAlJeCzZwZ3RwwL0x8vwqitQdg1SDAD/QsdE
         jY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIHQ0nfnuyMmgEFNXkhcMCcJ7Os2kSXr1Bu55cTWSgt1XtWOHySnrum0SzMFfhFTTtp1dsa0l2n3ifjQBr@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7DHqJVnCxfZVR6o4buMAkAHQr0IriOs+9lSXPzcbH8yFyvhR
	u9EcReXIQ59Os41JJEBlJi0FeyLaQAV+cEGmMBj5MEU6EF+q5dBdNOPQQZQ1rKQI/B7C7OdyiKJ
	yA8FG/vpDGsOEuucpxe0/fL+4Yq4=
X-Gm-Gg: ASbGncs8WEKHe4MAYBcbPjXIx+k3EOpHClwGRunZR03ZfvJUQHFR7OJgBb3H/pDS1hB
	83nrUFTWxGsHsc2lZNcU6ypjIYTPD3RyOZDdrj6Khdh60NYCwh0qlSWoHagZHaDw+m1hfhW7TdJ
	dYXAL66yjPzJLKg2xLnrSpcrkyBhA/l7I=
X-Google-Smtp-Source: AGHT+IHyKGym57K3SDxXnBX9YWHX+2UPkeo1muWz2Ff4/fiQ32CN0xa9LzjrlMDdoZd/HyITjLpMHcnrq7OOpn+Y3Zw=
X-Received: by 2002:a19:7611:0:b0:542:297f:4ec9 with SMTP id
 2adb3069b0e04-543e4be9838mr5931318e87.14.1738603202278; Mon, 03 Feb 2025
 09:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z41z9gKyyVMiRZnB@dread.disaster.area> <173732553757.22054.12851849131700067664@noble.neil.brown.name>
 <Z472VjIvT78DskGv@dread.disaster.area> <2aa2cea5a36dd1250134706e31fd0fa42cdf0fd4.camel@kernel.org>
In-Reply-To: <2aa2cea5a36dd1250134706e31fd0fa42cdf0fd4.camel@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Mon, 3 Feb 2025 11:19:55 -0600
X-Gm-Features: AWEUYZmJLT-smcfFndxo_eBrn620v53UNbvnytoldJBRMJN-yZZnzOxolHZ2KIw
Message-ID: <CAH2r5mtCbfw=XArYZhQ5m6pKW-==PpkPp2W2xFqzZXVYq1wY3A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, lsf-pc@lists.linuxfoundation.org, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 7:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2025-01-21 at 12:20 +1100, Dave Chinner wrote:
> > On Mon, Jan 20, 2025 at 09:25:37AM +1100, NeilBrown wrote:
> > > On Mon, 20 Jan 2025, Dave Chinner wrote:
> > > > On Sat, Jan 18, 2025 at 12:06:30PM +1100, NeilBrown wrote:
> > > > >
> > > > > My question to fs-devel is: is anyone willing to convert their fs=
 (or
> > > > > advice me on converting?) to use the new interface and do some te=
sting
> > > > > and be open to exploring any bugs that appear?
> > > >
> > > > tl;dr: You're asking for people to put in a *lot* of time to conver=
t
> > > > complex filesystems to concurrent directory modifications without
> > > > clear indication that it will improve performance. Hence I wouldn't
> > > > expect widespread enthusiasm to suddenly implement it...
> > >
> > > Thanks Dave!
> > > Your point as detailed below seems to be that, for xfs at least, it m=
ay
> > > be better to reduce hold times for exclusive locks rather than allow
> > > concurrent locks.  That seems entirely credible for a local fs but
> > > doesn't apply for NFS as we cannot get a success status before the
> > > operation is complete.
> >
> > How is that different from a local filesystem? A local filesystem
> > can't return from open(O_CREAT) with a struct file referencing a
> > newly allocated inode until the VFS inode is fully instantiated (or
> > failed), either...
> >
> > i.e. this sounds like you want concurrent share-locked dirent ops so
> > that synchronously processed operations can be issued concurrently.
> >
> > Could the NFS client implement asynchronous directory ops, keeping
> > track of the operations in flight without needing to hold the parent
> > i_rwsem across each individual operation? This basically what I've
> > been describing for XFS to minimise parent dir lock hold times.
> >
>
> Yes, basically. The protocol and NFS client have no requirement to
> serialize directory operations. We'd be happy to spray as many at the
> server in parallel as we can get away with. We currently don't do that
> today, largely because the VFS prohibits it.
>
> The NFS server, or exported filesystem may have requirements that
> serialize these operations though.
>
> > What would VFS support for that look like? Is that of similar
> > complexity to implementing shared locking support so that concurrent
> > blocking directory operations can be issued? Is async processing a
> > better model to move the directory ops towards so we can tie
> > userspace directly into it via io_uring?
> >
>
> Given that the VFS requires an exclusive lock today for directory
> morphing ops, moving to a model where we can take a shared lock on the
> directory instead seems like a nice, incremental approach to dealing
> with this problem.
>
> That said, I get your objection. Not being able to upgrade a rwsem
> makes that shared lock kind of nasty for filesystems that actually do
> rely on it for some parts of their work today.
>
> The usual method of dealing with that would be to create a new XFS-only
> per-inode lock that would take over that serialization. The nice thing
> there is that you could (over time) reduce its scope.
>
> > > So it seems likely that different filesystems
> > > will want different approaches.  No surprise.
> > >
> > > There is some evidence that ext4 can be converted to concurrent
> > > modification without a lot of work, and with measurable benefits.  I
> > > guess I should focus there for local filesystems.
> > >
> > > But I don't want to assume what is best for each file system which is
> > > why I asked for input from developers of the various filesystems.

This is an interesting question for SMB3.1.1 as well (cifs.ko etc.), especi=
ally
in workloads where the client already has a directory lease on the director=
y
being updated (and with multichannel there could be quite a bit of i/o in
flight), but even without a directory lease there is no restriction on send=
ing
multiple simultaneous directory related requests to the server


--=20
Thanks,

Steve

