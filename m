Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72247547C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 09:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbhLOIpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 03:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbhLOIp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:45:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A2C061574;
        Wed, 15 Dec 2021 00:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iIVq7X1YWsv9JyusL27Whnr/sIBDoiMdZkobuE2AZOk=; b=CsCnDOKBkd5gxuTlrTkODxkZ+E
        D4/Ajn8hXAu87nC9Q62IPGCAdArE5KhzqzRXozPuByYOh3U34gBC4bS2EBYB5jD8tAfsT0DctNmvB
        kcvaidd7h+UEFJmiKWvgAzzqiaVV0Ey3IKB9Z4NgmArY+XY8DfO/nFh4M026NJVMNKsTseMX6SbVi
        U5Q+FdnXKXgbPyHg5v4qXDIFtcwLuKJ2E+NlZeTYV5Te4XRCdgUHxIsi/NGp5B1+FsyKXkpoYgsWW
        +sZFmf+GGso6GWtBS0jHGgJ9/g1G4NdEI3qYVrMx626hjG32fx6dHoUe8x8vUNQZrd1uBvfGep3Ku
        Sf43Piuw==;
Received: from [2001:4bb8:184:5c65:c56:ed89:c020:6100] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxPuQ-00ETyh-BI; Wed, 15 Dec 2021 08:45:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/4] uio: remove copy_from_iter_flushcache() and copy_mc_to_iter()
Date:   Wed, 15 Dec 2021 09:45:05 +0100
Message-Id: <20211215084508.435401-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215084508.435401-1-hch@lst.de>
References: <20211215084508.435401-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These two wrappers are never used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/pmem.c |  4 +---
 include/linux/uio.h   | 20 +-------------------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4190c8c46ca88..d225bcfa67cf9 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -302,9 +302,7 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 }
 
 /*
- * Use the 'no check' versions of copy_from_iter_flushcache() and
- * copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
- * checking, both file offset and device offset, is handled by
+ * Bounds checking, both file offset and device offset, is handled by
  * dax_iomap_actor()
  */
 static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e90..494d552c1d663 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -196,7 +196,7 @@ bool copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /*
  * Note, users like pmem that depend on the stricter semantics of
- * copy_from_iter_flushcache() than copy_from_iter_nocache() must check for
+ * _copy_from_iter_flushcache() than _copy_from_iter_nocache() must check for
  * IS_ENABLED(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) before assuming that the
  * destination is flushed from the cache on return.
  */
@@ -211,24 +211,6 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 #define _copy_mc_to_iter _copy_to_iter
 #endif
 
-static __always_inline __must_check
-size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
-{
-	if (unlikely(!check_copy_size(addr, bytes, false)))
-		return 0;
-	else
-		return _copy_from_iter_flushcache(addr, bytes, i);
-}
-
-static __always_inline __must_check
-size_t copy_mc_to_iter(void *addr, size_t bytes, struct iov_iter *i)
-{
-	if (unlikely(!check_copy_size(addr, bytes, true)))
-		return 0;
-	else
-		return _copy_mc_to_iter(addr, bytes, i);
-}
-
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
-- 
2.30.2

