Return-Path: <linux-fsdevel+bounces-23454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD792C7C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135D72834A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37CC2D6;
	Wed, 10 Jul 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mNSU3tN3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mNSU3tN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDF1392;
	Wed, 10 Jul 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573702; cv=none; b=GdhUQAPfHKgg27cWmYWVosYCsmz8wzWykNxsCSdkNXO7y347lZIehMN/3zJfso273Nv5xIja/ykoTHu4be93fkpKtMOp2Cbf7ekUb9pSoKNxvcaty3Ainw5VIl5Qe38mdVigS1gc2uXRzQEVRqfhM3SJ9YRbHWXGLOTJRBW9k2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573702; c=relaxed/simple;
	bh=WmFbDg7Z76GHoIZEHppXiPa+TTSE9ALB9Z3Ij21qNnI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL7vKJjPqOgUet2vesKt2Ikx78vkAS/Xe731EUTdQarJHM0ZHP9hM/PElm5JvmiyLbVhrMC7ZsI9uPmKe6igxLCuMbIHuobmvvE/32cebkjUPaJLid6nQmlqNIjUy7tmsC2j5VNCo1BLJzFMRxMXVYPEtlgx0/ZuaQE+X2tPRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mNSU3tN3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mNSU3tN3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0735E21992;
	Wed, 10 Jul 2024 01:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720573699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ4IkQENG6pAsAvxDMHr6A4L6Cb8IoFDy31gJ/5zHnI=;
	b=mNSU3tN3Ou3EI19Z2tJFU6z1BKnlle3J30Z9sGaQw2KQjs2IaJI+jDFXPtU+geVVNzxWT4
	vyvhTW2mse0zEn6UYfq1w87wwhv7anlh9DD6B7Vku5rPUmzzdT4E+rOPi+JwFDn60IDLnu
	IPDUFz3lzx6uCKyS0ZnCTJdoGN9eDiQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mNSU3tN3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720573699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ4IkQENG6pAsAvxDMHr6A4L6Cb8IoFDy31gJ/5zHnI=;
	b=mNSU3tN3Ou3EI19Z2tJFU6z1BKnlle3J30Z9sGaQw2KQjs2IaJI+jDFXPtU+geVVNzxWT4
	vyvhTW2mse0zEn6UYfq1w87wwhv7anlh9DD6B7Vku5rPUmzzdT4E+rOPi+JwFDn60IDLnu
	IPDUFz3lzx6uCKyS0ZnCTJdoGN9eDiQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5BC1369A;
	Wed, 10 Jul 2024 01:08:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GPwQEgHfjWaYTQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 10 Jul 2024 01:08:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] mm: allow certain address space to be not accounted by memcg
Date: Wed, 10 Jul 2024 10:37:47 +0930
Message-ID: <92dea37a395781ee4d5cf8b16307801ccd8a5700.1720572937.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720572937.git.wqu@suse.com>
References: <cover.1720572937.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0735E21992
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Currently any page/folio added to an address space will be accounted by
memcg.

However this is not always true for certain address spaces.
One example is the address space of btrfs btree inode, which stores the
metadata of one btrfs.

Currently btrfs is using __GFP_NOFAIL for all operations touching that
address space, but this can has other problems as __GFP_NOFAIL can wait
infinitely until the request is met.

To avoid unnecessary memcg charge for the btree inode address space,
introduce a new flag, AS_NO_MEMCG, to inform that folios added to that
address space should not trigger memcg charge/uncharge, and add btrfs
btree inode to utilize that new flag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c      |  1 +
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 12 +++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9e64e9fde832..2de9db95fbb9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1931,6 +1931,7 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	inode->i_size = OFFSET_MAX;
 	inode->i_mapping->a_ops = &btree_aops;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	set_bit(AS_NO_MEMCG, &inode->i_mapping->flags);
 
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
 			    IO_TREE_BTREE_INODE_IO);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 59f1df0cde5a..d4634d5d5dab 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -209,6 +209,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
+	AS_NO_MEMCG,		/* No memcg should be applied to this address space .*/
 };
 
 /**
diff --git a/mm/filemap.c b/mm/filemap.c
index 876cc64aadd7..a2282aa4f2a6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -960,11 +960,17 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 				pgoff_t index, gfp_t gfp)
 {
 	void *shadow = NULL;
+	const bool no_memcg = test_bit(AS_NO_MEMCG, &mapping->flags);
 	int ret;
 
-	ret = mem_cgroup_charge(folio, NULL, gfp);
-	if (ret)
-		return ret;
+	if (!no_memcg) {
+		ret = mem_cgroup_charge(folio, NULL, gfp);
+		if (ret)
+			return ret;
+	} else {
+		/* The page should not has any memcg set for it. */
+		VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
+	}
 
 	__folio_set_locked(folio);
 	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
-- 
2.45.2


