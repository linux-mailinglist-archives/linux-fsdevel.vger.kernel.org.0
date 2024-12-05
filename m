Return-Path: <linux-fsdevel+bounces-36573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCE49E5FDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 22:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE603164CEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACAE1CB337;
	Thu,  5 Dec 2024 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RGSODj+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9CE1B87C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433312; cv=none; b=mC9OuagK5DOjeud3N/2lqcCvaLiRt7HimC2GTCTQV5irPdH1mzsi67zzfjhYr+UNV4963ksiQnTsTRyHf9WMWHlgKOZycYkU0mkEiuDK2Wqm4K0MsCwXCEJNC0JuOf7BJjeZB8xOr0yPoD/siCQUC19P8ZQv0aoBVbrTQJcLgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433312; c=relaxed/simple;
	bh=h3cshb4rCdaW6s7WqmDad6l3SlGpjsv59lMl5HHGEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTozYb7XwdepFPPwoiAYrwxcPnKjngHZu+Qfb1MO5AgHHPqvCTOric+3Sr3iQAPGc6iRKrc1XyCs6SIhejoYZ9tuqchyj8OccY13RU0GTvrDN7vq6eWlVs5uoVJc9jhtbv3V4BJtbp+AnfPo8FKkheFngVus1wVQOFAbq3LgMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RGSODj+M; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2155312884fso14692585ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 13:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733433310; x=1734038110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMNOQ/LbvkZ3RF8xsPDD/T0btfy12YyJO+FcJtUBr1I=;
        b=RGSODj+MxXsXe7fNQ4NdjdmlFWo+q5p2g2XJJv/hlQWs61GvxWZtbiS4FphcnfVaNU
         6834g7g/SR0NR42VP7f2uMSr6ba/j1L8VwSa4b6i1P2honLSrKu1ay7+eQJ4BGWfiLqT
         MpCC7zRgfmcEdos1+CAEIoAU7pZh1ujAeAGqOKG/vNy8uHKFfFS01kcrUWLf22UlrImS
         kCOIBE0mYhL13VfCDLILEPoSFl0FwAS30mOis7mHz3grNDxGSrCeaRUUoxba/MWeHh5O
         Mwud2Itahm3zDHAQ9RQY4w0t9H0LhtyvlBL1WCZrxsY+bTR0FWQkBya4spPmW3RmcPLp
         lL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733433310; x=1734038110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMNOQ/LbvkZ3RF8xsPDD/T0btfy12YyJO+FcJtUBr1I=;
        b=RbVIKWM0zJfSXTtjp16B4Ahwl88dWztScXihhwZOZErgD6OeQZOrV3fnFOM5plGOYk
         mYZWam2k08S3HWTkQZpYLS/8DcYjhn2ZPz06bbqjyMABTZGU1YdKPG12BtvIzrTS9l96
         hRAZgQ6JjjXisGL4lsU85f5MmJL6YvCoYQupscCEhUaUK4Eqnjx2LQ7/o9r85g9+78kz
         /A3qnN8FTyB+aFdt75xwcy/X5LN0/AyHmZsxJFnti/gWIcki/VdwJqncw//P8LFb3ZW9
         XwGD38q86TUsd5Le63wGziX4mKYYJtvpAkaOtpRkbQdWGrrsY0hJzMg4Ep2CwSQ4eUbk
         4HIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTsipY8ItGwxyv8oQAccS0jFo5pYGG1wVeycr69RlG4pmEJozJ9AwlhwutWLvZBzdjZnbvGbKxYrr8GW28@vger.kernel.org
X-Gm-Message-State: AOJu0YxjmLT3fia982iGfqrFcNh824B/uVSk2vVaL/qpavIzzA/He2d6
	GQIgj4zuvhUxalZaqUKvvFoureR9JthulvP3gkmwjpEANIH/u9BXX7XnArbCFOE=
X-Gm-Gg: ASbGncsol77oWcAfLKGLrqZO5MAeLMMhfcWEB5jvBkj5Cn+jZyTzkG0eupus/whAuXp
	SzR6BCPZnRFxpc6/AO38z6ahfT4xlNpXg7CsitPRpbabdRBCtSbgC7hcTZyWBJZXjJ4yGSiEvSm
	/H5NyWxp3o7suhq2L0e3xzPslup6VYOSy7VPVIHjhmVV092FDYBtgjCBJ7MjRUZ+JPXm2zqjkBM
	ZUz/wIda0ox39yPdBiwpOXlnF2qyDmB99TFLEWtF6MLNGXoQu+2J3eYQLqJiBn8tFNpggt18b0r
	mvWJ8ZQfNaS0UHmdkFNThTI=
X-Google-Smtp-Source: AGHT+IE8OGm5O/X2/YMeH3EW08/gwIAqgtqX1jLcQ9PDg4MrtkF2WjvetNDK/FH/k5cKpV5Zgvy7rg==
X-Received: by 2002:a17:902:c40a:b0:211:ce91:63ea with SMTP id d9443c01a7336-21614d35675mr5837985ad.15.1733433309420;
        Thu, 05 Dec 2024 13:15:09 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e67244sm16836875ad.86.2024.12.05.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:15:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tJJBh-000000076LC-3Vyp;
	Fri, 06 Dec 2024 08:15:05 +1100
Date: Fri, 6 Dec 2024 08:15:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <Z1IX2dFida3coOxe@dread.disaster.area>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>

