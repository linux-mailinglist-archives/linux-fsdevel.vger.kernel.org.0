Return-Path: <linux-fsdevel+bounces-41547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB17A31768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 22:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C0116ACC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F5263C95;
	Tue, 11 Feb 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gxwXD8no"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB36263C74
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308328; cv=none; b=Mdn+SujPH+0dJ36TfMojLUkyAcdXlqfmIBe1aSncr9sHJENGgiCtBi9e1mxD8sLAeJAp2ss3FclFy/JqktbacPnmwEEnIPo5hgy4wsJxOoljIwCH0gO01X1bJ6Sx0KG6aPR60+ymOWiaxEMc9Rd+mPTrSM2RN+j84zLzMoEFY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308328; c=relaxed/simple;
	bh=nSYavudDQAY/YRPpaCKJgrmCwoGznHyVfvRfAcKCO+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsJePU1jaDp/DguSeQ7Kj7a3U/NhdKnmZ9Ep4lygVsiioc/JLAuAulWwW/bVVrN4w8yKpo4gAN6zSBBOmEEXLVBOWoRGWEdJib8tvgoG/nb58gl3/6DLg/JHxyFBVq3Tou6EkR0LnijFvW2svZAthLwoT2CgtPB2aqHYlBm3M+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gxwXD8no; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f4a4fbb35so2731175ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 13:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739308326; x=1739913126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FO3DqYQWWda9jStiMe3gabhVxE9CFIDfN7vajN/TxO4=;
        b=gxwXD8nok3IXyEGDLASCs65jZeezLTVPMBlpzX2MbxTRaI2FwWXIGVvEniHudk5Xcf
         YHaVbhnPmDdWyqBGDdXSYU6TR8ha/BeWu+GtC5mMomtiRERLwo0gtlpXoHbPRodJ1pvQ
         lpr4ZVHvqziU4XwxFFPdUE84B7KquTFi1M0YuUPrL6nArR4QALnTepYgTLB2/v06B8Ui
         iInNwyShN57QqC7xZn75Zrh1sAm2j3iBAkzIZ7DENY4XGT5Q5u9M42pNit9hpAgtixIL
         Yyiv5W+PuqTmyXybJ7V6qm+oHeKpo7Y3V3r1hgV4Y+xazGX5kNlSxcRz5y+z1MVqyL39
         hGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739308326; x=1739913126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FO3DqYQWWda9jStiMe3gabhVxE9CFIDfN7vajN/TxO4=;
        b=LSGlouH12LWrHd2l19rKupYqSVQ7ROkybpphou06Z0Ea+OgSy/llGhkM9TOVRTXkVg
         IUO9hDgbvhfp1MUXQNlwduYw5rsSWQXnBDmULmc+Bublr4KeuVixHv1rqHG6F0rgqK/O
         fH0KW/4BO8XrmgXkAhY3fk4uC3LdlcsoRtOo47XmrphKSg1LFqGbYITr39RIncuYDbMi
         cRO94AWc19Z6Tzzo/Dpc2dxRN2+jACGKSpjdU5IGr5tF2Of9mg5lEy4pz1ryHvDnB8TC
         Uw1h1prUz/NGaHVm6DNXwfN/arDJOVLT2JRajFmCMd3dLALLIsGoKvn4N0nfrfz2+BwM
         mlNA==
X-Gm-Message-State: AOJu0YyG+ePFFWT1BpQaBGfKy5CCsvsRif8O1p8KQxt8CQAaAP/uHJ03
	Zi9Ml6iOLe9Xn/xnguzWPehWlCEwey6R6TEwi2iyM9o8dBhVqH9JaTYMRpPT56GB3kjWHx1F+ou
	d
X-Gm-Gg: ASbGncuC7VRSY9EH17+RHdLTICf2C/2bPYHxnu+hZ80QNuLGMMPakG8vBWzXWNfhhnq
	ti2abQ1NrB9ii2AznNJcqVR4AZBWQdgafEMXjW7h/veoUSDaeJjuxV4YwBWkWGIS2OvOVod4Bmf
	nw+/WRIxIGioD33nYhgZgFkt9iQmVNIKc5OhrdSu3YfUjzIfN5z23BXQZp3cIrFF3toyCUZ4AMz
	alnu834M/F0nRsdG/0a5q8N2cJYzkT75CDGSasUp7kACA04MmI2TjdW+3b6Rlt1w63relUWeP0R
	R3PQE8Qvy346pmcX8ofMdIwM+YmgaU4rGdGtH0TOkLNOt5BLhhbL1/Re+R+8J/Z5MFU=
