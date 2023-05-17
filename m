Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448CC706D18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEQPng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEQPnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 11:43:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F4B558B
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/bea/Ao0tXydEBqoD4zpuJMruUISQrNg+0RkuvIvujw=; b=vuBNiJA+Js6e5rTz+93VXNm2V8
        AIw7R6LudQAH5hvMPm45nv9WSJSDkbZbtycFERpSw+iZysi5BsF3p5u6es7gsni5CQ+qkoIfhCYFR
        38y+P2f7WqdSXZ+wlzTI9xGytQTS4PvFlrO+HjEmEhPr7ONn0yI9nDrbmpH7DgKnk/p6R0JdR7P0z
        RBsXrqAnZHS07BnwnY0B93MZBHpPOtAyCe1LfdDQmVnH34KRkDgew40VZEySZsaaGbzI24wb9tFuw
        sUYGCvPwRMa2PeHDtW42IW2hToWL+Y22sCsadGP4q1JIr50zCpXqcLmjtb7YYGPFFvxX5sE52v7ta
        zQQ09+Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pzJJ6-005C5r-QP; Wed, 17 May 2023 15:43:16 +0000
Date:   Wed, 17 May 2023 16:43:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 4/6] buffer: Convert __block_write_full_page() to
 __block_write_full_folio()
Message-ID: <ZGT2FDNTp2Q+WfRA@casper.infradead.org>
References: <20230517032442.1135379-1-willy@infradead.org>
 <20230517032442.1135379-5-willy@infradead.org>
 <CGME20230517144703eucas1p1550db888e29fc5b182c202f24adddb87@eucas1p1.samsung.com>
 <20230517144701.4dnd5pzvzudccc56@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517144701.4dnd5pzvzudccc56@localhost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 04:47:01PM +0200, Pankaj Raghav wrote:
> > @@ -1793,7 +1793,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
> >  	blocksize = bh->b_size;
> >  	bbits = block_size_bits(blocksize);
> >  
> > -	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
> > +	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> 
> Shouldn't the PAGE_SHIFT be folio_shift(folio) as you allow larger
> folios to be passed to this function in the later patches?

No, the folio->index is expressed in multiples of PAGE_SIZE.

> >  	last_block = (i_size_read(inode) - 1) >> bbits;
> >  


