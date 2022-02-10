Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FF4B0541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiBJFiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 00:38:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiBJFis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:38:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9BE10CC;
        Wed,  9 Feb 2022 21:38:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F43B1F43D;
        Thu, 10 Feb 2022 05:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644471521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7aE0+LlADxoj0n+pYZhcga519vLh1NoOx460Fc9AvBM=;
        b=gjiQtnWj3gwutTC82abaAAb6TpRtme4XE3VzgJRnTJo367Csp4nU4sp/zOzMuxF2vyxuYH
        qBDgcUWHf9SmGXGwtBRaUd/Db06ZIsUA2pAdPV9oGRWhjgrjoIfX3WKpUWNFiS5/kOfRPg
        62YIItdK6Zp4r7xUPxNHYjSo2qYyMXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644471521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7aE0+LlADxoj0n+pYZhcga519vLh1NoOx460Fc9AvBM=;
        b=RO4W8dsgO64LRCac/vnEwU5jyhGcw5V+VnvGizNSElDuy7noN1dIWaybuz55SPaB/z+Gi0
        rvFlNtdRVRO/jpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41CC213519;
        Thu, 10 Feb 2022 05:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vBtLO9ikBGK5OAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 10 Feb 2022 05:38:32 +0000
Subject: [PATCH 02/11] MM: document and polish read-ahead code.
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Thu, 10 Feb 2022 16:37:52 +1100
Message-ID: <164447147257.23354.2801426518649016278.stgit@noble.brown>
In-Reply-To: <164447124918.23354.17858831070003318849.stgit@noble.brown>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some "big-picture" documentation for read-ahead and polish the code
to make it fit this documentation.

The meaning of ->async_size is clarified to match its name.
i.e. Any request to ->readahead() has a sync part and an async part.
The caller will wait for the sync pages to complete, but will not wait
for the async pages.  The first async page is still marked PG_readahead

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
 Documentation/core-api/mm-api.rst |   19 ++++++-
 Documentation/filesystems/vfs.rst |   16 ++++--
 include/linux/fs.h                |    9 +++
 mm/readahead.c                    |  103 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 135 insertions(+), 12 deletions(-)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 395835f9289f..f5b2f92822c8 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -58,15 +58,30 @@ Virtually Contiguous Mappings
 File Mapping and Page Cache
 ===========================
 
-.. kernel-doc:: mm/readahead.c
-   :export:
+Filemap
+-------
 
 .. kernel-doc:: mm/filemap.c
    :export:
 
+Readahead
+---------
+
+.. kernel-doc:: mm/readahead.c
+   :doc: Readahead Overview
+
+.. kernel-doc:: mm/readahead.c
+   :export:
+
+Writeback
+---------
+
 .. kernel-doc:: mm/page-writeback.c
    :export:
 
+Truncate
+--------
+
 .. kernel-doc:: mm/truncate.c
    :export:
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index bf5c48066fac..b4a0baa46dcc 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -806,12 +806,16 @@ cache in your filesystem.  The following members are defined:
 	object.  The pages are consecutive in the page cache and are
 	locked.  The implementation should decrement the page refcount
 	after starting I/O on each page.  Usually the page will be
