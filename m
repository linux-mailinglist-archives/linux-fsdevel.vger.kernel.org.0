Return-Path: <linux-fsdevel+bounces-41380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C84A2E6FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7CB1673A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1C1C1F0F;
	Mon, 10 Feb 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jcLSpBn4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jgzFjWA+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jcLSpBn4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jgzFjWA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AF1C07EC;
	Mon, 10 Feb 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177527; cv=none; b=HqG87OzYymC62kn+sq5F4pU1FzoKq8GFgXbrJXe3XV19JgHlcIjj86GKZEngpJtJk18olh1RJIYOK7jXjGc3wT8Z0OPSyve1Q1MNfQut3Uui/kzMR5y1XWOwqWNEdqX3NzvIju+NXkt8L/z/QAioTiC7yI1quZ5C/i9hU7pth2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177527; c=relaxed/simple;
	bh=tx0SakQudmWy7pQ2yssX7Lq1PY1uAjUJ2xYm5K/RDPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqEVUNa2BLJZLrFLfrnZ0q0Of6hOdaGRjpo4z6yWH5Wf6Cxah8B6Tgt3yWXiG5w8nZzk6pQYn29m51btzzl+CZzwGrsxoObGw7mQDwaPXUhjCX16b7JcpWwa6zQMWzr0kBPLpFn/4KnPsE73XJWrIdG2e1nsvMOsI/EeKlciyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jcLSpBn4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jgzFjWA+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jcLSpBn4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jgzFjWA+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91CC41F37E;
	Mon, 10 Feb 2025 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739177523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7ImRDEq0mvCvZM+o+oq2w3SAOJ+hD1BFuS0nDAv2EA=;
	b=jcLSpBn4p1UMOPYdW+8hqUByIr2BdL8MqW4gx999LZGDMCotBeiIyxhkPzEpoalBFlPYNs
	3TQVYh6QZhaLzZT/srK7Bqb0sxBoU7GE/xHb5u9y9ah2y93pG9MovMT0v8dtZGd17ts034
	qlIl99fJ3Xv1ny2HJWheNoVX+crd7yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739177523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7ImRDEq0mvCvZM+o+oq2w3SAOJ+hD1BFuS0nDAv2EA=;
	b=jgzFjWA+T5ZWTCqA3ZauMbMytyB2f96a6FyrBcJamtP5wn8hyf5YsXVNyqBrScn3oMiYSg
	ogUzS1ZOqB97zdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739177523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7ImRDEq0mvCvZM+o+oq2w3SAOJ+hD1BFuS0nDAv2EA=;
	b=jcLSpBn4p1UMOPYdW+8hqUByIr2BdL8MqW4gx999LZGDMCotBeiIyxhkPzEpoalBFlPYNs
	3TQVYh6QZhaLzZT/srK7Bqb0sxBoU7GE/xHb5u9y9ah2y93pG9MovMT0v8dtZGd17ts034
	qlIl99fJ3Xv1ny2HJWheNoVX+crd7yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739177523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7ImRDEq0mvCvZM+o+oq2w3SAOJ+hD1BFuS0nDAv2EA=;
	b=jgzFjWA+T5ZWTCqA3ZauMbMytyB2f96a6FyrBcJamtP5wn8hyf5YsXVNyqBrScn3oMiYSg
	ogUzS1ZOqB97zdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78A0D13707;
	Mon, 10 Feb 2025 08:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GtoIHTO+qWcoKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Feb 2025 08:52:03 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: miklos@szeredi.hu
Cc: christian@heusel.eu,
	joannelkoong@gmail.com,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mszeredi@redhat.com,
	regressions@lists.linux.dev,
	willy@infradead.org,
	Vlastimil Babka <vbabka@suse.cz>,
	=?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fuse: prevent folio use-after-free in readahead
Date: Mon, 10 Feb 2025 09:52:03 +0100
Message-ID: <20250210085202.14943-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
References: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[heusel.eu,gmail.com,toxicpanda.com,vger.kernel.org,kvack.org,redhat.com,lists.linux.dev,infradead.org,suse.cz];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,opensuse.org:url]
X-Spam-Score: -3.30
X-Spam-Flag: NO

