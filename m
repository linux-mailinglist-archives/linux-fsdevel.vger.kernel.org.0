Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30D13B35D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhFXSgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:36:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B17C061574;
        Thu, 24 Jun 2021 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=27gdr9GSvfO5CF3yEwKFCm7q1VtJuFO06FodmKTbgyI=; b=B5skOgOzPkjY6bdrH6eVE/ThMW
        wb2P1xvxjFuadS+qxGqcZLTeSohMATb5xFoWLB6hWImSGJm0iTtUpo9TglE+a9db8XPmXafyFuMAj
        4ZZeyYIKs1OlYOLOehy67kPaQq8s/1Ic7pyhs01bW960heZxbKudp2QhR7rDbnUZNQK2QyDRF46PM
        RXrV4e63262G9BAZfkn19Q53l6zpQrvVlOglbP4WayfmgBQBi+QWMrN9nSbTZVQpTi8T8Wm/AStFF
        Av+k203lhPZnDXTzGDZBywq+eSy0aXLMt6B6vmcVVkU7zqX3EIaOb+kSHkBWUHLmEZImvJDh2yJ0E
        vasxs2eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwUAV-00GslE-B3; Thu, 24 Jun 2021 18:33:42 +0000
Date:   Thu, 24 Jun 2021 19:33:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/46] mm/writeback: Add folio_start_writeback()
Message-ID: <YNTQA3JVoIdHWxyT@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-26-willy@infradead.org>
 <YNL8TGV2vgHcmmwX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNL8TGV2vgHcmmwX@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:18:04AM +0200, Christoph Hellwig wrote:
> > +static inline void set_page_writeback_keepwrite(struct page *page)
> >  {
> > +	folio_start_writeback_keepwrite(page_folio(page));
> >  }
> >  
> > +static inline bool test_set_page_writeback(struct page *page)
> >  {
> > +	return set_page_writeback(page);
> >  }
> 
> Shouldn't these be in folio-compat.c as well?

Thought about it.  We only have one caller of
set_page_writeback_keepwrite(), so it may as well get inlined there.
And test_set_page_writeback() is just a renaming ... I'd rather
replace the callers of test_set_page_writeback() with calls to
the new set_page_writeback() than move it into folio-compat.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
