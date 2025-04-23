Return-Path: <linux-fsdevel+bounces-47106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458DA991F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D053463CA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8E2BD598;
	Wed, 23 Apr 2025 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDOfynEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80328EA56;
	Wed, 23 Apr 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421664; cv=none; b=CzoaN6kSjcusaXMZ4Ryfpu6yP0vXKr4MFMX33jmBKZkJDxMeMzTz89V9KSsUr6JgMlnj6l3uk1k4LlzlRHcPDTnEDHYAPboI8LU3CvUZz06ukHqIXNZ+PtTknLXWWErtvnggzp8Fzcuq1UxNbHvJ7f1r0YTNXl6Jf7VwCG6TyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421664; c=relaxed/simple;
	bh=gzxfMjmVDcE5HTN533uohFiedZVmeDQ1cuY6pDnPCmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaWkc1oAQEdvIOweInP4s/ShATUMBBc3pJpH8NXwg4DBJyx4odNzPvW1uCmg+r0TFMUBFKaXPCohfVDL8or0clzGv5E/P02u4GjD5RNvuxIZ5x575jkMHthujX2SN3ntUA+a/9R6AoVRoLgXhcm+3SdMQ9NZY9mWhxWstS8UGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDOfynEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946BAC4CEE2;
	Wed, 23 Apr 2025 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421663;
	bh=gzxfMjmVDcE5HTN533uohFiedZVmeDQ1cuY6pDnPCmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDOfynEOoA4vbAHa9Hman68CVhYpB5f2QQxguP0d/0HUXVHH8mcFm0u4O+hUriE8c
	 fqI/5nMKaytYWRHaHISUkcdsLgxWZbSkB6xcuN2bJwmAXz0G/5yzOIVAZpGMIzPdmn
	 0rOUuqxc+KYeREy2cG9Xn8c+22AcHQRPqN7EpWDMWvA2t97//qi1ZupV0hiLw8lC02
	 OBWRswrTEyhGusOH1d+hGuIp6+HrcjXvV2psOfPGtHgg9Ao+MMnVBiPqwEozxfXtBB
	 K4rcNs4CTyjq70cp7FN9TxW/+fXmZyF740JCMINBW3fdddcwTWb/rTYO/y+91tI2tt
	 74nZhaf7VhYsg==
Date: Wed, 23 Apr 2025 08:21:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 15/15] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
Message-ID: <20250423152103.GD25675@frogsfrogsfrogs>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-16-john.g.garry@oracle.com>
 <20250423083209.GA30432@lst.de>
 <20250423150110.GB25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423150110.GB25675@frogsfrogsfrogs>

On Wed, Apr 23, 2025 at 08:01:10AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 23, 2025 at 10:32:09AM +0200, Christoph Hellwig wrote:
> > On Tue, Apr 22, 2025 at 12:27:39PM +0000, John Garry wrote:
> > > From: "Darrick J. Wong" <djwong@kernel.org>
> > > 
> > > Introduce a mount option to allow sysadmins to specify the maximum size
> > > of an atomic write.  If the filesystem can work with the supplied value,
> > > that becomes the new guaranteed maximum.
> > > 
> > > The value mustn't be too big for the existing filesystem geometry (max
> > > write size, max AG/rtgroup size).  We dynamically recompute the
> > > tr_atomic_write transaction reservation based on the given block size,
> > > check that the current log size isn't less than the new minimum log size
> > > constraints, and set a new maximum.
> > > 
> > > The actual software atomic write max is still computed based off of
> > > tr_atomic_ioend the same way it has for the past few commits.
> > 
> > The cap is a good idea, but a mount option for something that has
> > strong effects for persistent application formats is a little suboptimal.
> > But adding a sb field and an incompat bit wouldn't be great either.
> > 
> > Maybe this another use case for a trusted xattr on the root inode like
> > the autofsck flag?
> 
> That would be even better, since you could set it at mkfs time and it
> would persist until the next xfs_property set call.

[/me hands himself another coffee]

The only problem is, setting the property while the fs is mounted does
not change the actual fs capability until the next mount since
properties are regular (and not magic) xattrs.

--D

> --D
> 

