Return-Path: <linux-fsdevel+bounces-25348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F694AFC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265361C212A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989A145348;
	Wed,  7 Aug 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mz+S7s4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zNom4Umh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mz+S7s4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zNom4Umh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8EC143C70
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055413; cv=none; b=WPX9DXgrek0rgJbxmmv8Epd2lbQrzWM4EBOfT3+QU27hrKGcdE9VDKx1idyMKHzwbmCyZIIoMPk3mgbUjHQuCnj8aeUmFroamJi1TBGXbV3ahDxyrwIN6Fm91YZIQProD3IQt9yHcMvx3Cn0ZzgJEuOkC+XqM70H19ZJGvamqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055413; c=relaxed/simple;
	bh=8KmJ0x0UPIu10TnEpoxvWsrKnC2A+3Bc4jqRyuanl7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkbVyHxN7n2OESH89XkFmj01NVN7l2xZtmh6cy28ifeaxr8Ukb2t7O4j3xmBsC6sm5XqSq8ZO7zcOcUiDd6w3eTp4ctybzc/JhyU7hclvKUks21SZh/qfc+Ufyr38DMZCVY1oGRJ98ZwMgG91kTDCqmQyU7E6+p+D8UPtxX6OHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mz+S7s4d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zNom4Umh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mz+S7s4d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zNom4Umh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9200621D12;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqniTAIHeQnvY5cBsiNDIpvQxfh/HqTK3A2lIErejI=;
	b=mz+S7s4dTv/H0GtrfOk2DYO1DGClA+rNyENRLNTuZwMGO4+Ndjm1j8/nnjHBf1Zw8zhno3
	hEDeS9j9SNjTF/s1QSnM2I54cXznLMtsPLdTCUjacd/zhCJuoMIdCpqra0mpGAKxsG0HwX
	hfLnsOEDygRMfR8A2KsTmVYYI+NP4Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqniTAIHeQnvY5cBsiNDIpvQxfh/HqTK3A2lIErejI=;
	b=zNom4UmhKrzQ82DoCHJtUmbmbH4eOwNKt9xSmOM74omp8XfrZsWk/gTbwI0YYmIXcO8b08
	kzveboVDw0Sg24Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mz+S7s4d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zNom4Umh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqniTAIHeQnvY5cBsiNDIpvQxfh/HqTK3A2lIErejI=;
	b=mz+S7s4dTv/H0GtrfOk2DYO1DGClA+rNyENRLNTuZwMGO4+Ndjm1j8/nnjHBf1Zw8zhno3
	hEDeS9j9SNjTF/s1QSnM2I54cXznLMtsPLdTCUjacd/zhCJuoMIdCpqra0mpGAKxsG0HwX
	hfLnsOEDygRMfR8A2KsTmVYYI+NP4Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqniTAIHeQnvY5cBsiNDIpvQxfh/HqTK3A2lIErejI=;
	b=zNom4UmhKrzQ82DoCHJtUmbmbH4eOwNKt9xSmOM74omp8XfrZsWk/gTbwI0YYmIXcO8b08
	kzveboVDw0Sg24Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87D6813B18;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VEHvICy9s2aGNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF8F4A089C; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 12/13] fs: Make sb_start_pagefault() return error on shutdown filesystem
