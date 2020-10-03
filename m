Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A252820A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJCCzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgJCCzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08BDC0613D0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZKta8IyxQzIlsMsWMGSxXq7Lrb+niMsj3SuxGqIXdlE=; b=epMjbQoZKaXFlG1WJweps4wrRk
        LYHOQ3HqRbWAXJackMzP+X14XszWFPj+Sf7eVJDcNX/cnmS/kwlJJLxbh8OdO0a4Ca36wxAXELM2C
        itLobyb03d0Y7ovN+fTRw8WviAZHz5eY1TCcQ4OpAF5AT/8a8r5nU22847G3BEydyxnL84P60mDIK
        vlG5AO6u/NYVphEWMfildf+vmBsvXHUxg+pF7N3BApHiuaPZU20HKoREZF/fExuAusOSBw0L+H30A
        VZylo72FB6qUz/C72SnhaQz+AXAOnhHxhp4rXKdHe9J7p98UXQJxFo+prKmVqtrJYL027gMMucJnT
        8QpRNMVA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhx-0005VR-IE; Sat, 03 Oct 2020 02:55:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/13] exec: Pass a NULL pointer to kernel_read
Date:   Sat,  3 Oct 2020 03:55:29 +0100
Message-Id: <20201003025534.21045-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to start at 0 and do not care about the updated value.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/exec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..bb18ff89abcd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1743,10 +1743,8 @@ static int bprm_creds_from_file(struct linux_binprm *bprm)
  */
 static int prepare_binprm(struct linux_binprm *bprm)
 {
-	loff_t pos = 0;
-
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
-	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
+	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, NULL);
 }
 
 /*
-- 
2.28.0

