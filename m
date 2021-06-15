Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870433A8838
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 20:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFOSG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 14:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhFOSG5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:06:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D4366109D;
        Tue, 15 Jun 2021 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623780292;
        bh=qHFj0jjHf8dwYggsbcjGlYx/b2OsiVOozqfbCFZaVmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OapCdjtqQyic7adsNgbjRIy88KCh9pqicljwlmqMT3Wm5dHAgh96uE8MOIsXXSjBK
         6FCsNCQkrtcw2EZNd4ASN+joL9NqRvf0Gwt2keeX/f7CFOwE9lVBXT792/MwwTTZaC
         FWDxjcM76zSgHS1LMTv7QeaHKXigJCRXvm2Dyu5c=
Date:   Tue, 15 Jun 2021 20:04:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: Use __set_page_dirty_nobuffers
Message-ID: <YMjrwgO3pdExIwOI@kroah.com>
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

Ok, that's fine, I don't normally touch these files, so it's not an
issue for me :)
