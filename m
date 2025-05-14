Return-Path: <linux-fsdevel+bounces-48981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36BAB712B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760091B673FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA627C15A;
	Wed, 14 May 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2YX0GW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A127A92C;
	Wed, 14 May 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239828; cv=none; b=rEQckvt9TePzu3aAGQeroVLT2Dje4pl6nHvBu17wmraW7780vd+GU4pDvnI8u6Afm0olNE8ssuMcUuG2tStJJdgBQSb79vG3lv58wAUBQZOFC8TwlW3JSatJG14qC6Y12ynJ+JXsB0v72nc5/6i4EoPCArYZ3nEwRhaKLnm59Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239828; c=relaxed/simple;
	bh=QciJvT0ye+FB7haYpO9Jc0obRolFm9CcU08jRnCZhLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUCS1hAWY+kfOi7S0Z1xNiad8QK9B/NIub+E6fFqXO1W/SkqSOzftmIG/ipwh0z9GhyU8brkAJxpevMosIO0CQKzynOMnQ99/41D7L+vhwIWmaqnNOTpSh23tyvh6LtbQ6TPvjOSvf4M9TFEQD0jYmD6vBHmaxMAzOPtI5iERPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2YX0GW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DB0C4CEE3;
	Wed, 14 May 2025 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239827;
	bh=QciJvT0ye+FB7haYpO9Jc0obRolFm9CcU08jRnCZhLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2YX0GW2DZAQXDhCjU3bxHlUdCQbnl7EtZQB0SqEN/bznEQVC8Hrb4PI+KkeeulOy
	 B5ITeDQW9nGgkOkMjRO0B+IVqihx714IucWIz7hYPY04IaffTn3e4w8pZLqcYL3GjG
	 HufWlpL+hJ53v7mZQLd2xDa//VMORuSWYVhHC+C9v3V/bipdS51rgZyyiz5PGoqZpb
	 JJlhk8oxQioteOBZxLDtKVGsVbICMPjpPzw+R1HO6LUOtDggxRxN+z/MLevf4UGriW
	 Kqg/77Uy6OBeSOMEnZrIwfRD+bubMPOg6kA9Ro5/9nMhkqzBgGQjap/qerQzLwStwl
	 gADAA7GBSUUVw==
Date: Wed, 14 May 2025 09:23:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] ext4: Document an edge case for overwrites
Message-ID: <20250514162347.GJ25655@frogsfrogsfrogs>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <9f95d7e26f3421c5aa0b835b5aa1dd4f702fc380.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f95d7e26f3421c5aa0b835b5aa1dd4f702fc380.1746734745.git.ritesh.list@gmail.com>

On Fri, May 09, 2025 at 02:20:31AM +0530, Ritesh Harjani (IBM) wrote:
> ext4_iomap_overwrite_begin() clears the flag for IOMAP_WRITE before
> calling ext4_iomap_begin(). Document this above ext4_map_blocks() call
> as it is easy to miss it when focusing on write paths alone.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Weird but ok,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94c7d2d828a6..b10e5cd5bb5c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3436,6 +3436,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		}
>  		ret = ext4_iomap_alloc(inode, &map, flags);
>  	} else {
> +		/*
> +		 * This can be called for overwrites path from
> +		 * ext4_iomap_overwrite_begin().
> +		 */
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  	}
>  
> -- 
> 2.49.0
> 
> 

