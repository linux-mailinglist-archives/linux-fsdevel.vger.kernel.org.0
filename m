Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD246E2A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 07:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhLIGmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 01:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhLIGmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:42:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571FCC061746;
        Wed,  8 Dec 2021 22:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ouNiv2rrKa9k8QRwbohahE8DrswboT5nHLE2typSANU=; b=N7Rsz6p6yt49RTrhwjWPSlhceD
        CALFi9S5eAp1bh236cOyKU8rTo3i9jM0Ve/65KnR7XyWCSozmquN1bNVDtfmGmbwJP2yH6h0GCbS7
        yQDwr9YDSUqRlAuXlee/lzt5Rki0HjojpUSkLQVkrFwVgj/B7pr6Ul1Ju7cdbWRe25k/i9bCL71kc
        CrSPLQwg91Sok6ItP+daavYVhqBKZ+cqG3qs2Xi5SfzJgfcuPbNIzXp0hJKw4bz1ndQM7ykVSg47z
        1Fh133uaXd+HQEyu6Xe83YWZwtNGAdulTN089HddpxlBD1XQzIk2ner0wPishkUQppK8mKpuTxdUg
        TWY3Sgag==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvD4d-0096hv-8z; Thu, 09 Dec 2021 06:38:36 +0000
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
Subject: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
Date:   Thu,  9 Dec 2021 07:38:28 +0100
Message-Id: <20211209063828.18944-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063828.18944-1-hch@lst.de>
References: <20211209063828.18944-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While using the MC-safe copy routines is rather pointless on a virtual device
like virtiofs, it also isn't harmful at all.  So just use _copy_mc_to_iter
unconditionally to simplify the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c | 10 ----------
 fs/fuse/virtio_fs.c |  1 -
 include/linux/dax.h |  1 -
 3 files changed, 12 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ff676a07480c8..fe783234ca669 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -107,8 +107,6 @@ enum dax_device_flags {
 	DAXDEV_SYNC,
 	/* do not use uncached operations to write data */
 	DAXDEV_CACHED,
-	/* do not use mcsafe operations to read data */
-	DAXDEV_NOMCSAFE,
 };
 
 /**
@@ -171,8 +169,6 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 	 * via access_ok() in vfs_red, so use the 'no check' version to bypass
 	 * the HARDENED_USERCOPY overhead.
 	 */
-	if (test_bit(DAXDEV_NOMCSAFE, &dax_dev->flags))
-		return _copy_to_iter(addr, bytes, i);
 	return _copy_mc_to_iter(addr, bytes, i);
 }
 
@@ -242,12 +238,6 @@ void set_dax_cached(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(set_dax_cached);
 
-void set_dax_nomcsafe(struct dax_device *dax_dev)
-{
-	set_bit(DAXDEV_NOMCSAFE, &dax_dev->flags);
-}
-EXPORT_SYMBOL_GPL(set_dax_nomcsafe);
-
 bool dax_alive(struct dax_device *dax_dev)
 {
 	lockdep_assert_held(&dax_srcu);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 754319ce2a29b..d9c20b148ac19 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -838,7 +838,6 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	if (IS_ERR(fs->dax_dev))
 		return PTR_ERR(fs->dax_dev);
 	set_dax_cached(fs->dax_dev);
-	set_dax_nomcsafe(fs->dax_dev);
 	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
 					fs->dax_dev);
 }
diff --git a/include/linux/dax.h b/include/linux/dax.h
index d22cbf03d37d2..d267331bc37e7 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -90,7 +90,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 #endif
 
 void set_dax_cached(struct dax_device *dax_dev);
-void set_dax_nomcsafe(struct dax_device *dax_dev);
 
 struct writeback_control;
 #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
-- 
2.30.2

