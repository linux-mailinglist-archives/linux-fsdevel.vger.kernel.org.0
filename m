Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8171B461374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377227AbhK2LMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354515AbhK2LKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:10:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F0C08E9B5;
        Mon, 29 Nov 2021 02:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U05m0uvMr1dYJz1lFGG5yB/r2XP3HjP96H1ucFxFNjg=; b=TmMVPs93egmO+yQCIFCO4JBd6L
        Iu6QXcaWPpKCjhAaAvkZH0L/sY5AJ+IwgWPnE3gU/NHTlZxRFIuV/Qrmhlzpn5tHPY0CR4HUClojA
        gDggyM0tJBjKhOZ4Zd5KJ3C4DJbJR+2KfxMyjQ2qYpBzK8k3ieuNN3BUdM8V3jbv7/Va/zFwiDDxN
        18OJ1rJ0B+4wlqQWEXLu58rtO8Th6SVLhHxWmlsVTSjlzzZ2mtQQdmDmulYJyrl+sd473wwFwemHJ
        fAiYPy8tan9xVHqJVSDHOrPsjNy1QQ6moDpMsT2UvG9v1mQ1ydYkiW+pM31CRjkh8lOqAZPblSc7T
        C6VDPMSQ==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnl-0073Q9-G3; Mon, 29 Nov 2021 10:22:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
Date:   Mon, 29 Nov 2021 11:21:50 +0100
Message-Id: <20211129102203.2243509-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file relative offset must have the same alignment as the storage
offset, so use that and get rid of the call to iomap_sector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5364549d67a48..d7a923d152240 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1123,7 +1123,6 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
-	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	long rc, id;
 	void *kaddr;
@@ -1131,8 +1130,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	unsigned offset = offset_in_page(pos);
 	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 
-	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
-	    (size == PAGE_SIZE))
+	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
 		page_aligned = true;
 
 	id = dax_read_lock();
-- 
2.30.2

