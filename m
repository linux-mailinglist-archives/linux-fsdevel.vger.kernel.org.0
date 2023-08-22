Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE3784BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjHVVRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHVVRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FECEE
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 14:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E17635AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 21:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2A0C433C9;
        Tue, 22 Aug 2023 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692739040;
        bh=roiHgLZJ9eZxM4Qa4moRWIs6S5445MED2CQIRjckEIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5WaRtDjoooimOoHyMuNFAzp0vUJEHkX6xqtvX2OvvNXNgBXIAx1eLjdatiqwCyMA
         Sl2Qb6FOTNiwPHL/jB+PW4SZMWaEJ9hI7k8k0hDIR8CalVZin8zzOlxJuf65ev/DnT
         sVjLKS6sjMB91hM8BdhLMJ2pN8X6jl29i5S2fKX+qRy5biCv8E2gr42lM/BRu1qi3q
         PMhSGGVaVwRLGvMR8FbVr/FlOzltcrOxcg0M9eujJJtI1EAsnG7mk3SNXz0MbN1373
         CVWIf/o3KMb7VJwZlcJSnxMjn+wgz2uYwoPqjjNFB0kO1dAfTEnLSQ0tkMpqz0DPKw
         s4h1//3zXFreQ==
Date:   Tue, 22 Aug 2023 14:17:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] filemap: Convert generic_perform_write() to support
 large folios
Message-ID: <20230822211720.GA11242@frogsfrogsfrogs>
References: <20230822200937.159934-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822200937.159934-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 22, 2023 at 09:09:37PM +0100, Matthew Wilcox (Oracle) wrote:
> Modelled after the loop in iomap_write_iter(), copy larger chunks from
> userspace if the filesystem has created large folios.

Hum.  Which filesystems are those?  Is this for the in-memory ones like
tmpfs?

--D

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> This patch dependss on patches currently in the iomap tree.  Sending it
> out now for feedback, but I'll resend it after rc1.
> 
>  mm/filemap.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bf6219d9aaac..fd28767c760a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3908,6 +3908,7 @@ EXPORT_SYMBOL(generic_file_direct_write);
>  ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  {
>  	struct file *file = iocb->ki_filp;
> +	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	loff_t pos = iocb->ki_pos;
>  	struct address_space *mapping = file->f_mapping;
>  	const struct address_space_operations *a_ops = mapping->a_ops;
> @@ -3916,16 +3917,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  
>  	do {
>  		struct page *page;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> +		struct folio *folio;
> +		size_t offset;		/* Offset into folio */
> +		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
>  		void *fsdata = NULL;
>  
> -		offset = (pos & (PAGE_SIZE - 1));
> -		bytes = min_t(unsigned long, PAGE_SIZE - offset,
> -						iov_iter_count(i));
> +		offset = pos & (chunk - 1);
> +		bytes = min(chunk - offset, iov_iter_count(i));
> +		balance_dirty_pages_ratelimited(mapping);
>  
> -again:
>  		/*
>  		 * Bring in the user page that we will copy from _first_.
>  		 * Otherwise there's a nasty deadlock on copying from the
> @@ -3947,11 +3948,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  		if (unlikely(status < 0))
>  			break;
>  
> +		folio = page_folio(page);
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
> +
>  		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);
>  
> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> -		flush_dcache_page(page);
> +		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> +		flush_dcache_folio(folio);
>  
>  		status = a_ops->write_end(file, mapping, pos, bytes, copied,
>  						page, fsdata);
> @@ -3971,12 +3977,12 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  			 */
>  			if (copied)
>  				bytes = copied;
> -			goto again;
> +			if (chunk > PAGE_SIZE)
> +				chunk /= 2;
> +		} else {
> +			pos += status;
> +			written += status;
>  		}
> -		pos += status;
> -		written += status;
> -
> -		balance_dirty_pages_ratelimited(mapping);
>  	} while (iov_iter_count(i));
>  
>  	if (!written)
> -- 
> 2.40.1
> 
