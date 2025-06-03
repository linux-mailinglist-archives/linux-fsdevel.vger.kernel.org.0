Return-Path: <linux-fsdevel+bounces-50521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD9ACCF94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756F31896F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C92288EE;
	Tue,  3 Jun 2025 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ani9RRjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610891A2643
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988309; cv=none; b=nZLPXUnhYCDgdZichBHNssIa/0pvcjrxycqK1kmgsaAu+gnBw93U3riwF0ZaFlPMEt2S9PWuDdjh8b5IqOSryUQ6jNtvfkLZPmYkbHGNv6SEGhcK7EBfDt93YXEuCsZsqqpL7EpePvE6nV1E6NycvveLzIWk0MwIcFrYb+MwDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988309; c=relaxed/simple;
	bh=4Q6wpdubX03roYzxWuBd4mlmXNKXJQgIgTSoc1SwQqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvT41X7rdydYU9pKv2WHcNfBKZCW9gIZVFompcphtaIgXfbYrNGKWUHAJk+SV35S9Q2RFaKRjOhW1eJ1BI84ojl9qznS6r5FrEGhypGvVqHMvAnSep7eVFiDTXCLQLmmDM75tnDOupca5l3XkTn0DnpGabZ6aOBv4aAAiKn9uI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ani9RRjD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234c5b57557so54007855ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1748988306; x=1749593106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lju0Ryqqd15qALOnq6lO5mGiDU1YmqZiwkz30QskHzc=;
        b=ani9RRjDaxhGeak8nlfuJA3wxU75NFrtPlZo9WiYTSiONxBHzrIKeu6gfLLkWgfpf/
         XyRqG3ig+6UR3OhQ1I63KevmdwZPrKjq7zQD2eu1D69fVBwOfAiG+1SMZmf2VHkCtwnB
         Dy0UNxXQA1GFHRmEfjlbdlpDa+gSSpEwgyYYXx8umV2XEBqfuuCF7i8v2oYB+txWZAvP
         hDnerlEfDtW3KSmoadE9SUUwHf7SKALtu+n0x4yuXUNXNck8KSN2VhpckWY1/wiErd7e
         FGxL8wP85DxqJRJyMZotIquBS4KDo3x7KfkccDThQWdCQdilXtuOIxyOTfkm85vyDtuJ
         mIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988306; x=1749593106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lju0Ryqqd15qALOnq6lO5mGiDU1YmqZiwkz30QskHzc=;
        b=aq5zWzZuPHSrp78cpMGa1Grg6qjUIl5yqC5lWsYghAtghXzx1IU2mtq/yollcKctFI
         eD2PgQZ53EAGllSYuKwOkFjqofwZyfXN6nLBWg8ocIKUS5W0OBvAv2mZN7Phzng952fT
         8mo/2Sfm6NnixRNW1boBEA1y9hhSZylfVb48Oa4czB4Brpu1xVq2b2RP9RvJT2ue2dkt
         mL2fbNOsYfRkc2AiPQSbBlWyl983IfHo2nSzxQhyrpBp91izy4OpCMuT5FN9frdDgoC8
         bNxV5iQHzxLkwSilEWHGsA7TZz+GZx8CF3wy/8ZMq3A2pBeqpi37YIVhd4f65uGFVbUH
         Dysw==
X-Forwarded-Encrypted: i=1; AJvYcCXvPiEZNMbcalhlm9pg9r2iP7xFJBkj4mvTybjwKt4Tu6ibvI1V+AL0ywZUoTkPB2+ISRu2zozNqLNtAUdG@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgU6FaJAE9xX5AAql+fYNEoKbwcBmLJaa7+MiFk01vQDjboCN
	xrNn7qiAwN8kRLxFahaXm1B4NHq5XxbTo8pzCn4onfcYQYxR/kRzQO8n0oRRc5Q8mxU=
