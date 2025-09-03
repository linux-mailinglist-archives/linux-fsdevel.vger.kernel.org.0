Return-Path: <linux-fsdevel+bounces-60195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F406BB42903
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A31BA7D42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90D36208C;
	Wed,  3 Sep 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0W0XfEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9C2D63FC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925379; cv=none; b=TGUkmvFg4rqNYZABVeUKssDUYEVzbdkbXMYSDYU7DT0sB11j9s2Eg9NzNq7Wg0Om+Zt5WvPj6BBCYPdnCPDA/7n9O/d9NFuwqUwMj+uxDXnGCq8osstRWJc7mo+V7p/0tU6IJ5QHQpjqvggZHiGvdg9pviO6c6ziaWBosr1RKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925379; c=relaxed/simple;
	bh=yYu8m6DpqW/hMmg1nJ5iZg3mzuABlGM4cUAoKhJPH3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieJzZD6Aic/ovXwm3N38wwwKqDn8GTfLgLQ8ka5ceF+HrgvHUOZNDAeKlhBmCToZPi/JTF6VEc1QZs4FC2xgfAJKOfGH56Nk458yGMFdMzicvfW5AovpY1Rxz0on2FQvHLa+28ugnAylKZWtBIp9BgtIyUXC20eRkjwgrXhlyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0W0XfEP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756925376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlsHyD8qFclQgXEjGTKjDJD1rFu3mlPS6ILNfKfG5wA=;
	b=c0W0XfEPIZYF7iUhcfXr8FHRkL15zh3sbEIkMvraQeFcifNJddDbmQi3ie/HcGru1Qd45K
	fIaisyw1KJf+OrcSaxLPm7qkbz+nBRb5r5pYvggNXZJ2aonfu6Z50cA77L0gQrK92mDvUe
	9VnuEJqPzQuyUnukEN6mPeBS46qMs7Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-L0DAT_DfOwa0swGZDg2KjA-1; Wed,
 03 Sep 2025 14:49:35 -0400
X-MC-Unique: L0DAT_DfOwa0swGZDg2KjA-1
X-Mimecast-MFC-AGG-ID: L0DAT_DfOwa0swGZDg2KjA_1756925373
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E60219560B0;
	Wed,  3 Sep 2025 18:49:33 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C4901956056;
	Wed,  3 Sep 2025 18:49:30 +0000 (UTC)
Date: Wed, 3 Sep 2025 14:53:33 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org,
	jack@suse.cz, hch@infradead.org, djwong@kernel.org,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 10/12] iomap: refactor dirty bitmap iteration
Message-ID: <aLiOrcetNAvjvjtk@bfoster>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829233942.3607248-11-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Aug 29, 2025 at 04:39:40PM -0700, Joanne Koong wrote:
> Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
> iteration. This uses __ffs() internally and is more efficient for
> finding the next dirty or clean bit than manually iterating through the
> bitmap range testing every bit.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 67 ++++++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd827398afd2..dc1a1f371412 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -75,13 +75,42 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  		folio_mark_uptodate(folio);
>  }
>  
> -static inline bool ifs_block_is_dirty(struct folio *folio,
> -		struct iomap_folio_state *ifs, int block)
> +/**
> + * ifs_next_dirty_block - find the next dirty block in the folio
> + * @folio: The folio
> + * @start_blk: Block number to begin searching at
> + * @end_blk: Last block number (inclusive) to search
> + *
> + * If no dirty block is found, this will return end_blk + 1.
> + */
> +static unsigned ifs_next_dirty_block(struct folio *folio,
> +		unsigned start_blk, unsigned end_blk)
>  {
> +	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = folio->mapping->host;
> -	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int blks = i_blocks_per_folio(inode, folio);
> +
> +	return find_next_bit(ifs->state, blks + end_blk + 1,
> +		blks + start_blk) - blks;
> +}
> +
> +/**
> + * ifs_next_clean_block - find the next clean block in the folio
> + * @folio: The folio
> + * @start_blk: Block number to begin searching at
> + * @end_blk: Last block number (inclusive) to search
> + *
> + * If no clean block is found, this will return end_blk + 1.
> + */
> +static unsigned ifs_next_clean_block(struct folio *folio,
> +		unsigned start_blk, unsigned end_blk)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks = i_blocks_per_folio(inode, folio);
>  
> -	return test_bit(block + blks_per_folio, ifs->state);
> +	return find_next_zero_bit(ifs->state, blks + end_blk + 1,
> +		blks + start_blk) - blks;
>  }
>  
>  static unsigned ifs_find_dirty_range(struct folio *folio,
> @@ -92,18 +121,15 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
>  		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
>  	unsigned end_blk = min_not_zero(
>  		offset_in_folio(folio, range_end) >> inode->i_blkbits,
> -		i_blocks_per_folio(inode, folio));
> -	unsigned nblks = 1;
> +		i_blocks_per_folio(inode, folio)) - 1;
> +	unsigned nblks;
>  
> -	while (!ifs_block_is_dirty(folio, ifs, start_blk))
> -		if (++start_blk == end_blk)
> -			return 0;
> +	start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
> +	if (start_blk > end_blk)
> +		return 0;
>  
> -	while (start_blk + nblks < end_blk) {
> -		if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
> -			break;
> -		nblks++;
> -	}
> +	nblks = ifs_next_clean_block(folio, start_blk + 1, end_blk)
> +		- start_blk;

Not a critical problem since it looks like the helper bumps end_blk, but
something that stands out to me here as mildly annoying is that we check
for (start > end) just above, clearly implying that start == end is
possible, then go and pass start + 1 and end to the next call. It's not
clear to me if that's worth changing to make end exclusive, but may be
worth thinking about if you haven't already..

Brian

>  
>  	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
>  	return nblks << inode->i_blkbits;
> @@ -1077,7 +1103,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
>  		struct folio *folio, loff_t start_byte, loff_t end_byte,
>  		struct iomap *iomap, iomap_punch_t punch)
>  {
> -	unsigned int first_blk, last_blk, i;
> +	unsigned int first_blk, last_blk;
>  	loff_t last_byte;
>  	u8 blkbits = inode->i_blkbits;
>  	struct iomap_folio_state *ifs;
> @@ -1096,10 +1122,13 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
>  			folio_pos(folio) + folio_size(folio) - 1);
>  	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
>  	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
> -	for (i = first_blk; i <= last_blk; i++) {
> -		if (!ifs_block_is_dirty(folio, ifs, i))
> -			punch(inode, folio_pos(folio) + (i << blkbits),
> -				    1 << blkbits, iomap);
> +	while (first_blk <= last_blk) {
> +		first_blk = ifs_next_clean_block(folio, first_blk, last_blk);
> +		if (first_blk > last_blk)
> +			break;
> +		punch(inode, folio_pos(folio) + (first_blk << blkbits),
> +			1 << blkbits, iomap);
> +		first_blk++;
>  	}
>  }
>  
> -- 
> 2.47.3
> 
> 


