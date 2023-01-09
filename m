Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62C661E60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjAIFTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbjAIFS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DECE16;
        Sun,  8 Jan 2023 21:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=h9sfp3qLT5oZoYTMaEr7e7TXlhgkzcAwkjYXoXSr31A=; b=PcO+1hL8pqtTOSY4yjQyps5RAT
        8G47NpMFqRsfCTyyb3fqOkD4nZvLhv1r3FVYZrLgN00r1oeN21QCtKgEmFKzGXeWTCrysJbJ5YCil
        Aen/7Z5sWnYFTkumxQdid4EhfMATxkw91mIj+zVArGyLIan5liKmfdqEW61z3f8VWfKyIhAxEoXFX
        OFPTEcFDp3LtnC3sMgROMruznAor3rlG093CS6uBuQeVaKkIhsONDXkN5aHoXxKuympj6b484oPaV
        jgvthhmyZLyRzVTiLrG9W00eMDs0V5nEXE8hsS2ogRU3/wyaoGYP/GTMBu+Za3JZpHnvcsoysOqXm
        XozSWbbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYD-0020wt-9W; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/11] fuse: Convert fuse_flush() to use file_check_and_advance_wb_err()
Date:   Mon,  9 Jan 2023 05:18:16 +0000
Message-Id: <20230109051823.480289-5-willy@infradead.org>
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

As with fsync, use the newer file_check_and_advance_wb_err() instead
of filemap_check_errors().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 875314ee6f59..7174646ddf09 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -500,11 +500,10 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	fuse_sync_writes(inode);
 	inode_unlock(inode);
 
-	err = filemap_check_errors(file->f_mapping);
+	err = file_check_and_advance_wb_err(file);
 	if (err)
 		return err;
 
-	err = 0;
 	if (fm->fc->no_flush)
 		goto inval_attr_out;
 
-- 
2.35.1

