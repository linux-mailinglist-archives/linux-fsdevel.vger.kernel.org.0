Return-Path: <linux-fsdevel+bounces-52296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B8AE135B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F08177282
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE3C21D3E9;
	Fri, 20 Jun 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fMH/Cr9z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fMH/Cr9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8721ADAB
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398491; cv=none; b=tp184nKBA50wCLFhi0H3IGOMFwY0RSHGviu6va6GoqSSE7srhQ0qO+XBfNu1kDIf1WTzDCqexecFEDF8+J7jHM3Oxw8Xtg/ze9ucuUTpzQye2T4KooSHBf0SW+6QXUvXio0rFcZaJPhfIWEEIrQbjixbVv6DFaYZT53KvJmE3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398491; c=relaxed/simple;
	bh=BGFEqfR1sJtbR8E9RXeVkYezKfIf81HhZUBl/ZzULDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlJiTOp299kmL4Vw84OchcB2hzhnPgXGvNOaCaVrYoxhT+zJwvbGzX9DwR5XeUGXwlEZzHf5N9cI3M1c/T7Rrv/5/jJwtNaTjO/hn1cY6H467+zG52ejYhjXt5sarjPqNSVdOiBBAxK4N7Y2rTLC48vNyRDtOI4gJokRQGuDotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fMH/Cr9z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fMH/Cr9z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CCBA1F390;
	Fri, 20 Jun 2025 05:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjLnzYyn0667lurX7QbAUHMfzOSrJ4ZFxXfwwPe0Wfc=;
	b=fMH/Cr9zxxo9oRZKk+nSewtESFuZkXGXgX/fZ3J17SsXMXCQHo8007OnYuoEdpeTibXDFe
	qiXlcvnYF3fmqGBmApffCP0a4/EQNuzb/irPkNbW0+mH5yx/FfA1YXl8kP2x7wVzWECzKl
	LItqq+ZwOo37p8ltvmpBCX2UZc1Yuf4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjLnzYyn0667lurX7QbAUHMfzOSrJ4ZFxXfwwPe0Wfc=;
	b=fMH/Cr9zxxo9oRZKk+nSewtESFuZkXGXgX/fZ3J17SsXMXCQHo8007OnYuoEdpeTibXDFe
	qiXlcvnYF3fmqGBmApffCP0a4/EQNuzb/irPkNbW0+mH5yx/FfA1YXl8kP2x7wVzWECzKl
	LItqq+ZwOo37p8ltvmpBCX2UZc1Yuf4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F41A13318;
	Fri, 20 Jun 2025 05:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MHDOBA72VGi2NAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 20 Jun 2025 05:47:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block operation
Date: Fri, 20 Jun 2025 15:17:28 +0930
Message-ID: <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750397889.git.wqu@suse.com>
References: <cover.1750397889.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Currently we already have the super_operations::shutdown() callback,
which is called when the block device of a filesystem is marked dead.

However this is mostly for single(ish) block device filesystems.

For multi-device filesystems, they may afford a missing device, thus may
continue work without fully shutdown the filesystem.

So add a new super_operation::shutdown_bdev() callback, for mutli-device
filesystems like btrfs and bcachefs.

For now the only user is fs_holder_ops::mark_dead(), which will call
shutdown_bdev() if supported.
If not supported then fallback to the original shutdown() callback.

Btrfs is going to add the usage of shutdown_bdev() soon.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/super.c         |  4 +++-
 include/linux/fs.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 21799e213fd7..8242a03bd5ce 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1461,7 +1461,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 		sync_filesystem(sb);
 	shrink_dcache_sb(sb);
 	evict_inodes(sb);
-	if (sb->s_op->shutdown)
+	if (sb->s_op->shutdown_bdev)
+		sb->s_op->shutdown_bdev(sb, bdev);
+	else if (sb->s_op->shutdown)
 		sb->s_op->shutdown(sb);
 
 	super_unlock_shared(sb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..4f6b4b3cbe22 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2363,7 +2363,17 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	/*
+	 * For single-device filesystems. Called when the only block device is
+	 * marked dead.
+	 */
 	void (*shutdown)(struct super_block *sb);
+
+	/*
+	 * For multi-device filesystems. Called when any of its block device is
+	 * marked dead.
+	 */
+	void (*shutdown_bdev)(struct super_block *sb, struct block_device *bdev);
 };
 
 /*
-- 
2.49.0


