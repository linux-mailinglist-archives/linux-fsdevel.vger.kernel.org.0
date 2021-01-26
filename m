Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3F3041C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406127AbhAZPL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406065AbhAZPLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:11:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E6C061A31;
        Tue, 26 Jan 2021 07:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o7VUFbuCs40X37XHTmVmjDE9l+0qzfo+L5D5+3HB/Xs=; b=aV79kHDk99zhkL6s5WblnMsXYm
        MUeYdtQAir6ZpBM6WxTX2uHNWa9GoJblM5+y9lvBViksx2RanhFgtOVoykjDrNKUAASUImAhQ2S9S
        kCfJVL4xwzijj26ZqmZV0RNsrXFPbf4N+/Nr6bUnSe70GhYydpXzWfT1u3SDcEBkvvxsPZwC5/Opl
        QrXnJfVNQdYsJMZo5rcHFwaYuDhpw+B9jZZ2qD3QFDvKwydp8nBngTufhjUIOGN8sMm7ejCwV76Ba
        wQKngqSt6P9/gxTf3mYfoWEoeugpEM9qEEobeCMKiVADWZmeomcieNiE/g3oi2zy++X/iQc0gI0gY
        x6aONCMg==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4PuS-005nI7-1q; Tue, 26 Jan 2021 15:06:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 08/17] f2fs: remove FAULT_ALLOC_BIO
Date:   Tue, 26 Jan 2021 15:52:38 +0100
Message-Id: <20210126145247.1964410-9-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sleeping bio allocations do not fail, which means that injecting an error
into sleeping bio allocations is a little silly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/f2fs.rst |  1 -
 fs/f2fs/data.c                     | 29 ++++-------------------------
 fs/f2fs/f2fs.h                     |  1 -
 fs/f2fs/super.c                    |  1 -
 4 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index dae15c96e659e2..624f5f3ed93e86 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -179,7 +179,6 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_KVMALLOC		  0x000000002
 			 FAULT_PAGE_ALLOC	  0x000000004
 			 FAULT_PAGE_GET		  0x000000008
-			 FAULT_ALLOC_BIO	  0x000000010
 			 FAULT_ALLOC_NID	  0x000000020
 			 FAULT_ORPHAN		  0x000000040
 			 FAULT_BLOCK		  0x000000080
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0cf0c605992431..9fb6be65592b1f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -50,28 +50,6 @@ void f2fs_destroy_bioset(void)
 	bioset_exit(&f2fs_bioset);
 }
 
-static inline struct bio *__f2fs_bio_alloc(gfp_t gfp_mask,
-						unsigned int nr_iovecs)
-{
-	return bio_alloc_bioset(gfp_mask, nr_iovecs, &f2fs_bioset);
-}
-
-static struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages,
-		bool noio)
-{
-	if (noio) {
-		/* No failure on bio allocation */
-		return __f2fs_bio_alloc(GFP_NOIO, npages);
-	}
-
-	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
-		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
-		return NULL;
-	}
-
-	return __f2fs_bio_alloc(GFP_KERNEL, npages);
-}
-
 static bool __is_cp_guaranteed(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
@@ -433,7 +411,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	struct f2fs_sb_info *sbi = fio->sbi;
 	struct bio *bio;
 
-	bio = f2fs_bio_alloc(sbi, npages, true);
+	bio = bio_alloc_bioset(GFP_NOIO, npages, &f2fs_bioset);
 
 	f2fs_target_device(sbi, fio->new_blkaddr, bio);
 	if (is_read_io(fio->op)) {
@@ -1029,8 +1007,9 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	struct bio_post_read_ctx *ctx;
 	unsigned int post_read_steps = 0;
 
-	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES),
-								for_write);
+	bio = bio_alloc_bioset(for_write ? GFP_NOIO : GFP_KERNEL,
+			       min_t(int, nr_pages, BIO_MAX_PAGES),
+			       &f2fs_bioset);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 902bd3267c03e1..6c78365d80ceb5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -43,7 +43,6 @@ enum {
 	FAULT_KVMALLOC,
 	FAULT_PAGE_ALLOC,
 	FAULT_PAGE_GET,
-	FAULT_ALLOC_BIO,
 	FAULT_ALLOC_NID,
 	FAULT_ORPHAN,
 	FAULT_BLOCK,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b4a07fe62d1a58..3a312642907e86 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -45,7 +45,6 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_KVMALLOC]	= "kvmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
 	[FAULT_PAGE_GET]	= "page get",
-	[FAULT_ALLOC_BIO]	= "alloc bio",
 	[FAULT_ALLOC_NID]	= "alloc nid",
 	[FAULT_ORPHAN]		= "orphan",
 	[FAULT_BLOCK]		= "no more block",
-- 
2.29.2

