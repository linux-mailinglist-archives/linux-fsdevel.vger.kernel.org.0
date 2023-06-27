Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42C73F33A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjF0EQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0EQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:16:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA07C10FC;
        Mon, 26 Jun 2023 21:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YhN2HKlUxU0jShSahcjs57oeXS5v5uX1UIbvGoMaO4E=; b=Ej5m6KyWeYLWWpQNQM8Zb/OAra
        Z0TO4meR/mGllCmUl09CRh9qhElkXJpSDQrvKZuKb0rQi1EoceGSYfBwOTAP9s09XStXlaaeUzz+Z
        tmg8QYPCs33DGTj+5W1LQbLc9YYILcxJIta5y8QfGA21LOhueaJmHF3ljukfSH6CFt0aYQBNXW2A/
        UbtX6kE5UCjvZCvfIJLnUsYAl2nAq7hnmKgHgQ4reKksPy8zqKrvq5xv0J/ob+QncVr9ivUolDFMy
        ndoNxfAyu53/bj7OXOzB4A5pkzgLq8P76IgsmRETh79UYCA9q/8hjGdjXY5N/72FtRv8MwsPpJRvf
        gSvIfApA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE07g-00BfWP-35;
        Tue, 27 Jun 2023 04:16:12 +0000
Date:   Mon, 26 Jun 2023 21:16:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 04/12] writeback: Simplify the loops in
 write_cache_pages()
Message-ID: <ZJpijNd4G+JdVyhl@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:35:13PM +0100, Matthew Wilcox (Oracle) wrote:
> Collapse the two nested loops into one.  This is needed as a step
> towards turning this into an iterator.
> ---
>  mm/page-writeback.c | 94 ++++++++++++++++++++++-----------------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 54f2972dab45..68f28eeb15ed 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2461,6 +2461,7 @@ int write_cache_pages(struct address_space *mapping,
>  		      void *data)
>  {
>  	int error;
> +	int i = 0;
>  
>  	if (wbc->range_cyclic) {
>  		wbc->index = mapping->writeback_index; /* prev offset */
> @@ -2478,65 +2479,64 @@ int write_cache_pages(struct address_space *mapping,
>  	folio_batch_init(&wbc->fbatch);
>  	wbc->err = 0;
>  
> +	for (;;) {
> +		struct folio *folio;
>  
> +		if (i == wbc->fbatch.nr) {
> +			writeback_get_batch(mapping, wbc);
> +			i = 0;
> +		}
>  		if (wbc->fbatch.nr == 0)
>  			break;
> +		folio = wbc->fbatch.folios[i++];

Did you consider moving what is currently the "i" local variable
into strut writeback_control as well?  Then writeback_get_batch
could return the current folio, and we could hae a much nicer loop
here by moving all of the above into writeback_get_batch:

	while ((folio = writeback_get_batch(mapping, wbc))) {

(and yes, writeback_get_batch probably needs a better name with that)