Date: Wed,  7 Aug 2024 20:29:57 +0200
Message-Id: <20240807183003.23562-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10931; i=jack@suse.cz; h=from:subject; bh=8KmJ0x0UPIu10TnEpoxvWsrKnC2A+3Bc4jqRyuanl7Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70ksc3ySHKfAltYxeulBlWyqyiOrwze+R68+LMW Hp0ihjiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9JAAKCRCcnaoHP2RA2SaWB/ 9IExF5d8A7QrttGvftjZnv0TWTMuMB0kjpW2vLOxm93r6fJ2cMCGhvmhjwVhY6lElXv4kgNFV4EDtX 7h4D7dWoCpt4D3TF55TMy2NkHjnG45CTbQXPcuUlrCgOuBYmxS2+iT/qza6X3A8kfoL0qTHwEXelwc nDrherotqfaFbri9k7ReXnFUs3qCdGjDFS3KeHjbpaxryTcVeAIkD6/GMq+VF/zBhwIaYhzb8pGqdC uhqahvcKMdEi8S6OC09FCuZ0DQvaiPgMpM0WxibkrxIerXpbaWaMrkNJgQvnkjuF/FU+9txLM+C/6V jla+wB6hSQI7KeBMqFI1dw8FNtmI/w
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9200621D12
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Similarly to sb_start_write(), make sb_start_pagefault() return errors
for superblocks which are marked as shutdown to avoid modifications to
it which reduces noise in the error logs and generally makes life
somewhat easier for filesystems. We teach all sb_start_pagefault()
callers to handle the error.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/bcachefs/fs-io-pagecache.c | 3 ++-
 fs/btrfs/file.c               | 3 ++-
 fs/ceph/addr.c                | 9 ++++++---
 fs/ext2/file.c                | 3 ++-
 fs/ext4/file.c                | 3 ++-
 fs/ext4/inode.c               | 3 ++-
 fs/f2fs/file.c                | 4 +++-
 fs/fuse/dax.c                 | 3 ++-
 fs/gfs2/file.c                | 3 ++-
 fs/netfs/buffered_write.c     | 3 ++-
 fs/nfs/file.c                 | 3 ++-
 fs/nilfs2/file.c              | 3 ++-
 fs/ocfs2/mmap.c               | 3 ++-
 fs/orangefs/inode.c           | 3 ++-
 fs/udf/file.c                 | 3 ++-
 fs/xfs/xfs_file.c             | 3 ++-
 fs/zonefs/file.c              | 3 ++-
 include/linux/fs.h            | 5 ++++-
 mm/filemap.c                  | 3 ++-
 19 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
index a9cc5cad9cc9..a4efa1b76035 100644
--- a/fs/bcachefs/fs-io-pagecache.c
+++ b/fs/bcachefs/fs-io-pagecache.c
@@ -611,7 +611,8 @@ vm_fault_t bch2_page_mkwrite(struct vm_fault *vmf)
 
 	bch2_folio_reservation_init(c, inode, &res);
 
