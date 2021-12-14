Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F83A4746C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhLNPrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 10:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhLNPrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:47:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7770C061574;
        Tue, 14 Dec 2021 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JdGM5GreK4d7P/yIjP2xXXomBloxaPX0WunYOhiASqQ=; b=1t0q1phicf74iJb3TdVamaNu/E
        ALQjjbsbHzat42qdfFdXeZ8/krNQ0BKEUCaYu1OJOLwp7OA9GTUdELbLXQSQ/jJtjsl4X2RR8a+y5
        scFmoWCOdmhR8c68Q8SUn2SBN6bXa6zXbV6I/PGDnHRSsTIbd0KO4A37z0jlaZfULSAgQvfJ7aRRD
        mpBF/gREdBnS/qwnTfSZ0qxlgIekcml5LTnuQuH78MbLXzbqkCT7D4ptACW5q7e9kTn45M7zeqX0C
        yJLpJeTMnvoOWHbgvH3SwhQXVgmbwBtLr1jL+LKCmigz6pNmOkkSXLDPD5VbjK+7VhO+sl4RYZPxW
        VDpScrgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxA1R-00Ek1e-8E; Tue, 14 Dec 2021 15:47:21 +0000
Date:   Tue, 14 Dec 2021 07:47:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v8 6/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <Ybi8icn3W7vOEQV+@infradead.org>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
 <20211202084856.1285285-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202084856.1285285-7-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:48:53PM +0800, Shiyang Ruan wrote:
> @@ -254,6 +254,15 @@ static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
>  }
> +static inline unsigned long pgoff_address(pgoff_t pgoff,
> +		struct vm_area_struct *vma)

Empty lines between functions please.

Also this name is a bit generic for something in dax.h, but then again
it does not seem to be DAX-specific, so it might want to move into
a generic MM header with a proper name and kerneldoc comment.

I think a calling conventions that puts the vma before the pgoff would
seem a little more logical as well.

Last but not least such a move should be in a separate patch.

> +extern int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> +			     unsigned long count, int mf_flags);

No need for the extern here.

> -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> +static unsigned long dev_pagemap_mapping_shift(unsigned long address,
>  		struct vm_area_struct *vma)

Passing the vma first would seem more logical again.

> +	if (is_zone_device_page(p)) {
> +		/*
> +		 * Since page->mapping is no more used for fsdax, we should
> +		 * calculate the address in a fsdax way.
> +		 */

		/*
		 * Since page->mapping is not used for fsdax, we need
		 * calculate the address based on the vma.
		 */

> +static void collect_procs_fsdax(struct page *page, struct address_space *mapping,
> +		pgoff_t pgoff, struct list_head *to_kill)

Overly long line here.
