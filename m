Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16402721480
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 05:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjFDDfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 23:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFDDfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 23:35:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784ADA
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jun 2023 20:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CcaX1YqTccJ2pm/jjC3O01CP48RRVQ+VTKTRem2EehI=; b=TwFMSGTU6MLMTpcvIpMUV+kK0N
        iATUFXml3FjyXJxY9zcofua0V/tim3VfK7QW0rSO8BvbqQsjnVrCegk89TcL+nDYbvjR4gQqfVkd7
        /QmYWm7GYnV6YfLc9w5fiZfodDyBuYcBRp5hoTqK4EkqAwVbUK8lMLIteHtKapyrY0KW6EI669r0t
        ho38/+XleX60H6lpf6vkfZgBccBmSSWMEkDvDuwsV3rePRHfFZEmlnRGqb8ExEx3Jp2mqzrOESqYd
        5uQ+1VZ3vQhasEB5fMoJPR0VqqbMpIvqpH6+oaJOsiWB4pC1Zmv6FWS3D9S+JDGh9zLBdrn7MpUif
        aTLpvKGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5eWk-00Ahrt-Dz; Sun, 04 Jun 2023 03:35:34 +0000
Date:   Sun, 4 Jun 2023 04:35:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 3/6] gfs2: Convert gfs2_write_jdata_page() to
 gfs2_write_jdata_folio()
Message-ID: <ZHwGhsDPYZQlYksK@casper.infradead.org>
References: <20230517032442.1135379-1-willy@infradead.org>
 <20230517032442.1135379-4-willy@infradead.org>
 <CAHc6FU4G1F1OXC233hT7_Vog9F8GNZyeLwsi+01USSXhFBNc_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4G1F1OXC233hT7_Vog9F8GNZyeLwsi+01USSXhFBNc_A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 03, 2023 at 11:34:14AM +0200, Andreas Gruenbacher wrote:
> >   * This is the same as calling block_write_full_page, but it also
> >   * writes pages outside of i_size
> >   */
> > -static int gfs2_write_jdata_page(struct page *page,
> > +static int gfs2_write_jdata_folio(struct folio *folio,
> >                                  struct writeback_control *wbc)
> >  {
> > -       struct inode * const inode = page->mapping->host;
> > +       struct inode * const inode = folio->mapping->host;
> >         loff_t i_size = i_size_read(inode);
> > -       const pgoff_t end_index = i_size >> PAGE_SHIFT;
> > -       unsigned offset;
> >
> > +       if (folio_pos(folio) >= i_size)
> > +               return 0;
> 
> Function gfs2_write_jdata_page was originally introduced as
> gfs2_write_full_page in commit fd4c5748b8d3 ("gfs2: writeout truncated
> pages") to allow writing pages even when they are beyond EOF, as the
> function description documents.

Well, that was stupid of me.

> This hack was added because simply skipping journaled pages isn't
> enough on gfs2; before a journaled page can be freed, it needs to be
> marked as "revoked" in the journal. Journal recovery will then skip
> the revoked blocks, which allows them to be reused for regular,
> non-journaled data. We can end up here in contexts in which we cannot
> "revoke" pages, so instead, we write the original pages even when they
> are beyond EOF. This hack could be revisited, but it's pretty nasty
> code to pick apart.
> 
> So at least the above if needs to go for now.

Understood.  So we probably don't want to waste time zeroing the folio
if it is entirely beyond i_size, right?  Because at the moment we'd
zero some essentially random part of the folio if I just take out the
check.  Should it look like this?

        if (folio_pos(folio) < i_size &&
            i_size < folio_pos(folio) + folio_size(folio))
               folio_zero_segment(folio, offset_in_folio(folio, i_size),
                                folio_size(folio));

