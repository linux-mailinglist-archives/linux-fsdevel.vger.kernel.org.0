Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F293546876
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349656AbiFJOgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 10:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349655AbiFJOgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:36:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4A13FD6E;
        Fri, 10 Jun 2022 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SL6WDHTUHkdLCnhdaxfAT0gjsC7EVcgs4nlCTy2yQcs=; b=n0k3JrwAYZyCYAsOslLE2JxjQa
        OsgsRLcb6Rf6lNXwqDwq/MtvzPQrIpz4fQVQjH/SYvErT8pwLpbK8c4eahqPJnzNpFWsxw5iAqGFH
        vA+r4LewVXcMEUogpzRrQthPEucxjFGzRsJao+r0Xjl5IQkmF7X1Vy7n7Av+7Wpe+gQHJbmDmH/QF
        qGTepPN0qZXlTJPInVVtJFS877dJoZV41ZbHAC/Cs3u/0d1TcbAXRMcwlz9xzsd42bX6hZDSs4y0L
        FPphnfyls/1NxxJH1KIlo6akHSttgTUNu8fLRNjgvWsiLrsdADBUL8/5S7KreeJZDWn43z2oRzYgF
        9zrcuZfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzfkX-00EWMi-8G; Fri, 10 Jun 2022 14:36:33 +0000
Date:   Fri, 10 Jun 2022 15:36:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>, kent.overstreet@gmail.com
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Message-ID: <YqNW8cYn9gM7Txg6@casper.infradead.org>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqNWY46ZRoK6Cwbu@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 03:34:11PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 06, 2022 at 09:10:03AM +0800, Yu Kuai wrote:
> > On 2022/06/03 2:30, Matthew Wilcox wrote:
> > > On Thu, Jun 02, 2022 at 04:21:29PM +0800, Yu Kuai wrote:
> > > > In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
> > > > while it should be 'iocb->ki_ops'.
> > > 
> > > Can you walk me through your reasoning which leads you to believe that
> > > it should be ki_pos instead of ki_pos + copied?  As I understand it,
> > > prev_pos is the end of the previous read, not the beginning of the
> > > previous read.
> > 
> > Hi, Matthew
> > 
> > The main reason is the following judgement in flemap_read():
> > 
> > if (iocb->ki_pos >> PAGE_SHIFT !=	-> current page
> >     ra->prev_pos >> PAGE_SHIFT)		-> previous page
> >         folio_mark_accessed(fbatch.folios[0]);
> > 
> > Which means if current page is the same as previous page, don't mark
> > page accessed. However, prev_pos is set to 'ki_pos + copied' during last
> > read, which will cause 'prev_pos >> PAGE_SHIFT' to be current page
> > instead of previous page.
> > 
> > I was thinking that if prev_pos is set to the begining of the previous
> > read, 'prev_pos >> PAGE_SHIFT' will be previous page as expected. Set to
> > the end of previous read is ok, however, I think the caculation of
> > previous page should be '(prev_pos - 1) >> PAGE_SHIFT' instead.
> 
> OK, I think Kent broke this in 723ef24b9b37 ("mm/filemap/c: break
> generic_file_buffered_read up into multiple functions").  Before:
> 
> -       prev_index = ra->prev_pos >> PAGE_SHIFT;
> -       prev_offset = ra->prev_pos & (PAGE_SIZE-1);
> ...
> -               if (prev_index != index || offset != prev_offset)
> -                       mark_page_accessed(page);
> 
> After:
> +       if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
> +               mark_page_accessed(page);
> 
> So surely this should have been:
> 
> +       if (iocb->ki_pos != ra->prev_pos)
> +               mark_page_accessed(page);
> 
> Kent, do you recall why you changed it the way you did?

Oh, and if this is the right diagnosis, then this is the fix for the
current tree:

+++ b/mm/filemap.c
@@ -2673,8 +2673,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
                 * When a sequential read accesses a page several times, only
                 * mark it as accessed the first time.
                 */
-               if (iocb->ki_pos >> PAGE_SHIFT !=
-                   ra->prev_pos >> PAGE_SHIFT)
+               if (iocb->ki_pos != ra->prev_pos)
                        folio_mark_accessed(fbatch.folios[0]);

                for (i = 0; i < folio_batch_count(&fbatch); i++) {


