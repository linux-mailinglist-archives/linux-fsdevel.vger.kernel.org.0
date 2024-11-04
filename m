Return-Path: <linux-fsdevel+bounces-33589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E339BAA95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 02:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3E82817D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CFB167296;
	Mon,  4 Nov 2024 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WK2nQ19i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456507E0E8
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685167; cv=none; b=GIKR+sGl0hle+pC3us9CKL1/nbZ2r0sUR5F9FRADiXdgLACPvk1XVXgJI5CHfI7EeR7wHkTBPGPOUHh+aw/mm1A9E92S4vXuepToBoTep5NOUkuFh/Ar8Gq0Ste904XYYOVDigMAsPfUn4o6FdPkYJeL7T1GVTkeq6ZxwhOD8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685167; c=relaxed/simple;
	bh=4ER/EiUCkm4Hjda9LTk/1TdU9pkW80CjEHKAFrE8eD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv4Q/4FKD6+Af+zV2UjaMue5IaxHDfw1V8JeFD7XHx+AWRaIt+SJZkcm+DRPjFPnPQfoWR0LUyZXxp6RcXQ8HtA5vSPaJQqhzi1AT7zzSmtTRtKz0mfCkbDsuOBaVRKueMFx1G1D1NEevJGNQKC3BJufdBHZzWgf9rtitL+IuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WK2nQ19i; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7eab7622b61so2894205a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2024 17:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730685165; x=1731289965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1gO7nE6k1d3RjOM7nVXHvrivHG7QQDb7RYI/vhsl1g=;
        b=WK2nQ19iurnnXZh/H138SBIHp3WiDagYGsLzW8Q2WSuM2PMUzKJj/GfR7k0AYmeKos
         hJn4GArnVZ4VEgxn7oZQy40khQpgPj7onWuH2Phl+7mmvdKuI37jBAHaDDPTsl5nb4Fz
         GdHbpXvzmCUvx3GQVcjZo3x5ojFrvAMzfz2Em6whCBa4W+CZ7v3EERd5opZz2RKoBb81
         EEqdAGGTVP1cqLjmU86d+PzgfVPvRq/9rGlVkHr9HWpW+8C1C42gfYNoimoMsqqagNqK
         iplPld4ChHpTcexP21UpEfo0BTYpe48qtj5N0rWNKy8fNMtiD/pGzmffBubX3nfkTSod
         NN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730685165; x=1731289965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1gO7nE6k1d3RjOM7nVXHvrivHG7QQDb7RYI/vhsl1g=;
        b=hgsB50FKCFcM71HbVD7pIBxXaNTDOceNBdPwjs9k6V0dv8wAUe9EFA2JLsQQouYSGR
         okx8GOexwR9sN2zHvazY8dxWaarG0jdj5zGivH98tifXYKn7lQK2CpoiY0kKXQEtYxlV
         I89F7WqUewTiYxeUngVfbrtdLEuGox7HXODXAqw2F1wu6sWjohSFo0iC1i4gFLySFGpW
         PrKiOYio63mrnE419+FtglvgsxknzI/49y3woTBIyo5TIQPVh1PXSxOaen3Q7elxchUy
         Qg6Mdxn/D6ahtKLEGnzRVKZpGIwHEtA4ZGhxnr72jMRqleDfou79Zsk07XXC7cFZtGfv
         47eg==
X-Forwarded-Encrypted: i=1; AJvYcCUyE7m2mE/9+/NMG4iWs23hqGXgOiS9KcJjHfUVaTJB9PUAKJbF67YQV0YzJTBFziS9VVK2scAKzOS0VrqE@vger.kernel.org
X-Gm-Message-State: AOJu0YziCc5AzlO0AT6XL9YQcvonbGvHrMRhm8sE/LFS5O/r8W2ZNhgu
	/Vs5okkuFhzFTXPLhIjaI9RI0GtYoYJczk6Xw9LlXf11kYbPBvPcBMExU+dDZM4=
X-Google-Smtp-Source: AGHT+IHU0t6TXjLqTaEyMJ+80xaQseYHEZhGQPcykH54yPn7f5EMEawKPcrdWfzxP/RT/N77cHYxWA==
X-Received: by 2002:a05:6a20:d8b:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d9a84d168emr47042468637.35.1730685165442;
        Sun, 03 Nov 2024 17:52:45 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc318824sm6235825b3a.212.2024.11.03.17.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 17:52:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t7mGo-009qSI-0n;
	Mon, 04 Nov 2024 12:52:42 +1100
Date: Mon, 4 Nov 2024 12:52:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
	John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
