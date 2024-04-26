Return-Path: <linux-fsdevel+bounces-17917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF0C8B3BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FDD1C241EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F8149018;
	Fri, 26 Apr 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0jTmmbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7F149E0B;
	Fri, 26 Apr 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146187; cv=none; b=ryoQ07ycAlyDyBFhnP/YEZm5k9a3onoeCE0x4soo1WrM+qYoobHMZhvMgWwyxeBW8AiFF7u43bg2qucTw+0GR29bJJ8xHCTOYxK9Ev8Vr5ovqWbKDRVSddmeUY1h765Vy1JxaUy24kYTKDQp5dOkIXfoXymYd9M7BnFUvlOfvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146187; c=relaxed/simple;
	bh=3+MZ66czdcyI5ySyUqaAWboyXMAynQGI20OLMSN+S04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmXliG0d/g57GdbDBTy4EKtmClV24rxd9eeHM/Pp/yYKPpjxLtq8uYrLI/o4dnMNHTH8HhP5tHTJqjX1R3Ftcd/Pset6CAdc2EaUjmPaZ7eT0rJ8mzFPkIwUVARFLUWWzr36kLD0EyNBskpBUxCtW+nkVK/3REVPSx30c3hgEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0jTmmbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B6FC113CD;
	Fri, 26 Apr 2024 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146186;
	bh=3+MZ66czdcyI5ySyUqaAWboyXMAynQGI20OLMSN+S04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0jTmmbqTpKuOmXZSdP719T4nHxqf1QK0u51lSPC4Ya8tc4gf8yIXHrbdYUVYRPqv
	 0p2K22Mew/703CANqSZ4djhiQka/y6Kj7AeuSLFAn0gfQ11QZoeFQ6JnGGoFJLYU5j
	 QhAOSx3eNvbi7aOBlK2K3299eIyeXdzkhJc6e30fGBedN0M+re5uE7a78S7iZxNSw3
	 CvV/smtkGW0YUSnrAe8y9/n29b9ZCzyUJ4KYseaiK3cExqDH/RPXwx0jLMyXLOHiS7
	 wRtTeOq44OO9nmGWxUropwFoOqf39jybXtIaW9niIe1WfMYSJlPyU8KLe4f5dLatsf
	 8T4dvEZTZiK1Q==
Date: Fri, 26 Apr 2024 08:43:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 5/7] iomap: Fix iomap_adjust_read_range for plen
 calculation
Message-ID: <20240426154306.GM360919@frogsfrogsfrogs>
References: <ZitOlbeIO4_XVw8r@infradead.org>
 <87ttjoijzq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttjoijzq.fsf@gmail.com>

On Fri, Apr 26, 2024 at 02:22:25PM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Thu, Apr 25, 2024 at 06:58:49PM +0530, Ritesh Harjani (IBM) wrote:
> >> If the extent spans the block that contains the i_size, we need to
> >
> > s/the i_size/i_size/.
> >
> >> handle both halves separately
> >
> > .. so that we properly zero data in the page cache for blocks that are
> > entirely outside of i_size.
> 
> Sure. 
> 
> >
> > Otherwise looks good:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks for the review.

With Christoph's comments addressed, you can also add
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> -ritesh
> 

