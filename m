Return-Path: <linux-fsdevel+bounces-13145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC486BC87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 01:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749A41C21498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259D01106;
	Thu, 29 Feb 2024 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYsuk93l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AF36E;
	Thu, 29 Feb 2024 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165355; cv=none; b=ltFOV7jW3p3XlaM97IMRnTLWtUXc8T5aMUoasM09/CO5cmvHEyvef8KKamjiRS0HQmVv3zzzDEYykicwyzayBCwEkNGLqPNw/BmJk5OxpgrWONaj8dn4lGGSQSWcD1y/p7rl11RWxWsFf5C/KXok9+1YXSMRND+GIfpc5yPFe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165355; c=relaxed/simple;
	bh=o2YrE4Wg5P5dMrPlsumXZdUJcLyEyakod/z5dZ8Cs/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9n8uXDpwbEah00akptyEjAUuh14BPr27olCwwy2NBO2/KxfZloOnVMUiNbJ6sdQJFQ0BDP6TQ1MECb+x2m0u8rhwviecrN3Vl61o7F1gQHkMxxhdODwW8EEBV4tV3rpukf6kWRD3cSla2JuvR5KGKvDvfkFabz1ZcWC5H9SgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYsuk93l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E9CC433C7;
	Thu, 29 Feb 2024 00:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709165355;
	bh=o2YrE4Wg5P5dMrPlsumXZdUJcLyEyakod/z5dZ8Cs/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYsuk93lDakFM2DAsuqJ9hVdSG13lxWT9Wck34hJMOHqr5Ai4TAUVHKrdbQAlByQr
	 p723t5WmZB6gvTpL6p0l6sm4Gv+jSkmQBmg0BIUdLfsMqxE4D8QxOzZaai1GNvlFS+
	 s31kdoYtY5vh3PTT6O+7UXfAPgChCpIYRWh84zL4+PxvMYo1/1YKezMfQsr/ARnvZp
	 aC7kRT8THTIlOuLjOGkT+ZHWL6ILYrL3N3DhPnaVFHPDrbloS0JqAK4URVt7AUe2ni
	 Ho5d6aQtUdQI6D7Lm9kCsM6QiXaVmJiP/KyHrn/uY2/Rn3hlt2Or9KRsAqEAaGf801
	 f0UIzGpk5B5AQ==
Date: Wed, 28 Feb 2024 16:09:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs: stop advertising SB_I_VERSION
Message-ID: <20240229000914.GX1927156@frogsfrogsfrogs>
References: <20240228042859.841623-1-david@fromorbit.com>
 <20240228160848.GF1927156@frogsfrogsfrogs>
 <Zd/H6pf1YM0mTk1r@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd/H6pf1YM0mTk1r@dread.disaster.area>

On Thu, Feb 29, 2024 at 10:55:22AM +1100, Dave Chinner wrote:
> On Wed, Feb 28, 2024 at 08:08:48AM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 28, 2024 at 03:28:59PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > The redefinition of how NFS wants inode->i_version to be updated is
> > > incomaptible with the XFS i_version mechanism. The VFS now wants
> > > inode->i_version to only change when ctime changes (i.e. it has
> > > become a ctime change counter, not an inode change counter). XFS has
> > > fine grained timestamps, so it can just use ctime for the NFS change
> > > cookie like it still does for V4 XFS filesystems.
> > > 
> > > We still want XFS to update the inode change counter as it currently
> > > does, so convert all the code that checks SB_I_VERSION to check for
> > > v5 format support. Then we can remove the SB_I_VERSION flag from the
> > > VFS superblock to indicate that inode->i_version is not a valid
> > > change counter and should not be used as such.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > 
> > Seeing as NFS and XFS' definition of i_version have diverged, I suppose
> > divorce is the only option.  But please, let's get rid of all the
> > *iversion() calls in the codebase.
> > 
> > With my paranoia hat on: let's add an i_changecounter to xfs_inode and
> > completely stop using the inode.i_version to prevent the vfs from
> > messing with us.
> 
> Ok, I'll do that in a new patch rather than try to do everything in
> a single complicated patch.

Sounds good!

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

