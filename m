Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A26E2EC8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 05:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDODZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDODZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:25:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6504ECB;
        Fri, 14 Apr 2023 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ieHtrQuR9xDvhidDNkbr97KSetebKREK0D1RgGN+8Kw=; b=nWIxEB2WTi0n5vRquZCmT201yR
        LteCJWdrJj+NyEvujqTn/vJP4mZ73RtA90E6jffxBqzZ4OTH+kCoxWavP4vBVj+UEa4wVBLieQEbO
        /S3fzZ2mJudG8cfl08Qk/ztSjUUTXeG8Lw1SYzO9a1/9vlul0/tbP6GUBrgZv8akf52dM4KbKNXcA
        G3Ku2uDRaSGy/vftY9g1dO1E24BQmBPHrCSHA3oidqqI7LR19esa01Ofb9xErkO2EMvE5XeJ1tccP
        Rfs3hbXcBAM3vaMaGmSVY6NVn/EUszDj4tkPMBgb4W2n1nZPHr13HIMvichh1KNo2rTHTnCCv2djg
        vMan+UeA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnWX2-00BBD1-1b;
        Sat, 15 Apr 2023 03:24:56 +0000
Date:   Fri, 14 Apr 2023 20:24:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDoMmtcwNTINAu3N@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 03:31:54AM +0100, Matthew Wilcox wrote:
> On Fri, Apr 14, 2023 at 06:01:16PM -0700, Luis Chamberlain wrote:
> > a) dynamically allocate those now
> > b) do a cursory review of the users of that and prepare them
> >    to grok buffer heads which are blocksize based rather than
> >    PAGE_SIZE based. So we just try to kill MAX_BUF_PER_PAGE.
> > 
> > Without a) I think buffers after PAGE_SIZE won't get submit_bh() or lock for
> > bs > PAGE_SIZE right now.
> 
> Worse, we'll overflow the array and corrupt the stack.
> 
> This one is a simple fix ...
> 
> +++ b/fs/buffer.c
> @@ -2282,7 +2282,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  {
>         struct inode *inode = folio->mapping->host;
>         sector_t iblock, lblock;
> -       struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
> +       struct buffer_head *bh, *head;
>         unsigned int blocksize, bbits;
>         int nr, i;
>         int fully_mapped = 1;
> @@ -2335,7 +2335,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>                         if (buffer_uptodate(bh))
>                                 continue;
>                 }
> -               arr[nr++] = bh;
>         } while (i++, iblock++, (bh = bh->b_this_page) != head);
>  
>         if (fully_mapped)
> @@ -2353,24 +2352,27 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>         }
>  
>         /* Stage two: lock the buffers */
> -       for (i = 0; i < nr; i++) {
> -               bh = arr[i];
> +       bh = head;
> +       do {
>                 lock_buffer(bh);
>                 mark_buffer_async_read(bh);
> -       }
> +               bh = bh->b_this_page;
> +       } while (bh != head);
>  
>         /*
>          * Stage 3: start the IO.  Check for uptodateness
>          * inside the buffer lock in case another process reading
>          * the underlying blockdev brought it uptodate (the sct fix).
>          */
> -       for (i = 0; i < nr; i++) {
> -               bh = arr[i];
> +       bh = head;
> +       do {
>                 if (buffer_uptodate(bh))
>                         end_buffer_async_read(bh, 1);
>                 else
>                         submit_bh(REQ_OP_READ, bh);
> -       }
> +               bh = bh->b_this_page;
> +       } while (bh != head);
> +
>         return 0;

I thought of that but I saw that the loop that assigns the arr only
pegs a bh if we don't "continue" for certain conditions, which made me
believe that we only wanted to keep on the array as non-null items which
meet the initial loop's criteria. If that is not accurate then yes,
the simplication is nice!

  Luis
