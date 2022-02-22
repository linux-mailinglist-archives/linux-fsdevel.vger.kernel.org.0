Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375664C0256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiBVTtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B4DBA770
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8crDd8W3bTXW+GgyPV1DyiujOdfL3TXU+GKC8sFnXnQ=; b=gTQ+qnhTaJxvXV+n7nYrSnsWw+
        rX9dLG+x0QbR648C4c3suS0Vgb0PxU8tXSUnh6GFKW+K1tR72VluojZnnSPRoYtLlDTyUziCnNQs0
        iuP6s76CXboD3ugobsb538RYy++0R/ol2t2OwvUpUMn4247D9zEnONtLttQ0JFV1DqjmbGDKj/X+r
        5eY0EeOiuT6FiTaaJ5XBrXIz1PwqtCwniyM5krfvfmadnTl6o+atQNiC77+6g+yb4Z3kh8gyKroUL
        Rbk0K7fiF5Z2R8KuLUcOArAS2w8ltJWlK8EJXD+2oTTTI8N3Tfv4Z6BZgem4v2ZFC6lOcCFkvZhdK
        iltwCi5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb97-00360t-7m; Tue, 22 Feb 2022 19:48:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 19/22] affs: Use pagecache_write_begin() & pagecache_write_end()
Date:   Tue, 22 Feb 2022 19:48:17 +0000
Message-Id: <20220222194820.737755-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the convenience wrappers instead of invoking ->write_begin and
->write_end directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/affs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 06645d05c717..1c18f13e8aa1 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -887,9 +887,11 @@ affs_truncate(struct inode *inode)
 		loff_t isize = inode->i_size;
 		int res;
 
-		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, 0, &page, &fsdata);
+		res = pagecache_write_begin(NULL, mapping, isize, 0, &page,
+						&fsdata);
 		if (!res)
-			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, page, fsdata);
+			res = pagecache_write_end(NULL, mapping, isize, 0, 0,
+					page, fsdata);
 		else
 			inode->i_size = AFFS_I(inode)->mmu_private;
 		mark_inode_dirty(inode);
-- 
2.34.1

