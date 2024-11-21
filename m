Return-Path: <linux-fsdevel+bounces-35428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12C9D4BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE88E1F21A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F0A1DE3BD;
	Thu, 21 Nov 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QlV1S2h+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YUhKzjAo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QlV1S2h+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YUhKzjAo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AF1D9A66;
	Thu, 21 Nov 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188154; cv=none; b=clxoboEV37tx2TMJHc7wmRiCLUrYxXDlZ9zMr+HAzmoQw9LlU3JGQiWfAJ5GYxh/96vHf4/9iTV/Kh6/5XCJO94m6s/TRvj2IN20kIk2Uu8tjiNZ3pKYrzorTyIl+otxC+IGBjF3Ps1Ye276sHjmiywmZA8qvII5We9xCt0cmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188154; c=relaxed/simple;
	bh=pZHfGJR0R0RLbu18dhrfGKiT8OiWksOXI+k72Zg9gUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2m7jSxpNswtTxLth+fvtspNAxzKohylsMHrXjrJChL924z06BWeUGsLWd52iad0O5VSyobPBA/5/4/ibnERIKb8DpeBUT/2KqdsOGFxUjx3fXCMqRriR8gvV0lLpoH35fgi5u1k0FaThg0N9+KjYUFIAl/tl9uAerrD1hYfSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QlV1S2h+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YUhKzjAo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QlV1S2h+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YUhKzjAo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C11D01F802;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNXKIooKmDN7lsLja3Qn4DQNYnh1LdTktk6J4bSg71E=;
	b=QlV1S2h+xd23+4a8YG06xuyShqMaNKuWlJp9V34L+ZWqZLH1Cp/l1ilq2NQn5iN3aEeF5V
	VSrVcK6PbP9KCZ6uR034BR1+X2XgeUmbGBIAWd8LDoqiZZnktQ48xkX70l6PQo4eApUQOU
	XGRYwMvimGEcnnHXzMr7TD7+czPuAbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNXKIooKmDN7lsLja3Qn4DQNYnh1LdTktk6J4bSg71E=;
	b=YUhKzjAoRO1JpjX5ENW4+IIwXUKJx7w6f/00v6F6A1wimubLShWTK3pOAENAVg59hWiWw/
	jaUu26D5Tk+UpWBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNXKIooKmDN7lsLja3Qn4DQNYnh1LdTktk6J4bSg71E=;
	b=QlV1S2h+xd23+4a8YG06xuyShqMaNKuWlJp9V34L+ZWqZLH1Cp/l1ilq2NQn5iN3aEeF5V
	VSrVcK6PbP9KCZ6uR034BR1+X2XgeUmbGBIAWd8LDoqiZZnktQ48xkX70l6PQo4eApUQOU
	XGRYwMvimGEcnnHXzMr7TD7+czPuAbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNXKIooKmDN7lsLja3Qn4DQNYnh1LdTktk6J4bSg71E=;
	b=YUhKzjAoRO1JpjX5ENW4+IIwXUKJx7w6f/00v6F6A1wimubLShWTK3pOAENAVg59hWiWw/
	jaUu26D5Tk+UpWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5B9613A7D;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ofy9LPAXP2dHfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 48A28A08FA; Thu, 21 Nov 2024 12:22:24 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 16/19] xfs: add pre-content fsnotify hook for DAX faults
Date: Thu, 21 Nov 2024 12:22:15 +0100
Message-Id: <20241121112218.8249-17-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,kernel.org,linux-foundation.org,ZenIV.linux.org.uk,vger.kernel.org,kvack.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,msgid.link:url];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -6.80
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

xfs has it's own handling for DAX faults, so we need to add the
pre-content fsnotify hook for this case. Other faults go through
filemap_fault so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/9eccdf59a65b72f0a1a5e2f2b9bff8eda2d4f2d9.1731684329.git.josef@toxicpanda.com
---
 fs/xfs/xfs_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 412b1d71b52b..8b1bfb149b2c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1395,6 +1395,9 @@ xfs_dax_read_fault(
 	struct xfs_inode	*ip = XFS_I(file_inode(vmf->vma->vm_file));
 	vm_fault_t		ret;
 
+	ret = filemap_fsnotify_fault(vmf);
+	if (unlikely(ret))
+		return ret;
 	xfs_ilock(ip, XFS_MMAPLOCK_SHARED);
 	ret = xfs_dax_fault_locked(vmf, order, false);
 	xfs_iunlock(ip, XFS_MMAPLOCK_SHARED);
@@ -1412,6 +1415,17 @@ xfs_write_fault(
 	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
 	vm_fault_t		ret;
 
+	/*
+	 * Usually we get here from ->page_mkwrite callback but in case of DAX
+	 * we will get here also for ordinary write fault. Handle HSM
+	 * notifications for that case.
+	 */
+	if (IS_DAX(inode)) {
+		ret = filemap_fsnotify_fault(vmf);
+		if (unlikely(ret))
+			return ret;
+	}
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-- 
2.35.3


