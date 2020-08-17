Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A5D246E78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgHQRbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 13:31:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388918AbgHQQ5d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:57:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2326AADE5;
        Mon, 17 Aug 2020 16:57:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD1611E12CB; Mon, 17 Aug 2020 18:57:31 +0200 (CEST)
Date:   Mon, 17 Aug 2020 18:57:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 01/20] dax: Modify bdev_dax_pgoff() to handle NULL bdev
Message-ID: <20200817165731.GB22500@quack2.suse.cz>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-2-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 07-08-20 15:55:07, Vivek Goyal wrote:
> virtiofs does not have a block device but it has dax device.
> Modify bdev_dax_pgoff() to be able to handle that.
> 
> If there is no bdev, that means dax offset is 0. (It can't be a partition
> block device starting at an offset in dax device).
> 
> This is little hackish. There have been discussions about getting rid
> of dax not supporting partitions.
> 
> https://lore.kernel.org/linux-fsdevel/20200107125159.GA15745@infradead.org/
> 
> IMHO, this path can easily break exisitng users. For example
> ioctl(BLKPG_ADD_PARTITION) will start breaking on block devices
> supporting DAX. Also, I personally find it very useful to be able to
> partition dax devices and still be able to use DAX.
> 
> Alternatively, I tried to store offset into dax device information in iomap
> interface, but that got NACKed.
> 
> https://lore.kernel.org/linux-fsdevel/20200217133117.GB20444@infradead.org/
> 
> I can't think of a good path to solve this issue properly. So to make
> progress, it seems this patch is least bad option for now and I hope
> we can take it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-nvdimm@lists.01.org

This patch looks OK to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/dax/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 8e32345be0f7..c4bec437e88b 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -46,7 +46,8 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
>  int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  		pgoff_t *pgoff)
>  {
> -	phys_addr_t phys_off = (get_start_sect(bdev) + sector) * 512;
> +	sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> +	phys_addr_t phys_off = (start_sect + sector) * 512;
>  
>  	if (pgoff)
>  		*pgoff = PHYS_PFN(phys_off);
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
