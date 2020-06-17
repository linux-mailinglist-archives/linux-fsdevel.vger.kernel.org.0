Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E071FCDB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgFQMsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 08:48:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQMsp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:48:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9BF9AE89;
        Wed, 17 Jun 2020 12:48:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4168F1E128D; Wed, 17 Jun 2020 14:48:42 +0200 (CEST)
Date:   Wed, 17 Jun 2020 14:48:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ext4: mark filesystem error if failed to async
 write metadata
Message-ID: <20200617124842.GC29763@quack2.suse.cz>
References: <20200617115947.836221-1-yi.zhang@huawei.com>
 <20200617115947.836221-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617115947.836221-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-06-20 19:59:44, zhangyi (F) wrote:
> There is a risk of filesystem inconsistency if we failed to async write
> back metadata buffer in the background. Because of current buffer's end
> io procedure is handled by end_buffer_async_write() in the block layer,
> and it only clear the buffer's uptodate flag and mark the write_io_error
> flag, so ext4 cannot detect such failure immediately. In most cases of
> getting metadata buffer (e.g. ext4_read_inode_bitmap()), although the
> buffer's data is actually uptodate, it may still read data from disk
> because the buffer's uptodate flag has been cleared. Finally, it may
> lead to on-disk filesystem inconsistency if reading old data from the
> disk successfully and write them out again.
> 
> This patch propagate ext4 end buffer callback to the block layer which
> could detect metadata buffer's async error and invoke ext4 error handler
> immediately.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks for the patch. It looks good, just some language fixes below...

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 15b062efcff1..2f22476f41d2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1515,6 +1515,10 @@ struct ext4_sb_info {
>  	/* workqueue for reserved extent conversions (buffered io) */
>  	struct workqueue_struct *rsv_conversion_wq;
>  
> +	/* workqueue for handle metadata buffer async writeback error */
                         ^^ handling

> +	struct workqueue_struct *s_bdev_wb_err_wq;
> +	struct work_struct s_bdev_wb_err_work;
> +
>  	/* timer for periodic error stats printing */
>  	struct timer_list s_err_report;
>  
...
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index de6fe969f773..50aa8e26e38c 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -560,3 +560,50 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  		end_page_writeback(page);
>  	return ret;
>  }
> +
> +/*
> + * Handle error of async writeback metadata buffer, just mark the filesystem
> + * error to prevent potential further inconsistency.
> + */

This comment is probably unnecessary. The comment inside the function is
enough. So I'd just delete this one.

> +void ext4_end_buffer_async_write_error(struct work_struct *work)
> +{
> +	struct ext4_sb_info *sbi = container_of(work,
> +				struct ext4_sb_info, s_bdev_wb_err_work);
> +
> +	/*
> +	 * If we failed to async write back metadata buffer, there is a risk
> +	 * of filesystem inconsistency since we may read old metadata from the
> +	 * disk successfully and write them out again.
> +	 */
> +	ext4_error_err(sbi->s_sb, -EIO, "Error while async write back metadata buffer");
> +}
> +
> +static void ext4_end_buffer_async_write(struct buffer_head *bh, int uptodate)
> +{
> +	struct super_block *sb = bh->b_bdev->bd_super;
> +
> +	end_buffer_async_write(bh, uptodate);
> +
> +	if (!uptodate && sb && !sb_rdonly(sb)) {
> +		struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +		/* Handle error of async writeback metadata buffer */

Instead of this comment, which isn't very useful, I'd add a comment
explaining why we do it like this. So something like:

/*
 * This function is called from softirq handler and complete abort of a
 * filesystem requires taking sleeping locks and submitting IO. So postpone
 * the real work to a workqueue.
 */

> +		queue_work(sbi->s_bdev_wb_err_wq, &sbi->s_bdev_wb_err_work);
> +	}
> +}
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
