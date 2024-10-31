Return-Path: <linux-fsdevel+bounces-33374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB49B8586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6644D1F254CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6C01CDFCE;
	Thu, 31 Oct 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Bt12i6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836C1D0E03;
	Thu, 31 Oct 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410939; cv=none; b=ow+3DV6WkzME2rNixwtZf2kdpAA312dQJJayVkeqTcumFeEA5YFLOomOavRXLX9oGcR/aYZndR2G6mWGJzmXpMiWwf6s7cEv9dqFnssQzice8hIJDV0to/i+Ho2zVYkaFyyUt/USFO32/nXkhd2bsA42fToWMSMfsaZnsvF7CiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410939; c=relaxed/simple;
	bh=1IUPJPksX/e73IKRaHj8GmjOeMBTHfHmBstwuyyR1QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc6rCNHla4Q7d8clZ5y2+k60iJqpo5V8VIDEMOQYYqK/7KcoaOoG6ZS8h3rG/XLw1f6YVp80QmDxqEpm21L1Zia9bvVDJ4UedLShfATgZSsX5p0Tf+nWrN1BDu46jAPX5XslIRFsz10gwN9vW4O5t0u7v8D6Fm+x0DvjABNFTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Bt12i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF28C4CEC3;
	Thu, 31 Oct 2024 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730410939;
	bh=1IUPJPksX/e73IKRaHj8GmjOeMBTHfHmBstwuyyR1QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/Bt12i6yLdyktcy0Jlq9U2xcXTkDVkHLVNJhsAJoeOkP1J5czLSLZC5gZczohTcO
	 myItrGlESPZRQ8eVq0os2KhQzyoxlYXkX6OCrd5wp+u4ro0QKJFyOwyth1jvAnpz45
	 qhNW/AqYLryNKKwJRemkWOy+kaI8Oh1t3laUSddl40YpOC8wI5psIDva4RP0/Cn/V4
	 hLy7Ix41NfZ9U+be2h1WMI6rESVN1Y5ebBb9vtzAdSrM5s6P33pJ2JWn5F29eSBoyn
	 63q86w0Qk9LhQ4FxhIyS8eazCEmv/4Lt6Zt803La1AzmrzigkzuSIIi+6vfD4oLnNj
	 uK0vrPwUE2u9Q==
Date: Thu, 31 Oct 2024 14:42:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] ext4: Check for atomic writes support in write
 iter
Message-ID: <20241031214218.GD21832@frogsfrogsfrogs>
References: <cover.1730286164.git.ritesh.list@gmail.com>
 <dc9529514a5c2d1ad5e44d649697764831bbaa32.1730286164.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9529514a5c2d1ad5e44d649697764831bbaa32.1730286164.git.ritesh.list@gmail.com>

On Wed, Oct 30, 2024 at 09:27:39PM +0530, Ritesh Harjani (IBM) wrote:
> Let's validate the given constraints for atomic write request.
> Otherwise it will fail with -EINVAL. Currently atomic write is only
> supported on DIO, so for buffered-io it will return -EOPNOTSUPP.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks decent,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext4/file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f14aed14b9cf..a7b9b9751a3f 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (IS_DAX(inode))
>  		return ext4_dax_write_iter(iocb, from);
>  #endif
> +
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		size_t len = iov_iter_count(from);
> +		int ret;
> +
> +		if (len < EXT4_SB(inode->i_sb)->s_awu_min ||
> +		    len > EXT4_SB(inode->i_sb)->s_awu_max)
> +			return -EINVAL;
> +
> +		ret = generic_atomic_write_valid(iocb, from);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (iocb->ki_flags & IOCB_DIRECT)
>  		return ext4_dio_write_iter(iocb, from);
>  	else
> -- 
> 2.46.0
> 
> 

