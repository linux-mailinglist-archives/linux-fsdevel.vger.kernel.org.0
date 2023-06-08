Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C251728000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjFHMaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFHMaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:30:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F74134
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EScWBpUly43XmjjjdD4wwdvXMFWqSgBIztZj7g+ZMe8=; b=T7KP6y431WK8GeBm0R6CKgAlYM
        zYrZvnZtEGgBGDFXKUPZaKgYgPoXbuosUXoTFjrjzTq2OMIRvPqL+IGVj+xg/h6HVlkCFp+ZhLvAg
        faXWgltpAVADoMdQzDLefpEyg/8VEkzoD6Zk+NGnAMuTksREZMGUnDNxQq+0ApW0HMSrTKW3VtBCl
        IazFd7QGkh6V6umSPQQn5hfKRcZo+v9wkoPjbKCjrX6eFrx3XuHKpKaNrtOI/CxOw6Hx5ZGND1zIc
        Gj+9oVFCxtLhdb2F0nr0KbUUPR7vijCLruZknneg3xNUYjMYBd8A2gA8y+TKR/9ogLu1MUQwyy8RD
        2iOD6OEQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7Em8-009Krl-2F;
        Thu, 08 Jun 2023 12:30:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: unexport buffer_check_dirty_writeback
Date:   Thu,  8 Jun 2023 14:29:58 +0200
Message-Id: <20230608122958.276954-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

