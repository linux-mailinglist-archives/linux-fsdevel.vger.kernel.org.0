Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96600250CCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 02:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgHYAMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 20:12:30 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:34433 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgHYAM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:12:29 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 9335D1091CA;
        Tue, 25 Aug 2020 10:12:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kAMZb-0005kb-4O; Tue, 25 Aug 2020 10:12:23 +1000
Date:   Tue, 25 Aug 2020 10:12:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iomap: Convert iomap_write_end types
Message-ID: <20200825001223.GH12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-9-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=Jc2B04GcgJ8hC2UcC2sA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:55:09PM +0100, Matthew Wilcox (Oracle) wrote:
> iomap_write_end cannot return an error, so switch it to return
> size_t instead of int and remove the error checking from the callers.
> Also convert the arguments to size_t from unsigned int, in case anyone
> ever wants to support a page size larger than 2GB.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8c6187a6f34e..7f618ab4b11e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -666,9 +666,8 @@ iomap_set_page_dirty(struct page *page)
>  }
>  EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
>  
> -static int
> -__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> -		unsigned copied, struct page *page)
> +static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> +		size_t copied, struct page *page)
>  {

Please leave the function declarations formatted the same way as
they currently are. They are done that way intentionally so it is
easy to grep for function definitions. Not to mention is't much
easier to read than when the function name is commingled into the
multiline paramener list like...

> -static int
> -iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
> -		struct page *page, struct iomap *iomap, struct iomap *srcmap)
> +/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> +static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> +		size_t copied, struct page *page, struct iomap *iomap,
> +		struct iomap *srcmap)

... this.

Otherwise the code looks fine.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
