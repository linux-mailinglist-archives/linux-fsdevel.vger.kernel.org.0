Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3594C242284
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgHKWbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 18:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKWbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:31:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF2FC06174A;
        Tue, 11 Aug 2020 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A/hI0S7gtfY9mSqdqK890h1+rXEGA4FIpXNQ4i01M7A=; b=vf/VQwYxBp8OzecyfjMKdWCA6T
        94Ol3tP5mE7Ye/rYCnB04ZCtg6XfRJMbQ9SX+tjnde21FkKvP+7QT2v7USa/yrubVjDhMZBun0s1V
        XzolBzCpqOh5HFrqeLsWK7sCpUCghykfM6N6bCJX8+n9IPMpOrV3twyzv32tzlmOFuXZhv0OE6W6J
        rvMVjItojIO0e2bSLVo9PUCGaTRaWMm8tMdwaPwbsK3eSScTGP5/5uPN/j5rvtOLrflrdgMFqOtm7
        lBvSSMK5/dPKiorh0C8IEgKbnAVsQIBDax9IcdKACpHAZpMMeyHvJ/XVF7zYYSlhJ6qHGcls6YWxG
        J4smetkA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5cnc-000626-Th; Tue, 11 Aug 2020 22:31:17 +0000
Date:   Tue, 11 Aug 2020 23:31:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: Convert readahead to iomap_iter
Message-ID: <20200811223116.GY17456@casper.infradead.org>
References: <20200728173216.7184-1-willy@infradead.org>
 <20200728173216.7184-3-willy@infradead.org>
 <20200811205314.GF6107@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811205314.GF6107@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:56:13PM -0700, Darrick J. Wong wrote:
> > @@ -625,7 +625,14 @@ STATIC void
> >  xfs_vm_readahead(
> >  	struct readahead_control	*rac)
> >  {
> > -	iomap_readahead(rac, &xfs_read_iomap_ops);
> > +	IOMAP_ITER(iomi, rac->mapping->host, readahead_pos(rac),
> > +			readahead_length(rac), 0);
> > +	struct iomap_readpage_ctx ctx = {
> > +		.rac = rac,
> > +	};
> > +
> > +	while (iomap_iter(&iomi, xfs_iomap_next_read))
> > +		iomi.copied = iomap_readahead(&iomi, &ctx);
> 
> Why not have iomap_readahead set iomi.copied on its way out?  The actor
> function is supposed to set iomi.ret if an error happens, right?

I actually wanted to make iomap_readahead take a const pointer.
This should do the trick.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fff23ed6a682..3ca128a3b044 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -377,7 +377,8 @@ EXPORT_SYMBOL_GPL(iomap_readpage);
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-loff_t iomap_readahead(struct iomap_iter *iomi, struct iomap_readpage_ctx *ctx)
+loff_t iomap_readahead(const struct iomap_iter *iomi,
+		struct iomap *iomap, struct iomap_readpage_ctx *ctx)
 {
 	loff_t done, ret, length = iomap_length(iomi);
 
@@ -393,8 +394,7 @@ loff_t iomap_readahead(struct iomap_iter *iomi, struct iomap_readpage_ctx *ctx)
 			ctx->cur_page_in_bio = false;
 		}
 		ret = iomap_readpage_actor(iomi->inode, iomi->pos + done,
-				length - done, ctx,
-				&iomi->iomap, &iomi->srcmap);
+				length - done, ctx, iomap, NULL);
 	}
 
 	if (iomi->len == done) {
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2884752e40e8..62777daefe94 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -632,7 +632,7 @@ xfs_vm_readahead(
 	};
 
 	while (iomap_iter(&iomi, xfs_iomap_next_read))
-		iomi.copied = iomap_readahead(&iomi, &ctx);
+		iomi.copied = iomap_readahead(&iomi, &iomi.iomap, &ctx);
 }
 
 static int
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 4842b85ce36d..6ae51bf1d77c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -99,7 +99,7 @@ static void zonefs_readahead(struct readahead_control *rac)
 	};
 
 	while (iomap_iter(&iomi, zonefs_iomap_next))
-		iomi.copied = iomap_readahead(&iomi, &ctx);
+		iomi.copied = iomap_readahead(&iomi, &iomi.iomap, &ctx);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index dd9bfed85c4f..11a104129a04 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -305,7 +305,8 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-loff_t iomap_readahead(struct iomap_iter *, struct iomap_readpage_ctx *);
+loff_t iomap_readahead(const struct iomap_iter *, struct iomap *,
+		struct iomap_readpage_ctx *);
 
 /*
  * Flags for direct I/O ->end_io:

> Oh wait no, the actor function returns a positive copied value, or a
> negative error code, and then it's up to the _next_read function to
> notice if copied is negative, stuff it in ret, and then return false to
> stop the iteration?

I want to handle all the changes to iomap_iter in iomap_iter() and
iomi_advance() so people writing new things that use iomap_iter don't
need to think about what they should modify.  Just return the error;
done.

One of the more convoluted bits of this is making sure that both the
filesystem and the body of the loop get the chance to clean up their state
if the other encounters an error.  So if 'copied' is set to an errno by
the body, then we call next() anyway (and stop the iteration).  And if
next() returns an error, we iterate the body once more.  We'll still
call next() again even if it did return an error, because it might not
have realised that returning a completely bogus iomap was an error.

> > +int
> > +xfs_iomap_next_read(
> > +	const struct iomap_iter *iomi,
> > +	struct iomap		*iomap,
> > +	struct iomap		*srcmap)
> 
> Aren't these last two parameters already in the iomap iter?
> Are they passed separately to work around the pointer being const?

Exactly.

> > +{
> > +	if (iomi->copied < 0)
> > +		return iomi->copied;
> 
> Is this boilerplate going to end up in every single iomap_next_t
> function?  If so, it should probably just go in iomap_iter prior to the
> next() call, right?

This is to give the next_t the opportunity to clean up after itself.
ie it's for the things currently done in ->iomap_end().  So when we
replace xfs_buffered_write_iomap_ops, you'll see it used then.

> > +	if (iomi->copied >= iomi->len)
> > +		return 0;
> 
> Er... if we copied more than we asked for, doesn't that imply something
> bad just happened?

erm ... maybe?  We don't currently sanity-check the return value from
actor() in iomap_apply().  Perhaps we should?

> > +
> > +	return xfs_read_iomap_begin(iomi->inode, iomi->pos + iomi->copied,
> > +			iomi->len - iomi->copied, iomi->flags, iomap, srcmap);
> 
> Would be kinda nice if you could just pass the whole iomap_iter, but I
> get that we're probably stuck with this until the entirety gets
> converted.

Yeah.  I could probably do it the other way round where
xfs_read_iomap_begin() constructs an iomap_iter on the stack and passes
it to xfs_read_iomap_begin().  I don't think it makes much difference.
