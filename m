Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C144BF85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfFSRWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 13:22:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44276 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbfFSRW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:22:26 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so215203iob.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDc3/t6pQgXRlrbpZdKVEwq+X2f/5QLw6zNH6ghEEMo=;
        b=WPhIzrHu8MmV20787TkEtOfYm8/d2xp1ifATc3YV0/Rsg0RGf7SNVNtMk1uBr3yM3O
         ZzONv6mp3+uKgsCWGg7j7qWkPxVOAYs+9VPxean7qbw9ydspDA8iJKMeRoICmmyuPYCL
         Gs68n8T05do8PZDva2U27cwXM3i99K4Y387kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDc3/t6pQgXRlrbpZdKVEwq+X2f/5QLw6zNH6ghEEMo=;
        b=kMY4WcGK30L4KV8dwh8lhtvlncTVRtirHF80U55SLOHiRHlXmSWkIhkE7Ymt+t2m+K
         bc2XAD474ZgWsJ/tPGA9HVicbrlHKjp/uM3K9Wc57ImB/mXKBoc4XQi0PWEHJE2nnioT
         en9AcdyrVj7v1TYxhV6CDSEtgoxpffENIRVIBbwFIZvZ3dn9cD/yhr1w/uQdnkOsVBxu
         Ui1QvtxDxeRDDVxz32iYKlJSsvQdCuIrCn00iWWHlYpTvaANIsworxLLPohqxk3yCo0J
         XpOBfeQQ6Wc/xLDH1rTCocPiZw4Mq6DfhLoi7HjsXQSa3DLslZI5EPWj6l2o/aE7AcQs
         z3mA==
X-Gm-Message-State: APjAAAVDosY1dfGSThsAhTMvr9wF7LyAf6xDmg+FgCY+SiVyS+avy+gn
        aJ9jgMmXZZu8EHcr98MmbCg/hQ==
X-Google-Smtp-Source: APXvYqyww/nXaKClg6oe4jKe1+QWUCyNtR9Nkjre2Tn+D5wwr4oCZC/khTMy8wbQr3InQ0out2BhWw==
X-Received: by 2002:a6b:cf17:: with SMTP id o23mr3506984ioa.176.1560964945770;
        Wed, 19 Jun 2019 10:22:25 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id u26sm22681456iol.1.2019.06.19.10.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:22:25 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: [PATCH 3/3] ext4: use jbd2_inode dirty range scoping
Date:   Wed, 19 Jun 2019 11:21:56 -0600
Message-Id: <20190619172156.105508-4-zwisler@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190619172156.105508-1-zwisler@google.com>
References: <20190619172156.105508-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the newly introduced jbd2_inode dirty range scoping to prevent us
from waiting forever when trying to complete a journal transaction.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 fs/ext4/ext4_jbd2.h   | 12 ++++++------
 fs/ext4/inode.c       | 13 ++++++++++---
 fs/ext4/move_extent.c |  3 ++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 75a5309f22315..ef8fcf7d0d3b3 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -361,20 +361,20 @@ static inline int ext4_journal_force_commit(journal_t *journal)
 }
 
 static inline int ext4_jbd2_inode_add_write(handle_t *handle,
-					    struct inode *inode)
+		struct inode *inode, loff_t start_byte, loff_t length)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2_journal_inode_add_write(handle,
-						    EXT4_I(inode)->jinode);
+		return jbd2_journal_inode_ranged_write(handle,
+				EXT4_I(inode)->jinode, start_byte, length);
 	return 0;
 }
 
 static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
-					   struct inode *inode)
+		struct inode *inode, loff_t start_byte, loff_t length)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2_journal_inode_add_wait(handle,
-						   EXT4_I(inode)->jinode);
+		return jbd2_journal_inode_ranged_wait(handle,
+				EXT4_I(inode)->jinode, start_byte, length);
 	return 0;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c7f77c6430085..27fec5c594459 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -731,10 +731,16 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
 		    !ext4_is_quota_file(inode) &&
 		    ext4_should_order_data(inode)) {
+			loff_t start_byte =
+				(loff_t)map->m_lblk << inode->i_blkbits;
+			loff_t length = (loff_t)map->m_len << inode->i_blkbits;
+
 			if (flags & EXT4_GET_BLOCKS_IO_SUBMIT)
-				ret = ext4_jbd2_inode_add_wait(handle, inode);
+				ret = ext4_jbd2_inode_add_wait(handle, inode,
+						start_byte, length);
 			else
-				ret = ext4_jbd2_inode_add_write(handle, inode);
+				ret = ext4_jbd2_inode_add_write(handle, inode,
+						start_byte, length);
 			if (ret)
 				return ret;
 		}
@@ -4085,7 +4091,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		err = 0;
 		mark_buffer_dirty(bh);
 		if (ext4_should_order_data(inode))
-			err = ext4_jbd2_inode_add_write(handle, inode);
+			err = ext4_jbd2_inode_add_write(handle, inode, from,
+					length);
 	}
 
 unlock:
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 1083a9f3f16a1..c7ded4e2adff5 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -390,7 +390,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 
 	/* Even in case of data=writeback it is reasonable to pin
 	 * inode to transaction, to prevent unexpected data loss */
-	*err = ext4_jbd2_inode_add_write(handle, orig_inode);
+	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
+			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
 
 unlock_pages:
 	unlock_page(pagep[0]);
-- 
2.22.0.410.gd8fdbe21b5-goog

