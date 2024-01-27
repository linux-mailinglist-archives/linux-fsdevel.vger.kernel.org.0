Return-Path: <linux-fsdevel+bounces-9138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B383E7FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8401B27228
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD608A55;
	Sat, 27 Jan 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kg617hfS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fZQkcjqw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kg617hfS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fZQkcjqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322081C2F;
	Sat, 27 Jan 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314222; cv=none; b=oxZezoS6qbs4XBEiIhgHQONz3JSwL5oxwZPbSkbzJds81Z7lJv06yCgAjxUB9DEZKjcMjcMW/9g4uB0tP+P2r7o9T274O9xIVMalKVwkWP+sV3D3Hdskhi08BH8ZxbBAUbbfjYu7osCk1KspA246/XdN4q5o3dzhEvS+SaBcra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314222; c=relaxed/simple;
	bh=jvyy4JAJu9Y6cX/1I2LuK3eXa22FjhvE6irM/TZBjms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIG7OcITRDk5q2P18jpIGKXeuQFh9XryMq6ZZyOPVwcccHz8fZGl0hZCrOl26Asp6H9zmBhNBYl6tadCplVp74TwNHPIhp+tL+47Ed2dSk0mBoeN8Bz2u111wQGOvweMFs+WKaywE/HEC5ih+0ULnAjPYqZnjCEvIuGROdsWD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kg617hfS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fZQkcjqw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kg617hfS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fZQkcjqw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 329A32214A;
	Sat, 27 Jan 2024 00:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GydXMmSuj/uYXlybfN2w6K2XDuYK0bvidi/G9R0qOpI=;
	b=kg617hfSs+9so9gC5I1o8ciS4Wy3Dr/YmOOXQF2ZesOXWmRNaBZ6LNa6CUAfHLnzx/fna1
	+ClkwZlqS0kuYbkogWw+2P2UkA8ulu6RdnE6oZPq4ZwxpFqhIeNTm97PxTjJbZbUDEe8Il
	JFfAtSnfrT+a5YcMHTMQwFi8nn2yAvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GydXMmSuj/uYXlybfN2w6K2XDuYK0bvidi/G9R0qOpI=;
	b=fZQkcjqw6hGGrW90atyCw9RCFbtfwIIjRSjTyvMlhTiUM6SvORYMnc/kk6Pcaunn5MdUia
	u7/1ynboi1eP9tCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GydXMmSuj/uYXlybfN2w6K2XDuYK0bvidi/G9R0qOpI=;
	b=kg617hfSs+9so9gC5I1o8ciS4Wy3Dr/YmOOXQF2ZesOXWmRNaBZ6LNa6CUAfHLnzx/fna1
	+ClkwZlqS0kuYbkogWw+2P2UkA8ulu6RdnE6oZPq4ZwxpFqhIeNTm97PxTjJbZbUDEe8Il
	JFfAtSnfrT+a5YcMHTMQwFi8nn2yAvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GydXMmSuj/uYXlybfN2w6K2XDuYK0bvidi/G9R0qOpI=;
	b=fZQkcjqw6hGGrW90atyCw9RCFbtfwIIjRSjTyvMlhTiUM6SvORYMnc/kk6Pcaunn5MdUia
	u7/1ynboi1eP9tCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6CF13998;
	Sat, 27 Jan 2024 00:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yQjED+lJtGVIEQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:17 +0000
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
Subject: [PATCH v4 00/12] Set casefold/fscrypt dentry operations through sb->s_d_op
Date: Fri, 26 Jan 2024 21:10:00 -0300
Message-ID: <20240127001013.2845-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kg617hfS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fZQkcjqw
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: 329A32214A
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Hi,

The v4 of this patchset addresses the issues Eric pointed out in the
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
  fscrypt: Ignore non-fscrypt volumes during d_move
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  libfs: Add helper to choose dentry operations at mount-time
  ext4: Configure dentry operations at dentry-creation time
  f2fs: Configure dentry operations at dentry-creation time
  ubifs: Configure dentry operations at dentry-creation time
  libfs: Drop generic_set_encrypted_ci_d_ops

 fs/crypto/hooks.c       | 28 ++++-----------
 fs/ext4/namei.c         |  1 -
 fs/ext4/super.c         |  1 +
 fs/f2fs/namei.c         |  1 -
 fs/f2fs/super.c         |  1 +
 fs/libfs.c              | 62 +++++++++-----------------------
 fs/overlayfs/params.c   | 14 ++++++--
 fs/ubifs/dir.c          |  1 -
 fs/ubifs/super.c        |  1 +
 include/linux/fs.h      | 11 +++++-
 include/linux/fscrypt.h | 78 +++++++++++++++++++++++++++++------------
 11 files changed, 103 insertions(+), 96 deletions(-)

-- 
2.43.0


