Return-Path: <linux-fsdevel+bounces-54909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685DB050AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 07:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3928A4E119C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFDB2D322F;
	Tue, 15 Jul 2025 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyq/nPRD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869D2D1925;
	Tue, 15 Jul 2025 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556478; cv=none; b=ifvKFJr8u1y0fqGDunCUc/lBsEQRdcaY413rFNTusLEasjlH+XUmxeC8wHlDNkZRwV/iU++eWSX5ByN3UVxtjjmeOyFu3Vdt7YXyVZTmTPCf14IZFaKGP6UjpBYbuwYIih1YfafcnoqZJeGUBoYws0Fv+wrHh2xQXGdaY0JrxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556478; c=relaxed/simple;
	bh=h2X1TkpXtIdnrt/ph0/EuZP8g9aNItNrhlGKSgwtUqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0FELjY0GKK9Ze6f7EPjCAzYgUCNKq+EbDVeXsmVOmiAwPRCFK9bvASWdSwRQLhGOMfJOHC9m0H0VYKpnKz6DxlH1nsqZBZkCyBxAegnvyAADx5QlgYAV5RNTzzf+LxoXOVb0r4LleIqavxP3vf1I8FyVW2XnNrV+0+EijElbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyq/nPRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085A9C4CEE3;
	Tue, 15 Jul 2025 05:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752556476;
	bh=h2X1TkpXtIdnrt/ph0/EuZP8g9aNItNrhlGKSgwtUqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyq/nPRDEbopPISGr/hXs1gGTURraTsM8XNBcR9s21YeOCjvFaxcYzjDdkCl7WmT5
	 PV1Jgg7HPuc7W1H7q07MvMyJO8pYgMvGjl8hX7yoPk2Y6ch4xSmSjjvvb2yQQZiOQV
	 VGODeuQ+aoP/rHcyk+RbsTV00SX1ujaT2LpVKoiKS4J5+N98pUIdxZhQkLO5IhtfjW
	 vjihgVJG8lNuokuiqU8fOi5IRozNuUOBPKEeaZOsaEC47pIqzmaNped5Ks73MALVlo
	 qvycxDwhLpRGNQE3lBSb/sqbfgwc9UFBa+XybZRD2pU5b3UUsWzU+VrH7r0MClTcpe
	 /jD6r5wxo/a4g==
Date: Mon, 14 Jul 2025 22:14:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 2/7] iomap: remove pos+len BUG_ON() to after folio
 lookup
Message-ID: <20250715051435.GM2672049@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714204122.349582-3-bfoster@redhat.com>

On Mon, Jul 14, 2025 at 04:41:17PM -0400, Brian Foster wrote:
> The bug checks at the top of iomap_write_begin() assume the pos/len
> reflect exactly the next range to process. This may no longer be the
> case once the get folio path is able to process a folio batch from
> the filesystem. On top of that, len is already trimmed to within the
> iomap/srcmap by iomap_length(), so these checks aren't terribly
> useful. Remove the unnecessary BUG_ON() checks.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Heh, glad this went away
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..38da2fa6e6b0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -805,15 +805,12 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	loff_t pos = iter->pos;
> +	loff_t pos;
>  	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
>  	struct folio *folio;
>  	int status = 0;
>  
>  	len = min_not_zero(len, *plen);
> -	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> -	if (srcmap != &iter->iomap)
> -		BUG_ON(pos + len > srcmap->offset + srcmap->length);
>  
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> -- 
> 2.50.0
> 
> 

