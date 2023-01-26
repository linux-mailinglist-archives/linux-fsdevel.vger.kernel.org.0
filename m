Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C321F67C63D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjAZIwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 03:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbjAZIwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:52:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835540BC2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 00:52:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9B1F521B2B;
        Thu, 26 Jan 2023 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674723121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fFofRjM/vwdGLu4A/HdbI7HT7P87GTtj7NuuDzlr77c=;
        b=WTO1zeV6mXrEaZzIDVsWegLOWtou/KO3iDyM64tt68/bzrBhHw6ADeNBtKvKPjWuxGnI+B
        rDcXjz4wJ8OOcNUaBDXKTYEDUOBp5XJ5G+ehiXP2/Nf/SH9fJIiatbZlMNX7TqDziEfvfG
        /mKjCRgOlkgbgIf9gcpMxmIeUxZB9t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674723121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fFofRjM/vwdGLu4A/HdbI7HT7P87GTtj7NuuDzlr77c=;
        b=weA1BQOpG4TZmkb4FGBvfkVFGv7cS/NMOj2tVSiW7zZEebsqf5y9kAs2a/SLpCjJ/ljdp3
        SNE0ZZKg1NpbI+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CB78139B3;
        Thu, 26 Jan 2023 08:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ydaIjE/0mPQRAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Jan 2023 08:52:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14BF1A06B4; Thu, 26 Jan 2023 09:52:01 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: gracefully handle ->get_block not mapping bh in __mpage_writepage
Date:   Thu, 26 Jan 2023 09:51:55 +0100
Message-Id: <20230126085155.26395-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=jack@suse.cz; h=from:subject; bh=w5jnMEXevvhIBqefepgoK9+b7lEELaQhPlj+9IFsX+g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0j8lmhFJI7jqEBmh+r2SiyTfQKehPlHLTRYEdHE3 PxppdwOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9I/JQAKCRCcnaoHP2RA2RldB/ sHCNurakJdm7ZwryjQVtk8jBEuQQmqJG4NAJkvfQmgWgC8+EWUEto9Pc50khPZ0kM8k6aQWq7vS0jI bV7wfGOObXINsIVlzFwguCi8UqOdC/j5u+3JuTOZVrUXKxY+OYE85gtPXtuDLFxI7td8dZ9xINWIM7 kB2VjZ8+/C77FvEV9D8RW/niIft/c1MaZk76p2qD7q9VSjzTZ9ya5BrGT0A05d3VM68OzS5jtaWKBc /5fZwaXbkmUScDuzT9QGBMZ43LUneUSvrokM7grXVr6f/bAudDEGv9n3XF1ZLg7UOml86ahGWr6IAI CBZ7rgR4n8B4EDGi0FwhmPrG7RbupG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When filesystem's ->get_block function does not map the buffer head when
called from __mpage_writepage(), the function will happily go and pass
bogus bdev and block number to bio allocation routines which leads to
crashes sooner or later. E.g. UDF can do this because it doesn't want to
allocate blocks from ->writepages callbacks. It allocates blocks on
write or page fault but writeback can still spot dirty buffers without
underlying blocks allocated e.g. if blocksize < pagesize, the tail page
is dirtied (which means all its buffers are dirtied), and truncate
extends the file so that some buffer starts to be within i_size.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/mpage.c | 2 ++
 1 file changed, 2 insertions(+)

I'd like to get this patch merged through my tree as other UDF fixes depend on
it and without this change the kernel crashes in unfortunate ways.

diff --git a/fs/mpage.c b/fs/mpage.c
index 9f040c1d5912..8bd77a8e2627 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -538,6 +538,8 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 		map_bh.b_size = 1 << blkbits;
 		if (mpd->get_block(inode, block_in_file, &map_bh, 1))
 			goto confused;
+		if (!buffer_mapped(&map_bh))
+			goto confused;
 		if (buffer_new(&map_bh))
 			clean_bdev_bh_alias(&map_bh);
 		if (buffer_boundary(&map_bh)) {
-- 
2.35.3

