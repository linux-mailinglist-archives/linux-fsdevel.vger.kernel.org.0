Return-Path: <linux-fsdevel+bounces-40273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB888A2161E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 02:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13797166F20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3A17D346;
	Wed, 29 Jan 2025 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAG3QbEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3942A92
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114809; cv=none; b=szd23KDrkHvh6PnWjHEaGiV8QgIGV2LRLz0EnqqLoG2UQPjXYoRm3eNBd6Uw+ATyKVbA+S1a/T+8ydEzj00ZMD4dyV7K/3/aV7j6oUwX183HPKGyci+YtUX8gZVtEf13LOBIJOIhX4LatpD7sgafKlnYyEa+GQpbfAyrpKWtWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114809; c=relaxed/simple;
	bh=bnj+p7QgREE9HelftB5CFFATIV1MvZHYGGcne1oRkeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrcGWmWMtwd/kgNpC44F0Eo+hQunA7cdlG2P4XjozxHaYGuT6vzTSsBqft9CsZ1ghvaPtSvt/P8XWWazp5V+oGO8H4mhte8qZQkPldb4o+G3FMWVheivZesB7Kyt2zN/aUtwNsnaCg0xoD0rEg88Xec6EZF5MQm1xYzclhhlIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAG3QbEn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso12013076a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 17:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738114806; x=1738719606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LqCyxiynKNL6Q8aObO8nZ1ujRy1iDPIKFO23boGSio=;
        b=eAG3QbEnYz0VBPFutmAeDcoKeZguJoPuFEDkPxAusNjrPoj/c+XlQgKLMIxMsJrC8R
         Evyooemy0zS5LzBB4jXgPrIVgrX3ye35sScrnAvt5DMiFCUdpYIJWbdmOQkuvyF2Yyzo
         wzSRtNhfe913NtxkD8dCW0+5W+Xezolp4f2xrAN9xhsYN/AWz02IvyVXcScrR5n9K8XJ
         deH6Qs6JJ0UJmRYZK0TXbMTh2wDO3o8bO6VEgMcl1fbvKhaHWSWf8L3BPvcFpLX0QFu9
         Uz+KCcnkS7wZjvoZOl8nv0e4GhM6HiX7L0QAsToKMK1ZWzkNSoyA31w+pVeeFPDDTIji
         ZhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738114806; x=1738719606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LqCyxiynKNL6Q8aObO8nZ1ujRy1iDPIKFO23boGSio=;
        b=mXF0YLrhDCPseQa7v2kR2rrbA67ukqAv2P1AWDcwb3ROqGIHQFBNO+QXF5keXDpTiy
         eMhND4I14VQTFX1q5GVf27GCXTbPiXFzkoahi3yRQh7H5nGdZJgQw5m2D1yIEBA4A1yg
         rrtEtg0XPSsEbwqI8ONOy3zrLyDd2lus3hRRgeys+o+8Hy6E5YRYH4/7T/hvgRe1hOoq
         RLnlzXT1d8FS0KMsycYTusUW44b//LvGrfAQYR00BOyd0ffARxGWCKhb66JpK5qF9XV4
         z6I1/N2YUlKQkZWuI53+pXn6C1r2YHS/HAsAkq3RdniV7J4ItSRcXfnaG4JeQZe8lpBR
         HiuA==
X-Gm-Message-State: AOJu0YwA5fenSv1NNhREQ04j2vD4ENvGwGOtIiTHdEO3qq9LpiPcaqzS
	Vgc+mViwB9Y0oJ3zDheF9R3/SYAOr/+vzZG2eHTxWzXYcO5yu690dXSPODHkVavUfbrRNd7343/
	VMvYMKD2UJSb03zS0y1xDSYftFhM=
X-Gm-Gg: ASbGncubtma3elDRXfXeWH1c4IuEMG0PNLGIvL2PVOqFa8/X19fLpt8GFeDDLJKVlj/
	BEVDWWqSHDBbiPb00AF+zHdEK9ECUFgyGOOw8tiS6Rd/dBOmdnNbiFsVG80oYXiYpzgVIa88=
X-Google-Smtp-Source: AGHT+IEk+SLypIKgawbQGVfZEsf9IonjsOieHf2ji+Ivwi26DxZ3f0q1TnI/LVxAaMxfrIu8tXY0abJxv4jT4ccjoOM=
X-Received: by 2002:a05:6402:2706:b0:5d4:3105:c929 with SMTP id
 4fb4d7f45d1cf-5dc5f01e7c3mr852303a12.23.1738114805600; Tue, 28 Jan 2025
 17:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area> <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <Z5gX7hTPhTtxam1g@dread.disaster.area>
