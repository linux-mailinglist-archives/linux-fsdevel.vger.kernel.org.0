Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC1B3A8851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 20:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFOSPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOSPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:15:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CBC061574;
        Tue, 15 Jun 2021 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cmlOH2ygGuqkkEEXUVRYhK6toz49SclSyMHtpe4EPs4=; b=tEw+AvYOLjPVtnh1k27hxPEwjO
        ntiLTS24P4AI23cJzHtF5Lm1Z7QtbDL9ZYc4WubCvN/vmQP3zLKPEaAi3V9Ys3Rx6Y3bPq5c4M7H9
        BYuiqTAwClrZbAK59VNSmyE+F6GOaqlD+2/yU78JwaXeJny0O5Kf/j6eLzSb1HgdTccz4EFLRplTE
        BgeUFow2hiITH+NH/Zvpg9UCmjXk0aETXPeSMRxUt8kFGeuw0I2ynwOgvil84rzIhiEC6Ero/5lG/
        t+bMeTHe4wUMVw6IVHPqYLcSMgfKarNBjT0ABtWDzUsE5T4a96YOicfA00lJ7HMPzwz4BETVBXVgD
        PsJ1i6tg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltDYq-00770E-CH; Tue, 15 Jun 2021 18:13:21 +0000
Date:   Tue, 15 Jun 2021 19:13:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <YMjtvLkHQ8sZ/CPS@casper.infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-4-willy@infradead.org>
 <YMjhP+Bk5PY5yqm7@kroah.com>
 <YMjkNd0zapLcooNB@casper.infradead.org>
 <20210615173453.GA2849@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615173453.GA2849@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:34:53PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 15, 2021 at 06:32:37PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 15, 2021 at 07:19:59PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jun 15, 2021 at 05:23:39PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Using __ functions in structures in different modules feels odd to me.
> > > Why not just have iomap_set_page_dirty be a #define to this function now
> > > if you want to do this?
> > > 
> > > Or take the __ off of the function name?
> > > 
> > > Anyway, logic here is fine, but feels odd.
> > 
> > heh, that was how I did it the first time.  Then I thought that it was
> > better to follow Christoph's patch:
> > 
> >  static const struct address_space_operations adfs_aops = {
> > +       .set_page_dirty = __set_page_dirty_buffers,
> > (etc)
> 
> Eventually everything around set_page_dirty should be changed to operate
> on folios, and that will be a good time to come up with a sane
> naming scheme without introducing extra churn.

The way it currently looks in my tree ...

set_page_dirty(page) is a thin wrapper that calls folio_mark_dirty(folio).
folio_mark_dirty() calls a_ops->dirty_folio(mapping, folio) (which
	returns bool).
__set_page_dirty_nobuffers() becomes filemap_dirty_folio()
__set_page_dirty_buffers() becomes block_dirty_folio()
__set_page_dirty_no_writeback() becomes dirty_folio_no_writeback()

Now I look at it, maybe that last should be nowb_dirty_folio().
