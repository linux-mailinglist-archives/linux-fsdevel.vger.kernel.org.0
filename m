Return-Path: <linux-fsdevel+bounces-50260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB902AC9D53
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF61C189C38D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 23:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9C1758B;
	Sat, 31 May 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="3b5nkaEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75719CD13
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748732551; cv=none; b=AR5P6g/G9PI/IU1YIimEMhM9/o5m+OD602EDtNa6tDLsq5awWRE8LR3PKbXzuBHFrubgN3YcK7Lz095rROg3Uu80MZyUg0sYdddUA8pLNHZdz79nJB7JOBTDIlaNak3Cz9es5CLW2skXuV+EQI5Op2NkdK0dEK1p3PZEdLXYg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748732551; c=relaxed/simple;
	bh=8hugkn2chSzOND8npXGoVju5Aj13/h0hF1UBAmlYIFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKSF1KI7YeE14UMqGSFVX6ux0Yucsrgmz48ihiU77T/lnY2+vfTiUJX1yCmIoDDaduPLXGMLzFVrX9nzzgKqeslGfU6vkCvSFzAVXeV6+CTOoTy/TetA4mLGTdab6Jeo7/tzEdOXHNCVuHVQ44qzLDz3DLeQT/sF5swRhDR+nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=3b5nkaEX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso2346220a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1748732549; x=1749337349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ7SV3WId9rdCwdJiGcNR2WyLASNg8zeGEGyr/NQVuk=;
        b=3b5nkaEX6hJLk89QhPGxynPb+mxKnDMX9PwFC+/KtaitzN+gHEDGKxd1UcPzPK822g
         H5/TZG34LmtWl+rnwlNeXG18SJ/nwJzdYxLGY3D6GTSH0LlCxlWEEISL4ofRFSeqmV1U
         Lunl1Tt+zhY2cZURvNXBMEgjjU6RD+OkzY/c2dp3IIU/b55hNC74zU10XiONUqo6b8qF
         maxWSaz20A8pXufG+bjpI/upva8rDoWrIaC5qGLyBY+P/paI+c7hTAMFd7ehmfPf2Tha
         sWNozRCt/jslafDc/uF+LcA5CaqGv4Lp7t0ZT33tV9NsD2aV4xhfGq8be3aQtphSMDDj
         OGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748732549; x=1749337349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ7SV3WId9rdCwdJiGcNR2WyLASNg8zeGEGyr/NQVuk=;
        b=Z8daPMMKIIgamhb33qXBp017JOVFXjlVQcjEPvR9UqL2Td3XjL8Y1hbcXzpliXC9zL
         UF8Ac9c9zQAZTLWut3dzJ0FkwT9uQ2/JSCzfh6cirRyt3Malj4VQywl2q6Qi/HSgwYxo
         ygXJEJwzZlWEXylIWDyEjm5JxjhcZqqKrk0qV7+qKTWAcPY+iyHYn3lcx5gMOF/isCi8
         UmdlK+C3dh4b5nlzSM6zsvSiP5FGQsQiokuiqp9q2Ot8lwR7krz42UD11alFTg/IwsgF
         ijaweqK3m0oRxPPWQBV3C22eq48mf/g7Rcu9brGIAj50K8Y2Dd4VX5bDNepGf0hciMrC
         iy+A==
X-Forwarded-Encrypted: i=1; AJvYcCXFvGylkyrt9c/trufbGlfmSl582x/pUQNnf1/xu7A8cvN9Wd1gTxvZ7r/olkHmHHUWNwHR7z1ba7xnOlqY@vger.kernel.org
X-Gm-Message-State: AOJu0YyUU3SHwv1LdtYWbfX4eC+tI1CiNgfgAk6s38F5hKbpK4kfdrXk
	sqXnAa+4IKmq1MTYJ4jPzKp+GZQMbCPHGEnlWoEtTJtVmtvufr0KzaWuYIq6Id2zTu8=
X-Gm-Gg: ASbGncujIVnkE5/6YxnpdiBqj6UzAUmLR8uj2xtZ5ENdEJZqlmEvQgiQKYnILy/bZh6
	7wZ4QwoutlhshAh4V4RtO8qbHzCsT29p8a2dfXUVZNNwUGgbub5t0iBxaZDzitq3P5HuvIQC8Rs
	omm1EoQ9+TLHuyuGDYuaDP3EwgA65eHETxSd0lBuQqkWl4fmKrhRyyjZF1C+IjbrwAxTwcUjONR
	M+UhU/VXZuLIq5fl1HTI6pmO2Ro42mLh7YeNLy3xVSFZhDAWd5MxFJzBNZReCfXShfeyjiCYFap
	W2Sa1phTQrFoFI70P/xGB2LlJoYf35qQxuEiVc/3q8juVCKe5ToWuYDfR5MoJeOfcbnlHubCzTx
	YzmYKnOBHIAIPQf6xquCzZptly+o=
