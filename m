Return-Path: <linux-fsdevel+bounces-52295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E573DAE1351
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8D19E17C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE31321CC46;
	Fri, 20 Jun 2025 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N3694PPD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N3694PPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9321B909
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398486; cv=none; b=iwszTmA4mLyZa/bDwVbWJW7Zye4BxSIEfXyt1u3YtyZSzXsA/AvmN/tHRsoTRKWHWdjdtvLvB16joviPDox4ZbXcxY/b51KMXrO1f3UI6ltdOfmzbRT60F1EajnPNxs4FMFbaAB3zmH5zWAuJItM43kEEn8YVr8y3aMpkkEffFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398486; c=relaxed/simple;
	bh=gLxpWopeGzX5i2c+c3DPuEGiBnbwYJ4+Px6kccsfpZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+9QJiQrSIo1ntI4zQrKCTREsw6fNvT/haQM/few8ngcgIjQFHvFE2LIqBc6+nh3DDeF+ecNsRspcrHsEX5qPS8Heiz8AKde+eZAo/tF9jYQBfwQvZXO136tL3Fn5H29KPFcv690tzGv3T0fNgxFmDylsiHT//JxqUu6BSXgN80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N3694PPD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N3694PPD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0F3421216;
	Fri, 20 Jun 2025 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10jRyq8kb8qkCxgdr4H/KvoetlZdaOiijZU9unxTtzY=;
	b=N3694PPDNXRgdpW8vUI1adeUPStZgw/yPcsPsmd6hFk77Iugr4olXDR9h/YktYr9F36TLN
	9LDIPkLnKvAKOgCrOAW6cce4hxllI4zSsCsUrxMophPv1pBnyZcJvc+HWv4XGkSIvqSeCO
	GoHKZkAVF+4QFmU3mB0taBqwOmddc40=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N3694PPD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10jRyq8kb8qkCxgdr4H/KvoetlZdaOiijZU9unxTtzY=;
	b=N3694PPDNXRgdpW8vUI1adeUPStZgw/yPcsPsmd6hFk77Iugr4olXDR9h/YktYr9F36TLN
	9LDIPkLnKvAKOgCrOAW6cce4hxllI4zSsCsUrxMophPv1pBnyZcJvc+HWv4XGkSIvqSeCO
	GoHKZkAVF+4QFmU3mB0taBqwOmddc40=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D1013A99;
	Fri, 20 Jun 2025 05:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aFOZKAn2VGi2NAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 20 Jun 2025 05:47:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 3/6] btrfs: reject delalloc ranges if the fs is shutdown
Date: Fri, 20 Jun 2025 15:17:26 +0930
Message-ID: <3d17c28e603cf001aea2566e6ebc909a165a034e.1750397889.git.wqu@suse.com>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A0F3421216
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

If the filesystem has dirty pages before the fs is shutdown, we should
no longer write them back, instead should treat them as writeback error.

Handle such situation by marking all those delalloc range as error and
let error handling path to clean them up.

For ranges that already have ordered extent created, let them continue
the writeback, and at ordered io finish time the file extent item update
will be rejected as the fs is already marked error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 31feb470fe33..b8eb3153f5e0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -862,6 +862,9 @@ static void compress_file_range(struct btrfs_work *work)
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
 
+	if (unlikely(btrfs_is_shutdown(fs_info)))
+		goto cleanup_and_bail_uncompressed;
+
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
 	/*
@@ -1277,6 +1280,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	unsigned long page_ops;
 	int ret = 0;
 
+	if (unlikely(btrfs_is_shutdown(fs_info))) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+
 	if (btrfs_is_free_space_inode(inode)) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -2027,7 +2035,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	u64 cow_start = (u64)-1;
 	/*
 	 * If not 0, represents the inclusive end of the last fallback_to_cow()
@@ -2047,6 +2055,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
 
+	if (unlikely(btrfs_is_shutdown(fs_info))) {
+		ret = -EIO;
+		goto error;
+	}
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-- 
2.49.0


