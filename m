Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F6679743
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAXMGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjAXMGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E8A42BD5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBDF41FDAB;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fQiALYYxtoAS4I+mwqhI7NOvIPGNdFLZ3aDQhtCMGg=;
        b=BXwbMXmpPLVKBgjezqlRxETM8LGxkdl57KBcqIhRBlFlAINw0Il0uPmNWF1rpfGeDW1+pJ
        SrJ4CRc1LiJAARTqObGEtFNDntGFcFjCNBgaRpLgSbLmxmZ1jeIeSM5V3XifMo+Bm5iiQ6
        P5wVnKKBmlBNFv00INd6fq3YMh/+jow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fQiALYYxtoAS4I+mwqhI7NOvIPGNdFLZ3aDQhtCMGg=;
        b=s7v+Ws7Vjzxp0Kmpv74R6Dw2lviokY4UC53+X+zVwm3CMwoXY1xhnR9+02M0jJhih6lNVB
        qlOqf2MhNqO9JDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCEE813A04;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TKjnNcfJz2MPMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4C021A06D3; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 08/10] udf: Mark aops implementation static
Date:   Tue, 24 Jan 2023 13:06:19 +0100
Message-Id: <20230124120628.24449-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660; i=jack@suse.cz; h=from:subject; bh=VthrwZ5OSXAIOttzrwTcqnd/sxobYc4WDYwx6I6QdSM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m6fcL3kef5SVhn0wm/eLeeity9WrE8jX8+68yf nklqY9eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JugAKCRCcnaoHP2RA2Us+B/ 9nE5MJuMLNQs+QA4o3uwOg9y+dUlDesHYMMGgwDMWaivHqaC3tfazKpbIjUtbXEVte6rpRy1OQ3SfU 60Oqb2jymw/q839+aTe2wfHBWWjcbbNl2QTAOVX7D+gM8VKBHQA2Cce9NkHo4/CCsY1Et2W7SWiPxX z5TkUYlwC5uGYOL3yjjOXDNqNJh16oF+Be7iZqk2lAc9KCvFk5wFpv5waEqvIQofXvQgxpySRfahgf MjSH7LOHXiUiH3vWl3TlNEULurKME1Y4v3SQNWFXjgmhX6Vc0jzTiNjMZ1ey2XfEDaKpFDjpT+vSn7 8vbLsVbYJZ++5PBqlADXQkjXVlt+d7
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

Mark functions implementing aops static since they are not needed
outside of inode.c anymore.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c   | 19 ++++++++++---------
 fs/udf/udfdecl.h |  9 ---------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 5b0be8f281f0..af069a05919c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -204,7 +204,8 @@ static int udf_adinicb_writepage(struct page *page,
 	return 0;
 }
 
-int udf_writepages(struct address_space *mapping, struct writeback_control *wbc)
+static int udf_writepages(struct address_space *mapping,
+			  struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -214,7 +215,7 @@ int udf_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	return write_cache_pages(mapping, wbc, udf_adinicb_writepage, NULL);
 }
 
-int udf_read_folio(struct file *file, struct folio *folio)
+static int udf_read_folio(struct file *file, struct folio *folio)
 {
 	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
 
@@ -231,9 +232,9 @@ static void udf_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, udf_get_block);
 }
 
-int udf_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+static int udf_write_begin(struct file *file, struct address_space *mapping,
+			   loff_t pos, unsigned len,
+			   struct page **pagep, void **fsdata)
 {
 	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
 	struct page *page;
@@ -257,9 +258,9 @@ int udf_write_begin(struct file *file, struct address_space *mapping,
 	return 0;
 }
 
-int udf_write_end(struct file *file, struct address_space *mapping,
-		  loff_t pos, unsigned len, unsigned copied,
-		  struct page *page, void *fsdata)
+static int udf_write_end(struct file *file, struct address_space *mapping,
+			 loff_t pos, unsigned len, unsigned copied,
+			 struct page *page, void *fsdata)
 {
 	struct inode *inode = file_inode(file);
 	loff_t last_pos;
@@ -277,7 +278,7 @@ int udf_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
-ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d8c0de3b224e..337daf97d5b4 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -158,15 +158,6 @@ extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 extern int udf_setsize(struct inode *, loff_t);
 extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
-int udf_read_folio(struct file *file, struct folio *folio);
-int udf_writepages(struct address_space *mapping, struct writeback_control *wbc);
-int udf_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata);
-int udf_write_end(struct file *file, struct address_space *mapping,
-		  loff_t pos, unsigned len, unsigned copied,
-		  struct page *page, void *fsdata);
-ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
 int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
-- 
2.35.3

