Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681BD80F7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfHDXyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 19:54:09 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42312 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbfHDXyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 19:54:09 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 734053647B7;
        Mon,  5 Aug 2019 09:54:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1huQJ9-0004oa-AA; Mon, 05 Aug 2019 09:52:59 +1000
Date:   Mon, 5 Aug 2019 09:52:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/13] iomap: Read page from srcmap for IOMAP_COW
Message-ID: <20190804235259.GD7689@dread.disaster.area>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8 a=AMSWgMcbKuDIAMYta8YA:9
        a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:37PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> In case of a IOMAP_COW, read a page from the srcmap before
> performing a write on the page.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/buffered-io.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f27756c0b31c..a96cc26eec92 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -581,7 +581,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> -		struct page **pagep, struct iomap *iomap)
> +		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	pgoff_t index = pos >> PAGE_SHIFT;
> @@ -607,6 +607,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  
>  	if (iomap->type == IOMAP_INLINE)
>  		iomap_read_inline_data(inode, page, iomap);
> +	else if (iomap->type == IOMAP_COW)
> +		status = __iomap_write_begin(inode, pos, len, page, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
>  	else

This looks busted w.r.t. IOMAP_F_BUFFER_HEAD.  i.e. What's to stop
someone returning iomap->type == IOMAP_COW, iomap->flags &
IOMAP_F_BUFFER_HEAD?

In which case we can't call __iomap_write_begin(), right?

I'm with Darrick on CONFIG_IOMAP_DEBUG here - we need to start
locking down invalid behaviour and invalid combinations with asserts
that tell developers they've broken something.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
