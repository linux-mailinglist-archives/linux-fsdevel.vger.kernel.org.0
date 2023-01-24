Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5087367973F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjAXMGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjAXMGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074C2A142
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A20D021871;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUIgpUoILBkxxrNX4TYpwRPxjlAl4KhtPM5NNincH1U=;
        b=G9h6HiZFQwjcaJ05GgJePCGIarGhhFAZGQbXoQtw5DQdaUq6k8Ezp8VF5XheDuYDK3drmk
        nUbvg5BZtnKeR3b4stM5pqhkJYxE7/MAHSJGkxc+xalZrJ8cfy8YtRcqCT3/O/fJb3Saml
        TnHxyYGd+R/J7HtYY3Pbek8d8Wmw7Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUIgpUoILBkxxrNX4TYpwRPxjlAl4KhtPM5NNincH1U=;
        b=Q3w9B8LjSFet+ngAPr61B9H7QLuncfwVOe6g9jWdz5IggEDvxhPi4M3OOn9vibb8wxbAuC
        CeKngWj/yT4jevBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 954AF139FF;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QCxuJMfJz2MFMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 395F5A06C6; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/10] udf: Convert all file types to use udf_write_end()
Date:   Tue, 24 Jan 2023 13:06:16 +0100
Message-Id: <20230124120628.24449-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=jack@suse.cz; h=from:subject; bh=hzRIKA29NwS4YIjo2R5FmWKQBDYsGUn89kb2rsG48FM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m3nYGeYBEIa69N6k+RBUDDl4UvXhSDzU94uHgb sZpkfReJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JtwAKCRCcnaoHP2RA2RtYB/ 4y1ZOeFWG3pOG/J94zUgqWZuWg8UoggijSbK5CuTIPHfYeYh9QwwvJWERI/X2pkZDd8+N403TUIwyv 6HjzjSMro0hvYDLcqNuYYJMO+WnDmeN44dKp5DtTB3GErhBo1F4LzUIuYh00yXOMr/N2PNvEEo1diz lfFf8DTU5/C0ljjggqV5u1KRPclU/R+tBJxc8hGHJLHkv/X6ZQF34qXzJdk9WOClzeWcDk6qUnrHFx x2FKO6reafXWGSFvfxTWnj+YFJ6ppADpxiYYSychxKJQhtLFXUedsDMx1V5ulG5zeEJvf5Uku6XOUO IEth8T+qOGqxh51Q28jtmjyuAFFrD6
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
in UDF, create udf_write_end() function that is able to handle both
normal and in-ICB files.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 16 +---------------
 fs/udf/inode.c   | 22 +++++++++++++++++++++-
 fs/udf/udfdecl.h |  3 +++
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 16aecf4b2387..8a37cd593883 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,27 +57,13 @@ void udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_write_end(struct file *file, struct address_space *mapping,
-				 loff_t pos, unsigned len, unsigned copied,
-				 struct page *page, void *fsdata)
-{
-	struct inode *inode = page->mapping->host;
-	loff_t last_pos = pos + copied;
-	if (last_pos > inode->i_size)
-		i_size_write(inode, last_pos);
-	set_page_dirty(page);
-	unlock_page(page);
-	put_page(page);
-	return copied;
-}
-
 const struct address_space_operations udf_adinicb_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= udf_read_folio,
 	.writepages	= udf_writepages,
 	.write_begin	= udf_write_begin,
-	.write_end	= udf_adinicb_write_end,
+	.write_end	= udf_write_end,
 	.direct_IO	= udf_direct_IO,
 };
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7f5b2b1f9847..91758c8d77e5 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -257,6 +257,26 @@ int udf_write_begin(struct file *file, struct address_space *mapping,
 	return 0;
 }
 
+int udf_write_end(struct file *file, struct address_space *mapping,
+		  loff_t pos, unsigned len, unsigned copied,
+		  struct page *page, void *fsdata)
+{
+	struct inode *inode = file_inode(file);
+	loff_t last_pos;
+
+	if (UDF_I(inode)->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
+		return generic_write_end(file, mapping, pos, len, copied, page,
+					 fsdata);
+	last_pos = pos + copied;
+	if (last_pos > inode->i_size)
+		i_size_write(inode, last_pos);
+	set_page_dirty(page);
+	unlock_page(page);
+	put_page(page);
+
+	return copied;
+}
+
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -286,7 +306,7 @@ const struct address_space_operations udf_aops = {
 	.readahead	= udf_readahead,
 	.writepages	= udf_writepages,
 	.write_begin	= udf_write_begin,
-	.write_end	= generic_write_end,
+	.write_end	= udf_write_end,
 	.direct_IO	= udf_direct_IO,
 	.bmap		= udf_bmap,
 	.migrate_folio	= buffer_migrate_folio,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 32decf6b6a21..304c2ec81589 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -164,6 +164,9 @@ int udf_writepages(struct address_space *mapping, struct writeback_control *wbc)
 int udf_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
+int udf_write_end(struct file *file, struct address_space *mapping,
+		  loff_t pos, unsigned len, unsigned copied,
+		  struct page *page, void *fsdata);
 ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
-- 
2.35.3

