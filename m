Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904A53AA14A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhFPQbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhFPQbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:31:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8680C061574;
        Wed, 16 Jun 2021 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P3JM1PR0r8cXkfSpx6oDkANGnRG4SyX1FnBVo8rM8bQ=; b=WkFNMopVIoCUpd6Eqyc/x/e9Cu
        fGtqjaLTAEaCv2+fGvmJ32Ts/jZ6r7PNwy7GQ4bcxXftK/u5wA58Bp8O3GGvlP486CgGGqCVzvKil
        f6NddKUR6v9gBJQV08yhXncKu5HVKMVD7nPbvBWLIqf8HA6eIYqkxj4lPUj/BS8a+2RrutyU8n3nR
        nhFvHOAThn91QcZ52r/220tjI/wqBZtVdMWe+MFXuwTjqbrKT3lIYngmIUaesvNMKTnNClD0c8Rp6
        Mq6i8EkL8Cz/L8lkH6Lqh9fX75kiW0FVCnwvy0uj4JgE5foyBq5U6In9bRlhoqkVqCjlq1/qrqsIk
        8E3gKO5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltYOk-008Fhq-En; Wed, 16 Jun 2021 16:28:19 +0000
Date:   Wed, 16 Jun 2021 17:28:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <YMomnpDT9EQ/5XB9@casper.infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-4-willy@infradead.org>
 <YMjhP+Bk5PY5yqm7@kroah.com>
 <YMjkNd0zapLcooNB@casper.infradead.org>
 <20210615173453.GA2849@lst.de>
 <YMjtvLkHQ8sZ/CPS@casper.infradead.org>
 <YMmfQNjExNs3cuyq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMmfQNjExNs3cuyq@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 08:50:40AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 15, 2021 at 07:13:16PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 15, 2021 at 07:34:53PM +0200, Christoph Hellwig wrote:
> > > Eventually everything around set_page_dirty should be changed to operate
> > > on folios, and that will be a good time to come up with a sane
> > > naming scheme without introducing extra churn.
> > 
> > The way it currently looks in my tree ...
> > 
> > set_page_dirty(page) is a thin wrapper that calls folio_mark_dirty(folio).
> > folio_mark_dirty() calls a_ops->dirty_folio(mapping, folio) (which
> > 	returns bool).
> > __set_page_dirty_nobuffers() becomes filemap_dirty_folio()
> > __set_page_dirty_buffers() becomes block_dirty_folio()
> > __set_page_dirty_no_writeback() becomes dirty_folio_no_writeback()
> > 
> > Now I look at it, maybe that last should be nowb_dirty_folio().
> 
> Not to be a pain, but you are mixing "folio" at the front and back of
> the api name?  We messed up in the driver core with this for some things
> (get_device() being one), I would recommend just sticking with one
> naming scheme now as you are getting to pick what you want to use.

That is mostly what I'm doing.  eg,

get_page -> folio_get
lock_page -> folio_lock
PageUptodate -> folio_uptodate
set_page_dirty -> folio_mark_dirty

What I haven't dealt with yet is the naming of the
address_space_operations.  My thinking with those is that they should
be verb_folio, since they _aren't_ the functions that get called.
ie it looks like this:

folio_mark_dirty()
  aops->dirty_folio()
    ext4_dirty_folio()
      buffer_dirty_folio()

I actually see the inconsistency here as a good thing -- these are
implementations of the aop, so foo_verb_folio() means you're doing
something weird and internal instead of going through the vfs/mm.

That implies doing things like renaming ->readpage to ->read_folio, but
if we're changing the API from passing a struct page to a struct folio,
that can all be done at the same time with no additional disruption.
