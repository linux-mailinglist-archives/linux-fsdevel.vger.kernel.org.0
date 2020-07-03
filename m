Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5516B213985
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGCLol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 07:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCLol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:44:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC55C08C5C1;
        Fri,  3 Jul 2020 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mVR1gXljLGpsshXpPuPenSltifBQ0m7hA39smBDxocI=; b=f8g/hiBbZIFmGN0vjAXuJdzTqE
        jp7sz11bmMaGdybtODKGG6nwTVwV1b1+JJ7fAUxVO5cjRUrDVp6ORA5VJZ1yer2DYfGyl9k1pCbWZ
        KHWKerVFkXYI4wlHPU65bCOrMsGXmn+uQoCbc0ZYxG/v3XvwFYdX72ICY0HbR6x9SOPChTmOvms95
        oZNxlRXL9Qe2ayvAqn0kvZOGhZegnZnQmlJULuDeWSdh6Owg/UuEbZDFnnp3vlGgwal3K2KXnpcTX
        MVDYdyPnBizWtAluNduvxZHxkeCJ2r7o/vTii2Q0Ochsg9O95PsPgOCBrh/O1HbEs3C9e/PNnTeCt
        B6OI3LKw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrK7R-0000OA-TV; Fri, 03 Jul 2020 11:44:38 +0000
Date:   Fri, 3 Jul 2020 12:44:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/2] gfs2: Rework read and page fault locking
Message-ID: <20200703114437.GF25523@casper.infradead.org>
References: <20200703095325.1491832-1-agruenba@redhat.com>
 <20200703095325.1491832-3-agruenba@redhat.com>
 <20200703113801.GD25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703113801.GD25523@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 03, 2020 at 12:38:01PM +0100, Matthew Wilcox wrote:
> > @@ -598,16 +562,9 @@ static void gfs2_readahead(struct readahead_control *rac)
> >  {
> >  	struct inode *inode = rac->mapping->host;
> >  	struct gfs2_inode *ip = GFS2_I(inode);
> > -	struct gfs2_holder gh;
> >  
> > -	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> > -	if (gfs2_glock_nq(&gh))
> > -		goto out_uninit;
> >  	if (!gfs2_is_stuffed(ip))
> >  		mpage_readahead(rac, gfs2_block_map);
> 
> I think you probably want to make this:
> 
> 	if (i_blocksize(page->mapping->host) == PAGE_SIZE &&
> 	    !page_has_buffers(page))
> 		error = iomap_readahead(rac, &gfs2_iomap_ops);
> 	else if (!gfs2_is_stuffed(ip))
> 		error = mpage_readahead(rac, gfs2_block_map);
> 
> ... but I understand not wanting to make that change at this point
> in the release cycle.

That was stupid.  I meant to write out:

	if (i_blocksize(rac->mapping->host) == PAGE_SIZE)
		error = iomap_readahead(rac, &gfs2_iomap_ops);
	else if (!gfs2_is_stuffed(ip))
		error = mpage_readahead(rac, gfs2_block_map);

Since the pages are freshly allocated, they can't have buffers, and
the mapping comes out of the readahead_control, not from the page.
