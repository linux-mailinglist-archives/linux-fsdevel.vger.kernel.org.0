Return-Path: <linux-fsdevel+bounces-42859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9DA49DAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16993171472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D863425DD1D;
	Fri, 28 Feb 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqsGOGVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAC16EB7C;
	Fri, 28 Feb 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757163; cv=none; b=G0uTRySy4K+Ilnwlvch7HRijpKZe+Y3zZHmHdau7jZ+bcWwZkgIisVCuGT0HcEecB842/t/WLbLiChkVMdmjyUcXX1vV7ZPf/Paeu7L8l2haV/n711Bo3lZaFP8w6F8dGxbT6I/L8t55pSM2RakYf2CM0M1u2muRb2rseK71OLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757163; c=relaxed/simple;
	bh=B8f9YoA217D5MfhZBuAP3T/3FZZ+EJYwQ1Da0jiEJVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3HCNfByGuyWVf+LD/Sbltvl20cG6z3d8hBNQJw7ZqloKMIy/n54+a2nDpwhiAnXhnKNoEqnmD4BMJfD3Pn/jN9V82pq0/rAUesVmM6MqI2E7EIfVBWoeGA1zNlXwkIt5L1bEG69G/NYBkEFYNlUOlXAikOxo4Y2itW/7MAJnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqsGOGVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850A9C4CED6;
	Fri, 28 Feb 2025 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740757162;
	bh=B8f9YoA217D5MfhZBuAP3T/3FZZ+EJYwQ1Da0jiEJVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqsGOGVyOu9yYSdB2GX0A4lXGa3nLORJjJrhnVDHUg9fMvH5+bNb6fAjKnFGEY+kD
	 JrilKnDRUC9PpZvl1kHG4Az4lbPkMn04JxMpwaeF+2XZxHo2aNXHCTfUoAKt+lOPPG
	 x+oUWMiTV7/or3OkvMl5jg3XYKk1myk4iI/eqwiFqpeHhcPnA/EYFHuarZB1XFglSs
	 aNGJ0fRG/q6jghFyjEPeMH3K/8b6Xjam4rC2IMtq2b+sC5l4r3taDPWysMXQE6Z4tl
	 Ik4bKy9B+qQ8sdjD0NdYMLuZ9EOrMq+lIWd9EaHhq8SrhYJTW5hcpTYTnobweKp7mG
	 iwWLmLwE1SE/g==
Date: Fri, 28 Feb 2025 07:39:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 09/12] xfs: Add xfs_file_dio_write_atomic()
Message-ID: <20250228153922.GY6242@frogsfrogsfrogs>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-10-john.g.garry@oracle.com>
 <20250228011913.GD1124788@frogsfrogsfrogs>
 <903c3d2d-8f31-457c-b29d-45cc14a2b851@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903c3d2d-8f31-457c-b29d-45cc14a2b851@oracle.com>

On Fri, Feb 28, 2025 at 07:45:59AM +0000, John Garry wrote:
> On 28/02/2025 01:19, Darrick J. Wong wrote:
> > > +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
> > > +	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
> > > +		xfs_iunlock(ip, iolock);
> > > +		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
> > One last little nit here: if the filesystem doesn't have reflink, you
> > can't use copy on write as a fallback.
> > 
> > 		/*
> > 		 * The atomic write fallback uses out of place writes
> > 		 * implemented with the COW code, so we must fail the
> > 		 * atomic write if that is not supported.
> > 		 */
> > 		if (!xfs_has_reflink(ip->i_mount))
> > 			return -EOPNOTSUPP;
> > 		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
> > 
> 
> Currently the awu max is limited to 1x FS block if no reflink, and then we
> check the write length against awu max in xfs_file_write_iter() for
> IOCB_ATOMIC. And the xfs iomap would not request a SW-based atomic write for
> 1x FS block. So in a around-about way we are checking it.
> 
> So let me know if you would still like that additional check - it seems
> sensible to add it.

Yes, please.  The more guardrails the better, particularly when someone
gets around to enabling software-only RWF_ATOMIC.

--D

> Cheers,
> John
> 
> 

