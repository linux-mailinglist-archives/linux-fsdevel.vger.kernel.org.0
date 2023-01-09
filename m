Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F96625D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 13:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAIMvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 07:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjAIMuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32925B487
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 04:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673268411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swjuNQ/i0Y/kXuzGWDfuHdb2fSh/vC4jMIjMsr1R+fQ=;
        b=YWbky0IOZVhK8bxsR2zeYGT2xzWcs4qjX8NH14YqvWKsqYllBbYz1KMqnBegmHW3yEQWVd
        MPgw2fF43XdhIL9cJUgOarKTEyVTIeh1NRmfdTWi4Rgr4IaeqE4xM7PcHJhCZYQQUyIz+r
        BZ6GmIebDJj+mOfvxRpGSvVs9QTIAhU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-_1ny9MyEP1qNP0EdbYiIug-1; Mon, 09 Jan 2023 07:46:46 -0500
X-MC-Unique: _1ny9MyEP1qNP0EdbYiIug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E73DF1C0754F;
        Mon,  9 Jan 2023 12:46:45 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2923C2166B26;
        Mon,  9 Jan 2023 12:46:42 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Date:   Mon,  9 Jan 2023 13:46:42 +0100
Message-Id: <20230109124642.1663842-1-agruenba@redhat.com>
In-Reply-To: <20230108213305.GO1971568@dread.disaster.area>
References: <20230108213305.GO1971568@dread.disaster.area> <20230108194034.1444764-1-agruenba@redhat.com> <20230108194034.1444764-5-agruenba@redhat.com> 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 8, 2023 at 10:33 PM Dave Chinner <david@fromorbit.com> wrote:
> On Sun, Jan 08, 2023 at 08:40:28PM +0100, Andreas Gruenbacher wrote:
> > Add an iomap_get_folio() helper that gets a folio reference based on
> > an iomap iterator and an offset into the address space.  Use it in
> > iomap_write_begin().
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++++++++++---------
> >  include/linux/iomap.h  |  1 +
> >  2 files changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d4b444e44861..de4a8e5f721a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -457,6 +457,33 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
> >
> > +/**
> > + * iomap_get_folio - get a folio reference for writing
> > + * @iter: iteration structure
> > + * @pos: start offset of write
> > + *
> > + * Returns a locked reference to the folio at @pos, or an error pointer if the
> > + * folio could not be obtained.
> > + */
> > +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> > +{
> > +     unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
> > +     struct folio *folio;
> > +
> > +     if (iter->flags & IOMAP_NOWAIT)
> > +             fgp |= FGP_NOWAIT;
> > +
> > +     folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> > +                     fgp, mapping_gfp_mask(iter->inode->i_mapping));
> > +     if (folio)
> > +             return folio;
> > +
> > +     if (iter->flags & IOMAP_NOWAIT)
> > +             return ERR_PTR(-EAGAIN);
> > +     return ERR_PTR(-ENOMEM);
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_get_folio);
>
> Hmmmm.
>
> This is where things start to get complex. I have sent a patch to
> fix a problem with iomap_zero_range() failing to zero cached dirty
> pages over UNWRITTEN extents, and that requires making FGP_CREAT
> optional. This is an iomap bug, and needs to be fixed in the core
> iomap code:
>
> https://lore.kernel.org/linux-xfs/20221201005214.3836105-1-david@fromorbit.com/
>
> Essentially, we need to pass fgp flags to iomap_write_begin() need
> so the callers can supply a 0 or FGP_CREAT appropriately. This
> allows iomap_write_begin() to act only on pre-cached pages rather
> than always instantiating a new page if one does not exist in cache.
>
> This allows that iomap_write_begin() to return a NULL folio
> successfully, and this is perfectly OK for callers that pass in fgp
> = 0 as they are expected to handle a NULL folio return indicating
> there was no cached data over the range...
>
> Exposing the folio allocation as an external interface makes bug
> fixes like this rather messy - it's taking a core abstraction (iomap
> hides all the folio and page cache manipulations from the
> filesystem) and punching a big hole in it by requiring filesystems
> to actually allocation page cache folios on behalf of the iomap
> core.
>
> Given that I recently got major push-back for fixing an XFS-only bug
> by walking the page cache directly instead of abstracting it via the
> iomap core, punching an even bigger hole in the abstraction layer to
> fix a GFS2-only problem is just as bad....

We can handle that by adding a new IOMAP_NOCREATE iterator flag and
checking for that in iomap_get_folio().  Your patch then turns into
the below.

Thanks,
Andreas

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dacc7c80b20d..34b335a89527 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -470,6 +470,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
 	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
 	struct folio *folio;
 
+	if (!(iter->flags & IOMAP_NOCREATE))
+		fgp |= FGP_CREAT;
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
 
@@ -478,6 +480,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
 	if (folio)
 		return folio;
 
+	if (iter->flags & IOMAP_NOCREATE)
+		return ERR_PTR(-ENODATA);
 	if (iter->flags & IOMAP_NOWAIT)
 		return ERR_PTR(-EAGAIN);
 	return ERR_PTR(-ENOMEM);
@@ -1162,8 +1166,12 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	loff_t written = 0;
 
 	/* already zeroed?  we're done. */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (srcmap->type == IOMAP_HOLE)
 		return length;
+	/* only do page cache lookups over unwritten extents */
+	iter->flags &= ~IOMAP_NOCREATE;
+	if (srcmap->type == IOMAP_UNWRITTEN)
+		iter->flags |= IOMAP_NOCREATE;
 
 	do {
 		struct folio *folio;
@@ -1172,8 +1180,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		size_t bytes = min_t(u64, SIZE_MAX, length);
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (status)
+		if (status) {
+			if (status == -ENODATA) {
+				/*
+				 * No folio was found, so skip to the start of
+				 * the next potential entry in the page cache
+				 * and continue from there.
+				 */
+				if (bytes > PAGE_SIZE - offset_in_page(pos))
+					bytes = PAGE_SIZE - offset_in_page(pos);
+				goto loop_continue;
+			}
 			return status;
+		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
@@ -1181,6 +1200,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
 
+		/*
+		 * If the folio over an unwritten extent is clean, then we
+		 * aren't going to touch the data in it at all. We don't want to
+		 * mark it dirty or change the uptodate state of data in the
+		 * page, so we just unlock it and skip to the next range over
+		 * the unwritten extent we need to check.
+		 */
+		if (srcmap->type == IOMAP_UNWRITTEN &&
+		    !folio_test_dirty(folio)) {
+			folio_unlock(folio);
+			goto loop_continue;
+		}
+
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
@@ -1188,6 +1220,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
+loop_continue:
 		pos += bytes;
 		length -= bytes;
 		written += bytes;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 515318dfbc38..87b9d9aba4bb 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -841,17 +841,7 @@ xfs_setattr_size(
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
 		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
 				&did_zeroing);
-	} else {
-		/*
-		 * iomap won't detect a dirty page over an unwritten block (or a
-		 * cow block over a hole) and subsequently skips zeroing the
-		 * newly post-EOF portion of the page. Flush the new EOF to
-		 * convert the block before the pagecache truncate.
-		 */
-		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
-						     newsize);
-		if (error)
-			return error;
+	} else if (newsize != oldsize) {
 		error = xfs_truncate_page(ip, newsize, &did_zeroing);
 	}
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3e6c34b03c89..55f195866f00 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -164,6 +164,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_NOCREATE		(1 << 9) /* look up folios without FGP_CREAT */
 
 struct iomap_ops {
 	/*
-- 
2.38.1

