Return-Path: <linux-fsdevel+bounces-54798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB2DB035B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32F37ABFD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705E20E330;
	Mon, 14 Jul 2025 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tJnsOm/c";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tJnsOm/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA501E1DE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470809; cv=none; b=NHL3kMBqJVJprdumAHOmdATYw3+Z2hDIMsS2Hkod5p8QnTn4+oUnVUTHywZ8IQkvkD1DbuRcGMTiz58Rx8iwRiRYoilWy7tQd8jAYGi7N5vxzX9qbowCfzBHQM31C2Jyv2UJu06NDDFb2wTmdVWU+ymiSmxhJj8SmlMESD5qMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470809; c=relaxed/simple;
	bh=3ulhhHEPoWFIITDSoMKod9YIYI+WuRlG+FXbxm6KlQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz7Fx3KR2JZDeYMfuq0GgVkqHfj1a1jFGpYzKGwD9devS0GhMBGCJneRdSDH3DdIcbzolyh4bq1KT5PUvtRTPgaOGmsemF7x8A8v1pPPiKKw9RFP6AieLp4Hjw019XzpBC3iBWftIp955YzjCULCzmq/8KH6WNAD3Zd0Y+QcM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tJnsOm/c; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tJnsOm/c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CE1F2120F;
	Mon, 14 Jul 2025 05:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDHRpM6rWuGozW7RbmAYDuEYzMKnRAAzUdsFGdTN2dU=;
	b=tJnsOm/cbJZgbGHWNs3XO84h0H4Fn8ho/hzwtK4Zm7j3zxglp/fC9APM6HooJ76LayYgyg
	qF/Eweg9u961lgsSzQ6TxOUPBSr3apEaXdci2hz7oi6t2tnD6okYX26mJee/H+/RWHo5xl
	467C8vKb4bYTUTEwxj09UoowMKW46k4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="tJnsOm/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDHRpM6rWuGozW7RbmAYDuEYzMKnRAAzUdsFGdTN2dU=;
	b=tJnsOm/cbJZgbGHWNs3XO84h0H4Fn8ho/hzwtK4Zm7j3zxglp/fC9APM6HooJ76LayYgyg
	qF/Eweg9u961lgsSzQ6TxOUPBSr3apEaXdci2hz7oi6t2tnD6okYX26mJee/H+/RWHo5xl
	467C8vKb4bYTUTEwxj09UoowMKW46k4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B2A1138A1;
	Mon, 14 Jul 2025 05:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iLf6MwGVdGhadQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Jul 2025 05:26:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v5 2/6] btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
Date: Mon, 14 Jul 2025 14:55:58 +0930
Message-ID: <e0de89f8198161ab2315649f851b31d6c6dfe48d.1752470276.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752470276.git.wqu@suse.com>
References: <cover.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3CE1F2120F
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
index 8cc07cc70b12..f0f1d1e47d6c 100644
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
 
@@ -1095,6 +1102,27 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
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


