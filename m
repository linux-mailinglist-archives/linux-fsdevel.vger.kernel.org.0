Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B245B689CB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjBCPHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 10:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjBCPHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:07:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286FEA0E99;
        Fri,  3 Feb 2023 07:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DFUkqlIb1koR34QSR5KYPFYQ+oC2ej0KqthqG2wrzL8=; b=QTLBPiQNVGLCOGdfPgtGITnHy8
        VdbEIQzfUpVRnoHj6uEvO9vNTNXB3Y5GAKE52fN3jq0ciwAKlSiiJniPLlZ9mW7lpssuUH3AHoauX
        tZVG9s5oncmxw8GO3wfZRHq52EYoApCHer2IBgXz0X8NmYslkeLdNfL7irqEC8W1Hl1CskyZtzQk3
        di4ZfKsWGctoXkMvrHi/SoFhY8QeTD9OaEUlRQ6qGCXYvAaL8p8cvhaNwgS3XvjDjxRXDUWl9PdWk
        gclC2AyLWzE0WqfI2Atf8bmUX8wg49kdHjsRVo0OPzlYU1ARyDAyaa6dpiJLpDabruhiyI+kS6Ylf
        Qbl9VHoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxeb-00EOZb-KF; Fri, 03 Feb 2023 15:07:05 +0000
Date:   Fri, 3 Feb 2023 15:07:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] truncate: Zero bytes after 'oldsize' if we're
 expanding the file
Message-ID: <Y90jGVTFxU/QLM5o@casper.infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
 <20230202204428.3267832-2-willy@infradead.org>
 <Y90FYG+tNtBIl62S@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90FYG+tNtBIl62S@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:00:16AM -0500, Brian Foster wrote:
> On Thu, Feb 02, 2023 at 08:44:23PM +0000, Matthew Wilcox (Oracle) wrote:
> > POSIX requires that "If the file size is increased, the extended area
> > shall appear as if it were zero-filled".  It is possible to use mmap to
> > write past EOF and that data will become visible instead of zeroes.
> > This fixes the problem for the filesystems which simply call
> > truncate_setsize().  More complex filesystems will need their own
> > patches.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/truncate.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index 7b4ea4c4a46b..cebfc5415e9a 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -763,9 +763,12 @@ void truncate_setsize(struct inode *inode, loff_t newsize)
> >  	loff_t oldsize = inode->i_size;
> >  
> >  	i_size_write(inode, newsize);
> > -	if (newsize > oldsize)
> > +	if (newsize > oldsize) {
> >  		pagecache_isize_extended(inode, oldsize, newsize);
> > -	truncate_pagecache(inode, newsize);
> > +		truncate_pagecache(inode, oldsize);
> > +	} else {
> > +		truncate_pagecache(inode, newsize);
> > +	}
> 
> I don't think this alone quite addresses the problem. Looking at ext4
> for example, if the eof page is dirty and writeback occurs between the
> i_size update (because writeback also zeroes the post-eof portion of the
> page) and the truncate_setsize() call, we end up with pagecache
> inconsistency because pagecache truncate doesn't dirty the page it
> zeroes.
> 
> So for example, with this series plus a nefariously placed
> filemap_flush() in ext4_setattr():
> 
> # xfs_io -fc "truncate 1" -c "mmap 0 1k" -c "mwrite 0 10" -c "truncate 5" -c "mread -v 0 5" /mnt/file
> 00000000:  58 00 00 00 00  X....
> # umount /mnt/; mount <dev> /mnt/
> # xfs_io -c "mmap 0 1k" -c "mread -v 0 5" /mnt/file 
> 00000000:  58 58 58 58 58  XXXXX

Hm, so switch the order of i_size_write() and truncate_pagecache()?
There could still be a store between old-EOF and new-EOF from another
thread, which would then be visible, but I don't think you could prove
that store should have been zeroed.  Not from the thread doing the
ftruncate() anyway -- I think the thread doing the store could prove
it, but that thread is relying on undefined behaviour anyway.

