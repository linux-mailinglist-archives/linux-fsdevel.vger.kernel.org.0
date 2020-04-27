Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FEC1BA067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 11:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgD0Jus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 05:50:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgD0Jus (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:50:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A11FABC2;
        Mon, 27 Apr 2020 09:50:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 64CBB1E129C; Mon, 27 Apr 2020 11:50:45 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:50:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        Borislav Petkov <bp@alien8.de>, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 6/7] isofs: stop using ioctl_by_bdev
Message-ID: <20200427095045.GA15107@quack2.suse.cz>
References: <20200425075706.721917-1-hch@lst.de>
 <20200425075706.721917-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425075706.721917-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 25-04-20 09:57:05, Christoph Hellwig wrote:
> Instead just call the CDROM layer functionality directly, and turn the
> hot mess in isofs_get_last_session into remotely readable code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/isofs/inode.c | 54 +++++++++++++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 62c0462dc89f3..276107cdaaf13 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -544,43 +544,41 @@ static int isofs_show_options(struct seq_file *m, struct dentry *root)
>  
>  static unsigned int isofs_get_last_session(struct super_block *sb, s32 session)
>  {
> -	struct cdrom_multisession ms_info;
> -	unsigned int vol_desc_start;
> -	struct block_device *bdev = sb->s_bdev;
> -	int i;
> +	struct cdrom_device_info *cdi = disk_to_cdi(sb->s_bdev->bd_disk);
> +	unsigned int vol_desc_start = 0;
>  
> -	vol_desc_start=0;
> -	ms_info.addr_format=CDROM_LBA;
>  	if (session > 0) {
> -		struct cdrom_tocentry Te;
> -		Te.cdte_track=session;
> -		Te.cdte_format=CDROM_LBA;
> -		i = ioctl_by_bdev(bdev, CDROMREADTOCENTRY, (unsigned long) &Te);
> -		if (!i) {
> +		struct cdrom_tocentry te;
> +
> +		if (!cdi)
> +			return 0;
> +
> +		te.cdte_track = session;
> +		te.cdte_format = CDROM_LBA;
> +		if (cdrom_read_tocentry(cdi, &te) == 0) {
>  			printk(KERN_DEBUG "ISOFS: Session %d start %d type %d\n",
> -				session, Te.cdte_addr.lba,
> -				Te.cdte_ctrl&CDROM_DATA_TRACK);
> -			if ((Te.cdte_ctrl&CDROM_DATA_TRACK) == 4)
> -				return Te.cdte_addr.lba;
> +				session, te.cdte_addr.lba,
> +				te.cdte_ctrl & CDROM_DATA_TRACK);
> +			if ((te.cdte_ctrl & CDROM_DATA_TRACK) == 4)
> +				return te.cdte_addr.lba;
>  		}
>  
>  		printk(KERN_ERR "ISOFS: Invalid session number or type of track\n");
>  	}
> -	i = ioctl_by_bdev(bdev, CDROMMULTISESSION, (unsigned long) &ms_info);
> -	if (session > 0)
> -		printk(KERN_ERR "ISOFS: Invalid session number\n");
> -#if 0
> -	printk(KERN_DEBUG "isofs.inode: CDROMMULTISESSION: rc=%d\n",i);
> -	if (i==0) {
> -		printk(KERN_DEBUG "isofs.inode: XA disk: %s\n",ms_info.xa_flag?"yes":"no");
> -		printk(KERN_DEBUG "isofs.inode: vol_desc_start = %d\n", ms_info.addr.lba);
> -	}
> -#endif
> -	if (i==0)
> +
> +	if (cdi) {
> +		struct cdrom_multisession ms_info;
> +
> +		ms_info.addr_format = CDROM_LBA;
> +		if (cdrom_multisession(cdi, &ms_info) == 0) {
>  #if WE_OBEY_THE_WRITTEN_STANDARDS
> -		if (ms_info.xa_flag) /* necessary for a valid ms_info.addr */
> +			/* necessary for a valid ms_info.addr */
> +			if (ms_info.xa_flag)
>  #endif
> -			vol_desc_start=ms_info.addr.lba;
> +				vol_desc_start = ms_info.addr.lba;
> +		}
> +	}
> +
>  	return vol_desc_start;
>  }
>  
> -- 
> 2.26.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
