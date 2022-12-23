Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04366551CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiLWPCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 10:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiLWPCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:02:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB424BE0;
        Fri, 23 Dec 2022 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h+SmOW9vIMluWkiAOCy8s6ZiV2yLlIn3ZNFaeXBMSoA=; b=UrTkXlzBBuslEkvIUONV8dJgb5
        1jeGUmyfXIsAFWgWw4A0ERmGOjSR59qHBDTfAwqKLpdTKeTihaPx9w1NxfXHwHZShNp4h+YQk4Dua
        F1O1rdKzj2MHdg0eZj0NqOLj5Iqlxvk8lACDQKKbWUcPX3o7aX8GVQSMZmAhglvwbo91XAC2DuCk+
        h0jwk/5l7DAIx9JtoLSiySJeLaXZCbl/V7AFRd/gZnOVOxV+CpNWUkB5e0W5BxMwvENq9XwzgfWwd
        D7lcPyIIwXzvP+a91FdC5O9bL5YW1rYtYGvNLo0ebpSWyMdQx1gQZM5pWm1s3O3Z8m9Y8JC4Lc0Hh
        pRszZV4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8jZ2-009A0X-UF; Fri, 23 Dec 2022 15:02:24 +0000
Date:   Fri, 23 Dec 2022 07:02:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 2/7] iomap: Add iomap_folio_done helper
Message-ID: <Y6XDAG25Qumt/iyM@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216150626.670312-3-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:06:21PM +0100, Andreas Gruenbacher wrote:
> +static void iomap_folio_done(struct iomap_iter *iter, loff_t pos, size_t ret,
> +		struct folio *folio)
> +{
> +	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> +
> +	if (folio)
> +		folio_unlock(folio);
> +	if (page_ops && page_ops->page_done)
> +		page_ops->page_done(iter->inode, pos, ret, &folio->page);
> +	if (folio)
> +		folio_put(folio);
> +}

How is the folio derefence going to work if folio is NULL?

That being said, I really wonder if the current API is the right way to
go.  Can't we just have a ->get_folio method with the same signature as
__filemap_get_folio, and then do the __filemap_get_folio from the file
system and avoid the page/folio == NULL clean path entirely?  Then on
the done side move the unlock and put into the done method as well.

>  	if (!folio) {
>  		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> -		goto out_no_page;
> +		iomap_folio_done(iter, pos, 0, NULL);
> +		return status;
>  	}
>  
>  	/*
> @@ -656,13 +670,9 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	return 0;
>  
>  out_unlock:
> -	folio_unlock(folio);
> -	folio_put(folio);
> +	iomap_folio_done(iter, pos, 0, folio);
>  	iomap_write_failed(iter->inode, pos, len);
>  
> -out_no_page:
> -	if (page_ops && page_ops->page_done)
> -		page_ops->page_done(iter->inode, pos, 0, NULL);
>  	return status;

But for the current version I don't really understand why the error
unwinding changes here.
