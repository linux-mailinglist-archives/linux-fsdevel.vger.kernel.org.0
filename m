Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56FA1B59FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgDWLFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgDWLFy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:05:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF96BB08C;
        Thu, 23 Apr 2020 11:05:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F2BF91E1293; Thu, 23 Apr 2020 13:05:51 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:05:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        Borislav Petkov <bp@alien8.de>, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] udf: stop using ioctl_by_bdev
Message-ID: <20200423110551.GF3737@quack2.suse.cz>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423071224.500849-8-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-04-20 09:12:24, Christoph Hellwig wrote:
> Instead just call the CD-ROM layer functionality directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/lowlevel.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
> index 5c7ec121990d..f1094cdcd6cd 100644
> --- a/fs/udf/lowlevel.c
> +++ b/fs/udf/lowlevel.c
> @@ -27,41 +27,38 @@
>  
>  unsigned int udf_get_last_session(struct super_block *sb)
>  {
> +	struct cdrom_device_info *cdi = disk_to_cdi(sb->s_bdev->bd_disk);
>  	struct cdrom_multisession ms_info;
> -	unsigned int vol_desc_start;
> -	struct block_device *bdev = sb->s_bdev;
> -	int i;
>  
> -	vol_desc_start = 0;
> -	ms_info.addr_format = CDROM_LBA;
> -	i = ioctl_by_bdev(bdev, CDROMMULTISESSION, (unsigned long)&ms_info);
> +	if (!cdi) {
> +		udf_debug("CDROMMULTISESSION not supported.\n");
> +		return 0;
> +	}
>  
> -	if (i == 0) {
> +	ms_info.addr_format = CDROM_LBA;
> +	if (cdrom_multisession(cdi, &ms_info) == 0) {
>  		udf_debug("XA disk: %s, vol_desc_start=%d\n",
>  			  ms_info.xa_flag ? "yes" : "no", ms_info.addr.lba);
>  		if (ms_info.xa_flag) /* necessary for a valid ms_info.addr */
> -			vol_desc_start = ms_info.addr.lba;
> -	} else {
> -		udf_debug("CDROMMULTISESSION not supported: rc=%d\n", i);
> +			return ms_info.addr.lba;
>  	}
> -	return vol_desc_start;
> +	return 0;
>  }
>  
>  unsigned long udf_get_last_block(struct super_block *sb)
>  {
>  	struct block_device *bdev = sb->s_bdev;
> +	struct cdrom_device_info *cdi = disk_to_cdi(bdev->bd_disk);
>  	unsigned long lblock = 0;
>  
>  	/*
> -	 * ioctl failed or returned obviously bogus value?
> +	 * The cdrom layer call failed or returned obviously bogus value?
>  	 * Try using the device size...
>  	 */
> -	if (ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long) &lblock) ||
> -	    lblock == 0)
> +	if (!cdi || cdrom_get_last_written(cdi, &lblock) || lblock == 0)
>  		lblock = i_size_read(bdev->bd_inode) >> sb->s_blocksize_bits;
>  
>  	if (lblock)
>  		return lblock - 1;
> -	else
> -		return 0;
> +	return 0;
>  }
> -- 
> 2.26.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
