Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596524F576E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiDFH1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586059AbiDFGtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:49:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF14967CD;
        Tue,  5 Apr 2022 22:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kLa5oUSgaNFUARPCCRK3MtvUz9vPBIGfTXvIZgPjfRk=; b=g31RPnEWyQAdFvhv+AatEvE3d7
        ga7RtNK5QlYiWaMbDbFcU+ZDovzFUq0aoZtZpfPZmVud6GW0ZpB2efEr1RWdUdE4Jp0TjZ56qfiEL
        bsUCd8mi9gghBU3OUKpbq3014qPfC+3nFmTBoRXXYodMcLNPqAUtHag51c8sl/Z76gjwCUU4iJW4m
        HFOdqrY3AtKqkW2X+wBUTCigB0QBPvE9ns9rS6+dZx7nUxNrBoRTK0W0bTT+rGzgLMtELg5bl2Uxi
        lkKoaIjx61eO9ASb5252Baqhts+85B/Nodx78ihgu4QatcqgcsFQ0B+dc0V1NZRZPz3ILMOWTnEyl
        rQRTVDdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nby5G-003oBJ-1m; Wed, 06 Apr 2022 05:19:58 +0000
Date:   Tue, 5 Apr 2022 22:19:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Message-ID: <Yk0i/pODntZ7lbDo@infradead.org>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uA3+SxEy8RfCAOX5"
Content-Disposition: inline
In-Reply-To: <20220405194747.2386619-5-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uA3+SxEy8RfCAOX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 01:47:45PM -0600, Jane Chu wrote:
> Introduce DAX_RECOVERY flag to dax_direct_access(). The flag is
> not set by default in dax_direct_access() such that the helper
> does not translate a pmem range to kernel virtual address if the
> range contains uncorrectable errors.  When the flag is set,
> the helper ignores the UEs and return kernel virtual adderss so
> that the caller may get on with data recovery via write.
> 
> Also introduce a new dev_pagemap_ops .recovery_write function.
> The function is applicable to FSDAX device only. The device
> page backend driver provides .recovery_write function if the
> device has underlying mechanism to clear the uncorrectable
> errors on the fly.

I know Dan suggested it, but I still think dev_pagemap_ops is the very
wrong choice here.  It is about VM callbacks to ZONE_DEVICE owners
independent of what pagemap type they are.  .recovery_write on the
other hand is completely specific to the DAX write path and has no
MM interactions at all.

>  /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
>  __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> -		long nr_pages, void **kaddr, pfn_t *pfn)
> +		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
>  {
>  	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
> +	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
> +	unsigned int num = PFN_PHYS(nr_pages) >> SECTOR_SHIFT;
> +	struct badblocks *bb = &pmem->bb;
> +	sector_t first_bad;
> +	int num_bad;
> +	bool bad_in_range;
> +	long actual_nr;
> +
> +	if (!bb->count)
> +		bad_in_range = false;
> +	else
> +		bad_in_range = !!badblocks_check(bb, sector, num, &first_bad, &num_bad);
>  
> -	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
> -					PFN_PHYS(nr_pages))))
> +	if (bad_in_range && !(flags & DAX_RECOVERY))
>  		return -EIO;

The use of bad_in_range here seems a litle convoluted.  See the attached
patch on how I would structure the function to avoid the variable and
have the reocvery code in a self-contained chunk.

> -		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
> -				&kaddr, NULL);
> +		nrpg = PHYS_PFN(size);
> +		map_len = dax_direct_access(dax_dev, pgoff, nrpg, 0, &kaddr, NULL);

Overly long line here.

--uA3+SxEy8RfCAOX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b868a88a0d589..377e4d59aa90f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -272,42 +272,40 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	struct badblocks *bb = &pmem->bb;
 	sector_t first_bad;
 	int num_bad;
-	bool bad_in_range;
-	long actual_nr;
-
-	if (!bb->count)
-		bad_in_range = false;
-	else
-		bad_in_range = !!badblocks_check(bb, sector, num, &first_bad, &num_bad);
-
-	if (bad_in_range && !(flags & DAX_RECOVERY))
-		return -EIO;
 
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
 		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
 
-	if (!bad_in_range) {
+	if (bb->count &&
+	    badblocks_check(bb, sector, num, &first_bad, &num_bad)) {
+		long actual_nr;
+
+		if (!(flags & DAX_RECOVERY))
+			return -EIO;
 		/*
-		 * If badblock is present but not in the range, limit known good range
-		 * to the requested range.
+		 * Set the recovery stride to the kernel page size because the
+		 * underlying driver and firmware clear poison functions don't
+		 * appear to handle large chunk (such as
+		 * 2MiB) reliably.
 		 */
-		if (bb->count)
-			return nr_pages;
-		return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
+		actual_nr = PHYS_PFN(
+			PAGE_ALIGN((first_bad - sector) << SECTOR_SHIFT));
+		dev_dbg(pmem->bb.dev, "start sector(%llu), nr_pages(%ld), first_bad(%llu), actual_nr(%ld)\n",
+				sector, nr_pages, first_bad, actual_nr);
+		if (actual_nr)
+			return actual_nr;
+		return 1;
 	}
 
 	/*
-	 * In case poison is found in the given range and DAX_RECOVERY flag is set,
-	 * recovery stride is set to kernel page size because the underlying driver and
-	 * firmware clear poison functions don't appear to handle large chunk (such as
-	 * 2MiB) reliably.
+	 * If badblock is present but not in the range, limit known good range
+	 * to the requested range.
 	 */
-	actual_nr = PHYS_PFN(PAGE_ALIGN((first_bad - sector) << SECTOR_SHIFT));
-	dev_dbg(pmem->bb.dev, "start sector(%llu), nr_pages(%ld), first_bad(%llu), actual_nr(%ld)\n",
-			sector, nr_pages, first_bad, actual_nr);
-	return (actual_nr == 0) ? 1 : actual_nr;
+	if (bb->count)
+		return nr_pages;
+	return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
 }
 
 static const struct block_device_operations pmem_fops = {

--uA3+SxEy8RfCAOX5--
