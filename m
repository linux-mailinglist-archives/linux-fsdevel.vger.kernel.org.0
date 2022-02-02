Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E684A71C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 14:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbiBBNny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 08:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiBBNnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:43:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E926C061714;
        Wed,  2 Feb 2022 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N6XNpq0FwsPZbJN5qSf1QDu//6lOqVafqdV/nNfMwPs=; b=P9ssVHu92H395D9dqlvAQrFmVu
        zKIl0C7d+Txpf8iBrIzXx/dzU+g5VJHkZwUxKJbZGY5U2XKYdyQUyUDMuWLOnolX+Z6pU5eQXPSK6
        InvGInZPS2GjMZ1G+YA7vRJ4RBc1XvocjEaZ9AqVN03zK304M7dY6pesian6URx3SQPbe3Tw/BC8I
        nuKX6723VVs1siOOtPIS7hpOEwZlKXO1WFqmm6MsOSXZvMBRbAiytZ7k+C/VPyXQO3MDDqS6Kkdk/
        XIVB5yi2oAhPk1Dhl6rhpm8c6bBF3hS27kmmdxwNG0+Rd1Qp7whtxegvQGan1C9Eo4W6AogSh3sKI
        9eEXGwAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFFvE-00FNjc-Ie; Wed, 02 Feb 2022 13:43:44 +0000
Date:   Wed, 2 Feb 2022 05:43:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 5/7] pmem: add pmem_recovery_write() dax op
Message-ID: <YfqKkEB3gBsiuMZt@infradead.org>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-6-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128213150.1333552-6-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -257,10 +263,15 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>  __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>  		long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> +	bool bad_pmem;
> +	bool do_recovery = false;
>  	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
>  
> -	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
> -					PFN_PHYS(nr_pages))))
> +	bad_pmem = is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
> +				PFN_PHYS(nr_pages));
> +	if (bad_pmem && kaddr)
> +		do_recovery = dax_recovery_started(pmem->dax_dev, kaddr);
> +	if (bad_pmem && !do_recovery)
>  		return -EIO;

I find the passing of the recovery flag through the address very
cumbersome.  I remember there was some kind of discussion, but this looks
pretty ugly.

Also no need for the bad_pmem variable:

	if (is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, PFN_PHYS(nr_pages)) &&
	    (!kaddr | !dax_recovery_started(pmem->dax_dev, kaddr)))
		return -EIO;

Also:  the !kaddr check could go into dax_recovery_started.  That way
even if we stick with the overloading kaddr could also be used just for
the flag if needed.
