Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6B40F010
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 05:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbhIQDBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 23:01:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243237AbhIQDBi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:01:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB335223BE;
        Fri, 17 Sep 2021 03:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631847615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOYRJb9fJ+cMO6Hj0cgeXpg6pQoK6BH8BG5fqFk6i+M=;
        b=TRc7wKqSyLeB/iEALRI6D6YqRSG6iz+Dq+XLvWC0q61avt5RPD6l5eo+J9e2cm0RAlLndG
        bCR/i4dYjEnf68mBhKdVP1g+5WyLBU137hqqn9pFB7hOY9jQh9U2O/3XagwE7D9w6IZHhX
        bB+fyY7lriilGsSaYPwQeJPgnfg1Glk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631847615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOYRJb9fJ+cMO6Hj0cgeXpg6pQoK6BH8BG5fqFk6i+M=;
        b=/lq6dz70EAyTVlxTdVKlR4Bn0HQwVD6XFi1dN/9iHfYMXcFuYHWhp0rAc/wmbsX9/3XzPy
        3BMcXfR/dH2dKDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 732FE13D0B;
        Fri, 17 Sep 2021 03:00:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X8J7DLsERGHIMwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Sep 2021 03:00:11 +0000
Subject: [PATCH 6/6] XFS: remove congestion_wait() loop from
 xfs_buf_alloc_pages()
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Fri, 17 Sep 2021 12:56:57 +1000
Message-ID: <163184741782.29351.3052773526186670351.stgit@noble.brown>
In-Reply-To: <163184698512.29351.4735492251524335974.stgit@noble.brown>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Documentation commment in gfp.h discourages indefinite retry loops on
ENOMEM and says of __GFP_NOFAIL that it

    is definitely preferable to use the flag rather than opencode
    endless loop around allocator.

congestion_wait() is indistinguishable from
schedule_timeout_uninterruptible() in practice and it is not a good way
to wait for memory to become available.

So add __GFP_NOFAIL to gfp if failure is not an option, and remove the
congestion_wait().  We now only loop when failure is an option, and
alloc_bulk_pages_array() made some progres, but not enough.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/xfs/xfs_buf.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 5fa6cd947dd4..b19ab52c551b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -352,7 +352,7 @@ xfs_buf_alloc_pages(
 	if (flags & XBF_READ_AHEAD)
 		gfp_mask |= __GFP_NORETRY;
 	else
-		gfp_mask |= GFP_NOFS;
+		gfp_mask |= GFP_NOFS | __GFP_NOFAIL;
 
 	/* Make sure that we have a page list */
 	bp->b_page_count = DIV_ROUND_UP(BBTOB(bp->b_length), PAGE_SIZE);
@@ -372,8 +372,9 @@ xfs_buf_alloc_pages(
 
 	/*
 	 * Bulk filling of pages can take multiple calls. Not filling the entire
-	 * array is not an allocation failure, so don't back off if we get at
-	 * least one extra page.
+	 * array is not an allocation failure but is worth counting in
+	 * xb_pages_retries statistics.  If we don't even get one page,
+	 * then this must be a READ_AHEAD and we should abort.
 	 */
 	for (;;) {
 		long	last = filled;
@@ -385,16 +386,13 @@ xfs_buf_alloc_pages(
 			break;
 		}
 
-		if (filled != last)
-			continue;
-
-		if (flags & XBF_READ_AHEAD) {
+		if (filled == last) {
+			ASSERT(flags & XBF_READ_AHEAD);
 			xfs_buf_free_pages(bp);
 			return -ENOMEM;
 		}
 
 		XFS_STATS_INC(bp->b_mount, xb_page_retries);
-		congestion_wait(BLK_RW_ASYNC, HZ / 50);
 	}
 	return 0;
 }


