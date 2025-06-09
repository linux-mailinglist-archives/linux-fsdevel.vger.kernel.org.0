Return-Path: <linux-fsdevel+bounces-50976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A91AD1859
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F4E7A42B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86F280031;
	Mon,  9 Jun 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QaxT3ZLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7938DEC;
	Mon,  9 Jun 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749447142; cv=none; b=HPh3dw+2b6Ys7TyqETLPN5tSQzad51Vadaskr6UMfkpm1WEJF9tJhlS+vKaAJrwJw1Ojgg8q0pbFgdO+sp7Qo8tNDHVOmzv+sr3Xti4EGIdrPDohe7S/XH9qeaF22UtWbqpIGzI4zpPp3wCaJCvl/ZPCYAusLL3EwcfBAuwjxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749447142; c=relaxed/simple;
	bh=yiRwVAHSm7T3WpcW56K/RUAYsFLGCjjv7NTZekJU/uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b43ACTd2HLeu8dXIMKlYWjQQY8WAIabYrDtdoW9Dc7NvgXmvaMV+jzK4Wjn9r34A8fQmBVSepaW90qdeFLjVNkLM0kQvUdPwvmHrqcdSwdIwnMTZawvA+FvGBRAjPJcJ/GiMu3J4jWtvYORY/Arb+vhHNV+PaGdpMQldc4gl1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QaxT3ZLT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tudyN5Ef8ssqxd5U7eJL1wZMX3F3BrWh0oBOEfA+N6Y=; b=QaxT3ZLTfdc9JSE313TQaz7Jqb
	oQ6ZeeCS03lVq59Rht2Q5t4p/avWQwenubcir+OUtCAu1gywLM35LhWdc9KnwIwVrTv8S1B1TR9O0
	wMZV4d/g83fPyIF7SdGRn1uZgQK144Z3DVVTs4TqwDauEB4MUZ5MadjMnaTvjgzD7OkgForrf+JAW
	R6jxuqzLliSA807I24JeBQrPlI9hIYwYzXW07vvts97AjOZx5sXWcV5kNx4ufLsusApctZCgiU+hd
	4SXPrY/wmKabdC3Nb5w+POFyEUUfMyax0E2giY70MSVJ0HTO/Dq7NGZgaxy1LeN8ACJAc4lqxDV54
	fn9Dpyiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOV7M-00000003T6u-1MIe;
	Mon, 09 Jun 2025 05:32:20 +0000
Date: Sun, 8 Jun 2025 22:32:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM
 iomaps
Message-ID: <aEZx5FKK13v36wRv@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-5-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 06, 2025 at 04:37:59PM -0700, Joanne Koong wrote:
> This allows IOMAP_IN_MEM iomaps to use iomap_writepages() for handling
> writeback. This lets IOMAP_IN_MEM iomaps use some of the internal
> features in iomaps such as granular dirty tracking for large folios.
> 
> This introduces a new iomap_writeback_ops callback, writeback_folio(),
> callers may pass in which hands off folio writeback logic to the caller
> for writing back dirty pages instead of relying on mapping blocks.
> 
> This exposes two apis, iomap_start_folio_write() and
> iomap_finish_folio_write(), which callers may find useful in their
> writeback_folio() callback implementation.

It might also be worth stating what you don't use.  One big thing
that springs to mind is ioends.  Which are really useful if you
need more than one request to handle a folio, something that is
pretty common in network file systems.  I guess you don't need
that for fuse?

> +	if (wpc->iomap.type == IOMAP_IN_MEM) {
> +		if (wpc->ops->submit_ioend)
> +			error = wpc->ops->submit_ioend(wpc, error);
> +		return error;
> +	}

Given that the patch that moved things around already wrapped the
error propagation to the bio into a helpr, how does this differ
from the main path in the function now?

> +	/*
> +	 * If error is non-zero, it means that we have a situation where some part of
> +	 * the submission process has failed after we've marked pages for writeback.
> +	 * We cannot cancel ioend directly in that case, so call the bio end I/O handler
> +	 * with the error status here to run the normal I/O completion handler to clear
> +	 * the writeback bit and let the file system process the errors.
> +	 */

Please add the comment in a separate preparation patch.

> +		if (wpc->ops->writeback_folio) {
> +			WARN_ON_ONCE(wpc->ops->map_blocks);
> +			error = wpc->ops->writeback_folio(wpc, folio, inode,
> +							  offset_in_folio(folio, pos),
> +							  rlen);
> +		} else {
> +			WARN_ON_ONCE(wpc->iomap.type == IOMAP_IN_MEM);
> +			error = iomap_writepage_map_blocks(wpc, wbc, folio,
> +							   inode, pos, end_pos,
> +							   rlen, &count);
> +		}

So instead of having two entirely different methods, can we
refactor the block based code to also use
->writeback_folio?

Basically move all of the code inside the do { } while loop after
the call into ->map_blocks into a helper, and then let the caller
loop and also directly discard the folio if needed.  I can give that
a spin if you want.

Note that writeback_folio is misnamed, as it doesn't write back an
entire folio, but just a dirty range.

>  	} else {
> -		if (!count)
> +		/*
> +		 * If wpc->ops->writeback_folio is set, then it is responsible
> +		 * for ending the writeback itself.
> +		 */
> +		if (!count && !wpc->ops->writeback_folio)
>  			folio_end_writeback(folio);

This fails to explain why writeback_folio does the unlocking itself.
I also don't see how that would work in case of multiple dirty ranges.

>  	}
>  	mapping_set_error(inode->i_mapping, error);
> @@ -1693,3 +1713,25 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  	return iomap_submit_ioend(wpc, error);
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
> +
> +void iomap_start_folio_write(struct inode *inode, struct folio *folio, size_t len)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> +	if (ifs)
> +		atomic_add(len, &ifs->write_bytes_pending);
> +}
> +EXPORT_SYMBOL_GPL(iomap_start_folio_write);
> +
> +void iomap_finish_folio_write(struct inode *inode, struct folio *folio, size_t len)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> +	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
> +
> +	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
> +		folio_end_writeback(folio);

Please also use these helpers in the block based code.


