Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470DF46137A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376870AbhK2LMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbhK2LKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:10:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EEC0613A1;
        Mon, 29 Nov 2021 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H+baub+SY7kYeZZ2KxU0E3Zwt65gIS5RvPZ323ul08M=; b=MEm5kuP9Cu9W7+Vm7bKuSOW8KI
        eKzIUX+m7EYtzGyc2tl4CctkoEK/Uw1NPYmKrpbt8qQHja2DRh7esyhh3kzz/jgfzj19lpKZoPEnL
        gJcHV65daqC8V5CtDGLfaUxw81bqJip9VLM7EXUkompHytbUHRyYnsZC4cY5Uvzb/A/N9w5xPD9N2
        fRF7DCVC+dFcZxAUHzpPlE3NtKGmIM5zXsP3JmxYyh5TVFnt2OX9nVURe9GHL6vixcNBwHVWW1Zgx
        GBbbDziJZrP0YmACJe0BQl0A5z0tCdd4vQUfoM5+bQEf1nPWzPqGgGFlig8G1fpo1ETMNB0tjEb3b
        5UGbuGAg==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnu-0073UC-9C; Mon, 29 Nov 2021 10:22:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 22/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
Date:   Mon, 29 Nov 2021 11:21:56 +0100
Message-Id: <20211129102203.2243509-23-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While the buffered write iomap ops do work due to the fact that zeroing
never allocates blocks, the DAX zeroing should use the direct ops just
like actual DAX I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 6a0c3b307bd73..9b7f92c6aef33 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1322,7 +1322,7 @@ xfs_zero_range(
 
 	if (IS_DAX(inode))
 		return dax_zero_range(inode, pos, len, did_zero,
-				      &xfs_buffered_write_iomap_ops);
+				      &xfs_direct_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
 				&xfs_buffered_write_iomap_ops);
 }
@@ -1337,7 +1337,7 @@ xfs_truncate_page(
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, did_zero,
-					&xfs_buffered_write_iomap_ops);
+					&xfs_direct_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
-- 
2.30.2

