Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1344AB2FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 01:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbiBGA5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 19:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGA5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:57:32 -0500
X-Greylist: delayed 579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 16:57:30 PST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F83C06173B;
        Sun,  6 Feb 2022 16:57:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5DDB5210E3;
        Mon,  7 Feb 2022 00:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644194870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21WIIzE9YYrRqrYWxydwgJGsuLHTdcArQErbIWQkhhI=;
        b=NUSSJjR6d27Wl1sOq849qhR0qdh6M76BsfAEtFPmOTrbWS3k3gMPSFCW5GTTlFg8B4y93H
        0QYru8En+QBfAHZhuaszUZhAacBErk/OANAc+mlKXiOvbfETDdTpeUCeJnQhmxAJh+PmAb
        0UkMujG9yw2RJ7B11CCWvWyYfrbScAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644194870;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21WIIzE9YYrRqrYWxydwgJGsuLHTdcArQErbIWQkhhI=;
        b=yptlk9UG1wXG36Mnuikm2dpAH1IZs30FNZlIkD5ggUGeaEzoyPw0QPqTRfbRFVpfrnN8Ah
        sIeR46qxdk1AP+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C785F13519;
        Mon,  7 Feb 2022 00:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t6L3HzJsAGIWeAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 00:47:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fuse: remove reliance on bdi congestion
In-reply-to: <YfixwCAA0TUR7ldD@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>,
 <164360183348.4233.761031466326833349.stgit@noble.brown>,
 <YfdlbxezYSOSYmJf@casper.infradead.org>,
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>,
 <YffgKva2Dz3cTwhr@casper.infradead.org>,
 <164367002370.18996.7242801209611375112@noble.neil.brown.name>,
 <YfiUaJ59A3px+DqP@casper.infradead.org>,
 <164368611206.1660.3728723868309208734@noble.neil.brown.name>,
 <YfixwCAA0TUR7ldD@casper.infradead.org>
Date:   Mon, 07 Feb 2022 11:47:43 +1100
Message-id: <164419486336.1660.10239401483169466179@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> On Tue, Feb 01, 2022 at 02:28:32PM +1100, NeilBrown wrote:
> > On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> > > On Tue, Feb 01, 2022 at 10:00:23AM +1100, NeilBrown wrote:
> > > > I really would like to see that high-level documentation!!
> > >=20
> > > I've done my best to add documentation.  There's more than before
> > > I started.
> >=20
> > I guess it's my turn then - if I can manage to understand it.
>=20
> It always works out better when two people are interested in the
> documentation.
>=20
>=20

Please review...

From: NeilBrown <neilb@suse.de>
Subject: [PATCH] MM: document and polish read-ahead code.

Add some "big-picture" documentation for read-ahead and polish the code
to make it fit this documentation.

The meaning of ->async_size is clarified to match its name.
i.e. Any request to ->readahead() has a sync part and an async part.
The caller will wait for the sync pages to complete, but will not wait
for the async pages.  The first async page is still marked PG_readahead

- When ->readhead does not consume all pages, any remaining async pages
  are now discarded with delete_from_page_cache().  This make it
  possible for the filesystem to delay readahead due e.g. to congestion.
