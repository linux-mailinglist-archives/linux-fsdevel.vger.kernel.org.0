Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6806E2E15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDOBB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 21:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDOBB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 21:01:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD94C30;
        Fri, 14 Apr 2023 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HuvJIncN8aFUliTWQ7g2baezC5OHGU7tzKlMYWi/RtU=; b=B0fuWDeiDcj+zjit6RptExvuKE
        hLJW57hDfopXZs8gWmeEolk8lC34Ps3FnSGah6Wij69ZpPdG7uV/3JOMyJS4FIBo87kWwF0duX4Xw
        EQTSbYOPWbqMYHQeQK8HYIXp4nlpvLlo18l19yOWpfQi4GhnlUXgt0GPya0wxom7dNEqPAxwjTJvC
        oMzo/bOor6+KGDyRJsQKgwuTqbDGtShW9ZG06tJSMEt7d6TI62MAXe2ymhGxvpcqFV7Mv00aI7RDC
        CcpzdcT1uTxpuff/4rZhWXIWGSbGjD//yzJ05FWqQwr+57mN6e2m4PSuEgFKEcjGM8RqxhRJV1y4z
        X0tUyxaA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnUI0-00Ax0X-2t;
        Sat, 15 Apr 2023 01:01:16 +0000
Date:   Fri, 14 Apr 2023 18:01:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDn3XPMA024t+C1x@bombadil.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
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

On Fri, Apr 14, 2023 at 03:47:13PM +0200, Hannes Reinecke wrote:
> On 4/14/23 13:08, Pankaj Raghav wrote:
> > One of the first kernel panic we hit when we try to increase the
> > block size > 4k is inside create_page_buffers()[1]. Even though buffer.c
> > function do not support large folios (folios > PAGE_SIZE) at the moment,
> > these changes are required when we want to remove that constraint.

> Funnily enough, I've been tinkering along the same lines, and ended up with
> pretty similar patches.
> I've had to use two additional patches to get my modified 'brd' driver off
> the ground with logical blocksize of 16k:
> - mm/filemap: allocate folios according to the blocksize
>   (will be sending the patch separately)
> - Modify read_folio() to use the correct order:
> 
> @@ -2333,13 +2395,15 @@ int block_read_full_folio(struct folio *folio,
> get_block_t *get_block)
>         if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
>                 limit = inode->i_sb->s_maxbytes;
> 
> -       VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
>         head = create_folio_buffers(folio, inode, 0);
>         blocksize = head->b_size;
>         bbits = block_size_bits(blocksize);
> 
> -       iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> +       if (WARN_ON(PAGE_SHIFT < bbits)) {
> +               iblock = (sector_t)folio->index >> (bbits - PAGE_SHIFT);
> +       } else {
> +               iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> +       }
>         lblock = (limit+blocksize-1) >> bbits;
>         bh = head;
>         nr = 0;

At a quick glance I think both approaches (unless Hannes already did it)
seem to just miss that pesky static *arr[MAX_BUF_PER_PAGE], and so I
think we need to:

a) dynamically allocate those now
b) do a cursory review of the users of that and prepare them
   to grok buffer heads which are blocksize based rather than
   PAGE_SIZE based. So we just try to kill MAX_BUF_PER_PAGE.

Without a) I think buffers after PAGE_SIZE won't get submit_bh() or lock for
bs > PAGE_SIZE right now.

Luis
