Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310E3679782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjAXMSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjAXMSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CAC442EA
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96ABC2188E;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47r5ExZRB24cDn2IjtdkIRMHYac0BXu7wUVP0ko8VT8=;
        b=StabaqjxyLINpvcTNijwJ6YcNaLPwVvSG4IvsItjvU3DBF5nXpAqWxZke3bBvNU1IMfZiw
        yWa3+CpnSqvV6qHkM8iopYP2SYlqZI14j6MBgfu5vNeRTFyxcViRqkYUIqfg5gcbkQhTAw
        EaJYu4kbDGEvqMV+jpfAMkNHD+H+hbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47r5ExZRB24cDn2IjtdkIRMHYac0BXu7wUVP0ko8VT8=;
        b=CxukcPpfWAU3KJM8g73XVKBoPifleobmqKt+uH5zGK10HHofZF8QAq9q2LL6cmBoienLSc
        PkEefxjhaeWCXADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 891F013A06;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x09aIYbMz2PSNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12511A06C5; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 03/22] udf: Move incrementing of goal block directly into inode_getblk()
Date:   Tue, 24 Jan 2023 13:17:49 +0100
Message-Id: <20230124121814.25951-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=jack@suse.cz; h=from:subject; bh=AlSPZhbo6K1pV5NFVChrTADgN11hy8V5XtSJXgXgye8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xvLYFCPR79HZCjDxnG5hrlBDtE6MDb/YEYgInH pUd5NTGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MbwAKCRCcnaoHP2RA2dc7B/ 9+zhB2poRfQZQUswg8+Ne1RDr3QwwHAtzPx7EJBr3uIlKKZwCn+DuFlhb9+Uit2amJdEVE0pVOmKu8 tTS8fFMkHYEHmu2ITzFGce45ocTbCYItP4RYCfo10cjRB7jEKqOE7bLX6E7YPbIS56a4bkO5tRwWKZ h58aiy2tCol5OvDzLIoCLTTXLWzMFt37RDuQOzeeXxwqBweyWx63zkcX1lgi27MeA+ubpRre7vUtSD rHcbd19qoYmEy2ZWRi+TVZyCX4ADr+9C35QdSBjOyYXsAF9sB/iPcaFVdZL1gP2PmMgEp6hPwXFks5 sWQ5vPkgYjQH6TZD2mTqWKF2fXg0jI
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

inode_getblk() sets goal block for the next allocation to the currently
allocated block. This is obviously one less than what the goal block
should be which we fixup in udf_get_block(). Just set the right goal
block directly in inode_getblk().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 2b3fc897d1b3..ff414fff354a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -339,11 +339,6 @@ static int udf_get_block(struct inode *inode, sector_t block,
 	iinfo = UDF_I(inode);
 
 	down_write(&iinfo->i_data_sem);
-	if (block == iinfo->i_next_alloc_block + 1) {
-		iinfo->i_next_alloc_block++;
-		iinfo->i_next_alloc_goal++;
-	}
-
 	/*
 	 * Block beyond EOF and prealloc extents? Just discard preallocation
 	 * as it is not useful and complicates things.
@@ -812,8 +807,8 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 		goto out_free;
 	}
 	*new = 1;
-	iinfo->i_next_alloc_block = block;
-	iinfo->i_next_alloc_goal = newblocknum;
+	iinfo->i_next_alloc_block = block + 1;
+	iinfo->i_next_alloc_goal = newblocknum + 1;
 	inode->i_ctime = current_time(inode);
 
 	if (IS_SYNC(inode))
-- 
2.35.3

