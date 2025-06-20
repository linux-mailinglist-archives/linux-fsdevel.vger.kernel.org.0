Return-Path: <linux-fsdevel+bounces-52293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8512AE134D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB919E1648
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB9219307;
	Fri, 20 Jun 2025 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pp3BvkRl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pp3BvkRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD83212B38
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398480; cv=none; b=ub2/G4BkkB9iddo5nfq5hqlXBITJyYHh1x2amUDoifXEZrbA/bEHmgoznP4710NB4X6MNdpToS2/fMjY+ZBfvYScNGvXxmK1KWVh8h5vJ+yWN1WO7kQLcVrmeapEt47GEhnMzkIiX/PYrhQKzXz8xDkq79pjw6fjtstgZWipsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398480; c=relaxed/simple;
	bh=VsSD/0/aEidgD7BHvT7aslFYXDCnm91WaQJXfLx24jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxTZwePPbwwjiX9eYXEX07S+Y2W6+Wgt+FiwyE7VyxVlsitrVnPlbkkAYNytNj93Q6ZIThBcDWZslk9h40tdhRV/hE+zed3uo1jGqHbSzriiabAF+EDC1ydNuJnYGGgY6R73U0KdIQQbQ+QRpMykXz/DbsZIUO52+Hcx8JhvGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pp3BvkRl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pp3BvkRl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E13B21211;
	Fri, 20 Jun 2025 05:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynn3i4/NnovR24X9oGvOwFevLJrx81Yjk2B88pzAtbU=;
	b=Pp3BvkRlgmrxv9mPDMtTPvFw/CWAjpLuJE+Czg9qxczJqbksNrNmZ64HBubTk8b0nAWyqw
	ZQCX9wh/Y0qA+6UoN9o4zr/li+9VS1jTROkxBrvQhj0svy6LG7vJi7iDG2S2WrK73DM5Kp
	1eQcGQJwyOK1dNYWupEfmB/YiDptw9E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynn3i4/NnovR24X9oGvOwFevLJrx81Yjk2B88pzAtbU=;
	b=Pp3BvkRlgmrxv9mPDMtTPvFw/CWAjpLuJE+Czg9qxczJqbksNrNmZ64HBubTk8b0nAWyqw
	ZQCX9wh/Y0qA+6UoN9o4zr/li+9VS1jTROkxBrvQhj0svy6LG7vJi7iDG2S2WrK73DM5Kp
	1eQcGQJwyOK1dNYWupEfmB/YiDptw9E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FF9713318;
	Fri, 20 Jun 2025 05:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8O+qEAX2VGi2NAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 20 Jun 2025 05:47:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 1/6] btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
Date: Fri, 20 Jun 2025 15:17:24 +0930
Message-ID: <043640383b7b062b0099eec1a9e74794016896e5.1750397889.git.wqu@suse.com>
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

This is btrfs' equivalent of XFS_IOC_GOINGDOWN or EXT4_IOC_SHUTDOWN,
after entering the emergency shutdown state, all operations will return
error (-EIO), and can not be bring back to normal state until unmount.

We reuse the existing btrfs_handle_fs_error() function, which will mark
the fs read-only and output an error message.
This allows us to handle put_super() callback as usual, as the fs is
already marked as error and RO, thus we need no special handling.

The only extra thing is to set the EMERGENCY_SHUTDOWN flag to reject
future operations with -EIO.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h       | 18 ++++++++++++++++++
 fs/btrfs/messages.c |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d90304d4e32c..8cc4468a9894 100644
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
 
@@ -1100,6 +1107,17 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
 			   &(fs_info)->fs_state)))
 
+static inline bool btrfs_is_shutdown(struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state);
+}
+
+static inline void btrfs_shutdown(struct btrfs_fs_info *fs_info)
+{
+	btrfs_handle_fs_error(fs_info, -EIO, "filesystem emergency shutdown");
+	set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state);
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
2.49.0


