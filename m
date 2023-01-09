Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858EC661E56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjAIFS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAIFSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D1D2C8;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UvH9ycUllkHxgh2ZsVpQIK1Y6EVpAeDrvEMZLSZxFIM=; b=LbvKlGSOOBJGYKzPTxzwC51OUM
        4pi+Lu0AKUj5674G9a9HGH2avOJVNKMzAho+9kZg1BLmoaQWZGFapak9qevcs5vCNX4cowDhjDTMy
        fecc/Mp4vTjQxDqsMnH/5D+7oIUueYz/KbNAPa3cSljyAFyidWyyb6gUZ0lx9YaUaNCpo18r76syB
        DIIOJfRRf+AcFziAPXk8JB5K4EdITspdaBq+l84JN1RdFBkFF+cD7zAqa1vPwm8jweofhVKpcmaFM
        i137t3ozQkjZdDD9Vrt8EYXLDGZ808AQNdtpYA+unsLNTlfaq9tJjcQ3MUy87+YUWevUMEmHHRCjb
        WlbLNRRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYD-0020xJ-SI; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/11] cifs: Remove call to filemap_check_wb_err()
Date:   Mon,  9 Jan 2023 05:18:20 +0000
Message-Id: <20230109051823.480289-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_write_and_wait() now calls filemap_check_wb_err(), so we cannot
glean any additional information by calling it ourselves.  It may also
be misleading as it will pick up on any errors since the beginning of
time which may well be since before this program opened the file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 22dfc1f8b4f1..7e7ee26cf77d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3042,14 +3042,12 @@ int cifs_flush(struct file *file, fl_owner_t id)
 	int rc = 0;
 
 	if (file->f_mode & FMODE_WRITE)
-		rc = filemap_write_and_wait(inode->i_mapping);
+		rc = filemap_write_and_wait(file->f_mapping);
 
 	cifs_dbg(FYI, "Flush inode %p file %p rc %d\n", inode, file, rc);
-	if (rc) {
-		/* get more nuanced writeback errors */
-		rc = filemap_check_wb_err(file->f_mapping, 0);
+	if (rc)
 		trace_cifs_flush_err(inode->i_ino, rc);
-	}
+
 	return rc;
 }
 
-- 
2.35.1

