Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44C362B113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 03:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiKPCKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 21:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKPCKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:10:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B613317DF;
        Tue, 15 Nov 2022 18:10:17 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h193so15312803pgc.10;
        Tue, 15 Nov 2022 18:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edTd/8en+S7nFCs7bvchEE9GA5NqYTbaAgFkDH59CPw=;
        b=cD9MV49WEAUYWQxdD69ZABkZwcvH/Sy01d2BEoajQL/UB3FK0pJWmFL16ABBRlMdah
         YI96fzjPXUi96FFTetnaBW5znWFlL0hqj6nYo65uDMWqTjqxd+FU0tJvx/WKZHKNBVPz
         yBGhVi1oAiGAZIwI6v1p6pWA3yzks5gxKvXJVHsQKni6IVm7qViZ6TuRA5kXqnwEHiAF
         lNGyejgS/WqIY2zJiA+MqV2vFEkR5GqyoMQALz1appaBZrLtRHUJm6XxkEALy7fkGieB
         +UhLTAtIOBGsBOdnXKz2nZC5qEj2bo4iNFeHe9GcwwmJuhZB65Aq2rUTjRGcDMw70j+5
         zvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edTd/8en+S7nFCs7bvchEE9GA5NqYTbaAgFkDH59CPw=;
        b=3IBz9GTPbDg9+BfJ0M9L9gUl4DvNe0JUYNvDTVx84gisKy2NLEjiugAAkz8CmQ99+y
         yR+aubVqv5thjyhH5slP8YmHA2hClqSos0a/ORfu+vqzwhzKyvRsSrRCrl1m5zsae1YJ
         NGv+v2WtiZYjemkrt1EHvJ9lgaQq0lFh9jnWpLqkS9jncyaVE1y4uy/Uve43/QalW4SD
         7hhBn3JRJfHF4LNChMVq/FhrHRKfiDGUUxFEO+NeNvmHaXCkTcm62N1h6eduhhl9HG7B
         I7bgt+J4OmfXjd4wzG3+wVkumdcCRrb0RLvTEOliA10ZftBLPEaGw4Urt/mGCkgYoe6i
         ARFw==
X-Gm-Message-State: ANoB5plsAT/58m+BlVeDAd68668RXc7ak0s8rghCPWM1Lxm7vcZJ9/py
        uhiPgE0xJV8uQgLxZncmbyI=
X-Google-Smtp-Source: AA0mqf6VE+cIqZ132CIPFdm51AI+vVTW9iFk3WFUMCM2PAXHIKpEfwf11GrBWCmVT+8N77rIQ+bRhw==
X-Received: by 2002:a63:f53:0:b0:456:d859:2143 with SMTP id 19-20020a630f53000000b00456d8592143mr18731335pgp.396.1668564616706;
        Tue, 15 Nov 2022 18:10:16 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id e18-20020a17090301d200b0018691ce1696sm10782926plh.131.2022.11.15.18.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:10:16 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/4] ext4: Convert move_extent_per_page() to use folios