Message-ID: <Zygo6nqOJMoJxYrm@dread.disaster.area>
References: <87v7xgmpwo.fsf@gmail.com>
 <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com>
 <87ttd0mnuo.fsf@gmail.com>
 <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com>
 <87r084mkat.fsf@gmail.com>
 <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com>
 <87plnomfsy.fsf@gmail.com>
 <20241025182858.GM2386201@frogsfrogsfrogs>
 <87jzdvmqfz.fsf@gmail.com>
 <20241031213640.GB21832@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031213640.GB21832@frogsfrogsfrogs>

On Thu, Oct 31, 2024 at 02:36:40PM -0700, Darrick J. Wong wrote:
> On Sat, Oct 26, 2024 at 10:05:44AM +0530, Ritesh Harjani wrote:
> > > This gets me to the third and much less general solution -- only allow
> > > untorn writes if we know that the ioend only ever has to run a single
> > > transaction.  That's why untorn writes are limited to a single fsblock
> > > for now -- it's a simple solution so that we can get our downstream
> > > customers to kick the tires and start on the next iteration instead of
> > > spending years on waterfalling.
> > >
> > > Did you notice that in all of these cases, the capabilities of the
> > > filesystem's ioend processing determines the restrictions on the number
> > > and type of mappings that ->iomap_begin can give to iomap?
> > >
> > > Now that we have a second system trying to hook up to the iomap support,
> > > it's clear to me that the restrictions on mappings are specific to each
> > > filesystem.  Therefore, the iomap directio code should not impose
> > > restrictions on the mappings it receives unless they would prevent the
> > > creation of the single aligned bio.
> > >
> > > Instead, xfs_direct_write_iomap_begin and ext4_iomap_begin should return
> > > EINVAL or something if they look at the file mappings and discover that
> > > they cannot perform the ioend without risking torn mapping updates.  In
> > > the long run, ->iomap_begin is where this iomap->len <= iter->len check
> > > really belongs, but hold that thought.
> > >
> > > For the multi fsblock case, the ->iomap_begin functions would have to
> > > check that only one metadata update would be necessary in the ioend.
> > > That's where things get murky, since ext4/xfs drop their mapping locks
> > > between calls to ->iomap_begin.  So you'd have to check all the mappings
> > > for unsupported mixed state every time.  Yuck.
> > >
> > 
> > Thanks Darrick for taking time summarizing what all has been done
> > and your thoughts here.
> > 
> > > It might be less gross to retain the restriction that iomap accepts only
> > > one mapping for the entire file range, like Ritesh has here.
> > 
> > less gross :) sure. 
> > 
> > I would like to think of this as, being less restrictive (compared to
> > only allowing a single fsblock) by adding a constraint on the atomic
> > write I/O request i.e.  
> > 
> > "Atomic write I/O request to a region in a file is only allowed if that
> > region has no partially allocated extents. Otherwise, the file system
> > can fail the I/O operation by returning -EINVAL."
> > 
> > Essentially by adding this constraint to the I/O request, we are
> > helping the user to prevent atomic writes from accidentally getting
> > torned and also allowing multi-fsblock writes. So I still think that
> > might be the right thing to do here or at least a better start. FS can
> > later work on adding such support where we don't even need above
> > such constraint on a given atomic write I/O request.
> 
> On today's ext4 call, Ted and Ritesh and I realized that there's a bit
> more to it than this -- it's not possible to support untorn writes to a
> mix of written/(cow,unwritten) mappings even if they all point to the
> same physical space.  If the system fails after the storage device
> commits the write but before any of the ioend processing is scheduled, a
> subsequent read of the previously written blocks will produce the new
> data, but reads to the other areas will produce the old contents (or
> zeroes, or whatever).  That's a torn write.

I'm *really* surprised that people are only realising that IO
completion processing for atomic writes *must be atomic*.

This was the foundational constraint that the forced alignment
proposal for XFS was intended to address. i.e. to prevent fs
operations from violating atomic write IO constraints (e.g. punching
sub-atomic write size holes in the file) so that the physical IO can
be done without tearing and the IO completion processing that
exposes the new data can be done atomically.

> Therefore, iomap ought to stick to requiring that ->iomap_begin returns
> a single iomap to cover the entire file range for the untorn write.  For
> an unwritten extent, the post-recovery read will see either zeroes or
> the new contents; for a single-mapping COW it'll see old or new contents
> but not both.

I'm pretty sure we enforced that in the XFS mapping implemention for
atomic writes using forced alignment. i.e.  we have to return a
correctly aligned, contiguous mapping to iomap or we have to return
-EINVAL to indicate atomic write mapping failed.

Yes, we can check this in iomap, but it's really the filesystem that
has to implement and enforce it...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

