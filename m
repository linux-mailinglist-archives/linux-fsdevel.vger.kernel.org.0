Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F554423B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 05:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiFID4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 23:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiFID4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:56:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7B286C9;
        Wed,  8 Jun 2022 20:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k5NOE2/mOchRWcRvMdsOMX23IRbR4XjJRm5kjerQYfs=; b=UMDExU/q7tF8/mqWoSgLYxhOpC
        FkB/nDKRBlAlwMswJxYlpwOD+T9b3fHuzs5Xk9HKsw1RzKM18Nvzmz2zvtMnyPCsG0qy2kU/WHu9X
        mVccNPi9V87DFgmPksbjSq32mvZYh7FU9kikejkUfrcbqMujPYOK4OsnGEYmxwRBuH+8cz929MoC+
        J1L5P254VCbTHcr/3B4+pgfRdz1mWvdV10u33rtAMJjWsHP0HN5sU7QukTrtM4bSJeT0tiNaLZ0sf
        okORJ39zhtNOHmkrX4y3W5zWBlbmRyPPS8qKqjL4e2oY+q3FEDzI+tyRYIGUkaqgz1VdTJg+hKLV8
        s6Jccx+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz9HM-00G0pb-DO; Thu, 09 Jun 2022 03:56:16 +0000
Date:   Wed, 8 Jun 2022 20:56:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 08/10] vmscan: Add check_move_unevictable_folios()
Message-ID: <YqFvYAlGGWW7ohTZ@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-9-willy@infradead.org>
 <YqBYxNPu3tLiN5kI@infradead.org>
 <YqDPIv5IgNHK/pJT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDPIv5IgNHK/pJT@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:32:34PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 08, 2022 at 01:07:32AM -0700, Christoph Hellwig wrote:
> > On Sun, Jun 05, 2022 at 08:38:52PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Change the guts of check_move_unevictable_pages() over to use folios
> > > and add check_move_unevictable_pages() as a wrapper.
> > 
> > The changes here look fine, but please also add patches for converting
> > the two callers (which looks mostly trivial to me).
> 
> I do want to get rid of pagevecs entirely, but that conversion isn't
> going to happen in time for the next merge window.  for_each_sgt_page()
> is a little intimidating.

for_each_sgt_page, just like other creative scatterlist abuse in the gpu
code is a beast.  But, instead of doing a for_each_sgt_page to add
pages to the pagevec and then do a loop over the pagevec to add to
the folio batch it should be pretty trivial to just cut out the
middle man.
