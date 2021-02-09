Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E63149B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 08:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBIHtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 02:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBIHtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:49:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62DC06178A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 23:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7v/LXSCkJaQecTj466+HivjlsG5ba0k/dU73SoyjJLM=; b=VdTvV906S8cfRAkeIknqhQN3ni
        ZbIQo5nAxQ+z2ECnciE7j3MoWs9mYfRREgchNzcLv5g9JxHkD/xNaPzxvzAwMUh7CJZw5wmE3e27P
        d+a4gK5eSXSPZg7/j8PTljZ5bXTmas3UMsG8WaSsp+JOaI3ukIwitg8GO6xdj0SA/huuZSLlsVx1C
        B7WQbycrKI9kP+qcRikFmJB3vR/5S2dbsrIcALf7HMfAeyf2V1Vp3ZaRoHVtBA0QRejsMofhjcpD3
        JaOc4o9pi/KlOuIFFe/Bq+s1O+VePA5V14py1R0uIis27c/90jhgwAWGmVW3o6h+rLKldbLIf7pc4
        tAdCPI/w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9Nks-0077ge-JF; Tue, 09 Feb 2021 07:48:16 +0000
Date:   Tue, 9 Feb 2021 07:48:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] mm: use filemap_range_needs_writeback() for O_DIRECT
 reads
Message-ID: <20210209074814.GB1696555@infradead.org>
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209023008.76263-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209023008.76263-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:30:07PM -0700, Jens Axboe wrote:
> For the generic page cache read helper, use the better variant of checking
> for the need to call filemap_write_and_wait_range() when doing O_DIRECT
> reads. This avoids falling back to the slow path for IOCB_NOWAIT, if there
> are no pages to wait for (or write out).
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  mm/filemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6a58d50fbd31..c80acb80e8f7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2643,8 +2643,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  
>  		size = i_size_read(inode);
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
> -			if (filemap_range_has_page(mapping, iocb->ki_pos,
> -						   iocb->ki_pos + count - 1))
> +			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
> +							  iocb->ki_pos + count - 1))

Please avoid the overy long line, which is trivial to do by using the
normal two tab indent for the continuation.