-	unlocked by the I/O completion handler.  If the filesystem decides
-	to stop attempting I/O before reaching the end of the readahead
-	window, it can simply return.  The caller will decrement the page
-	refcount and unlock the remaining pages for you.  Set PageUptodate
-	if the I/O completes successfully.  Setting PageError on any page
-	will be ignored; simply unlock the page if an I/O error occurs.
+	unlocked by the I/O completion handler.  The set of pages are
+	divided into some sync pages followed by some async pages,
+	rac->ra->async_size gives the number of async pages.  The
+	filesystem should attempt to read all sync pages but may decide
+	to stop once it reaches the async pages.  If it does decide to
+	stop attempting I/O, it can simply return.  The caller will
+	remove the remaining pages from the address space, unlock them
+	and decrement the page refcount.  Set PageUptodate if the I/O
+	completes successfully.  Setting PageError on any page will be
+	ignored; simply unlock the page if an I/O error occurs.
 
 ``readpages``
 	called by the VM to read pages associated with the address_space
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..8b5c486bd4a2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -930,10 +930,15 @@ struct fown_struct {
  * struct file_ra_state - Track a file's readahead state.
  * @start: Where the most recent readahead started.
  * @size: Number of pages read in the most recent readahead.
- * @async_size: Start next readahead when this many pages are left.
- * @ra_pages: Maximum size of a readahead request.
+ * @async_size: Numer of pages that were/are not needed immediately
+ *      and so were/are genuinely "ahead".  Start next readahead when
+ *      the first of these pages is accessed.
+ * @ra_pages: Maximum size of a readahead request, copied from the bdi.
  * @mmap_miss: How many mmap accesses missed in the page cache.
  * @prev_pos: The last byte in the most recent read request.
+ *
+ * When this structure is passed to ->readahead(), the "most recent"
+ * readahead means the current readahead.
  */
 struct file_ra_state {
 	pgoff_t start;
diff --git a/mm/readahead.c b/mm/readahead.c
index cf0dcf89eb69..c44b2957f59f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -8,6 +8,105 @@
  *		Initial version.
  */
 
+/**
+ * DOC: Readahead Overview
+ *
+ * Readahead is used to read content into the page cache before it is
+ * explicitly requested by the application.  Readahead only ever
+ * attempts to read pages that are not yet in the page cache.  If a
+ * page is present but not up-to-date, readahead will not try to read
+ * it. In that case a simple ->readpage() will be requested.
+ *
+ * Readahead is triggered when an application read request (whether a
+ * systemcall or a page fault) finds that the requested page is not in
+ * the page cache, or that it is in the page cache and has the
+ * %PG_readahead flag set.  This flag indicates that the page was loaded
+ * as part of a previous read-ahead request and now that it has been
+ * accessed, it is time for the next read-ahead.
+ *
+ * Each readahead request is partly synchronous read, and partly async
+ * read-ahead.  This is reflected in the struct file_ra_state which
+ * contains ->size being to total number of pages, and ->async_size
+ * which is the number of pages in the async section.  The first page in
+ * this async section will have %PG_readahead set as a trigger for a
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
+ * was triggered by the %PG_readahead flag, the size of the previous
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
+ * In general read ahead is accelerated at the start of the file, as
+ * reads from there are often sequential.  There are other minor
+ * adjustments to the read ahead size in various special cases and these
+ * are best discovered by reading the code.
+ *
+ * The above calculation determines the readahead, to which any requested
+ * read size may be added.
+ *
+ * Readahead requests are sent to the filesystem using the ->readahead()
+ * address space operation, for which mpage_readahead() is a canonical
+ * implementation.  ->readahead() should normally initiate reads on all
+ * pages, but may fail to read any or all pages without causing an IO
+ * error.  The page cache reading code will issue a ->readpage() request
+ * for any page which ->readahead() does not provided, and only an error
+ * from this will be final.
+ *
+ * ->readahead() will generally call readahead_page() repeatedly to get
+ * each page from those prepared for read ahead.  It may fail to read a
+ * page by:
+ *
+ * * not calling readahead_page() sufficiently many times, effectively
+ *   ignoring some pages, as might be appropriate if the path to
+ *   storage is congested.
+ *
+ * * failing to actually submit a read request for a given page,
+ *   possibly due to insufficient resources, or
+ *
+ * * getting an error during subsequent processing of a request.
+ *
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
+ * They will eventually be read individually using ->readpage().
+ */
+
 #include <linux/kernel.h>
 #include <linux/dax.h>
 #include <linux/gfp.h>
@@ -426,7 +525,7 @@ static int try_context_readahead(struct address_space *mapping,
 
 	ra->start = index;
 	ra->size = min(size + req_size, max);
-	ra->async_size = 1;
+	ra->async_size = ra->size - req_size;
 
 	return 1;
 }
@@ -527,7 +626,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 initial_readahead:
 	ra->start = index;
 	ra->size = get_init_ra_size(req_size, max_pages);
-	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
+	ra->async_size = ra->size > req_size ? ra->size - req_size : 0;
 
 readit:
 	/*


