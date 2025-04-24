Return-Path: <linux-fsdevel+bounces-47209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E89CA9A671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D496118802A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477F221279;
	Thu, 24 Apr 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akfXnO4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F02206BB;
	Thu, 24 Apr 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484021; cv=none; b=hLEoa1lig+d8FUMvXkfxNzYywR7Be7xNWg6pSmkW9ZMh9uUyRB8B5W8Fc1eiuNDYrmyk0g6V2t7POGYV9CbSwtU1WZieV3h9SboMUwAwrbC97Ml7MdByZ0b/TI0Lm36NyTMB+bramGiFuq5rdkfQgkwqfSFlqbTNmOf1drQXAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484021; c=relaxed/simple;
	bh=sVIlkPEQeG3DxeMz+vLqRh28tiKBnygsKuB6DCumRl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAMV/1lYmxrsvsoLKwRRDFejm6KkEQDpAmGhUHOXMLj596jbo8so7v195bvIbH7rHf1gSGUrWfQNiu4z/x9EXQCD5EbH90BZ3DTlj/LOEo1jzHqrom+8y5dYEOvmXpEqpON1iSuCRAEJh8DLB/V2KZ/ur6Dol/kqCWAXE3YMKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akfXnO4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDD5C4CEEC;
	Thu, 24 Apr 2025 08:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745484020;
	bh=sVIlkPEQeG3DxeMz+vLqRh28tiKBnygsKuB6DCumRl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akfXnO4dERto9TNmT2ocyhltse8MkqWj6RyweWyMXLAxGdxLPzD/YKVtb4NNyynU8
	 jgBuECVcxRiH+X8ZsnipqVsU4Rdx2zw1sOFb1/RKSsiz8WTjttDQTDswjC1+blPsoI
	 ZWRBVk5V36LLdT6wZgHj3bjR79cbmEVU6G8HSZcGWdGiSPqYPHFmCIVJnuNKBntoek
	 kuX5FiF3N5tXhlnANp6F01OGiStqEA1vRKD+XBFuq4pQwjrvljg41La7inctrJhrgi
	 YHeIlxI/hNjXVd7QGlhlQTy5pAL8rb48nUp+lb/SXOh019IYIF6NjLAv/VBh49HX8E
	 NX6kiwZfceLtg==
Date: Thu, 24 Apr 2025 10:40:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hca@linux.ibm.com, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250424-waldgebiet-mitinhaber-886939383e1f@brauner>
References: <20250423045941.1667425-1-hch@lst.de>
 <20250423-wettkampf-zahnlos-87fa8f273df7@brauner>
 <2025042305-timid-unusable-0501@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025042305-timid-unusable-0501@gregkh>

On Wed, Apr 23, 2025 at 08:42:34AM +0200, Greg KH wrote:
> On Wed, Apr 23, 2025 at 07:54:51AM +0200, Christian Brauner wrote:
> > On Wed, Apr 23, 2025 at 06:59:41AM +0200, Christoph Hellwig wrote:
> > > The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
> > > helper caused it being used by devtmpfs, which leads to deadlocks in
> > > md teardown due to the block device lookup and put interfering with the
> > > unusual lifetime rules in md.
> > > 
> > > But as handle_remove only works on inodes created and owned by devtmpfs
> > > itself there is no need to use vfs_getattr_nosec vs simply reading the
> > > mode from the inode directly.  Switch to that to avoid the bdev lookup
> > > or any other unintentional side effect.
> > > 
> > > Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Reported-by: Xiao Ni <xni@redhat.com>
> > > Fixes: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Tested-by: Xiao Ni <xni@redhat.com>
> > > ---
> > 
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> Do you want me to take this through the driver-core tree, or is this a
> fs-specific thing as that's where the regression showed up from?  Either
> is fine with me.

I'd grab it because it's a fixes for an earlier commit from Christoph.
I also need to check whether we need to revert the bdev_statx() addition
to vfs_getattr_nosec().

Thanks, Greg!

