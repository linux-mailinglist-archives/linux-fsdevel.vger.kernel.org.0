Return-Path: <linux-fsdevel+bounces-39629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D779A1640C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 22:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84753A338B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF31DF96F;
	Sun, 19 Jan 2025 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sDlnPl/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D23F9D2
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737323516; cv=none; b=kXuqZorNf1M0xKklPqlT1RmsX2qSBolYyBf0it8NpbWzNShUqAF0laXge+/yGKFqpI7oTRbrx+oOeeyJvq6ae55O9Y4TKzcKTrC723aOfCj8Cj0dnD88cDzJ3Xn3kIalNMN4k+ONZbbUCein5a/yI9UnbeJJ/tWTSf1Kk9GEyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737323516; c=relaxed/simple;
	bh=C5gAupy+5Ri+qcaUq6xF+6E8frKYdfkqcn+EgsdLsZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4xGSDG8Y8reweqlcXHSHlHK6vs9zIvKKNrOHabDluVa41+n7aB/ICVMyqem7IQbqR2lLA9zt8YbJtcPcVPGypL5w6tbgLBPOcAGXHnfszEYQeMW1ZjXh+yjcDhPMiVbKnI1uC/Saw6XKENgF7JgkHAmlZungXAKzkKepZmASsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sDlnPl/2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so5275282a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 13:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737323514; x=1737928314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ2Hg4fRelaaAmZNpN+A3kOGu1Yh4it+kIABNi1FMck=;
        b=sDlnPl/219z1nsC3/LHAxUM0fSIhkklkONa/OV4NM9OZWMlvKqLb9ng56PkgqXlrM9
         1fJM2BheKB53JruoMVuOAh5PWJwqpFRZcI/b7NJAUhfaSfqsPHAuWS2dR1oi6as3AeWW
         bQ+zYqFv5jYfYo7YA2n4ZesDke5vGY/FghCK4Tx7EmSokqtEiYD1P5QzSaxbdnkP0BZQ
         3cGu3nQXldciiGvDF263NeEB4YHM5pOi+IQQR/Ui+S9OOAnyypTu/wTOyqr3UgykGdM1
         Jumoc9/IGlC+kyh7W9Zn/+K+IxBfVtFcq0/2/WQffsY2F6bwlRsbrlxwXYaq4f+Il3pa
         /gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737323514; x=1737928314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ2Hg4fRelaaAmZNpN+A3kOGu1Yh4it+kIABNi1FMck=;
        b=czE2nhAhHLN7hoUSlnVU+GqvaiI+s2RwdjQm4M4S/LQ2VSg4VqWh7R8u/Liz91igs/
         VzGT5CGuAxfD/GukiEvrlFmN+Jr2b05juNR1ZM6yyiFx5pFXdLEhnRTlAFS3YteoDMXI
         oGQVe82i3ipn0AqQkAuptg2OzNC9RKW4Dm9UCzDDHtbZe35i5ItbSob03JWh9Ov9rK86
         taSAplsH6jn2kbqDfH9n2ybp7kcnDxYVFX1u45mXjPnEcnFW7FQO3czOMmOd83R1anZ5
         FujU5otefN0HxGeRmcIaGtUNS2h/TErmLRKSLvHSVZRkz6pDggwRpiETduY0GUELpo1w
         9VXg==
X-Forwarded-Encrypted: i=1; AJvYcCWJr6W8lssBuFvtZKSXv5vC2kHFCkvmZqMn2n3G0d1ouMFUioWcRt6c4cV8FoWGltLuECpS1dqrEYznuHa3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LEuh2kH7Y/FuxDlIUBbErcfYsaPk2NRZGlnY34h/0p81bhHf
	8jRXINxGfN8e09DaBSQNhAAceKZ/xirKRDTImJmq3kB26/xCrHPilHNU2ZzyH1bRdPHSFNvLHnl
	p
X-Gm-Gg: ASbGncubRxHlVbWYROpat6XHpE8V9i5jQ+0ArnuwIUctDV8xWow/3icDA15fk7QZKbj
	ShzCi2UDdJTIyU9VjDQH5JAzjuwH5WebSWWxnJhGNtkdVDxKk8awGBvRpBz3Xa5crcz+I9rJZvj
	wPKnvblTgbiANYFPXfv/uhNJiDn3IPw5h5HGTXA7h+olSmvQ8STDpsTfS+rcmDHaV4c7u5pTJiO
	UJA7zn9WQNEkVDA7UHAme6SecbrUAPNQM0qXxt0SLWUUDvzjpsvXJmpJxI/3W8sd4Myb8omsghN
	b/kh2P9aKxw3TFnddbN1Jh3nWqq1mH7tg4A=
