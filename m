Return-Path: <linux-fsdevel+bounces-17168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D338A8898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321251F26294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599E148835;
	Wed, 17 Apr 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cygt0x9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86E1422B9;
	Wed, 17 Apr 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370468; cv=none; b=UqUFvflO/3Hx8Np/w8w15r65AXjvfcVWmYsbwnOhgxi5snr4Wrrdqx1P9xZ7cb/dv1NAZDsw2e8hZLnzyfGj+R3r5UtCOtA/1+7uaZ7fPzMPecJnKsWFRuJvrjUvaSrvMAoJSKQsEutLvJca+Q7b9h8qEONApc0IPZoB/VH+te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370468; c=relaxed/simple;
	bh=oJHmBwancnmpq+7dNBJ8AHQD4Vg9FUd2fiFyKoboRfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG3m8VFN+pOovesY0dNAbAO+tf33f6qQSstFjDAOgfW+pnAFXroS7FVkt1LqeeeVFyKEJxG8dHZor6ZlX+dp9pvGCd3Iq54dBpoS0Kdz1EepmliDzhV/lJa8Ih4JhRs61Q5xyt2c5xiw8VHhSneZPgbrj0cE+i6A/fwa/FkBf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cygt0x9f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zLXbEHaPuRTXl8YXU9P1QgIbiqadkPO+DuLjekRXSPI=; b=cygt0x9fgIzCrMhVZMNKpXHHel
	7pCa+WLpZxMgmqPhQg58IxvWWGRDRTOaMbRJpHd5nCts5Zon3Vi2rLCq9xXzNDvZpOidlCo9EPac0
	N1k0Ipi3ls5TIEDhd/T4x8RCzsf/sazVkPSnQaHH3PbWJeYoVfTlYf719WSG4RUHNFcshWiMb2aSB
	L1ucvLHQb9CGuhREtnCKebK0TcM2HLw8lPf6Te1ktugbGikmTvcK6QxMaR+BXoAZXMR4xdk+/i/Ag
	W2l5A6dwEB1G6Z2o5Sqyw0DKXEX8U0zycA4o1b4vlObdJ1A05G4486c1BHjKdc5Loji6qh03j+p5/
	SeJLDaCA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx7vB-00000003GV2-1ZBN;
	Wed, 17 Apr 2024 16:14:05 +0000
Date: Wed, 17 Apr 2024 17:14:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 2/8] nilfs2: drop usage of page_index
Message-ID: <Zh_1TdrwJcBeALIG@casper.infradead.org>
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417160842.76665-3-ryncsn@gmail.com>

On Thu, Apr 18, 2024 at 12:08:36AM +0800, Kairui Song wrote:
> +++ b/fs/nilfs2/bmap.c
> @@ -453,8 +453,7 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
>  	struct buffer_head *pbh;
>  	__u64 key;
>  
> -	key = page_index(bh->b_page) << (PAGE_SHIFT -
> -					 bmap->b_inode->i_blkbits);
> +	key = bh->b_page->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);

I'd prefer this were

	key = bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);

(pages only have a ->index field for historical reasons; I'm trying to
get rid of it)


