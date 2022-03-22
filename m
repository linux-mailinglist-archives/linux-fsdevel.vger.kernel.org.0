Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19C4E43AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiCVP72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbiCVP7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151670CE0;
        Tue, 22 Mar 2022 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gE3QTBROAJLL9bQC5tH2wEY8kxAUnxaxWn1SG261S40=; b=bsSGBLG1ySUmfCedHlm/cFMoEp
        UQV9iB9r33ICbG6YXpcAf59tbqHDDNr9uY3VdEQvqHpobLBw1DFKjSQWh7ed50pVZjQ6k3lKmSB8F
        hmOwSWmjq3loNB879uUUicTl6qJXblBoeFIwChYGC8885t4ohb0Qnz2R3M8x+qzrZlOvlMU15XbPL
        haCYCl4MDyHSmfbbwNJkXuHyRjgY8kB1ggSZdFaFW5Ff5k4e6PbDkum6uPPO9UAFkb7uLCL6e+W+V
        tTI8/tu5LMkm8WZhFFSV1QOJGKqZXItB1ClKr0rE7BdOS0sD33YVchzOjrj1TJrTj9V0aUy37OwpJ
        hpGwgsUQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgt6-00Bb6H-Ew; Tue, 22 Mar 2022 15:57:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 34/40] btrfs: add a btrfs_dio_rw wrapper
Date:   Tue, 22 Mar 2022 16:56:00 +0100
Message-Id: <20220322155606.1267165-35-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
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
 fs/btrfs/ctree.h |  4 ++--
 fs/btrfs/file.c  |  6 ++----
 fs/btrfs/inode.c | 11 +++++++++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c22a24ca81652..196f308e3e0d7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3255,9 +3255,9 @@ int btrfs_writepage_cow_fixup(struct page *page);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate);
+ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		     size_t done_before);
 extern const struct dentry_operations btrfs_dentry_operations;
-extern const struct iomap_ops btrfs_dio_iomap_ops;
-extern const struct iomap_dio_ops btrfs_dio_ops;
 
 /* Inode locking type flags, by default the exclusive lock is taken */
 #define BTRFS_ILOCK_SHARED	(1U << 0)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a0179cc62913b..752ef6ecb311d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1967,8 +1967,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 */
 again:
 	from->nofault = true;
-	err = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			   IOMAP_DIO_PARTIAL, written);
+	err = btrfs_dio_rw(iocb, from, written);
 	from->nofault = false;
 
 	/* No increment (+=) because iomap returns a cumulative value. */
@@ -3719,8 +3718,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	 */
 	pagefault_disable();
 	to->nofault = true;
-	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			   IOMAP_DIO_PARTIAL, read);
+	ret = btrfs_dio_rw(iocb, to, read);
 	to->nofault = false;
 	pagefault_enable();
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2eb7e730c2afc..ab3ff4747266a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8050,15 +8050,22 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
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

