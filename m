Return-Path: <linux-fsdevel+bounces-8327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8D832F11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680111F2197E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95854F9B;
	Fri, 19 Jan 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XEQR/Ulj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGk2ZWfI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XEQR/Ulj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGk2ZWfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884A1E4A4;
	Fri, 19 Jan 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690075; cv=none; b=YFufG5x6brIMHYWEWozKL/1lA4lgWTHagnfAiFd4gDjVPCeQKQSpz6+w5Ivi3imok1xFnBIJNdcd0zwlml3k/teOhUesDE5GQ5OVQBqKehgsax4T6D+01iAFTBFTVzWY1eHQ3QXcPzRIWawk71k18hvjmG7ap4wUW6vq9Zmvqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690075; c=relaxed/simple;
	bh=2Mkir5oacOpUSf408YZRKKrYoWsIpkCFfOi5VvVUfew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJp76cTAT3iFNZAy77YjKaxuOih+/daQQtTxIylM46R79uAE9Wfv2n9KtIVgMacTNl/MS+OZZcOdwsq2zOpMChpNnCfPTrx+pi1SNpkffmNTAuL6t3XeCQiYhjbKjN8d/FQY6hTN/vddgFriY7k5bjkHRMwEWUDcjaK+ciFutnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XEQR/Ulj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGk2ZWfI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XEQR/Ulj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGk2ZWfI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B8C11FD18;
	Fri, 19 Jan 2024 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/AK4CUoyCCpgUyKqlaAXUyQMoWBb4a+kMZT5jkRKYRo=;
	b=XEQR/UljNCtTIKGyLwNp8MFJkyg+gMuAAh8+TvUodHRwMlAqahmmS6PwSnSaYsnzXPxv6/
	J5e5CNcqVWw4wEVoKVYfT5m7B1qnfLGzoK6qISCPwC30zQpZRTXB7iF2/Co8Oy+Aufa1ht
	p8Z+Il8r3NYPfR9eQBEhAEuf1EfBeLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/AK4CUoyCCpgUyKqlaAXUyQMoWBb4a+kMZT5jkRKYRo=;
	b=IGk2ZWfI96mVCVYzaNXn1k8QnsLP8hfw4O+Y9ZPRdbDh5jrjtDzohYUNSNNqdF8m7s80Yw
	+jeAdXMa/g5LPiDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/AK4CUoyCCpgUyKqlaAXUyQMoWBb4a+kMZT5jkRKYRo=;
	b=XEQR/UljNCtTIKGyLwNp8MFJkyg+gMuAAh8+TvUodHRwMlAqahmmS6PwSnSaYsnzXPxv6/
	J5e5CNcqVWw4wEVoKVYfT5m7B1qnfLGzoK6qISCPwC30zQpZRTXB7iF2/Co8Oy+Aufa1ht
	p8Z+Il8r3NYPfR9eQBEhAEuf1EfBeLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/AK4CUoyCCpgUyKqlaAXUyQMoWBb4a+kMZT5jkRKYRo=;
	b=IGk2ZWfI96mVCVYzaNXn1k8QnsLP8hfw4O+Y9ZPRdbDh5jrjtDzohYUNSNNqdF8m7s80Yw
	+jeAdXMa/g5LPiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2782136F5;
	Fri, 19 Jan 2024 18:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rrVVJNbDqmUoDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:47:50 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 00/10] Set casefold/fscrypt dentry operations through sb->s_d_op
Date: Fri, 19 Jan 2024 15:47:32 -0300
Message-ID: <20240119184742.31088-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hi,

The only difference of v3 from v2 is a fix from an issue reported by
kernel test robot in patch 4.  Please consider this version instead.

The v2 has some big changes: instead of only configuring on the
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


