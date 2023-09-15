Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303217A2758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjIOTpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbjIOTp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:45:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D943C8E;
        Fri, 15 Sep 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=162ByQtUEtKATklSugznQjq/HmritqoY8YxWx3GTMHQ=; b=of/bPBGMK23VCoRz50gjg0FFj9
        D0Xt0uivezxGMsBBQORMb0znYbWzkWTWghVEB/Va32s5RBV2XqK6OBrCoHQKMFc+9K4ubLa2FXFJM
        c9mtRmD6BsvrBTdSj/0oiahRyIAqlXP0UDEbTEGo5vNpng9yKOdH+h05CxVd6v9mxCdEtxrUsSW1G
        5Nu1zdE9k288+9TFHnrWmcXc7SDzJ8Pl0RCtWwS8KTx8xE4GQI/leEBab3Ix0St5Vjy1KzXSv6sj7
        mYiIj/vlMUKZfuZNS072Vr6LEq1jSaXP6rx2xvCvvMALzpHWgITaNHGpo/TchrLTPjZVMojqDfg0o
        MaM8TaDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhEki-00Bg0a-Q4; Fri, 15 Sep 2023 19:45:20 +0000
Date:   Fri, 15 Sep 2023 20:45:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 05/23] filemap: align index to mapping_min_order in
 filemap_range_has_page()
Message-ID: <ZQS0UGQMbUCYr2t3@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-6-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-6-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:30PM +0200, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> page cache is mapping min_folio_order aligned. Use mapping min_folio_order
> to align the start_byte and end_byte in filemap_range_has_page().

What goes wrong if you don't?  Seems to me like it should work.

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/filemap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 2c47729dc8b0..4dee24b5b61c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -477,9 +477,12 @@ EXPORT_SYMBOL(filemap_flush);
>  bool filemap_range_has_page(struct address_space *mapping,
>  			   loff_t start_byte, loff_t end_byte)
>  {
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int nrpages = 1UL << min_order;
> +	pgoff_t index = round_down(start_byte >> PAGE_SHIFT, nrpages);
>  	struct folio *folio;
> -	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
> -	pgoff_t max = end_byte >> PAGE_SHIFT;
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	pgoff_t max = round_down(end_byte >> PAGE_SHIFT, nrpages);
>  
>  	if (end_byte < start_byte)
>  		return false;
> -- 
> 2.40.1
> 
