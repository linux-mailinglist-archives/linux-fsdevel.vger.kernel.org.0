Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12B42A4C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgKCRN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 12:13:58 -0500
Received: from verein.lst.de ([213.95.11.211]:38329 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgKCRN6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:13:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A38BA6736F; Tue,  3 Nov 2020 18:13:56 +0100 (CET)
Date:   Tue, 3 Nov 2020 18:13:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, kent.overstreet@gmail.com
Subject: Re: [PATCH 15/17] mm/filemap: Don't relock the page after calling
 readpage
Message-ID: <20201103171356.GA18303@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-16-willy@infradead.org> <20201103080045.GN8389@lst.de> <20201103152436.GA27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103152436.GA27442@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:24:36PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 03, 2020 at 09:00:45AM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 02, 2020 at 06:43:10PM +0000, Matthew Wilcox (Oracle) wrote:
> > > We don't need to get the page lock again; we just need to wait for
> > > the I/O to finish, so use wait_on_page_locked_killable() like the
> > > other callers of ->readpage.
> > 
> > As that isn't entirely obvious, what about adding a comment next to
> > the wait_on_page_locked_killable call to document it?
> 
> The other callers of ->readpage don't document that, so not sure why
> we should here?

The callers of ->readpage are a mess :(

Many use lock_page or trylock_page, one uses wait_on_page_locked directly,
another one uses the wait_on_page_read helper.  I think we need a good
helper here, and I think it looks a lot like filemap_read_page in your
tree..
