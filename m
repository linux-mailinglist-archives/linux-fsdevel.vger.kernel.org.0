Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8639218C010
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 20:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCSTGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 15:06:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSTGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BfiVRtqXS3lVX9f3SkIik53RafXTtrCXM3yRWcRJeUs=; b=qrzHsJbrcipuIQnvRPoaCxmRmD
        +cSvtqqkkzZANB3UyhAxXL+L3FVI7twHI/G8u0tdkNlwZuwZWMPaZsVtaH5TjZfa8A9cSzAOSFNcL
        WDH+1SvTivlafZGpVcKsPnF7rKijRVxxK4X9wgXL7eXNt1wNJIJUUGtZ7Uw6jZGGFyww0l34+108U
        HFB3BgtquppUFJFKYEWK3OKQH40EoljqjPX66M+SlAJcjqJpQQMxs9itpDBJRrmwB+R053zg6vKm9
        gW6gfxZ8kkBOqFyQuE1EgTcKJ27vm+1M7tVqXXRvbS3SNfqysjXGeF93zsqMTH/NreIEDgO6Ee0g5
        OJ6gW2Vg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jF0VD-00027W-29; Thu, 19 Mar 2020 19:06:47 +0000
Date:   Thu, 19 Mar 2020 12:06:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit BIOs at the end of each extent
Message-ID: <20200319190646.GM22433@bombadil.infradead.org>
References: <20200319150720.24622-1-willy@infradead.org>
 <20200319151819.GA1581085@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319151819.GA1581085@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:18:19AM -0700, Darrick J. Wong wrote:
> On Thu, Mar 19, 2020 at 08:07:20AM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > By definition, an extent covers a range of consecutive blocks, so
> > it would be quite rare to be able to just add pages to the BIO from
> > a previous range.  The only case we can think of is a mapped extent
> > followed by a hole extent, followed by another mapped extent which has
> > been allocated immediately after the first extent.  We believe this to
> 
> Well... userspace can induce that with fallocate(INSERT_RANGE). :)

It's not impossible, of course ... just unlikely.  Nobody actually uses
INSERT_RANGE anyway.

> > be an unlikely layout for a filesystem to choose and, since the queue
> > is plugged, those two BIOs would be merged by the block layer.
> > 
> > The reason we care is that ext2/ext4 choose to lay out blocks 0-11
> > consecutively, followed by the indirect block, and we want to merge those
> > two BIOs.  If we don't submit the data BIO before asking the filesystem
> > for the next extent, then the indirect BIO will be submitted first,
> > and waited for, leading to inefficient I/O patterns.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/iomap/buffered-io.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 83438b3257de..8d26920ddf00 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -388,6 +388,11 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
> >  				ctx, iomap, srcmap);
> >  	}
> >  
> > +	if (ctx->bio) {
> > +		submit_bio(ctx->bio);
> > +		ctx->bio = NULL;
> > +	}
> 
> Makes sense, but could we have a quick comment here to capture why we're
> submitting the bio here?
> 
> /*
>  * Submit the bio now so that we neither combine IO requests for
>  * non-adjacent ranges nor interleave data and metadata requests.
>  */

How about:

         * Submitting the bio here leads to better I/O patterns for
         * filesystems which need to do metadata reads to find the
         * next range.

I also realised we can add:

@@ -454,8 +459,6 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
        }
        ret = 0;
 done:
-       if (ctx.bio)
-               submit_bio(ctx.bio);
        if (ctx.cur_page) {
                if (!ctx.cur_page_in_bio)
                        unlock_page(ctx.cur_page);

since we always subit the bio in readpages_actor.
