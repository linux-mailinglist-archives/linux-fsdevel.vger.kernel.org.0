Return-Path: <linux-fsdevel+bounces-23416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE492C1BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4051F2317B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFFA1BF308;
	Tue,  9 Jul 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpytXus4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289119FA9C;
	Tue,  9 Jul 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543103; cv=none; b=XBEh8ExeCFgC3Et3/9kiJGh2DBc1vSIo9tl60qISrSsx4icrwCYHsgd0MtNKPOOrfG77c+z3QHrXxj52ZysZhSa0lD8B3qordk1xEyOb1KCw6v0SxqeCuWM5DDSaxttp53kx5bqTsKfsXNToYU+ssmUfJFk+CQ79NIKMNkWVBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543103; c=relaxed/simple;
	bh=akLVWA7pf4SRs2gLWJwI/mYO+UhiI591Xoaqs/UbXro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gaoxd27SlDsKAce9ou2bgxhSIyRILnTDB59tWSrI0GZVVwRU0ELDSILrwrKh/EAjK524pf+zQfQXWH8BuPrMyboUZFdHfjeFLnGY3yVYMtuI1PQ4qZcb7JkvWQnu/EwbuE+hIZ6qa2XD7vJKivEbUzjTnF0ulwvi2GJS6KAHwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WpytXus4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u4kPF+jVZYaqYv+3DJpB7H4K1qcZD5HFQiZJHlOGeGY=; b=WpytXus4/67LYHQxKyVq8IgmMj
	vwWPyhQhfVWQl5R2oXGMEWzXoGz7UdJZIxulJAGqCcXKPw1r/YJCy+y36vi8dKPYs7oDljCZ3ZfSc
	UvWnO8qpOKMhEO3WAlesMn1ai2HgM8hQCQ+zBGjIAwPm08pwsXsP8HI4vcDylx3MFCwsmBMVFA0b0
	q9el4xa9mBvtiTt0+g9qUPaNyP66OD09LVC+5bSOVufROy/PCMVzRNHYH4CpYWY+uXLxKc3yfQmFb
	uKJAIJ1NMAxISmUhq1IbkZMfagOzmD7KFAH7Og7GP1fnizOKJilzcIQA4J+D/qF7M2r0izlNS2UzP
	hBKtDr+A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRDr6-000000084d9-3wYB;
	Tue, 09 Jul 2024 16:38:16 +0000
Date: Tue, 9 Jul 2024 17:38:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, ryan.roberts@arm.com, djwong@kernel.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>,
	akpm@linux-foundation.org, chandan.babu@oracle.com
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <Zo1neJYABzuMEvTO@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <20240709162907.gsd5nf33teoss5ir@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709162907.gsd5nf33teoss5ir@quentin>

On Tue, Jul 09, 2024 at 04:29:07PM +0000, Pankaj Raghav (Samsung) wrote:
> +++ b/include/linux/pagemap.h
> @@ -394,13 +394,24 @@ static inline void mapping_set_folio_order_range(struct address_space *mapping,
>                                                  unsigned int min,
>                                                  unsigned int max)
>  {
> -       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +               VM_WARN_ONCE(1, 
> +       "THP needs to be enabled to support mapping folio order range");
>                 return;
> +       }

No.  Filesystems call mapping_set_folio_order_range() without it being
conditional on CONFIG_TRANSPARENT_HUGEPAGE.  Usually that takes the
form of an unconditional call to mapping_set_large_folios().


