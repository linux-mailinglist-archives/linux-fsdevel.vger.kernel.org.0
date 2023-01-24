Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970CA679745
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjAXMGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjAXMGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E6E42DD9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5B6F21874;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDDrDcw26phQCdbPzUDXNsvKIR+e0QO5VKmO8bijbQw=;
        b=ybedig2WH1ktgUowIbPoNoj3LDuH/QjNWXyhNBbEYVkgm6xCPgGPkTLBJuzc1jhVE7ooBY
        N0za2b+VLH8iRpyRN6FpxdX9JwZX6koQtlaQjkOPWg1ouJhMlG6p6PGf1Hh22XVzuLY2sJ
        suWtW0mT0Mw54Z7qyY1gATKsaCOuUPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDDrDcw26phQCdbPzUDXNsvKIR+e0QO5VKmO8bijbQw=;
        b=7y5jNwYyNhwgY/248rpl/yasGUgl7brkwTVbt6IWV90BPMl54d0pLHoyK9wUJt6pdgc5HH
        6M41LmLWKftR/iDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D975F139FF;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4yMWNcfJz2MNMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 45BABA06D1; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/10] udf: Switch to single address_space_operations
Date:   Tue, 24 Jan 2023 13:06:18 +0100
Message-Id: <20230124120628.24449-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3845; i=jack@suse.cz; h=from:subject; bh=4mgp3QLb6HmP1b/8ThPLU90Zl6h/3PYHYO/pxF75v/A=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m53DO2nlWf892szXBo+L9iUxddRdI9ygL5ktsJ l7GyStOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JuQAKCRCcnaoHP2RA2VesB/ 9gp2+6luaF0rQHNz+SfJWHGkZIKB3yvU83sUhwAA1L1GvE/F5TtUkUbuP4PGaq0UM5G0AV7giVbpQY A0TUMJfO7IhaPKf/2CpVUOWQLXZavQUWBnxAy7Ph7SAd6Zj8MKpCMrMtNla+LmoqSxJ4+UgZViTZ4I YSZCvMPA7DeCUrhKDux3KENADikCI84iqkNWXRUGo2jFPmIR/dKhsBY23K6tFC8ULS3ZGVaaZwXToS 6kJxnJR2gED+Zn64KQBnce3UvlDr2zOhqidR+YWr1fovBAYfZevNRehHape9iVSraNB7VxbbUqHLpW 8PP+T4okCZjDh7d02zspo1UrV0mI24
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

Now that udf_aops and udf_adiniicb_aops are functionally identical, just
drop udf_adiniicb_aops.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 10 ----------
 fs/udf/inode.c   |  8 +-------
 fs/udf/namei.c   | 10 ++--------
 fs/udf/udfdecl.h |  1 -
 4 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 8a37cd593883..84e0b241940d 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,16 +57,6 @@ void udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-const struct address_space_operations udf_adinicb_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= udf_read_folio,
-	.writepages	= udf_writepages,
-	.write_begin	= udf_write_begin,
-	.write_end	= udf_write_end,
-	.direct_IO	= udf_direct_IO,
-};
-
 static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 703db2a4516b..5b0be8f281f0 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -364,8 +364,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-	/* from now on we have normal address_space methods */
-	inode->i_data.a_ops = &udf_aops;
 	set_page_dirty(page);
 	unlock_page(page);
 	up_write(&iinfo->i_data_sem);
@@ -379,7 +377,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 		kunmap_atomic(kaddr);
 		unlock_page(page);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-		inode->i_data.a_ops = &udf_adinicb_aops;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
 	}
@@ -1566,10 +1563,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	case ICBTAG_FILE_TYPE_REGULAR:
 	case ICBTAG_FILE_TYPE_UNDEF:
 	case ICBTAG_FILE_TYPE_VAT20:
-		if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-			inode->i_data.a_ops = &udf_adinicb_aops;
-		else
-			inode->i_data.a_ops = &udf_aops;
+		inode->i_data.a_ops = &udf_aops;
 		inode->i_op = &udf_file_inode_operations;
 		inode->i_fop = &udf_file_operations;
 		inode->i_mode |= S_IFREG;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1b0f4c600b63..c043584463d2 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -373,10 +373,7 @@ static int udf_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		inode->i_data.a_ops = &udf_adinicb_aops;
-	else
-		inode->i_data.a_ops = &udf_aops;
+	inode->i_data.a_ops = &udf_aops;
 	inode->i_op = &udf_file_inode_operations;
 	inode->i_fop = &udf_file_operations;
 	mark_inode_dirty(inode);
@@ -392,10 +389,7 @@ static int udf_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		inode->i_data.a_ops = &udf_adinicb_aops;
-	else
-		inode->i_data.a_ops = &udf_aops;
+	inode->i_data.a_ops = &udf_aops;
 	inode->i_op = &udf_file_inode_operations;
 	inode->i_fop = &udf_file_operations;
 	mark_inode_dirty(inode);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 304c2ec81589..d8c0de3b224e 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -80,7 +80,6 @@ extern const struct inode_operations udf_file_inode_operations;
 extern const struct file_operations udf_file_operations;
 extern const struct inode_operations udf_symlink_inode_operations;
 extern const struct address_space_operations udf_aops;
-extern const struct address_space_operations udf_adinicb_aops;
 extern const struct address_space_operations udf_symlink_aops;
 
 struct udf_fileident_iter {
-- 
2.35.3

