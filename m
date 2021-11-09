Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D346744A8CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbhKIIgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244196AbhKIIgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9434BC061767;
        Tue,  9 Nov 2021 00:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zfCI/U8WTukvUOFF16NcuXhCNGsYjAKrDL4zQNucYJY=; b=o6GhNxlQ3IOt/+NcSH7pkNZyIL
        e2NSHpEgG9tiBm0dYKfFQsF4fAAYNym9zC+t/oW68Brq6whz7Cii35gCwCKYHwTVndsoeduiVYmUU
        Q801npG6fplWZawdN/5aJPLAtwfswvRBf/64Q7wOP1Dm1K7qDH0oTzbj4ICmluRQbgiYJxppS8Dyq
        nmjKrkOjW6ZuxyH4A718D3Pb5Io8KoSUtQMHFkso1tiV5r1efOgc5GVO5cgOJ+sDzKB+KCL0eafbU
        mBvauGwx5vGzElAKrv1yl8LYZP+pskH0bgRrmWiKl7zcxgKmqUdOOx76gDAbJy66nOvQsYHxFG+Ts
        VRdqkklQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZa-000s5E-1A; Tue, 09 Nov 2021 08:33:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
Date:   Tue,  9 Nov 2021 09:32:56 +0100
Message-Id: <20211109083309.584081-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file relative offset must have the same alignment as the storage
offset, so use that and get rid of the call to iomap_sector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

