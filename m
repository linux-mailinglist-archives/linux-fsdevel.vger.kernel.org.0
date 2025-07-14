Return-Path: <linux-fsdevel+bounces-54796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00969B035B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180FE189ACF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D6207DE2;
	Mon, 14 Jul 2025 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0NMRaE4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N0NMRaE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AF1F4CBB
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470802; cv=none; b=kf4RH78HwVr/2rQDTxlgIGKurBloEujC+TELRNqaSLGGbqBahAa2onSz8+vshDaM11m8hPW1yCXL3ndX6AhKkgA8QxPqHa0tJS5pC+4gRFRlJeaVaI4KSkK9TIsmS60pvY/MzgLztZ8WpGannHbG+sDW03paHTioF6S9bbLOISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470802; c=relaxed/simple;
	bh=SNY75fsY6e7sQeBBeQGBsOTLahuVn3oguHZ1PSrqzgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCKMlSHdESuS4PcFZV8dMcwlA+HsYbiZuYsopdMpnf2/ksmJ49tNoNKU6HVMOBlQb215YkylZ9dPdxbgkQjMtINzQ+T2+yHAcBVeVLPglFHszPPfh/FiRE0kiGeZj2iu+JNBZruCUZq06ZFBxJkZfXfyWCVKA6O94eEfkcLzlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0NMRaE4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N0NMRaE4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F81E211FA;
	Mon, 14 Jul 2025 05:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yN6LJftq+Y0Lt3UmNB9j24MvI31bjWAyDUe94EQG7Gk=;
	b=N0NMRaE4sXtkYtSRkVlfGDlH9uJ2ChT0YOs8cTsmhBmAGTPn8BL91D7rh4tdPaOWxc6mv5
	wNJOpHCSLw0b6yZzWqyJhI6wqConjsYGm/YeemQbqI24fIrij/Ek89p9lv+gK2QUe9lJ8d
	3J42qp/kdDxFz2NP/YbgzEDhSbEG0Fs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N0NMRaE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yN6LJftq+Y0Lt3UmNB9j24MvI31bjWAyDUe94EQG7Gk=;
	b=N0NMRaE4sXtkYtSRkVlfGDlH9uJ2ChT0YOs8cTsmhBmAGTPn8BL91D7rh4tdPaOWxc6mv5
	wNJOpHCSLw0b6yZzWqyJhI6wqConjsYGm/YeemQbqI24fIrij/Ek89p9lv+gK2QUe9lJ8d
	3J42qp/kdDxFz2NP/YbgzEDhSbEG0Fs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D78B13941;
	Mon, 14 Jul 2025 05:26:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CLtiDP+UdGhadQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Jul 2025 05:26:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v5 1/6] fs: add a new remove_bdev() callback
Date: Mon, 14 Jul 2025 14:55:57 +0930
Message-ID: <09909fcff7f2763cc037fec97ac2482bdc0a12cb.1752470276.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8F81E211FA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Currently all filesystems which implement super_operations::shutdown()
can not afford losing a device.

Thus fs_bdev_mark_dead() will just call the ->shutdown() callback for the
involved filesystem.

But it will no longer be the case, as multi-device filesystems like
btrfs and bcachefs can handle certain device loss without the need to
shutdown the whole filesystem.

To allow those multi-device filesystems to be integrated to use
fs_holder_ops:

- Add a new super_operations::remove_bdev() callback

- Try ->remove_bdev() callback first inside fs_bdev_mark_dead()
  If the callback returned 0, meaning the fs can handling the device
  loss, then exit without doing anything else.

  If there is no such callback or the callback returned non-zero value,
  continue to shutdown the filesystem as usual.

This means the new remove_bdev() should only do the check on whether the
operation can continue, and if so do the fs specific handlings.
The shutdown handling should still be handled by the existing
->shutdown() callback.

For all existing filesystems with shutdown callback, there is no change
to the code nor behavior.

Btrfs is going to implement both the ->remove_bdev() and ->shutdown()
callbacks soon.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/super.c         | 11 +++++++++++
 include/linux/fs.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 80418ca8e215..7f876f32343a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1459,6 +1459,17 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	if (!sb)
 		return;
 
+	if (sb->s_op->remove_bdev) {
+		int ret;
+
+		ret = sb->s_op->remove_bdev(sb, bdev);
+		if (!ret) {
+			super_unlock_shared(sb);
+			return;
+		}
+		/* Fallback to shutdown. */
+	}
+
 	if (!surprise)
 		sync_filesystem(sb);
 	shrink_dcache_sb(sb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..6a8a5e63a5d4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2367,6 +2367,15 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	/*
+	 * If a filesystem can support graceful removal of a device and
+	 * continue read-write operations, implement this callback.
+	 *
+	 * Return 0 if the filesystem can continue read-write.
+	 * Non-zero return value or no such callback means the fs will be shutdown
+	 * as usual.
+	 */
+	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
 	void (*shutdown)(struct super_block *sb);
 };
 
-- 
2.50.0


