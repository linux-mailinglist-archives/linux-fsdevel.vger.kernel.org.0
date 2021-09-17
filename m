Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B6840EFF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 04:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbhIQDAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 23:00:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbhIQDAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:00:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ABA7D2007B;
        Fri, 17 Sep 2021 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631847569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhO+AMBCn5CF5KJqwHi2NRgoifLeDG6tBD6IhB9YLqI=;
        b=vThorR8aWQ88Y2GmJEKKlzu9235Z/ZeCUkMr1tu37GhRXPpZfoOnsprc1JRFJTuXWRqbYo
        OrwNdG+winpkkSlgaBUSLsVjiQSK1WiUbcsFBMP1c4iGoCvNYpDkYEriFSvFrODR8idE2j
        Tlusg86Y9/ATaenPc/okC73RyP3RPU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631847569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhO+AMBCn5CF5KJqwHi2NRgoifLeDG6tBD6IhB9YLqI=;
        b=PdD7iVhth5i0uczJ3IGRe4R+iuVLNQA6JKSOCFB6xykfVbdQIAbKb0z9L556d52BZHWlwR
        comcujPIZxeGDSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A36E13D0B;
        Fri, 17 Sep 2021 02:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v4HZAo0ERGFmMwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Sep 2021 02:59:25 +0000
Subject: [PATCH 1/6] MM: Support __GFP_NOFAIL in  alloc_pages_bulk_*() and
 improve doco
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
Message-ID: <163184741776.29351.3565418361661850328.stgit@noble.brown>
In-Reply-To: <163184698512.29351.4735492251524335974.stgit@noble.brown>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When alloc_pages_bulk_array() is called on an array that is partially
allocated, the level of effort to get a single page is less than when
the array was completely unallocated.  This behaviour is inconsistent,
but now fixed.  One effect if this is that __GFP_NOFAIL will not ensure
at least one page is allocated.

Also clarify the expected success rate.  __alloc_pages_bulk() will
allocated one page according to @gfp, and may allocate more if that can
be done cheaply.  It is assumed that the caller values cheap allocation
where possible and may decide to use what it has got, or to call again
to get more.

Acked-by: Mel Gorman <mgorman@suse.com>
Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_alloc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..aa51016e49c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5191,6 +5191,11 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
  * is the maximum number of pages that will be stored in the array.
  *
  * Returns the number of pages on the list or array.
+ *
+ * At least one page will be allocated if that is possible while
+ * remaining consistent with @gfp.  Extra pages up to the requested
+ * total will be allocated opportunistically when doing so is
+ * significantly cheaper than having the caller repeat the request.
  */
 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			nodemask_t *nodemask, int nr_pages,
@@ -5292,7 +5297,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 								pcp, pcp_list);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
-			if (!nr_populated)
+			if (!nr_account)
 				goto failed_irq;
 			break;
 		}


