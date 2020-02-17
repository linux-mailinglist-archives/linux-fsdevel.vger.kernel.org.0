Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FB4161361
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgBQNan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:30:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgBQNan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U11A+++4LKK51+4tdSmvbusBvC9USfeT04f6UKr3pAE=; b=Y6quXZyQbtJGHAqQouPU/RR9fr
        pQtX4bvumSbjtm5YOIkW/pRMaKU2libxHzttIOHrS54dg/Coan3bHDoOF+inP1AulxTy5/w7X/Rx2
        DSyhT+xq98ZNuWP1+j0wIfM89xtTm9YgCm1wE8UXid3ZQFIRK6QqjtB9rhbxduG2hh3l6fFlYiFtd
        7fcIiVv68pn5+YP7LMH+ldRhkQRyhTrv2hEaBKgPS5qZVitXJkg0FclicZqDPPuiPr1zv/2y+rwKP
        YvCVp8HN1H+G4mwIT1UpYW1zsbQ+mC0I7b2Cw+LpfHDenYSYZ6yM/25dGOJ9XrLwk131QjCz4qCbp
        g8TUo6hA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gTz-0007JC-7K; Mon, 17 Feb 2020 13:30:43 +0000
Date:   Mon, 17 Feb 2020 05:30:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 1/6] dax: Define a helper dax_pgoff() which takes in
 dax_offset as argument
Message-ID: <20200217133043.GA20444@infradead.org>
References: <20200212170733.8092-1-vgoyal@redhat.com>
 <20200212170733.8092-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212170733.8092-2-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:07:28PM -0500, Vivek Goyal wrote:
> Create a new helper dax_pgoff() which will replace bdev_dax_pgoff(). Difference
> between two is that dax_pgoff() takes in "sector_t dax_offset" as an argument
> instead of "struct block_device".
> 
> dax_offset specifies any offset into dax device which should be added to
> sector while calculating pgoff.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/dax/super.c | 12 ++++++++++++
>  include/linux/dax.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0aa4b6bc5101..e9daa30e4250 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -56,6 +56,18 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  }
>  EXPORT_SYMBOL(bdev_dax_pgoff);
>  
> +int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t *pgoff)

Please add a kerneldoc document.  I can't really make sense of what
dax_offset and sector mean here and why they are passed separately.

> +{
> +	phys_addr_t phys_off = (dax_offset + sector) * 512;

							<< SECTOR_SHIFT;

> +
> +	if (pgoff)
> +		*pgoff = PHYS_PFN(phys_off);

What is the use case of not passing a pgoff argument?

> +	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL(dax_pgoff);

EXPORT_SYMBOL_GPL, please.
