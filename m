Return-Path: <linux-fsdevel+bounces-42136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87707A3CC76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6763916C19D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789525A2AC;
	Wed, 19 Feb 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftkMCGty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125023C368;
	Wed, 19 Feb 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004584; cv=none; b=SN4Ln4w4uFhM0YZZZmT1kfpJ9qCPn0G2A7B7Vc7R1ATp67/uDfxkU/oqvoYs+/RxfLrUMMcwj1VQJ/Pubu8Sdl72UbQwMxQQa6/p9m1PjISKALexBrQQjXCPu/gvc+K8ZaiApTLVnYiqMzCQ69JyTLy7y/dMuqnT0a5gW99pIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004584; c=relaxed/simple;
	bh=jKAxW9e6zu9f/bynTF0kVI/rsWrLORYE8YVwTUiFSsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIQiwcz29SdC340C2kKYoPTEx9vZUfPVhn6tlH1GpTfvF78/AfktX+QtH3sAHvgV9oq2uoSjNtxVibEQLY08inNxQTxq1F36jqnNfXCrRoKWOeoD0S2f1ZXwa45t/EVyDx7HZ9PmY912bXoSp5mvkSMgNlrC6LnzwByLtPyjhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftkMCGty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDA8C4CED1;
	Wed, 19 Feb 2025 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004584;
	bh=jKAxW9e6zu9f/bynTF0kVI/rsWrLORYE8YVwTUiFSsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftkMCGty3pseaHztHe4X+I4j+EXE7CTuyHdlMn0YQscp7ziku1wJ4KBdhTSFmJIIf
	 X1WiELWSxe+M2xM8ihX4Y+RY2JLWMylEKUGFtcOgUjYUaReQZ2kdB1SUoJwoDJkRzN
	 8JJEB94Ntl46UwVh+VRjsodMvUivhvJcYxiHhhm+n1PCdXXuYKm5qoiOfxtsFL1ZvD
	 qX4mxdvjhVvtgVpxfqYY52Xr4R9Hm5OyIfUPxrlU47sboSo9ANGAfgHRidH+U12zcb
	 nYNmU/CFfOIsO7Y5CsjzOJkHSULLtLFYNe5txo0J2yJd5ZY6+1Ma+8u06xE5rwYAIY
	 9jlhqR06mfAYw==
Date: Wed, 19 Feb 2025 14:36:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 09/12] dax: advance the iomap_iter on pte and pmd
 faults
Message-ID: <20250219223623.GO21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-10-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-10-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:47PM -0500, Brian Foster wrote:
> Advance the iomap_iter on PTE and PMD faults. Each of these
> operations assign a hardcoded size to iter.processed. Replace those
> with an advance and status return.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index c8c0d81122ab..44701865ca94 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1771,8 +1771,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  			ret |= VM_FAULT_MAJOR;
>  		}
>  
> -		if (!(ret & VM_FAULT_ERROR))
> -			iter.processed = PAGE_SIZE;
> +		if (!(ret & VM_FAULT_ERROR)) {
> +			u64 length = PAGE_SIZE;
> +			iter.processed = iomap_iter_advance(&iter, &length);
> +		}
>  	}
>  
>  	if (iomap_errp)
> @@ -1885,8 +1887,10 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  			continue; /* actually breaks out of the loop */
>  
>  		ret = dax_fault_iter(vmf, &iter, pfnp, &xas, &entry, true);
> -		if (ret != VM_FAULT_FALLBACK)
> -			iter.processed = PMD_SIZE;
> +		if (ret != VM_FAULT_FALLBACK) {
> +			u64 length = PMD_SIZE;
> +			iter.processed = iomap_iter_advance(&iter, &length);
> +		}
>  	}
>  
>  unlock_entry:
> -- 
> 2.48.1
> 
> 

