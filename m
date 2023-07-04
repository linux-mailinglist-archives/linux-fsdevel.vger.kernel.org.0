Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6287470FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGDMXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjGDMXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399A1703;
        Tue,  4 Jul 2023 05:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A18822873;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdnEy6doZuj4T4K7nSzTIyIECtQFFVt3/RzDP88gsmY=;
        b=a81BmTCZ90hLkXKtL+oiXj66o12wEJNqm/5N+YhSzQN//2u76/Sx/Ix2IzjSd2/ieb0Izd
        L1C0d9f7SEEFrpVNL1TLjbeBzGvcTpJYG4FMamPZHYghYBGMRk3zka0XU61wA63v6wqVX1
        uWHCCk/yQiEzKPBOl5UqSaLQoClKgwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdnEy6doZuj4T4K7nSzTIyIECtQFFVt3/RzDP88gsmY=;
        b=Cm9YT4HtRVGdabVASUQcZymzmzyV9VOKtf4HzOMxaRIqr1Q9vWi5U4iD7mqh2LYosKOtIu
        5TQo9zlahslRH/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59B9513A98;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /63gFQIPpGREMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0CA26A077D; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 19/32] mm/swap: Convert to use blkdev_get_handle_by_dev()
Date:   Tue,  4 Jul 2023 14:21:46 +0200
Message-Id: <20230704122224.16257-19-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=jack@suse.cz; h=from:subject; bh=wVpmIfN/eR5Ua8hSYo1mzxPGdVVPf7LYMVYIJFGGkHQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7bCKbxtHM46e9K00CmUmLKjtHbRBO9emBILVuZ hg9lmwOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO2wAKCRCcnaoHP2RA2ZCWB/ 9gpG67tIbc+Tvq85swoTN5lhCJ84EUHxZ+l5N6M6RpnR6hh+jUdzysCV/gfzdf1IbOkpwLhbsByeDB NQK6WTFg6tM7pUKTgqv/9CZqTqZO2ZB0/tgItgl6jf5ZirEuiXBAj45bkJ4h2HrruVsjBt4B4LX9L/ py35F0C37hdadhgcSfE9tc+xYWd3bolllxfISCrrBWE3c4Wi5DFCN9K749Vkfr4MxWifCJvhyxx/Bg aU9voIO+nVorMt8dwQgXwJlfWefUHOqn7RsZbwmNrvt4QHtSHaBMIfyXBLP29YS9QqPnq9s8ih2F+V KexxrhIyaScM7/+txmNwayQDHvcUcx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert swapping code to use blkdev_get_handle_by_dev() and pass the
handle around.

CC: linux-mm@kvack.org
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 456546443f1f..62334f8d4932 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,6 +298,7 @@ struct swap_info_struct {
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
+	struct bdev_handle *bdev_handle;/* open handle of the bdev */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
 	unsigned int old_block_size;	/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8e6dde68b389..dbd37aa4724d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2526,11 +2526,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
-	if (S_ISBLK(inode->i_mode)) {
-		struct block_device *bdev = I_BDEV(inode);
-
-		set_blocksize(bdev, old_block_size);
-		blkdev_put(bdev, p);
+	if (p->bdev_handle) {
+		set_blocksize(p->bdev, old_block_size);
+		blkdev_handle_put(p->bdev_handle);
 	}
 
 	inode_lock(inode);
@@ -2760,13 +2758,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 	int error;
 
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev = blkdev_get_by_dev(inode->i_rdev,
+		p->bdev_handle = blkdev_get_handle_by_dev(inode->i_rdev,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
-		if (IS_ERR(p->bdev)) {
-			error = PTR_ERR(p->bdev);
-			p->bdev = NULL;
+		if (IS_ERR(p->bdev_handle)) {
+			error = PTR_ERR(p->bdev_handle);
+			p->bdev_handle = NULL;
 			return error;
 		}
+		p->bdev = p->bdev_handle->bdev;
 		p->old_block_size = block_size(p->bdev);
 		error = set_blocksize(p->bdev, PAGE_SIZE);
 		if (error < 0)
@@ -3210,9 +3209,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->percpu_cluster = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
-	if (inode && S_ISBLK(inode->i_mode) && p->bdev) {
+	if (p->bdev_handle) {
 		set_blocksize(p->bdev, p->old_block_size);
-		blkdev_put(p->bdev, p);
+		blkdev_handle_put(p->bdev_handle);
 	}
 	inode = NULL;
 	destroy_swap_extents(p);
-- 
2.35.3

