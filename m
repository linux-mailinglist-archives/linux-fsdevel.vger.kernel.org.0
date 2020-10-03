Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA82820A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgJCCzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgJCCzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D561C0613E5
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=azF4s+OwgCljpUHBjnvPyPfLu7xTfdBTh2YRJ7BzcO8=; b=TkCCLKAtcDrXa3atKimDvn8yim
        0hQ5PKTMerbJDSKrIJwddJrWlvZFpffEG/hN1PiwGIcJKgrvrxkytLipTOHQEFVbJubZrwT5pxmBN
        ibN4vuRAgbzlfNjg43MDBHcnH4x8fGURXUJpagAZrItWArBucSW+yESv+Th+9HZAtGyRvqwlsp8o1
        xF2fMvl9xWMyEBVPsX4sAoeQn7rjxu6gQ8z/xJ/N2bmjDIVt53uFQVkQqIH+fzlbvhjbHSN27wcTS
        aSQBs90QGc5ODFZxOGpbzRGofCnQYCHrhvw+3CJF/mBvGcHZ3sdlfjAXHXqMTdZs/jIldIkk6095i
        9xTOg1NQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhz-0005W4-1G; Sat, 03 Oct 2020 02:55:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/13] usermode: Pass a NULL pointer to kernel_write
Date:   Sat,  3 Oct 2020 03:55:34 +0100
Message-Id: <20201003025534.21045-14-willy@infradead.org>
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
 kernel/usermode_driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index 0b35212ffc3d..ff880befc5bf 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -15,7 +15,6 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 	struct vfsmount *mnt;
 	struct file *file;
 	ssize_t written;
-	loff_t pos = 0;
 
 	type = get_fs_type("tmpfs");
 	if (!type)
@@ -32,7 +31,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 		return ERR_CAST(file);
 	}
 
-	written = kernel_write(file, data, len, &pos);
+	written = kernel_write(file, data, len, NULL);
 	if (written != len) {
 		int err = written;
 		if (err >= 0)
-- 
2.28.0

