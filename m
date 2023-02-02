Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817468886F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjBBUoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 15:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBBUof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:44:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74C48A58;
        Thu,  2 Feb 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CHTViCFku/KBgg0p6DZbUUb80eMrbMHO+BwTMmLL/c8=; b=Cnpe1akXRcTjrbOFxM+9HrW+ur
        d1lfcvyzmUOAlYVR9x6xYmCbrq53KnUEe+yqtSAHOPbH7OHm0rewQg2RMYzAmtBFcYZE4oSeqLxMi
        eCHHJ8dFrq4kz9d/JcMQzW5XpXnfBUje4e46WGl4WZgLZJBy7/sDkudm3R/iXLIpz5Vh7F5wllJ7I
        OUkIXT5U0OkITUYHT6Dd+ODvKs5q3qcDfvn3fcX5d53emCWIimY8ED0Y5esijwiT7AN7seZkhU+G+
        eFufWstFTegm87OA4SkZuEQOD6F1ZgjDbt9nNJNndVfqGOf533nK3ibsN/iH0hY3EkdfhgfQTwKHm
        GPQu7rFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNgRa-00Di7O-Ue; Thu, 02 Feb 2023 20:44:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 2/5] ext4: Zero bytes after 'oldsize' if we're expanding the file
Date:   Thu,  2 Feb 2023 20:44:24 +0000
Message-Id: <20230202204428.3267832-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230202204428.3267832-1-willy@infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX requires that "If the file size is increased, the extended area
shall appear as if it were zero-filled".  It is possible to use mmap to
write past EOF and that data will become visible instead of zeroes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..14e3fa99f733 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5604,6 +5604,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			if (!shrink) {
 				pagecache_isize_extended(inode, oldsize,
 							 inode->i_size);
+				truncate_pagecache(inode, oldsize);
 			} else if (ext4_should_journal_data(inode)) {
 				ext4_wait_for_tail_page_commit(inode);
 			}
-- 
2.35.1

