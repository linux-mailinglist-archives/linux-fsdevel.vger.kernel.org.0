Return-Path: <linux-fsdevel+bounces-43044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C92A4D384
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EEE172EBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5551F4E27;
	Tue,  4 Mar 2025 06:11:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5F1F473C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068680; cv=none; b=A7P9aCDgdC2A34bO5SmlhAb53mBiIlj2vT/3fFQYpCVPOhHpA4BfpUmA9EB8WCO2Z/q4Zsrm/AJ48hi0GEkfKcEGFvG/J+WekIUTjG3LE5rF24LKeALAug8i/el49zzkxUIt1P/VGS/bD2eL7O5igT8fnRZiBIcxzbo4EWynJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068680; c=relaxed/simple;
	bh=s/MLrsZFxuwfkP4egpHy7WZYFKlEtB/YLVrfclejCAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPSlOODDBUz72rfP+hK/NKkY99DFjtek4ON2pBMhChsczi3zfQCrDyzX/YQWWOU+fmwG8Bk3CbFZnXblgBjXQNUvGR8IVA5VnlHhgMXteFLKwQGxvZ0x/wsNu6LWVz5Yo6lSpYx5KJ/Q0xzCtdPAtD9zneIw8el3LQrojVUbfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A69631F74D;
	Tue,  4 Mar 2025 06:10:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A10961393C;
	Tue,  4 Mar 2025 06:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UIlWFmmZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:49 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 7/8] initramfs: fix hardlink hash leak without TRAILER
Date: Tue,  4 Mar 2025 16:57:50 +1100
Message-ID: <20250304061020.9815-8-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304061020.9815-1-ddiss@suse.de>
References: <20250304061020.9815-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A69631F74D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

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
 init/initramfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index b9cacdc54eaf1..e0b11f8d6f3d6 100644
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
@@ -564,6 +567,8 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
+	/* free any hardlink state collected without optional TRAILER!!! */
+	free_hash();
 	kfree(bufs);
 	return message;
 }
-- 
2.43.0