Date:   Tue, 15 Nov 2022 18:10:08 -0800
Message-Id: <20221116021011.54164-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116021011.54164-1-vishal.moola@gmail.com>
References: <20221116021011.54164-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Converts move_extent_per_page() to use folios. This change removes
5 calls to compound_head() and is in preparation for the removal of
the try_to_release_page() wrapper.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ext4/move_extent.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 044e34cd835c..0c680d4a2929 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -253,6 +253,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 {
 	struct inode *orig_inode = file_inode(o_filp);
 	struct page *pagep[2] = {NULL, NULL};
+	struct folio *folio[2] = {NULL, NULL};
 	handle_t *handle;
 	ext4_lblk_t orig_blk_offset, donor_blk_offset;
 	unsigned long blocksize = orig_inode->i_sb->s_blocksize;
@@ -313,6 +314,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 * hold page's lock, if it is still the case data copy is not
 	 * necessary, just swap data blocks between orig and donor.
 	 */
+	folio[0] = page_folio(pagep[0]);
+	folio[1] = page_folio(pagep[1]);
 	if (unwritten) {
 		ext4_double_down_write_data_sem(orig_inode, donor_inode);
 		/* If any of extents in range became initialized we have to
@@ -331,10 +334,10 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 			ext4_double_up_write_data_sem(orig_inode, donor_inode);
 			goto data_copy;
 		}
-		if ((page_has_private(pagep[0]) &&
-		     !try_to_release_page(pagep[0], 0)) ||
-		    (page_has_private(pagep[1]) &&
-		     !try_to_release_page(pagep[1], 0))) {
+		if ((folio_has_private(folio[0]) &&
+		     !filemap_release_folio(folio[0], 0)) ||
+		    (folio_has_private(folio[1]) &&
+		     !filemap_release_folio(folio[1], 0))) {
 			*err = -EBUSY;
 			goto drop_data_sem;
 		}
@@ -344,19 +347,21 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 						   block_len_in_page, 1, err);
 	drop_data_sem:
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
-		goto unlock_pages;
+		goto unlock_folios;
 	}
 data_copy:
-	*err = mext_page_mkuptodate(pagep[0], from, from + replaced_size);
+	*err = mext_page_mkuptodate(&folio[0]->page, from, from + replaced_size);
 	if (*err)
-		goto unlock_pages;
+		goto unlock_folios;
 
 	/* At this point all buffers in range are uptodate, old mapping layout
 	 * is no longer required, try to drop it now. */
-	if ((page_has_private(pagep[0]) && !try_to_release_page(pagep[0], 0)) ||
-	    (page_has_private(pagep[1]) && !try_to_release_page(pagep[1], 0))) {
+	if ((folio_has_private(folio[0]) &&
+		!filemap_release_folio(folio[0], 0)) ||
+	    (folio_has_private(folio[1]) &&
+		!filemap_release_folio(folio[1], 0))) {
 		*err = -EBUSY;
-		goto unlock_pages;
+		goto unlock_folios;
 	}
 	ext4_double_down_write_data_sem(orig_inode, donor_inode);
 	replaced_count = ext4_swap_extents(handle, orig_inode, donor_inode,
@@ -369,13 +374,13 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 			replaced_size =
 				block_len_in_page << orig_inode->i_blkbits;
 		} else
-			goto unlock_pages;
+			goto unlock_folios;
 	}
 	/* Perform all necessary steps similar write_begin()/write_end()
 	 * but keeping in mind that i_size will not change */
-	if (!page_has_buffers(pagep[0]))
-		create_empty_buffers(pagep[0], 1 << orig_inode->i_blkbits, 0);
-	bh = page_buffers(pagep[0]);
+	if (!folio_buffers(folio[0]))
+		create_empty_buffers(&folio[0]->page, 1 << orig_inode->i_blkbits, 0);
+	bh = folio_buffers(folio[0]);
 	for (i = 0; i < data_offset_in_page; i++)
 		bh = bh->b_this_page;
 	for (i = 0; i < block_len_in_page; i++) {
@@ -385,7 +390,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		bh = bh->b_this_page;
 	}
 	if (!*err)
-		*err = block_commit_write(pagep[0], from, from + replaced_size);
+		*err = block_commit_write(&folio[0]->page, from, from + replaced_size);
 
 	if (unlikely(*err < 0))
 		goto repair_branches;
@@ -395,11 +400,11 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
 			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
 
-unlock_pages:
-	unlock_page(pagep[0]);
-	put_page(pagep[0]);
-	unlock_page(pagep[1]);
-	put_page(pagep[1]);
+unlock_folios:
+	folio_unlock(folio[0]);
+	folio_put(folio[0]);
+	folio_unlock(folio[1]);
+	folio_put(folio[1]);
 stop_journal:
 	ext4_journal_stop(handle);
 	if (*err == -ENOSPC &&
@@ -430,7 +435,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		*err = -EIO;
 	}
 	replaced_count = 0;
-	goto unlock_pages;
+	goto unlock_folios;
 }
 
 /**
-- 
2.38.1

