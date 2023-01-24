Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96B679795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjAXMSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjAXMSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A7544BCA
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BDBB1FE4D;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuRHlhx2mHjz1hrJYA0ACB01C/AufQqOFLhYM4oFqa4=;
        b=FNYjaZ0FzHTyDIgrPAy4np5RwRG/0ujjMmyzA9MfiOfmF8s6Sja+kbE1SpaKZ8EShhwL6j
        3CnLQPDgeoGTTnErHQbtLttl9UDJLSAjs+o2Lqfzt/P/ASHMMfGlAA+BiXT1X4c6a6tew9
        zwXK6gZQ/+gZuZnDdUfji0wdrUIIDvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuRHlhx2mHjz1hrJYA0ACB01C/AufQqOFLhYM4oFqa4=;
        b=U6ge9Ga5tsjwwNoyMXQFVZBAvjtW1BGfSy8Mb7DvMxDT1RmyGpPCMY3Ln6gSc7KSTgFcwk
        k+ww5Pw11f6CAeDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EBF9139FB;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yi05E4fMz2P2NwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 58614A06F3; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 15/22] udf: Push i_data_sem locking into udf_expand_file_adinicb()
Date:   Tue, 24 Jan 2023 13:18:01 +0100
Message-Id: <20230124121814.25951-15-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3436; i=jack@suse.cz; h=from:subject; bh=egCksdVqpUNTMa2JmVa1OO3JlGwu/sZq7LNwywphVOQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x5hbvW1xCK+XuiCOd/sp3kv/lJaYlF3uhY67/H Wzm245qJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MeQAKCRCcnaoHP2RA2eLbB/ 0W9emDbtPFyu6N6HkxW9kjRFRNlrhj9RuddYGoCw+SLljZRChFLCka0SqlBbCxlWVN1qaw5Z9EFeBh LdWkEIL3paJTeErRHHfKiUwdDvG5IZLQMKZZxqjwN6N9A/RcRx41eUQ85MHdmJ/+epUVkXeIv2jMee QYH3Hw4f9b0bTBQLqKBx1E1PhDfHDvuV3dxZ8rMja3GlpOuK7qIrceiCiE1QeYIaHKcjfylHBx1h09 llZxvVXCsT/vKA8NU2sNfP6y8iMGZgFnJggciuj7IqycD8kHfgqflpi7KAOjyIsR0swBWhDToPF7eQ Wx/YO4/bCdkKvmuO9nbwrdBNXC4hq3
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

The checks we do in udf_setsize() and udf_file_write_iter() are safe to
do only with i_rwsem locked as it stabilizes both file type and file
size. Hence we don't need to lock i_data_sem before we enter
udf_expand_file_adinicb() which simplifies the locking somewhat.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c  | 11 +++++------
 fs/udf/inode.c | 18 ++++++------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 8be51161f3e5..60524814c594 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -148,7 +148,6 @@ static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (retval <= 0)
 		goto out;
 
-	down_write(&iinfo->i_data_sem);
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
 	    inode->i_sb->s_blocksize < (udf_file_entry_alloc_offset(inode) +
 				 iocb->ki_pos + iov_iter_count(from))) {
@@ -158,15 +157,15 @@ static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			udf_debug("udf_expand_adinicb: err=%d\n", err);
 			return err;
 		}
-	} else
-		up_write(&iinfo->i_data_sem);
+	}
 
 	retval = __generic_file_write_iter(iocb, from);
 out:
-	down_write(&iinfo->i_data_sem);
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB && retval > 0)
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB && retval > 0) {
+		down_write(&iinfo->i_data_sem);
 		iinfo->i_lenAlloc = inode->i_size;
-	up_write(&iinfo->i_data_sem);
+		up_write(&iinfo->i_data_sem);
+	}
 	inode_unlock(inode);
 
 	if (retval > 0) {
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4554d1e54eb3..b13c35335dd1 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -247,7 +247,6 @@ const struct address_space_operations udf_aops = {
 /*
  * Expand file stored in ICB to a normal one-block-file
  *
- * This function requires i_data_sem for writing and releases it.
  * This function requires i_mutex held
  */
 int udf_expand_file_adinicb(struct inode *inode)
@@ -259,6 +258,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
 	if (!iinfo->i_lenAlloc) {
+		down_write(&iinfo->i_data_sem);
 		if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
 			iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 		else
@@ -269,11 +269,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 		mark_inode_dirty(inode);
 		return 0;
 	}
-	/*
-	 * Release i_data_sem so that we can lock a page - page lock ranks
-	 * above i_data_sem. i_mutex still protects us against file changes.
-	 */
-	up_write(&iinfo->i_data_sem);
 
 	page = find_or_create_page(inode->i_mapping, 0, GFP_NOFS);
 	if (!page)
@@ -1160,19 +1155,18 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 
 	iinfo = UDF_I(inode);
 	if (newsize > inode->i_size) {
-		down_write(&iinfo->i_data_sem);
 		if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-			if (bsize <
+			if (bsize >=
 			    (udf_file_entry_alloc_offset(inode) + newsize)) {
-				err = udf_expand_file_adinicb(inode);
-				if (err)
-					return err;
 				down_write(&iinfo->i_data_sem);
-			} else {
 				iinfo->i_lenAlloc = newsize;
 				goto set_size;
 			}
+			err = udf_expand_file_adinicb(inode);
+			if (err)
+				return err;
 		}
+		down_write(&iinfo->i_data_sem);
 		err = udf_extend_file(inode, newsize);
 		if (err) {
 			up_write(&iinfo->i_data_sem);
-- 
2.35.3

