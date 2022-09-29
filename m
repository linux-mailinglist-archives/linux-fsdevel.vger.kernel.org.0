Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51735EFF4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiI2VaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 17:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiI2V37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:29:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CE36417;
        Thu, 29 Sep 2022 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rXAbzFGK0jU8HKQfVHTw7kWBB/3401FxZQXUj1ewiAA=; b=hlF6332JfLej9LJRLWg/snSc7p
        povbjSrA68GNyAFUkAonIT7X7npZNcZ0BNDosog4Gu0CYQZIlS117+wKaJ4/gxDO5sx34kHq6sKsX
        ZEf9zxvjRa4o1S9McfNVwDp5/PSR2iXwNCHky24BbCcoNodPlE6i2dnn84jEbGI4Wz9Y6QDaJvGOH
        3oZlCj9iCM2Y/E8AbtiHIOVqFLkVO7CtPQl6JaHnS/+EO3wLca8mtDF12zuOyZmey76a86jr35m7x
        HIX2+s5ewd7KHxV+8JJccLfh7lpWBypdM/4G9k89SlGf3xJIUh0a9rInjPzCE0HWFjdincdFUt8Km
        szj0UOFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oe16R-00Dcok-Aw; Thu, 29 Sep 2022 21:29:55 +0000
Date:   Thu, 29 Sep 2022 22:29:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: fix memory corruption when recording errors
 during writeback
Message-ID: <YzYOU76l/ZqhgFie@casper.infradead.org>
References: <YzXnoR0UMBVfoaOf@magnolia>
 <YzXy8lJGMRUbEdsM@casper.infradead.org>
 <YzYNtYgU1ckryg4Q@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzYNtYgU1ckryg4Q@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:27:17PM -0700, Darrick J. Wong wrote:
> On Thu, Sep 29, 2022 at 08:33:06PM +0100, Matthew Wilcox wrote:
> > On Thu, Sep 29, 2022 at 11:44:49AM -0700, Darrick J. Wong wrote:
> > > Fixes: e735c0079465 ("iomap: Convert iomap_add_to_ioend() to take a folio")
> > > Probably-Fixes: 598ecfbaa742 ("iomap: lift the xfs writeback code to iomap")
> > 
> > I think this is a misuse of Fixes.  As I understand it, Fixes: is "Here's
> > the commit that introduced the bug", not "This is the most recent change
> > after which this patch will still apply".  e735c0079465 only changed
> > s/page/folio/ in this line of code, so clearly didn't introduce the bug.
> > 
> > Any kernel containing 598ecfbaa742 has this same bug, so that should be
> > the Fixes: line.  As you say though, 598ecfbaa742 merely moved the code
> > from xfs_writepage_map().  bfce7d2e2d5e moved it from xfs_do_writepage(),
> > but 150d5be09ce4 introduced it.  Six years ago!  Good find.  So how about:
> > 
> > Fixes: 150d5be09ce4 ("xfs: remove xfs_cancel_ioend")
> 
> Sounds fine to me, though if I hear complaints from AUTOSEL about how
> the patch does not directly apply to old kernels, I'll forward them to
> you, because that's what I do now to avoid getting even /more/ email.

Well, autosel is right to complain ... there's a fix which doesn't
apply magically to every still-supported kernel containing the bug.
I'm happy to own backporting this one as far as necessary.

> > Also,
> > 
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> However, thank you for the quick review. :)
> 
> --D
> 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  fs/iomap/buffered-io.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index ca5c62901541..77d59c159248 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1421,7 +1421,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > >  	if (!count)
> > >  		folio_end_writeback(folio);
> > >  done:
> > > -	mapping_set_error(folio->mapping, error);
> > > +	mapping_set_error(inode->i_mapping, error);
> > >  	return error;
> > >  }
> > >  
