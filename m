Return-Path: <linux-fsdevel+bounces-66335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4123BC1C012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 892F54E1160
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0883C34D4CE;
	Wed, 29 Oct 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnpJGOIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48243345754;
	Wed, 29 Oct 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753662; cv=none; b=Nm+0ck8pCKgk5ECojZlap+79QfCcdpT8nli5vMy7GUbx18iOpECeEU0a/Peo3xyyfU+kS+uwOkUF9iAsM/hkth0jN4v5WM6i+1DqreVXVVfB067Hic64AOZulPvv4ru+U0jHDx2aVV1xPm7oXIxcF+zPc4sj/ixfNqLVB5DHpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753662; c=relaxed/simple;
	bh=5y2EenqzFLP9UzyCR6z3MZF4MozOljxHWjFYrZ0sBdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mntuBmY24tsaT4urrzYWm9ggqDZC+9Fvf01gJjCv4GtwralZOqYyAeAMJJKDAo4srQnp1Sjnyz+j8YkTwrXdJpKZGzJSqM7yEIeRDPqIOnJoaEpB7a/0o3HMjRkFo1uyUs/EUdKCoM+1juSLxP0Pwyq43pwk74bL0m5ZHnjemxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnpJGOIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17A2C4CEF7;
	Wed, 29 Oct 2025 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753661;
	bh=5y2EenqzFLP9UzyCR6z3MZF4MozOljxHWjFYrZ0sBdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnpJGOIbMKJh+QWUSTx/ethUcpBWOw5qYqWckokxZzQnPgP6hRohI4cGfn7FsA172
	 EUbl0S4GKRZ56nDsjtzTT19T2Nwk7U0980igwaTCPKdrg5Wybbww7cvpi32D/J6lDs
	 Zdhc1NDXEViVpj06QbMCb7B2DvdDx5Ef3Djydf+9e0ddgHZIu4Y9EYf8AgK2rbxcrK
	 dPEXFLiaiaaX0X1se/zfjkPWrdmiyh8di3LEnfv/2Z0AI2Y8ueLNYiaYj0Gy2iqEqX
	 pFyjR2GGnHcOynwxqlfS3c973A38XWNFCcIRp2KrDfVbea28x+Z+X2RpNQcIQqzsk1
	 H3LsSO4DrIPQA==
Date: Wed, 29 Oct 2025 09:01:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in
 generic_write_sync
Message-ID: <20251029160101.GE3356773@frogsfrogsfrogs>
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071537.1127397-3-hch@lst.de>

On Wed, Oct 29, 2025 at 08:15:03AM +0100, Christoph Hellwig wrote:
> Currently generic_write_sync only kicks of writeback for IOCB_DONTCACHE
> writes, but never looks at the writeback errors.  When using
> IOCB_DONTCACHE as a fallback for IOCB_DIRECT for devcies that require

                                                   devices

> stable writes, this breaks a few xfstests test cases that expect instant
> errors like removed devices to be directly propagated to the writer.
> While I don't know of real applications that would expect this, trying to
> keep the behavior as similar as possible sounds useful and can be
> trivially done by checking for and returning writeback errors in
> generic_write_sync.

Hum.  So we kick writeback but don't wait for any of it to start, and
immediately sample wberr.  Does that mean that in the "bdev died" case,
the newly initiated writeback will have failed so quickly that
file_check_and_advance_wb_err will see that?  Or are we only reflecting
past write failures back to userspace on the *second* write after the
device dies?

It would be helpful to know which fstests break, btw.

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/fs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 09b47effc55e..34a843cf4c1c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3047,9 +3047,13 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>  			return ret;
>  	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
>  		struct address_space *mapping = iocb->ki_filp->f_mapping;
> +		int err;
>  
>  		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos - count,
>  					      iocb->ki_pos - 1);
> +		err = file_check_and_advance_wb_err(iocb->ki_filp);
> +		if (err)
> +			return err;
>  	}
>  
>  	return count;
> -- 
> 2.47.3
> 
> 

