Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0024676D29A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjHBPnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjHBPmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:42:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FC187;
        Wed,  2 Aug 2023 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9z6iRUB0HpEH9yVJZ8SKsjwqR2QNW5zkViH5X/SDjhI=; b=i+HYYGUwVQd0cBogaXIV5vo/pL
        zWblj0H6yG//E5OamCxdVKjjA+loZfVwsPHotijZMYyONUsXn+hTKEPyxDUrHsRUHCyDEzKsicFlq
        duF5vCrFzEbsPWaI2grnR07yMIRV3pbVI/44jrUI4J6B4XHIeW+91ZQBEGfYVI9o+NZeD/XBGRQP6
        o03BDUtDrFgof5bL0lrd7JoHdf7A7vgTEDPlp/C4wUx9XWGAuylz3IICKc7G/ZBWEMNj+Ucoc47ZZ
        BcPdWnYJZX9Eb6u3srXrOnd8/GtwLWAbFSXxE0MVQIBm2dAmvbZaDYkJWjeg771VMhLIIxgUqbssB
        Om0i9bfQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDzD-005GL4-1L;
        Wed, 02 Aug 2023 15:42:07 +0000
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
Subject: [PATCH 09/12] ext4: drop s_umount over opening the log device
Date:   Wed,  2 Aug 2023 17:41:28 +0200
Message-Id: <20230802154131.2221419-10-hch@lst.de>
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

Just like get_tree_bdev needs to drop s_umount when opening the main
device, we need to do the same for the ext4 log device to avoid a
potential lock order reversal with s_unmount for the mark_dead path.

It might be preferable to just drop s_umount over ->fill_super entirely,
but that will require a fairly massive audit first, so we'll do the easy
version here first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 193d665813b611..2ccb19d345c6dd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5854,7 +5854,10 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return NULL;
 
+	/* see get_tree_bdev why this is needed and safe */
+	up_write(&sb->s_umount);
 	bdev = ext4_blkdev_get(j_dev, sb);
+	down_write(&sb->s_umount);
 	if (bdev == NULL)
 		return NULL;
 
-- 
2.39.2

