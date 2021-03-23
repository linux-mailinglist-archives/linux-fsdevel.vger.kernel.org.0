Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B234653B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhCWQcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhCWQcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:32:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B20DC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ihX/eVzLUh0hv0NsIYp82L1/9v86wWW/P5s9/r4H1To=; b=i+MrimXgJ6Bvy9EJnOlXSwvGLz
        UXxaf6JjFvfKVNysHbaVPLOqr8EuErR41HoyDvVFsx/JbnljA5mX1Rjz+IpaO4BdPxmvPDhVWBgdX
        imMoQzmAtwa9gSQZGVaSUnKOuj5W9SP7vj1tW0q1kl16WX3phtzhdoN4hXwMBcHMmwBlneNsLHb6+
        fnxgZZ6xRO2UBHZho3vWLbzSRZnHBfgYKAFVujfijHWpIKjhnl+lgSFeVFkgbO44/JLUKT9DjNs+V
        qC1TWfkCwuntKWJDixtxbnViUh8rbPdjCz2BwO4f3QMLE4gAns/kpujI4Ve9/evU/7WFpzTIb3eci
        3w70dZww==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOjvH-00AHPX-Fi; Tue, 23 Mar 2021 16:30:53 +0000
Date:   Tue, 23 Mar 2021 16:30:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: set_page_dirty variants
Message-ID: <20210323163027.GH1719932@casper.infradead.org>
References: <20210322011907.GB1719932@casper.infradead.org>
 <20210323154125.GA2438080@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323154125.GA2438080@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:41:25PM +0000, Christoph Hellwig wrote:
> On Mon, Mar 22, 2021 at 01:19:07AM +0000, Matthew Wilcox wrote:
> > I'd like to get it down to zero.  After all, the !mapping case in
> > set_page_dirty() is exactly what we want.  So is there a problem
> > with doing this?
> > 
> > +++ b/mm/page-writeback.c
> > @@ -2562 +2562 @@ int set_page_dirty(struct page *page)
> > -       if (likely(mapping)) {
> > +       if (likely(mapping && mapping_can_writeback(mapping))) {
> > 
> > But then I noticed that we have both mapping_can_writeback()
> > and mapping_use_writeback_tags(), and I'm no longer sure
> > which one to use.  Also, why don't we mirror the results of
> > inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK into
> > a mapping->flags & AS_something bit?
> 
> Probably because no one has bothered to submit a patch yet.

I was hoping for a little more guidance.  Are mapping_can_writeback()
and mapping_use_writeback_tags() really the same thing?  I mean,
obviously the swap spaces actually _can_ writeback, but it doesn't
use the tags to do it.

