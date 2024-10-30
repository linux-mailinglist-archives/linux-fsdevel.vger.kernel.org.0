Return-Path: <linux-fsdevel+bounces-33217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC19B59BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 03:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5CAB22AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 02:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2019154BF0;
	Wed, 30 Oct 2024 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d6fBSQTJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zpOeDkUd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d6fBSQTJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zpOeDkUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115CD531
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253984; cv=none; b=NxJXZjd+doXtIT94AdysWtzrloziG5GLi9pljqQrYP0TJoJQksDb8KAO+zTV7YX6hXrTwk4tKZtcwDos4a0DaCp+tOwErTRA0U7PZZm//km3Td2qjAP5+4CnF599mYI5o6mT+6hA9UgvB+H6++6Li8WwVEnzo/+ge6m0NSlW/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253984; c=relaxed/simple;
	bh=n5DenDjfbNPk6RkO/Oj+cvwSriYH/9dJEvbdUIGVUSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMYYWgAkShjwtNmY2T8lK1CYIopxM5CO/p057knSxfENEqB/kr/QMqtssXNTyIhfDW+Nc9RBpResPdvd3xmYY/sw5B0G1YxIPdbDnQspVfU/c8ROsf02eklM3vVm8gpWfwigxnrrBJSp51XETsydPX660ku6KnlMsTwiRJ5ctEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d6fBSQTJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zpOeDkUd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d6fBSQTJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zpOeDkUd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A1091F7A9;
	Wed, 30 Oct 2024 02:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730253979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bWAtd9KL4GyT2ALZg9Y131zax5p45RjozfwJ1YFJpWA=;
	b=d6fBSQTJbmrwxRroIs1nWwKyB07n0Qtmq7VB/pSjYO9a+pOz6SobZ/gy0DEXopb4Y5NNCj
	K1Rn2sGUKPMotwq41ACsxl7Gq7V9HdFVSkVIzHsUWwdRb722tPhAJgXjTCWJowN+8xF7pb
	ymfdaxLAM2owFieu+GBiAk3WEbwopVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730253979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bWAtd9KL4GyT2ALZg9Y131zax5p45RjozfwJ1YFJpWA=;
	b=zpOeDkUdXrSwSJhLdrtS24SXp7EtPwhlF6Ltf5UNKzCve0G8UGytJiu7l6lYg9dUnkJDBa
	zHFxdIqzsIqrTnDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d6fBSQTJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zpOeDkUd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730253979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bWAtd9KL4GyT2ALZg9Y131zax5p45RjozfwJ1YFJpWA=;
	b=d6fBSQTJbmrwxRroIs1nWwKyB07n0Qtmq7VB/pSjYO9a+pOz6SobZ/gy0DEXopb4Y5NNCj
	K1Rn2sGUKPMotwq41ACsxl7Gq7V9HdFVSkVIzHsUWwdRb722tPhAJgXjTCWJowN+8xF7pb
	ymfdaxLAM2owFieu+GBiAk3WEbwopVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730253979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bWAtd9KL4GyT2ALZg9Y131zax5p45RjozfwJ1YFJpWA=;
	b=zpOeDkUdXrSwSJhLdrtS24SXp7EtPwhlF6Ltf5UNKzCve0G8UGytJiu7l6lYg9dUnkJDBa
	zHFxdIqzsIqrTnDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEEF613AD6;
	Wed, 30 Oct 2024 02:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PNyCHJmUIWdwNgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 30 Oct 2024 02:06:17 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] initramfs: avoid filename buffer overrun
Date: Wed, 30 Oct 2024 02:02:23 +0000
Message-ID: <20241030020222.17806-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A1091F7A9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The initramfs filename field is defined in
Documentation/driver-api/early-userspace/buffer-format.rst as:

 37 cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
...
 55 ============= ================== =========================
 56 Field name    Field size         Meaning
 57 ============= ================== =========================
...
 70 c_namesize    8 bytes            Length of filename, including final \0

When extracting an initramfs cpio archive, the kernel's do_name() path
handler assumes a zero-terminated path at @collected, passing it
directly to filp_open() / init_mkdir() / init_mknod().

If a specially crafted cpio entry carries a non-zero-terminated filename
and is followed by uninitialized memory, then a file may be created with
trailing characters that represent the uninitialized memory. The ability
to create an initramfs entry would imply already having full control of
the system, so the buffer overrun shouldn't be considered a security
vulnerability.

Append the output of the following bash script to an existing initramfs
and observe any created /initramfs_test_fname_overrunAA* path. E.g.
  ./reproducer.sh | gzip >> /myinitramfs

It's easiest to observe non-zero uninitialized memory when the output is
gzipped, as it'll overflow the heap allocated @out_buf in __gunzip(),
rather than the initrd_start+initrd_size block.

---- reproducer.sh ----
nilchar="A"	# change to "\0" to properly zero terminate / pad
magic="070701"
ino=1
mode=$(( 0100777 ))
uid=0
gid=0
nlink=1
mtime=1
filesize=0
devmajor=0
devminor=1
rdevmajor=0
rdevminor=0
csum=0
fname="initramfs_test_fname_overrun"
namelen=$(( ${#fname} + 1 ))	# plus one to account for terminator

printf "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s" \
	$magic $ino $mode $uid $gid $nlink $mtime $filesize \
	$devmajor $devminor $rdevmajor $rdevminor $namelen $csum $fname

termpadlen=$(( 1 + ((4 - ((110 + $namelen) & 3)) % 4) ))
printf "%.s${nilchar}" $(seq 1 $termpadlen)
---- reproducer.sh ----

Symlink filename fields handled in do_symlink() won't overrun past the
data segment, due to the explicit zero-termination of the symlink
target.

Fix filename buffer overrun by skipping over any cpio entries where the
field doesn't carry a zero-terminator at the expected (name_len - 1)
offset.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

Changes since v1:
- flag error and exit initramfs FSM instead of skipping the entry
- slightly rework commit message

diff --git a/init/initramfs.c b/init/initramfs.c
index bc911e466d5bb..b2f7583bb1f5c 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -360,6 +360,15 @@ static int __init do_name(void)
 {
 	state = SkipIt;
 	next_state = Reset;
+
+	/* name_len > 0 && name_len <= PATH_MAX checked in do_header */
+	if (collected[name_len - 1] != '\0') {
+		pr_err("initramfs name without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		error("malformed archive");
+		return 1;
+	}
+
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
@@ -424,6 +433,12 @@ static int __init do_copy(void)
 
 static int __init do_symlink(void)
 {
+	if (collected[name_len - 1] != '\0') {
+		pr_err("initramfs symlink without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		error("malformed archive");
+		return 1;
+	}
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
 	init_symlink(collected + N_ALIGN(name_len), collected);
-- 
2.43.0