X-Google-Smtp-Source: AGHT+IEaQNe0LUsoW7kg3ebDDB8WCQdXgGP4HgWoQ0yi1TfLH1DCYOK3CunLYaUIUGx/jb4oKM2K4g==
X-Received: by 2002:a17:903:2cf:b0:216:59f1:c7d9 with SMTP id d9443c01a7336-220bc263cd8mr10909915ad.19.1739308326430;
        Tue, 11 Feb 2025 13:12:06 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650f91asm100505075ad.18.2025.02.11.13.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 13:12:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1thxY3-000000001GC-0PjZ;
	Wed, 12 Feb 2025 08:12:03 +1100
Date: Wed, 12 Feb 2025 08:12:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
Message-ID: <Z6u9I5L3LqCOtf7C@dread.disaster.area>
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area>
 <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <Z5gX7hTPhTtxam1g@dread.disaster.area>
 <CAOQ4uxj6k1TbeHgcP8yeMGQ2SaVscDe8SGYk8U3Liy02CBdC4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj6k1TbeHgcP8yeMGQ2SaVscDe8SGYk8U3Liy02CBdC4A@mail.gmail.com>

On Wed, Jan 29, 2025 at 02:39:56AM +0100, Amir Goldstein wrote:
> On Tue, Jan 28, 2025 at 12:34 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Jan 20, 2025 at 12:41:33PM +0100, Amir Goldstein wrote:
> > > On Sun, Jan 19, 2025 at 10:15 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > This proposed write barrier does not seem capable of providing any
> > > > sort of physical data or metadata/data write ordering guarantees, so
> > > > I'm a bit lost in how it can be used to provide reliable "crash
> > > > consistent change tracking" when there is no relationship between
> > > > the data/metadata in memory and data/metadata on disk...
> > >
> > > That's a good question. A bit hard to explain but I will try.
> > >
> > > The short answer is that the vfs write barrier does *not* by itself
> > > provide the guarantee for "crash consistent change tracking".
> > >
> > > In the prototype, the "crash consistent change tracking" guarantee
> > > is provided by the fact that the change records are recorded as
> > > as metadata in the same filesystem, prior to the modification and
> > > those metadata records are strictly ordered by the filesystem before
> > > the actual change.
> >
> > Uh, ok.
> >
> > I've read the docco and I think I understand what the prototype
> > you've pointed me at is doing.
> >
> > It is using a separate chunk of the filesystem as a database to
> > persist change records for data in the filesystem. It is doing this
> > by creating an empty(?) file per change record in a per time
> > period (T) directory instance.
> >
> > i.e.
> >
> > write()
> >  -> pre-modify
> >   -> fanotify
> >    -> userspace HSM
> >     -> create file in dir T named "<filehandle-other-stuff>"
> >
> > And then you're relying on the filesystem to make that directory
> > entry T/<filehandle-other-stuff> stable before the data the
> > pre-modify record was generated for ever gets written.
> >
> 
> Yes.
> 
> > IOWs, you've specifically relying on *all unrelated metadata changes
> > in the filesystem* having strict global ordering *and* being
> > persisted before any data written after the metadata was created
> > is persisted.
> >
> > Sure, this might work right now on XFS because the journalling
> > implementation -currently- provides global metadata ordering and
> > data/metadata ordering based on IO completion to submission
> > ordering.
> >
> 
> Yes.

[....]

> > > I would love to discuss the merits and pitfalls of this method, but the
> > > main thing I wanted to get feedback on is whether anyone finds the
> > > described vfs API useful for anything other that the change tracking
> > > system that I described.
> >
> > If my understanding is correct, then this HSM prototype change
> > tracking mechanism seems like a fragile, unsupportable architecture.
> > I don't think we should be trying to add new VFS infrastructure to
> > make it work, because I think the underlying behaviours it requires
> > from filesystems are simply not guaranteed to exist.
> >
> 
> That's a valid opinion.
> 
> Do you have an idea for a better design for fs agnostic change tracking?

Store your HSM metadata in a database on a different storage device
and only signal the pre-modification notification as complete once
the database has completed it's update transaction.

> I mean, sure, we can re-implement DMAPI in specific fs, but I don't think
> anyone would like that.

DMAPI pre-modification notifications didn't rely on side effects of
filesystem behaviour for correctness. The HSM had to guarantee that
it's recording of events were stable before it allowed the
modification to be done. Lots of dmapi modification notifications
used pre- and post- event notifications so the HSM could keep track
of modifications that were in flight at any given point in time.

That way the HSM recovery process knew after a crash which files it
needed to go look at to determine if the operation in progress had
completed or not once the system came back up....

> IMO The metadata ordering contract is a technical matter that could be fixed.
> 
> I still hold the opinion that the in-core changes order w.r.t readers
> is a problem
> regardless of persistence to disk, but I may need to come up with more
> compelling
> use cases to demonstrate this problem.

IIRC, the XFS DMAPI implementation solved that problem by blocking
read notifications whilst there was a pending modification
notification outstanding. The problem with the Linux DMAPI
implementation of this (one of the show stoppers that prevented
merge) was that it held a rwsem across syscall contexts to provide
this functionality.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

