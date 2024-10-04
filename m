Return-Path: <linux-fsdevel+bounces-31030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1A9910DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64950B2D8A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DB21D95BE;
	Fri,  4 Oct 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bnX0pcnE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FuRQmcj+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bnX0pcnE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FuRQmcj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C01DF72C;
	Fri,  4 Oct 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072346; cv=none; b=Mm1EKXmjrxrPO5Gc3rgA4PoSMQZu3sPcE+sih7D5ICVXNEzR/AzKjt+pht3/fkFUExBHyCDfkTc9BuA0NdZZ3jYVMrMFv4DFBFbxpiXHkwrqzUiirwt4pqnZaJeLlJIpHOLr+j3xOa15gXzl76m4GPGX7TsggDwIuNoI553Lbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072346; c=relaxed/simple;
	bh=Adkfi/1bKk2ccBTcF21BVys24OgiR1VQ0O/MOOVPcCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fro5oaKUCIZNzbmEGUIcRMXf89TSrhW7wzM9bnYjNOAZWYfiWRYQ+eRPjXr+U7YrqlQJcZ1LWc8oiro3Gpflpk3lXXBJyUBetsh7AaruPhHPFpaSW8O9+Me9rs7IitoHteyJcMLKlhbS/uHGgQGletw65xojU+urO/63Mg9XXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bnX0pcnE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FuRQmcj+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bnX0pcnE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FuRQmcj+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A80AB21D52;
	Fri,  4 Oct 2024 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0V4CHAX3CWflF16IyoE2yVn73SneAgekRD+IOv9G1c=;
	b=bnX0pcnE8WvSdo0M9gkfit09YDIUsona76UYRnEvs7wsel27J4OmgcVAuXE8t6gpzWVeFB
	4jbj2vMqI1XsELpKnJVZvYiRh7pz5FCgDBypiiMytvprX6GmYgO+QeizxoKRImJm/vqqEV
	XUF4RTcOZN+GI0SNxVgAci8gOx4vUMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0V4CHAX3CWflF16IyoE2yVn73SneAgekRD+IOv9G1c=;
	b=FuRQmcj+ACxzOgLuNERjZcSj7QBBxJAGtd+9DTUxGhKxw3Rv4uFo2WUoeVja4QS7t9hrep
	8G1+ApQNdHMn7ECQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bnX0pcnE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FuRQmcj+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728072342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0V4CHAX3CWflF16IyoE2yVn73SneAgekRD+IOv9G1c=;
	b=bnX0pcnE8WvSdo0M9gkfit09YDIUsona76UYRnEvs7wsel27J4OmgcVAuXE8t6gpzWVeFB
	4jbj2vMqI1XsELpKnJVZvYiRh7pz5FCgDBypiiMytvprX6GmYgO+QeizxoKRImJm/vqqEV
	XUF4RTcOZN+GI0SNxVgAci8gOx4vUMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728072342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0V4CHAX3CWflF16IyoE2yVn73SneAgekRD+IOv9G1c=;
	b=FuRQmcj+ACxzOgLuNERjZcSj7QBBxJAGtd+9DTUxGhKxw3Rv4uFo2WUoeVja4QS7t9hrep
	8G1+ApQNdHMn7ECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E08713883;
	Fri,  4 Oct 2024 20:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IgnlApZKAGcTRgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 04 Oct 2024 20:05:42 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 08/12] btrfs: iomap_begin() for buffered reads
Date: Fri,  4 Oct 2024 16:04:35 -0400
Message-ID: <5cba21c0cbc0da7adaa186f0163939912edd61d9.1728071257.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728071257.git.rgoldwyn@suse.com>
References: <cover.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A80AB21D52
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_read_iomap_begin() fetches the extent on the file position passed
and converts the resultant extent map to iomap. The iomap code uses the
sector offset from iomap structure to create the bios.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7f40c2b8bfb8..6ef2fa802c30 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -962,6 +962,34 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 
 	return em;
 }
+
+static int btrfs_read_iomap_begin(struct inode *inode, loff_t pos,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct extent_map *em;
+	struct extent_state *cached_state = NULL;
+	u64 start = round_down(pos, fs_info->sectorsize);
+	u64 end = round_up(pos + length, fs_info->sectorsize) - 1;
+
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, end, &cached_state);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, start, end - start + 1);
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+
+	btrfs_em_to_iomap(inode, em, iomap, start, false);
+	free_extent_map(em);
+
+	return 0;
+}
+
+static const struct iomap_ops btrfs_buffered_read_iomap_ops = {
+	.iomap_begin = btrfs_read_iomap_begin,
+};
+
+
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
  * into the tree that are removed when the IO is done (by the end_io
-- 
2.46.1


