Return-Path: <linux-fsdevel+bounces-66709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906DC2A042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 05:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 386CD34820D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 04:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94442874E4;
	Mon,  3 Nov 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q4RV0Apv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ODDJZOSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB81DC198
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142871; cv=none; b=DTJ99o1AqLRwEl/3AWoOf956dHiSquofaI+xys1LNf5oQJJfmnbigqvPa3FK2S11kGQuRd1X9Vk+uaZF0c0dOgoOOFmuPDfEzVksCtxENBje9A6opY1sn0nDdNSuMEwBqZQVdVhz81yAXw3uuLtB5VSiB6yZLaXbEIQp5UB8Fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142871; c=relaxed/simple;
	bh=cp2mm6mff7j8S3Cgrm8QLgnCBBRiAtKj9QgsqSpTIeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQkAsLHbji1FKJdq/4XCamrm2u2iwE9mODD9pkyGG42LR6ZvhipYr0byzx9eDS+y9wNdeU/qNQzRsaj+aUmkZrxOD+YsH1FjfqVXcXcY29B2QZMlFPLdqDcos6VKJTy7/HLxbzpW7JWTsItvFeSjSlkrmUYi7QIvbkhqj3pDZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q4RV0Apv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ODDJZOSY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4F1F21EF8;
	Mon,  3 Nov 2025 04:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762142859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyMfOuVKraJZq6KIVKidR48T1DzHLkBMns263MENuWQ=;
	b=q4RV0Apvki6ufer/r2cobd4eJe7Ltf2bFrTfzFaZiEtx+n0FqwUaiXmXA4wUzWP7z5MT3I
	W92Ie+TMe3sLow+Qoz5ibn9u9bOe6Gll1ROVmByEKXOix25gDimLNxraM7mi+vuuh1MeS6
	0h97I2pgyjAbuZLC9ocCOYWw/Qclgxw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ODDJZOSY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762142858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyMfOuVKraJZq6KIVKidR48T1DzHLkBMns263MENuWQ=;
	b=ODDJZOSYj7v3xMnysvY+a5w1hnwIs6nvdR7MyUjI8NFii2XSJtsIYxdSe820kQzsqQjSgg
	sLXFdfIU9RiyNtQ7UoFKhWn8mDrbVyU7ebaRGb5ISV7JHey4EWlgIJMTx/58ClQFG6vAwj
	BFCqwjKc7PC2JzbeLB4rmtrO7abdGwc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD4CF1397D;
	Mon,  3 Nov 2025 04:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aDfIGogqCGnhfAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Nov 2025 04:07:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	Askar Safin <safinaskar@gmail.com>
Subject: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency sync
Date: Mon,  3 Nov 2025 14:37:29 +1030
Message-ID: <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1762142636.git.wqu@suse.com>
References: <cover.1762142636.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4F1F21EF8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[BUG]
There is a bug report that during emergency sync, btrfs only write back
all the dirty data and metadadta, but no full transaction commit,
resulting the super block still pointing to the old trees, thus the end
user can only see the old data, not the newer one.

[CAUSE]
Initially this looks like a btrfs specific bug, since ext4 doesn't get
affected by this one.

But the root problem here is, a combination of btrfs features and the no
wait nature of emergency sync.

Firstly do_sync_work() will call sync_inodes_one_sb() for every fs, to
writeback all the dirty pages for the fs.

Btrfs will properly writeback all dirty pages, including both data and
the updated metadata. So far so good.

Then sync_fs_one_sb() called with @nowait, in the case of btrfs it means
no full transaction commit, thus no super block update.

At this stage, btrfs is only one super block update away to be fully committed.
I believe it's the more or less the same for other fses too.

The problem is the next step, sync_bdevs().
Normally other fses have their super block already updated in the page
cache of the block device, but btrfs only updates the super block during
full transaction commit.

So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
still using its older super block, all pointing back to the old metadata
and data.

Thus if after emergency sync, power loss happened, the end user will
only see the old data, not the newer one, despite that everything but the
super block is already written back.

[FIX]
Since the emergency sync is already executing in a workqueue, I didn't
see much need to only do a nowait sync.
Especially after the fact that sync_inodes_one_sb() always wait for the
writeback to finish.

Instead for the second iteration of sync_fs_one_sb(), pass wait == 1
into it, so fses like btrfs can properly commit its super blocks.

Reported-by: Askar Safin <safinaskar@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/20251101150429.321537-1-safinaskar@gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/sync.c b/fs/sync.c
index 1081cd0e89c7..dd692df54a85 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -121,6 +121,7 @@ SYSCALL_DEFINE0(sync)
 static void do_sync_work(struct work_struct *work)
 {
 	int nowait = 0;
+	int wait = 1;
 
 	/*
 	 * Sync twice to reduce the possibility we skipped some inodes / pages
@@ -130,7 +131,7 @@ static void do_sync_work(struct work_struct *work)
 	iterate_supers(sync_fs_one_sb, &nowait);
 	sync_bdevs(false);
 	iterate_supers(sync_inodes_one_sb, NULL);
-	iterate_supers(sync_fs_one_sb, &nowait);
+	iterate_supers(sync_fs_one_sb, &wait);
 	sync_bdevs(false);
 	printk("Emergency Sync complete\n");
 	kfree(work);
-- 
2.51.2


