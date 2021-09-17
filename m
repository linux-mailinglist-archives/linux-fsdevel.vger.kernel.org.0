Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD040F004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 05:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbhIQDBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 23:01:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56580 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbhIQDBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:01:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0018223BD;
        Fri, 17 Sep 2021 02:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631847594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2Rgi41wxZueRRJfJ3e7t139IMXGOwOFm/IW/86sxa8=;
        b=TN9g57JhoeeQCj56ZDT1Z5eH8c3azHNFurn6Qcu8WtVKUJyL+7juZYOKl1ThupKPKuR9Zk
        wrwCImtWXdb8m2WpjzERGLTMfrZEvG2PAT+/nYm6aGTE1kEUhzGQxoTgg4GRVdjak/X352
        u75+NChOvjnDYseuYUWwfwRfaQ3y4LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631847594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2Rgi41wxZueRRJfJ3e7t139IMXGOwOFm/IW/86sxa8=;
        b=wTggxCx6C/rUpvp5f5bdxeTCzPFiiQYeoHK1ofO3v0pxvISag8G6Kmr6h1TGJJjXk9dWpv
        DMvK0w6KJxde2nCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AC2A13D0B;
        Fri, 17 Sep 2021 02:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OQR+EqQERGGWMwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Sep 2021 02:59:48 +0000
Subject: [PATCH 4/6] EXT4: remove congestion_wait from ext4_bio_write_page,
 and simplify
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
Message-ID: <163184741781.29351.8660877195340279243.stgit@noble.brown>
In-Reply-To: <163184698512.29351.4735492251524335974.stgit@noble.brown>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

congestion_wait() is indistinguishable from
schedule_timeout_uninterruptible().  It is best avoided and should be
deprecated.

It is not needed in ext4_bio_write_page().  There are two cases.
If there are no ->io_bio yet, then it is appropriate to use __GFP_NOFAIL
which does the waiting in a better place.  The code already uses this
flag on the second attempt.  This patch changes to it always use that
flag for this case.

If there *are* ->io_bio (in which case the allocation was non-blocking)
we submit the io and return the first case.  No waiting is needed in
this case.

So remove the congestion_wait() call, and simplify the code so that the
two cases are somewhat clearer.

Remove the "if (io->io_bio)" before calling ext4_io_submit() as that
test is performed internally by that function.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/ext4/page-io.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index f038d578d8d8..3b6ece0d3ad6 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -506,7 +506,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	 * can't happen in the common case of blocksize == PAGE_SIZE.
 	 */
 	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
-		gfp_t gfp_flags = GFP_NOFS;
+		gfp_t gfp_flags;
 		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
 
 		/*
@@ -514,21 +514,18 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		 * a waiting mask (i.e. request guaranteed allocation) on the
 		 * first page of the bio.  Otherwise it can deadlock.
 		 */
+	retry_encrypt:
 		if (io->io_bio)
 			gfp_flags = GFP_NOWAIT | __GFP_NOWARN;
-	retry_encrypt:
+		else
+			gfp_flags = GFP_NOFS | __GFP_NOFAIL;
 		bounce_page = fscrypt_encrypt_pagecache_blocks(page, enc_bytes,
 							       0, gfp_flags);
 		if (IS_ERR(bounce_page)) {
 			ret = PTR_ERR(bounce_page);
 			if (ret == -ENOMEM &&
 			    (io->io_bio || wbc->sync_mode == WB_SYNC_ALL)) {
-				gfp_flags = GFP_NOFS;
-				if (io->io_bio)
-					ext4_io_submit(io);
-				else
-					gfp_flags |= __GFP_NOFAIL;
-				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				ext4_io_submit(io);
 				goto retry_encrypt;
 			}
 