On Thu, Dec 05, 2024 at 10:52:50AM +0000, John Garry wrote:
> On 04/12/2024 20:35, Dave Chinner wrote:
> > On Wed, Dec 04, 2024 at 03:43:41PM +0000, John Garry wrote:
> > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > 
> > > Filesystems like ext4 can submit writes in multiples of blocksizes.
> > > But we still can't allow the writes to be split into multiple BIOs. Hence
> > > let's check if the iomap_length() is same as iter->len or not.
> > > 
> > > It is the responsibility of userspace to ensure that a write does not span
> > > mixed unwritten and mapped extents (which would lead to multiple BIOs).
> > 
> > How is "userspace" supposed to do this?
> 
> If an atomic write spans mixed unwritten and mapped extents, then it should
> manually zero the unwritten extents beforehand.
> 
> > 
> > No existing utility in userspace is aware of atomic write limits or
> > rtextsize configs, so how does "userspace" ensure everything is
> > laid out in a manner compatible with atomic writes?
> > 
> > e.g. restoring a backup (or other disaster recovery procedures) is
> > going to have to lay the files out correctly for atomic writes.
> > backup tools often sparsify the data set and so what gets restored
> > will not have the same layout as the original data set...
> 
> I am happy to support whatever is needed to make atomic writes work over
> mixed extents if that is really an expected use case and it is a pain for an
> application writer/admin to deal with this (by manually zeroing extents).
> 
> JFYI, I did originally support the extent pre-zeroing for this. That was to
> support a real-life scenario which we saw where we were attempting atomic
> writes over mixed extents. The mixed extents were coming from userspace
> punching holes and then attempting an atomic write over that space. However
> that was using an early experimental and buggy forcealign; it was buggy as
> it did not handle punching holes properly - it punched out single blocks and
> not only full alloc units.
> 
> > 
> > Where's the documentation that outlines all the restrictions on
> > userspace behaviour to prevent this sort of problem being triggered?
> 
> I would provide a man page update.

I think, at this point, we need an better way of documenting all the
atomic write stuff in one place. Not just the user interface and
what is expected of userspace, but also all the things the
filesystems need to do to ensure atomic writes work correctly. I was
thinking that a document somewhere in the Documentation/ directory,
rather than random pieces of information splattered across random man pages
would be a much better way of explaining all this.

Don't get me wrong - man pages explaining the programmatic API are
necessary, but there's a whole lot more to understanding and making
effective use of atomic writes than what has been added to the man
pages so far.

> > Common operations such as truncate, hole punch,
> 
> So how would punch hole be a problem? The atomic write unit max is limited
> by the alloc unit, and we can only punch out full alloc units.

I was under the impression that this was a feature of the
force-align code, not a feature of atomic writes. i.e. force-align
is what ensures the BMBT aligns correctly with the underlying
extents.

Or did I miss the fact that some of the force-align semantics bleed
back into the original atomic write patch set?

> > buffered writes,
> > reflinks, etc will trip over this, so application developers, users
> > and admins really need to know what they should be doing to avoid
> > stepping on this landmine...
> 
> If this is not a real-life scenario which we expect to see, then I don't see
> why we would add the complexity to the kernel for this.

I gave you one above - restoring a data set as a result of disaster
recovery. 

> My motivation for atomic writes support is to support atomically writing
> large database internal page size. If the database only writes at a fixed
> internal page size, then we should not see mixed mappings.

Yup, that's the problem here. Once atomic writes are supported by
the kernel and userspace, all sorts of applications are going to
start using them for in all sorts of ways you didn't think of.

> But you see potential problems elsewhere ..

That's my job as a senior engineer with 20+ years of experience in
filesystems and storage related applications. I see far because I
stand on the shoulders of giants - I don't try to be a giant myself.

Other people become giants by implementing ground-breaking features
(e.g. like atomic writes), but without the people who can see far
enough ahead just adding features ends up with an incoherent mess of
special interest niche features rather than a neatly integrated set
of widely usable generic features.

e.g. look at MySQL's use of fallocate(hole punch) for transparent
data compression - nobody had forseen that hole punching would be
used like this, but it's a massive win for the applications which
store bulk compressible data in the database even though it does bad
things to the filesystem.

Spend some time looking outside the proprietary database application
box and think a little harder about the implications of atomic write
functionality.  i.e. what happens when we have ubiquitous support
for guaranteeing only the old or the new data will be seen after
a crash *without the need for using fsync*.

Think about the implications of that for a minute - for any full
file overwrite up to the hardware atomic limits, we won't need fsync
to guarantee the integrity of overwritten data anymore. We only need
a mechanism to flush the journal and device caches once all the data
has been written (e.g. syncfs)...

Want to overwrite a bunch of small files safely?  Atomic write the
new data, then syncfs(). There's no need to run fdatasync after each
write to ensure individual files are not corrupted if we crash in
the middle of the operation. Indeed, atomic writes actually provide
better overwrite integrity semantics that fdatasync as it will be
all or nothing. fdatasync does not provide that guarantee if we
crash during the fdatasync operation.

Further, with COW data filesystems like XFS, btrfs and bcachefs, we
can emulate atomic writes for any size larger than what the hardware
supports.

At this point we actually provide app developers with what they've
been repeatedly asking kernel filesystem engineers to provide them
for the past 20 years: a way of overwriting arbitrary file data
safely without needing an expensive fdatasync operation on every
file that gets modified.

Put simply: atomic writes have a huge potential to fundamentally
change the way applications interact with Linux filesystems and to
make it *much* simpler for applications to safely overwrite user
data.  Hence there is an imperitive here to make the foundational
support for this technology solid and robust because atomic writes
are going to be with us for the next few decades...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

