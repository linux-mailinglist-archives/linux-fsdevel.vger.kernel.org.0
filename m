Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0EA712BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjEZRlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbjEZRl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 13:41:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CAE5C;
        Fri, 26 May 2023 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IlhXisbqRI4JCa1p0EpJL3g9WoXpQt0xT0Nj4ndM20E=; b=mnWv9xxpTNuhG9+/dZEP0422ih
        ZPvYZFFcScZsfnA2f4wknjp8Fp0JtupSp2LqseWHGM7ee9+lvA+QH1ioyjPQBJPaRm09DAuRuIwZv
        eMymAmHrmXat4ByJhquy0fed6ttcWGo5OSwCD4DS0hOTJZVIw3e/jKAfZPk/Dyoj6Bc7pa3JwUyTm
        U4mdVm/BmYresJJJ/2b5LrnxT1pJH71T53E4VxJMDnaNm+3584FVJJ9t93+Mkg4BRTKHwwm3KUvzM
        CVPnRwfPFh9kSVefDR9cPVvUJy8aevpvmdUAx0lYoGi0npASsDLKiy7j4Zyju9aD90/HrStecaqc4
        MyH9ayMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2bQy-003KpZ-2Y;
        Fri, 26 May 2023 17:41:00 +0000
Date:   Fri, 26 May 2023 10:41:00 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/8] shmem: convert to use is_folio_hwpoison()
Message-ID: <ZHDvLD3vwt11EYFg@bombadil.infradead.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
 <20230526075552.363524-3-mcgrof@kernel.org>
 <ZHDDFoXs51Be8FcZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHDDFoXs51Be8FcZ@casper.infradead.org>
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

On Fri, May 26, 2023 at 03:32:54PM +0100, Matthew Wilcox wrote:
> On Fri, May 26, 2023 at 12:55:46AM -0700, Luis Chamberlain wrote:
> > The PageHWPoison() call can be converted over to the respective folio
> > call is_folio_hwpoison(). This introduces no functional changes.
> 
> Yes, it very much does!
> 
> > @@ -4548,7 +4548,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> >  		return &folio->page;
> >  
> >  	page = folio_file_page(folio, index);
> > -	if (PageHWPoison(page)) {
> > +	if (is_folio_hwpoison(folio)) {
> >  		folio_put(folio);
> 
> Imagine you have an order-9 folio and one of the pages in it gets
> HWPoison.  Before, you can read the other 511 pages in the folio.

But before we didn't use high order folios for reads on tmpfs?

But I get the idea.

> After your patch, you can't read any of them.  You've effectively
> increased the blast radius of any hwerror, and I don't think that's an
> acceptable change.

I see, thanks! Will fix if we move forward with this.

  Luis
