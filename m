Return-Path: <linux-fsdevel+bounces-52149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAEFADFB64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 04:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619135A0538
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61A221FCB;
	Thu, 19 Jun 2025 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E403jCME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8F257D;
	Thu, 19 Jun 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301408; cv=none; b=fOfCHwtbED0ElAWY3s7rJVMX+4Lm0mROnxE/HUSfbAmF9uxGPikUyVLEDhMARiN2GyC2d2LVJocAFMj9YGUg1+p1KaRO/eJ/uJvrdDBMdv2q9CyeZuCIofUBy6NY9Tet55UvK3RV/AIsA3fR70AeodDgs58FMc4ObTw+ETCUZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301408; c=relaxed/simple;
	bh=idNXWrJ0i3YcXz4VA0qpiX6JhxQXk97j60sfqRiBDws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lq2/Z/Y8syMgaKCOwY66b3jJOUt4idAfFZ1XRLTEVe4afmk/tS+u6Dp03jzp/sCvH5m5V0cQA+8LtACjad/mmgOE3t0O+DkXa7vrLUGtoo+m7BzlpV4BxE8VYBkysG7MH9arFtKbYbQJYk4hpskKdzx1BZo+C1UI18tya7GEV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E403jCME; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8f7kpl9Yxe2EdTmPC6QhXiUO8Uwa6ytASfkfx0haMQs=; b=E403jCME+Ber1jDCjSgjhUCkrt
	dwq40BpJFB1tiy4dzogZapvXCLj9bafDNhYV3L04aNo8MRkn51a/8sOt7sI2bCChtoQ6NrdTAGT0B
	GGEQoVyy09AGaCu4UQY9sGI+bUJ9GDKw0HejsRZHmDc8M7sESYTvT4YJ28AkiWdDHmLcvjKdwRRBV
	54I6rsymJgG7vqrKiR9n+FcyG2ZEFNfA25F4/ZAXHjmMCrslleP4uZdr3qQFdiA/154TlxXYITclw
	WZ5lFGaR1foc7WTucMxi8t0DVMuRN2UnnkIgOFgJpJ0gYAK9A/dc24XTr0zht4cQj9jg4X1NkX0Ls
	s4o/xQLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS5Ll-00000006YUF-18nZ;
	Thu, 19 Jun 2025 02:50:01 +0000
Date: Thu, 19 Jun 2025 03:50:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Convert test_find_delalloc() to use a folio
Message-ID: <aFN62U-Fx4RZGj6Q@casper.infradead.org>
References: <20250613190705.3166969-1-willy@infradead.org>
 <20250613190705.3166969-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613190705.3166969-2-willy@infradead.org>

On Fri, Jun 13, 2025 at 08:07:00PM +0100, Matthew Wilcox (Oracle) wrote:
> @@ -201,17 +200,16 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>  	 *           |--- search ---|
>  	 */
>  	test_start = SZ_64M;
> -	locked_page = find_lock_page(inode->i_mapping,
> +	locked_folio = filemap_lock_folio(inode->i_mapping,
>  				     test_start >> PAGE_SHIFT);
> -	if (!locked_page) {
> -		test_err("couldn't find the locked page");
> +	if (!locked_folio) {
> +		test_err("couldn't find the locked folio");
>  		goto out_bits;
>  	}
>  	btrfs_set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
>  	start = test_start;
>  	end = start + PAGE_SIZE - 1;
> -	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
> -					 &end);
> +	found = find_lock_delalloc_range(inode, locked_folio, &start, &end);
>  	if (!found) {
>  		test_err("couldn't find delalloc in our range");
>  		goto out_bits;

Hm.  How much do you test the failure paths here?  It seems to me that
the 'locked_folio' is still locked at this point ...

> @@ -328,8 +323,8 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>  		dump_extent_io_tree(tmp);
>  	btrfs_clear_extent_bits(tmp, 0, total_dirty - 1, (unsigned)-1);
>  out:
> -	if (locked_page)
> -		put_page(locked_page);
> +	if (locked_folio)
> +		folio_put(locked_folio);

And here we put it without unlocking it, which should cause the page
allocator to squawk at you.


