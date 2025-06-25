Return-Path: <linux-fsdevel+bounces-53036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE48AE9309
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D887ACCDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531F2D3EF6;
	Wed, 25 Jun 2025 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LZ0VdSDu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LZ0VdSDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD22D3EDF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895659; cv=none; b=DTPtPNjNJZOq+ohrtVXsixtnJREvM5OtdYRk4wNTDGaENJZQxpLrTKuo6I3TlUHMzpNZHCgOMLFS6SrHS9Y8xxJTpQ27Y0gvvJ85rQVQxAQ6oli9gL8srUqYDmryY5t5eF/dHjX+D/VZ4GACLW9vcNEeLh7w5YTHCQu5gdc16v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895659; c=relaxed/simple;
	bh=RHiH+YxF73h8yxUe6c0uzEIdhY+jf7mjiuxlg2AG9Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owNgJt/MSvw4WGusn47a+OSxOYmOf5y+qmdGdEyxciZaSdwE77nFBEBbvV9opfkEiC34Lb9+8lxqoXddSvspIEy/MkrTGm57Z9qGDghY9fJr1zHV/9CDXfg02C/sjXAZcDM5g75oX7F8ssFfjhsAzOcIs14cpK8As6/oL74OTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LZ0VdSDu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LZ0VdSDu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3875A1F460;
	Wed, 25 Jun 2025 23:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48Z8zVEjczIoZV1gBHbc2xIpKvwOhFsNSu3lFlgSuQg=;
	b=LZ0VdSDuQEV9VAEeQvVwrkK9IQjQFMxKm/ODOB6luwYsGjYDSvlCdwkpDoAyN/wAZLP4hq
	Y3SSW9WhM8ddlQ/ADEGh1ecZ441d3SUCLd/haf0iiPfFyNeVbKEUU1JHAMXActLxvN43uP
	CNJBhy+gUUJQu24KxE6osNd0JP/Toww=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48Z8zVEjczIoZV1gBHbc2xIpKvwOhFsNSu3lFlgSuQg=;
	b=LZ0VdSDuQEV9VAEeQvVwrkK9IQjQFMxKm/ODOB6luwYsGjYDSvlCdwkpDoAyN/wAZLP4hq
	Y3SSW9WhM8ddlQ/ADEGh1ecZ441d3SUCLd/haf0iiPfFyNeVbKEUU1JHAMXActLxvN43uP
	CNJBhy+gUUJQu24KxE6osNd0JP/Toww=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AD0013301;
	Wed, 25 Jun 2025 23:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBh+DyaMXGjQMAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 25 Jun 2025 23:54:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH 4/6] btrfs: reject delalloc ranges if the fs is shutdown
Date: Thu, 26 Jun 2025 09:23:45 +0930
Message-ID: <4875a74ffbf5d621ab328a8cf891f53c74bf4a35.1750895337.git.wqu@suse.com>
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
index 80c72c594b19..bb2b5d594b14 100644
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


