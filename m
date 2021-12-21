Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B547B938
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 05:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhLUEpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 23:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLUEpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 23:45:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0AC061574;
        Mon, 20 Dec 2021 20:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5rGtk37LcrNh+N9Whvt+Y0DkA2xZOzII17DUWEsUco4=; b=RHHTkbFKO4fVOwSUASIK7/uQSu
        4lmo7CCF6ndRNOTuomIglQUhaJNzfxZ8G6buWvbuscA0/d48eZmGpf6SzaZ/HPgP/8EsHn5pirnG/
        xoMAJvPJ5U1F8tDqdX0iwSp27lfDDXRpgr7IP06y5AtTmliJ7+UktVWgoWP/NmZnjRDrbPH9YEMMP
        v/FiL+h/ies4neEJD6bDtnxY9rBKUWrHpkBxmY9MPUXlHeFyyutkJXN6JKGq/mvcSinjmSCMehDby
        hjvkljFmeyC/KA1mqzRspdtsAaCw2wmJqWWd9FZ52aQf1+01EqWU0ON7u4fJDrpbQmLtOKqhrRqrR
        lcmvkECQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzX1E-002AeV-6f; Tue, 21 Dec 2021 04:44:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iomap: Fix error handling in iomap_zero_iter()
Date:   Tue, 21 Dec 2021 04:44:50 +0000
Message-Id: <20211221044450.517558-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_write_end() does not return a negative errno to indicate an
error, but the number of bytes successfully copied.  It cannot return
an error today, so include a debugging assertion like the one in
iomap_unshare_iter().

Fixes: c6f40468657d ("fsdax: decouple zeroing from the iomap buffered I/O code")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f3176cf90351..955f51f94b3f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -901,8 +901,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		mark_page_accessed(page);
 
 		bytes = iomap_write_end(iter, pos, bytes, bytes, page);
-		if (bytes < 0)
-			return bytes;
+		if (WARN_ON_ONCE(bytes == 0))
+			return -EIO;
 
 		pos += bytes;
 		length -= bytes;
-- 
2.33.0

