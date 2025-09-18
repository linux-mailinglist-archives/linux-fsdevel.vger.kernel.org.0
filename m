Return-Path: <linux-fsdevel+bounces-62178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E243FB87310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 23:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB98566DF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBD62FB0BB;
	Thu, 18 Sep 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiKU6bg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC61DF996;
	Thu, 18 Sep 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232555; cv=none; b=n2mUJsFl05T6HgTogxLErfgPKYL3S5u16cqzOkrkFDiWmdQzn3MHKi+aVvg0YEjh+5ZAybengUAwTNjmTQyVjmbqQepzSqbUhmmMa7/N/UHf24buJfOCdl4D/CMx1zQo4570AvPDfWckan+0VI6un1sYI+sPVKduoIzdzZ3+pwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232555; c=relaxed/simple;
	bh=3r3FJF7tnBqo8I2mbRhnltq1o3PtuTvWzSRtwmeefYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/jN/f2M9xqeXoKSa/Bw6MQejf7GM9j25HrFz+KSJEcBzEvZgW9JEQMTJoaBZWkKY37aRFzEmprOz1r98Kd2nGXoGvmkFYI2PVpCYXIQ5mmDCL2yh/W6fTisRC5nwsCC63iVLRh/cET5w40DGqLR1p/M08Ss2e4dZjKC9ComnUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiKU6bg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF1C4CEF0;
	Thu, 18 Sep 2025 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758232554;
	bh=3r3FJF7tnBqo8I2mbRhnltq1o3PtuTvWzSRtwmeefYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XiKU6bg7X20yegJPpWnF4ekbCfkYDOIdWyKV5OmwYG9piT9R4V3DMxTlYKG7xKH26
	 1bgDh2mZIOfcFvmOazRvjs/j/DjJsjtrrQAQymImbYjEivVkOA1z81aonB0VLT8CcZ
	 7qgSvVeSfCg9/UGyfC1KMTUfYEiGdcmrsuxnKw4+tOTcBijxkbkGIpgv9f1irTq7ED
	 lz6ltXV67VBElWTKb5K0gbQhcOWXtwKzh5BUF2QHDGhceCaM0kYDcghD3O01+6w3pg
	 2+5doHmtHbvK2iVFMgpMqrifVDWx4f6XMZB0rssdZGi+L1unEuqBrk6GqzuwP4nd+q
	 TvoEA+X7OAWjQ==
Date: Thu, 18 Sep 2025 14:55:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
Message-ID: <20250918215554.GX1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-13-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:22PM -0700, Joanne Koong wrote:
> No errors are propagated in iomap_read_folio(). Change
> iomap_read_folio() to a void return to make this clearer to callers.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Yesssssss
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 9 +--------
>  include/linux/iomap.h  | 2 +-
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 72258b0109ec..be535bd3aeca 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -450,7 +450,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  	return ret;
>  }
>  
> -int iomap_read_folio(const struct iomap_ops *ops,
> +void iomap_read_folio(const struct iomap_ops *ops,
>  		struct iomap_read_folio_ctx *ctx)
>  {
>  	struct folio *folio = ctx->cur_folio;
> @@ -477,13 +477,6 @@ int iomap_read_folio(const struct iomap_ops *ops,
>  
>  	if (!cur_folio_owned)
>  		folio_unlock(folio);
> -
> -	/*
> -	 * Just like mpage_readahead and block_read_full_folio, we always
> -	 * return 0 and just set the folio error flag on errors.  This
> -	 * should be cleaned up throughout the stack eventually.
> -	 */
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4a168ebb40f5..fa55ec611fff 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -340,7 +340,7 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private);
> -int iomap_read_folio(const struct iomap_ops *ops,
> +void iomap_read_folio(const struct iomap_ops *ops,
>  		struct iomap_read_folio_ctx *ctx);
>  void iomap_readahead(const struct iomap_ops *ops,
>  		struct iomap_read_folio_ctx *ctx);
> -- 
> 2.47.3
> 
> 

