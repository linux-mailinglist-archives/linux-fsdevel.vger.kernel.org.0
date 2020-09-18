Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93426FB47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 13:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIRLTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIRLTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:19:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF9C06174A;
        Fri, 18 Sep 2020 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D2ju8jMz6rNG3JDmyLzknrnz9KKFGg0PYq+DeMuVZKY=; b=OhWnaBzrqkDRbzOwxxDZrAitsW
        uGCQAikASHjYa/PMPuiPlUOcliemRBZlSc/1RLXgVWxgpXKT26jnRaH2hmTM72gxSVdhOPqu6kQPd
        h+y2nYjcOI/MK6CMWwhrlZi9ICHnkGIztdyZsb1kUMTfkP470jFOrvRJfyuy8uYVb1UtlcOcYJKpU
        E5Rm9//Op9Yh9xVsMJdzShSN0jO9N6AGwLLD/O1r3P9sdUd2Ic22Cm/qIxyYzHn5gT/lwgN84usJW
        ACafXKejemQbxTWMfkPL3z3ucBuijE/zG8VKPfz4WQt3m2mP+hkouoscs89VtGRxh2HUUy/mInKXY
        PZ8Gd81Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJEQ9-0002ra-1H; Fri, 18 Sep 2020 11:19:17 +0000
Date:   Fri, 18 Sep 2020 12:19:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mtd@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [V9fs-developer] [PATCH 02/13] 9p: Tell the VFS that readpage
 was synchronous
Message-ID: <20200918111916.GA32101@casper.infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-3-willy@infradead.org>
 <20200918055919.GA30929@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918055919.GA30929@nautica>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 07:59:19AM +0200, Dominique Martinet wrote:
> Matthew Wilcox (Oracle) wrote on Thu, Sep 17, 2020:
> > diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> > index cce9ace651a2..506ca0ba2ec7 100644
> > --- a/fs/9p/vfs_addr.c
> > +++ b/fs/9p/vfs_addr.c
> > @@ -280,6 +280,10 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
> >  		goto out;
> >  
> >  	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
> > +	if (retval == AOP_UPDATED_PAGE) {
> > +		retval = 0;
> > +		goto out;
> > +	}
> 
> FWIW this is a change of behaviour; for some reason the code used to
> loop back to grab_cache_page_write_begin() and bail out on
> PageUptodate() I suppose; some sort of race check?
> The whole pattern is a bit weird to me and 9p has no guarantee on
> concurrent writes to a file with cache enabled (except that it will
> corrupt something), so this part is fine with me.
> 
> What I'm curious about is the page used to be both unlocked and put, but
> now isn't either and the return value hasn't changed for the caller to
> make a difference on write_begin / I don't see any code change in the
> vfs  to handle that.
> What did I miss?

The page cache is kind of subtle.  The grab_cache_page_write_begin()
will return a Locked page with an increased refcount.  If it's Uptodate,
that's exactly what we want, and we return it.  If we have to read the
page, readpage used to unlock the page before returning, and rather than
re-lock it, we would drop the reference to the page and look it up again.
It's possible that after dropping the lock on that page that the page
was replaced in the page cache and so we'd get a different page.

Anyway, now (unless fscache is involved), v9fs_fid_readpage will return
the page without unlocking it.  So we don't need to do the dance of
dropping the lock, putting the refcount and looking the page back up
again.  We can just return the page.  The VFS doesn't need a special
return code because nothing has changed from the VFS's point of view --
it asked you to get a page and you got the page.
