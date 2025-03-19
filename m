Return-Path: <linux-fsdevel+bounces-44484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5EBA69AD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 22:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780E41703EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA3219E93;
	Wed, 19 Mar 2025 21:25:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F593219312
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419545; cv=none; b=B2DXLLea484PbYg1RV2ttW47LotovBtaQoeuakHu5Q3z/UfBKCXDEVRz2jMUy8mM5eA0NG1glk4tqdkiK9WFp6kxX/X8/yEp3i1h2qoyzVaWg28yESC8IcbrwEmfY6CPVfhFOPxcwu0IJoZI9RHLovulA+u480gmiVYeuAfA0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419545; c=relaxed/simple;
	bh=mFZMXe0p2nN2EmZgPd1cnqREJBnVFgkDcOdhNMk4REc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvzIACasy0zQ5DJtds14jJULzaUIIWnpWSMFlLz8XztRUux8Kf/gnzzEwlit9JWdALcq5SlZSNtp4dW1nx+Bws1wBTnAPEczsJpmeLRAFPw486CiYu1QfTekudYvgGKDeFWjyNKn/aA0ICcYA0yBUIFM0O3zrAC8bVUyKeZuaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52JLPH5s012540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 17:25:18 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 9956E2E010B; Wed, 19 Mar 2025 17:25:17 -0400 (EDT)
Date: Wed, 19 Mar 2025 17:25:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Dave Chinner <david@fromorbit.com>, cve@kernel.org, gnoack@google.com,
        gregkh@linuxfoundation.org, kent.overstreet@linux.dev,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mic@digikod.net,
        Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250319212517.GB1079074@mit.edu>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <Z9CYzjpQUH8Bn4AL@itl-email>
 <20250318221128.GA1040959@mit.edu>
 <Z9sCcbZ7sdBgbX77@itl-email>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9sCcbZ7sdBgbX77@itl-email>

On Wed, Mar 19, 2025 at 01:44:13PM -0400, Demi Marie Obenour wrote:
> > Note that this won't help if you have a malicious hardware that
> > *pretends* to be a USB storage device, but which doens't behave a like
> > a honest storage device.  For example, reading a particular sector
> > with one data at time T, and a different data at time T+X, with no
> > intervening writes.  There is no real defense to this attack, since
> > there is no way that you can authentiate the external storage device;
> > you could have a registry of USB vendor and model id's, but a device
> > can always lie about its id numbers.
> 
> This attack can be defended against by sandboxing the filesystem driver
> and copying files to trusted storage before using them.  You can
> authenticate devices based on what port they are plugged into, and Qubes
> OS is working on exactly that.

Copying files to trusted storge is not sufficient.  The problem is
that an untrustworthy storage device can still play games with
metadata blocks.  If you are willing to copy the entire storage device
to trustworthy storage, and then run fsck on the file system, and then
mount it, then *sure* that would help.  But if the storage device is
very large or very slow, this might not be practical.

> > Like everything else, security and usability and performance and costs
> > are all engineering tradeoffs....
>
> Is the tradeoff fundamental, or is it a consequence of Linux being a
> monolithic kernel?  If Linux were a microkernel and every filesystem
> driver ran as a userspace process with no access to anything but the
> device it is accessing, then there would be no tradeoff when it comes to
> filesystems: a compromised filesystem driver would have no more access
> than the device itself would, so compromising a filesystem driver would
> be of much less value to an attacker.  There is still the problem that
> plug and play is incompatible with not trusting devices to identify
> themselves, but that's a different concern.

Microkernels have historically been a performance disaster.  Yes, you
can invest a *vast* amount of effort into trying to make a microkernel
OS more performant, but in the meantime, the competing monolithic
kernel will have gotten even faster, or added more features, leaving
the microkernel in the dust.

The effort needed to create a new file system from scratch, taking it
all the way from the initial design, implementation, testing and
performance tuning, and making it something customers are comfortable
depending on it for enterprise workloads is between 50 and 100
engineer years.  This estimate came from looking at the development
effort needed for various file systems implemented on monolithic
kernels, including Digital's Advfs (part of Digital Unix and OSF/1),
IBM's AIX, and Sun's ZFS, as well as GPFS from IBM (although that was
a cluster file sytem, and the effort estimated from my talking to the
engineering managers and tech leads was around 200 PY's.)

I'm not sure how much harder it will be to make a performant file
system which is suitable for enterprise workloads from a performance,
feature, and stability perspective, *and* to make it secure against
storage devices which are outside the TCB, *and* to make it work on a
microkernel.  But I'm going to guess it would inflate these effort
estimates by at least 50%, if not more.

Of course, if we're just witing a super simple file system that is
suitable for backups and file transfers, but not much else, that would
probably take much less efort.  But if we need to support file
exchange with storge devices with NTFS or HFS, thos aren't simple file
sytes.  So the VM sandbox approach might still be the better way to go.

Cheers,

					- Ted

