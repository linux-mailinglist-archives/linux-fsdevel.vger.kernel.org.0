Return-Path: <linux-fsdevel+bounces-46110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B918A82A99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B8A19E3993
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52F267AFD;
	Wed,  9 Apr 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDYMkhjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F0267728;
	Wed,  9 Apr 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212622; cv=none; b=hLLbBMPcPZ5cfwHjM0ZeFaH4BfHN2M64b6GWuCQaKn8Ia3VueI12RAxUPO/132ijc20ZpFjSBOvlp/IH/SlDYo2wJS5xuohgmr1n/npIAHony3CzmrQYvyKR8j75TSlM8HS+b/DJqkNt9OX1LwPT6udncK40x4DBVVJIGtlTdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212622; c=relaxed/simple;
	bh=ivUQb28XI1vcjk3mNc3Pm/4MdzWr0iiUSHg1N7z6vVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOJ/CBrHZATS1KTnCpX0zfriNpfodHFZAFIMouIPWnRLzw2FLZ+vOnBvIOP5bnf4az6fityqw8DMbO48CsjIePPhf6hEVR4AxHdm+TVEqzDOmQJKF79NrL+y0pTRAsGI/5tbzE0hJVHlV9hGZbLRMrMCqMeRpcFOO6itLg0z+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDYMkhjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28182C4CEE2;
	Wed,  9 Apr 2025 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744212621;
	bh=ivUQb28XI1vcjk3mNc3Pm/4MdzWr0iiUSHg1N7z6vVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDYMkhjCpQG46BmGPRXq2jAkwtRVjx4zrPtmsh7qsgTXpCDgdWAiknzG+DhkPQG/2
	 Ztx/H68P0mbZ5sqSVUbRDbAhY9w9SlyfCrHLyEdKAl0GlOyimmXMiiKrZ11jhGnEVN
	 7LGW4XyzC2RN+S80NDGVVtguyJjkuRxN3bo9i0BdFqcfRQfoMlVwByRbn9izJQGRxy
	 fByIsxMxjrMEjHAh5vtS0sca3iBA5qbH2PrR8hYsH1Fp+Zlln/mnvzY7h03Pl+sZZ7
	 ZafepeRvJRHX9M5bG3Ggj+qUlaM9mNPVJQpyiQG/n5+KxKrRFEUm1AeC+g8i/z89hf
	 vmiRTn8J5tXsQ==
Date: Wed, 9 Apr 2025 08:30:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Gou Hao <gouhao@uniontech.com>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com, gouhaojake@163.com
Subject: Re: [PATCH] iomap: skip unnecessary ifs_block_is_uptodate check
Message-ID: <20250409153020.GR6283@frogsfrogsfrogs>
References: <20250408172924.9349-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408172924.9349-1-gouhao@uniontech.com>

On Wed, Apr 09, 2025 at 01:29:24AM +0800, Gou Hao wrote:
> After the first 'for' loop, the first call to
> ifs_block_is_uptodate always evaluates to 0.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 31553372b33a..2f52e8e61240 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -259,7 +259,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  		}
>  
>  		/* truncate len if we find any trailing uptodate block(s) */
> -		for ( ; i <= last; i++) {
> +		for (i++; i <= last; i++) {

Hmmm... prior to the loop, $i is either the first !uptodate block, or
it's past $last.  Assuming there's no overflow (there's no combination
of huge folios and tiny blksize that I can think of) then yeah, there's
no point in retesting that the same block $i is uptodate since we hold
the folio lock so nobody else could have set uptodate.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


>  			if (ifs_block_is_uptodate(ifs, i)) {
>  				plen -= (last - i + 1) * block_size;
>  				last = i - 1;
> -- 
> 2.20.1
> 
> 

