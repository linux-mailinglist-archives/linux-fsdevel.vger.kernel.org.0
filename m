Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A283153823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBESaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:30:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBESaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ps5OmylYpbLa02TyE4cuWxYOR03LYsFUcTf4hNL0iGQ=; b=VznFrfNanQr9DZP2fRjS6RAE6P
        ywoYHK+leWqpfxekMZfHY0jES/tdrtJtLN31b/68JAZvOPWSK7A3Y//y8VnCTJjKTvt+pchcLVFK5
        saGYmEjNdhPQp1OWrZyySQmrDAIhCaqeZ/8a/ERhs2CuuMk6mthK41DLaITE8rd3TVdnCosJfynPE
        eXUXQkZWO6mqy108GM4h8ipF1HT4X/Bvo/l8fLTJ+Fv6++pRSy+9nl7o/1yYHq3ucWeVMTPk0QEG5
        S4cnIDStJFgiEzx8ZE3nX9rBd0tI7O1g3n6RztOeZbmsYE/PhZVV3H+3QurrGmEd4fC/q7rmRcRWF
        E11nwKcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izPRq-0001GT-Dv; Wed, 05 Feb 2020 18:30:50 +0000
Date:   Wed, 5 Feb 2020 10:30:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200205183050.GA26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-2-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	/*
> +	 * There are no users as of now. Once users are there, fix dm code
> +	 * to be able to split a long range across targets.
> +	 */

This comment confused me.  I think this wants to say something like:

	/*
	 * There are now callers that want to zero across a page boundary as of
	 * now.  Once there are users this check can be removed after the
	 * device mapper code has been updated to split ranges across targets.
	 */

> +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +				    unsigned int offset, size_t len)
> +{
> +	int rc = 0;
> +	phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;

Any reason not to pass a phys_addr_t in the calling convention for the
method and maybe also for dax_zero_page_range itself?

> +	sector_start = ALIGN(phys_pos, 512)/512;
> +	sector_end = ALIGN_DOWN(phys_pos + bytes, 512)/512;

Missing whitespaces.  Also this could use DIV_ROUND_UP and
DIV_ROUND_DOWN.

> +	if (sector_end > sector_start)
> +		nr_sectors = sector_end - sector_start;
> +
> +	if (nr_sectors &&
> +	    unlikely(is_bad_pmem(&pmem->bb, sector_start,
> +				 nr_sectors * 512)))
> +		bad_pmem = true;

How could nr_sectors be zero?

> +	write_pmem(pmem_addr, page, 0, bytes);
> +	if (unlikely(bad_pmem)) {
> +		/*
> +		 * Pass block aligned offset and length. That seems
> +		 * to work as of now. Other finer grained alignment
> +		 * cases can be addressed later if need be.
> +		 */
> +		rc = pmem_clear_poison(pmem, ALIGN(pmem_off, 512),
> +				       nr_sectors * 512);
> +		write_pmem(pmem_addr, page, 0, bytes);
> +	}

This code largerly duplicates the write side of pmem_do_bvec.  I
think it might make sense to split pmem_do_bvec into a read and a write
side as a prep patch, and then reuse the write side here.

> +int generic_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +				 unsigned int offset, size_t len);

This should probably go into a separare are of the header and have
comment about being a section for generic helpers for drivers.
