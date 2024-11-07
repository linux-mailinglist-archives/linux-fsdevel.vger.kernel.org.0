Return-Path: <linux-fsdevel+bounces-33850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76DD9BFAB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A9C1F24777
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523804A28;
	Thu,  7 Nov 2024 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lRDAaXq0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1TD78RUn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lRDAaXq0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1TD78RUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F38DDBE;
	Thu,  7 Nov 2024 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938932; cv=none; b=E5O3qJKMWTpGjN3a5JhNVk9mThQZtJTjKOQCrT3aZkmbBFzMHFmHHz5tUrAcl1JDqOjtacvXuImiyAoGR3vs0fua0y3lH5H9cpLmjV1ID3+bGtVD2afe0IOIACO+MMEB5cjdb4Epa1rEU7LbGtXrp/w4eITM8CJpCDO3f99XbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938932; c=relaxed/simple;
	bh=krkyUqfN+iKlgdCj9cJ6rYMKGOen0i2ly2NpNWg360E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmAnQ+gwq1Eq9daPo52KxGMnl28/66jLkT+uZU84OIwjyjoyH0l8PmUYq9dUtfDTZLW2+bS8Cc0ZzTYvDSy/6Bhs+da8udTi3tJhxnVtmRVB4bF3g4x6K2sdo7CHRRhguvhVbx0ebphLd6UyuimmBihG7LFOJglDCpAqhKowR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lRDAaXq0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1TD78RUn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lRDAaXq0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1TD78RUn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73E261FED3;
	Thu,  7 Nov 2024 00:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgh50Gs0c4C8Tv+d6hGAofXRW1Q9fkC4OW2jRZIYntg=;
	b=lRDAaXq06LOmBiG3G+rEe3D4LncBpva0lHoX4DaCh2X9RpvKGyRhAEtB+6qeuntdMcjo9U
	ra+ATEZPGqmeNaa+bofubIFVVoqe/mAOnqktMfGFSz+4Gs0OZhdxiVgtfDLoMbyhnQSlKF
	BV2xUUv3RLt9IAmqKmcx7GHfxXEAi18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgh50Gs0c4C8Tv+d6hGAofXRW1Q9fkC4OW2jRZIYntg=;
	b=1TD78RUn/Vavi0elW0bPYREsTsz6c3DQd9sbKlaviJZVyQgk7a7halyED6wRa27lJG+0Rd
	uMJnxhYjIF9F3RAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lRDAaXq0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1TD78RUn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgh50Gs0c4C8Tv+d6hGAofXRW1Q9fkC4OW2jRZIYntg=;
	b=lRDAaXq06LOmBiG3G+rEe3D4LncBpva0lHoX4DaCh2X9RpvKGyRhAEtB+6qeuntdMcjo9U
	ra+ATEZPGqmeNaa+bofubIFVVoqe/mAOnqktMfGFSz+4Gs0OZhdxiVgtfDLoMbyhnQSlKF
	BV2xUUv3RLt9IAmqKmcx7GHfxXEAi18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgh50Gs0c4C8Tv+d6hGAofXRW1Q9fkC4OW2jRZIYntg=;
	b=1TD78RUn/Vavi0elW0bPYREsTsz6c3DQd9sbKlaviJZVyQgk7a7halyED6wRa27lJG+0Rd
	uMJnxhYjIF9F3RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 541A11394A;
	Thu,  7 Nov 2024 00:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QE2TAi8ILGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:22:07 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 8/9] initramfs: fix hardlink hash leak without TRAILER
Date: Thu,  7 Nov 2024 11:17:27 +1100
Message-ID: <20241107002044.16477-10-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107002044.16477-1-ddiss@suse.de>
References: <20241107002044.16477-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73E261FED3
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Covered in Documentation/driver-api/early-userspace/buffer-format.rst ,
initramfs archives can carry an optional "TRAILER!!!" entry which serves
as a boundary for collecting and associating hardlinks with matching
inode and major / minor device numbers.

Although optional, if hardlinks are found in an archive without a
subsequent "TRAILER!!!" entry then the hardlink state hash table is
leaked, e.g. unfixed kernel, with initramfs_test.c hunk applied only:
unreferenced object 0xffff9405408cc000 (size 8192):
  comm "kunit_try_catch", pid 53, jiffies 4294892519
  hex dump (first 32 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 ff 81 00 00  ................
    00 00 00 00 00 00 00 00 69 6e 69 74 72 61 6d 66  ........initramf
  backtrace (crc a9fb0ee0):
    [<0000000066739faa>] __kmalloc_cache_noprof+0x11d/0x250
    [<00000000fc755219>] maybe_link.part.5+0xbc/0x120
    [<000000000526a128>] do_name+0xce/0x2f0
    [<00000000145c1048>] write_buffer+0x22/0x40
    [<000000003f0b4f32>] unpack_to_rootfs+0xf9/0x2a0
    [<00000000d6f7e5af>] initramfs_test_hardlink+0xe3/0x3f0
    [<0000000014fde8d6>] kunit_try_run_case+0x5f/0x130
    [<00000000dc9dafc5>] kunit_generic_run_threadfn_adapter+0x18/0x30
    [<000000001076c239>] kthread+0xc8/0x100
    [<00000000d939f1c1>] ret_from_fork+0x2b/0x40
    [<00000000f848ad1a>] ret_from_fork_asm+0x1a/0x30

Fix this by calling free_hash() after initramfs buffer processing in
unpack_to_rootfs(). An extra hardlink_seen global is added as an
optimization to avoid walking the 32 entry hash array unnecessarily.
The expectation is that a "TRAILER!!!" entry will normally be present,
and initramfs hardlinks are uncommon.

There is one user facing side-effect of this fix: hardlinks can
currently be associated across built-in and external initramfs archives,
*if* the built-in initramfs archive lacks a "TRAILER!!!" terminator. I'd
consider this cross-archive association broken, but perhaps it's used.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c      | 7 ++++++-
 init/initramfs_test.c | 5 -----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index c264f136c5281..99f3cac10d392 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -76,6 +76,7 @@ static __initdata struct hash {
 	struct hash *next;
 	char name[N_ALIGN(PATH_MAX)];
 } *head[32];
+static __initdata bool hardlink_seen;
 
 static inline int hash(int major, int minor, int ino)
 {
@@ -109,19 +110,21 @@ static char __init *find_link(int major, int minor, int ino,
 	strcpy(q->name, name);
 	q->next = NULL;
 	*p = q;
+	hardlink_seen = true;
 	return NULL;
 }
 
 static void __init free_hash(void)
 {
 	struct hash **p, *q;
-	for (p = head; p < head + 32; p++) {
+	for (p = head; hardlink_seen && p < head + 32; p++) {
 		while (*p) {
 			q = *p;
 			*p = q->next;
 			kfree(q);
 		}
 	}
+	hardlink_seen = false;
 }
 
 #ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
@@ -563,6 +566,8 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
+	/* free any hardlink state collected without optional TRAILER!!! */
+	free_hash();
 	kfree(cpio_buf);
 	return message;
 }
diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 84b21f465bc3d..a2930c70cc817 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -319,11 +319,6 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 		.namesize = sizeof("initramfs_test_hardlink_link"),
 		.fname = "initramfs_test_hardlink_link",
 		.data = "ASDF",
-	}, {
-		/* hardlink hashtable leaks when the archive omits a trailer */
-		.magic = "070701",
-		.namesize = sizeof("TRAILER!!!"),
-		.fname = "TRAILER!!!",
 	} };
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
-- 
2.43.0


