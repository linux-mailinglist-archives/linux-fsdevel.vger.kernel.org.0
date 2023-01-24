Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39B3679744
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjAXMGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjAXMGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A12BEDE
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DE4221870;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3W/Z5L/rQVvH2+Vp+tqcQyTsa4B2jPJQp7bkamGySvk=;
        b=BxPr9FAHqDKHCwzKo6OwKy2poh4V+g+Pu4pLSTc4z303QDtalE0eSkUhx05kfNBEQetjsQ
        AVHPYEUzVIhUxMV9AhbQVI3LorWeNLfNyxuZL3/H1aznxeRBu44hfvP53lmqrb8BWzv6GJ
        3ZIjsQ7E+QZ9mscEIMyVuO3I6dhVD5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3W/Z5L/rQVvH2+Vp+tqcQyTsa4B2jPJQp7bkamGySvk=;
        b=AHQ4ukclDoJvealudDe9yYgqmlTKjj9igOMqR6HvHb2eoI4BfCIYzoRvOGtSxsOjb/tKVl
        95XRUwDTgIBCnOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9139613A04;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YipsI8fJz2MEMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33605A06C5; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/10] udf: Convert in-ICB files to use udf_write_begin()
Date:   Tue, 24 Jan 2023 13:06:15 +0100
Message-Id: <20230124120628.24449-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3643; i=jack@suse.cz; h=from:subject; bh=wEf6/4UzZKr4921ATwS9G7K/Mt18TbUw8aarYllmkmw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m3M3pRF3ypuZZRl/HXudol4qFCgL6gN6nzXdkV 01rxa9eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JtwAKCRCcnaoHP2RA2UEICA CQuKjV4zmyW+HUH6oqBP9r40ei7Bxewirfs8XvXN8H3LX9BEFP03v6Qld4IrLwM2HUam8TifVCwOvp zRtYgfKLMvo5WK3DNERoZ67Ewars6vC3tDIvl1CiP5M+zJ+wsBQgflb9ISVljdcFj/rbW7gtv1Gry+ m/w4/15BsCERMaguh+ev0XRgFTaiy+FaxvXWsKHpPLfx8GWeR3dwSDTL6rGAHV+oJ2qzDKBDxhliOg uQnHJ/HMcjJCy957lf3LqeJnqfbeUdn6HWG0SyeC5WMUuQ/W7k9FkGCIF0mcNVIWwmL8j1fvPTzFoI /3oYMZhnLNSEehWrhD1eQESWzBEJEA
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
in UDF, make in-ICB files use udf_write_begin().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 21 +--------------------
 fs/udf/inode.c   | 24 +++++++++++++++++++-----
 fs/udf/udfdecl.h |  3 +++
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 6bab6aa7770a..16aecf4b2387 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,25 +57,6 @@ void udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_write_begin(struct file *file,
-			struct address_space *mapping, loff_t pos,
-			unsigned len, struct page **pagep,
-			void **fsdata)
-{
-	struct page *page;
-
-	if (WARN_ON_ONCE(pos >= PAGE_SIZE))
-		return -EIO;
-	page = grab_cache_page_write_begin(mapping, 0);
-	if (!page)
-		return -ENOMEM;
-	*pagep = page;
-
-	if (!PageUptodate(page))
-		udf_adinicb_readpage(page);
-	return 0;
-}
-
 static int udf_adinicb_write_end(struct file *file, struct address_space *mapping,
 				 loff_t pos, unsigned len, unsigned copied,
 				 struct page *page, void *fsdata)
@@ -95,7 +76,7 @@ const struct address_space_operations udf_adinicb_aops = {
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= udf_read_folio,
 	.writepages	= udf_writepages,
-	.write_begin	= udf_adinicb_write_begin,
+	.write_begin	= udf_write_begin,
 	.write_end	= udf_adinicb_write_end,
 	.direct_IO	= udf_direct_IO,
 };
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 52016c942f68..7f5b2b1f9847 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -231,16 +231,30 @@ static void udf_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, udf_get_block);
 }
 
-static int udf_write_begin(struct file *file, struct address_space *mapping,
+int udf_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
+	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
+	struct page *page;
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, udf_get_block);
-	if (unlikely(ret))
-		udf_write_failed(mapping, pos + len);
-	return ret;
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		ret = block_write_begin(mapping, pos, len, pagep,
+					udf_get_block);
+		if (unlikely(ret))
+			udf_write_failed(mapping, pos + len);
+		return ret;
+	}
+	if (WARN_ON_ONCE(pos >= PAGE_SIZE))
+		return -EIO;
+	page = grab_cache_page_write_begin(mapping, 0);
+	if (!page)
+		return -ENOMEM;
+	*pagep = page;
+	if (!PageUptodate(page))
+		udf_adinicb_readpage(page);
+	return 0;
 }
 
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index a851613465c6..32decf6b6a21 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -161,6 +161,9 @@ extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
 int udf_read_folio(struct file *file, struct folio *folio);
 int udf_writepages(struct address_space *mapping, struct writeback_control *wbc);
+int udf_write_begin(struct file *file, struct address_space *mapping,
+			loff_t pos, unsigned len,
+			struct page **pagep, void **fsdata);
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
-- 
2.35.3

