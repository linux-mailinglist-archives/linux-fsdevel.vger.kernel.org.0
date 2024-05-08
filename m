Return-Path: <linux-fsdevel+bounces-19013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4CC8BF676
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310FE281FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE354288AE;
	Wed,  8 May 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="geVAFd3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13151A2C15
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150586; cv=none; b=eZuIi43iQT8umDkCXc9kV35pVK3WD6CFyCWEKIMIKcJrHLBGi2J99AQW+a0fuqimp+wKTUQc8H8CpNvgVbBPLsMoShNHsYVMlIomE5DsOnT28ricsHy8u3yOb7V4yGpSiO2Nx+h71FW6N0bPcTlFOqyE08Ubs+S0ptHpSu8FSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150586; c=relaxed/simple;
	bh=O7/svx19PHGA7RQQM/4haK5NTpzXS0w2J0ej4VFL+I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mp1v9/0F1hkzFPRfAdt4w9cMZZ2ztD/TE+X7wVyw7kMp9twCfhfd/J1Bfc7NAN8RDrUkSSTKbgeax7lZcRzwT1aVjo6np8YZ1Ugne+qk+aKHFK7EjbZnocSxrwCzhq9OQ9PnHelgvzqYbDHtVIY3rBNhCy70iVHp7JGKcg7oJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=geVAFd3A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BtwrkYQuRbDbpdUipdu6pNRU/MfaZ4iN5Z5g3Xeh6Ik=; b=geVAFd3AihCTEppBEMMUdCKVnX
	BOB8/35cFWMzLNcqgnuzDvKTVCAxNzZuip/V7APw+1O6xpfDZt9OBG36c/yW2rsdAvphhpZaJlzcT
	Z94r18mi4LQCErRaIaPBCvgu4WtPu4bfsfLHaDY8kTwx04s7VyIh7oB7/Ben/vCElYWsOci8zmRvU
	Y4sXlkKCURMmGIWJuUEpWTJULNf3uzF1EvT7Pd0Nq/XfHv4BB70ESBvR1FsH2+BncdqVJhxVmnVhU
	Qal7YxEEt98cKvnpdniFoGyN4AWtAigUkYlOUJePhseCFS17QgOAg2tvx2rg5LPsCJzErkbtNdH56
	fA75mBfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b13-00Fvp8-2K;
	Wed, 08 May 2024 06:43:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 1 1/7] ext4: remove block_device_ejected()
Date: Wed,  8 May 2024 07:42:55 +0100
Message-Id: <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508063522.GO2118490@ZenIV>
References: <20240508063522.GO2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Yu Kuai <yukuai3@huawei.com>

block_device_ejected() is added by commit bdfe0cbd746a ("Revert
"ext4: remove block_device_ejected"") in 2015. At that time 'bdi->wb'
is destroyed synchronized from del_gendisk(), hence if ext4 is still
mounted, and then mark_buffer_dirty() will reference destroyed 'wb'.
However, such problem doesn't exist anymore:

- commit d03f6cdc1fc4 ("block: Dynamically allocate and refcount
backing_dev_info") switch bdi to use refcounting;
- commit 13eec2363ef0 ("fs: Get proper reference for s_bdi"), will grab
additional reference of bdi while mounting, so that 'bdi->wb' will not
be destroyed until generic_shutdown_super().

Hence remove this dead function block_device_ejected().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-7-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/super.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9988b3a40b42..b255f798f449 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -492,22 +492,6 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 		schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 }
 
-/*
- * The del_gendisk() function uninitializes the disk-specific data
- * structures, including the bdi structure, without telling anyone
- * else.  Once this happens, any attempt to call mark_buffer_dirty()
- * (for example, by ext4_commit_super), will cause a kernel OOPS.
- * This is a kludge to prevent these oops until we can put in a proper
- * hook in del_gendisk() to inform the VFS and file system layers.
- */
-static int block_device_ejected(struct super_block *sb)
-{
-	struct inode *bd_inode = sb->s_bdev->bd_inode;
-	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
-
-	return bdi->dev == NULL;
-}
-
 static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 {
 	struct super_block		*sb = journal->j_private;
@@ -6172,8 +6156,6 @@ static int ext4_commit_super(struct super_block *sb)
 
 	if (!sbh)
 		return -EINVAL;
-	if (block_device_ejected(sb))
-		return -ENODEV;
 
 	ext4_update_super(sb);
 
-- 
2.39.2


