Return-Path: <linux-fsdevel+bounces-18410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 994B58B861B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 09:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F051F22207
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F84D9FD;
	Wed,  1 May 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2QYKSUeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DE4D131;
	Wed,  1 May 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548796; cv=none; b=Q0dK+jyx6uVP54x7kAGePKbmnOJZoL5Hw5mGbNGpgtW7CIDIb71ela8KPRZEnz3M+GNxJJ/7k7WOMJH/n4ZduMI5gzTUIGdP1K5Y/giGqC/Z23XQn2HpbJnAVXCp2FpLOZOaoisrnq4t2+6SmFIbKZRQcH0OcLzNpevuIJKhw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548796; c=relaxed/simple;
	bh=gR4PCz6WbT4gck1xTDqrFInEQmtC/aDTcltBhWZCPN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvmO2mzMDtM7yCvUCyq4IIu7byc9V1a8wwhRqhdJmO2PLK3lXc94P+kL5lNZs7SVYqWkcDi3YHIMNu2TWuVtHkCt4frvSm4gGl9gmG7iZz/hWsy5tlCyKIfSXie3+mMY19NeXKAJanrqb+/02QIX08QBnmOQjHe3MY2fL5Ev9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2QYKSUeb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hGkkzPEPn1jJpcNUcl0RN93WreFSVMaG5I+i+Dg1yuw=; b=2QYKSUebCPh8lo4QHX+65QaN9F
	UZJGpS0Ik1dXnizXUPGYmhzP5xIpwg5kw88yM1ThWxwnnyx+LzAeUecjvY7+nTr1y/eiElEw1PZUL
	wPe/56CJhLqovh4qcW/wJxMpbpnozgYaMTCx6cW78WArFhuyxhIQOm4reZ3AbAkavkLDpwS0bZ0hc
	Im5DSUti1EDxgeuVgQBFVoGgzbQduXpMbY0iZq/Ig8pHsxAgxKHbc+6OargAdytcV032PWFfgGMN2
	PQ1p48lFQArz1pZZ5ATWx3xAgmRrfgVMBDwDPWX7yR9PL3ZoCamgJht0G6vx/hqioKxPNZLMSuKn/
	I/fdhkGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24So-00000008kuN-2q8q;
	Wed, 01 May 2024 07:33:14 +0000
Date: Wed, 1 May 2024 00:33:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/18] fsverity: convert verification to use byte instead
 of page offsets
Message-ID: <ZjHwOm-BeLtY25wc@infradead.org>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679642.955480.14668034329027994356.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444679642.955480.14668034329027994356.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
> +	struct backing_dev_info *bdi = inode->i_sb->s_bdi;
> +	const u64 max_ra_bytes = min((u64)bdi->io_pages << PAGE_SHIFT,
> +				     ULONG_MAX);
> +	const struct merkle_tree_params *params = &vi->tree_params;

bdi->io_pages is really a VM readahead concept.  I know this is existing
code, but can we rething why this is even used here?

> +	unsigned int offs_in_block = pos & (params->block_size - 1);
>  	int retval = 0;
>  	int err = 0;
>  
> +	 * Iterate through each Merkle tree block in the requested range and
> +	 * copy the requested portion to userspace. Note that we are returning
> +	 * a byte stream.
>  	 */
> +	while (pos < end_pos) {
> +		unsigned long ra_bytes;
> +		unsigned int bytes_to_copy;
> +		struct fsverity_blockbuf block = { };
>  
> +		ra_bytes = min_t(unsigned long, end_pos - pos, max_ra_bytes);
> +		bytes_to_copy = min_t(u64, end_pos - pos,
> +				      params->block_size - offs_in_block);
> +
> +		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
> +						      pos - offs_in_block,
> +						      ra_bytes, &block);

Maybe it's just me, but isn't passing a byte offset to a read...block
routine a bit weird and this should operate on the block number instead?

> +		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {

And the returned/passed value should be a kernel pointer to the start
of the in-memory copy of the block?
to 

> +static bool is_hash_block_verified(struct inode *inode,
> +				   struct fsverity_blockbuf *block,
>  				   unsigned long hblock_idx)

Other fsverify code seems to use the (IMHO) much more readable
two-tab indentation for prototype continuations, maybe stick to that?

>
>  {
> +	struct fsverity_info *vi = inode->i_verity_info;
> +	struct page *hpage = (struct page *)block->context;

block->context is a void pointer, no need for casting it.

> +	for (; level > 0; level--)
> +		fsverity_drop_merkle_tree_block(inode, &hblocks[level - 1].block);

Overlh long line here.  But the loop kinda looks odd anyway with the
exta one off in the body instead of the loop.


