Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AA445911
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhKDR6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhKDR6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:58:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC9DC061714;
        Thu,  4 Nov 2021 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S8+GvGjJAqniHYjM2Wp5vjOitbiYfVXd5DEzzMgGQcs=; b=cl00Zy7gZSJ0I2s23pCGHt0Q6X
        Q8OT0LUd5SXoIe7fvuNwxZ+uR2NfFqjAr1lmqRjRY7MysVby4VZTVSub++9SMNi1mHMzSPsvTumjK
        fU4/TJZZ0aaOrVT0cuznAxYACaRH0wsXg84useAnwbW66Ut3sO+SzdI9uc1abVRpHzWnCz5iUodL8
        R+Jct1O4oQtdBIq3Es2RfNRKmwoA0aFBJaCvJKlSeyPKKba6vPk6u10I//qdSmC57tFPWyee9ZspH
        55psKuHOFabypdipvFDLwBxbjTuKFxruc/976HfLSlC0TIfzKMHCkmhEis0hsj0M802VPWZOPyuaa
        r08pc56w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migxH-009jE8-C7; Thu, 04 Nov 2021 17:55:15 +0000
Date:   Thu, 4 Nov 2021 10:55:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] libnvdimm/pmem: Provide pmem_dax_clear_poison for
 dax operation
Message-ID: <YYQegz3nPmbavQtK@infradead.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <20210914233132.3680546-5-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914233132.3680546-5-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:31:32PM -0600, Jane Chu wrote:
> +static int pmem_dax_clear_poison(struct dax_device *dax_dev, pgoff_t pgoff,
> +					size_t nr_pages)
> +{
> +	unsigned int len = PFN_PHYS(nr_pages);
> +	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> +	blk_status_t ret;
> +
> +	if (!is_bad_pmem(&pmem->bb, sector, len))
> +		return 0;
> +
> +	ret = pmem_clear_poison(pmem, pmem_off, len);
> +	return (ret == BLK_STS_OK) ? 0 : -EIO;

No need for the braces here (and I'd prefer a good old if anyway).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
