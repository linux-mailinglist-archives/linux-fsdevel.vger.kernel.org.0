Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511B878562F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjHWKuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjHWKuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986ECE60;
        Wed, 23 Aug 2023 03:49:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0EBD20750;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJnlKAsaBe7sPZrPQ08auxrCcdr7TMUMkg3NCrwvvAc=;
        b=iDDKWdnMHbDv4nwSHrczBOyZD4GVw4sn2o/RXV/rBqMygIZ3dBYsdy86bk1KX8Q/UNpDGR
        Oksuj1/rxd8CWpdHrtga5QKJYnyXdJNXRkhMVG+KNfzzHZmwj7EINCbtYsi+85dAF1MGnl
        9htjoshTWF0/Nw4jpskx9axemvZojJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJnlKAsaBe7sPZrPQ08auxrCcdr7TMUMkg3NCrwvvAc=;
        b=rB4qB/gJfwuSWz1MNhpxj7oTHhvBn4CLc3ep8oawowPA50BWgRE61cwqqmke248sNQZVad
        Dwd9TQowyzRAOEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFED013458;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MmeoMhrk5WRVIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7239CA0792; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 18/29] mm/swap: Convert to use bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:29 +0200
Message-Id: <20230823104857.11437-18-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2762; i=jack@suse.cz; h=from:subject; bh=f/JlRJ3B9MNW3NLuXC/An2yXaaMnt87ViwCq0s9tEUM=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGFKePv7LcNySuWPPvC9SJ5OT7iQvOH5U+MJl8+yj3X0ms0V3 O/GkdzIaszAwcjDIiimyrI68qH1tnlHX1lANGZhBrExgU7g4BWAiO55zMMz8Elovf21lZOKij/Hv4q ZL6TfW53ky/FuirHKlo3+CTusUL7V6Sc1j/cIXXry00J7iJmp0+0305d7G2hNWCkcZlrOeX2PnkBXo KdHB4zS/YnaVZaPAifm3VorsOSHke/pf6y77xt6f5hKix3maT639nSTVd4EnomJB8e9arWdiHP85ts xwkJ9vtdHM/Kxfrnky/9+HzeweX33tTom37Mvk3VrOdeTm2tZ+61WhDnNqstb5197ZeJDhlVKhh060 y1vjO+X9yxUu362yvcitv0jZIDn76ELLS5drpn9av/JKkUfTlUUR83L/On1wKTZ5wLdgXskKubLrlZ ubd83813ZJqu5HYZnujun8e4vMAQ==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

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
index 8e6dde68b389..621428ee6895 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2526,11 +2526,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
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
@@ -2760,13 +2759,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
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
@@ -3210,9 +3210,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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

