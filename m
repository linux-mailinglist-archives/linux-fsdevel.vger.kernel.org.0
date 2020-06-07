Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966431F0968
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 05:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgFGDE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgFGDE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 23:04:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78045C08C5C2;
        Sat,  6 Jun 2020 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S3FsUUp8iXLmWySNCgqZUVANUjvem9zIZH7o+aGND30=; b=q4dNKWO73dvv/w2gR5rVJs4uHc
        SSRMpCrEhQJBGJNJHiXI2ImHh5CIVaaFicv7gtGSZ0lonH97AaIFXeQUsJOm0csmj/8RqI6I+DNVl
        X185hBYPYnOtmCup1cPrexAyQtT0zc9hDY5o195HKK6PKWWq4WNNoDvu/WlqNfsZlgF8ejf9XJEQy
        /rvBf0Efdbmmr2sL2ShPseC6+L9WMlfWFE5KWaGLJgVU3koUMYaYqMVVpTJyRwyT9hflXRlaKfkCX
        0zbkAZcHfum4vM8taTDEij3C9A6bxIxJJRr1kv6u+rXYYQLHj4Jvq+jNBLfQDljRtlEXjhZ4W33Lq
        kWLAFCzw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhlcB-0008FJ-Eg; Sun, 07 Jun 2020 03:04:51 +0000
Date:   Sat, 6 Jun 2020 20:04:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/25] mm: Allow large pages to be added to the page
 cache
Message-ID: <20200607030451.GR19604@bombadil.infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
 <20200429133657.22632-19-willy@infradead.org>
 <20200504031036.GB16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504031036.GB16070@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 03, 2020 at 08:10:36PM -0700, Matthew Wilcox wrote:
> On Wed, Apr 29, 2020 at 06:36:50AM -0700, Matthew Wilcox wrote:
> > @@ -886,7 +906,7 @@ static int __add_to_page_cache_locked(struct page *page,
> >  	/* Leave page->index set: truncation relies upon it */
> >  	if (!huge)
> >  		mem_cgroup_cancel_charge(page, memcg, false);
> > -	put_page(page);
> > +	page_ref_sub(page, nr);
> >  	return xas_error(&xas);
> >  }
> >  ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
> 
> This is wrong.  page_ref_sub() will not call __put_page() if the refcount
> gets to zero.  What do people prefer?

*sigh*.  It's not wrong.  The caller holds a reference on the page
already, so calling page_ref_sub() will never reduce the refcount to 0.
The latest version looks like this:

+       page_ref_sub(page, nr);
+       VM_BUG_ON_PAGE(page_count(page) <= 0, page);

