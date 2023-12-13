Return-Path: <linux-fsdevel+bounces-6022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E43E812356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 00:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE871C2148E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C183B1F;
	Wed, 13 Dec 2023 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lBwXMd1E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/jFoUx2k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lBwXMd1E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/jFoUx2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A652122;
	Wed, 13 Dec 2023 15:40:57 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 923242230E;
	Wed, 13 Dec 2023 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702510839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ob8CvgVrk1WZbkIoZ6UBNnmSgu3zulSWfLiJK83jOqA=;
	b=lBwXMd1EPmnGnA8+k3bo5cw3oNB545PNRt2oXQ2MSwXJTDndMTZOmOd2ttgQ80s1sQibOS
	oepcveTHzebyEc5MYn1U/Igq0lEr+9McqN2v6vd99wQwZ7aA2YeGDeUIim24X+MCmU/s/a
	8trlKpAsdITnHkLCYBYFTQJic6UD1QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702510839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ob8CvgVrk1WZbkIoZ6UBNnmSgu3zulSWfLiJK83jOqA=;
	b=/jFoUx2kLod1hZkAlOySsxr7piDjHRpp764THDP20gBnCz7XvevHBSZDXL7Mcd8+FM+2MX
	6ZliT/DI8Q4qmXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702510839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ob8CvgVrk1WZbkIoZ6UBNnmSgu3zulSWfLiJK83jOqA=;
	b=lBwXMd1EPmnGnA8+k3bo5cw3oNB545PNRt2oXQ2MSwXJTDndMTZOmOd2ttgQ80s1sQibOS
	oepcveTHzebyEc5MYn1U/Igq0lEr+9McqN2v6vd99wQwZ7aA2YeGDeUIim24X+MCmU/s/a
	8trlKpAsdITnHkLCYBYFTQJic6UD1QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702510839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ob8CvgVrk1WZbkIoZ6UBNnmSgu3zulSWfLiJK83jOqA=;
	b=/jFoUx2kLod1hZkAlOySsxr7piDjHRpp764THDP20gBnCz7XvevHBSZDXL7Mcd8+FM+2MX
	6ZliT/DI8Q4qmXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AAA11377F;
	Wed, 13 Dec 2023 23:40:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fLf5C/dAemVXPgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 13 Dec 2023 23:40:39 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 0/8] Revert setting casefolding dentry operations through s_d_op
Date: Wed, 13 Dec 2023 18:40:23 -0500
Message-ID: <20231213234031.1081-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.44
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.44
X-Spamd-Result: default: False [3.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.26)[73.73%]
X-Spam-Flag: NO

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

It survives fstests encrypt and quick groups without regressions.  Based on v6.7-rc1.

[1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@ZenIV/
[2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@ZenIV/

Gabriel Krisman Bertazi (8):
  dcache: Add helper to disable d_revalidate for a specific dentry
  fscrypt: Drop d_revalidate if key is available
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  libfs: Expose generic_ci_dentry_ops outside of libfs
  ext4: Set the case-insensitive dentry operations through ->s_d_op
  f2fs: Set the case-insensitive dentry operations through ->s_d_op
  libfs: Don't support setting casefold operations during lookup
  fscrypt: Move d_revalidate configuration back into fscrypt

 fs/crypto/fname.c       |  9 +++++-
 fs/crypto/hooks.c       |  8 ++++++
 fs/dcache.c             | 10 +++++++
 fs/ext4/namei.c         |  1 -
 fs/ext4/super.c         |  3 ++
 fs/f2fs/namei.c         |  1 -
 fs/f2fs/super.c         |  3 ++
 fs/libfs.c              | 64 +++--------------------------------------
 fs/ubifs/dir.c          |  1 -
 include/linux/dcache.h  |  1 +
 include/linux/fs.h      |  2 +-
 include/linux/fscrypt.h | 10 +++----
 12 files changed, 43 insertions(+), 70 deletions(-)

-- 
2.43.0


