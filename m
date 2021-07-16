Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B9D3CB111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 05:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhGPDVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 23:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:21:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27AC06175F;
        Thu, 15 Jul 2021 20:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YJuHEwapSltASFpILWUNzMl5SPEKG8/2ANXYoq2HkBU=; b=h36gNtuVFuvS9UeGvV/j+hrId+
        zvo+adnj2okPAYN6dPtpp21ecuG4iZfLScgRZhAj5Iq3KIzBiVvrn7erZeSxMjlryTjnDDxslDzVx
        fZoyInAnyLJmI89qOVsdRd7jgCmjBac1c9ttT0NHDae591fNilMxvrvhKT0EQk6k0sENCFevC9vR1
        OACfEf2gjmL/vyRqD5rRIKSZbuwSpmiyO85uAXiMPujT84sJss1sFbH4LS25xUQXsuQGtsWCWbamA
        zNrOkREMhCXcv7FD08OiK3nHLJc6/LGFEmX5bGwwOi46dv83+po2AwNvTRySdYNxVTjOybtPlMmZ+
        Bm+gJm+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4EMl-0046Aa-2a; Fri, 16 Jul 2021 03:18:32 +0000
Date:   Fri, 16 Jul 2021 04:18:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 101/138] iomap: Convert iomap_page_mkwrite to use a
 folio
Message-ID: <YPD6e1QQlwJ4F303@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-102-willy@infradead.org>
 <20210715214106.GL22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715214106.GL22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:41:06PM -0700, Darrick J. Wong wrote:
> > @@ -975,33 +975,33 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
> >  
> >  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> >  {
> > -	struct page *page = vmf->page;
> > +	struct folio *folio = page_folio(vmf->page);
> 
> If before the page fault the folio was a compound 2M page, will the
> memory manager will have split it into 4k pages before passing it to us?
> 
> That's a roundabout way of asking if we should expect folio_mkwrite at
> some point. ;)

Faults are tricky.  For ->fault, we need to know the precise page which
the fault occurred on (this detail is handled for you by filemap_fault()).
For mkwrite(), the page will not be split, so it's going to be a matter
of just marking the entire compound page as dirty (in the head page)
and making sure the filesystem is able to write back the entire folio.

Yes, there's going to be some write amplification here.  I believe
this will turn out to be a worthwhile tradeoff.  If I'm wrong, we can
implement some kind of split-on-fault.
