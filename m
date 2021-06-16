Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148243AA170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFPQhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhFPQhP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:37:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E2766135C;
        Wed, 16 Jun 2021 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623861309;
        bh=y/YznPEe6jQnoQXyq4Rh3l3/m6Ej3k4x0E+6ydXUYVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onVmsbR/Bm8s78aDBGdm+vdJPMTMQuaMzqHVyTVm99f0KIy4+a+DnBKoj7Lj368Pu
         P8LRkEFZsbnftDcx8k+q4G56hpORgUnUxFdJ1o9jzpnStqXMUZL7/kqxuFaw7K7o0I
         pQq7pXPGoBB3ZIgdS8vuv+MJWUdOfdb2+qxyUVV4=
Date:   Wed, 16 Jun 2021 18:35:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <YMooO+YwvdFO+z3+@kroah.com>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-4-willy@infradead.org>
 <YMjhP+Bk5PY5yqm7@kroah.com>
 <YMjkNd0zapLcooNB@casper.infradead.org>
 <20210615173453.GA2849@lst.de>
 <YMjtvLkHQ8sZ/CPS@casper.infradead.org>
 <YMmfQNjExNs3cuyq@kroah.com>
 <YMomnpDT9EQ/5XB9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMomnpDT9EQ/5XB9@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:28:14PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 16, 2021 at 08:50:40AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 15, 2021 at 07:13:16PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 15, 2021 at 07:34:53PM +0200, Christoph Hellwig wrote:
> > > > Eventually everything around set_page_dirty should be changed to operate
> > > > on folios, and that will be a good time to come up with a sane
> > > > naming scheme without introducing extra churn.
> > > 
> > > The way it currently looks in my tree ...
> > > 
> > > set_page_dirty(page) is a thin wrapper that calls folio_mark_dirty(folio).
> > > folio_mark_dirty() calls a_ops->dirty_folio(mapping, folio) (which
> > > 	returns bool).
> > > __set_page_dirty_nobuffers() becomes filemap_dirty_folio()
> > > __set_page_dirty_buffers() becomes block_dirty_folio()
> > > __set_page_dirty_no_writeback() becomes dirty_folio_no_writeback()
> > > 
> > > Now I look at it, maybe that last should be nowb_dirty_folio().
> > 
> > Not to be a pain, but you are mixing "folio" at the front and back of
> > the api name?  We messed up in the driver core with this for some things
> > (get_device() being one), I would recommend just sticking with one
> > naming scheme now as you are getting to pick what you want to use.
> 
> That is mostly what I'm doing.  eg,
> 
> get_page -> folio_get
> lock_page -> folio_lock
> PageUptodate -> folio_uptodate
> set_page_dirty -> folio_mark_dirty

Nice.

> What I haven't dealt with yet is the naming of the
> address_space_operations.  My thinking with those is that they should
> be verb_folio, since they _aren't_ the functions that get called.
> ie it looks like this:
> 
> folio_mark_dirty()
>   aops->dirty_folio()
>     ext4_dirty_folio()
>       buffer_dirty_folio()
> 
> I actually see the inconsistency here as a good thing -- these are
> implementations of the aop, so foo_verb_folio() means you're doing
> something weird and internal instead of going through the vfs/mm.
> 
> That implies doing things like renaming ->readpage to ->read_folio, but
> if we're changing the API from passing a struct page to a struct folio,
> that can all be done at the same time with no additional disruption.

Ok, as long as there's a reason for the naming scheme, I'm happy as
hopefully it will make sense to others as well.

thanks,

greg k-h