X-Gm-Gg: ASbGncsPptj4+CL8vBEr939xA32U2eX+8rbEoCIO09CRObCXdrhpYd6Gh/IWrMb6df2
	a4k/ogpl7owYbwqA7ZvOzqqUt6m9Qo7QT2DaQf2kv/hXQjtN5o+cXIqyjWwudytW3/98D+WSYzB
	J3WGt1p5HdIKShaIp7zcPLLiWTb92HbNXN5HVr7GxxFrIRMaV3uoU3ucQNvQF20GEdK8P10F0I1
	8i/aDeyUgOL/d26yxVd2oJAua+y4hR2iiP8/47c7egxS3nGcRVLa3XFL2va8wDR+aJhb5ZiUYpo
	A84kxHWxkah1ap8nLBkj+5/g6goR9oZlljMoNOpC9sIi3MTrDI86wT6kPBILoCBpU20Lm5+zHD1
	3aLyACwOu/9Gllhfk29sNa3ZGm+0=
X-Google-Smtp-Source: AGHT+IFB7MFjtIScvIBdqXB2ckXxOy1R5cdJuSvkVoKok2QP9CnHqhUz+oglAxd/DdbXqyKh7BRlLw==
X-Received: by 2002:a17:903:18f:b0:234:986c:66e0 with SMTP id d9443c01a7336-235e112bd6cmr4869035ad.4.1748988306543;
        Tue, 03 Jun 2025 15:05:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c79sm92206565ad.230.2025.06.03.15.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:05:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uMZkl-0000000Bsxy-26gn;
	Wed, 04 Jun 2025 08:05:03 +1000
Date: Wed, 4 Jun 2025 08:05:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD9xj8cwfY9ZmQ2B@dread.disaster.area>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aDfkTiTNH1UPKvC7@dread.disaster.area>
 <aD04v9dczhgGxS3K@infradead.org>
 <aD4xboH2mM1ONhB-@dread.disaster.area>
 <aD5-_OOsKyX0rDDO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD5-_OOsKyX0rDDO@infradead.org>

On Mon, Jun 02, 2025 at 09:50:04PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 03, 2025 at 09:19:10AM +1000, Dave Chinner wrote:
> > > In other words, write errors in Linux are in general expected to be
> > > persistent, modulo explicit failfast requests like REQ_NOWAIT.
> > 
> > Say what? the blk_errors array defines multiple block layer errors
> > that are transient in nature - stuff like ENOSPC, ETIMEDOUT, EILSEQ,
> > ENOLINK, EBUSY - all indicate a transient, retryable error occurred
> > somewhere in the block/storage layers.
> 
> Let's use the block layer codes reported all the way up to the file
> systems and their descriptions instead of the errnos they are
> mapped to for compatibility.  The above would be in order:
> 
> [BLK_STS_NOSPC]         = { -ENOSPC,    "critical space allocation" },
> [BLK_STS_TIMEOUT]       = { -ETIMEDOUT, "timeout" },
> [BLK_STS_PROTECTION]    = { -EILSEQ,    "protection" },
> [BLK_STS_TRANSPORT]     = { -ENOLINK,   "recoverable transport" },
> [BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },
> 
> > What is permanent about dm-thinp returning ENOSPC to a write
> > request? Once the pool has been GC'd to free up space or expanded,
> > the ENOSPC error goes away.
> 
> Everything.  ENOSPC means there is no space.  There might be space in
> the non-determinant future, but if the layer just needs to GC it must
> not report the error.

GC of thin pools requires the filesystem to be mounted so fstrim can
be run to tell the thinp device where all the free LBA regions it
can reclaim are located. If we shut down the filesystem instantly
when the pool goes ENOSPC on a metadata write, then *we can't run
fstrim* to free up unused space and hence allow that metadata write
to succeed in the future.

It should be obvious at this point that a filesystem shutdown on an
ENOSPC error from the block device on anything other than journal IO
is exactly the wrong thing to be doing.

