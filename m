Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF227352B87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhDBOiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhDBOiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:38:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D00C0613E6;
        Fri,  2 Apr 2021 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IWrrySydU1/oVFGzV/01gHMnlvSDnEBCyFAKBNPbXMQ=; b=QqMeM2AuPHvGbfyV9wRQVNM9Ot
        HlSIsyvwULnCxg6yeJDvnAz4Vk4gxR6GtNNsb8+EVx0zMfGX7SZvRfSLwdRXJi+cFVl+Jr9B6VoRD
        PS7Qvs+plQiHH3xE+aD86YOHWR059aKwwblgEI0sCQKVQYpVjypwngD9faNWlTm+aG+S64rq+Qs6q
        2EX25gt7pixvKE1OMi9mvDr8WcCLqFWiHsu/Fcjdy/4hT3vOK1vEeDbajhZM6fs4axnzSgzSklC8z
        XkX/9QF8vFgiTKpI75Mj+5FylRHpL5F33mLI7+czjD/lsim0ghd6z5AP3r9UzNc9yaLFDBGjp9bca
        Y81fkO5Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSKvr-007k8s-W3; Fri, 02 Apr 2021 14:37:57 +0000
Date:   Fri, 2 Apr 2021 15:37:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210402143755.GA1843620@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210401070537.GB1363493@infradead.org>
 <20210401112656.GA351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401112656.GA351017@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:26:56PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 01, 2021 at 08:05:37AM +0100, Christoph Hellwig wrote:
> > On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > >  - Mirror members of struct page (for pagecache / anon) into struct folio,
> > >    so (eg) you can use folio->mapping instead of folio->page.mapping
> > 
> > Eww, why?
> 
> So that eventually we can rename page->mapping to page->_mapping and
> prevent the bugs from people doing page->mapping on a tail page.  eg
> https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2103102214170.7159@eggly.anvils/

I'm not sure I like this.  This whole concept of structures that do need
the same layout is very problematic, even with the safe guards you've
added.  So if it was up to me I'd prefer the folio as a simple container
as it was in the previous revisions.  At some point members should move
from the page to the folio, but I'd rather do that over a shorter period
an in targeted series.  We need the basic to go in first.
