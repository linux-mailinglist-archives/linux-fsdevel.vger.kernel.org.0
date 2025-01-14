Return-Path: <linux-fsdevel+bounces-39114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A99DA0FFF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A833A4CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 04:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08A2309BE;
	Tue, 14 Jan 2025 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DLrp1Fm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0814A0A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736829680; cv=none; b=Qq+yA0Cwsk9k2LkLQcR6qjV3PWSETZRV9Bibwl1VHdac165fK7xE5s60QWflCGhT7ETUOwcquYtOV4fXJsoiyD4IOpIQZY+T3Wz7CywDWYX1/KSfgsUYY5GduHpikJDyVOnw/q7c4Ho083ceYEBhWtIYB5bDq+WMYs50JIDlqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736829680; c=relaxed/simple;
	bh=jVfOCC5IYA07dnEiZLPS8rmKdjIbmS+g7aJK7f+3yPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd7omwPZuG7o269mbbm0+d5R5/PgHWjCINdG+AdkUmpDHD+7cqfG4z0MhiD6BOBS8aGm3X4XvC2I4ETiNVKJxjtjS/dIyOWeLFsqi0iuVUZD3iCYN8lb/J6gpQLSFDWDcdociQameioOr7fs+4uWf46+1HsT9xvZktAwJ91KA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DLrp1Fm6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21644aca3a0so110698795ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 20:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736829677; x=1737434477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Bwt5MOYyShKNyRq/VAiWpfJZM93IWclP9sYqUOAhs8=;
        b=DLrp1Fm6lbNsXrNbFpopby+eSnxUvGJCDfypvJob0fH5OCgdaGxb3IV5Igw5SRZRN7
         ObsUI+aOz97uWioHQjIxdF9KMf91ktArV0IxDPlGGAks7PIAwC6hMlrs+NpussLNzjWW
         R1yDhg95XQ3KxDWx96oLi8UkbE7MLOiTY+/m0ZDTFNGHizLn/f6x1uuUtD8ZZ7xYAKLD
         mG5gnJvlXmQJGgsG6qCvRvJ7Tnb06pKSw22Woe1eLf+3O70A6b8l+TVtPdSfEM5lyDCD
         E9dPDCREWm8I5p07sJ3am8dwj3mSrgyQkkVN1/COwGe3FUYwLY6n+RVRQ2TUlUR3FZyx
         L9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736829677; x=1737434477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bwt5MOYyShKNyRq/VAiWpfJZM93IWclP9sYqUOAhs8=;
        b=aEuVBtpIo7AVXvwIhIFKGPrPtZ2kQch7qxCywQOgfzexRkRDoVUrwvxK+mCcNeVEgq
         89HHO4uLc2qGISn/wIvsgGpRnsVGW9/ZT7G2dTbGKR+W3aoMwoCWOA+2uAbB8DieQM1U
         ScxPcy03c6XDHocFCN8AOYSV3P6R+A1/w/K8rhRI7kcI2KIquh/J30j2URROCS1kac3S
         GYvHdr3TKFLwNN1uCSwnkVpVbl1aP+i8/DKaIUX2Zy58DjyNvznpjJkl4S6jHA07aA2W
         7390ZPYBtOfq8AP+HtWqQ3qs6oYqbwpGv1CT2U6OQGU1zcL/e65HNaBVSAPJLmRnTaMG
         Zydw==
X-Forwarded-Encrypted: i=1; AJvYcCXSemRM6b39aD4LDJTmaGdKJtxL1i1PvnpJksK6WRB44R1z2ZzyYfBVZxF5osvq8Fy/rlpCoycrzS41P/qe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/rhJBm7P/kzqvnzD5jUZGbooo/Ep6JVZpb4t+g0WM1L5QfH1
	YcJOsnsGDa7wwi5LyCeiCWuOXVFR9k9BWLMCIswQzr5mWX37QSWHHjQjJ8hVEDc=
X-Gm-Gg: ASbGncsrJP9l/4j0+T91jNSriKUAtEUKEjaxXgqUt9yU40astxuIzbYKwI3d7/ymihi
	MMj5N0HyVupZT7ouWF7hu1XpkdMbfyB/6t5dkrlDt+Vlfx/jVdHEw4GVMX4O8GQ982QRqqa9a6z
	0zYZpfpE/vOwNM3w2OzZx1zOD45IENGToyCYudwFd145apqLzvTv6eELFvHEQvm1xZhTB0TcqJt
	FBaZU7Cxy/OX6D/h6yrO0NIFfPQzzeyekQu3Xybnjbri5fHLotp+nmP+Gcx7HgIqqKR0RMGHH6d
	0uYprLbQ38ftlcZx35jEoKrbUcQEulDZ
X-Google-Smtp-Source: AGHT+IEVyfa4+JQMG+1FYgQ2kp6arnxMgjlrx0JtvwvXXN2OelsXIfgiyVhNeUoLfm/SVmQV93XSLg==
X-Received: by 2002:a05:6a21:1087:b0:1e1:b727:181a with SMTP id adf61e73a8af0-1e88cfd3cb1mr40282507637.24.1736829677164;
        Mon, 13 Jan 2025 20:41:17 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405493d4sm6691741b3a.1.2025.01.13.20.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 20:41:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tXYjp-00000005ce8-2KJL;
	Tue, 14 Jan 2025 15:41:13 +1100
Date: Tue, 14 Jan 2025 15:41:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212013433.GC6678@frogsfrogsfrogs>

