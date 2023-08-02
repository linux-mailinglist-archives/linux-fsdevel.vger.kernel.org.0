Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B476D2AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjHBPne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjHBPmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:42:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529B212D;
        Wed,  2 Aug 2023 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZozxeyMGKtkHoR7QtYaUPrxcN8fxX1IcTx0bj1m0eVM=; b=tmx+7o4GP5sBLM4xYrSsgh9Bda
        +QbMMfDpv1DNC4tqjwNcuPtyVRBYZ5oHVHlh96dQf4IlYjTn55/fw/emJuHrTvhSTgLn4CKM9zq4t
        yT98ZOv03AtsAwaRoj6DqU98ep41F8AzGg/vBGkfVEdAUr4avk2zKXcHV0RtlssyfziJvzMueYqIu
        KhQzE7/xrzzJxOSxfghcWbWDsTFToL/ymn6ov4rjA65Xpl2PHUsmr14itMLIKsS6o6PNsi4Ntd7Pn
        Had/kLEX3WJqsmYXpRsZO5n2YtV4JiZvaKZR7L9CDniwRiSZTphwqLxU2Uxztca27xF+6dVMKrhoR
        wAcOwFaA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDzA-005GKj-0K;
        Wed, 02 Aug 2023 15:42:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 08/12] fs: export fs_holder_ops
Date:   Wed,  2 Aug 2023 17:41:27 +0200
Message-Id: <20230802154131.2221419-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154131.2221419-1-hch@lst.de>
References: <20230802154131.2221419-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export fs_holder_ops so that file systems that open additional block
devices can use it as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c             | 3 ++-
 include/linux/blkdev.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 0cda4af0a7e16c..dac05f96ab9ac8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1244,9 +1244,10 @@ static void fs_mark_dead(struct block_device *bdev)
 	up_read(&sb->s_umount);
 }
 
-static const struct blk_holder_ops fs_holder_ops = {
+const struct blk_holder_ops fs_holder_ops = {
 	.mark_dead		= fs_mark_dead,
 };
+EXPORT_SYMBOL_GPL(fs_holder_ops);
 
 static int set_bdev_super(struct super_block *s, void *data)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629f5..83262702eea71a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1464,6 +1464,8 @@ struct blk_holder_ops {
 	void (*mark_dead)(struct block_device *bdev);
 };
 
+extern const struct blk_holder_ops fs_holder_ops;
+
 /*
  * Return the correct open flags for blkdev_get_by_* for super block flags
  * as stored in sb->s_flags.
-- 
2.39.2

