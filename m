Return-Path: <linux-fsdevel+bounces-59738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F7EB3D8B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB211793E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9952459E5;
	Mon,  1 Sep 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WsOHJP96";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WsOHJP96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50E244694
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704287; cv=none; b=Vye/gue5/YSPyYn/ZRxtvBZw14jUp34ehTl1e2Bnw1hgmTv8ZnxfKYhox+95n/F3TOnt/oHs9e3+Y9DcjGxygBE3YZrR9g13tFPaTHPNJuO4bPbQim01prw6yIrXYNEHY7kj2xQPKjOb7DLdgepQ00cpjLVSp9OSZZCEoryxpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704287; c=relaxed/simple;
	bh=5ch/VXFpuHtl0240W7QoHxNeg2iPyigm7BaRmWkEXUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kyg4Fd60G4RHAc7CV7PKbBV6roJlbCSR7GvFCJdkaSLCHmUMbImi0WL3mhx05A39Oun7AJwnNlzEFOe8LXW/S9YZGVc/A/gjXdrPonO/1p24fNhvaDQoeETaQ3kVy9eiB1SuRjgXJm1gKuh8b4gIfl3gdIPOkJTDSZZ9LmQzV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WsOHJP96; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WsOHJP96; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8E9D1F393;
	Mon,  1 Sep 2025 05:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGnTRPwkqSHWRMEpULRGp2c2UJfsVxdTPKjJXakPyhU=;
	b=WsOHJP965EidMPLRTUhz5P6wAXfz6t2SSVGUdL0ISVvDq6ecIurkOZIalqP4Mkc64qGKuE
	Om+UUbgwO9C9hjB8GCkMUNRQDuDxZXW+ufP+e0uHNjOFQ0kqx/0YdLBNjKM9wrGc5xTi5i
	Uo95zN6jwGgjwH949EP9ODUTNdajSZw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGnTRPwkqSHWRMEpULRGp2c2UJfsVxdTPKjJXakPyhU=;
	b=WsOHJP965EidMPLRTUhz5P6wAXfz6t2SSVGUdL0ISVvDq6ecIurkOZIalqP4Mkc64qGKuE
	Om+UUbgwO9C9hjB8GCkMUNRQDuDxZXW+ufP+e0uHNjOFQ0kqx/0YdLBNjKM9wrGc5xTi5i
	Uo95zN6jwGgjwH949EP9ODUTNdajSZw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA04613981;
	Mon,  1 Sep 2025 05:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WGGxJgoutWhBJgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 01 Sep 2025 05:24:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] btrfs: cache max and min order inside btrfs_fs_info
Date: Mon,  1 Sep 2025 14:54:04 +0930
Message-ID: <d1a3793b551f0a6ccaf8907cc5aa06d8f5b3d5c2.1756703958.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756703958.git.wqu@suse.com>
References: <cover.1756703958.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Inside btrfs_fs_info we cache several bits shift like sectorsize_bits.

Apply this to max and min folio orders so that every time mapping order
needs to be applied we can skip the calculation.

Furthermore all those sectorsize/nodesize shifts, along with the new
min/max folio orders have a very limited value range by their natures.

E.g. blocksize bits can be at most ilog2(64K) which is 16, and for 4K
page size and 64K block size (bs > ps) the minimal folio order is only
4.
Neither those number can even exceed U8_MAX, thus there is no need to
use u32 for those bits.

Use u8 for those members to save memory.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 6 +++---
 fs/btrfs/disk-io.c     | 2 ++
 fs/btrfs/fs.h          | 8 +++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index df3445448b7d..a9d6e1bfebae 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -527,14 +527,14 @@ static inline void btrfs_update_inode_mapping_flags(struct btrfs_inode *inode)
 
 static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	/* Metadata inode should not reach here. */
 	ASSERT(is_data_inode(inode));
 
 	/* We only allow BITS_PER_LONGS blocks for each bitmap. */
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-	mapping_set_folio_order_range(inode->vfs_inode.i_mapping, 0,
-			ilog2(((BITS_PER_LONG << inode->root->fs_info->sectorsize_bits)
-				>> PAGE_SHIFT)));
+	mapping_set_folio_order_range(inode->vfs_inode.i_mapping, fs_info->block_min_order,
+				      fs_info->block_max_order);
 #endif
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7b06bbc40898..a2eba8bc4336 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3383,6 +3383,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->nodesize_bits = ilog2(nodesize);
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
+	fs_info->block_min_order = ilog2(round_up(sectorsize, PAGE_SIZE) >> PAGE_SHIFT);
+	fs_info->block_max_order = ilog2((BITS_PER_LONG << fs_info->sectorsize_bits) >> PAGE_SHIFT);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 	fs_info->fs_devices->fs_info = fs_info;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5f0b185a7f21..412d3eb30b73 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -820,11 +820,13 @@ struct btrfs_fs_info {
 	struct mutex reclaim_bgs_lock;
 
 	/* Cached block sizes */
-	u32 nodesize;
-	u32 nodesize_bits;
 	u32 sectorsize;
+	u32 nodesize;
 	/* ilog2 of sectorsize, use to avoid 64bit division */
-	u32 sectorsize_bits;
+	u8 sectorsize_bits;
+	u8 nodesize_bits;
+	u8 block_min_order;
+	u8 block_max_order;
 	u32 csum_size;
 	u32 csums_per_leaf;
 	u32 stripesize;
-- 
2.50.1


