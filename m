Return-Path: <linux-fsdevel+bounces-53857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C6AF8467
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40D91C87320
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BDE2D3A68;
	Thu,  3 Jul 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rw/yMmgw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rw/yMmgw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93692D94A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586177; cv=none; b=LbOaLdGJgZE4EmrG2O/Nzd/e9nsPo35j05yGUMXHbKkEk+0Ml+wJMnAqGn84XkJ2DqqGAy29d6LQ1XUyyZfG+jUWwD2HbL+bd5l67jV3gAS+KEBW8njL2pLskLoSgJIMBB8jx+cR4IqAs+miCDBAzPIRqezk8iyZA6dMJTEefSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586177; c=relaxed/simple;
	bh=qwL+RRAiCH71PO2k77WNlMx+zbQHoh5WT/KTkbxSpXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+E2B4kdwCSnQ6ZG7iraEiBQiTfjweHTQNqNkXI+U4tokgJ8pjPiivFK/IsB/PZuNkORV3D4Bm3nBh3jC9JzBDLYci1wAq2CCtckgT0SDd20r/ixKXkhVQAlsllYeyBqCMO4+3b/eW26pGeOsAf3RW9ojyGxWl92O6z+2yk3l0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rw/yMmgw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rw/yMmgw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A51D221195;
	Thu,  3 Jul 2025 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fISVXiQeUFSkAd0Aj43ViqgfZ/TXb03a/sQHptk4G/Y=;
	b=rw/yMmgwP47qCsxRXk4tbv9Si6DuVHGyYeNkGaHqgaiTa8gqvIfhE59OBAoVklEAI5P6HA
	+jygNbFXF57UxmSgDXE1FdWlJz2U/BncKMqROFHEipCJLT8ekTTBi09oEwlfs5zZBhDegE
	MGzG1iwjblxHDGOe2CgbXuPEvzazKWY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="rw/yMmgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fISVXiQeUFSkAd0Aj43ViqgfZ/TXb03a/sQHptk4G/Y=;
	b=rw/yMmgwP47qCsxRXk4tbv9Si6DuVHGyYeNkGaHqgaiTa8gqvIfhE59OBAoVklEAI5P6HA
	+jygNbFXF57UxmSgDXE1FdWlJz2U/BncKMqROFHEipCJLT8ekTTBi09oEwlfs5zZBhDegE
	MGzG1iwjblxHDGOe2CgbXuPEvzazKWY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E689A13721;
	Thu,  3 Jul 2025 23:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FPHKXIVZ2j7AQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 03 Jul 2025 23:42:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v3 2/6] btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
Date: Fri,  4 Jul 2025 09:12:15 +0930
Message-ID: <189023b233218a37a784506416a8e214038be670.1751577459.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751577459.git.wqu@suse.com>
References: <cover.1751577459.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A51D221195
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

This is btrfs' equivalent of XFS_IOC_GOINGDOWN or EXT4_IOC_SHUTDOWN,
after entering the emergency shutdown state, all operations will return
errors (-EIO), and can not be bring back to normal state until unmount.

A new helper, btrfs_force_shutdown() is introduced, which will:

- Mark the fs as error
  But without flipping the fs read-only.
  This is a special handling for the future shutdown ioctl, which will
  freeze the fs first, set the SHUTDOWN flag, thaw the fs.

  But the thaw path will no longer call the unfreeze_fs() call back
  if the superblock is already read-only.

  So to handle future shutdown correctly, we only mark the fs as error,
  without flipping it read-only.

- Set the SHUTDOWN flag and output an message

New users of those interfaces will be added when implementing shutdown
ioctl support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h       | 28 ++++++++++++++++++++++++++++
 fs/btrfs/messages.c |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5154ad390f31..83d93ef0c451 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -29,6 +29,7 @@
 #include "extent-io-tree.h"
 #include "async-thread.h"
 #include "block-rsv.h"
+#include "messages.h"
 
 struct inode;
 struct super_block;
@@ -120,6 +121,12 @@ enum {
 	/* No more delayed iput can be queued. */
 	BTRFS_FS_STATE_NO_DELAYED_IPUT,
 
+	/*
+	 * Emergency shutdown, a step further than trans aborted by rejecting
+	 * all operations.
+	 */
+	BTRFS_FS_STATE_EMERGENCY_SHUTDOWN,
+
 	BTRFS_FS_STATE_COUNT
 };
 
@@ -1094,6 +1101,27 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
 			   &(fs_info)->fs_state)))
 
+static inline bool btrfs_is_shutdown(struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state);
+}
+
+static inline void btrfs_force_shutdown(struct btrfs_fs_info *fs_info)
+{
+	/*
+	 * Here we do not want to use handle_fs_error(), which will mark
+	 * the fs read-only.
+	 * Some call sites like shutdown ioctl will mark the fs shutdown
+	 * when the fs is frozen. But thaw path will handle RO and RW fs
+	 * differently.
+	 *
+	 * So here we only mark the fs error without flipping it RO.
+	 */
+	WRITE_ONCE(fs_info->fs_error, -EIO);
+	if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state))
+		btrfs_info(fs_info, "emergency shutdown");
+}
+
 /*
  * We use folio flag owner_2 to indicate there is an ordered extent with
  * unfinished IO.
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 363fd28c0268..2bb4bcb7c2cd 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -23,6 +23,7 @@ static const char fs_state_chars[] = {
 	[BTRFS_FS_STATE_NO_DATA_CSUMS]		= 'C',
 	[BTRFS_FS_STATE_SKIP_META_CSUMS]	= 'S',
 	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= 'L',
+	[BTRFS_FS_STATE_EMERGENCY_SHUTDOWN]	= 'E',
 };
 
 static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
-- 
2.50.0


