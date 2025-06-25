Return-Path: <linux-fsdevel+bounces-53034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C166FAE9303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E7D5A18D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35172D3ED4;
	Wed, 25 Jun 2025 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PHMPOrj8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PHMPOrj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFB28726B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895653; cv=none; b=bJCPkM635COduGmjueHfaSDusV2ft6h/1Z+OQ/WglSiWTcOLl7Kjf8ygpNFxvGzOhszQKhIwadavgniK0yq6nSJKrunYZvk7ev8I8RUUvdq+C8D3Bk63vsRnVW/b/hfSLUI/JXBsWiWyDPmeZwQOheWcnD65n6xkFdimOU2aiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895653; c=relaxed/simple;
	bh=HvupKW54KPa9jGVGpdTdBhlgnBOhWHDD3Nrje2bks+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbIyUfeva4zpm3kIPtAUxO53CJq8xoc2kKTvfLek5RWguepG6x17gCiqbZyYfT64oC2F1S2HHdPDYYdmdbkmI7WNaN5wYsjxVdPhkjv9aLiUXNqSus6saZwo4YUT2EFK6yk1qwR4NSkpi1xblSrY/8toXVE54T4PPNYCbGIxexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PHMPOrj8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PHMPOrj8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A96A31F460;
	Wed, 25 Jun 2025 23:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9xTTixAeKh5LgHSCF0NhpHUPGXFCvwfmlHXjd/8wS0=;
	b=PHMPOrj8Roote4S9gwP5f6XE1omPmAj68qwUOSwqegRvLhalRpnifJbak3wreDXPQYP1ay
	FqvJtuyvMNpRPP6kG8el0n+RqdPSW5DliqG1uYnmE5M9p4ipOdgPMVY+0JDO+E6s3dM3FM
	QJip05LWGxpzwDLwVQsrh31yMVgieMo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9xTTixAeKh5LgHSCF0NhpHUPGXFCvwfmlHXjd/8wS0=;
	b=PHMPOrj8Roote4S9gwP5f6XE1omPmAj68qwUOSwqegRvLhalRpnifJbak3wreDXPQYP1ay
	FqvJtuyvMNpRPP6kG8el0n+RqdPSW5DliqG1uYnmE5M9p4ipOdgPMVY+0JDO+E6s3dM3FM
	QJip05LWGxpzwDLwVQsrh31yMVgieMo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E084213301;
	Wed, 25 Jun 2025 23:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPZLKB+MXGjQMAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 25 Jun 2025 23:54:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
Date: Thu, 26 Jun 2025 09:23:42 +0930
Message-ID: <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750895337.git.wqu@suse.com>
References: <cover.1750895337.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The new remove_bdev() call back is mostly for multi-device filesystems
to handle device removal.

Some multi-devices filesystems like btrfs can have the ability to handle
device lose according to the setup (e.g. all chunks have extra mirrors),
thus losing a block device will not interrupt the normal operations.

Btrfs will soon implement this call back by:

- Automatically degrade the fs if read-write operations can be
  maintained

- Shutdown the fs if read-write operations can not be maintained

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/super.c         |  4 +++-
 include/linux/fs.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 80418ca8e215..07845d2f9ec4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1463,7 +1463,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 		sync_filesystem(sb);
 	shrink_dcache_sb(sb);
 	evict_inodes(sb);
-	if (sb->s_op->shutdown)
+	if (sb->s_op->remove_bdev)
+		sb->s_op->remove_bdev(sb, bdev, surprise);
+	else if (sb->s_op->shutdown)
 		sb->s_op->shutdown(sb);
 
 	super_unlock_shared(sb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..5e84e06c7354 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2367,7 +2367,25 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	/*
+	 * Callback to shutdown the fs.
+	 *
+	 * If a fs can not afford losing any block device, implement this callback.
+	 */
 	void (*shutdown)(struct super_block *sb);
+
+	/*
+	 * Callback to handle a block device removal.
+	 *
+	 * Recommended to implement this for multi-device filesystems, as they
+	 * may afford losing a block device and continue operations.
+	 *
+	 * @surprse:	indicates a surprise removal. If true the device/media is
+	 *		already gone. Otherwise we're prepareing for an orderly
+	 *		removal.
+	 */
+	void (*remove_bdev)(struct super_block *sb, struct block_device *bdev,
+			    bool surprise);
 };
 
 /*
-- 
2.49.0


