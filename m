Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D797B0080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjI0Jf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjI0JfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968F61A5;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9BF21FD69;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWox+GLVkjLVVIArakP9cAUUV2iTT/qkhzrRTPlAxvY=;
        b=0uQQory13vukraPr9d3ZIsRgcCSNtW8PxPmOi7dnfuUuHj5eSUaFRwrxiwD4yQ41DCx+hw
        XrwDb5gO5myT/caQmCCGfvR60mOoOY15q/G4+oUC0GetqmpSLcmDE8lIS27k6CFHrvfy6k
        yaMr6RVQZlaPPVAS1lB61+aZznJak08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWox+GLVkjLVVIArakP9cAUUV2iTT/qkhzrRTPlAxvY=;
        b=RHtPBWjH8bnj4QQXU/9yCp/vhm6F7qoYvsffD6eKATkHVC0rihNWfRn1Z6UrgnrD5GhOzB
        OhVOuEBalNWJXIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A614B13AC6;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UpWEKDT3E2UpEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6DC50A07EB; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 18/29] mm/swap: Convert to use bdev_open_by_dev()
Date:   Wed, 27 Sep 2023 11:34:24 +0200
Message-Id: <20230927093442.25915-18-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812; i=jack@suse.cz; h=from:subject; bh=NmUW6gg2Xjg1qi0nO90YIybt1mRlOBGBuQ5XZfWL1m0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cgi531HfB58Kv1WABC5rLfqRXzXB1J0wl+M1Ha 4kdD5OSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3IAAKCRCcnaoHP2RA2XH4B/ wM1xYOKeN8ss1ttRo74EFxM36UMQEjo+LVYNs+FsfHgc7lE3xE5KMbyY9lbA/8mFIRsFw3NC3m73Ja RR74NfA4TsVfmW6Ws6y8+8VS8PDcflw1otRCZlf5qoUn/ct28Cv/50Rg4XSo0JFQ38wMXUnl8ZwIJO jFzE1wVVOhc/ZqwSoCa7P8peKesfnz1UgrppAaRT7Lj9bOfmIYowCtK0kGE1HnvxKKWpIcqG+eOeaJ DoZItVLKblMdhSd980kU9yNNj2SlRhrg03T1Fk4lZ2RfEHJCjaXhY0J0N9IvJ3i0W4TeguWfPX6Ft9 paBF06W9CrZd6RnnsPtLhs2xNnyrzC
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert swapping code to use bdev_open_by_dev() and pass the handle
around.

CC: linux-mm@kvack.org
CC: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 493487ed7c38..f6dd6575b905 100644
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
index e52f486834eb..4bc70f459164 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2530,11 +2530,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
-	if (S_ISBLK(inode->i_mode)) {
-		struct block_device *bdev = I_BDEV(inode);
-
-		set_blocksize(bdev, old_block_size);
-		blkdev_put(bdev, p);
+	if (p->bdev_handle) {
+		set_blocksize(p->bdev, old_block_size);
+		bdev_release(p->bdev_handle);
+		p->bdev_handle = NULL;
 	}
 
 	inode_lock(inode);
@@ -2764,13 +2763,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 	int error;
 
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev = blkdev_get_by_dev(inode->i_rdev,
+		p->bdev_handle = bdev_open_by_dev(inode->i_rdev,
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
@@ -3206,9 +3206,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->percpu_cluster = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
-	if (inode && S_ISBLK(inode->i_mode) && p->bdev) {
+	if (p->bdev_handle) {
 		set_blocksize(p->bdev, p->old_block_size);
-		blkdev_put(p->bdev, p);
+		bdev_release(p->bdev_handle);
+		p->bdev_handle = NULL;
 	}
 	inode = NULL;
 	destroy_swap_extents(p);
-- 
2.35.3

