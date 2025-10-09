Return-Path: <linux-fsdevel+bounces-63664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92ECBC9ABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A628019E1CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933172EC094;
	Thu,  9 Oct 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz7Hsju7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66314A06;
	Thu,  9 Oct 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022087; cv=none; b=RJ76p0PBp4sAtwUfJpcYkrLnZy8rtgp8gsgqFwLiRHGn2Vc0IPA0RAkTUxex4DoCSBA4Z4jyZyWbJ6lgUTNkIyvFoe1GNwl6UcwfptIB2WBSPHmkRt2IuDsICfttOMx3j0f8EsNhM6aLL2SshH62oJlWJolbQXKS9phBY0e7zYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022087; c=relaxed/simple;
	bh=fGUbxV2imRoaC18tpDejY6Nxj+HVoSQvDfYC1VnKUH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUkxtcUrIrf1EIqGJrKE2FDgPNE7WJhm3ijAOt4+bE3mtgHjIbkFYcia/HE1Vw2gjUcFcB0S8rWmE9w9EjMCKrXXhCK8kFpvxPAMxjNWrXF0RzQlbOdC4eEfaYTJCM8+TL5/IktcHoMk5W/HMiuzdJOTGYtwVaM/h9m7zCH0jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz7Hsju7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7B9C4CEE7;
	Thu,  9 Oct 2025 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022086;
	bh=fGUbxV2imRoaC18tpDejY6Nxj+HVoSQvDfYC1VnKUH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fz7Hsju7/kGLF37hvNE1LY+cXN+928YRhy6D3AHsurEewVMgwdn5msgAmDP/P/f+V
	 q+V4diujSO+hEsAZ2UDdJffturMjFFmAIq8vdr/5+gBd7zkat3e8Jd8xKNh/IcgYW9
	 bsm6oRRYKea3wC2OlizlylQGeCUEdb42Vx8mc6THJIJqX5SOc+snn/r8pC4AE54pGU
	 RvQ4NE9+UqIC+7OK5OSX0wRUUuXllNqB2/W2ZXlYNZio/tYjtZbdCPhW4pZR0LTm0i
	 8lgvBl1W5frlR3kKtkmi5nElm7zcdjF4sOpHqxSTOXBZY/IBu5LtTlzC5Frc9xlGPY
	 Lta8x10HbrEvg==
Date: Thu, 9 Oct 2025 08:01:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: alexjlzheng@gmail.com, dave.hansen@linux.intel.com
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH] iomap: move prefaulting out of hot write path
Message-ID: <20251009150125.GD6188@frogsfrogsfrogs>
References: <20251009090851.2811395-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009090851.2811395-1-alexjlzheng@tencent.com>

On Thu, Oct 09, 2025 at 05:08:51PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> Prefaulting the write source buffer incurs an extra userspace access
> in the common fast path. Make iomap_write_iter() consistent with
> generic_perform_write(): only touch userspace an extra time when
> copy_folio_from_iter_atomic() has failed to make progress.
> 
> This patch is inspired by commit 665575cff098 ("filemap: move
> prefaulting out of hot write path").

Seems fine to me, but I wonder if dhansen has any thoughts about this
patch ... which exactly mirrors one he sent eight months ago?

--D

> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8b847a1e27f1..6e6573fce78a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -972,21 +972,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  		if (bytes > iomap_length(iter))
>  			bytes = iomap_length(iter);
>  
> -		/*
> -		 * Bring in the user page that we'll copy from _first_.
> -		 * Otherwise there's a nasty deadlock on copying from the
> -		 * same page as we're writing to, without it being marked
> -		 * up-to-date.
> -		 *
> -		 * For async buffered writes the assumption is that the user
> -		 * page has already been faulted in. This can be optimized by
> -		 * faulting the user page.
> -		 */
> -		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
> -			status = -EFAULT;
> -			break;
> -		}
> -
>  		status = iomap_write_begin(iter, write_ops, &folio, &offset,
>  				&bytes);
>  		if (unlikely(status)) {
> @@ -1001,6 +986,12 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
>  
> +		/*
> +		 * Faults here on mmap()s can recurse into arbitrary
> +		 * filesystem code. Lots of locks are held that can
> +		 * deadlock. Use an atomic copy to avoid deadlocking
> +		 * in page fault handling.
> +		 */
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		written = iomap_write_end(iter, bytes, copied, folio) ?
>  			  copied : 0;
> @@ -1039,6 +1030,16 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  				bytes = copied;
>  				goto retry;
>  			}
> +
> +			/*
> +			 * 'folio' is now unlocked and faults on it can be
> +			 * handled. Ensure forward progress by trying to
> +			 * fault it in now.
> +			 */
> +			if (fault_in_iov_iter_readable(i, bytes) == bytes) {
> +				status = -EFAULT;
> +				break;
> +			}
>  		} else {
>  			total_written += written;
>  			iomap_iter_advance(iter, &written);
> -- 
> 2.49.0
> 
> 

