Return-Path: <linux-fsdevel+bounces-21510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E0904C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE630283D53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 07:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78416B75C;
	Wed, 12 Jun 2024 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LkV/ZaX8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xgm+6acR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FPE2S/yD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0FtTp0u0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086D25622;
	Wed, 12 Jun 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176206; cv=none; b=EBF9J3LB2B0VjCp0/+lU8y4IpeNq59FEvqNkR1AMIJkCTVITNxDj0stByXmp10Ze4y0kfWJTT3Zo2IT32ANOr2lxqTiLIIM+47cgCbIadXHIlzKXcgOcBP/k5vLIrvBLiWPbgWC2uiaZlZEAdQ80VK8ayk7bqdxQolOCHLfuzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176206; c=relaxed/simple;
	bh=qbxLuon5KxXHYApDIRUEBavM5lzeW7uuEr5MdN4Lllg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=uS59i43bdlx/P97WN1HKKmuHrD9g2t7a3mi4B/zMkNROGOvFeKdhGz919q0u/3qwDrX9RzVVwPF1TmzhDhDx1GbCLm0AeMz02zcqm4FntgiHhc7554H9wTyj28FehXwLM48mJ9dJM4gtqDfC05hPe3qPeRLX9lcnR/Gg6AAkBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LkV/ZaX8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xgm+6acR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FPE2S/yD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0FtTp0u0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE1ED5BD04;
	Wed, 12 Jun 2024 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718176203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G7i4+1Vvosd7eNoIC1qmAQ+0MIGQEpsmdevyZCNDhcs=;
	b=LkV/ZaX8lAh6loAJySmBqgm3MoWJ2qaC/UTH6hiZv4NQLc5G5OPf43eo8Teb4ya2XflPD4
	hgiWeFqEXDf/jKI2lFLelo1EiPom5+kHs2T9WJ/yujZXMTMMC7Z7yn2tn9Eng+NOR4S1GF
	ZYNdebNgUPYn8qe2+IvF00+uYv0eejw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718176203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G7i4+1Vvosd7eNoIC1qmAQ+0MIGQEpsmdevyZCNDhcs=;
	b=Xgm+6acRrYEg3rDOjcP6GBzDP4JVeL0Dm2hoXSP/BB+LqT2GWCtjbTf62QEF6xI+FOytC5
	Esq5XwDgN3mowTAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="FPE2S/yD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0FtTp0u0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718176202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G7i4+1Vvosd7eNoIC1qmAQ+0MIGQEpsmdevyZCNDhcs=;
	b=FPE2S/yDU2yTIbPU0wRddevJtzKslVe57uxTWkRd+cjtOsQwild9quZUoo6moeZ7PG6Vks
	kOXRY2JVCeQkieNqmrcUQhpXD441lealnKHbbdK4XUlWv0gbA6lWjMJaiSOf+tH9+5uKRM
	1He3hQIOze2vogmudW5zc4+si4pjYkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718176202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G7i4+1Vvosd7eNoIC1qmAQ+0MIGQEpsmdevyZCNDhcs=;
	b=0FtTp0u091MUVhJtYYnpRK2mRbRFtlOl2V73w9vP4JAc2Waz2xxnuJI8Nyujbru64CaZj8
	eTMtPKMtdtLownAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 291C9137DF;
	Wed, 12 Jun 2024 07:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S0/bL8ZJaWYQRQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 07:09:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, James Clark <james.clark@arm.com>,
 ltp@lists.linux.it, linux-nfs@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject:
 [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
Date: Wed, 12 Jun 2024 17:09:55 +1000
Message-id: <171817619547.14261.975798725161704336@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,lists.linux.it,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CE1ED5BD04
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 


When a file is opened and created with open(..., O_CREAT) we get
both the CREATE and OPEN fsnotify events and would expect them in that
order.   For most filesystems we get them in that order because
open_last_lookups() calls fsnofify_create() and then do_open() (from
path_openat()) calls vfs_open()->do_dentry_open() which calls
fsnotify_open().

However when ->atomic_open is used, the
   do_dentry_open() -> fsnotify_open()
call happens from finish_open() which is called from the ->atomic_open
handler in lookup_open() which is called *before* open_last_lookups()
calls fsnotify_create.  So we get the "open" notification before
"create" - which is backwards.  ltp testcase inotify02 tests this and
reports the inconsistency.

This patch lifts the fsnotify_open() call out of do_dentry_open() and
places it higher up the call stack.  There are three callers of
do_dentry_open().

For vfs_open() and kernel_file_open() the fsnotify_open() is placed
directly in that caller so there should be no behavioural change.

For finish_open() there are two cases:
 - finish_open is used in ->atomic_open handlers.  For these we add a
   call to fsnotify_open() at the top of do_open() if FMODE_OPENED is
   set - which means do_dentry_open() has been called.
 - finish_open is used in ->tmpfile() handlers.  For these a similar
   call to fsnotify_open() is added to vfs_tmpfile()

With this patch NFSv3 is restored to its previous behaviour (before
->atomic_open support was added) of generating CREATE notifications
before OPEN, and NFSv4 now has that same correct ordering that is has
not had before.  I haven't tested other filesystems.

Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correc=
tly.")
Reported-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/all/01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.=
com
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |  5 +++++
 fs/open.c  | 19 ++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..057afacc4b60 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
 	int acc_mode;
 	int error;
=20
+	if (file->f_mode & FMODE_OPENED)
+		fsnotify_open(file);
+
 	if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
 		error =3D complete_walk(nd);
 		if (error)
@@ -3700,6 +3703,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	mode =3D vfs_prepare_mode(idmap, dir, mode, mode, mode);
 	error =3D dir->i_op->tmpfile(idmap, dir, file, mode);
 	dput(child);
+	if (file->f_mode & FMODE_OPENED)
+		fsnotify_open(file);
 	if (error)
 		return error;
 	/* Don't check for other permissions, the inode was just created */
diff --git a/fs/open.c b/fs/open.c
index 89cafb572061..970f299c0e77 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1004,11 +1004,6 @@ static int do_dentry_open(struct file *f,
 		}
 	}
=20
-	/*
-	 * Once we return a file with FMODE_OPENED, __fput() will call
-	 * fsnotify_close(), so we need fsnotify_open() here for symmetry.
-	 */
-	fsnotify_open(f);
 	return 0;
=20
 cleanup_all:
@@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
  */
 int vfs_open(const struct path *path, struct file *file)
 {
+	int ret;
+
 	file->f_path =3D *path;
-	return do_dentry_open(file, NULL);
+	ret =3D do_dentry_open(file, NULL);
+	if (!ret)
+		/*
+		 * Once we return a file with FMODE_OPENED, __fput() will call
+		 * fsnotify_close(), so we need fsnotify_open() here for symmetry.
+		 */
+		fsnotify_open(file);
+	return ret;
 }
=20
 struct file *dentry_open(const struct path *path, int flags,
@@ -1178,7 +1182,8 @@ struct file *kernel_file_open(const struct path *path, =
int flags,
 	if (error) {
 		fput(f);
 		f =3D ERR_PTR(error);
-	}
+	} else
+		fsnotify_open(f);
 	return f;
 }
 EXPORT_SYMBOL_GPL(kernel_file_open);
--=20
2.44.0


