Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE72A3DB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgKCHbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:31:07 -0500
Received: from verein.lst.de ([213.95.11.211]:35993 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgKCHbE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:31:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7885967373; Tue,  3 Nov 2020 08:31:02 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:31:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 04/17] mm/filemap: Support readpage splitting a page
Message-ID: <20201103073102.GD8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-5-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:59PM +0000, Matthew Wilcox (Oracle) wrote:
> For page splitting to succeed, the thread asking to split the
> page has to be the only one with a reference to the page.  Calling
> wait_on_page_locked() while holding a reference to the page will
> effectively prevent this from happening with sufficient threads waiting
> on the same page.  Use put_and_wait_on_page_locked() to sleep without
> holding a reference to the page, then retry the page lookup after the
> page is unlocked.
> 
> Since we now get the page lock a little earlier in filemap_update_page(),
> we can eliminate a number of duplicate checks.  The original intent
> (commit ebded02788b5 ("avoid unnecessary calls to lock_page when waiting
> for IO to complete during a read")) behind getting the page lock later
> was to avoid re-locking the page after it has been brought uptodate by
> another thread.  We still avoid that because we go through the normal
> lookup path again after the winning thread has brought the page uptodate.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
