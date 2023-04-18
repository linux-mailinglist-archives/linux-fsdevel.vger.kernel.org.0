Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C386E59AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDRGur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDRGuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB1C9;
        Mon, 17 Apr 2023 23:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0323D62465;
        Tue, 18 Apr 2023 06:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29928C433EF;
        Tue, 18 Apr 2023 06:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681800644;
        bh=m0aoQNzOmb6TzmGaMXcg9PrpCa/tOrj2DkkReGTrODY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYDrr4xiq+8nSUCv+wKkztoqXRBa/knMwzmG2ST2X+eNUT0HMJgrX80BpFtXs6vG8
         MHHUXMdrBXEDU3/dW3e0SVHyZhUfjHn2M8UpRAMuainKwkxrsC6bQ3Ni88jx+XFwk0
         dItRC892uFizxvAYlKkf0NUBnJjULlp91DLcB9z9qrswdv+twrSTidxith+4qCE8ih
         fS0Zg29kuvw8UdEBwJNCgxRgrUyJBh6B4FLCT+I4J1+V4vGeI7I6lDJm9VFjoOeYdU
         kBmB2f5Z5gc1cuDJpRScevR0IxpCl301NETVA3fA2aVaIjOA30ECF4X0KjNN6sH6qM
         2LNgUPU23r5iQ==
Date:   Mon, 17 Apr 2023 23:50:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 29/29] ext4: Use a folio in ext4_read_merkle_tree_page
Message-ID: <20230418065042.GA121074@quark.localdomain>
References: <20230324180129.1220691-1-willy@infradead.org>
 <20230324180129.1220691-30-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324180129.1220691-30-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Fri, Mar 24, 2023 at 06:01:29PM +0000, Matthew Wilcox (Oracle) wrote:
> This is an implementation of fsverity_operations read_merkle_tree_page,
> so it must still return the precise page asked for, but we can use the
> folio API to reduce the number of conversions between folios & pages.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/verity.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index afe847c967a4..3b01247066dd 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -361,21 +361,21 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
>  					       pgoff_t index,
>  					       unsigned long num_ra_pages)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  
>  	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
>  
> -	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
> -	if (!page || !PageUptodate(page)) {
> +	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> +	if (!folio || !folio_test_uptodate(folio)) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
> -		if (page)
> -			put_page(page);
> +		if (folio)
> +			folio_put(folio);
>  		else if (num_ra_pages > 1)
>  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> -		page = read_mapping_page(inode->i_mapping, index, NULL);
> +		folio = read_mapping_folio(inode->i_mapping, index, NULL);
>  	}
> -	return page;
> +	return folio_file_page(folio, index);

This is not working at all, since it dereferences ERR_PTR(-ENOENT).  I think it
needs:

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 3b01247066dd..dbc655a6c443 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -366,15 +366,17 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (!folio || !folio_test_uptodate(folio)) {
+	if (folio == ERR_PTR(-ENOENT) || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-		if (folio)
+		if (!IS_ERR(folio))
 			folio_put(folio);
 		else if (num_ra_pages > 1)
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
 		folio = read_mapping_folio(inode->i_mapping, index, NULL);
 	}
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
 	return folio_file_page(folio, index);
 }
 
