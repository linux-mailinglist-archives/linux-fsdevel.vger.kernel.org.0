Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73C91B59EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDWLDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:45482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgDWLDu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:03:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C34D8B0AE;
        Thu, 23 Apr 2020 11:03:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD00A1E1293; Thu, 23 Apr 2020 13:03:47 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:03:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        Borislav Petkov <bp@alien8.de>, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] isofs: stop using ioctl_by_bdev
Message-ID: <20200423110347.GE3737@quack2.suse.cz>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423071224.500849-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-04-20 09:12:23, Christoph Hellwig wrote:
> Instead just call the CD-ROM layer functionality directly, and turn the
> hot mess in isofs_get_last_session into remotely readable code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One comment below...

> ---
>  fs/isofs/inode.c | 54 +++++++++++++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 62c0462dc89f..fc48923a9b6c 100644
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
> +			return -EINVAL;

There's no error handling in the caller and this function actually returns
unsigned int... So I believe you need to return 0 here to maintain previous
behavior (however suspicious it may be)?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