-	sb_start_pagefault(inode->v.i_sb);
+	if (sb_start_pagefault(inode->v.i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	file_update_time(file);
 
 	/*
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 21381de906f6..481d355c66ee 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1900,7 +1900,8 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	reserved_space = PAGE_SIZE;
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	page_start = page_offset(page);
 	page_end = page_start + PAGE_SIZE - 1;
 	end = page_end;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8c16bc5250ef..60ddddce4ec1 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1686,7 +1686,9 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	if (!prealloc_cf)
 		return VM_FAULT_OOM;
 
-	sb_start_pagefault(inode->i_sb);
+	err = sb_start_pagefault(inode->i_sb);
+	if (err)
+		goto out_free;
 	ceph_block_sigs(&oldset);
 
 	if (off + thp_size(page) <= size)
@@ -1704,7 +1706,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	got = 0;
 	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, off + len, &got);
 	if (err < 0)
-		goto out_free;
+		goto out_sigs;
 
 	doutc(cl, "%llx.%llx %llu~%zd got cap refs on %s\n", ceph_vinop(inode),
 	      off, len, ceph_cap_string(got));
@@ -1758,9 +1760,10 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	doutc(cl, "%llx.%llx %llu~%zd dropping cap refs on %s ret %x\n",
 	      ceph_vinop(inode), off, len, ceph_cap_string(got), ret);
 	ceph_put_cap_refs_async(ci, got);
-out_free:
+out_sigs:
 	ceph_restore_sigs(&oldset);
 	sb_end_pagefault(inode->i_sb);
+out_free:
 	ceph_free_cap_flush(prealloc_cf);
 	if (err < 0)
 		ret = vmf_error(err);
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 10b061ac5bc0..b57197007b28 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -98,7 +98,8 @@ static vm_fault_t ext2_dax_fault(struct vm_fault *vmf)
 		(vmf->vma->vm_flags & VM_SHARED);
 
 	if (write) {
-		sb_start_pagefault(inode->i_sb);
+		if (sb_start_pagefault(inode->i_sb) < 0)
+			return VM_FAULT_SIGBUS;
 		file_update_time(vmf->vma->vm_file);
 	}
 	filemap_invalidate_lock_shared(inode->i_mapping);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..37623d4624c0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -725,7 +725,8 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	pfn_t pfn;
 
 	if (write) {
-		sb_start_pagefault(sb);
+		if (sb_start_pagefault(sb) < 0)
+			return VM_FAULT_SIGBUS;
 		file_update_time(vmf->vma->vm_file);
 		filemap_invalidate_lock_shared(mapping);
 retry:
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..195fcbb5c083 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6128,7 +6128,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return VM_FAULT_SIGBUS;
 
-	sb_start_pagefault(inode->i_sb);
+	if (unlikely(sb_start_pagefault(inode->i_sb) < 0))
+		return VM_FAULT_SIGBUS;
 	file_update_time(vma->vm_file);
 
 	filemap_invalidate_lock_shared(mapping);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 168f08507004..67ee66ff75a7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -100,7 +100,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (need_alloc)
 		f2fs_balance_fs(sbi, true);
 
-	sb_start_pagefault(inode->i_sb);
+	err = sb_start_pagefault(inode->i_sb);
+	if (err)
+		goto out;
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..d42d0aaa1bd9 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -797,7 +797,8 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,
 	bool retry = false;
 
 	if (write)
-		sb_start_pagefault(sb);
+		if (sb_start_pagefault(sb) < 0)
+			return VM_FAULT_SIGBUS;
 retry:
 	if (retry && !(fcd->nr_free_ranges > 0))
 		wait_event(fcd->range_waitq, (fcd->nr_free_ranges > 0));
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 08982937b5df..774203da5262 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -427,7 +427,8 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	loff_t size;
 	int err;
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
 	err = gfs2_glock_nq(&gh);
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 4726c315453c..e46fcd387be6 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -531,7 +531,8 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	_enter("%lx", folio->index);
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 61a8cdb9f1e1..ae0791c67ab8 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -593,7 +593,8 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 		 filp, filp->f_mapping->host->i_ino,
 		 (long long)folio_pos(folio));
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 
 	/* make sure the cache has finished storing the page */
 	if (folio_test_private_2(folio) && /* [DEPRECATED] */
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 0e3fc5ba33c7..6e80377250d1 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -54,7 +54,8 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
 		return VM_FAULT_SIGBUS; /* -ENOSPC */
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	folio_lock(folio);
 	if (folio->mapping != inode->i_mapping ||
 	    folio_pos(folio) >= i_size_read(inode) ||
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 1834f26522ed..a56465a3a515 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -119,7 +119,8 @@ static vm_fault_t ocfs2_page_mkwrite(struct vm_fault *vmf)
 	int err;
 	vm_fault_t ret;
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	ocfs2_block_signals(&oldset);
 
 	/*
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index fdb9b65db1de..170ef9456ff1 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -632,7 +632,8 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 	vm_fault_t ret;
 	struct orangefs_write_range *wr;
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 
 	if (wait_on_bit(bitlock, 1, TASK_KILLABLE)) {
 		ret = VM_FAULT_RETRY;
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 3a4179de316b..d97ba972f1f3 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -45,7 +45,8 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 	vm_fault_t ret = VM_FAULT_LOCKED;
 	int err;
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	file_update_time(vma->vm_file);
 	filemap_invalidate_lock_shared(mapping);
 	folio_lock(folio);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..7e2c9bd70bc2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1283,7 +1283,8 @@ xfs_write_fault(
 	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
 	vm_fault_t		ret;
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	file_update_time(vmf->vma->vm_file);
 
 	/*
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 3b103715acc9..0b100d48056a 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -294,7 +294,8 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 	if (zonefs_inode_is_seq(inode))
 		return VM_FAULT_NOPAGE;
 
-	sb_start_pagefault(inode->i_sb);
+	if (sb_start_pagefault(inode->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	file_update_time(vmf->vma->vm_file);
 
 	/* Serialize against truncates */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 44ae86f46b12..a082777eac6a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1858,9 +1858,12 @@ static inline bool __must_check sb_start_write_trylock(struct super_block *sb)
  * mmap_lock
  *   -> sb_start_pagefault
  */
-static inline void sb_start_pagefault(struct super_block *sb)
+static inline int __must_check sb_start_pagefault(struct super_block *sb)
 {
+	if (sb_test_iflag(sb, SB_I_SHUTDOWN))
+		return -EROFS;
 	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
+	return 0;
 }
 
 /**
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..97efc8a62c21 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3672,7 +3672,8 @@ vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 	struct folio *folio = page_folio(vmf->page);
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
-	sb_start_pagefault(mapping->host->i_sb);
+	if (sb_start_pagefault(mapping->host->i_sb) < 0)
+		return VM_FAULT_SIGBUS;
 	file_update_time(vmf->vma->vm_file);
 	folio_lock(folio);
 	if (folio->mapping != mapping) {
-- 
2.35.3


