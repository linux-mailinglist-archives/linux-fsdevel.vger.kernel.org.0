Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3215D778D08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjHKLGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHKLFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26B19AC;
        Fri, 11 Aug 2023 04:05:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A64D1F8A6;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dm65YPBU4WF++93NcPRGO369cin1mb5NbYyvGd96QdM=;
        b=rnFgytbUUSfM1yYlAEV3N0MlVgYnNtYUI/uZIYRClxlsK15vDvg3JUNj4lQtLlS7NO9W59
        3umrFRvx+Dt04JUTb+zDUK6X/9xPE/FaYOowLuTGpPiyoFRY0q15CyLkjSAdirzjvC+Td/
        pQVPfVJvQBHxyWEWhV+Hb1RNkZD1YrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dm65YPBU4WF++93NcPRGO369cin1mb5NbYyvGd96QdM=;
        b=koJjKAtqi+tSuBCmnka8qupqnsy/l+xssfsV98M70AFB/Vphua6mq0DUUwD0JApj03fnFM
        kUhmqENMLrI/R7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CE6913AA3;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VBbDEuIV1mRsRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 296A6A0791; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 18/29] mm/swap: Convert to use bdev_open_by_dev()
Date:   Fri, 11 Aug 2023 13:04:49 +0200
Message-Id: <20230811110504.27514-18-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2720; i=jack@suse.cz; h=from:subject; bh=FDmfvKiq2bPU3yLB5qvHKCGkR05qUs5JO4bCliChJ1c=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXSQQNy+iXJtgc29QwdVw1/9omYyGR1nnhzV2w2 rjBIYu2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV0gAKCRCcnaoHP2RA2auVB/ 9TOquphUJz+/zD06SKTcFzZ5Ihz8Qv4AH+/Y0K2oNQdnpm6oTeRhTVGJJkHhBkq2ZNdeIyh+6vtxNH raAsIOSezmjfRr234tUBor6E/VtlzBiu/a8gQbXu9pm6+tthX5mSLG3jXYxxXzOuunswiaL4I5pUcS Is8x0LNIEL/uNXjJX4UtpRlTEXCy0MNR/0DyXQGrqw3aGrNsD2XNyR4aMzaZ6swS7qXy9Ls3SnxAja r5alxCecit/eNbyzB8+yve8qi1rE0DuyiDz04SzZ5ViT0ua81LE6piK/Z5vfuUmmm+If9chDVBYT9a 62MeMLplsGWXaK9L5nXBJKzndSjQZ0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert swapping code to use bdev_open_by_dev() and pass the handle
around.

CC: linux-mm@kvack.org
CC: Andrew Morton <akpm@linux-foundation.org>
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

