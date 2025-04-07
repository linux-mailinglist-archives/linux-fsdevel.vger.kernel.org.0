Return-Path: <linux-fsdevel+bounces-45857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA83A7DB02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 12:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB153A9705
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340D32343C0;
	Mon,  7 Apr 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LBGAm51+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LBGAm51+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2E230BF4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021438; cv=none; b=baM/wIlpj947MsIp41en7d0skasvcrh2twR0vUyr1tocqR6mix689rNil9PI5pnBC9x7OBR++VKIDuigqMUpkFnPG5RfO+VLh4q8mKcWeNkAWZC7wx5BxbcwMb7OwzZODWD15pprn6oSjVggLVVlyoSM495NoI+Iy0y0sgSlqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021438; c=relaxed/simple;
	bh=3yL6ihE9Ok8yrhvB+pNCUT769UWlIAV/Saf4lRXVuMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAodFpa8aw6e8neDToczeE2hW/LPi8MuBrCKtzbdzp6MKs9PyNO2b3LUi1NkgzmqCWH/wXmkFN2wKaVoTJC67uTPgT3GGtIkxRY0Rk0kmUtWWl48RkUkRvCcAbjNWdTxfAOMD+W/GMSM1nxxWZGfo4qIrWRck7un5XTsd+7lKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LBGAm51+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LBGAm51+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9E34E2111F;
	Mon,  7 Apr 2025 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744021434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DmOYoQ0io2qlH69OT1JZtBhYBpXaggMtyAFx63Mj3oY=;
	b=LBGAm51+F4SHdymVyYyPnRkUZDdSjUrqWuJnfJd+XVf9+voame+zwAf4uEGsS3IZp+hNCc
	Q2ErgTF+QlkSYBguidohvhkzCqQrwHd5GMNzACcqpVYBrgtzMKjb8IAYHzHJTS/AwlZWQ3
	61GLTOE90ZWerETQUhGdHveNpDy2ABE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744021434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DmOYoQ0io2qlH69OT1JZtBhYBpXaggMtyAFx63Mj3oY=;
	b=LBGAm51+F4SHdymVyYyPnRkUZDdSjUrqWuJnfJd+XVf9+voame+zwAf4uEGsS3IZp+hNCc
	Q2ErgTF+QlkSYBguidohvhkzCqQrwHd5GMNzACcqpVYBrgtzMKjb8IAYHzHJTS/AwlZWQ3
	61GLTOE90ZWerETQUhGdHveNpDy2ABE=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: enable request merging for dir readahead
Date: Mon,  7 Apr 2025 12:23:44 +0200
Message-ID: <20250407102345.50130-1-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,kunlun.arch.suse.cz:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Directory listings that need to access the inode metadata (e.g. via
statx to obtain the file types) of large filesystems with lots of
metadata that aren't yet in dcache, will take a long time due to the
directory readahead submitting one io request at a time which although
targeting sequential disk sectors (up to EXFAT_MAX_RA_SIZE) are not
merged at the block layer.

Add plugging around sb_breadahead so that the requests can be batched
and submitted jointly to the block layer where they can be merged by the
io schedulers, instead of having each request individually submitted to
the hardware queues.

This significantly improves the throughput of directory listings as it
also minimizes the number of io completions and related handling from
the device driver side.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/exfat/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3103b932b674..a46ab2690b4d 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -621,6 +621,7 @@ static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct buffer_head *bh;
+	struct blk_plug plug;
 	unsigned int max_ra_count = EXFAT_MAX_RA_SIZE >> sb->s_blocksize_bits;
 	unsigned int page_ra_count = PAGE_SIZE >> sb->s_blocksize_bits;
 	unsigned int adj_ra_count = max(sbi->sect_per_clus, page_ra_count);
@@ -644,8 +645,10 @@ static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
 	if (!bh || !buffer_uptodate(bh)) {
 		unsigned int i;
 
+		blk_start_plug(&plug);
 		for (i = 0; i < ra_count; i++)
 			sb_breadahead(sb, (sector_t)(sec + i));
+		blk_finish_plug(&plug);
 	}
 	brelse(bh);
 	return 0;
-- 
2.49.0


