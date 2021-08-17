Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907263EED19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhHQNKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 09:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhHQNKU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:10:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DA560F22;
        Tue, 17 Aug 2021 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629205787;
        bh=eAJNwq+LR0vGZWapzyEOlD/ux+bUrLIyd52HO8STYtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvx+YmPwu3IclVZ3FyBJ1vW8Cx4JY6xaozjlAH01HnNG0VX6LxT0DRr7zvHM+befh
         kOnw9shM9edP0OujVaUD0Xn0i6jy08Z8Abxo0s/bwVwGL5G2nt06PTLR5QwPctxLXy
         TlwQfCNYyyZ4TxF2m5PVOwsCTcP/x22DYBUTs7y8=
Date:   Tue, 17 Aug 2021 15:09:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SelvaKumar S <selvakuma.s1@samsung.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com
Subject: Re: [PATCH 4/7] block: Introduce a new ioctl for simple copy
Message-ID: <YRu1GG7SRMMcNyrZ@kroah.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b@epcas5p1.samsung.com>
 <20210817101423.12367-5-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817101423.12367-5-selvakuma.s1@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 03:44:20PM +0530, SelvaKumar S wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> to a destination in the device. COPY ioctl accepts a 'copy_range'
> structure that contains destination (in sectors), no of sources and
> pointer to the array of source ranges. Each source range is represented by
> 'range_entry' that contains start and length of source ranges (in sectors)
> 
> MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> 
> Example code, to issue BLKCOPY:
> /* Sample example to copy three source-ranges [0, 8] [16, 8] [32,8] to
>  * [64,24], on the same device */
> 
> int main(void)
> {
> 	int ret, fd;
> 	struct range_entry source_range[] = {{.src = 0, .len = 8},
> 		{.src = 16, .len = 8}, {.src = 32, .len = 8},};
> 	struct copy_range cr;
> 
> 	cr.dest = 64;
> 	cr.nr_range = 3;
> 	cr.range_list = (__u64)&source_range;
> 
> 	fd = open("/dev/nvme0n1", O_RDWR);
> 	if (fd < 0) return 1;
> 
> 	ret = ioctl(fd, BLKCOPY, &cr);
> 	if (ret < 0) printf("copy failure\n");
> 
> 	close(fd);
> 
> 	return ret;
> }
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  block/ioctl.c           | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  8 ++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index eb0491e90b9a..2af56d01e9fe 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -143,6 +143,37 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  				    GFP_KERNEL, flags);
>  }
>  
> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg)
> +{
> +	struct copy_range crange;
> +	struct range_entry *rlist;
> +	int ret;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> +		return -EFAULT;
> +
> +	rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
> +			GFP_KERNEL);
> +	if (!rlist)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(rlist, (void __user *)crange.range_list,
> +				sizeof(*rlist) * crange.nr_range)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	ret = blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, crange.dest,
> +			GFP_KERNEL, 0);
> +out:
> +	kfree(rlist);
> +	return ret;
> +}
> +
>  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
>  		unsigned long arg)
>  {
> @@ -468,6 +499,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  	case BLKSECDISCARD:
>  		return blk_ioctl_discard(bdev, mode, arg,
>  				BLKDEV_DISCARD_SECURE);
> +	case BLKCOPY:
> +		return blk_ioctl_copy(bdev, mode, arg);
>  	case BLKZEROOUT:
>  		return blk_ioctl_zeroout(bdev, mode, arg);
>  	case BLKGETDISKSEQ:
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 7a97b588d892..4183688ff398 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -76,6 +76,13 @@ struct range_entry {
>  	__u64 len;
>  };
>  
> +struct copy_range {
> +	__u64 dest;
> +	__u64 nr_range;
> +	__u64 range_list;
> +	__u64 rsvd;

If you have a "reserved" field, you HAVE to check that it is 0.  If not,
you can never use it in the future.

Also, you can spell it out, we have lots of vowels :)

thanks,

greg k-h
