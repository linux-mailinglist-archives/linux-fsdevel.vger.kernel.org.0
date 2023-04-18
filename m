Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F936E657A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjDRNI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjDRNI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:08:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8BA16FB9;
        Tue, 18 Apr 2023 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7B7rVYKI0u9INXAf/hY7evlSsSjz4DCVmUMyb5PFACA=; b=RmLVY+N4ghBqEcPNyOHY/AmsUu
        J3BOzkFsi1VAE0I2M7haXwo8W9m/B1o5xTz/QzUUEn0u9G+QRMiNZaNTItZ2vzQZOQCINELoEFIXr
        /vISQAodEcaG1SvVKey2BrhbZljzdPafWdQ3i4sOE/NFtBYkPr0BnY569qAMBPmk6eTDlZlwSPin4
        MWUHHxXh3Zv87MpjfDoY+3TppXSNQMxcH2XTd9L+xyOUZF82ZMStJ+ZxlI40gD1Had2KjbrkcFzzk
        zGS1z02F0eJYawApfI1CbsvuxCFQq8kX+vN6Q2mgFdGoel52zJLb5bE/5SA2hjepqoA8HkPB/dAm3
        zJ+eh5JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pol41-00CJKR-Ba; Tue, 18 Apr 2023 13:08:05 +0000
Date:   Tue, 18 Apr 2023 14:08:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 29/29] ext4: Use a folio in ext4_read_merkle_tree_page
Message-ID: <ZD6WNSKCjGGEFLB3@casper.infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
 <20230324180129.1220691-30-willy@infradead.org>
 <20230418065042.GA121074@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418065042.GA121074@quark.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:50:42PM -0700, Eric Biggers wrote:
> Hi Matthew,
> 
> On Fri, Mar 24, 2023 at 06:01:29PM +0000, Matthew Wilcox (Oracle) wrote:
> > This is an implementation of fsverity_operations read_merkle_tree_page,
> > so it must still return the precise page asked for, but we can use the
> > folio API to reduce the number of conversions between folios & pages.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/ext4/verity.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> > index afe847c967a4..3b01247066dd 100644
> > --- a/fs/ext4/verity.c
> > +++ b/fs/ext4/verity.c
> > @@ -361,21 +361,21 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
> >  					       pgoff_t index,
> >  					       unsigned long num_ra_pages)
> >  {
> > -	struct page *page;
> > +	struct folio *folio;
> >  
> >  	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
> >  
> > -	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
> > -	if (!page || !PageUptodate(page)) {
> > +	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> > +	if (!folio || !folio_test_uptodate(folio)) {
> >  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
> >  
> > -		if (page)
> > -			put_page(page);
> > +		if (folio)
> > +			folio_put(folio);
> >  		else if (num_ra_pages > 1)
> >  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> > -		page = read_mapping_page(inode->i_mapping, index, NULL);
> > +		folio = read_mapping_folio(inode->i_mapping, index, NULL);
> >  	}
> > -	return page;
> > +	return folio_file_page(folio, index);
> 
> This is not working at all, since it dereferences ERR_PTR(-ENOENT).  I think it
> needs:

Argh.  Christoph changed the return value of __filemap_get_folio().

>  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> -	if (!folio || !folio_test_uptodate(folio)) {
> +	if (folio == ERR_PTR(-ENOENT) || !folio_test_uptodate(folio)) {

This should be "if (IS_ERR(folio) || !folio_test_uptodate(folio)) {"

But we can't carry this change in Ted's tree because it doesn't have
Christoph's change.  And we can't carry it in Andrew's tree because it
doesn't have my ext4 change.

>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
> -		if (folio)
> +		if (!IS_ERR(folio))
>  			folio_put(folio);
>  		else if (num_ra_pages > 1)
>  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
>  		folio = read_mapping_folio(inode->i_mapping, index, NULL);
>  	}
> +	if (IS_ERR(folio))
> +		return ERR_CAST(folio);

return &folio->page;

>  	return folio_file_page(folio, index);
>  }
>  
