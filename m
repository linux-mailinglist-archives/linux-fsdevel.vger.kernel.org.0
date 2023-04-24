Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45FD6EC50F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjDXFtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXFtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:49:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E210CE;
        Sun, 23 Apr 2023 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EScWBpUly43XmjjjdD4wwdvXMFWqSgBIztZj7g+ZMe8=; b=MLLALFsGBXb0yEP6gMC+osLHIV
        LxXX9DY2kTS2XEw2wLe6CXDUGRoxAMHBwXzobLE9Y9zji+azCMLR5NU8y8TLrvKuOMasdYzfEdAbx
        YS0O7LEmtvCsE+U0cmWHT4J2ADCxI6QWaoyVaWpQVUefmWLPSuNZO42MVhHQwB3WxcfClsmoL0JNN
        tN4fQtJUEXSg3i8MJ/wAy3B6Z6igVb8BVPomdBmnhj9Z4ZWBCDswm59W3TtI08owaBDS0Vnv8Jt+Y
        NyKD0hmhBS+Tx5z7HnU1WPDVW85bTSHltv+c4f8A4YPMvyYVqQ6G4LsKmHiql/CpLvwdMS1O4lk1U
        I4zba1cA==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp4v-00FOuH-2z;
        Mon, 24 Apr 2023 05:49:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] fs: unexport buffer_check_dirty_writeback
Date:   Mon, 24 Apr 2023 07:49:10 +0200
Message-Id: <20230424054926.26927-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424054926.26927-1-hch@lst.de>
References: <20230424054926.26927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

buffer_check_dirty_writeback is only used by the block device aops,
remove the export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e1e2add541e07..eb14fbaa7d35f7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -111,7 +111,6 @@ void buffer_check_dirty_writeback(struct folio *folio,
 		bh = bh->b_this_page;
 	} while (bh != head);
 }
-EXPORT_SYMBOL(buffer_check_dirty_writeback);
 
 /*
  * Block until a buffer comes unlocked.  This doesn't stop it
-- 
2.39.2

