Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B338658EC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 17:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiL2QLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 11:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2QKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:10:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6207CFC2;
        Thu, 29 Dec 2022 08:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fEUbsjBI9KXdP6pghJ78AVl7+BFXIZGKll0p9tWCLUk=; b=t1S2jL2DHoW16PA0jk/pbHQHDg
        RBs4GhrpF9YeRdVoZ5tq9A1aPdJeOjq91lfo7o5iKcunokcstvPbjfOb5C1qHOTZBoAGzMEgZ25d9
        C5o7gFDbOXlZVoosJgILi0a9I3LR4lGcXGGPpDxMY8Z08Fs+hik9wVwCAUkCmR2OV7rxGJJyr2hjp
        Zv4kGbTY2mD5jY+OJ8lwVOyAR4ZX1bDl+ikdrDdlU07hOw7f3AsQUBG1SNmOv77SPXjK1JIImv2No
        Dbh0w8jo37mco9XgGK5mLl24utTvSDtaTj3J5LiN5/5CGoVanfP2Q7XBUN+yCvVYGXOsn3vy9A0Al
        FxMX+glA==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvUK-00HKL2-18; Thu, 29 Dec 2022 16:10:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: [PATCH 1/6] fs: remove an outdated comment on mpage_writepages
Date:   Thu, 29 Dec 2022 06:10:26 -1000
Message-Id: <20221229161031.391878-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229161031.391878-1-hch@lst.de>
References: <20221229161031.391878-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mpage_writepages doesn't do any of the page locking itself, so remove
and outdated comment on the locking pattern there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0f8ae954a57903..910cfe8a60d2e4 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -641,14 +641,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
  *
  * This is a library function, which implements the writepages()
  * address_space_operation.
- *
- * If a page is already under I/O, generic_writepages() skips it, even
- * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
- * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
- * and msync() need to guarantee that all the data which was dirty at the time
- * the call was made get new I/O started against them.  If wbc->sync_mode is
- * WB_SYNC_ALL then we were called for data integrity and we must wait for
- * existing IO to complete.
  */
 int
 mpage_writepages(struct address_space *mapping,
-- 
2.35.1

