Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2036C7A70DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 05:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjITDL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjITDL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640DB0;
        Tue, 19 Sep 2023 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uE+UAnC9YgmNAUhKoTWIdxRk/FdOddBgLymLwlPaqnk=; b=ekNfgmFwoHu8gIoYFOjAVApvtB
        3IXO/kDTQVK7eWR0y6nYylINvIk4NtmEm3kQODEPrUFwrj5dXTYcXamT6rwoq/2nvLl5fEGFiXvrd
        qGejySTQ2pAFXZBOhqsyHwndRN62Ily6nVv64jjObtM6K2L7dmD/rDOmehFEm5JknDqooHYchnJLb
        YI/tCYH/CrK1gcaARvorBnRcZOqw+jUnC5gKxqrYuQkFKyzuOj4PSUCgORs7pW00BJ/+8vty/M8I/
        5YP4CSRdEi8Ax4LZNa3piEYfC9C6VrjU/6PZSNvOYis9wkJzK92YeqJ4CXWiya1PLUT44i/m0R7WO
        mKrrt6Uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qincN-003PFJ-OR; Wed, 20 Sep 2023 03:11:11 +0000
Date:   Wed, 20 Sep 2023 04:11:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 07/26] gfs2; Convert gfs2_getjdatabuf to use a folio
Message-ID: <ZQpizwzZ/J+2CUfj@casper.infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
 <20230919045135.3635437-8-willy@infradead.org>
 <CAHc6FU4-RSAsc-LWw2OuLDecofapd30OZhxyjVKLXzJNwh-ZoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4-RSAsc-LWw2OuLDecofapd30OZhxyjVKLXzJNwh-ZoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:27:08AM +0200, Andreas Gruenbacher wrote:
> Thanks,
> 
> but this patch has an unwanted semicolon in the subject.

Thanks.  My laptop has a dodgy shift key, so this sometimes happens.
The build quality on HP Spectre laptops has gone downhill in the last
few years.

> > -       page = find_get_page_flags(mapping, index, FGP_LOCK|FGP_ACCESSED);
> > -       if (!page)
> > -               return NULL;
> > -       if (!page_has_buffers(page)) {
> > -               unlock_page(page);
> > -               put_page(page);
> > +       folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_ACCESSED, 0);
> > +       if (IS_ERR(folio))
> >                 return NULL;
> > -       }
> > -       /* Locate header for our buffer within our page */
> > -       for (bh = page_buffers(page); bufnum--; bh = bh->b_this_page)
> > -               /* Do nothing */;
> > -       get_bh(bh);
> > -       unlock_page(page);
> > -       put_page(page);
> > +       bh = folio_buffers(folio);
> > +       if (bh)
> > +               get_nth_bh(bh, bufnum);
> 
> And we need this here:
> 
>     bh = get_nth_bh(bh, bufnum);

Oof.  I should make that __must_check so the compiler tells me I'm being
an idiot.

Thanks!
