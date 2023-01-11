Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC16A6663CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 20:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAKTgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 14:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjAKTgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:36:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B431B1F5;
        Wed, 11 Jan 2023 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4DMvLtDPlSliteCx6qFn8oz8SfGuJcvsaDoB1yob6PA=; b=cxz5grnAiBegZwKe0//f0g0OKX
        4gkmIH7NF8YsMltcQct079FMOE4/4zG/TKFYq6Bctmj/ogBBPuXAxNJOPA+/WLVSsLbgsHTVUDBb0
        Kea/apmkOYXwk0+Zc3i/s9Zea37pYGD0bE4j6bFXi7XlLmYbFFGXZKUyNJMpigUzwhUV5xKbx3hvp
        kAHb9GyC3+jWs5/u9RVmwLywaATyRfF17qpjCN25ocOZtmzyPYZa9DkkkNoQ1b3udzX1FqZjvKb7u
        k4GgEvqUkdVFS0MnU+u2C8B4vTpSFMlVwFnACST/nCW/IWrLD4sqpBZLyouUQYiHYLC2lpUXW/8go
        AN5hL5Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFgte-004Pul-4L; Wed, 11 Jan 2023 19:36:26 +0000
Date:   Wed, 11 Jan 2023 19:36:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y78PunroeYbv2qgH@casper.infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
 <Y72DK9XuaJfN+ecj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y72DK9XuaJfN+ecj@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:24:27AM -0800, Christoph Hellwig wrote:
> On Tue, Jan 10, 2023 at 01:34:16PM +0000, Matthew Wilcox wrote:
> > > Exactly.  And as I already pointed out in reply to Dave's original
> > > patch what we really should be doing is returning an ERR_PTR from
> > > __filemap_get_folio instead of reverse-engineering the expected
> > > error code.
> > 
> > Ouch, we have a nasty problem.
> > 
> > If somebody passes FGP_ENTRY, we can return a shadow entry.  And the
> > encodings for shadow entries overlap with the encodings for ERR_PTR,
> > meaning that some shadow entries will look like errors.  The way I
> > solved this in the XArray code is by shifting the error values by
> > two bits and encoding errors as XA_ERROR(-ENOMEM) (for example).
> > 
> > I don't _object_ to introducing XA_ERROR() / xa_err() into the VFS,
> > but so far we haven't, and I'd like to make that decision intentionally.
> 
> So what would be an alternative way to tell the callers why no folio
> was found instead of trying to reverse engineer that?  Return an errno
> and the folio by reference?  The would work, but the calling conventions
> would be awful.

Agreed.  How about an xa_filemap_get_folio()?

(there are a number of things to fix here; haven't decided if XA_ERROR
should return void *, or whether i should use a separate 'entry' and
'folio' until I know the entry is actually a folio ...)

Usage would seem pretty straightforward:

	folio = xa_filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
			fgp, mapping_gfp_mask(iter->inode->i_mapping));
	status = xa_err(folio);
	if (status)
		goto out_no_page;

diff --git a/mm/filemap.c b/mm/filemap.c
index 7bf8442bcfaa..7d489f96c690 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1800,40 +1800,25 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * xa_filemap_get_folio - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
  *
- * Looks up the page cache entry at @mapping & @index.
- *
- * @fgp_flags can be zero or more of these flags:
- *
- * * %FGP_ACCESSED - The folio will be marked accessed.
- * * %FGP_LOCK - The folio is returned locked.
- * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
- *   instead of allocating a new folio to replace it.
- * * %FGP_CREAT - If no page is present then a new page is allocated using
- *   @gfp and added to the page cache and the VM's LRU list.
- *   The page is returned locked and with an increased refcount.
- * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
- *   page is already in cache.  If the page was allocated, unlock it before
- *   returning so the caller can do the same dance.
- * * %FGP_WRITE - The page will be written to by the caller.
- * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
- * * %FGP_NOWAIT - Don't get blocked by page lock.
- * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
- *
- * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
- * if the %GFP flags specified for %FGP_CREAT are atomic.
+ * Looks up the page cache entry at @mapping & @index.  See
+ * __filemap_get_folio() for a detailed description.
  *
