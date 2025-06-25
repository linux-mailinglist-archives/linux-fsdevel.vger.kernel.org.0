Return-Path: <linux-fsdevel+bounces-52929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C46AE88CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F371891179
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380D29E115;
	Wed, 25 Jun 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bslke0Kx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="piMT3Cft";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bslke0Kx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="piMT3Cft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543329B771
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866719; cv=none; b=NSFV1bR8kNmvTD8tFBR9TSbNOSyMhRu7hi+PoW4+g8rfGwfxa5yHZUY5jhT2F2OX50GoaZy2kfTVGP6udYjSK2obva8P13OoBS2hbTbeW1eJIlTJ9+31SYA0OsVLsnuv/6VoybUydf1SlLypyCenizrD2qbuWXaL57hivJBb/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866719; c=relaxed/simple;
	bh=t8USNlJXF4U9plUczuyiMuPRiapOt9YbAVBerRDdDM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZV0Rwdxj6nJUTH0aKsfqDtqybd5i6FuKUnM9OE53Nm07Oe76nREnsAv8YCFWtNGTdvpg/92KYv7SIsuRokjf2XGQJlCrptrs2A9K92hWHdCUmVP0ewnindl29pUmNXp7uwLXqjJlW+yfqMFCPKZNTNRtfAX2am2HSJfELo8A33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bslke0Kx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=piMT3Cft; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bslke0Kx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=piMT3Cft; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62E922118D;
	Wed, 25 Jun 2025 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750866715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8nQknDS6pmpLWfs+ArFdioX0s6CDoohu6KF7xdiMMw=;
	b=Bslke0KxoWYmAwuQsgr63B43hSdaD6vOJUqVFX8B6iMS7j0MCm/poCtLli6H8FlQ1qpd1n
	rpRpzywhC9BM6JUtsEK3To3T8m91bAcCzd4k83zImiQJn8DmpBdNBL+jjGmHLUuvzt/mRk
	jeRZWfP/AIDBBDRwYrgrWpZbvsTvs4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750866715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8nQknDS6pmpLWfs+ArFdioX0s6CDoohu6KF7xdiMMw=;
	b=piMT3Cfty2+bthrCf+5fvhIuDbq1swXPjGZrZYfe3/autzx76SM2iJ+L3aREPnnT64cBFC
	gcCQTR7GCuhLL7Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bslke0Kx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=piMT3Cft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750866715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8nQknDS6pmpLWfs+ArFdioX0s6CDoohu6KF7xdiMMw=;
	b=Bslke0KxoWYmAwuQsgr63B43hSdaD6vOJUqVFX8B6iMS7j0MCm/poCtLli6H8FlQ1qpd1n
	rpRpzywhC9BM6JUtsEK3To3T8m91bAcCzd4k83zImiQJn8DmpBdNBL+jjGmHLUuvzt/mRk
	jeRZWfP/AIDBBDRwYrgrWpZbvsTvs4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750866715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8nQknDS6pmpLWfs+ArFdioX0s6CDoohu6KF7xdiMMw=;
	b=piMT3Cfty2+bthrCf+5fvhIuDbq1swXPjGZrZYfe3/autzx76SM2iJ+L3aREPnnT64cBFC
	gcCQTR7GCuhLL7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36BC813301;
	Wed, 25 Jun 2025 15:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i2AJDRsbXGjnMAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 25 Jun 2025 15:51:55 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 25 Jun 2025 17:51:52 +0200
Subject: [PATCH] mm, vmstat: remove the NR_WRITEBACK_TEMP node_stat_item
 counter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-nr_writeback_removal-v1-1-7f2a0df70faa@suse.cz>
X-B4-Tracking: v=1; b=H4sIABcbXGgC/x3M3QpAQBBA4VfRXNta66d4FUljDSYszQol725z+
 V2c84AnYfJQRQ8Inex5cwFJHIGd0I2kuA8Go02uC5MrJ+0lfFCHdm6F1u3ERWVkMUlLO+gSIaS
 70MD3v62b9/0A+LRK2GYAAAA=
X-Change-ID: 20250625-nr_writeback_removal-4eca139cf09a
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Maxim Patlasov <mpatlasov@parallels.com>, 
 Jan Kara <jack@suse.cz>, Zach O'Keefe <zokeefe@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>, 
 Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5950; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=t8USNlJXF4U9plUczuyiMuPRiapOt9YbAVBerRDdDM8=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBoXBsY1YOFpjfas7/tInAngabuIgbw3W2JzIjSC
 zsedRZJ2lGJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCaFwbGAAKCRC74LB10kWI
 mu70CACIdu4YQxdhrRCyDP5/xfNaJ5Tlelej6t1lOpU7kQsvm3MChRKj+FItRPDsMpDfKNdUtoU
 1WE7Yutm8ytFuaH1gfu2uyhn9hP5tXfcyo8Ge8hvySG3Jsy2D+dBP3dSUWh6LrCOl+l+vWCyT8o
 03dEWe0GRRnJA2HOJISipZf87tAKT9rYOBtWzEFh8zvKo4PhzTRQpI3tQS5dIhHGALTw/iBkN0S
 dCOU48Pc53/5Hq3e42mtth6cFbFBiukMGDlxuYiMej6iV6ThK8zC2kt7f3mMeMIswxQ0IYlykvJ
 xK9rvuRHkTSKmaXZJOL0xCfKyrHb2Q1+MJSntcUD4l/cDynW
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,parallels.com,suse.cz,google.com,lwn.net,linuxfoundation.org,suse.com,linux.intel.com,cmpxchg.org,nvidia.com,gmail.com,linux.alibaba.com,redhat.com,vger.kernel.org,kvack.org,kernel.dk];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLduzbn1medsdpg3i8igc4rk67)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 62E922118D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