X-Google-Smtp-Source: AGHT+IHDuje8vS0A06flfUC73vr4enmnymnLn8q9CpS5J4S30+/0xyxJpV/nkrkBIIoeO6yMagyruw==
X-Received: by 2002:a05:6a00:1a94:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-72daf929f5cmr11576752b3a.5.1737323514259;
        Sun, 19 Jan 2025 13:51:54 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f2271sm5582874b3a.25.2025.01.19.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 13:51:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tZdCw-00000007ziG-1MX2;
	Mon, 20 Jan 2025 08:51:50 +1100
Date: Mon, 20 Jan 2025 08:51:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linuxfoundation.org,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
Message-ID: <Z41z9gKyyVMiRZnB@dread.disaster.area>
References: <f78f4a5e86c10d723fd60d51a52dd727924fed3a.camel@kernel.org>
 <173716239018.22054.4624947284143971296@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173716239018.22054.4624947284143971296@noble.neil.brown.name>

On Sat, Jan 18, 2025 at 12:06:30PM +1100, NeilBrown wrote:
> On Sat, 18 Jan 2025, Jeff Layton wrote:
> > We've hit a number of cases in testing recently where the parent's
> > i_rwsem ends up being the bottleneck in heavy parallel create
> > workloads. Currently we have to take the parent's inode->i_rwsem
> > exclusively when altering a directory, which means that any directory-
> > morphing operations in the same directory are serialized.
> > 
> > This is particularly onerous in the ->create codepath, since a
> > filesystem may have to do a number of blocking operations to create a
> > new file (allocate memory, start a transaction, etc.)
> > 
> > Neil recently posted this RFC series, which allows parallel directory
> > modifying operations:
> > 
> >     https://lore.kernel.org/linux-fsdevel/20241220030830.272429-1-neilb@suse.de/
> > 
> > Al pointed out a number of problems in it, but the basic approach seems
> > sound. I'd like to have a discussion at LSF/MM about this.
> > 
> > Are there any problems with the basic approach? Are there other
> > approaches that might be better? Are there incremental steps we could
> > do pave the way for this to be a reality?
> 
> Thanks for raising this!
> There was at least one problem with the approach but I have a plan to
> address that.  I won't go into detail here.  I hope to get a new
> patch set out sometime in the coming week.
> 
> My question to fs-devel is: is anyone willing to convert their fs (or
> advice me on converting?) to use the new interface and do some testing
> and be open to exploring any bugs that appear?

tl;dr: You're asking for people to put in a *lot* of time to convert
complex filesystems to concurrent directory modifications without
clear indication that it will improve performance. Hence I wouldn't
expect widespread enthusiasm to suddenly implement it...

In more detail....

It's not exactly simple to take a directory tree structure that is
exclusively locked for modification and make it safe for concurrent
updates. It -might- be possible to make the directory updates in XFS
more concurrent, but it still has an internal name hash btree index
that would have to be completely re-written to support concurrent
updates.

That's also ignoring all the other bits of the filesystem that will
single thread outside the directory. e.g. during create we have to
allocate an inode, and locality algorithms will cluster new inodes
in the same directory close together. That means they are covered by
the same exclusive lock (e.g. the AGI and AGF header blocks in XFS).
Unlink has the same problem.

IOWs, it's not just directory ops and structures that need locking
changes; the way filesystems do inode and block allocation and
freeing also needs to change to support increased concurrency in
directory operations.

Hence I suspect that concurrent directory mods for filesystems like
XFS will need a new processing model - possibly a low overhead
intent-based modification model using in-memory whiteouts and async
background batching of intents. We kinda already do this with unlink
- we do the directory removal in the foreground, and defer the rest
of the unlink (i.e. inode freeing) to async background worker
threads.

e.g. doing background batching of namespace ops means things like
"rm *" in a directory doesn't need to transactionally modify the
directory as it runs. We could track all the inodes we are unlinking
via the intents and then simply truncate away the entire directory
when it becomes empty and rmdir() is called. We still have to clean
up and mark all the inodes free, but that can be done in the
background.

As such, I suspect that moving XFS to a more async processing model
for directory namespace ops to minimise lock hold times will be
simpler (and potentially faster!) than rewriting large chunks of the
XFS directory and inode management operations to allow for
i_rwsem/ILOCK/AGI/AGF locking concurrency...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

