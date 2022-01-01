Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4974827EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiAAQOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jan 2022 11:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiAAQOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jan 2022 11:14:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A2C061574
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jan 2022 08:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XcgCn4MDqHhoa71szrFMuQC8sZ2VigvhMVV05YZ9l4c=; b=Tvj/rg4WMiKLRm/D3X2JIEY7U5
        ZyMJADm1UOZ/rt6uKjmQo+Vi0+q8znzwZWPEABOyuGB7P3NhenOnQguuOOJQjghuDSpUJF0xB5syr
        0Tl3O9pQKxaMSc6r0KNTNpukA426QdTj+OR8jKetEeyER+4KC1PwVui5ufbqRu+1dc71K0VosJsf0
        urmHgGLMbeKZ/aInNe7yh4udUp03PRTBPJyshiUEWA8udRSMwLl0l4oIF7dIt4naNFJccHPkdxkqU
        k72NU9K9jod9xFdEVqvdtydnkFK7x9HYlhTNwOkYrU0sTdmGdFTKAbEhSnUTw6DExDYxrwL014Www
        pXJ8Jgyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3h1d-00BOkQ-Sk; Sat, 01 Jan 2022 16:14:33 +0000
Date:   Sat, 1 Jan 2022 16:14:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 39/48] filemap: Convert filemap_read() to use a folio
Message-ID: <YdB96Sjzm5vEMwI0@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-40-willy@infradead.org>
 <YcQxqnwGyDj1rf1c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcQxqnwGyDj1rf1c@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 09:22:02AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 08, 2021 at 04:22:47AM +0000, Matthew Wilcox (Oracle) wrote:
> >  		for (i = 0; i < pagevec_count(&pvec); i++) {
> > -			struct page *page = pvec.pages[i];
> > -			size_t page_size = thp_size(page);
> > -			size_t offset = iocb->ki_pos & (page_size - 1);
> > +			struct folio *folio = page_folio(pvec.pages[i]);
> > +			size_t fsize = folio_size(folio);
> 
> Any reason for fsize vs folio_size?

  CC      mm/filemap.o
../mm/filemap.c: In function ‘filemap_read’:
../mm/filemap.c:2672:45: error: called object ‘folio_size’ is not a function or function pointer
 2672 |                         size_t folio_size = folio_size(folio);
      |                                             ^~~~~~~~~~
../mm/filemap.c:2672:32: note: declared here
 2672 |                         size_t folio_size = folio_size(folio);
      |                                ^~~~~~~~~~

