Return-Path: <linux-fsdevel+bounces-7823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4A82B75C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDD81F25431
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D456476;
	Thu, 11 Jan 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fnwHOf7b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vlESKhfa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fnwHOf7b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vlESKhfa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8A58114;
	Thu, 11 Jan 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 138F01F74A;
	Thu, 11 Jan 2024 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705013916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ta9IdNZqtCCoKDFw9Ha2hukayZYjXb1Cd+I4SdTh7EI=;
	b=fnwHOf7baa/u9PG6d2dI3pDtz3BV3ue214lU4HH3qyqdTBp7oSC8EXYZ/w0lt2iytgyRq2
	lFjb1jKzvaY/sooANIMbb/DcPAF1+b66ovjpqknq8UZWiTSkCvo61aDLLYkkIvPAMWRPp+
	6fzepX1SmkfGim1wbzdbFLTko7g3JWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705013916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ta9IdNZqtCCoKDFw9Ha2hukayZYjXb1Cd+I4SdTh7EI=;
	b=vlESKhfayfoLOjVUoUqAei5fr+UtHtF7Wa16/zemvgxV9oCbX2bUWjLeTnWdbKQ4XOF+rx
	xEmrdWejX/4z2+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705013916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ta9IdNZqtCCoKDFw9Ha2hukayZYjXb1Cd+I4SdTh7EI=;
	b=fnwHOf7baa/u9PG6d2dI3pDtz3BV3ue214lU4HH3qyqdTBp7oSC8EXYZ/w0lt2iytgyRq2
	lFjb1jKzvaY/sooANIMbb/DcPAF1+b66ovjpqknq8UZWiTSkCvo61aDLLYkkIvPAMWRPp+
	6fzepX1SmkfGim1wbzdbFLTko7g3JWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705013916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ta9IdNZqtCCoKDFw9Ha2hukayZYjXb1Cd+I4SdTh7EI=;
	b=vlESKhfayfoLOjVUoUqAei5fr+UtHtF7Wa16/zemvgxV9oCbX2bUWjLeTnWdbKQ4XOF+rx
	xEmrdWejX/4z2+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E66013946;
	Thu, 11 Jan 2024 22:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /azCFZtyoGVILwAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 11 Jan 2024 22:58:35 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 00/10] Set casefold/fscrypt dentry operations through sb->s_d_op
Date: Thu, 11 Jan 2024 19:58:06 -0300
Message-ID: <20240111225816.18117-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fnwHOf7b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vlESKhfa
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 138F01F74A
X-Spam-Flag: NO

Hi,

Thank you, Eric and Al, for your feedback on the previous version.

This version has some big changes: instead of only configuring on the
case-insensitive case, we do it for case-sensitive fscrypt as well, and
disable d_revalidate as needed.  This pretty much reverses the way
fscrypt operated (only enable d_revalidate for dentries that require
it), but has the advantage we can be consistent among variations of
case-insensitive/sensitive, encrypted/unencrypted configurations.

You'll find the code is simpler than v1 and v2.  I dropped the dcache
patch because now we always try to disable DCACHE_OP_REVALIDATE while
holding the d_lock already, so I do it inline; I also changed the way we
drop d_revalidate when the key is made available, because we couldn't
really do it the way I originally proposed on the RCU case, which would
require falling back to non-RCU lookup just to disable d_revalidate; I
also included a patch fixing the overlayfs issue that I mentioned on the
previous thread.  While unrelated to the rest of the patchset, it is a
quick fix that I might merge earlier if you are happy with it.

More details can be found in the per-patch changelog.

This survived fstests on ext4 and f2fs.  I also verified that fscrypt
continues to work when combined to overlayfs as Eric requested.

..
original cover letter:

When case-insensitive and fscrypt were adapted to work together, we moved the
code that sets the dentry operations for case-insensitive dentries(d_hash and
d_compare) to happen from a helper inside ->lookup.  This is because fscrypt
wants to set d_revalidate only on some dentries, so it does it only for them in
d_revalidate.

But, case-insensitive hooks are actually set on all dentries in the filesystem,
so the natural place to do it is through s_d_op and let d_alloc handle it [1].
In addition, doing it inside the ->lookup is a problem for case-insensitive
dentries that are not created through ->lookup, like those coming
open-by-fhandle[2], which will not see the required d_ops.

This patchset therefore reverts to using sb->s_d_op to set the dentry operations
for case-insensitive filesystems.  In order to set case-insensitive hooks early
and not require every dentry to have d_revalidate in case-insensitive
filesystems, it introduces a patch suggested by Al Viro to disable d_revalidate
on some dentries on the fly.

It survives fstests encrypt and quick groups without regressions.  Based on
v6.7-rc1.

[1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@ZenIV/
[2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@ZenIV/

Gabriel Krisman Bertazi (10):
  ovl: Reject mounting case-insensitive filesystems
  fscrypt: Share code between functions that prepare lookup
  fscrypt: Drop d_revalidate for valid dentries during lookup
  fscrypt: Drop d_revalidate once the key is added
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  libfs: Add helper to choose dentry operations at mount
  ext4: Configure dentry operations at dentry-creation time
  f2fs: Configure dentry operations at dentry-creation time
  ubifs: Configure dentry operations at dentry-creation time
  libfs: Drop generic_set_encrypted_ci_d_ops

 fs/ceph/dir.c           |  2 +-
 fs/ceph/file.c          |  2 +-
 fs/crypto/hooks.c       | 62 +++++++++++++++++++++--------------------
 fs/ext4/namei.c         |  1 -
 fs/ext4/super.c         |  1 +
 fs/f2fs/namei.c         |  1 -
 fs/f2fs/super.c         |  1 +
 fs/libfs.c              | 61 +++++++++++-----------------------------
 fs/overlayfs/params.c   | 13 +++++++--
 fs/ubifs/dir.c          |  1 -
 fs/ubifs/super.c        |  1 +
 include/linux/fs.h      | 11 +++++++-
 include/linux/fscrypt.h | 51 ++++++++++++++++++++-------------
 13 files changed, 106 insertions(+), 102 deletions(-)

-- 
2.43.0


