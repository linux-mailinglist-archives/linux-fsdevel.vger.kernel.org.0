Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA077A1FF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjIONkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjIONkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:40:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431651BEB;
        Fri, 15 Sep 2023 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I+/YKQ4i+/r6yo756aOfG+7UGEVhIuZROLbZ9WTDM80=; b=Q4md8y4/PXXCS6tFFXDCy+1Czx
        d1uDYKzf8x3eeThB0v0clHgFcJllTbJ/w+dM5rjEDs5ESW0hubWUmOtTW/Y73skTLMG0JAo4hZSDE
        lv5TM8HdRzUdIQ1Q85nKx+zVtMEPNzscnYBZzmYj+Y07Z8jMeCbtvzO01G5iekEMJtwyI/0Hb+nI4
        c4HqyL1w0pNyrxMo/8iQRiyG7Q+lUiCtDZQxtNcGxf8IGUjO35cUCFccj3Syt8iKHPNYnULskYB6I
        A40s8+3gs8SVNvuf20h5Lvs0o91dLEKLPp0AkFXpGkL26fO9eKxcZFBEnOVEs5LV0rYcrr0WtNK0S
        mkSA6d3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh93H-009z79-Vc; Fri, 15 Sep 2023 13:40:08 +0000
Date:   Fri, 15 Sep 2023 14:40:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/6] filemap: make the folio order calculation shareable
Message-ID: <ZQRet4w5VSbvKvKB@casper.infradead.org>
References: <20230915095042.1320180-1-da.gomez@samsung.com>
 <CGME20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150@eucas1p1.samsung.com>
 <20230915095042.1320180-2-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095042.1320180-2-da.gomez@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:51:23AM +0000, Daniel Gomez wrote:
> To make the code that clamps the folio order in the __filemap_get_folio
> routine reusable to others, move and merge it to the fgf_set_order
> new subroutine (mapping_size_order), so when mapping the size at a
> given index, the order calculated is already valid and ready to be
> used when order is retrieved from fgp_flags with FGF_GET_ORDER.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  fs/iomap/buffered-io.c  |  6 ++++--
>  include/linux/pagemap.h | 42 ++++++++++++++++++++++++++++++++++++-----
>  mm/filemap.c            |  8 --------
>  3 files changed, 41 insertions(+), 15 deletions(-)

That seems like a lot of extra code to add in order to avoid copying
six lines of code and one comment into the shmem code.

It's not wrong, but it seems like a bad tradeoff to me.
