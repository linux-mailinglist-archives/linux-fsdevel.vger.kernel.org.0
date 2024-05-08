Return-Path: <linux-fsdevel+bounces-19022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498338BF681
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B67B20D15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B552BB09;
	Wed,  8 May 2024 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q4t65Vy8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE762224D6
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150697; cv=none; b=a/QG7juVQk+Vc55aTbKfuR1dFwX6zC0TjK4pam0SIqyxuo01W1Bu4ESQJSIuk3F1NOPcu+fnIVEHjQsdYhPXUVdHk+rnc+LVDirTt8zSK1/7xOVhXbN2RCAXq7B0dkYokxbx/ntLPYwzz4hkNee9P3SGqsZ8vK6fHE27PwuwMLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150697; c=relaxed/simple;
	bh=PYGssmKIcISfCUZ3VzooHl+1fOwbWIhhwAy0jIYsOH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hs1ZNy/nZqQ0boKvkZGyqL0TVWmYedI+wHj64AQd+5X3EK3R+3z6mVrDQ47NK8rjTQFiPta+caeVP+R9JlgUH3rmr//rCApmgHnjFsKITZAvg6Ohq3+lEydPGevYMwQAAmfZnw5vaEwDakWb2dL86JJirrvKTdC0l3OwBWqMYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Q4t65Vy8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mfqPUTaPhck5tiTVn6eibuvnlRJS0+5Ps3TxrO1JM+4=; b=Q4t65Vy8Dde8yxArD27pl8O0Gi
	qksat3l0Gc71cWzw6SPxR1FfV0P7geAOMlv3e6ir2htjCF1R1QK+vuDW/hmNEPCtur2iN2KkenUvj
	JB1z5l0ty0YuJOmHwMYDZzZdnHbanvomLgQ3oxV9yzb3JJLH40qkLMoWXU3RTjzIebjse27Pu8bsx
	+UNh/DOJ0YjMoT6GpM0+aPAj9NTQ8nyp0/y+BW8dOaDM5ifIJQD+erloy12yNwMXv0bHrxo+1TWTb
	P57zKeq28lc/OLQLz7//Ekg9nE0/mztC0Ywumk0iD9LSDaRs+KSacqt2VmAtUuyK11s3M+7ea8drS
	74Lk2TMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2s-00Fw09-0s;
	Wed, 08 May 2024 06:44:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 10/10] RIP ->bd_inode
Date: Wed,  8 May 2024 07:44:52 +0100
Message-Id: <20240508064452.3797817-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c              | 1 -
 include/linux/blk_types.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index a8c66cc1d6b8..0849a9cfa2b6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -423,7 +423,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
 	bdev->bd_partno = partno;
-	bdev->bd_inode = inode;
 	bdev->bd_mapping = &inode->i_data;
 	bdev->bd_queue = disk->queue;
 	if (partno)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6438c75cbb35..5616d059cb23 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -50,7 +50,6 @@ struct block_device {
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
-	struct inode		*bd_inode;	/* will die */
 	struct address_space	*bd_mapping;	/* page cache */
 
 	atomic_t		bd_openers;
-- 
2.39.2