> > What is permanent about an IO failing with EILSEQ because a t10
> > checksum failed due to a random bit error detected between the HBA
> > and the storage device? Retry the IO, and it goes through just fine
> > without any failures.
> 
> Normally it means your checksum was wrong.  If you have bit errors
> in the cable they will show up again, maybe not on the next I/O
> but soon.

But it's unlikely to be hit by another cosmic ray anytime soon, and
so bit errors caused by completely random environmental events
should -absolutely- be retried as the subsequent write retry will
succeed.

If there is a dodgy cable causing the problems, the error will
re-occur on random IOs and we'll emit write errors to the log that
monitoring software will pick up. If we are repeatedly isssuing write
errors due to EILSEQ errors, then that's a sign the hardware needs
replacing.

There is no risk to filesystem integrity if write retries
succeed, and that gives the admin time to schedule downtime to
replace the dodgy hardware. That's much better behaviour than
unexpected production system failure in the middle of the night...

It is because we have robust and resilient error handling in the
filesystem that the system is able to operate correctly in these
marginal situations. Operating in marginal conditions or as hardware
is beginning to fail is a necessary to keep production systems
running until corrective action can be taken by the administrators.

> > These transient error types typically only need a write retry after
> > some time period to resolve, and that's what XFS does by default.
> > What makes these sorts of errors persistent in the linux block layer
> > and hence requiring an immediate filesystem shutdown and complete
> > denial of service to the storage?
> > 
> > I ask this seriously, because you are effectively saying the linux
> > storage stack now doesn't behave the same as the model we've been
> > using for decades. What has changed, and when did it change?
> 
> Hey, you can retry.  You're unlikely to improve the situation though
> but instead just keep deferring the inevitable shutdown.

Absolutely. That's the whole point - random failures won't repeat,
and hence when they do occur we avoid a shutdown by retrying them on
failure. This is -exactly- how robust error handling should work.

However, for IO errors that persist or where other IO errors start
to creep in, all the default behaviour is trying to do is hold the
system up in a working state until downtime can be scheduled and the
broken hardware is replaced. If integrity ends up being compromised
by a subsequent IO failure, then we will shut the filesystem down at
that point.

This is about resilience in the face of errors. Not every error is
fatal, nor does every error re-occur. There are classes of errors
known to be transient (ENOSPC), others that are permanent (ENODEV),
and others that we just don't know (EIO). If we value resiliency
and robustness, then the filesystem should be able to withstand
transient and "maybe-transient" IO failures without compromising
integrity.

Failing to recognise that transient and "maybe-transient" errors can
generally be handled cleanly and successfully with future write
retries leads to brittle, fragile systems that fall over at the
first sign of anything going wrong. Filesystems that are targetted
at high value production systems and/or running mission critical
applications needs to have resilient and robust error handling.

> > > Which also leaves me a bit puzzled what the XFS metadata retries are
> > > actually trying to solve, especially without even having a corresponding
> > > data I/O version.
> > 
> > It's always been for preventing immediate filesystem shutdown when
> > spurious transient IO errors occur below XFS. Data IO errors don't
> > cause filesystem shutdowns - errors get propagated to the
> > application - so there isn't a full system DOS potential for
> > incorrect classification of data IO errors...
> 
> Except as we see in this thread for a fairly common use case (buffered
> I/O without fsync) they don't.  And I agree with you that this is not
> how you write applications that care about data integrity - but the
> entire reset of the system and just about every common utility is
> written that way.

Yes, I know that. But there are still valid reasons for retrying
failed async data writeback IO when it triggers a spurious or
retriable IO error....

> And even applications that fsync won't see you fancy error code.  The
> only thing stored in the address_space for fsync to catch is EIO and
> ENOSPC.

The filesystem knows exactly what the IO error reported by the block
layer is before we run folio completions, so we control exactly what
we want to report as IO compeltion status.

Hence the bogosities of error propagation to userspace via the
mapping is completely irrelevant to this discussion/feature because
it would be implemented below the layer that squashes the eventual
IO errno into the address space...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

