Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F55702AC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbjEOKk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbjEOKk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:40:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE471BC;
        Mon, 15 May 2023 03:40:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so8825959b3a.1;
        Mon, 15 May 2023 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684147254; x=1686739254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMjoQ6t2aFRxmfNfu7Q0YEqH72acltcAQi6vXgz7/40=;
        b=ggkwRbc0Y5EUjOfNwngab/gF1CBQdmYrrihvDYpNH4+a9n1A5XyE7DWxTZD60vtWfP
         TlHszDW3pYVsYsA0qN5fIMUDcLv9uiuiBFrbZjzN2WxBYgFaxjyPLsM/YYN8qmiNmrBm
         Vv/GDLddZ6FQ8WSTh0up0830NwA5kOnDBHXSPwHLDmtQ6mvITMUMV1zGZxVjEMwShwg2
         dekRFxE0h8BwaPZuP5na0+Kiq2JJrgKcljvG5MyLjMQvQU+iXipO6ruFU12MzL5G4KGW
         dyrY4xn4BtjvimWOnjUIO7LbELZvUzs2qPZLA1/uhhFb1hBnwkMUbx7xIAwJ/NxdVZ9u
         UaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684147254; x=1686739254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMjoQ6t2aFRxmfNfu7Q0YEqH72acltcAQi6vXgz7/40=;
        b=FYt8AFmuyE+x8nAex8rHzdd/fG+VL+4zGEyjTptjXX3sF2wLBZ5JwC0kdhGehGMc1+
         fjgPK8vfOXczVvZbebprNNwZup6Qn7oOwUcpjez4dYASOBC05L3x1eeNUXg+rej5Sn5C
         RauWwVgobyEfx/027+me3GnP1SnDZ+dhajHwQo59V6WXxuYnYsckeIProtVbQBpZiUZB
         G7VlX6LtXEBG3lwvPa36VIPmn/YZs52g37/AnHehphRZwc2LDMDE6T1QrXywnSVpW54w
         MzWSFJLQX8Kn2tn71xl+vlTuGCkHixMYmaRYm6Eldh7sNjYQvpuX2dFSFjHNn/dVPySx
         8YfA==
X-Gm-Message-State: AC+VfDxJeC8zuG/1maqJyROmTJKAthZ4DChkDXj6EH3WkgGEufpmXDEH
        Wmf5kC/nkPY0lGkK0ShYqKRlcavr4aI=
X-Google-Smtp-Source: ACHHUZ7rwl/LmMB+euMJqrQ0aZKK1nXpntPMPxZphE+jkNqe9MRDQviyrS8TtaEkqWb4YvnrYgjZgA==
X-Received: by 2002:aa7:88ce:0:b0:645:6142:7f5a with SMTP id k14-20020aa788ce000000b0064561427f5amr34853349pff.3.1684147253878;
        Mon, 15 May 2023 03:40:53 -0700 (PDT)
Received: from rh-tp.c4p-in.ibmmobiledemo.com ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b006466d70a30esm11867078pfo.91.2023.05.15.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:40:53 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 1/5] ext4: kill unused function ext4_journalled_write_inline_data
Date:   Mon, 15 May 2023 16:10:40 +0530
Message-Id: <122b2a8d5e0650686f23ed6da26ed9e04105562b.1684122756.git.ritesh.list@gmail.com>
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

Commit 3f079114bf522 ("ext4: Convert data=journal writeback to use ext4_writepages()")
Added support for writeback of journalled data into ext4_writepages()
and killed function __ext4_journalled_writepage() which used to call
ext4_journalled_write_inline_data() for inline data.
This function got left over by mistake. Hence kill it's definition as
no one uses it.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h   |  4 ----
 fs/ext4/inline.c | 24 ------------------------
 2 files changed, 28 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6948d673bba2..f9a58251ccea 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3481,10 +3481,6 @@ extern int ext4_write_inline_data_end(struct inode *inode,
 				      loff_t pos, unsigned len,
 				      unsigned copied,
 				      struct page *page);
-extern struct buffer_head *
-ext4_journalled_write_inline_data(struct inode *inode,
-				  unsigned len,
-				  struct page *page);
 extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   struct inode *inode,
 					   loff_t pos, unsigned len,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 5854bd5a3352..c0b2dc6514b2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -823,30 +823,6 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	return ret ? ret : copied;
 }
 
-struct buffer_head *
-ext4_journalled_write_inline_data(struct inode *inode,
-				  unsigned len,
-				  struct page *page)
-{
-	int ret, no_expand;
-	void *kaddr;
-	struct ext4_iloc iloc;
-
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret) {
-		ext4_std_error(inode->i_sb, ret);
-		return NULL;
-	}
-
-	ext4_write_lock_xattr(inode, &no_expand);
-	kaddr = kmap_atomic(page);
-	ext4_write_inline_data(inode, &iloc, kaddr, 0, len);
-	kunmap_atomic(kaddr);
-	ext4_write_unlock_xattr(inode, &no_expand);
-
-	return iloc.bh;
-}
-
 /*
  * Try to make the page cache and handle ready for the inline data case.
  * We can call this function in 2 cases:
-- 
2.40.1

