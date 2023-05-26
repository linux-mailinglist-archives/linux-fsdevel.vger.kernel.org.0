Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C236712CB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbjEZSmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZSme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 14:42:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED4E71;
        Fri, 26 May 2023 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mSsoE+0p2sc9kGpcn+WU5AUctLzpkgWUGD8f1AoBzvo=; b=ltD/wwR9voMJdzOfZ705IzKtCB
        eZA7RNSbiHcpZdR1w/wBRURZPc/ijS/ori312B41S0Xufrmw922txQtPZmPY5+qP7FUIDuM4hr1ug
        8d8UfgpK2eQOcxlveydCE6bMK2cbIXaKTL2pTOCI+ZAwJz2C2e8g7WFv21oqk8rYJaMQzBL2vqCsT
        /FPZsbcufMQFKMJoeBRxZMGJQv8E5b41Ajp9qlQLTNUnWkA07uvkkW0OZ1+PePVtaAvQqQSBO8N0T
        0raE2IBPXMiOsqaWqfVKuHy/9DDEOR8NyExErim0sjxvhnMKn/DdO77faDX89uXK5n7vdl26kjTRW
        hATqoiAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2cNe-0032Q1-F3; Fri, 26 May 2023 18:41:38 +0000
Date:   Fri, 26 May 2023 19:41:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/8] shmem: convert to use is_folio_hwpoison()
Message-ID: <ZHD9Yi04AvbawW8d@casper.infradead.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
 <20230526075552.363524-3-mcgrof@kernel.org>
 <ZHDDFoXs51Be8FcZ@casper.infradead.org>
 <ZHDvLD3vwt11EYFg@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHDvLD3vwt11EYFg@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 10:41:00AM -0700, Luis Chamberlain wrote:
> On Fri, May 26, 2023 at 03:32:54PM +0100, Matthew Wilcox wrote:
> > On Fri, May 26, 2023 at 12:55:46AM -0700, Luis Chamberlain wrote:
> > > The PageHWPoison() call can be converted over to the respective folio
> > > call is_folio_hwpoison(). This introduces no functional changes.
> > 
> > Yes, it very much does!
> > 
> > > @@ -4548,7 +4548,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> > >  		return &folio->page;
> > >  
> > >  	page = folio_file_page(folio, index);
> > > -	if (PageHWPoison(page)) {
> > > +	if (is_folio_hwpoison(folio)) {
> > >  		folio_put(folio);
> > 
> > Imagine you have an order-9 folio and one of the pages in it gets
> > HWPoison.  Before, you can read the other 511 pages in the folio.
> 
> But before we didn't use high order folios for reads on tmpfs?

Sure we did!  If SHMEM_HUGE_ALWAYS is set, we can see reads of THPs
(order-9 folios) in this path.

