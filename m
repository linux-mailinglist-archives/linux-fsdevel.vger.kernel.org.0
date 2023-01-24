Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283D1679747
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjAXMGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjAXMGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36F43459
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 804E01F45B;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hy4VOZBmtEU89Bx7353BUzINIoSVHvCrzaZkcayD8yc=;
        b=X4DOTgDX20MQVDVj/V1L6j1+pWAV3pJbo47sV43LxiDF4kBif3PTQLuZmRQxymSTj4Ko6M
        lwVu3Zq6cj1vi8oos9Mq2fdGCWExekmKb5OGTp++Wh1fCkBHCLUszme+bm5q1/xuKbdNaK
        PBeAsfIcYtec8PM9aEhHYoiM6q0LumA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hy4VOZBmtEU89Bx7353BUzINIoSVHvCrzaZkcayD8yc=;
        b=j6QTeR9zfBybJA65I6fJ2+BMnXaYhAc/1wuozvBl3f0Z/srX4rUOgjYJeE00Zq4Oe9xqqv
        zIaYq0ZCcmai7rDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 731C7139FB;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4KYWHMfJz2P9MAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21937A06B5; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 01/10] udf: Unify .read_folio for normal and in-ICB files
Date:   Tue, 24 Jan 2023 13:06:12 +0100
Message-Id: <20230124120628.24449-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528; i=jack@suse.cz; h=from:subject; bh=+Aw3Zp3tgnBCgNL73bIVEpE5qYNcKCVPpG6msw1G5z8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m0xL3HZyvI1qrDKH48UkmT+DTxcU+tdvXmeLRW oS3z0SqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JtAAKCRCcnaoHP2RA2fcfB/ 44C0k9WRWXb2fZpfsL/IkGclzWeJh8FNDiUqBQEStM0g9cVhLY6XyI5PA72SHlGJJECc60dQprdh9n PEZqGS3vHC+k9DzAF+FwTcxiploRHVRQV26Lfs3SYj8LkQjoqGyARTd24QhwPQT3bE/1Dt4ozSNp9C L7i9K6Ssf7Mex6asqrT+Z+o204uS60xmGOIC0O8Ae4AJhHx2sZNNfAXx8fh0m3IneoWikpi9MgsgFt X+Mba69n34MflzeLH8TKnHC735tuHpnf+OzlDbcuXd11mPEU9qDf6CLSUDha9Sv7fDiQmP6E/i4OXq XVhLzI9UdpOw9ld77oUKkjO3Uux3ZI
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

Switching address_space_operations while a file is used is difficult to
do in a race-free way. To be able to use single address_space_operations
in UDF, make udf_read_folio() handle both normal and in-ICB files.

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
index 15e0d9f23c06..9ef56574e452 100644
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

