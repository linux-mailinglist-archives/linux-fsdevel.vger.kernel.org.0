Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5374367AE49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjAYJmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAYJmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0B9005
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3096B1FED0;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMSzfWfD7/SM2a3hJykihl68Hqs5dpEiEJt6FdJqpvE=;
        b=pxtUYyuamtobe0tFIfcehsfR+ns78OnGxB0XZr3CfYkkB/o8SNK8blf5vipfui5TSIHTxV
        2lqZZpfPB9DbboM3KkQ9kzhtJVvoyHSbja6oC8STdm7Kj9F8fP4m7Uu7SbBTRd99JTlE6i
        a91V1Rb2Zy6iqg3hQ4RJaWgV1dK7vQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMSzfWfD7/SM2a3hJykihl68Hqs5dpEiEJt6FdJqpvE=;
        b=tsVcOEFlOq0hW6ITtCHKIbhklu4amTQJVLJvaDRAyhhao/DAYFy3KcQzkFp5BqZaL5mqr3
        WGEY6PihL4Tpy0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B34213A08;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ll6bBmj50GMUIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D901A06B6; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 01/12] udf: Unify .read_folio for normal and in-ICB files
Date:   Wed, 25 Jan 2023 10:41:43 +0100
Message-Id: <20230125094159.10877-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; i=jack@suse.cz; h=from:subject; bh=nYpSEcS0ug2d1fCKnNAsHlaBxvR6MQHkIOos6izMw9M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlXPIoktWeUHiZ1qLOzPoQfoBs5NyOxTWc5A38m 0ZVJeyqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5VwAKCRCcnaoHP2RA2cHsCA CBLTMLg0d7whkELxRICHQI+dzIv7ztB3MbRs8UiG7Z6NX19bim4AUv+5vwJ3l1xiqn3FRp519mVFhh Fe2o6+7CubE36wsz81emJGCwH3H681d3zfRLdCW40c8vEyx5hELiPQvdbwY6rLmb8Qp4oZjBNku70z SPshtViifepG4/gYRRFIQFfs4K8xPJfTHcFZgQ4HekplRN0IpCtG7ogMeVyZ4caKiloAw7xPpKARot u/JPoJrG2nFzlc+5x+SP1/nrBOhLA5MTsol3IxGXiSD6+FKtfGloZPqvFX6ngrdBdPFLRF/UNsq4wS txB8xRWLd3iyNQDqvEb5ZSQbAhAjg6
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

Switching address_space_operations while a file is used is difficult to
do in a race-free way. To be able to use single address_space_operations
in UDF, make udf_read_folio() handle both normal and in-ICB files.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 15 +++------------
 fs/udf/inode.c   |  9 ++++++++-
 fs/udf/udfdecl.h |  2 ++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 322115c8369d..2666234a5204 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -38,7 +38,7 @@
 #include "udf_i.h"
 #include "udf_sb.h"
 
-static void __udf_adinicb_readpage(struct page *page)
+void udf_adinicb_readpage(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	char *kaddr;
@@ -57,15 +57,6 @@ static void __udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_read_folio(struct file *file, struct folio *folio)
-{
-	BUG_ON(!folio_test_locked(folio));
-	__udf_adinicb_readpage(&folio->page);
-	folio_unlock(folio);
-
-	return 0;
-}
-
 static int udf_adinicb_writepage(struct page *page,
 				 struct writeback_control *wbc)
 {
@@ -100,7 +91,7 @@ static int udf_adinicb_write_begin(struct file *file,
 	*pagep = page;
 
 	if (!PageUptodate(page))
-		__udf_adinicb_readpage(page);
+		udf_adinicb_readpage(page);
 	return 0;
 }
 
@@ -127,7 +118,7 @@ static int udf_adinicb_write_end(struct file *file, struct address_space *mappin
 const struct address_space_operations udf_adinicb_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= udf_adinicb_read_folio,
+	.read_folio	= udf_read_folio,
 	.writepage	= udf_adinicb_writepage,
 	.write_begin	= udf_adinicb_write_begin,
 	.write_end	= udf_adinicb_write_end,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 8b73515227ff..b90b9862b073 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -191,8 +191,15 @@ static int udf_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, udf_get_block_wb);
 }
 
-static int udf_read_folio(struct file *file, struct folio *folio)
+int udf_read_folio(struct file *file, struct folio *folio)
 {
+	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		udf_adinicb_readpage(&folio->page);
+		folio_unlock(folio);
+		return 0;
+	}
 	return mpage_read_folio(folio, udf_get_block);
 }
 
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 5ba59ab90d48..6b93b393cb46 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -138,6 +138,7 @@ static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
 
 /* file.c */
 extern long udf_ioctl(struct file *, unsigned int, unsigned long);
+void udf_adinicb_readpage(struct page *page);
 
 /* inode.c */
 extern struct inode *__udf_iget(struct super_block *, struct kernel_lb_addr *,
@@ -158,6 +159,7 @@ extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 extern int udf_setsize(struct inode *, loff_t);
 extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
+int udf_read_folio(struct file *file, struct folio *folio);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
 int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
-- 
2.35.3

