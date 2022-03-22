Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826A94E3B5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 10:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiCVJDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiCVJDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:03:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE1BE0F;
        Tue, 22 Mar 2022 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LtO7Gpa8ASYKqY1/CwdSfVaPTW3C+ci3qYUk5dRycGQ=; b=yAiokzCaLy/awcMQcpRXrqiDEr
        rqCdbpdl2Es5oSNKzpIVb/wnI1luKtmRXGg9ffOjP4DFsCyTiGlOv2Q1YoX6jPRYUey9D1UMxJS1i
        noIpsbSasVzmopVGv21VsYoBKqixj7eKTXKwF3LeRFoAJTaCT22a2hDXONsP4FOOR9rpeR8kFf3ZM
        FMwMiYzXBuxQ0Ig/zd2nBVLZz3mCjJVOV/Fo8I1Sq68vaMqRdjUsA33xa/DYUUf+WatbKTpg6ylvl
        94x+Xdb16f+LFzi6AJg5khLgub2Sz4MrrlMaY3eYm8BO4hIc7WbhNy1WFH95HL5kYwwJqyyoC0AB0
        Ka2e8mdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWaOa-00AVwe-GZ; Tue, 22 Mar 2022 09:01:40 +0000
Date:   Tue, 22 Mar 2022 02:01:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Message-ID: <YjmQdJdOWUr2IYIP@infradead.org>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-5-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319062833.3136528-5-jane.chu@oracle.com>
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

On Sat, Mar 19, 2022 at 12:28:31AM -0600, Jane Chu wrote:
> Introduce DAX_RECOVERY flag to dax_direct_access(). The flag is
> not set by default in dax_direct_access() such that the helper
> does not translate a pmem range to kernel virtual address if the
> range contains uncorrectable errors.  When the flag is set,
> the helper ignores the UEs and return kernel virtual adderss so
> that the caller may get on with data recovery via write.

This DAX_RECOVERY doesn't actually seem to be used anywhere here or
in the subsequent patches.  Did I miss something?

> Also introduce a new dev_pagemap_ops .recovery_write function.
> The function is applicable to FSDAX device only. The device
> page backend driver provides .recovery_write function if the
> device has underlying mechanism to clear the uncorrectable
> errors on the fly.

Why is this not in struct dax_operations?

>  
> +size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
> +		void *addr, size_t bytes, struct iov_iter *iter)
> +{
> +	struct dev_pagemap *pgmap = dax_dev->pgmap;
> +
> +	if (!pgmap || !pgmap->ops->recovery_write)
> +		return -EIO;
> +	return pgmap->ops->recovery_write(pgmap, pgoff, addr, bytes,
> +				(void *)iter);

No need to cast a type pointer to a void pointer.  But more importantly
losing the type information here and passing it as void seems very
wrong.

> +static size_t pmem_recovery_write(struct dev_pagemap *pgmap, pgoff_t pgoff,
> +		void *addr, size_t bytes, void *iter)
> +{
> +	struct pmem_device *pmem = pgmap->owner;
> +
> +	dev_warn(pmem->bb.dev, "%s: not yet implemented\n", __func__);
> +
> +	/* XXX more later */
> +	return 0;
> +}

This shuld not be added here - the core code can cope with a NULL
method just fine.

> +		recov = 0;
> +		flags = 0;
> +		nrpg = PHYS_PFN(size);

Please spell out the words.  The recovery flag can also be
a bool to make the code more readable.

> +		map_len = dax_direct_access(dax_dev, pgoff, nrpg, flags,
> +					&kaddr, NULL);
> +		if ((map_len == -EIO) && (iov_iter_rw(iter) == WRITE)) {

No need for the inner braces.

> +			flags |= DAX_RECOVERY;
> +			map_len = dax_direct_access(dax_dev, pgoff, nrpg,
> +						flags, &kaddr, NULL);

And noneed for the flags variable at all really.

>  			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
>  					map_len, iter);
>  		else
> @@ -1271,6 +1286,11 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		length -= xfer;
>  		done += xfer;
>  
> +		if (recov && (xfer == (ssize_t) -EIO)) {
> +			pr_warn("dax_recovery_write failed\n");
> +			ret = -EIO;
> +			break;

And no, we can't just use an unsigned variable to communicate a
negative error code.
