Return-Path: <linux-fsdevel+bounces-9440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3469841478
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630A41F22020
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B3A153BD1;
	Mon, 29 Jan 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y13LX74e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JjqX9IRl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y13LX74e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JjqX9IRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98773F9F3;
	Mon, 29 Jan 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561018; cv=none; b=ufJmZsCAFfb0wkQg2MlnbTc7kVgrqY3t166UZkUzUqGGWfwSfDAwSEo50UAyfu0B6WaErX7RP13NcDfc4ATjDdSLAVPInYhJDOHcdOC2urwWJtx9wBNHBVlzQ4nJUfLE7Um9y4l40qPFn6brqPX84TrqK8ygaqU179bEVEnpCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561018; c=relaxed/simple;
	bh=zWnTQls7zJksGdbaIzsnftEf+GfNWBHBMg8G8QqUrOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4Hebqv+PhhoAq80GSt941XGjiVJNJR2wKKf2xeyIybMUzGjMgzJVj5faqIDMIt49xfoD4iV0hWvpJEBNjvZ1zFIc38cb8kt7VNNHY+2+UNnIQUbF2OF04xZiMHkWWAVfEilOxvz0nyxTNRxa9agb+MNgFAujzQzyezcyufkymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y13LX74e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JjqX9IRl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y13LX74e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JjqX9IRl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02B9621E90;
	Mon, 29 Jan 2024 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706561015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gafjaukDasr5oQuNWIkTl8VbHZftkVo7vNgh9ZWycDc=;
	b=Y13LX74e6Iz11+VN5UxxZlMdkJ11bbWANbBANCg5zX3m9OJDPXXOmKBL2A2QCz/iX1tpi+
	YrBSuL32IUAW0Ur8mcCFsvZIStwK8p8nHMCITudkbOgykzCraNwyHhSm8vwloD7dz4Ko/i
	kD4o4kYMe2Tgw6V2pvEJc6tBraAJtZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706561015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gafjaukDasr5oQuNWIkTl8VbHZftkVo7vNgh9ZWycDc=;
	b=JjqX9IRlapCI+n7hKlhomBoPixESwOWCP9ECYF+pjnOo66jIzgQii+7HZdrL735VLpQs9Y
	YWXlPdScEox3ZlBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706561015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gafjaukDasr5oQuNWIkTl8VbHZftkVo7vNgh9ZWycDc=;
	b=Y13LX74e6Iz11+VN5UxxZlMdkJ11bbWANbBANCg5zX3m9OJDPXXOmKBL2A2QCz/iX1tpi+
	YrBSuL32IUAW0Ur8mcCFsvZIStwK8p8nHMCITudkbOgykzCraNwyHhSm8vwloD7dz4Ko/i
	kD4o4kYMe2Tgw6V2pvEJc6tBraAJtZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706561015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gafjaukDasr5oQuNWIkTl8VbHZftkVo7vNgh9ZWycDc=;
	b=JjqX9IRlapCI+n7hKlhomBoPixESwOWCP9ECYF+pjnOo66jIzgQii+7HZdrL735VLpQs9Y
	YWXlPdScEox3ZlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E51012FF7;
	Mon, 29 Jan 2024 20:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YoUnEfYNuGW5DAAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 29 Jan 2024 20:43:34 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v5 00/12] Set casefold/fscrypt dentry operations through sb->s_d_op
Date: Mon, 29 Jan 2024 17:43:18 -0300
Message-ID: <20240129204330.32346-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
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
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hi,

Sorry for the quick respin. The only difference from v4 is that we
change the way we check for relevant dentries during a d_move, as
suggested by Eric.

The v5 of this patchset addresses the issues Eric pointed out in the
previous version.  The patch merging the fscrypt lookup helpers was
completely rewritten to avoid the race condition; We also now return
immediately from __fscrypt_handle_d_move; Finally, the overlayfs patch
message was improved.  Further details can be found on the changelog of
each patch.

As usual, this survived fstests on ext4 and f2fs.

---
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

Gabriel Krisman Bertazi (12):
  ovl: Reject mounting over case-insensitive directories
  fscrypt: Factor out a helper to configure the lookup dentry
  fscrypt: Call fscrypt_prepare_lookup_dentry on unencrypted dentries
  fscrypt: Drop d_revalidate for valid dentries during lookup
  fscrypt: Drop d_revalidate once the key is added
  fscrypt: Ignore plaintext dentries during d_move
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  libfs: Add helper to choose dentry operations at mount-time
  ext4: Configure dentry operations at dentry-creation time
  f2fs: Configure dentry operations at dentry-creation time
  ubifs: Configure dentry operations at dentry-creation time
  libfs: Drop generic_set_encrypted_ci_d_ops

 fs/crypto/hooks.c       | 28 +++-----------
 fs/ext4/namei.c         |  1 -
 fs/ext4/super.c         |  1 +
 fs/f2fs/namei.c         |  1 -
 fs/f2fs/super.c         |  1 +
 fs/libfs.c              | 62 +++++++++---------------------
 fs/overlayfs/params.c   | 14 +++++--
 fs/ubifs/dir.c          |  1 -
 fs/ubifs/super.c        |  1 +
 include/linux/fs.h      | 11 +++++-
 include/linux/fscrypt.h | 83 ++++++++++++++++++++++++++++++-----------
 11 files changed, 108 insertions(+), 96 deletions(-)

-- 
2.43.0


