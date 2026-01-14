Return-Path: <linux-fsdevel+bounces-73611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4DD1CA80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 837AC301591F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23712356A37;
	Wed, 14 Jan 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaQYoP7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A733B6C7;
	Wed, 14 Jan 2026 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371572; cv=none; b=oCssPeLhTuoyw0LfSwrp6LU90bx+UhjtdRLUEdGdNhuY7tZpdkkPi3Av9vQcs4iZ6tuEQ/seTjV2uLrXQH8e9ZJb8SNkuWkzjxcwVqVJa+JFEcVOtSZlu4rnUl5a7fUitxOZFbBg9Z/jCKsKeWdcR9N7TX3NR0w94eZRFEl5oKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371572; c=relaxed/simple;
	bh=Nj7+2r6aMmpWFZausLp8hDZ4m5xNZMEQ7qo9UQJO29s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy0kMog92wihZr3PxFXgwUhv/1dDY9fvqWcYqJBIgCZP0xeMzA14sKQoZhY5Ep5hmYaF2101xm43K+d1X2K+RsyCrUBcATLXIo4aaUfUapik+JsPUufELEiRgFQKQZrpI6jyjHyX/blqIbXB5JVtyl6jCU7YWZPL0LMuplrMMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaQYoP7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17173C4CEF7;
	Wed, 14 Jan 2026 06:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768371571;
	bh=Nj7+2r6aMmpWFZausLp8hDZ4m5xNZMEQ7qo9UQJO29s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaQYoP7Jam3BpX+UsBkkkN2N0mdP5O6qZbG9mIll5CBv9i84+TOk+oSU26m9hvwug
	 v+guNuIYMD+qH6NRXg4Q11onlqW+jPhSHYpa6bSOvV5d9fwNVpHsViAq9WkfZXwjDY
	 TjV1d6n9UtWvKJd5kEtgudOFhrwrU5Tqlbphr/fkOvUDZOQfus3MPQQoov2cb4wpPA
	 epyU12qsyhS4wEU3eX/QjNt/iMgKW8y2fm6MwSck7vqIrDtybZD6wwsoGBwKrUdkUL
	 Qr3pEiaOrbwwyfwPRZU84Fv5eROC510ZFY4FQhbbdN+tQYQzVwFZeojy2+Gq7xOUFS
	 av/jq6KFvqt+Q==
Date: Tue, 13 Jan 2026 22:19:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260114061930.GL15583@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
 <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs>
 <20260113155701.GA3489@lst.de>
 <20260113232113.GD15551@frogsfrogsfrogs>
 <20260114060214.GA10372@lst.de>
 <20260114060705.GK15583@frogsfrogsfrogs>
 <20260114061559.GA10613@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114061559.GA10613@lst.de>

On Wed, Jan 14, 2026 at 07:15:59AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 13, 2026 at 10:07:05PM -0800, Darrick J. Wong wrote:
> > > a tunable is a better choice here at least for now.
> > 
> > <nod> I'll set iosize to 1MB by default and userspace can decrease it if
> > it so desires.
> > 
> > Also it occurs to me that max_hw_sectors_kb seems to be 128K for all of
> > my consumer nvme devices, and the fancy Intel ones too.  Funny that the
> > sata ssds set it to 4MB, but I guess capping at 128k is one way to
> > reduce the command latency...?  (Or the kernel's broken?  I can't figure
> > out how to get mpsmin with nvme-cli...)
> 
> mpsmin is basically always 4k.
> 
> 
> On something unrelated:  SSDs remap all the time by definition, and
> HDDs are really good at remapping bad sectors these days as well.
> So verifying blocks that do not actually contain file system (meta)data
> is pretty pointless.   Can we come up with a way to verify only blocks
> that have valid data in them, while still being resonably sequential?
> I.e. walk the rmap?

xfs_scrub phase6 already calls getfsmap to figure out which parts of the
disk actually contain written data of any kind and are worth verifying.

--D

