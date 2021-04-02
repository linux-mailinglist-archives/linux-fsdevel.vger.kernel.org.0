Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0203F352BF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhDBOtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhDBOta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:49:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25FC0613E6;
        Fri,  2 Apr 2021 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fBsK7nTwBRh7zmZwlhR0hgVopltJEFGA41hXUoQ3g6Y=; b=HvUSmtVTxyIGtGp8LpJtiW6fHl
        e39Q6+s0X8R/zZdPF+774ETc5C3kK43KI5ZO/HVI5vkYqUCY8Ak7IWGlqnT1aPHe69hbIKzUpMYpF
        5wkZg+M7GaiepYGmn89B6l4LamHDDq1tHPIzkTcSexsDgS7u8GSwbcm30HV/+0pQHcVL7V2bn1yfR
        kxSJCP5BFHzGw+abkUg22slEZxYS4D5Y99peIaVvL07aCaCTt1qLvvxkkyCBcB7VP3mUNxVv+uZkm
        zIoMJvmv0PSmHy7Wj+XwTTKFK0AiD2Xx+B97jGZoxxx56rtRh/qsJpYdPRu3o9HEMF1mLKOXeGxiN
        sAcEN/Xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSL6p-007l0E-W1; Fri, 02 Apr 2021 14:49:17 +0000
Date:   Fri, 2 Apr 2021 15:49:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210402144915.GP351017@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210401070537.GB1363493@infradead.org>
 <20210401112656.GA351017@casper.infradead.org>
 <20210402143755.GA1843620@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402143755.GA1843620@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 03:37:55PM +0100, Christoph Hellwig wrote:
> On Thu, Apr 01, 2021 at 12:26:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 01, 2021 at 08:05:37AM +0100, Christoph Hellwig wrote:
> > > On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > > >  - Mirror members of struct page (for pagecache / anon) into struct folio,
> > > >    so (eg) you can use folio->mapping instead of folio->page.mapping
> > > 
> > > Eww, why?
> > 
> > So that eventually we can rename page->mapping to page->_mapping and
> > prevent the bugs from people doing page->mapping on a tail page.  eg
> > https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2103102214170.7159@eggly.anvils/
> 
> I'm not sure I like this.  This whole concept of structures that do need
> the same layout is very problematic, even with the safe guards you've
> added.  So if it was up to me I'd prefer the folio as a simple container
> as it was in the previous revisions.  At some point members should move
> from the page to the folio, but I'd rather do that over a shorter period
> an in targeted series.  We need the basic to go in first.

That was my original plan, but it'll be another round of churn, and I'm
not sure there'll be the appetite for it.  There's not a lot of appetite
for this round, and this one has measurable performance gains!