There have been crash reports in 6.13+ kernels related to FUSE and
Flatpak, such as from Christian:

 BUG: Bad page state in process rnote  pfn:67587
 page: refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67587
 flags: 0xfffffc8000020(lru|node=0|zone=1|lastcpupid=0x1fffff)
 raw: 000fffffc8000020 dead000000000100 dead000000000122 0000000000000000
 raw: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000000
 page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
 CPU: 0 UID: 1000 PID: 1962 Comm: rnote Not tainted 6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef3209cee42e97ae1c
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 Call Trace:

  dump_stack_lvl+0x5d/0x80
  bad_page.cold+0x7a/0x91
  __rmqueue_pcplist+0x200/0xc50
  get_page_from_freelist+0x2ae/0x1740
  ? srso_return_thunk+0x5/0x5f
  ? __pm_runtime_suspend+0x69/0xc0
  ? srso_return_thunk+0x5/0x5f
  ? __seccomp_filter+0x303/0x520
  ? srso_return_thunk+0x5/0x5f
  __alloc_frozen_pages_noprof+0x184/0x330
  alloc_pages_mpol+0x7d/0x160
  folio_alloc_mpol_noprof+0x14/0x40
  vma_alloc_folio_noprof+0x69/0xb0
  do_anonymous_page+0x32a/0x8b0
  ? srso_return_thunk+0x5/0x5f
  ? ___pte_offset_map+0x1b/0x180
  __handle_mm_fault+0xb5e/0xfe0
  handle_mm_fault+0xe2/0x2c0
  do_user_addr_fault+0x217/0x620
  exc_page_fault+0x81/0x1b0
  asm_exc_page_fault+0x26/0x30
 RIP: 0033:0x7fcfc31c8cf9

Or Mantas:

 list_add corruption. next->prev should be prev (ffff889c8f5bd5f0), but was ffff889940066a10. (next=ffffe3ce8b683548).
 WARNING: CPU: 3 PID: 2184 at lib/list_debug.c:29 __list_add_valid_or_report+0x62/0xb0
  spi_intel_pci soundcore nvme_core spi_intel rfkill rtsx_pci nvme_auth cec i8042 video serio wmi
 CPU: 3 UID: 1000 PID: 2184 Comm: fuse mainloop Tainted: G     U     OE      6.13.1-arch1-1 #1 c1258adae10e6ad423427764ae6ad3679b7d8e8a
 Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: LENOVO 20S6003QPB/20S6003QPB, BIOS N2XET42W (1.32 ) 06/12/2024
 RIP: 0010:__list_add_valid_or_report+0x62/0xb0

 Call Trace:
  <TASK>
  ? __list_add_valid_or_report+0x62/0xb0
  ? __warn.cold+0x93/0xf6
  ? __list_add_valid_or_report+0x62/0xb0
  ? report_bug+0xff/0x140
  ? handle_bug+0x58/0x90
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __list_add_valid_or_report+0x62/0xb0
  free_unref_page_commit.cold+0x9/0x12
  free_unref_page+0x46e/0x570
  fuse_copy_page+0x37e/0x6c0
  fuse_copy_args+0x186/0x210
  fuse_dev_do_write+0x796/0x12a0
  fuse_dev_splice_write+0x29d/0x380
  do_splice+0x308/0x890
  __do_splice+0x204/0x220
  __x64_sys_splice+0x84/0xf0
  do_syscall_64+0x82/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x77e0dde36e56

Christian bisected the issue to 3eab9d7bc2f4 ("fuse: convert readahead
to use folios"). The bug reports suggest a refcount underflow on struct
page due to a use after free or double free. The bisected commit
switches fuse_readahead() to readahead_folio() which includes a
folio_put() and removes folio_put() from fuse_readpages_end(). As a
result folios on the ap->folios (previously ap->pages) don't have an
elevated refcount. According to Matthew the folio lock should protect
them from being freed prematurely. It's unclear why not, but before this
is fully resolved we can stop the kernels from crashing by having the
refcount relevated again. Thus switch to __readahead_folio() that does
not drop the refcount, and reinstate folio_put() in
fuse_readpages_end().

Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/all/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/110
Reported-by: Mantas Mikulėnas <grawity@gmail.com>
Closes: https://lore.kernel.org/all/34feb867-09e2-46e4-aa31-d9660a806d1a@gmail.com/
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1236660
Tested-by: Joanne Koong <joannelkoong@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Given the impact on users and positive testing feedback, this is the
proper patch in case Miklos decides to mainline and stable it before the
full picture is known.

 fs/fuse/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a5479998..a40d65ffb94d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_invalidate_atime(inode);
 	}
 
-	for (i = 0; i < ap->num_folios; i++)
+	for (i = 0; i < ap->num_folios; i++) {
 		folio_end_read(ap->folios[i], !err);
+		folio_put(ap->folios[i]);
+	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
 
@@ -1048,7 +1050,7 @@ static void fuse_readahead(struct readahead_control *rac)
 		ap = &ia->ap;
 
 		while (ap->num_folios < cur_pages) {
-			folio = readahead_folio(rac);
+			folio = __readahead_folio(rac);
 			ap->folios[ap->num_folios] = folio;
 			ap->descs[ap->num_folios].length = folio_size(folio);
 			ap->num_folios++;
-- 
2.48.1


