Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4B51A56A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353393AbiEDQ1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351186AbiEDQ1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 12:27:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8988D4667A;
        Wed,  4 May 2022 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fBVrbe6Bwv56qkohYH6YihFUc4A7+M1nHINpHwxi6xU=; b=rJaED6EOzmgD7azz0LYKszTuG7
        dA4UKGo0pqAyX3jJWNAyPyTUBV14rTvUnxbxpJOZvFoZ0lASJSqUhlcoYX/WLHdFKQJ2oW+Qs0Sp6
        CPaeX0HMxCYhEBJcvBAmPD4/yvQQ4aywd9CpHnzAMPur2I0GQlYcIKfyevpCrqGVA9Mag9td1Qh+c
        LSwRELykidOkWmc38Ln/CZED2wp6+ejvnIDP2LOm5TRhdIAExLvWirgQZ2OrTMiTEMsYTShQmPRAh
        PYcblJ2uGXKS0jyftOYNs8IZiG+NsGmXJZWB9O7VZKUjdUTnzeERJ9Ri7p5xWcDlDtQi5u0I3s6AT
        xDT9ANZg==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmHmy-00BeDT-DM; Wed, 04 May 2022 16:23:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] btrfs: add a btrfs_dio_rw wrapper
Date:   Wed,  4 May 2022 09:23:40 -0700
Message-Id: <20220504162342.573651-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504162342.573651-1-hch@lst.de>
References: <20220504162342.573651-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a wrapper around iomap_dio_rw that keeps the direct I/O internals
isolated in inode.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h |  5 +++--
 fs/btrfs/file.c  |  6 ++----
 fs/btrfs/inode.c | 11 +++++++++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6e939bf01dcc3..aa6e71fdc72b9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3358,9 +3358,10 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			     const struct btrfs_ioctl_encoded_io_args *encoded);
 
+ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		     size_t done_before);
+
 extern const struct dentry_operations btrfs_dentry_operations;
-extern const struct iomap_ops btrfs_dio_iomap_ops;
-extern const struct iomap_dio_ops btrfs_dio_ops;
 
 /* Inode locking type flags, by default the exclusive lock is taken */
 #define BTRFS_ILOCK_SHARED	(1U << 0)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b64fb93d90469..46c2baa8fdf54 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1929,8 +1929,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 */
 again:
 	from->nofault = true;
-	err = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			   IOMAP_DIO_PARTIAL, written);
+	err = btrfs_dio_rw(iocb, from, written);
 	from->nofault = false;
 
 	/* No increment (+=) because iomap returns a cumulative value. */
@@ -3693,8 +3692,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	 */
 	pagefault_disable();
 	to->nofault = true;
-	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			   IOMAP_DIO_PARTIAL, read);
+	ret = btrfs_dio_rw(iocb, to, read);
 	to->nofault = false;
 	pagefault_enable();
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b42d6e7e4049f..cdf96a2472821 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8155,15 +8155,22 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	btrfs_dio_private_put(dip);
 }
 
-const struct iomap_ops btrfs_dio_iomap_ops = {
+static const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
 	.iomap_end              = btrfs_dio_iomap_end,
 };
 
-const struct iomap_dio_ops btrfs_dio_ops = {
+static const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_submit_direct,
 };
 
+ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		size_t done_before)
+{
+	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			   IOMAP_DIO_PARTIAL, done_before);
+}
+
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len)
 {
-- 
2.30.2

