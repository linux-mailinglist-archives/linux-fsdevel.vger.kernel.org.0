Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DB679789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjAXMSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjAXMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467DD442F1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 001151FE1E;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KX2l2VM3mQseDoZjciXJXWz/AlvoZ81GcxemuHKONFo=;
        b=cADyG9DKg0DsmcIdejyyOnRcZ+x/M4pru/rFT8/T2a0DbbusnIkF2lo4n5BXcZKSLHI8yR
        EVPNdKzelGV8Ncb7J8YMKSeJPIXO3fOr6CGNq7+D9RzSpIdKXj4kvaZIVRHj3fUwYxU8GL
        BZjBlhBXpED0swBwk7eO8N/FfUQfwF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KX2l2VM3mQseDoZjciXJXWz/AlvoZ81GcxemuHKONFo=;
        b=F/2p6unSpqiGVa6QZp+aq9knpzWSMCAo0J/fkBqajYhuQlXwSD0LBykVxeFpTTUN0Dac12
        r+es9ZoDcZ1yThBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5C08139FB;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dtghOIbMz2PeNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2EED0A06D4; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 08/22] udf: Convert udf_symlink_filler() to use udf_bread()
Date:   Tue, 24 Jan 2023 13:17:54 +0100
Message-Id: <20230124121814.25951-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=jack@suse.cz; h=from:subject; bh=FHIKTP5NfPL9Luj4nsfFCPKR0huUs5SW/4yaAzAanjY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xzWLyIeumZKzEUlN9maWXCi0V4BdsWybvFLCjp ie7Vw4+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/McwAKCRCcnaoHP2RA2cFRB/ 0R36hnt/uniZj+4i8uwsjyBIAX4R3pXT1zS5VwUffMXZFE0/1fbY8Vnp24PNYiFfG7ELx2tukO5vj7 AwUz4TZ4TQc1HPUI1FKD1ow7UynXx8xFScYPTk18vEt/uFHBSsolLLnwu+hK6TfPTaJfwnTFgBtcfP 8hD0j7s9/Fu0he8flvAn9KD7dDKrsVlIVkPTgHt8r8d3F/nb8VX3JI99exnOiLKIhY0y01Ig4Wun0O Uc1s9Om6b7rgrelqudSEQSm1JAJY6byhGk+PZ56tWoPVKcaweLcKgcYMCbbmlZVy0fX2rFeztUUd19 Swk+MQica4miZi4pyDKnXA3UI4HSM7
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

Convert udf_symlink_filler() to use udf_bread() instead of mapping and
reading buffer head manually.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/symlink.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 451d6d6c701e..a6cabaa5f1c2 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -107,10 +107,9 @@ static int udf_symlink_filler(struct file *file, struct folio *folio)
 	struct inode *inode = page->mapping->host;
 	struct buffer_head *bh = NULL;
 	unsigned char *symlink;
-	int err;
+	int err = 0;
 	unsigned char *p = page_address(page);
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	uint32_t pos;
 
 	/* We don't support symlinks longer than one block */
 	if (inode->i_size > inode->i_sb->s_blocksize) {
@@ -121,14 +120,12 @@ static int udf_symlink_filler(struct file *file, struct folio *folio)
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		symlink = iinfo->i_data + iinfo->i_lenEAttr;
 	} else {
-		pos = udf_block_map(inode, 0);
-		bh = sb_bread(inode->i_sb, pos);
-
+		bh = udf_bread(inode, 0, 0, &err);
 		if (!bh) {
-			err = -EIO;
+			if (!err)
+				err = -EFSCORRUPTED;
 			goto out_err;
 		}
-
 		symlink = bh->b_data;
 	}
 
-- 
2.35.3

