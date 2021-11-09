Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B844B152
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 17:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhKIQmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 11:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbhKIQml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:42:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2466C061764;
        Tue,  9 Nov 2021 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HrXSYw8rk4n+A4PZtzybK6DqKpPd/fbVLmvWcN7MKLY=; b=UHjJm/M0a6jysVzwv55hP5Uzm0
        iK1H669wXcWisFWKFSki4/Ys5QBVqbHMvV9j2k8nqyNM2wfyzFm1sVQxeLirA/z0jTWRoCPP0jO8M
        KmZIOk1hXTrQTzbFuA8PdQs0Os9FYtElATLiI7crSQ80+LzhHhQv8XqmgGw0RQQaGQLmPZXUDDU14
        5sJDCSUVxgsqpXXmdRzhqe/Vqbfa/OLUXDh9qrjUv4iVCt453PNSWAurV7//B1mbO0jcfcw+0EQr5
        5/kAikwmtzYqjPKAdTUG5Ach3mso5A+4FGI0aXzIHzmhmsCBmOlChE2ehNLtUdC6qiDBT4cI1zT4C
        evdBOVbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkUA5-002iSj-NZ; Tue, 09 Nov 2021 16:39:53 +0000
Date:   Tue, 9 Nov 2021 08:39:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] f2fs: provide a way to attach HIPRI for Direct IO
Message-ID: <YYqkWWZZsMW49/xu@infradead.org>
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109021336.3796538-1-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 06:13:36PM -0800, Jaegeuk Kim wrote:
> This patch adds a way to attach HIPRI by expanding the existing sysfs's
> data_io_flag. User can measure IO performance by enabling it.

NAK.  This flag should only be used when explicitly specified by
the submitter of the I/O.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 16 +++++++++-------
>  fs/f2fs/data.c                          |  2 ++
>  fs/f2fs/f2fs.h                          |  3 +++
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index b268e3e18b4a..ac52e1c6bcbc 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -369,13 +369,15 @@ Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
>  Description:	Give a way to attach REQ_META|FUA to data writes
>  		given temperature-based bits. Now the bits indicate:
>  
> -		+-------------------+-------------------+
> -		|      REQ_META     |      REQ_FUA      |
> -		+------+------+-----+------+------+-----+
> -		|    5 |    4 |   3 |    2 |    1 |   0 |
> -		+------+------+-----+------+------+-----+
> -		| Cold | Warm | Hot | Cold | Warm | Hot |
> -		+------+------+-----+------+------+-----+
> +		+------------+-------------------+-------------------+
> +		| HIPRI_DIO  |      REQ_META     |      REQ_FUA      |
> +		+------------+------+------+-----+------+------+-----+
> +		|          6 |    5 |    4 |   3 |    2 |    1 |   0 |
> +		+------------+------+------+-----+------+------+-----+
> +		|        All | Cold | Warm | Hot | Cold | Warm | Hot |
> +		+------------+------+------+-----+------+------+-----+
> +
> +		Note that, HIPRI_DIO bit is only for direct IO path.
>  
>  What:		/sys/fs/f2fs/<disk>/node_io_flag
>  Date:		June 2020
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9f754aaef558..faa40aca2848 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3707,6 +3707,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  		if (do_opu)
>  			down_read(&fi->i_gc_rwsem[READ]);
>  	}
> +	if (sbi->data_io_flag & HIPRI_DIO)
> +		iocb->ki_flags |= IOCB_HIPRI;
>  
>  	err = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
>  			iter, rw == WRITE ? get_data_block_dio_write :
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ce9fc9f13000..094f1e8ff82b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1557,6 +1557,9 @@ struct decompress_io_ctx {
>  #define MAX_COMPRESS_LOG_SIZE		8
>  #define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
>  
> +/* HIPRI for direct IO used in sysfs/data_io_flag */
> +#define HIPRI_DIO			(1 << 6)
> +
>  struct f2fs_sb_info {
>  	struct super_block *sb;			/* pointer to VFS super block */
>  	struct proc_dir_entry *s_proc;		/* proc entry */
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog
> 
---end quoted text---
