Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC046E2A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 07:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhLIGmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 01:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhLIGmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:42:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1174C0617A2;
        Wed,  8 Dec 2021 22:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=htUwCCtUX9PzaWFdnDFl1fOu5jD7a6JFE1uiwtWNOPg=; b=Ly1440zV0cByQIdm/JOJLcXfce
        Cmkz7+jw/VqfHgFGrbTl71KaS4k2In58H6KfSgRWGaevWPTW2/PS57P45xFxxEIm1B+DgS4RP/0Ex
        1GLC3yln1HyXJ0i4DAvkQ2nPdKoN4gvO6lDsSMJOR5Mt9+DydbBhkCgm0hrP3FKvNQTNVqvtcRhj3
        xurivO4JuBdw6btE8A7e9MB0JsPavzaTJjDFoFTEupuLEykjGP9jc9vT1jiEAatK7CUqVFomhY+7n
        BopT9SE3KODZGIO/I51SZdjBCswHgu2jGA8iG9++UswyJ4Aq7napF1fMe1n6IeRXyJui7v6Dh9BN3
        aLWpjGRw==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvD4X-0096hQ-JJ; Thu, 09 Dec 2021 06:38:30 +0000
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
Subject: [PATCH 1/5] uio: remove copy_from_iter_flushcache() and copy_mc_to_iter()
Date:   Thu,  9 Dec 2021 07:38:24 +0100
Message-Id: <20211209063828.18944-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063828.18944-1-hch@lst.de>
References: <20211209063828.18944-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These two wrappers are never used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/pmem.c |  4 ++--
 include/linux/uio.h   | 20 +-------------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4190c8c46ca88..8294f1c701baa 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -302,8 +302,8 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 }
 
 /*
- * Use the 'no check' versions of copy_from_iter_flushcache() and
- * copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
+ * Use the 'no check' versions of _copy_from_iter_flushcache() and
+ * _copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
  * checking, both file offset and device offset, is handled by
  * dax_iomap_actor()
  */
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

