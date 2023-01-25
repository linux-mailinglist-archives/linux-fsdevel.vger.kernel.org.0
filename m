Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B848B67AE50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjAYJmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjAYJmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18F73D92E
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C1641FD8D;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvXHs7KC3XoYcieRWPWsX3JTLF6cKFBBMlbp8BGLHvw=;
        b=FbRu5Ubri2lpGIczpdxaKuIniPyxnTlc+/bY353WhKl9xoeCzA9hN2V8hf/C+Go5cfqVMl
        WRcux9Y6X9WZzM0+3/Qqsz+GI/XERWf3kP/UgABA3VSQICZJ2PFxQW7lYcqCTHqG5RUhtr
        obGh/7FjezVno9urTqyg9Fx40DfTsIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvXHs7KC3XoYcieRWPWsX3JTLF6cKFBBMlbp8BGLHvw=;
        b=CO27MhIh+nU1IhhYl9VE18TMwZzmiFIPl44p4871VKRbubWPKtyvccN/L+oVQtFMLhcZnc
        ahgupQNnYT0pU+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BC6D13A06;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v7mWDmn50GMoIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 673A5A06D4; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 08/12] udf: Mark aops implementation static
Date:   Wed, 25 Jan 2023 10:41:50 +0100
Message-Id: <20230125094159.10877-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705; i=jack@suse.cz; h=from:subject; bh=KohlA3zDsUpsD8ncXHbnvUVHzj7Ra7hy/Db1qwCHeg0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PleGXh+EyMA738Koav7xfNO+Na2r1Gfngy+eE2w EwTYx7+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5XgAKCRCcnaoHP2RA2VQ4CA DKVDtjaN2RUdksGl3+rSycya/xkMt0NpIlP045KsdJ5l2tanQS0Z52mAbIvVRRJLe7tIYyjqpao1Gx dJSwwGW+cfiqTn8R7x8FM8s/DWixX4lBrEJdO7Bbuf2Q4yF28CpebFWwrpG1z4rsrFcThDDb/ZmUWq N42QyrP93qizHBH8yo3OH8Kkda4ZqU15gC/6dPcTzX3z4VdDwAliXNlaOKrMxVKADj2P91IU6LWDjC +XACcTbjLunvREmcYanQAaPsr+6QJaqDw3/Xd1CtARcWlbvHUjPHbaDbTIpAzfq7vPh8inIlWAjSvu bAKjFhdzUVHUFGmWjlL9dN2WU/MD6R
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

Mark functions implementing aops static since they are not needed
outside of inode.c anymore.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c   | 19 ++++++++++---------
 fs/udf/udfdecl.h |  9 ---------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 6d303f580232..688ecf60edfa 100644
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

