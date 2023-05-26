Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF5712875
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbjEZOeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbjEZOd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 10:33:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E01739;
        Fri, 26 May 2023 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T8VThiU5yDpuxtlzoI3k0VlB8uKDehuvdCS/3nGjajM=; b=LBIXv8hGgi+RC/ChJJTsLPIuCx
        LYHJVDeVDXVjgD0j1JcLqthhprdU1SOY44Aqp+h+bygFqRx76bB8dgGx4tVnLxLEg4Bs4YKpfyqDU
        j6Cz/iX+sLsI41M8ojpeMz0lW+5ksg1CROaoLZTtScCuqBfu8iRu75z8cVCbInkVIUs6AIayjegKw
        yVQf7QeacQ78TiCaIt4S2wNYYT7AzAcda24siorZZgj0BXXaG1d8z9Jit1SpvkArkNtv5fotsMlFE
        7tf9rm4b0z5XvwuhEUufV9STTmDly7+/BiYjkSjwqxwd14WneUDajtkn7rW6IEexx4L70VzxZk7fI
        P+EqLesw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2YUw-002sns-I7; Fri, 26 May 2023 14:32:54 +0000
Date:   Fri, 26 May 2023 15:32:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/8] shmem: convert to use is_folio_hwpoison()
Message-ID: <ZHDDFoXs51Be8FcZ@casper.infradead.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
 <20230526075552.363524-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526075552.363524-3-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 12:55:46AM -0700, Luis Chamberlain wrote:
> The PageHWPoison() call can be converted over to the respective folio
> call is_folio_hwpoison(). This introduces no functional changes.

Yes, it very much does!

> @@ -4548,7 +4548,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>  		return &folio->page;
>  
>  	page = folio_file_page(folio, index);
> -	if (PageHWPoison(page)) {
> +	if (is_folio_hwpoison(folio)) {
>  		folio_put(folio);

Imagine you have an order-9 folio and one of the pages in it gets
HWPoison.  Before, you can read the other 511 pages in the folio.
After your patch, you can't read any of them.  You've effectively
increased the blast radius of any hwerror, and I don't think that's an
acceptable change.
