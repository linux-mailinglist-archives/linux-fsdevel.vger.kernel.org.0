Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF91926FC80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRMam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 08:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRMam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:30:42 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40856C06174A;
        Fri, 18 Sep 2020 05:30:42 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 58A7FC01D; Fri, 18 Sep 2020 14:30:40 +0200 (CEST)
Date:   Fri, 18 Sep 2020 14:30:25 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mtd@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [V9fs-developer] [PATCH 02/13] 9p: Tell the VFS that readpage
 was synchronous
Message-ID: <20200918123025.GA735@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918111916.GA32101@casper.infradead.org>
 <20200917151050.5363-3-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) wrote on Thu, Sep 17, 2020:
> The 9p readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

(I assume it'll be merged together with the rest)

> > What I'm curious about is the page used to be both unlocked and put, but
> > now isn't either and the return value hasn't changed for the caller to
> > make a difference on write_begin / I don't see any code change in the
> > vfs  to handle that.
> > What did I miss?
> 
> The page cache is kind of subtle.  The grab_cache_page_write_begin()
> will return a Locked page with an increased refcount.  If it's Uptodate,
> that's exactly what we want, and we return it.  If we have to read the
> page, readpage used to unlock the page before returning, and rather than
> re-lock it, we would drop the reference to the page and look it up again.
> It's possible that after dropping the lock on that page that the page
> was replaced in the page cache and so we'd get a different page.

Thanks for the explanation, I didn't realize the page already is
gotten/locked at the PageUptodate goto out.

> Anyway, now (unless fscache is involved), v9fs_fid_readpage will return
> the page without unlocking it.  So we don't need to do the dance of
> dropping the lock, putting the refcount and looking the page back up
> again.  We can just return the page.  The VFS doesn't need a special
> return code because nothing has changed from the VFS's point of view --
> it asked you to get a page and you got the page.

Yes, looks good to me.

Cheers,
-- 
Dominique
