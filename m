Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75E136E9DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 13:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhD2L7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 07:59:17 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:25214 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhD2L7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:59:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UXA-IhL_1619697495;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UXA-IhL_1619697495)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 19:58:15 +0800
Subject: Re: [Ocfs2-devel] [PATCH 1/3] fs/buffer.c: add new api to allow eof
 writeback
To:     Junxiao Bi <junxiao.bi@oracle.com>, ocfs2-devel@oss.oracle.com,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        akpm <akpm@linux-foundation.org>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <248885ce-6729-dc21-4937-849eb0fe8a45@linux.alibaba.com>
Date:   Thu, 29 Apr 2021 19:58:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210426220552.45413-1-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/21 6:05 AM, Junxiao Bi wrote:
> When doing truncate/fallocate for some filesytem like ocfs2, it
> will zero some pages that are out of inode size and then later
> update the inode size, so it needs this api to writeback eof
> pages.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>


Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/buffer.c                 | 14 +++++++++++---
>  include/linux/buffer_head.h |  3 +++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 0cb7ffd4977c..802f0bacdbde 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1709,9 +1709,9 @@ static struct buffer_head *create_page_buffers(struct page *page, struct inode *
>   * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
>   * causes the writes to be flagged as synchronous writes.
>   */
> -int __block_write_full_page(struct inode *inode, struct page *page,
> +int __block_write_full_page_eof(struct inode *inode, struct page *page,
>  			get_block_t *get_block, struct writeback_control *wbc,
> -			bh_end_io_t *handler)
> +			bh_end_io_t *handler, bool eof_write)
>  {
>  	int err;
>  	sector_t block;
> @@ -1746,7 +1746,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>  	 * handle any aliases from the underlying blockdev's mapping.
>  	 */
>  	do {
> -		if (block > last_block) {
> +		if (block > last_block && !eof_write) {
>  			/*
>  			 * mapped buffers outside i_size will occur, because
>  			 * this page can be outside i_size when there is a
> @@ -1871,6 +1871,14 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>  	unlock_page(page);
>  	goto done;
>  }
> +EXPORT_SYMBOL(__block_write_full_page_eof);
> +
> +int __block_write_full_page(struct inode *inode, struct page *page,
> +			get_block_t *get_block, struct writeback_control *wbc,
> +			bh_end_io_t *handler)
> +{
> +	return __block_write_full_page_eof(inode, page, get_block, wbc, handler, false);
> +}
>  EXPORT_SYMBOL(__block_write_full_page);
>  
>  /*
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 6b47f94378c5..5da15a1ba15c 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -221,6 +221,9 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
>  int __block_write_full_page(struct inode *inode, struct page *page,
>  			get_block_t *get_block, struct writeback_control *wbc,
>  			bh_end_io_t *handler);
> +int __block_write_full_page_eof(struct inode *inode, struct page *page,
> +			get_block_t *get_block, struct writeback_control *wbc,
> +			bh_end_io_t *handler, bool eof_write);
>  int block_read_full_page(struct page*, get_block_t*);
>  int block_is_partially_uptodate(struct page *page, unsigned long from,
>  				unsigned long count);
> 
