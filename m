Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B1D3A9320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhFPGwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 02:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhFPGwu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21AB2611CE;
        Wed, 16 Jun 2021 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623826244;
        bh=mkVmDBTkzp9vcVZUEJ0aZi98BpUdN+z9fa/gOoVHPxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQyoG04tzAI2WDIEcDGpz/DOUAx4FLI4MaQNWiNDQUzrCK1Ap8OoBECdrsP9Zd6qN
         ox3Cn/eZicJkH7Q1mn2mEkGuh8Me7+f+1wkAKFnMHhBzQ8J1qsuSfJYUb/jErX8K0B
         /OevaU6vSbgXeNpWeZV3KZfXFIJfnxaNAMvPGZks=
Date:   Wed, 16 Jun 2021 08:50:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <YMmfQNjExNs3cuyq@kroah.com>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-4-willy@infradead.org>
 <YMjhP+Bk5PY5yqm7@kroah.com>
 <YMjkNd0zapLcooNB@casper.infradead.org>
 <20210615173453.GA2849@lst.de>
 <YMjtvLkHQ8sZ/CPS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMjtvLkHQ8sZ/CPS@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:13:16PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 15, 2021 at 07:34:53PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 15, 2021 at 06:32:37PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 15, 2021 at 07:19:59PM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Jun 15, 2021 at 05:23:39PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > Using __ functions in structures in different modules feels odd to me.
> > > > Why not just have iomap_set_page_dirty be a #define to this function now
> > > > if you want to do this?
> > > > 
> > > > Or take the __ off of the function name?
> > > > 
> > > > Anyway, logic here is fine, but feels odd.
> > > 
> > > heh, that was how I did it the first time.  Then I thought that it was
> > > better to follow Christoph's patch:
> > > 
> > >  static const struct address_space_operations adfs_aops = {
> > > +       .set_page_dirty = __set_page_dirty_buffers,
> > > (etc)
> > 
> > Eventually everything around set_page_dirty should be changed to operate
> > on folios, and that will be a good time to come up with a sane
> > naming scheme without introducing extra churn.
> 
> The way it currently looks in my tree ...
> 
> set_page_dirty(page) is a thin wrapper that calls folio_mark_dirty(folio).
> folio_mark_dirty() calls a_ops->dirty_folio(mapping, folio) (which
> 	returns bool).
> __set_page_dirty_nobuffers() becomes filemap_dirty_folio()
> __set_page_dirty_buffers() becomes block_dirty_folio()
> __set_page_dirty_no_writeback() becomes dirty_folio_no_writeback()
> 
> Now I look at it, maybe that last should be nowb_dirty_folio().

Not to be a pain, but you are mixing "folio" at the front and back of
the api name?  We messed up in the driver core with this for some things
(get_device() being one), I would recommend just sticking with one
naming scheme now as you are getting to pick what you want to use.

So perhaps for the above:
	folio_mark_dirty()
	folio_dirty_no_writeback()
	folio_dirty_filemap()
	folio_dirty_block()

much like "set_page" is used today?

Anyway, just bikeshedding, it's your code, your choice :)

thanks for doing this work overall.

greg k-h
