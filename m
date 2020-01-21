Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0458E1446A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 22:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAUVsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 16:48:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUVsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SMmHzOoK0zKqRyOSPuGbNVZWUnoYfq46L99pnmVsOJY=; b=cr2FofCm1rbjNUQwnzKjOwtMP
        xA961TLZPVEYU8+eWACuJWMuD2n07mNuFScfR6fedEPpCTeLS+W9mnTYswY4kOtWQkMBkAvp0Pvk/
        sxLHdNXougXbWpwIFVB+aJrUQcfI43aqbBXePORygHCDSOUGEoVSVJwj3K8DPylNy3xm39WPZu8nD
        FuUkOrAAK0ZZh+gbc9RWec0zGkdsyTqY/U/YsuVfdFUK4qEULwUat+ABuWcF9TPs91Xx4hRnUeSac
        MW4raF8S4K3L3VPAMxsVGf061X7jKyig0w6H64zFNz01FQxkzxHcl68Ikc3OACeJtcUmMJb1byE7e
        3DeuMQ9lQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iu1O9-0000L5-VA; Tue, 21 Jan 2020 21:48:45 +0000
Date:   Tue, 21 Jan 2020 13:48:45 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [RFC v2 0/9] Replacing the readpages a_op
Message-ID: <20200121214845.GA14467@bombadil.infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200121113627.GA1746@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121113627.GA1746@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:36:27PM +0100, Jan Kara wrote:
> > v2: Chris asked me to show what this would look like if we just have
> > the implementation look up the pages in the page cache, and I managed
> > to figure out some things I'd done wrong last time.  It's even simpler
> > than v1 (net 104 lines deleted).
> 
> I have an unfinished patch series laying around that pulls the ->readpage
> / ->readpages API in somewhat different direction so I'd like to discuss
> whether it's possible to solve my problem using your API. The problem I
> have is that currently some operations such as hole punching can race with
> ->readpage / ->readpages like:
> 
> CPU0						CPU1
> fallocate(fd, FALLOC_FL_PUNCH_HOLE, off, len)
>   filemap_write_and_wait_range()
>   down_write(inode->i_rwsem);
>   truncate_pagecache_range();
> 						readahead(fd, off, len)
> 						  creates pages in page cache
> 						  looks up block mapping
>   removes blocks from inode and frees them
> 						  issues bio
> 						    - reads stale data -
> 						      potential security
> 						      issue
> 
> Now how I wanted to address this is that I'd change the API convention for
> ->readpage() so that we call it with the page unlocked and the function
> would lock the page, check it's still OK, and do what it needs. And this
> will allow ->readpage() and also ->readpages() to grab lock
> (EXT4_I(inode)->i_mmap_sem in case of ext4) to synchronize with hole punching
> while we are adding pages to page cache and mapping underlying blocks.
> 
> Now your API makes even ->readpages() (actually ->readahead) called with
> pages locked so that makes this approach problematic because of lock
> inversions. So I'd prefer if we could keep the situation that ->readpages /
> ->readahead gets called without any pages in page cache locked...

I'm not a huge fan of that approach because it increases the number of
atomic ops (right now, we __SetPageLocked on the page before adding it
to i_pages).  Holepunch is a rather rare operation while readpage and
readpages/readahead are extremely common, so can we make holepunch take
a lock that will prevent new readpage(s) succeeding?

I have an idea to move the lock entries from DAX to being a generic page
cache concept.  That way, holepunch could insert lock entries into the
pagecache to cover the range being punched, and readpage(s) would either
skip lock entries or block on them.

Maybe there's a better approach though.
