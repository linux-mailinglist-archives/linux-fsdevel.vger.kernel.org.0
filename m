Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC30F40A208
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 02:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhINAaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 20:30:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbhINA37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:29:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 230D921E66;
        Tue, 14 Sep 2021 00:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631579321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKg7RlKucOqg4kFvULlcfcgLDUa14h212dG0lQnULcE=;
        b=awMekhqm0ZNbe0UAJauJmcBwIc7nmh/WiO0Wm1svGCnQLjolPKb5AEyzgL6E7o+LIz4y5b
        lmX317K+JkPpTEpTlv/8PeWzfPTcsJIfAIpsVotoHrncS7969LnN3tar3wZGiAWm97fph1
        H5B/qIkNeKC7yoT4eFeE3/rSAVYmUos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631579321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKg7RlKucOqg4kFvULlcfcgLDUa14h212dG0lQnULcE=;
        b=2y/BbnOYFFsEbgxZG3DjeobRaJHXJPGcoflnoSvt9f/Hntganr1MCbrR5BikDTWxDcsICr
        wEc7foc1STYeTIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86E1A13ADE;
        Tue, 14 Sep 2021 00:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kqaiEbTsP2FYawAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 00:28:36 +0000
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>
Date:   Tue, 14 Sep 2021 10:13:04 +1000
Subject: [PATCH 6/6] XFS: remove congestion_wait() loop from
 xfs_buf_alloc_pages()
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <163157838440.13293.12568710689057349786.stgit@noble.brown>
In-Reply-To: <163157808321.13293.486682642188075090.stgit@noble.brown>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
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

So instead of waiting, allocate a single page using __GFP_NOFAIL, then
loop around and try to get any more pages that might be needed with a
bulk allocation.  This single-page allocation will wait in the most
appropriate way.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/xfs/xfs_buf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 5fa6cd947dd4..1ae3768f6504 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -372,8 +372,8 @@ xfs_buf_alloc_pages(
 
 	/*
 	 * Bulk filling of pages can take multiple calls. Not filling the entire
-	 * array is not an allocation failure, so don't back off if we get at
-	 * least one extra page.
+	 * array is not an allocation failure, so don't fail or fall back on
+	 * __GFP_NOFAIL if we get at least one extra page.
 	 */
 	for (;;) {
 		long	last = filled;
@@ -394,7 +394,7 @@ xfs_buf_alloc_pages(
 		}
 
 		XFS_STATS_INC(bp->b_mount, xb_page_retries);
-		congestion_wait(BLK_RW_ASYNC, HZ / 50);
+		bp->b_pages[filled++] = alloc_page(gfp_mask | __GFP_NOFAIL);
 	}
 	return 0;
 }


