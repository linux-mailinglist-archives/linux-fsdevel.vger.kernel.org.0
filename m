Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8C6908E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 13:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBIMca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 07:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBIMcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:32:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644302A16F;
        Thu,  9 Feb 2023 04:32:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC86C37476;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675945928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y67/jfZcaQ1t6XqJfCmKWgTl2+zDLO5vmdBow0/F1TM=;
        b=pcl1MoPjJrqtKQ7VmePmRZ7GSAV/t0ZTMCVMmqRZCJ85r+TM8FrAlpGX/+nAs3me2AXnYb
        +oke6O/NQry6pTkbUjFbiVswTcGKk9ZQFYdh4OHfafnnrpGnZ1pej1bEf6SbTjy7BfGODI
        svinGNwGJ7TU+ao9NGN2AirHgWvY8zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675945928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y67/jfZcaQ1t6XqJfCmKWgTl2+zDLO5vmdBow0/F1TM=;
        b=PDjlgzwzWa9eJisya0ohOe7XJZPKSBlvylyTL+RO3mNo9e0ewsIVxbK1yEk9GtbxNYZrsO
        2/GoNszJEVhzIVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF77E138E4;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAcqKsjn5GO4WQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 12:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86927A06E2; Thu,  9 Feb 2023 13:32:06 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] ext4: Drop workaround for mm reclaiming fs private page data
Date:   Thu,  9 Feb 2023 13:31:54 +0100
Message-Id: <20230209123206.3548-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209121046.25360-1-jack@suse.cz>
References: <20230209121046.25360-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=jack@suse.cz; h=from:subject; bh=h6csu2b8ZDggoYb6LWh5Isk6fkPmNiQSaSJRB+AFypk=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJKfPN911EVb7Lxqrw/bhdnTl4YmLDJx6uvdmPG5OEUtKpjn 1MIbnYzGLAyMHAyyYoosqyMval+bZ9S1NVRDBmYQKxPIFAYuTgGYyF9z9p+My7lNKjr+msd0J2bUzV h/9LhvRJ1jtImdb/yynSvc5vnoCr18rjdflL2vn/Mp7+Udld06EQ1v1+9nL6zZ/Mxgf5/4idOvs24r 2yrlKHs/PvMyhlf74w9l2b73W8L8Pl3s+G+y886HMN7rqfNkjD+ltn/LWf26t07ENUBt760Vjqq2Md dqbRhe62mpCqnuqrvqIW6ukLn9psn9tJ2/eARvBzQ6TmvRtNhlys2eIdOxxXNKsQxH8WL5T31OUS2L PivPPbkmnj/N4vtW9uhH7QoFz241XCjfOO3l34TDv0Qi5na15usteDHlky9XVoy80GlfqUeMLH0f/B QC22VLkxRdNq4oPX29ybHkxLY5AA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop workaround in ext4 writeback code to handle a situation when MM
reclaims fs-private page data from a page that is (or becomes) dirty.
After the previous commit this should not happen anymore.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..46078651ce32 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2657,22 +2657,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			wait_on_page_writeback(page);
 			BUG_ON(PageWriteback(page));
 
-			/*
-			 * Should never happen but for buggy code in
-			 * other subsystems that call
-			 * set_page_dirty() without properly warning
-			 * the file system first.  See [1] for more
-			 * information.
-			 *
-			 * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
-			 */
-			if (!page_has_buffers(page)) {
-				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
-				ClearPageDirty(page);
-				unlock_page(page);
-				continue;
-			}
-
 			if (mpd->map.m_len == 0)
 				mpd->first_page = page->index;
 			mpd->next_page = page->index + 1;
-- 
2.35.3

