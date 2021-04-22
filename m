Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567E336819D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhDVNmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:42:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12AAC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5GZN6n8RFLGnbXpliy8DLvFaPZN8tEjUfgtjz00oI0k=; b=RYUcFuY5sV0XSyKeetYoyy5Qu3
        8foVvGMyoLW270fBu2RKAg0u2Q9nO37gvOkWgRtq8cxyyQFsTPy+tUYL3H4qnhuZ5lL1HNZcrUcyS
        kVT1QcJVZpA+PE7MxNrRcqV/vQS+ZCWj7GjWp/y3b+ZR3BtQK5uGULezOEGgZdVpnFlCvyEuMZ3c7
        xKw43H3kTyRyyVV5gZ67EVAEk7I4bCPeF1umnyxkT+m3sQD5/HfHXlLmZcIHLR/oJ46v+dVDmgoq4
        mjQ62NcXPQi/Kzk08RIvq5LN/BlkY83RdEHtTOZsQLmGwAhUUsAsUw2uGTkqwwxFRX+aATYxlt0gq
        NTYxNKTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZZZy-000LuK-K7; Thu, 22 Apr 2021 13:41:28 +0000
Date:   Thu, 22 Apr 2021 14:41:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: (in)consistency of page/folio function naming
Message-ID: <20210422134114.GN3596236@casper.infradead.org>
References: <20210422032051.GM3596236@casper.infradead.org>
 <ee5148a4-1552-5cf0-5e56-9303311fb2ef@redhat.com>
 <20210422122117.GE2047089@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422122117.GE2047089@ziepe.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:21:17AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 22, 2021 at 11:09:45AM +0200, David Hildenbrand wrote:
> > On 22.04.21 05:20, Matthew Wilcox wrote:
> > > 
> > > I'm going through my patch queue implementing peterz's request to rename
> > > FolioUptodate() as folio_uptodate().  It's going pretty well, but it
> > > throws into relief all the places where we're not consistent naming
> > > existing functions which operate on pages as page_foo().  The folio
> > > conversion is a great opportunity to sort that out.  Mostly so far, I've
> > > just done s/page/folio/ on function names, but there's the opportunity to
> > > regularise a lot of them, eg:
> > > 
> > > 	put_page		folio_put
> > > 	lock_page		folio_lock
> > > 	lock_page_or_retry	folio_lock_or_retry
> > > 	rotate_reclaimable_page	folio_rotate_reclaimable
> > > 	end_page_writeback	folio_end_writeback
> > > 	clear_page_dirty_for_io	folio_clear_dirty_for_io
> > > 
> > > Some of these make a lot of sense -- eg when ClearPageDirty has turned
> > > into folio_clear_dirty(), having folio_clear_dirty_for_io() looks regular.
> > > I'm not entirely convinced about folio_lock(), but folio_lock_or_retry()
> > > makes more sense than lock_page_or_retry().  Ditto _killable() or
> > > _async().
> > > 
> > > Thoughts?
> > 
> > I tend to like prefixes: they directly set the topic.
> > 
> > The only thing I'm concerned is that we end up with
> > 
> > put_page vs. folio_put
> > 
> > which is suboptimal.
> 
> We have this issue across the kernel already, eg kref_put() vs its
> wrapper put_device()
> 
> Personally I tend to think the regularity of 'thing'_'action' is
> easier to remember than to try to guess/remember that someone judged
> 'action'_'thing' to be more englishy.

Mostly agree.  object_verb_attribute is usually better, but i'm not
changing offset_in_folio() to folio_calculate_offset() (unless someone
comes up with a better name)

There are also a few places where "folio" is subordinate.
eg filemap_get_folio(), lruvec_stat_mod_folio()
