Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3A51F177
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiEHUgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiEHUd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81169E006
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2Xve34hjRh2vFPByrJiJ2GP6eKReITIeVdbF5HgAW34=; b=B1FtpQNoobWNv/Fd0rIFxjaWMQ
        Js/P8SYJQDfx2mlfKdU87ICm/N0ZMlR85EohDzr/rg86vMHh1zhyglZRhdAdW8YCMNbvF84LDrDtD
        NtOGs5AKL/Kxpx9eKkCDqqGYuhD/RZf/hOAFF0zot4HdrQvE0YY+wlxrC6TkX+MbEbtYTMlumyPoN
        OQDIuMZ6qzSSg6jn5y1ODmaU2LxvdXZKHSbM1CfiousufNPsNvA5OBVq2SdEBDHZokFxyjnwB54PA
        fG0mBCCoLM103EvTLbleLex+E9AHgv4eX51oLNESlv9k1Yf/QuTBg+wyLxNi5DujyOyh0iHrA6PyK
        HaQJiieQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXT-002nZX-SC; Sun, 08 May 2022 20:29:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 19/25] ntfs3: Remove fsdata parameter from ntfs_extend_initialized_size()
Date:   Sun,  8 May 2022 21:29:35 +0100
Message-Id: <20220508202941.667024-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
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

After the last patch, Smatch reports:

        fs/ntfs3/file.c:168 ntfs_extend_initialized_size()
        error: uninitialized symbol 'fsdata'.

fsdata is indeed unused.  This is not new, but Smatch couldn't see it
before because calls through pagecache_write_begin()/pagecache_write_end()
could theoretically call any implemention of ->write_begin/write_end,
some of which do use fsdata.  Now that the calls are direct, Smatch can
see they're never used.

Fix this by simply passing NULL.  While ntfs3 does pass this parameter
on to generic functions, those generic functions also never dereference
the fsdata parameter, so it's unnecessary to pass the address of a real
pointer.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c2e7e561958a..e61f335c9c63 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -115,7 +115,6 @@ static int ntfs_extend_initialized_size(struct file *file,
 	for (;;) {
 		u32 zerofrom, len;
 		struct page *page;
-		void *fsdata;
 		u8 bits;
 		CLST vcn, lcn, clen;
 
@@ -157,15 +156,14 @@ static int ntfs_extend_initialized_size(struct file *file,
 		if (pos + len > new_valid)
 			len = new_valid - pos;
 
-		err = ntfs_write_begin(file, mapping, pos, len, &page, &fsdata);
+		err = ntfs_write_begin(file, mapping, pos, len, &page, NULL);
 		if (err)
 			goto out;
 
 		zero_user_segment(page, zerofrom, PAGE_SIZE);
 
 		/* This function in any case puts page. */
-		err = ntfs_write_end(file, mapping, pos, len, len, page,
-					  fsdata);
+		err = ntfs_write_end(file, mapping, pos, len, len, page, NULL);
 		if (err < 0)
 			goto out;
 		pos += len;
-- 
2.34.1

