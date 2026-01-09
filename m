Return-Path: <linux-fsdevel+bounces-73092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6504ED0C2C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C27130392B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34E368276;
	Fri,  9 Jan 2026 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4YMfHZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73801A5B84;
	Fri,  9 Jan 2026 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989938; cv=none; b=rVhHSxiwT37V8fLYF1z1GT6iv87/zCWJ4/+q+20BdRLyd6jIYSez0ZeAaGz8YcrsYLCT4H5h1kz4JBu6qWXj6DNm7DMxsLPViDXt9qRQBJ24R86tCS+VHeq9BJQKmKKB2mol0eW4aEnD7rHL1ZQ5peqGSqkD6Jo6PbmNwvft8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989938; c=relaxed/simple;
	bh=rhpHZ+U6MmkUr8n/dR1N+JKAxJQq5W5tojia0OytzPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhQP6x38sKvK1SPJINZ49dwtxrY9AUFeyK0bFV3ow6VGBgKnrnDEuW0rpq/K4uGQOGe9gkjshBF/1gkqsOBG0REBF0iGZkOwcqHClzcXHOoMzxb2laBxtaVM4ZyDkaSz8sC1dXuKWq/qDLqmeElXyg6xIkgHB3MXHI27FAmOACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4YMfHZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254F7C4CEF1;
	Fri,  9 Jan 2026 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767989938;
	bh=rhpHZ+U6MmkUr8n/dR1N+JKAxJQq5W5tojia0OytzPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4YMfHZBJMZvMAYuLRy/0sLybq/QXKYd4p7GSbqVhUKgaqEkv93D3uGjCHBMuvUAi
	 bxQFaRebDENZWtmA3ZjaR//I/SaDDgnhpuXMz/0oSqsKa0RpNjxZyRiV7IF/tzt4Qm
	 ssRcQNygvXHGdNp0EjAFdINjdJ0Z8TAWiRogj6lnzuhkKhRxe8UdNNtzNsakvtQRti
	 g7VbsCAycwcMozDu+NZlBWtNOsk7++g/tQJk7wjIS7UYr/WnceZMzUkFQ2T9YcHln9
	 rNTyqsz31M7AU+6JYacUwYbME5+zn4SJUdLKZrsL6Gc0bIHgMJgJmata2+HPy+v/ss
	 Ewvot0DycFpTA==
Date: Fri, 9 Jan 2026 20:18:56 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: move blk-crypto-fallback to sit above the block layer v5
Message-ID: <20260109201856.GA2915893@google.com>
References: <20260109060813.2226714-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109060813.2226714-1-hch@lst.de>

On Fri, Jan 09, 2026 at 07:07:40AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> in the past we had various discussions that doing the blk-crypto fallback
> below the block layer causes all kinds of problems due to very late
> splitting and communicating up features.
> 
> This series turns that call chain upside down by requiring the caller to
> call into blk-crypto using a new submit_bio wrapper instead so that only
> hardware encryption bios are passed through the block layer as such.
> 
> While doings this I also noticed that the existing blk-crypto-fallback
> code does various unprotected memory allocations which this converts to
> mempools, or from loops of mempool allocations to the new safe batch
> mempool allocator.
> 
> There might be future avenues for optimization by using high order
> folio allocations that match the file systems preferred folio size,
> but for that'd probably want a batch folio allocator first, in addition
> to deferring it to avoid scope creep.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

> Jens and Eric: I guess despite the fscrypt patches, the block tree
> would probably be the best fit.  Or do we need a separate branch?

Please go ahead and take these through the block tree.  Thanks!

- Eric

