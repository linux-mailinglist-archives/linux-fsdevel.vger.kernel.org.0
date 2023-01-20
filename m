Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBABC6759AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjATQRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 11:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjATQQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:16:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01804B472
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JrnqJrYlMP+qJ/XEVeiD2xIKkyegpJNuOm7AUt3/+5U=; b=Q6w0Vj5gprSJQstVhIqsQ6OyBT
        LpxsiybCtDiaQoixXNZMSMsWEGwB5RFHsoMevKDoC79JyrhZxBQdvxcwraoWdiGMNVD4/mpsavkaV
        WoeUP2Nj5hMbzFOXG0sov3ggWoVJXv088Hg1mfTtQgptlL2yHFZ8MEMMDiIqF+d5J9zHU+JqNcFhm
        RT5vEdTOS66D/7eQzKvHjNlWfFw9fJ0xHeUI3UbyXWhDSuuXVaevssYMo5mR39XTAX+5rqsFKmToG
        aXMuFaFCAfoIWtmAr2cYaMhtYXZZr3eEbMpsH7QuL6hrOzCo9d0NTABPwvJnI8oEBRGAOVApScoXL
        T4JXhLpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIu4V-0029vN-BW; Fri, 20 Jan 2023 16:16:55 +0000
Date:   Fri, 20 Jan 2023 16:16:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     dchinner@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] iomap: write iomap validity checks
Message-ID: <Y8q+d7TIZiT9nRVa@casper.infradead.org>
References: <Y8qbWDfLGqUDnbsz@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qbWDfLGqUDnbsz@kili>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:47:04PM +0300, Dan Carpenter wrote:
> Hello Dave Chinner,
> 
> The patch d7b64041164c: "iomap: write iomap validity checks" from Nov
> 29, 2022, leads to the following Smatch static checker warning:
> 
> 	fs/iomap/buffered-io.c:829 iomap_write_iter()
> 	error: uninitialized symbol 'folio'.
> 
> fs/iomap/buffered-io.c
>     818                 if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
>     819                         status = -EFAULT;
>     820                         break;
>     821                 }
>     822 
>     823                 status = iomap_write_begin(iter, pos, bytes, &folio);
>                                                                      ^^^^^^^
> The iomap_write_begin() function can succeed without initializing
> *foliop.  It's next to the big comment.

Yes, but if it does, it sets IOMAP_F_STALE

>     824                 if (unlikely(status))
>     825                         break;
>     826                 if (iter->iomap.flags & IOMAP_F_STALE)
>     827                         break;

so it breaks out here.  Maybe we should return an errno from
iomap_write_begin() to make life easier for the static checking tools?

> --> 829                 page = folio_file_page(folio, pos >> PAGE_SHIFT);
>                                                ^^^^^
> 
>     830                 if (mapping_writably_mapped(mapping))
>     831                         flush_dcache_page(page);
