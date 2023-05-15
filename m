Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41A702ACA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbjEOKlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbjEOKlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:41:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E9196;
        Mon, 15 May 2023 03:41:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64395e741fcso13077768b3a.2;
        Mon, 15 May 2023 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684147264; x=1686739264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1s/fpzNTihS5/5EOzSHIaLQ/HGTdRANGMzvbRQcFLM=;
        b=SWnVIzPHQqVxxyk+ju8xx27LVoZAsUdXsB73gAYADsV/Gd82rdmMFc/JGYu+glMbVp
         ONG91Z5ibGr3IJVJNS6P5k6ce6sWdz9ugKTweRIP+OXjXX1hJqSvr6hTku32Ua/INvfN
         Y88hJdzV/2/fTT+iUApKs0rURZ5YRKtf7WSIPaSVNfOysFuZHHFsHAVzdpE6ZPcsF+CP
         n7pCp6yxvMmV5fW7Vs+RPg9yHDcZx4lZ9OgJVqiSvblRN0I/Pg5W3hq4tNoD3OKMTsDA
         ntpUeiWRieLz9GeIDfNBXey6Fq15oy4lmgYZhHy7On6mQJi6M5Dsm9admbJxunf320/t
         2BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684147264; x=1686739264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1s/fpzNTihS5/5EOzSHIaLQ/HGTdRANGMzvbRQcFLM=;
        b=Mjie5cmNqKuraJYQG7SXgMd21MdC83WkQXi/9z2FBKQ55bqwt/beA+jR2KE/8KuIvq
         WtvhBRGtd4N3cz9/2iLru4vzQyOncstR30Tlyn2ZqL6rN2wJiXzjFOcKPauoPQQzx1WN
         fPgaq1HI0RQrGbaU0YFZeO9/wkTZ7HheFC8VOBy1zMv8E8c/bXXgOmvi5QiZGYGgF16W
         W6qzZid6rYoPIw1b2/YhNB5bZOhCyT9JfoBa6wW7KMTbxOE9IO9xl44/NSv4ZFkQKSEd
         xGPqLUnzcs5xwCooWHsimVV72Hb8x1Ar3FOUy1Rp1LqcTadGvc+AjXgajg5jKKWvSeBJ
         L1qQ==
X-Gm-Message-State: AC+VfDwsLxHOOsbYipY2nv2Q/w4KArlFtKrPR/wa/haiWRPTyO01UKyA
        POR308w9UBnLF/nXYnSdIkbWHk0JU1g=
X-Google-Smtp-Source: ACHHUZ7h2ziHFqrcthAubQoe1FhQ/3SciDSPajWvgSj/vd10YlurwvASGX8cGpteVMjG4do8Jhzg3w==
X-Received: by 2002:a05:6a21:78a7:b0:105:8d42:2622 with SMTP id bf39-20020a056a2178a700b001058d422622mr6760291pzc.41.1684147264150;
        Mon, 15 May 2023 03:41:04 -0700 (PDT)
Received: from rh-tp.c4p-in.ibmmobiledemo.com ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b006466d70a30esm11867078pfo.91.2023.05.15.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:41:03 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 5/5] ext4: Make ext4_write_inline_data_end() use folio
Date:   Mon, 15 May 2023 16:10:44 +0530
Message-Id: <1bcea771720ff451a5a59b3f1bcd5fae51cb7ce7.1684122756.git.ritesh.list@gmail.com>
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

ext4_write_inline_data_end() is completely converted to work with folio.
Also all callers of ext4_write_inline_data_end() already works on folio
except ext4_da_write_end(). Mostly for consistency and saving few
instructions maybe, this patch just converts ext4_da_write_end() to work
with folio which makes the last caller of ext4_write_inline_data_end()
also converted to work with folio.
We then make ext4_write_inline_data_end() take folio instead of page.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h   |  6 ++----
 fs/ext4/inline.c |  3 +--
 fs/ext4/inode.c  | 23 ++++++++++++++---------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f9a58251ccea..19e3a880ea16 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3477,10 +3477,8 @@ extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct inode *inode,
 					 loff_t pos, unsigned len,
 					 struct page **pagep);
-extern int ext4_write_inline_data_end(struct inode *inode,
-				      loff_t pos, unsigned len,
-				      unsigned copied,
-				      struct page *page);
+int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
+			       unsigned copied, struct folio *folio);
 extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   struct inode *inode,
 					   loff_t pos, unsigned len,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index c0b2dc6514b2..f48183f91c87 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -741,9 +741,8 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 }
 
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
-			       unsigned copied, struct page *page)
+			       unsigned copied, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	int no_expand;
 	void *kaddr;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bd827af19b55..3988e0be1270 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1287,7 +1287,8 @@ static int ext4_write_end(struct file *file,
 
 	if (ext4_has_inline_data(inode) &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
-		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+		return ext4_write_inline_data_end(inode, pos, len, copied,
+						  folio);
 
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 	/*
@@ -1395,7 +1396,8 @@ static int ext4_journalled_write_end(struct file *file,
 	BUG_ON(!ext4_handle_valid(handle));
 
 	if (ext4_has_inline_data(inode))
-		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+		return ext4_write_inline_data_end(inode, pos, len, copied,
+						  folio);
 
 	if (unlikely(copied < len) && !folio_test_uptodate(folio)) {
 		copied = 0;
@@ -2942,15 +2944,15 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
  * Check if we should update i_disksize
  * when write to the end of file but not require block allocation
  */
-static int ext4_da_should_update_i_disksize(struct page *page,
+static int ext4_da_should_update_i_disksize(struct folio *folio,
 					    unsigned long offset)
 {
 	struct buffer_head *bh;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	unsigned int idx;
 	int i;
 
-	bh = page_buffers(page);
+	bh = folio_buffers(folio);
 	idx = offset >> inode->i_blkbits;
 
 	for (i = 0; i < idx; i++)
@@ -2970,17 +2972,19 @@ static int ext4_da_write_end(struct file *file,
 	loff_t new_i_size;
 	unsigned long start, end;
 	int write_mode = (int)(unsigned long)fsdata;
+	struct folio *folio = page_folio(page);
 
 	if (write_mode == FALL_BACK_TO_NONDELALLOC)
 		return ext4_write_end(file, mapping, pos,
-				      len, copied, page, fsdata);
+				      len, copied, &folio->page, fsdata);
 
 	trace_ext4_da_write_end(inode, pos, len, copied);
 
 	if (write_mode != CONVERT_INLINE_DATA &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
 	    ext4_has_inline_data(inode))
-		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+		return ext4_write_inline_data_end(inode, pos, len, copied,
+						  folio);
 
 	if (unlikely(copied < len) && !PageUptodate(page))
 		copied = 0;
@@ -3004,10 +3008,11 @@ static int ext4_da_write_end(struct file *file,
 	 */
 	new_i_size = pos + copied;
 	if (copied && new_i_size > inode->i_size &&
-	    ext4_da_should_update_i_disksize(page, end))
+	    ext4_da_should_update_i_disksize(folio, end))
 		ext4_update_i_disksize(inode, new_i_size);
 
-	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	return generic_write_end(file, mapping, pos, len, copied, &folio->page,
+				 fsdata);
 }
 
 /*
-- 
2.40.1