- in try_context_readahead(), the async_sync is set correctly rather
  than being set to 1.  Prior to Commit 2cad40180197 ("readahead: make
  context readahead more conservative") it was set to ra->size which
  is not correct (that implies no sync component).  As this was too
  high and caused problems it was reduced to 1, again incorrect but less
  problematic.  The setting provided with this patch does not restore
  those problems, and is now not arbitrary.
- The calculation of ->async_size in the initial_readahead section of
  ondemand_readahead() now makes sense - it is zero if the chosen
  size does not exceed the requested size.  This means that we will not
  set the PG_readahead flag in this case, but as the requested size
  has not been satisfied we can expect a subsequent read ahead request
  any way.

Note that the current function names page_cache_sync_ra() and
page_cache_async_ra() are misleading.  All ra request are partly sync
and partly async, so either part can be empty.
A page_cache_sync_ra() request will usually set ->async_size non-zero,
implying it is not all synchronous.
When a non-zero req_count is passed to page_cache_async_ra(), the
implication is that some prefix of the request is synchronous, though
the calculation made there is incorrect - I haven't tried to fix it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/readahead.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index cf0dcf89eb69..5676f5c1aa39 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -8,6 +8,105 @@
  *		Initial version.
  */
=20
+/**
+ * Readahead is used to read content into the page cache before it is
+ * explicitly requested by the application.  Readahead only ever
+ * attempts to read pages which are not yet in the page cache.  If a
+ * page is present but not up-to-date, readahead will not try to read
+ * it. In that case a simple ->readpage() will be requested.
+ *
+ * Readahead is triggered when an application read request (whether a
+ * systemcall or a page fault) finds that the requested page is not in
+ * the page cache, or that it is in the page cache and has the
+ * PG_readahead flag set.  This flag indicates that the page was loaded
+ * as part of a previous read-ahead request and now that it has been
+ * accessed, it is time for the next read-ahead.
+ *
+ * Each readahead request is partly synchronous read, and partly async
+ * read-ahead.  This is reflected in the struct file_ra_state which
+ * contains ->size being to total number of pages, and ->async_size
+ * which is the number of pages in the async section.  The first page in
+ * this async section will have PG_readahead set as a trigger for a
+ * subsequent read ahead.  Once a series of sequential reads has been
+ * established, there should be no need for a synchronous component and
+ * all read ahead request will be fully asynchronous.
+ *
+ * When either of the triggers causes a readahead, three numbers need to
+ * be determined: the start of the region, the size of the region, and
+ * the size of the async tail.
+ *
+ * The start of the region is simply the first page address at or after
+ * the accessed address, which is not currently populated in the page
+ * cache.  This is found with a simple search in the page cache.
+ *
+ * The size of the async tail is determined by subtracting the size that
+ * was explicitly requested from the determined request size, unless
+ * this would be less than zero - then zero is used.  NOTE THIS
+ * CALCULATION IS WRONG WHEN THE START OF THE REGION IS NOT THE ACCESSED
+ * PAGE.
+ *
+ * The size of the region is normally determined from the size of the
+ * previous readahead which loaded the preceding pages.  This may be
+ * discovered from the struct file_ra_state for simple sequential reads,
+ * or from examining the state of the page cache when multiple
+ * sequential reads are interleaved.  Specifically: where the readahead
+ * was triggered by the PG_readahead flag, the size of the previous
+ * readahead is assumed to be the number of pages from the triggering
+ * page to the start of the new readahead.  In these cases, the size of
+ * the previous readahead is scaled, often doubled, for the new
+ * readahead, though see get_next_ra_size() for details.
+ *
+ * If the size of the previous read cannot be determined, the number of
+ * preceding pages in the page cache is used to estimate the size of
+ * a previous read.  This estimate could easily be misled by random
+ * reads being coincidentally adjacent, so it is ignored unless it is
+ * larger than the current request, and it is not scaled up, unless it
+ * is at the start of file.
+ *
+ * In generally read ahead is accelerated at the start of the file, as
+ * reads from there are often sequential.  There are other minor
+ * adjustments to the read ahead size in various special cases and these
+ * are best discovered by reading the code.
+ *
+ * The above calculation determine the readahead, to which any requested
+ * read size may be added.
+ *
+ * Readahead requests are sent to the filesystem using the ->readahead
+ * address space operation, for which mpage_readahead() is a canonical
+ * implementation.  ->readahead() should normally initiate reads on all
+ * pages, but may fail to read any or all pages without causing an IO
+ * error.  The page cache reading code will issue a ->readpage() request
+ * for any page which ->readahead() does not provided, and only an error
+ * from this will be final.
+ *
+ * ->readahead will generally call readahead_page() repeatedly to get
+ * each page from those prepared for read ahead.  It may fail to read a
+ * page by:
+ *  - not calling readahead_page() sufficiently many times, effectively
+ *    ignoring some pages, as might be appropriate if the path to
+ *    storage is congested.
+ *  - failing to actually submit a read request for a given page,
+ *    possibly due to insufficient resources, or
+ *  - getting an error during subsequent processing of a request.
+ * In the last two cases, the page should be unlocked to indicate that
+ * the read attempt has failed.  In the first case the page will be
+ * unlocked by the caller.
+ *
+ * Those pages not in the final ``async_size`` of the request should be
+ * considered to be important and ->readahead() should not fail them due
+ * to congestion or temporary resource unavailability, but should wait
+ * for necessary resources (e.g.  memory or indexing information) to
+ * become available.  Pages in the final ``async_size`` may be
+ * considered less urgent and failure to read them is more acceptable.
+ * In this case it best to use delete_from_page_cache() to remove the
+ * pages from the page cache as is automatically done for pages that
+ * were not fetched with readahead_page().  This will allow a
+ * subsequent synchronous read ahead request to try them again.  If they
+ * are left in the page cache, then they will be read individually using
+ * ->readpage().
+ *
+ */
+
 #include <linux/kernel.h>
 #include <linux/dax.h>
 #include <linux/gfp.h>
@@ -129,6 +228,8 @@ static void read_pages(struct readahead_control *rac, str=
uct list_head *pages,
 		aops->readahead(rac);
 		/* Clean up the remaining pages */
 		while ((page =3D readahead_page(rac))) {
+			if (rac->ra->async_pages >=3D readahead_count(rac))
+				delete_from_page_cache(page);
 			unlock_page(page);
 			put_page(page);
 		}
@@ -426,7 +527,7 @@ static int try_context_readahead(struct address_space *ma=
pping,
=20
 	ra->start =3D index;
 	ra->size =3D min(size + req_size, max);
-	ra->async_size =3D 1;
+	ra->async_size =3D ra->size - req_size;
=20
 	return 1;
 }
@@ -527,7 +628,7 @@ static void ondemand_readahead(struct readahead_control *=
ractl,
 initial_readahead:
 	ra->start =3D index;
 	ra->size =3D get_init_ra_size(req_size, max_pages);
-	ra->async_size =3D ra->size > req_size ? ra->size - req_size : ra->size;
+	ra->async_size =3D ra->size > req_size ? ra->size - req_size : 0;
=20
 readit:
 	/*
--=20
2.35.1

