Return-Path: <linux-fsdevel+bounces-53860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7ECAF846F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F2958459B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73862DCF64;
	Thu,  3 Jul 2025 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NRmySyff";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="afKhgYWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335B2DAFC0
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586195; cv=none; b=BkpOc3dPKavpNeZ+MRCC7iI3zWo6J9uVLaeJHH12xwUW3uroO825aZhGpXXO9kegwCFBP67WWxUWffPsGu1AQz9ACTY98DBoecc8inmFhZvsVVwC+ZkmTpzv9qudJRbdaqAbkxMvs0GrS095ZFElmEXaa++wkAQ1Dn5aPyDrwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586195; c=relaxed/simple;
	bh=t6P/3tEMYSNCf2g74ZdaC5k3jMUG/PhoOUVJMnt2yH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAupN0riuParmQD9LFnwocLBtEEAiAtYnrxeXkcSovjNTUBoyQKSeP/z08hBsBvk0BZIT/qOUF5mcpnXuv65IGe8cmgrNoxVF9plWREjBXRjxyY17LlrlT5LDYkEsUS1LferaqfbSDpkIYM42ZGlpBeYwh7hBWU8p0ycZYky4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NRmySyff; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=afKhgYWM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BC8821196;
	Thu,  3 Jul 2025 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEV2R3s7aMNPDo7nLNl4F43yDvW7/1y+Ft4a9kT2ncM=;
	b=NRmySyffZu10xc9ELhPZXz3a6ObwXWohkA3CxLLCHJvXO6pFE9oBe4ZMOCn6shwI6FB6ZI
	ycaA7TnhH/yfiKdOlI49Fow9O0Hlo6fvdzlGUQ9W7lmPIm92PEAW/Q1PUE96JOiU2RCv6P
	dhnlOc9sVWFFs4G7v0GJURbdNQ3c3bc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=afKhgYWM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEV2R3s7aMNPDo7nLNl4F43yDvW7/1y+Ft4a9kT2ncM=;
	b=afKhgYWMHZD6oXgSNP+1o3ACXPOSEEVgs1rSxlWd0wm/xtAGsI58AtrBhwXKmlmQpAtUi+
	zYN5VAKRomevXOF9IrL89kXZ/hvUCU3M+DQ4JfSLJ5lvLF6Dmz3b8mzs8jJQskIJC9Fxdl
	BOT2HoW8xUD/Neq1cq5BqBHInlzShqw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5277013721;
	Thu,  3 Jul 2025 23:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sP2mBXcVZ2j7AQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 03 Jul 2025 23:42:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v3 4/6] btrfs: reject delalloc ranges if in shutdown state
Date: Fri,  4 Jul 2025 09:12:17 +0930
Message-ID: <9a244cade3325e2a5faf0b7391daf57ca2b79037.1751577459.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1BC8821196
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

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
index d7a2ea7d121f..0f0c415e82a2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -861,6 +861,9 @@ static void compress_file_range(struct btrfs_work *work)
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
 
+	if (unlikely(btrfs_is_shutdown(fs_info)))
+		goto cleanup_and_bail_uncompressed;
+
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
 	/*
@@ -1276,6 +1279,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
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
@@ -2026,7 +2034,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	u64 cow_start = (u64)-1;
 	/*
 	 * If not 0, represents the inclusive end of the last fallback_to_cow()
@@ -2046,6 +2054,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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
2.50.0


