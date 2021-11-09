Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7502444A8FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbhKIIgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244253AbhKIIgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022B1C0613B9;
        Tue,  9 Nov 2021 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=brXsiud4Cc0AgfRTr4nbCZuEA3TzdfnPNyojG8VnBfw=; b=b+PYedIIgGjCdMCp9JN/B8B1Fz
        nzGeNiytbR6ImqRNS4vswOWH638cDm5VRSAitO6lGR+yV/I/Mz2iufYPGI1Y1GX1IfNXWO7JHC4ld
        fEzA52mVx4lCysgJIIwa69LyDX4hyeuPdKgbYC8DhqLL6Y8vrE5UVY453IQYCupw9RKT4TsXvf2ce
        j+ewr0bulk+Ez7yJgzAmbWDuIKmcUNTufJ5ljbdNaEC9XUayw1afVZIMZLjhbdRsIoNb6B7m+WiJa
        HgAsWfZs/0KGoArpevAcNfqJzQStr/V52bfoKMqM4fyX+hMXZKusk/jwOEJCnVmIpMa7W4rq6AHIj
        j82xNF8w==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZm-000sAK-3U; Tue, 09 Nov 2021 08:33:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 24/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
Date:   Tue,  9 Nov 2021 09:33:04 +0100
Message-Id: <20211109083309.584081-25-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
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
---
 fs/xfs/xfs_iomap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 8cef3b68cba78..704292c6ce0c7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1324,7 +1324,7 @@ xfs_zero_range(
 
 	if (IS_DAX(inode))
 		return dax_zero_range(inode, pos, len, did_zero,
-				      &xfs_buffered_write_iomap_ops);
+				      &xfs_direct_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
 				&xfs_buffered_write_iomap_ops);
 }
@@ -1339,7 +1339,7 @@ xfs_truncate_page(
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, did_zero,
-					&xfs_buffered_write_iomap_ops);
+					&xfs_direct_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
-- 
2.30.2

