Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8801679790
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjAXMSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjAXMST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F1E3525E
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D6CD21888;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=196YHvJ19wKMQw6z3X95DukOPQ9j7aYHN0sgl1/Ahlc=;
        b=bhy3mSakMBJjDpx5XosRnSA5a7VmfGT1ohjYe7R+SdUHwV4k2W7Hjhi0MlipMJG/sBHya7
        cgEQFu0b2jCENDUJ1dAklKwR4uzZXqrQg0bcjQ+lWgJm3N8JNSxnYUvlaqJKgRebCteras
        tXOIcqIsJXRRV2YFqqQxAFmFK7R2zyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=196YHvJ19wKMQw6z3X95DukOPQ9j7aYHN0sgl1/Ahlc=;
        b=HK58xVKnUDt62wF5VrllPIfJ4vAzYqsErgtaGPAgj3/J5Iv42vTcrX9s3kHhdYimLL925B
        uiRKywwIE1Ms/JBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80392139FB;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f/hKH4fMz2P/NwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6AA0AA0707; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 18/22] udf: Protect truncate and file type conversion with invalidate_lock
Date:   Tue, 24 Jan 2023 13:18:04 +0100
Message-Id: <20230124121814.25951-18-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=jack@suse.cz; h=from:subject; bh=mFr59aqWn7clgWTUq5BN0ALZS9t7E1WNUnhUBusUFog=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x8EvMWq4ZCmgPBGl//0skEQRRgXoCoe/bfIhVy N5PyFMuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MfAAKCRCcnaoHP2RA2dVZB/ 96ZW99dzQ8f595jtlSGI1v4tzQc1arIoRHV1iJrX5RKHGG5NcSAKsXtIpQK6ch1ekXOXF5K4h0UTy2 SFavAsJrx7noHtdW8TkqQgJHxM4sibxjQ8j1YEjjPpeLdiROgUAOh6gwDBKETydfpd+NycsOrV0Nhk Ja7qClCWj5qrspXo+hrmLE6HUAGfMrM8ElZIAMZmdSHcC+rK91BXa3qICeluslh0rBfC3LnJ1pTSUt O/LowPdR7D6E+vRb9VwynNWeGP+MvMKlXQA91DvBWLuRVk1vlJ+olGKB9A5rXIbcG3ntB1VxJJcY5S uoErA4VTdYj7TZtoDST4pa2wrl/LVG
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

Protect truncate and file type conversion in udf_file_write_iter() with
invalidate lock. That will allow us to serialize these paths with page
faults so that the page fault can determine the file type in a racefree
way.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c  |  2 ++
 fs/udf/inode.c | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 596d703fb6c8..cf050bdffd9e 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -150,7 +150,9 @@ static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
 	    inode->i_sb->s_blocksize < (udf_file_entry_alloc_offset(inode) +
 				 iocb->ki_pos + iov_iter_count(from))) {
+		filemap_invalidate_lock(inode->i_mapping);
 		retval = udf_expand_file_adinicb(inode);
+		filemap_invalidate_unlock(inode->i_mapping);
 		if (retval)
 			goto out;
 	}
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 3ffeb5651689..7109adcceefe 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1145,7 +1145,7 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 
 int udf_setsize(struct inode *inode, loff_t newsize)
 {
-	int err;
+	int err = 0;
 	struct udf_inode_info *iinfo;
 	unsigned int bsize = i_blocksize(inode);
 
@@ -1155,6 +1155,7 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return -EPERM;
 
+	filemap_invalidate_lock(inode->i_mapping);
 	iinfo = UDF_I(inode);
 	if (newsize > inode->i_size) {
 		if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
@@ -1167,11 +1168,11 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 			}
 			err = udf_expand_file_adinicb(inode);
 			if (err)
-				return err;
+				goto out_unlock;
 		}
 		err = udf_extend_file(inode, newsize);
 		if (err)
-			return err;
+			goto out_unlock;
 set_size:
 		truncate_setsize(inode, newsize);
 	} else {
@@ -1189,14 +1190,14 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 		err = block_truncate_page(inode->i_mapping, newsize,
 					  udf_get_block);
 		if (err)
-			return err;
+			goto out_unlock;
 		truncate_setsize(inode, newsize);
 		down_write(&iinfo->i_data_sem);
 		udf_clear_extent_cache(inode);
 		err = udf_truncate_extents(inode);
 		up_write(&iinfo->i_data_sem);
 		if (err)
-			return err;
+			goto out_unlock;
 	}
 update_time:
 	inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -1204,7 +1205,9 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 		udf_sync_inode(inode);
 	else
 		mark_inode_dirty(inode);
-	return 0;
+out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return err;
 }
 
 /*
-- 
2.35.3

