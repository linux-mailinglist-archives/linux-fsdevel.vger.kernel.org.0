Return-Path: <linux-fsdevel+bounces-20002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391758CC398
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C9F283999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F120DC3;
	Wed, 22 May 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOGTz7oy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4831C683;
	Wed, 22 May 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389798; cv=none; b=Az2Pr0oDNEi61pJhYTOvY5y+yYZdEJYRKHGSpMoogNePyNqKmczi8xFa5CIUFOv8bcyjt6wCLNqvxwV93bY0Jhd38p5GRj4KcWN/NuAziEd6ReZ/U464SuvKKh2e1OYjsNPKQZwQCYHKxTfnBy7s1xgpjjnS8zM/G9QLmFZhGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389798; c=relaxed/simple;
	bh=zWm8NiSY2+aawW2KRUHKXAJ/95lx4gCIUjpIrTP/ufc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpsbRBpFn1DdU6Z8C8EFWjiCeF1mqpDuqKtURQKNujy2nmvr5oRpqWxBG9ZkxWltaw5pLdaQXDwXUS1yuwyVQJPf84tP4sYoP+PCpfh7LpMI0VvE5Pn0kQTd6OoxY1anCsHJgvFx8F+qHP7PRyeyKQMGRPPWv10XFu87haNn1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOGTz7oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415E3C2BBFC;
	Wed, 22 May 2024 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716389798;
	bh=zWm8NiSY2+aawW2KRUHKXAJ/95lx4gCIUjpIrTP/ufc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOGTz7oynf65RXL6PVaStX562gyTyqhuRcDAIstxAgUBzOyhuqL9yJvvd1on9/nyv
	 2POi+KESaZ7+I1qt3oo8po9UUfh1Y1clhy+vtovEWSrXmtX4ORJHWVQE1abZ+SdTHd
	 qv2umpzSHjBXMTTiGYbq4lJ1r6e8+l/Cek2UlHdoca/16QAn0WPvI7VxA9PymwLMpt
	 q/Vu7I5TUwCiScpmepGhVnIRhRJonYO2/e4jwzh7aEFTRkGV32sjmW2Epfk9gASBdi
	 90yeF0mQGFjHZpttSXuC0+gC6dXSrB1UzV4Q1iUDrf13hGLkjWhW+35KEY/mzNUkU3
	 /NZbFLelIBbnQ==
Date: Wed, 22 May 2024 07:56:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: swap: print starting physical block offset in
 swapon
Message-ID: <20240522145637.GV25518@frogsfrogsfrogs>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <20240522074658.2420468-3-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522074658.2420468-3-Sukrit.Bhatnagar@sony.com>

On Wed, May 22, 2024 at 04:46:58PM +0900, Sukrit Bhatnagar wrote:
> When a swapfile is created for hibernation purposes, we always need
> the starting physical block offset, which is usually determined using
> userspace commands such as filefrag.

If you always need this value, then shouldn't it be exported via sysfs
or somewhere so that you can always get to it?  The kernel ringbuffer
can overwrite log messages, swapfiles can get disabled, etc.

> It would be good to have that value printed when we do swapon and get
> that value directly from dmesg.
> 
> Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
> ---
>  mm/swapfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f6ca215fb92f..53c9187d5fbe 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3264,8 +3264,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
>  	enable_swap_info(p, prio, swap_map, cluster_info);
>  
> -	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
> +	pr_info("Adding %uk swap on %s. Priority:%d extents:%d start:%llu across:%lluk %s%s%s%s\n",
>  		K(p->pages), name->name, p->prio, nr_extents,
> +		(unsigned long long)first_se(p)->start_block,

Last time I looked, start_block was in units of PAGE_SIZE, despite
add_swap_extent confusingly (ab)using the sector_t type.  Wherever you
end up reporting this value, it ought to be converted to something more
common (like byte offset or 512b-block offset).

Also ... if this is a swap *file* then reporting the path and the
physical storage device address is not that helpful.  Exposing the block
device major/minor and block device address would be much more useful,
wouldn't it?

(Not that I have any idea what the "suspend process" in the cover letter
refers to -- suspend and hibernate have been broken on xfs forever...)

--D

>  		K((unsigned long long)span),
>  		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
>  		(p->flags & SWP_DISCARDABLE) ? "D" : "",
> -- 
> 2.34.1
> 
> 