- * If there is a page cache page, it is returned with an increased refcount.
+ * This differs from __filemap_get_folio() in that it will return an
+ * XArray error instead of NULL if something goes wrong, allowing the
+ * advanced user to distinguish why the failure happened.  We can't use an
+ * ERR_PTR() because its encodings overlap with shadow/swap/dax entries.
  *
- * Return: The found folio or %NULL otherwise.
+ * Return: The entry in the page cache or an xa_err() if there is no entry
+ * or it could not be appropiately locked.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp)
+struct folio *xa_filemap_get_folio(struct address_space *mapping,
+		pgoff_t index, int fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
 
@@ -1851,7 +1836,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		if (fgp_flags & FGP_NOWAIT) {
 			if (!folio_trylock(folio)) {
 				folio_put(folio);
-				return NULL;
+				return (struct folio *)XA_ERROR(-EAGAIN);
 			}
 		} else {
 			folio_lock(folio);
@@ -1890,7 +1875,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		folio = filemap_alloc_folio(gfp, 0);
 		if (!folio)
-			return NULL;
+			return (struct folio *)XA_ERROR(-ENOMEM);
 
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
@@ -1902,19 +1887,65 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		err = filemap_add_folio(mapping, folio, index, gfp);
 		if (unlikely(err)) {
 			folio_put(folio);
-			folio = NULL;
 			if (err == -EEXIST)
 				goto repeat;
+			folio = (struct folio *)XA_ERROR(err);
+		} else {
+			/*
+			 * filemap_add_folio locks the page, and for mmap
+			 * we expect an unlocked page.
+			 */
+			if (fgp_flags & FGP_FOR_MMAP)
+				folio_unlock(folio);
 		}
-
-		/*
-		 * filemap_add_folio locks the page, and for mmap
-		 * we expect an unlocked page.
-		 */
-		if (folio && (fgp_flags & FGP_FOR_MMAP))
-			folio_unlock(folio);
 	}
 
+	if (!folio)
+		folio = (struct folio *)XA_ERROR(-ENODATA);
+	return folio;
+}
+EXPORT_SYMBOL_GPL(xa_filemap_get_folio);
+
+/**
+ * __filemap_get_folio - Find and get a reference to a folio.
+ * @mapping: The address_space to search.
+ * @index: The page index.
+ * @fgp: %FGP flags modify how the folio is returned.
+ * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ *
+ * Looks up the page cache entry at @mapping & @index.
+ *
+ * @fgp_flags can be zero or more of these flags:
+ *
+ * * %FGP_ACCESSED - The folio will be marked accessed.
+ * * %FGP_LOCK - The folio is returned locked.
+ * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
+ *   instead of allocating a new folio to replace it.
+ * * %FGP_CREAT - If no page is present then a new page is allocated using
+ *   @gfp and added to the page cache and the VM's LRU list.
+ *   The page is returned locked and with an increased refcount.
+ * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
+ *   page is already in cache.  If the page was allocated, unlock it before
+ *   returning so the caller can do the same dance.
+ * * %FGP_WRITE - The page will be written to by the caller.
+ * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
+ * * %FGP_NOWAIT - Don't get blocked by page lock.
+ * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ *
+ * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
+ * if the %GFP flags specified for %FGP_CREAT are atomic.
+ *
+ * If there is a page cache page, it is returned with an increased refcount.
+ *
+ * Return: The found folio or %NULL otherwise.
+ */
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		int fgp, gfp_t gfp)
+{
+	struct folio *folio = xa_filemap_get_folio(mapping, index, fgp, gfp);
+
+	if (xa_is_err(folio))
+		return NULL;
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
