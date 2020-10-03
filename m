Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5D2820A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJCCzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJCCzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F12C0613D0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D6EakYF26AfgUDfppQBvwIj90vFr/E4OGScg8gZc1Kg=; b=b+TbMmI/HDyCae9bHYArD9vd7j
        MZHF8rdokylRPkWVwIJP5Q88m/AQqAPSKmJ0qLnmAwINySrrRCAM5gAt5ZvzW4Ofmrfq4WIs6LRpI
        BOLal6zUvc2XdS6Gvol6ClhKUW5xWP77FBXUZKnlI0unjAQTsCbIdlqxnZMCDUUhK2t8DZWUnDfxy
        WNlr9gopeDSnt5xBoz8w/ZXLWx6rAykvtvHlWLnKoMIKhkGIw87R5HUByzsobLA+//eqMlhIQZEG4
        sCZDajFMPYdOScdOmeBwCbFVD8TlBHQLGvVXqwguwJ9lP2yqxXnSg515nZmz5hUeoUFgx6bN0qM1E
        1H6FfV6w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhx-0005V9-11; Sat, 03 Oct 2020 02:55:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/13] aout: Pass a NULL pointer to kernel_read
Date:   Sat,  3 Oct 2020 03:55:27 +0100
Message-Id: <20201003025534.21045-7-willy@infradead.org>
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
 fs/binfmt_aout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 3e84e9bb9084..6e7fea50523d 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -259,12 +259,11 @@ static int load_aout_library(struct file *file)
 	unsigned long error;
 	int retval;
 	struct exec ex;
-	loff_t pos = 0;
 
 	inode = file_inode(file);
 
 	retval = -ENOEXEC;
-	error = kernel_read(file, &ex, sizeof(ex), &pos);
+	error = kernel_read(file, &ex, sizeof(ex), NULL);
 	if (error != sizeof(ex))
 		goto out;
 
-- 
2.28.0

