Return-Path: <linux-fsdevel+bounces-17909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6568B3B0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1E1F21153
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA414D43E;
	Fri, 26 Apr 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti3q8L3p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8B148FE2;
	Fri, 26 Apr 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144543; cv=none; b=XamIpr65J/XX5KjLqjsBmiA1qm0p2Sjt64xMXbDGNUg36nekBf/WE3KeaWnSKnJXDw+QX/opr+bgLLZ2tSl9Xx3zUwE897Dk6s+HonCMvUKhg+0taPGWfd8MrIlgEHaDVIwBEKm9fWYgqls6ZFNRKm1r8ObDQv4oZzNJ4U1jMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144543; c=relaxed/simple;
	bh=JtWLiBEE0MYykclQ9qosZ0yssrcJ73QSVvIgrP7pgsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbUf8/LKeJyNn90V/4AW/iHxXG0+uljilotpfm2KHMlscF09T/lqga/M83ABxkPXNz1o02Oh/Ag+FIRNJo3IMZdrBcYIhNq91I/mNnqarkPUe0HhbSd7udPrnrswnd1tdOREkMThGIVFxc7lHnWGIVSVIEBMutc4/O2fbboGQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti3q8L3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADF5C113CD;
	Fri, 26 Apr 2024 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144542;
	bh=JtWLiBEE0MYykclQ9qosZ0yssrcJ73QSVvIgrP7pgsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti3q8L3puZFymuhMqmUVIbsLhYTYUlL7mBfESqoSRiKAsoFFsbdfoXSD2aj5pGpJx
	 jgAYUQA7bbte0IKNAhmMBy2U3ZI6SVlUZIssgPZ7J6DIaEROICXhhUTTAHjN5/QC4d
	 RDsfWbUJtAChfuc/XdOGHkmbaf5H1Wrc2hAI0egBna3je2n9M9Drwb4N702Tt9HvpI
	 yzFOolF2WcRhoNeGOeGvIV6HsW/iUz2ixfGGwX4t/bFzzacF3EP3jXlw424h4IWPB8
	 nV5o7r38FcX68JD8BmcCBjjmzfR0QyZK+iJJYXw3usS2X6qGz1t7DOivKBHqkDi6/P
	 em30UbQ32m4ag==
Date: Fri, 26 Apr 2024 08:15:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 09/11] xfs: expose block size in stat
Message-ID: <20240426151542.GE360919@frogsfrogsfrogs>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-10-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-10-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:44PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> For block size larger than page size, the unit of efficient IO is
> the block size, not the page size. Leaving stat() to report
> PAGE_SIZE as the block size causes test programs like fsx to issue
> illegal ranges for operations that require block size alignment
> (e.g. fallocate() insert range). Hence update the preferred IO size
> to reflect the block size in this case.
> 
> This change is based on a patch originally from Dave Chinner.[1]
> 
> [1] https://lwn.net/ml/linux-fsdevel/20181107063127.3902-16-david@fromorbit.com/
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Seems reasonable to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 66f8c47642e8..77b198a33aa1 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -543,7 +543,7 @@ xfs_stat_blksize(
>  			return 1U << mp->m_allocsize_log;
>  	}
>  
> -	return PAGE_SIZE;
> +	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
>  }
>  
>  STATIC int
> -- 
> 2.34.1
> 
> 

