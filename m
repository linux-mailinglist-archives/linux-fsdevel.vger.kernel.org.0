Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2825476F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiFKRmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 13:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiFKRmu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:42:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD357986;
        Sat, 11 Jun 2022 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cy4LqclDCzXO19Ll6jpbh9YluwE5VQrU+JF2sYO2jE0=; b=IxeQ9knTGfuPFY2EQO3cFHURNk
        8Aq729adAtGTjemhV30dzAco9EIMZh7j/WvantcPtZcAMhMNIPxKuaGYOXVzVodW8cCJuFcGPJvdz
        3QhZzc4YjmenhkYU1RNPeSB/3NQAUJLLXclhkJLs4g8y3YZhRxIr2xqWTvvmDLCWSIwJSDGoO3DUa
        he3gxqAngeEH8UKmIFvz6Nw/8zGYCDk+w2n763osH8eOIwcEaK5uV3XAdM5oW25NaZpZG1a71zz9i
        jzRYnpIMmls8+HfSypjUz43b/PCTd3Y7GlL9fnHttL5rcxmTekuN0llIvQl7xeqnMDThcspXRnPnR
        mcBtAr5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o058D-00FPYV-Al; Sat, 11 Jun 2022 17:42:41 +0000
Date:   Sat, 11 Jun 2022 18:42:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        akpm@linux-foundation.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Message-ID: <YqTUEZ+Pa24p09Uc@casper.infradead.org>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
 <YqNW8cYn9gM7Txg6@casper.infradead.org>
 <c5f97e2f-8a48-2906-91a2-1d84629b3641@gmail.com>
 <YqOOsHecZUWlHEn/@casper.infradead.org>
 <dfa6d60d-0efd-f12d-9e71-a6cd24188bba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa6d60d-0efd-f12d-9e71-a6cd24188bba@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 04:23:42PM +0800, Yu Kuai wrote:
> > This is going to mark the folio as accessed multiple times if it's
> > a multi-page folio.  How about this one?
> > 
> Hi, Matthew
> 
> Thanks for the patch, it looks good to me.

Did you test it?  This is clearly a little subtle ;-)

> BTW, I still think the fix should be commit 06c0444290ce ("mm/filemap.c:
> generic_file_buffered_read() now uses find_get_pages_contig").

Hmm, yes.  That code also has problems, but they're more subtle and
probably don't amount to much.

-       iocb->ki_pos += copied;
-
-       /*
-        * When a sequential read accesses a page several times,
-        * only mark it as accessed the first time.
-        */
-       if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
-               mark_page_accessed(page);
-
-       ra->prev_pos = iocb->ki_pos;

This will mark the page accessed when we _exit_ a page.  So reading
512-bytes at a time from offset 0, we'll mark page 0 as accessed on the
first read (because the prev_pos is initialised to -1).  Then on the
eighth read, we'll mark page 0 as accessed again (because ki_pos will
now be 4096 and prev_pos is 3584).  We'll then read chunks of page 1
without marking it as accessed, until we're about to step into page 2.

Marking page 0 accessed twice is bad; it'll set the referenced bit the
first time, and then the second time, it'll activate it.  So it'll be
thought to be part of the workingset when it's really just been part of
a streaming read.

And the last page we read will never be marked accessed unless it
happens to finish at the end of a page.

Before Kent started his refactoring, I think it worked:

-       pgoff_t prev_index;
-       unsigned int prev_offset;
...
-       prev_index = ra->prev_pos >> PAGE_SHIFT;
-       prev_offset = ra->prev_pos & (PAGE_SIZE-1);
...
-               if (prev_index != index || offset != prev_offset)
-                       mark_page_accessed(page);
-               prev_index = index;
-               prev_offset = offset;
...
-       ra->prev_pos = prev_index;
-       ra->prev_pos <<= PAGE_SHIFT;
-       ra->prev_pos |= prev_offset;

At least, I don't detect any bugs in this.