The only user of the counter (FUSE) was removed in commit 0c58a97f919c
("fuse: remove tmp folio for writebacks and internal rb tree") so follow
the established pattern of removing the counter and hardcoding 0 in
meminfo output, as done recently with NR_BOUNCE. Update documentation
for procfs, including for the value for Bounce that was missed when
removing its counter.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
The removal of the counter is straightforward. The reason for the large
Cc list is that there is a comment in mm/page-writeback.c function
wb_position_ratio() that mentions NR_WRITEBACK_TEMP, and just deleting
the sentence feels to me it could be the wrong thing to do - maybe the
strictlimit feature itself is now obsolete? It sure does mention FUSE
as the main reason to exist, but commit 5a53748568f79 that introduced it
also mentions slow USB sticks as a possibile scenario. Has that
happened? I'm not familiar enough with this so I'd rather highlight this
and ask for input here than make "git grep NR_WRITEBACK_TEMP" return
nothing.
---
 Documentation/filesystems/proc.rst | 8 +++++---
 drivers/base/node.c                | 2 +-
 fs/proc/meminfo.c                  | 3 +--
 include/linux/mmzone.h             | 1 -
 mm/show_mem.c                      | 2 --
 mm/vmstat.c                        | 1 -
 6 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5236cb52e357dcd00496b26be8578e1dec0a345e..2971551b7235345c9a7ec3c84a87a16adcda5901 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1196,12 +1196,14 @@ SecPageTables
               Memory consumed by secondary page tables, this currently includes
               KVM mmu and IOMMU allocations on x86 and arm64.
 NFS_Unstable
-              Always zero. Previous counted pages which had been written to
+              Always zero. Previously counted pages which had been written to
               the server, but has not been committed to stable storage.
 Bounce
-              Memory used for block device "bounce buffers"
+              Always zero. Previously memory used for block device
+              "bounce buffers".
 WritebackTmp
-              Memory used by FUSE for temporary writeback buffers
+              Always zero. Previously memory used by FUSE for temporary
+              writeback buffers.
 CommitLimit
               Based on the overcommit ratio ('vm.overcommit_ratio'),
               this is the total amount of  memory currently available to
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6d66382dae6533a0c8481f72ad67c35021e331d3..e434cb260e6182468e0d617b559134c6fbe128f4 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -500,7 +500,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
 			     nid, 0UL,
 			     nid, 0UL,
-			     nid, K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
+			     nid, 0UL,
 			     nid, K(sreclaimable +
 				    node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE)),
 			     nid, K(sreclaimable + sunreclaimable),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index bc2bc60c36ccc1dab8913913056f5ff20b448490..a458f1e112fdbc63019239a79ce39c5576b5f963 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -121,8 +121,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	show_val_kb(m, "NFS_Unstable:   ", 0);
 	show_val_kb(m, "Bounce:         ", 0);
-	show_val_kb(m, "WritebackTmp:   ",
-		    global_node_page_state(NR_WRITEBACK_TEMP));
+	show_val_kb(m, "WritebackTmp:   ", 0);
 	show_val_kb(m, "CommitLimit:    ", vm_commit_limit());
 	show_val_kb(m, "Committed_AS:   ", committed);
 	seq_printf(m, "VmallocTotal:   %8lu kB\n",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1d1bb2b7f40d25b430932c9ef9096d97bf1c29de..0c5da9141983b795018c0aa2457b065507416564 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -206,7 +206,6 @@ enum node_stat_item {
 	NR_FILE_PAGES,
 	NR_FILE_DIRTY,
 	NR_WRITEBACK,
-	NR_WRITEBACK_TEMP,	/* Writeback using temporary buffers */
 	NR_SHMEM,		/* shmem pages (included tmpfs/GEM pages) */
 	NR_SHMEM_THPS,
 	NR_SHMEM_PMDMAPPED,
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 0cf8bf5d832d6b339b4c9a6c7b8b3ab41683bcfe..41999e94a56d623726ea92f3f38785e8b218afe5 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -246,7 +246,6 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			" shmem_pmdmapped:%lukB"
 			" anon_thp:%lukB"
 #endif
-			" writeback_tmp:%lukB"
 			" kernel_stack:%lukB"
 #ifdef CONFIG_SHADOW_CALL_STACK
 			" shadow_call_stack:%lukB"
@@ -273,7 +272,6 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
-			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_KB),
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c3114b8826e4c3b6969fd4af4b0cd32173c42d7b..e0fcd9057f344170b2dc5c82beafea4ec18359bb 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1251,7 +1251,6 @@ const char * const vmstat_text[] = {
 	[I(NR_FILE_PAGES)]			= "nr_file_pages",
 	[I(NR_FILE_DIRTY)]			= "nr_dirty",
 	[I(NR_WRITEBACK)]			= "nr_writeback",
-	[I(NR_WRITEBACK_TEMP)]			= "nr_writeback_temp",
 	[I(NR_SHMEM)]				= "nr_shmem",
 	[I(NR_SHMEM_THPS)]			= "nr_shmem_hugepages",
 	[I(NR_SHMEM_PMDMAPPED)]			= "nr_shmem_pmdmapped",

---
base-commit: 4216fd45fc9156da0ee33fcb25cc0a5265049e32
change-id: 20250625-nr_writeback_removal-4eca139cf09a

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


