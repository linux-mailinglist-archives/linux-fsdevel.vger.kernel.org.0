Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0188D679794
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjAXMSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjAXMSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CC442ED
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CC081FE4B;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgF2+jVQFT/DrkwUQ/i2IFmOa9Lb4Ekn7vziWx+im30=;
        b=kdDNRm8fqvP2uO+hSSVf/7RO37RKFyTSQ1B22+t8jWTTjN8yUJKXyIsvO0/pPYozmoEsJ7
        adpWAJkqFzJcfhQs1Zbap1rSTTzayZ3Cp65YuRbYvdWeBdF8o0c18CTny42roVBvqkIRh6
        geJMJGbRkmb9+YkkfNszAofJ3qAxIfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgF2+jVQFT/DrkwUQ/i2IFmOa9Lb4Ekn7vziWx+im30=;
        b=ZjIisHIlxOTqgVZWXTSqGE8JGV7MY7gmlYKdmDS7NT/yc0SLpC540JNJEDb5ygUmhRCtx7
        tWFU4oxbLkcaD9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23F2313A09;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SubGCIfMz2PnNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 290F2A06D3; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 07/22] udf: Do not call udf_block_map() on ICB files
Date:   Tue, 24 Jan 2023 13:17:53 +0100
Message-Id: <20230124121814.25951-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=jack@suse.cz; h=from:subject; bh=w7r+wUrzagF3K6pnVTKKhlEMwrHB5EJvDVvesA5qtXY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xy4MJFZDRSI38ADJQ6BZWUrg8BfkHCk2WWryjk ioRDxCaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/McgAKCRCcnaoHP2RA2XofCA DTv1Pvk7/qLgjZb6yasvwEF6aUb4G1ULlK/8sBDlM/Iy1/M1pQ9G/I7UT4106ywPAZBInmHJjqyzSL 1t9p7/DYyKYfh+Jw/23BA/xSyyAslJDNHYtysjKrmaITFclQ5ysXoTP3uwvh0ifINv1Kr3YC6+xk5R 5BURwcVVnCs4mXAgeKU47FtaTIvguN6sVhg0T5Z2a5OYaugGhuqFWzdFs5h/Rptil7TxchWvQWGpem U+XLg4/3iSCJV1vLg/Vp8xREHRQz9AGzuuSUW1sotfkq1nmayI9Xjp5rPXVJFSTWjHycODb9GYxnAM BNZJQwWPqwcddk22Sox1+2JT09TFR7
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

Currently udf_symlink_filler() called udf_block_map() even on files
which have data stored inside the ICB. This is invalid as we cannot map
blocks for such files (although so far the error got silently ignored).
The call happened because we could not call block mapping function once
we've acquired i_data_sem and determined whether the file has data
stored in the ICB. For symlinks the situation is luckily simple as they
get never modified so file type never changes once it is set. Hence we
can check the file type even without i_data_sem. Just drop the
i_data_sem locking and move block mapping to where it is needed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/symlink.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index f3642f9c23f8..451d6d6c701e 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -109,27 +109,24 @@ static int udf_symlink_filler(struct file *file, struct folio *folio)
 	unsigned char *symlink;
 	int err;
 	unsigned char *p = page_address(page);
-	struct udf_inode_info *iinfo;
+	struct udf_inode_info *iinfo = UDF_I(inode);
 	uint32_t pos;
 
 	/* We don't support symlinks longer than one block */
 	if (inode->i_size > inode->i_sb->s_blocksize) {
 		err = -ENAMETOOLONG;
-		goto out_unmap;
+		goto out_unlock;
 	}
 
-	iinfo = UDF_I(inode);
-	pos = udf_block_map(inode, 0);
-
-	down_read(&iinfo->i_data_sem);
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		symlink = iinfo->i_data + iinfo->i_lenEAttr;
 	} else {
+		pos = udf_block_map(inode, 0);
 		bh = sb_bread(inode->i_sb, pos);
 
 		if (!bh) {
 			err = -EIO;
-			goto out_unlock_inode;
+			goto out_err;
 		}
 
 		symlink = bh->b_data;
@@ -138,17 +135,15 @@ static int udf_symlink_filler(struct file *file, struct folio *folio)
 	err = udf_pc_to_char(inode->i_sb, symlink, inode->i_size, p, PAGE_SIZE);
 	brelse(bh);
 	if (err)
-		goto out_unlock_inode;
+		goto out_err;
 
-	up_read(&iinfo->i_data_sem);
 	SetPageUptodate(page);
 	unlock_page(page);
 	return 0;
 
-out_unlock_inode:
-	up_read(&iinfo->i_data_sem);
+out_err:
 	SetPageError(page);
-out_unmap:
+out_unlock:
 	unlock_page(page);
 	return err;
 }
-- 
2.35.3

