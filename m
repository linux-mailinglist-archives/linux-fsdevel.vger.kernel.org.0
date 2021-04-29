Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF20336EB2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhD2NK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 09:10:27 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39980 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237315AbhD2NKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:10:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UXAmpys_1619701762;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UXAmpys_1619701762)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 21:09:23 +0800
Subject: Re: [Ocfs2-devel] [PATCH 2/3] ocfs2: allow writing back pages out of
 inode size
To:     Junxiao Bi <junxiao.bi@oracle.com>, ocfs2-devel@oss.oracle.com,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        akpm <akpm@linux-foundation.org>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
 <20210426220552.45413-2-junxiao.bi@oracle.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <3e75d19c-7c9e-c86f-dddf-ae1062811655@linux.alibaba.com>
Date:   Thu, 29 Apr 2021 21:09:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210426220552.45413-2-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/21 6:05 AM, Junxiao Bi wrote:
> When fallocate/truncate extend inode size, if the original isize is in
> the middle of last cluster, then the part from isize to the end of the
> cluster needs to be zeroed with buffer write, at that time isize is not
> yet updated to match the new size, if writeback is kicked in, it will
> invoke ocfs2_writepage()->block_write_full_page() where the pages out
> of inode size will be dropped. That will cause file corruption.
> 
> Running the following command with qemu-image 4.2.1 can get a corrupted
> coverted image file easily.
> 
>     qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>              -O qcow2 -o compat=1.1 $qcow_image.conv
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/aops.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index ad20403b383f..7a3e3d59f6a9 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -402,11 +402,28 @@ static void ocfs2_readahead(struct readahead_control *rac)
>   */
>  static int ocfs2_writepage(struct page *page, struct writeback_control *wbc)
>  {
> +	struct inode * const inode = page->mapping->host;
> +	loff_t i_size = i_size_read(inode);
> +	const pgoff_t end_index = i_size >> PAGE_SHIFT;
> +	unsigned int offset;
> +
>  	trace_ocfs2_writepage(
>  		(unsigned long long)OCFS2_I(page->mapping->host)->ip_blkno,
>  		page->index);
>  
> -	return block_write_full_page(page, ocfs2_get_block, wbc);
> +	/*
> +	 * The page straddles i_size.  It must be zeroed out on each and every
> +	 * writepage invocation because it may be mmapped.  "A file is mapped
> +	 * in multiples of the page size.  For a file that is not a multiple of
> +	 * the  page size, the remaining memory is zeroed when mapped, and
> +	 * writes to that region are not written out to the file."
> +	 */
> +	offset = i_size & (PAGE_SIZE-1);
> +	if (page->index == end_index && offset)
> +		zero_user_segment(page, offset, PAGE_SIZE);
> +
> +	return __block_write_full_page_eof(inode, page, ocfs2_get_block, wbc,
> +			end_buffer_async_write, true);
>  }
>  
>  /* Taken from ext3. We don't necessarily need the full blown
> 
