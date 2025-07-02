Return-Path: <linux-fsdevel+bounces-53687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7888AF604D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F71F7A4D89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17210303DC3;
	Wed,  2 Jul 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI6V8r7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617812F5095;
	Wed,  2 Jul 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478248; cv=none; b=iBA/K3hC4NtSpbKp7sjaf4FogbXiIQ4GooySUofGH8HMsOCjtsl9HC2qcd+pvSW0LLpgOZxHYOSIZo6il3+0CCYB2rg9O3yCISI0ZUoKyIAkXdnqvZlJcyJckETDoQ1S8XHhESjvnTuAYP5secXMFgriyNPtVLvpwZ5ila35UrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478248; c=relaxed/simple;
	bh=trVErAcIl9ScDZFHpt6r2SV3AzCvDDWaUGIJFRQYAIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVVEIMtSPGSDfOyHRtzdUZZc166SxEm+8eEUw6sAkbJEknV8kYwjUepfx1LIfD/NsmL4/djwKXwxJ1/kQT+riTvCEPwO8EP7nYW84oDWN03gYB4GMYAf+FIQph24CZcH96Kiu0L7o12FDOdkNvq3KPH5Xh8ss0o2ngl8SNqwCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI6V8r7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD5C4CEE7;
	Wed,  2 Jul 2025 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478247;
	bh=trVErAcIl9ScDZFHpt6r2SV3AzCvDDWaUGIJFRQYAIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AI6V8r7ZiIpOmAOzuF3jzZwhNUrRK8wcDcExDBq9bF0GgMWlPKRSdIeeGh0L4Ltdl
	 8hcffsMDumc/+VRvHrzn1yUSmnA0B/8qtNDuTtVJNRVSTZtrZ6G0hSCXwxeE7MTd4u
	 ENfKd7tOHAg3J4hQjIbLJ951cxHQt+LNVzv3QewxvX2j3Iaqg32PG2ZITcf+kWEr/v
	 OSE60GeKVHReOar9wVzcQqDS96pK2mSBtumnGPC6j321Gf4HLwx4ZKnFjP2vmUcGhu
	 Y3pS85qLIdfuQuEQ6aH0lxNOcDgU8PExMsISOpX/RI/55rr/tZg1qDXw8lmdmVpaAg
	 91Rkhmz+OdvXw==
Date: Wed, 2 Jul 2025 10:44:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 09/16] iomap: export iomap_writeback_folio
Message-ID: <20250702174407.GC10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-10-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:28PM -0700, Joanne Koong wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Allow fuse to use iomap_writeback_folio for folio laundering.  Note
> that the caller needs to manually submit the pending writeback context.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Seems reasonable to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  include/linux/iomap.h  | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2973fced2a52..d7fa885b1a0c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1638,8 +1638,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> -static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
> -		struct folio *folio)
> +int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = wpc->inode;
> @@ -1721,6 +1720,7 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
>  	mapping_set_error(inode->i_mapping, error);
>  	return error;
>  }
> +EXPORT_SYMBOL_GPL(iomap_writeback_folio);
>  
>  int
>  iomap_writepages(struct iomap_writepage_ctx *wpc)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index bfd178fb7cfc..7e06b3a392f8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -465,6 +465,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len);
>  void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len);
> +int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
>  int iomap_writepages(struct iomap_writepage_ctx *wpc);
>  
>  /*
> -- 
> 2.47.1
> 
> 

