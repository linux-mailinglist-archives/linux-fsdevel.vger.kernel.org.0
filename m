Return-Path: <linux-fsdevel+bounces-16698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D78A17EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A21F22975
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE217BCA;
	Thu, 11 Apr 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Vuvi3kUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B8171A2;
	Thu, 11 Apr 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847240; cv=none; b=TGNxN3j083tObFC5C6kWoJPEQ4bhISASDlKu3OOpeSSwoFXVQpfWKmXgVkFVWbazZTfm1UdmpTvznDOckXwHRbF75MNIU0ghg6Z68BeocTMvB7GVcY32drDwEmIj8c3UeGz8akDVYMSTCzegJmMSw/kZyynAYL81ia5fINl+ELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847240; c=relaxed/simple;
	bh=ap3oFZBBuXW17h6a4e4Umhs2ROBQwDIde/NaY9FQPrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7BHfif+HWzO+Htganzr/nCq4/xX1+KVZUSPjdlNpKUzSNd3uk1Ne24z+WoKuAaJbhrC7dTCF8ju4SNI9dEBV3+6B46lRhnewU2dByju3HLoD4h7xuPFPkYisBBuSNPK/qPoQv+gasKSAXMVKZDEqCNdbfHGuV/4d81oWZ4TtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Vuvi3kUW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yZdLjG/il+GlaYVgNdZTGvNnsUIUXz0bS4lPZX5rpxg=; b=Vuvi3kUW5dqJ3/fl3YxgenW8Pl
	VMyctbFk1qGFIIm5Xcz5EXUaRHxLJAH3pe/b15XV0fLOwFX4/wRHpegN0TiRSfoStSM5/yivPvZZ9
	TGGkY6gLnYsJadF5Q1BB1VFVVa1E6PyfQWBruQuMLXKF+Ivfxuq+Rs6dzteeJBim4KyWSilwVwf1w
	cxUKfaBL3VX3/u3bp40g9hqCZeTCWZpO3tSvGw22+5RIi2jtD/u5JGoO4M+MCT060R8u5Va203vkD
	c4q8cRkxxwp2zgMpW57GpL+eQ6TZd5K6ffDwHD0bW0Goc4Ho9TyGIIKgwa+yxjLREo1qphPUtBafG
	IqzmPhjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoB-00AYko-1B;
	Thu, 11 Apr 2024 14:53:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	hch@lst.de,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: [PATCH 07/11] ext4: remove block_device_ejected()
Date: Thu, 11 Apr 2024 15:53:42 +0100
Message-Id: <20240411145346.2516848-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
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
---
 fs/ext4/super.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0be1c3a7ffa0..6e2bd802b50c 100644
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
@@ -6168,8 +6152,6 @@ static int ext4_commit_super(struct super_block *sb)
 
 	if (!sbh)
 		return -EINVAL;
-	if (block_device_ejected(sb))
-		return -ENODEV;
 
 	ext4_update_super(sb);
 
-- 
2.39.2


