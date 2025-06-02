Return-Path: <linux-fsdevel+bounces-50283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1AACA8BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A441787E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 05:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C808187876;
	Mon,  2 Jun 2025 05:05:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6124178395;
	Mon,  2 Jun 2025 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840724; cv=none; b=m6y0pZBvvbLVvYn/NFN70v2ktWcHwwcuCh4Vdvze7+/1AniSpoHvfvB26gdXhFW+SIHZLfj81G6axMqrTt2txZav1wB+URZZpi1M9jPu2P3uerYqWlzxDPEUXlEh4AmkLVP4veIsH0Etb84DTRd2Ju1yQNGXj8MtKnuzM641VFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840724; c=relaxed/simple;
	bh=SC+82pEiDBl6jorf0k97JZ+mgWtiSYMMRAYbjPF1lnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsoUxJJnh0C3e1WH79tLflkqXtR5k9O39YWV542vT2TQD2sNEt2QNogXB12iUnMcTpFyq4QiFAiMfUD7S5uVwQ+1obUNHOpZYCiAdIzwiihUSut8RrBx/lgDGx+k6iKMslPc+rL0drEv/T6V6vtMmWIo0DnHVSykysNcHhiA8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C15F68CFE; Mon,  2 Jun 2025 07:05:14 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:05:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	willy@infradead.org, x86@kernel.org, linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
	gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de
Subject: Re: [RFC 3/3] block: use mm_huge_zero_folio in
 __blkdev_issue_zero_pages()
Message-ID: <20250602050514.GD21716@lst.de>
References: <20250527050452.817674-1-p.raghav@samsung.com> <20250527050452.817674-4-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527050452.817674-4-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 27, 2025 at 07:04:52AM +0200, Pankaj Raghav wrote:
> Noticed a 4% increase in performance on a commercial NVMe SSD which does
> not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
> gains might be bigger if the device supports bigger MDTS.

Impressive gain on the one hand - on the other hand what is the macro
workload that does a lot of zeroing on an SSD, because avoiding that
should yield even better result while reducing wear..

> +			unsigned int len, added = 0;
>  
> +			len = min_t(sector_t, folio_size(zero_folio),
> +				    nr_sects << SECTOR_SHIFT);
> +			if (bio_add_folio(bio, zero_folio, len, 0))
> +				added = len;
>  			if (added < len)
>  				break;
>  			nr_sects -= added >> SECTOR_SHIFT;

Unless I'm missing something the added variable can go away now, and
the code using it can simply use len.