In-Reply-To: <Z5gX7hTPhTtxam1g@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Jan 2025 02:39:56 +0100
X-Gm-Features: AWEUYZlhP_zGlNziJlUuiHfSxP45pF4CEFJ7PF68qZAJgA4IE-GcuFjK4id9hYc
Message-ID: <CAOQ4uxj6k1TbeHgcP8yeMGQ2SaVscDe8SGYk8U3Liy02CBdC4A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 12:34=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Mon, Jan 20, 2025 at 12:41:33PM +0100, Amir Goldstein wrote:
> > On Sun, Jan 19, 2025 at 10:15=E2=80=AFPM Dave Chinner <david@fromorbit.=
com> wrote:
> > > This proposed write barrier does not seem capable of providing any
> > > sort of physical data or metadata/data write ordering guarantees, so
> > > I'm a bit lost in how it can be used to provide reliable "crash
> > > consistent change tracking" when there is no relationship between
> > > the data/metadata in memory and data/metadata on disk...
> >
> > That's a good question. A bit hard to explain but I will try.
> >
> > The short answer is that the vfs write barrier does *not* by itself
> > provide the guarantee for "crash consistent change tracking".
> >
> > In the prototype, the "crash consistent change tracking" guarantee
> > is provided by the fact that the change records are recorded as
> > as metadata in the same filesystem, prior to the modification and
> > those metadata records are strictly ordered by the filesystem before
> > the actual change.
>
> Uh, ok.
>
> I've read the docco and I think I understand what the prototype
> you've pointed me at is doing.
>
> It is using a separate chunk of the filesystem as a database to
> persist change records for data in the filesystem. It is doing this
> by creating an empty(?) file per change record in a per time
> period (T) directory instance.
>
> i.e.
>
> write()
>  -> pre-modify
>   -> fanotify
>    -> userspace HSM
>     -> create file in dir T named "<filehandle-other-stuff>"
>
> And then you're relying on the filesystem to make that directory
> entry T/<filehandle-other-stuff> stable before the data the
> pre-modify record was generated for ever gets written.
>

Yes.

> IOWs, you've specifically relying on *all unrelated metadata changes
> in the filesystem* having strict global ordering *and* being
> persisted before any data written after the metadata was created
> is persisted.
>
> Sure, this might work right now on XFS because the journalling
> implementation -currently- provides global metadata ordering and
> data/metadata ordering based on IO completion to submission
> ordering.
>

Yes.

> However, we do not guarantee that XFS will -always- have this
> behaviour. This is an *implementation detail*, not a guaranteed
> behaviour we will preserve for all time. i.e. we reserve the right
> to change how we do unrelated metadata and data/metadata ordering
> internally.
>

Yes, that's why its a prototype, but its a userspace prototype.
The requirements from the kernel API won't change if the userspace
server would have used an independent nvram to store the change record.

> This reminds of how applications observed that ext3 ordered mode
> didn't require fsync to guarantee the data got written before the
> metadata, so they elided the fsync() because it was really expensive
> on ext3. i.e. they started relying on a specific filesystem
> implementation detail for "correct crash consistency behaviour",
> without understanding that it -only worked on ext3- and broken crash
> consistency behaviour on all other filesystems. That was *bad*, and
> it took a long time to get the message across that applications
> *must* use fsync() for correct crash consistency behaviour...

I am familiar with that episode.

>
> What you are describing for your prototype HSM to provide crash
> consistent change tracking really seems to me like it is reliant
> on the side effects of specific filesystem implementation choices,
> not a behaviour that all filesysetms guarantee.
>
> i.e. not all filesystems provide strict global metadata ordering
> semantics, and some fs maintainers are on record explicitly stating
> that they will not provide or guarantee them. e.g. ext4, especially
> with fast commits enabled, will not provide global strictly ordered
> metadata semantics. btrfs also doesn't provide such a guarantee,
> either.
>

Right. We did once a proposal to formalize this contract [1],
but its a bit off topic.

> > I would love to discuss the merits and pitfalls of this method, but the
> > main thing I wanted to get feedback on is whether anyone finds the
> > described vfs API useful for anything other that the change tracking
> > system that I described.
>
> If my understanding is correct, then this HSM prototype change
> tracking mechanism seems like a fragile, unsupportable architecture.
> I don't think we should be trying to add new VFS infrastructure to
> make it work, because I think the underlying behaviours it requires
> from filesystems are simply not guaranteed to exist.
>

That's a valid opinion.

Do you have an idea for a better design for fs agnostic change tracking?

I mean, sure, we can re-implement DMAPI in specific fs, but I don't think
anyone would like that.

IMO The metadata ordering contract is a technical matter that could be fixe=
d.

I still hold the opinion that the in-core changes order w.r.t readers
is a problem
regardless of persistence to disk, but I may need to come up with more
compelling
use cases to demonstrate this problem.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFR=
y7XEp8HBHQmMdQg+6w@mail.gmail.com/

