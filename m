Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354C64F2C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiLPUyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiLPUyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:54:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08045EDF5;
        Fri, 16 Dec 2022 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kQv6RkxWyrCYRrHEjnn1N2LGczjsV+6qdNwSrNRRtbU=; b=vJZOeBvvwLhtV+tp9GJPBIkpAD
        m+hu5Q/y7ap8jXA4EiUWFjHXHpyv4f0Gb0WrusF5L2FOvg4EnYw5FymANmCzDj8LrCH/Y49tmv9IV
        rBJdCZcyROe99BuAS6YQGgNA4uRSK5n/FXhijtvJrQoefLz9hNLfemhRd74xRr9/krW6VBp/r5Hud
        uWJBxMZooi5zEydMpBjhEa6Jw7Wu/G3q++6UdYXnlg5LMqTM8TD+/lRDb/P9SexcfMc8yUDojYw4p
        cpOhVCV+4WDhO+EXfXXHFS6KXKeHRvB6sorFpP+zvRTw95ZGswvMlzdZYZp65cO662lvIogCo4XAG
        +Kuav7cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiI-00Frfw-F3; Fri, 16 Dec 2022 20:53:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 8/8] reiserfs: Use flush_dcache_folio() in reiserfs_quota_write()
Date:   Fri, 16 Dec 2022 20:53:47 +0000
Message-Id: <20221216205348.3781217-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216205348.3781217-1-willy@infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
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

Remove a use of b_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 929acce6e731..ab9502381b40 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2567,7 +2567,7 @@ static ssize_t reiserfs_quota_write(struct super_block *sb, int type,
 		}
 		lock_buffer(bh);
 		memcpy(bh->b_data + offset, data, tocopy);
-		flush_dcache_page(bh->b_page);
+		flush_dcache_folio(bh->b_folio);
 		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		reiserfs_write_lock(sb);
-- 
2.35.1