On Wed, Dec 11, 2024 at 05:34:33PM -0800, Darrick J. Wong wrote:
> On Fri, Dec 06, 2024 at 08:15:05AM +1100, Dave Chinner wrote:
> > On Thu, Dec 05, 2024 at 10:52:50AM +0000, John Garry wrote:
> > e.g. look at MySQL's use of fallocate(hole punch) for transparent
> > data compression - nobody had forseen that hole punching would be
> > used like this, but it's a massive win for the applications which
> > store bulk compressible data in the database even though it does bad
> > things to the filesystem.
> > 
> > Spend some time looking outside the proprietary database application
> > box and think a little harder about the implications of atomic write
> > functionality.  i.e. what happens when we have ubiquitous support
> > for guaranteeing only the old or the new data will be seen after
> > a crash *without the need for using fsync*.
> 
> IOWs, the program either wants an old version or a new version of the
> files that it wrote, and the commit boundary is syncfs() after updating
> all the files?

Yes, though there isn't a need for syncfs() to guarantee old-or-new.
That's the sort of thing an application can choose to do at the end
of it's update set...

> > Think about the implications of that for a minute - for any full
> > file overwrite up to the hardware atomic limits, we won't need fsync
> > to guarantee the integrity of overwritten data anymore. We only need
> > a mechanism to flush the journal and device caches once all the data
> > has been written (e.g. syncfs)...
> 
> "up to the hardware atomic limits" -- that's a big limitation.  What if
> I need to write 256K but the device only supports up to 64k?  RWF_ATOMIC
> won't work.  Or what if the file range I want to dirty isn't aligned
> with the atomic write alignment?  What if the awu geometry changes
> online due to a device change, how do programs detect that?

If awu geometry changes dynamically in an incompatible way, then
filesystem RWF_ATOMIC alignment guarantees are fundamentally broken.
This is not a problem the filesystem can solve.

IMO, RAID device hotplug should reject new device replacement that
has incompatible atomic write support with the existing device set.
With that constraint, the whole mess of "awu can randomly change"
problems go away.

> Programs that aren't 100% block-based should use exchange-range.  There
> are no alignment restrictions, no limits on the size you can exchange,
> no file mapping state requiments to trip over, and you can update
> arbitrary sparse ranges.  As long as you don't tell exchange-range to
> flush the log itself, programs can use syncfs to amortize the log and
> cache flush across a bunch of file content exchanges.

Right - that's kinda my point - I was assuming that we'd be using
something like xchg-range as the "unaligned slow path" for
RWF_ATOMIC.

i.e. RWF_ATOMIC as implemented by a COW capable filesystem should
always be able to succeed regardless of IO alignment. In these
situations, the REQ_ATOMIC block layer offload to the hardware is a
fast path that is enabled when the user IO and filesystem extent
alignment matches the constraints needed to do a hardware atomic
write.

In all other cases, we implement RWF_ATOMIC something like
always-cow or prealloc-beyond-eof-then-xchg-range-on-io-completion
for anything that doesn't correctly align to hardware REQ_ATOMIC.

That said, there is nothing that prevents us from first implementing
RWF_ATOMIC constraints as "must match hardware requirements exactly"
and then relaxing them to be less stringent as filesystems
implementations improve. We've relaxed the direct IO hardware
alignment constraints multiple times over the years, so there's
nothing that really prevents us from doing so with RWF_ATOMIC,
either. Especially as we have statx to tell the application exactly
what alignment will get fast hardware offloads...

> Even better, if you still wanted to use untorn block writes to persist
> the temporary file's dirty data to disk, you don't even need forcealign
> because the exchange-range will take care of restarting the operation
> during log recovery.  I don't know that there's much point in doing that
> but the idea is there.

*nod*

> > Want to overwrite a bunch of small files safely?  Atomic write the
> > new data, then syncfs(). There's no need to run fdatasync after each
> > write to ensure individual files are not corrupted if we crash in
> > the middle of the operation. Indeed, atomic writes actually provide
> > better overwrite integrity semantics that fdatasync as it will be
> > all or nothing. fdatasync does not provide that guarantee if we
> > crash during the fdatasync operation.
> > 
> > Further, with COW data filesystems like XFS, btrfs and bcachefs, we
> > can emulate atomic writes for any size larger than what the hardware
> > supports.
> > 
> > At this point we actually provide app developers with what they've
> > been repeatedly asking kernel filesystem engineers to provide them
> > for the past 20 years: a way of overwriting arbitrary file data
> > safely without needing an expensive fdatasync operation on every
> > file that gets modified.
> > 
> > Put simply: atomic writes have a huge potential to fundamentally
> > change the way applications interact with Linux filesystems and to
> > make it *much* simpler for applications to safely overwrite user
> > data.  Hence there is an imperitive here to make the foundational
> > support for this technology solid and robust because atomic writes
> > are going to be with us for the next few decades...
> 
> I agree that we need to make the interface solid and robust, but I don't
> agree that the current RWF_ATOMIC, with its block-oriented storage
> device quirks is the way to go here.

> Maybe a byte-oriented RWF_ATOMIC
> would work, but the only way I can think of to do that is (say) someone
> implements Christoph's suggestion to change the COW code to allow
> multiple writes to a staging extent, and only commit the remapping
> operations at sync time... and you'd still have problems if you have to
> do multiple remappings if there's not also a way to restart the ioend
> chains.
> 
> Exchange-range already solved all of that, and it's already merged.

Yes, I agree that the block-device quirks need to go away from
RWF_ATOMIC, but I think it's the right interface for applications
that want to use atomic overwrite semantics.

Hiding exchange-range under the XFS covers for unaligned atomic IO
would mean applications won't need to target XFS specific ioctls to
do reliable atomic overwrites. i.e. the API really needs to be
simple and filesystem independent, and RWF_ATOMIC gives us that...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

