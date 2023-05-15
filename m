Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B6702AC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbjEOKlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbjEOKlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:41:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C8FE6E;
        Mon, 15 May 2023 03:41:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso11278282a12.1;
        Mon, 15 May 2023 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684147262; x=1686739262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgVI0rPM+Wkq02K4WoXfknpBOTvlMsN3UXnAERKIZK4=;
        b=RbV3lkIW+loD46ewNO7e7JWXGHWC1q2syIfyzBOZK9FDBXMNireBMkaaM3L1XdFjBc
         BEFYICnekj/XHjxL5oyZhZ14DzXEjU6UtY6oduaHmVqfMR2O48iPe59/lLS3KVVvmfxd
         cAsmtGffwHLWltJJ4qoIL4nGuFH7ZC0lO77tMZ3/IfNRtm5oyl8TE6cdkyW2wco9H1p7
         DkjhLMujQIsZP5oDj/xUb0Uk+KsR5fyz+zVEaTGj1n6/27VN73Fjd1W3IiFNmyU8tk8m
         YkAdvxf+fAZctZ1leKk4sRR7vMsi990dUOXb681t2JJlNHNbuNV76LnnctIJF16H++6V
         qtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684147262; x=1686739262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgVI0rPM+Wkq02K4WoXfknpBOTvlMsN3UXnAERKIZK4=;
        b=E4O2MO2V5zY6qgjmA68qe5KYf5WQ21UW/9J637qBlxgRvnPJt3K+0txPfJnWIo+gYf
         LqkxdPhxp72grAEvykQ52WtOdmrtU7aJwFeKQxuwZUT83asEFZj3kZq7djrj3mEUhAEs
         QseMHc6amG47LHI6oOEv9BJIyNoIgOsZcJPsMW3s32ZsCVN1qe5YtHBaNOI7yJLybHO7
         7IGunP5tpM9dOj8Szcqwe1LHAGPgXNMZJBbkvrpneDxOfoGFs0FlveCISF55tlJ2ctRA
         yoJNTHXLa1DAzJHkO1YmN+JEWgboNcftlld5S7ROqg+GQwpnNaIxABhlm/ggwOHhVkAn
         VLsA==
X-Gm-Message-State: AC+VfDxI1y2h6GOJn82YtWIHmKUFABwjgH2eSKFwu+4Xgf40eYdqobsy
        k2N+Xz51PAP5Cp1GohM18nlgaKJTq5E=
X-Google-Smtp-Source: ACHHUZ4X0NLpe7Bv9xVu55wqitABoZOm8Fhj6MZ9j8POxUwCgZ4EUJF6vaLc4hiseyNNGaajJD4h1g==
X-Received: by 2002:a05:6a20:9384:b0:105:f40f:c225 with SMTP id x4-20020a056a20938400b00105f40fc225mr4161492pzh.10.1684147261691;
        Mon, 15 May 2023 03:41:01 -0700 (PDT)
Received: from rh-tp.c4p-in.ibmmobiledemo.com ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b006466d70a30esm11867078pfo.91.2023.05.15.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:41:01 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 4/5] ext4: Make mpage_journal_page_buffers use folio
Date:   Mon, 15 May 2023 16:10:43 +0530
Message-Id: <ebc3ac80e6a54b53327740d010ce684a83512021.1684122756.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684122756.git.ritesh.list@gmail.com>
References: <cover.1684122756.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch converts mpage_journal_page_buffers() to use folio and also
removes the PAGE_SIZE assumption.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43b54aac1c65..bd827af19b55 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2321,11 +2321,11 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
 }
 
-static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
-				     int len)
+static int ext4_journal_folio_buffers(handle_t *handle, struct folio *folio,
+				     size_t len)
 {
-	struct buffer_head *page_bufs = page_buffers(page);
-	struct inode *inode = page->mapping->host;
+	struct buffer_head *page_bufs = folio_buffers(folio);
+	struct inode *inode = folio->mapping->host;
 	int ret, err;
 
 	ret = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
@@ -2334,7 +2334,7 @@ static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
 				     NULL, write_end_fn);
 	if (ret == 0)
 		ret = err;
-	err = ext4_jbd2_inode_add_write(handle, inode, page_offset(page), len);
+	err = ext4_jbd2_inode_add_write(handle, inode, folio_pos(folio), len);
 	if (ret == 0)
 		ret = err;
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
@@ -2344,22 +2344,20 @@ static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
 
 static int mpage_journal_page_buffers(handle_t *handle,
 				      struct mpage_da_data *mpd,
-				      struct page *page)
+				      struct folio *folio)
 {
 	struct inode *inode = mpd->inode;
 	loff_t size = i_size_read(inode);
-	int len;
+	size_t len = folio_size(folio);
 
-	ClearPageChecked(page);
+	folio_clear_checked(folio);
 	mpd->wbc->nr_to_write--;
 
-	if (page->index == size >> PAGE_SHIFT &&
+	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(inode))
-		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
+		len = size - folio_pos(folio);
 
-	return ext4_journal_page_buffers(handle, page, len);
+	return ext4_journal_folio_buffers(handle, folio, len);
 }
 
 /*
@@ -2499,7 +2497,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				/* Pending dirtying of journalled data? */
 				if (folio_test_checked(folio)) {
 					err = mpage_journal_page_buffers(handle,
-						mpd, &folio->page);
+						mpd, folio);
 					if (err < 0)
 						goto out;
 					mpd->journalled_more_data = 1;
@@ -6133,7 +6131,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		err = __block_write_begin(&folio->page, 0, len, ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
-			if (ext4_journal_page_buffers(handle, &folio->page, len))
+			if (ext4_journal_folio_buffers(handle, folio, len))
 				goto out_error;
 		} else {
 			folio_unlock(folio);
-- 
2.40.1