X-Google-Smtp-Source: AGHT+IFZYqZ5PtzAZdZsg1MHGy/6eVovqIJGBPyGl53dauoDFxeNxLz5oLRI5+GeA1/WnFZLuoyguw==
X-Received: by 2002:a17:90b:3e84:b0:311:e8cc:424e with SMTP id 98e67ed59e1d1-3127c74306dmr5211843a91.24.1748732549294;
        Sat, 31 May 2025 16:02:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c58sm47506645ad.217.2025.05.31.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 16:02:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uLVDd-0000000Ae3o-3NPz;
	Sun, 01 Jun 2025 09:02:25 +1000
Date: Sun, 1 Jun 2025 09:02:25 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>, cem@kernel.org,
	linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aDuKgfi-CCykPuhD@dread.disaster.area>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
 <20250530-ahnen-relaxen-917e3bba8e2d@brauner>
 <20250530153847.GC8328@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530153847.GC8328@frogsfrogsfrogs>

On Fri, May 30, 2025 at 08:38:47AM -0700, Darrick J. Wong wrote:
> On Fri, May 30, 2025 at 07:17:00AM +0200, Christian Brauner wrote:
> > On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote:
> > > On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > > > Hello,
> > > > 
> > > > Recently, we encountered data loss when using XFS on an HDD with bad
> > > > blocks. After investigation, we determined that the issue was related
> > > > to writeback errors. The details are as follows:
> > > > 
> > > > 1. Process-A writes data to a file using buffered I/O and completes
> > > > without errors.
> > > > 2. However, during the writeback of the dirtied pagecache pages, an
> > > > I/O error occurs, causing the data to fail to reach the disk.
> > > > 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> > > > since they are already clean pages.
> > > > 4. When Process-B reads the same file, it retrieves zeroed data from
> > > > the bad blocks, as the original data was never successfully written
> > > > (IOMAP_UNWRITTEN).
> > > > 
> > > > We reviewed the related discussion [0] and confirmed that this is a
> > > > known writeback error issue. While using fsync() after buffered
> > > > write() could mitigate the problem, this approach is impractical for
> > > > our services.
> > > > 
> > > > Instead, we propose introducing configurable options to notify users
> > > > of writeback errors immediately and prevent further operations on
> > > > affected files or disks. Possible solutions include:
> > > > 
> > > > - Option A: Immediately shut down the filesystem upon writeback errors.
> > > > - Option B: Mark the affected file as inaccessible if a writeback error occurs.
> > > > 
> > > > These options could be controlled via mount options or sysfs
> > > > configurations. Both solutions would be preferable to silently
> > > > returning corrupted data, as they ensure users are aware of disk
> > > > issues and can take corrective action.
> > > > 
> > > > Any suggestions ?
> > > 
> > > Option C: report all those write errors (direct and buffered) to a
> > > daemon and let it figure out what it wants to do:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring_2025-05-21
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring-rust_2025-05-21
> > > 
> > > Yes this is a long term option since it involves adding upcalls from the
> > 
> > I hope you don't mean actual usermodehelper upcalls here because we
> > should not add any new ones. If you just mean a way to call up from a
> > lower layer than that's obviously fine.
> 
> Correct.  The VFS upcalls to XFS on some event, then XFS queues the
> event data (or drops it) and waits for userspace to read the queued
> events.  We're not directly invoking a helper program from deep in the
> guts, that's too wild even for me. ;)
> 
> > Fwiw, have you considered building this on top of a fanotify extension
> > instead of inventing your own mechanism for this?
> 
> I have, at various stages of this experiment.
> 
> Originally, I was only going to export xfs-specific metadata events
> (e.g. this AG's inode btree index is bad) so that the userspace program
> (xfs_healer) could initiate a repair against the broken pieces.
> 
> At the time I thought it would be fun to experiment with an anonfd file
> that emitted jsonp objects so that I could avoid the usual C struct ABI
> mess because json is easily parsed into key-value mapping objects in a
> lot of languages (that aren't C).  It later turned out that formatting
> the json is rather more costly than I thought even with seq_bufs, so I
> added an alternate format that emits boring C structures.
> 
> Having gone back to C structs, it would be possibly (and possibly quite
> nice) to migrate to fanotify so that I don't have to maintain a bunch of
> queuing code.  But that can have its own drawbacks, as Ted and I
> discovered when we discussed his patches that pushed ext4 error events
> through fanotify:
> 
> For filesystem metadata events, the fine details of representing that
> metadata in a generic interface gets really messy because each
> filesystem has a different design.

Perhaps that is the wrong approach. The event just needs to tell
userspace that there is a metadata error, and the fs specific agent
that receives the event can then pull the failure information from
the filesystem through a fs specific ioctl interface.

i.e. the fanotify event could simply be a unique error, and that
gets passed back into the ioctl to retreive the fs specific details
of the failure. We might not even need fanotify for this - I suspect
that we could use udev events to punch error ID notifications out to
userspace to trigger a fs specific helper to go find out what went
wrong.

Keeping unprocessed failures in an internal fs queue isn't a big
deal; it's not a lot of memory, and it can be discarded on unmount.
At that point we know that userspace did not care about the
failure and is not going to be able to query about the failure in
future, so we can just throw it away.

This also allows filesystems to develop such functionality in
parallel, allowing us to find commonality and potential areas for
abstraction as the functionality is developed, rahter than trying to
come up with some generic interface that needs to support all
possible things we can think of right now....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

