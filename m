Return-Path: <linux-fsdevel+bounces-53866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B026AF84F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEF17EB80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FA5A79B;
	Fri,  4 Jul 2025 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YeJKic0k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YeJKic0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1A1EEE6
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589784; cv=none; b=A8PGl4//POCaOipHFJ8uSDa0L9rHKUV/hoOH+fAXTFVWQi3FfYODUedD1IMKsu/6NvAHFKwqLjR9jX6baDLK/nWf9N2RXdYytT+J5TtnzffwH/f0RuEqJgs4w9/LY0M5g2j4Cg09Cp791IxhqaqM85ncF/+lpX57a0jlyhWrd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589784; c=relaxed/simple;
	bh=qwL+RRAiCH71PO2k77WNlMx+zbQHoh5WT/KTkbxSpXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCKHDDd/HulSSlK4mOpk8ltkPspi+pPfAEq1I1C8kmoNSsbqHed4Y70vspGlXli3B6VbtUT+Dd7xP5l8aZuioUkL3gMWTjcgd7oWSB2qZKOO6TNSsZraabRl4z1f92oZ4CCf0kfqP9giVJ6OtQ3AV4fxnipcPi1VJP1Dmt/fkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YeJKic0k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YeJKic0k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1572F1F456;
	Fri,  4 Jul 2025 00:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751589779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fISVXiQeUFSkAd0Aj43ViqgfZ/TXb03a/sQHptk4G/Y=;
	b=YeJKic0krYd2S5XW6idTdj7aBC0yYW7Oze0yax3OEA2Y2bz2W4KSMW2/bpTqztbfvnHa2B
	Nuny12arfcOnEG2dM6OslYKGdZh+niucMeDQtlOghPwAW7u1wPzDV1mdLDrT3ZVQXqHItO
	NMprXYBLjQS91XzL+3nadcc33iRl9uc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751589779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fISVXiQeUFSkAd0Aj43ViqgfZ/TXb03a/sQHptk4G/Y=;
	b=YeJKic0krYd2S5XW6idTdj7aBC0yYW7Oze0yax3OEA2Y2bz2W4KSMW2/bpTqztbfvnHa2B
	Nuny12arfcOnEG2dM6OslYKGdZh+niucMeDQtlOghPwAW7u1wPzDV1mdLDrT3ZVQXqHItO
	NMprXYBLjQS91XzL+3nadcc33iRl9uc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 570B213757;
	Fri,  4 Jul 2025 00:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GIGrBpEjZ2hMEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 04 Jul 2025 00:42:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v4 2/6] btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
Date: Fri,  4 Jul 2025 10:12:30 +0930
Message-ID: <71b95f71c2b96769dfca7fc94b57ded4cef4c9e5.1751589725.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751589725.git.wqu@suse.com>
References: <cover.1751589725.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

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


