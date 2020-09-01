Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6C25A185
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIAWdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIAWdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:33:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBD4C061244;
        Tue,  1 Sep 2020 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TmyJ0BbLbbSDuQuruMjrmfeIja4KHT+NlxrM3Pes6YQ=; b=bNSviyyU19ly/efQ8h6QZNOBnx
        q8dhdpJIEhjLrPrzMRfmucfTIR1CbSAG8NKV64gk96L+lp5t3QizOYmMFe2287hTrIg2stFQkNdF7
        swELd6UeLDNj2iq0B+jXNa7N9XVWGCC/rCxiRy8V4BDpP8huOD+bBZyZIbUoQLmE1+FT4neaCHv+X
        W4gYVx/uizPrNG0D6+pK9AKjb9hD0A2ab0teQ9kRQGmNsmARWR0exsDRJXzaFA9jpfp5yf9qMZr2U
        YcEeg3NI3g9nerxd4CXoCBwOcf1xH7sPgYvRQ+Phao/qarhYkj1ymPY9HfTLSOQ5EzOcPMFbKQm0F
        ghp4rCNg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDEqY-00068H-W2; Tue, 01 Sep 2020 22:33:47 +0000
Date:   Tue, 1 Sep 2020 23:33:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] mm: Make more use of readahead_control
Message-ID: <20200901223346.GV14765@casper.infradead.org>
References: <20200901164827.GQ14765@casper.infradead.org>
 <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
 <423539.1598989454@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423539.1598989454@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:44:14PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > Note that I've been
> > > passing the number of pages to read in rac->_nr_pages, and then saving it
> > > and changing it certain points, e.g. page_cache_readahead_unbounded().
> > 
> > I do not like this.  You're essentially mutating the meaning of _nr_pages
> > as the ractl moves down the stack, and that's going to lead to bugs.
> > I'd keep it as a separate argument.
> 
> The meaning isn't specified in linux/pagemap.h.  Can you adjust the comments
> on the struct and on readahead_count() to make it more clear what the value
> represents?

It's intentionally not documented.  This documentation is for the
filesystem author, who should not be looking at it.  Neither should
you :-P
