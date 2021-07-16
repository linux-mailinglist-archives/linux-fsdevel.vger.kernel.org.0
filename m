Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4213CB0AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 04:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhGPCLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhGPCLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:11:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BACC06175F;
        Thu, 15 Jul 2021 19:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yiRhxxbR+vQ5qbuTqU1Ha6uMzPQoPlac3XG7Lxx4jJs=; b=HZWgPg26qb9x9qP4jzQXNTg9K0
        qCOQMuI4vrMemHNWvFsP0bYxE5T1XCaL+JQLI3Zyv07775Y6kfXjsQORpD8N+LnjqMF465xeT89l0
        lTIEjas9Z/pKIKNBma771J0VJRIJDGR5A58jty6Ij7Z/PMjpduG5leUagrgexzja5NU4W1ehM+stw
        G/PeW1RtFGrRLxWU6QxyVRNnPwQW8NyomGJDaxgioEUdL9CYzzKGGybBfuxCgEUAV7wq1dyMqm9mb
        b30O7q6+5bVfNP5FzN2E5tuNyNvNusPi2bmJoiaCaOqjDTjGGK4QwhjisaydWM+Hg0FRmYjsbUeAa
        22tEgBvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4DFa-0043I1-80; Fri, 16 Jul 2021 02:07:07 +0000
Date:   Fri, 16 Jul 2021 03:06:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 106/138] iomap: Convert iomap_do_writepage to use a
 folio
Message-ID: <YPDpunndhcBUeS+U@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-107-willy@infradead.org>
 <20210715220505.GQ22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715220505.GQ22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:05:05PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:32AM +0100, Matthew Wilcox (Oracle) wrote:
> > Writeback an entire folio at a time, and adjust some of the variables
> > to have more familiar names.
> > @@ -1398,16 +1397,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  static int
> >  iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
> 
> I imagine at some point this will become iomap_do_writefolio and ther
> will be some sort of write_cache_folios() call?  Or the equivalent
> while(get_next_folio_to_wrote()) iomap_write_folio(); type loop?

I hadn't quite got as far as planning out what to do next with a
replacement for write_cache_pages().  At a minimum, that function is
going to work on folios -- it does anyway; we don't tag tail pages in
the xarray, so the tagged lookup done by write_cache_pages() only finds
folios.  So everything we do with a page there is definitely looking at
a folio.

I want to get a lot more filesystems converted to use folios before I
undertake the write_cache_pages() interface overhaul (and I'll probably
think of several things to do to it at the same time -- like working on
a batch of pages all at once instead of calling one indirect function
per folio).
