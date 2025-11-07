Return-Path: <linux-fsdevel+bounces-67405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E2C3E59E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76F304E8F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891B26FA4E;
	Fri,  7 Nov 2025 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmx93Mm8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23818027;
	Fri,  7 Nov 2025 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486241; cv=none; b=el1C8A15iRLDKr8nCBhD1lSmn9wZsEsjH8iqSQIzXObj5cX92usLIEzmXMuPzdcM8i0AxmA/QP/Ysrt6HU3BjNFNmtkU4pSO82+0p1jyQflKtKlUfF1C4THyVwXpwvr+SfoIq7biH7Y4d75u+3CWDiBtIf3PK3R1OQk195tIaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486241; c=relaxed/simple;
	bh=zK6jf9HHfZm7vm9mP8L9SdDIGPKOC1ipjKdiWKVH24U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca12Hmk+cRZRHjqDScnebWoCzJaapv3Tpr48NLpAFun3p2Toa/X/pkMmgWjOJ1Z0MyOfIc5hgrrYI1SG6fKgMeBb7mCMzvCqQPL55wPubKkLgUyOql266OKHMUcbq82xw2fRrKOSmi1r2CJhyAq3N9nBqDTLjzZKPU4uTvmZnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmx93Mm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E9C4CEF7;
	Fri,  7 Nov 2025 03:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486241;
	bh=zK6jf9HHfZm7vm9mP8L9SdDIGPKOC1ipjKdiWKVH24U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmx93Mm8sPB2G+whQZKs6CQHv8uOVVzQjnxcJ3abtl+hKc1VTMCuczlTNSgu3cAlq
	 IllRT54BTxToeD/15INBQxbSMEIhFN276EbRqTtb0RAjvPsxLllAVPOHnAGO2mJwGj
	 qJ4cP8XslbcUN/IkiiLS8TEGKhkO0C4T1JwLKPlNDFNzmuWCyMKF6Q6kj5VsnB+yVW
	 UA9Kg0ePw+ctcbpnodSL+xh/lN5cQ+c3wrQET58OKHwfe03rAsYS15uaYtGz/WeQvq
	 xgqQl8+VWLRjmo5ELv4p7nE81hd28CHkpOnVswAYSFicMxMrrx2PA+62nBferFcKnK
	 TIyioAuJNizEQ==
Date: Thu, 6 Nov 2025 19:29:00 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/9] mempool: add error injection support
Message-ID: <20251107032900.GB16450@sol>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-3-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:32AM +0100, Christoph Hellwig wrote:
> Add a call to should_fail_ex that forces mempool to actually allocate
> from the pool to stress the mempool implementation when enabled through
> debugfs.  By default should_fail{,_ex} prints a very verbose stack trace
> that clutters the kernel log, slows down execution and triggers the
> kernel bug detection in xfstests.  Pass FAULT_NOWARN and print a
> single-line message notating the caller instead so that full tests
> can be run with fault injection.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/mempool.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index d7c55a98c2be..15581179c8b9 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -9,7 +9,7 @@
>   *  started by Ingo Molnar, Copyright (C) 2001
>   *  debugging by David Rientjes, Copyright (C) 2015
>   */
> -
> +#include <linux/fault-inject.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/highmem.h>
> @@ -20,6 +20,15 @@
>  #include <linux/writeback.h>
>  #include "slab.h"
>  
> +static DECLARE_FAULT_ATTR(fail_mempool_alloc);
> +
> +static int __init mempool_faul_inject_init(void)
> +{
> +	return PTR_ERR_OR_ZERO(fault_create_debugfs_attr("fail_mempool_alloc",
> +			NULL, &fail_mempool_alloc));
> +}
> +late_initcall(mempool_faul_inject_init);

Initcalls usually go at the bottom of the file.

> +	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {

This doesn't build when CONFIG_FAULT_INJECTION=n.

- Eric

