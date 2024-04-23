Return-Path: <linux-fsdevel+bounces-17567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFCE8AFC55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419AC28531B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A32E859;
	Tue, 23 Apr 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NfHZ0wWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB62E62F;
	Tue, 23 Apr 2024 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913149; cv=none; b=eZ7qG0g0vMxcXhM+d59m3bEfVIYEnec6UGCoRSbzXDUVZDXY6mPh1RdgES8PKq/YXvz5HdMi0o9oz9lR0wweYz4nyOoaVBRt6NUe1bmxGohG1R8c+AKLTN4hSozgEcpPyWJYJp+QLAl/n6QtRxoNLorO8tsQM55MYB8Hu7KhpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913149; c=relaxed/simple;
	bh=s8o3DPkfp3k+tdnCglc/unIS8LkRb0yjxyWkklbBA6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX44DmB/BavFgMRrcoOycUF4kuYMZ/eaTrfe11vs4RynxGkA8qWyLy/i0vnhUKKcQO/2ml0oFxfUQThpqfJ8qvgVMgFciY/hoqcYKEHgstZSP2ZDmWyrnhIW7AV4OSr9r+dAeq/juFpXE5snpsxILOqWpDBnLrA5G2jLlg4/3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NfHZ0wWx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vs2mxITFBV+nRdHIV1uS98AGVTfpM4tELm97x05ajm0=; b=NfHZ0wWx8GsndEQHkBQc5Ztki1
	+thI/9cbCmFDfsBKQdJhpY9sdYrV/3LG4b9EaxZ0lQ9V30/cPkhT3QlooLztHyMRN0CXpRp3xNP46
	x4cp4efIgNLFzO5QRLE3Q5J1Axh70ssti9HIPvCLDgDRJ6ZlOZMOIeD7MQdzG43fH26hzdZ6DeMnX
	iYYsZmvc+gaKlIlop7wT1ysPbtC6FwsO+/CDxp8D60K0LK8ef7xSNgaJzqYS8rfLG8Gwak/hUZuRt
	YFxaII764S2palC6DlSP+PhM5yULs8nvv0FSPVcWpRz6TmGmlLPH7/umzcJ+2ccIKSYRnRP2pgL4x
	qDIkZ1SQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP64-0000000HGFU-0pot;
	Tue, 23 Apr 2024 22:58:44 +0000
Date: Tue, 23 Apr 2024 23:58:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 3/8] f2fs: drop usage of page_index
Message-ID: <Zig9JCrhky9JieRS@casper.infradead.org>
References: <20240423170339.54131-1-ryncsn@gmail.com>
 <20240423170339.54131-4-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423170339.54131-4-ryncsn@gmail.com>

On Wed, Apr 24, 2024 at 01:03:34AM +0800, Kairui Song wrote:
> @@ -4086,8 +4086,7 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
>  	unsigned long flags;
>  
>  	xa_lock_irqsave(&mapping->i_pages, flags);
> -	__xa_clear_mark(&mapping->i_pages, page_index(page),
> -						PAGECACHE_TAG_DIRTY);
> +	__xa_clear_mark(&mapping->i_pages, page->index, PAGECACHE_TAG_DIRTY);
>  	xa_unlock_irqrestore(&mapping->i_pages, flags);
>  }

I just sent a patch which is going to conflict with this:

https://lore.kernel.org/linux-mm/20240423225552.4113447-3-willy@infradead.org/

Chao Yu, Jaegeuk Kim; what are your plans for converting f2fs to use
folios?  This is getting quite urgent.

