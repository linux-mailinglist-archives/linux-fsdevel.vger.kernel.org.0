Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1D4A66C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 22:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiBAVEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 16:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiBAVEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:04:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA4C061714;
        Tue,  1 Feb 2022 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KkpyPZF9boWkW2C3+gaN7IFNLv6yOkPRKRtBS9SK16U=; b=ZNs211dcxa+SVltpBuL6iy9T/4
        CUXhbiS46KQ0D5YIcD1Lz3PnMwgkP56pFexGfL1tVvPrP0irHxJOt5MEDbRH/lGgpB4hVpC/GY+7g
        gy/pFuMz/TOxJHN67i/pZPgwmMSfiPbrUmo7tobxqr3QZ8CGfA7sS+Y9ZI0JfBhu5l0aL+i+iHnfs
        5VW6IaBsdRwsHpnN5fabQhpoHLB5nOaKSeVW/kogT7BY0iKOID7MpDdzGaAzbWOGSAGS3eVFIV/0g
        Cy2dvYYFqiVJyw4sWt5J0atMatSR95LG/M38OYJ1/bLw3z9nQ7iW+6kCewMpAgpIkQQJliER0oKj5
        +dN7KYwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nF0Jb-00D6Pa-6l; Tue, 01 Feb 2022 21:03:51 +0000
Date:   Tue, 1 Feb 2022 21:03:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 2/9] mm: factor helpers for memory_failure_dev_pagemap
Message-ID: <YfmgNyG3mfxD/3nS@casper.infradead.org>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
 <20220127124058.1172422-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127124058.1172422-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:40:51PM +0800, Shiyang Ruan wrote:
> +static int mf_generic_kill_procs(unsigned long long pfn, int flags,
> +		struct dev_pagemap *pgmap)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +	LIST_HEAD(to_kill);
> +	dax_entry_t cookie;
> +
> +	/*
> +	 * Prevent the inode from being freed while we are interrogating
> +	 * the address_space, typically this would be handled by
> +	 * lock_page(), but dax pages do not use the page lock. This
> +	 * also prevents changes to the mapping of this pfn until
> +	 * poison signaling is complete.
> +	 */
> +	cookie = dax_lock_page(page);
> +	if (!cookie)
> +		return -EBUSY;
> +
> +	if (hwpoison_filter(page))
> +		return 0;
> +
> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> +		/*
> +		 * TODO: Handle HMM pages which may need coordination
> +		 * with device-side memory.
> +		 */
> +		return -EBUSY;
> +	}
> +
> +	/*
> +	 * Use this flag as an indication that the dax page has been
> +	 * remapped UC to prevent speculative consumption of poison.
> +	 */
> +	SetPageHWPoison(page);
> +
> +	/*
> +	 * Unlike System-RAM there is no possibility to swap in a
> +	 * different physical page at a given virtual address, so all
> +	 * userspace consumption of ZONE_DEVICE memory necessitates
> +	 * SIGBUS (i.e. MF_MUST_KILL)
> +	 */
> +	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> +	collect_procs(page, &to_kill, true);
> +
> +	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
> +	dax_unlock_page(page, cookie);
> +	return 0;
> +}

There's an assumption here that fsdax only has order-0 pages.
pfn_to_page() is going to return the precise page for that pfn, but then
page->mapping and page->index are not valid for tail pages.

I'm currently trying to folio-ise memory-failure.c, and it is not
going well!  There are several places where it's hard to tell
what should happen.

