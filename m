Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E574A3EAC61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhHLV0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhHLV0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:26:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE6C061756;
        Thu, 12 Aug 2021 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IaxypzM/Vd450pfEGpkrf9PDYM68Z4Ke2vXmaf+5usc=; b=bBdMGgY0e395Pv6868WWSWwx1w
        UhvtZIeN6lIkZJlSfHuaOVvuJtwbmiqCG2gdHG+A64njOfxRkQijGLcH28jQ4Oqxar3V8wGtcoPdD
        OUHoh1P0NfrvIUp/OilxQEWgtRabRDfM1gHd3G8xpygLnkxr9jyOmgS91wnFsMPV0i9D38g2IWQok
        a8bF0Ug0uMnucRBqfkQ0BoYG8MwgRahuFc2nZ4rmWoauoB/pRxCr6CJAJ6uihg1xBhMtkyyw5yT38
        L8cKGJp3+zTy4wXZoKULOwgopWVqyRRED0w5R5GliyWgzKw/NdlE0PX2Q2XjLIr/xybT2vawr4NBP
        I9P/w5pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEIB0-00F0Hk-1z; Thu, 12 Aug 2021 21:23:54 +0000
Date:   Thu, 12 Aug 2021 22:23:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        hch@lst.de, viro@zeniv.linux.org.uk, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <YRWRYnmoS+zVYqHV@casper.infradead.org>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
 <162879974434.3306668.4798886633463058599.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162879974434.3306668.4798886633463058599.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:22:24PM +0100, David Howells wrote:
> +++ b/include/linux/fs.h
> @@ -336,6 +336,7 @@ struct kiocb {
>  	union {
>  		unsigned int		ki_cookie; /* for ->iopoll */
>  		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
> +		struct page	*ki_swap_page;	/* For swapfile_read/write */

Nice idea.

> +static void __swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)

I would make this take a struct page * and just one 'ret'.

> +{
> +	struct page *page = iocb->ki_swap_page;
> +
> +	if (ret == PAGE_SIZE) {

page_size(page)?

> +	kiocb.ki_pos		= page_file_offset(page);

We talked about swap_file_pos(), right?

> +	ret = swap_file->f_mapping->a_ops->direct_IO(&kiocb, &to);
> +
> +	__swapfile_read_complete(&kiocb, ret, 0);
> +	return (ret > 0) ? 0 : ret;

What if it returns a short read?

> +static int swapfile_read(struct swap_info_struct *sis, struct page *page,
> +			 bool synchronous)
> +{
> +	struct swapfile_kiocb *ki;
> +	struct file *swap_file = sis->swap_file;
> +	struct bio_vec bv = {
> +		.bv_page = page,
> +		.bv_len  = thp_size(page),
> +		.bv_offset = 0
> +	};
> +	struct iov_iter to;
> +	int ret;
> +
> +	if (synchronous)
> +		return swapfile_read_sync(sis, page);

Seems a shame to set up the bio_vec and iov_iter twice.  Maybe call:

	iov_iter_bvec(&to, READ, &bv, 1, thp_size(page));

before swapfile_read_sync() and pass a pointer to 'to' to
swapfile_read_sync?

