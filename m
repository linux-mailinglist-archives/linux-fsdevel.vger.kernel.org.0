Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CA51CA57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385801AbiEEUPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359685AbiEEUPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 16:15:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF15F8F2;
        Thu,  5 May 2022 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xSu6q6f1HTdS9tkh59ToOB06wn8WXvnLrBuqUIUpBQo=; b=0TLefhLWv3kcuM81/ytmlUYWVn
        nQSA8jDnan6MGB3VEFB9R1zfRHwGPWQBpcYtXy/taO5u8AL+hH1BGaq+uIOfKteC5DikVaIaLWY+m
        CWobTXe0T1cmcFuWkNutX4yUKwp4QjcXF4zM9HT70b6fng+Sap5j+qOkI64X1dyU3OjqSIbCz2Jzc
        LuvTHQvR4/xF7yFt7TU2CQSuYZefkEGTsRg/5c4H5MIrZ90ZlDUcZtL6kCCiFXvxBb9ObR8wLSbSO
        NA5iDqOx46cDqz5CI2aQy2F47UXFts9+BWeFEd7HlTpwOUA+KVy7zNWdzCejatsiCoaZk0uh2Wd33
        d+ODURlw==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmhoo-0006jX-Eh; Thu, 05 May 2022 20:11:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] btrfs: remove the disk_bytenr in struct btrfs_dio_private
Date:   Thu,  5 May 2022 15:11:13 -0500
Message-Id: <20220505201115.937837-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220505201115.937837-1-hch@lst.de>
References: <20220505201115.937837-1-hch@lst.de>
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

This field is never used, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h | 1 -
 fs/btrfs/inode.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 32131a5d321b3..14c28213ca0d3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -403,7 +403,6 @@ struct btrfs_dio_private {
 	 * grab the file offset, thus need a dedicated member for file offset.
 	 */
 	u64 file_offset;
-	u64 disk_bytenr;
 	/* Used for bio::bi_size */
 	u32 bytes;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9686f123bf4e3..b1c0c7da6411c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8002,7 +8002,6 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	dip->inode = inode;
 	dip->file_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
-	dip->disk_bytenr = dio_bio->bi_iter.bi_sector << 9;
 	dip->dio_bio = dio_bio;
 	refcount_set(&dip->refs, 1);
 	return dip;
-- 
2.30.2

