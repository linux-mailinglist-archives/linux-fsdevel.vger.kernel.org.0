Return-Path: <linux-fsdevel+bounces-41002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61673A2A03F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D887E1672C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F57223715;
	Thu,  6 Feb 2025 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ejsAYohP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SlI27HaK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NONLoB2M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NnK505cZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D41F60A;
	Thu,  6 Feb 2025 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820722; cv=none; b=VRM9FqYfaWAMtf40/BFb/ocDlGYcsaPy5orh30T55LjNodXHw6FbAOnJS/ErIWtbM/awXSC75v39DwdTkvsRbvUNQOoExBKjgT3DJVqlx5ZLV6LCkQ27VLEwohZe3ry+Cjzi+YKcYW31cp7nKByYYRNb3TwxF4zrUm11FfaSpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820722; c=relaxed/simple;
	bh=mkyqEMxbnNNYR5EbJ2Hp34y78GprW+4mXBpXA6ogQZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npwggjXUuFdBCBbv5fSiMDG6zTGEBTbvo6GWVUyvXviXWO0NFMuZs9/NLrC4lWLcAPk8cy4MMiMiAGdCxsDAdrCOq8XFvYCPHq8gZ2Xhub6Fs3SSiFaR4USQ125iZ7xUw4pL+xQ00cCAsyJ+p4idRuwbXiEgzPv/oE7lnDiGK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ejsAYohP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SlI27HaK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NONLoB2M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NnK505cZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA1FD21108;
	Thu,  6 Feb 2025 05:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iyDXYvtmnHTjBGwvpmMSseMyjwG/VBRFeLnGHBIHtis=;
	b=ejsAYohPvvu9YzRwOA23jIYfPxJOP53Eyhr6tQPFT1JiwOP/1de4o0hFCqh+pVVIzxTuY/
	zj/J0S6CappKYn1V1tm4hTWtHSSusyMaEjhggqnpdqSioGZNwIKk89idvUhZ4g5Gzf9M7s
	nzKeAJxFdvcpG0nGhRfNKpftOij4n08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iyDXYvtmnHTjBGwvpmMSseMyjwG/VBRFeLnGHBIHtis=;
	b=SlI27HaKWS6tq1K63G9TfUZujTmdUy/AKpwif8wUep/HEIPVzGEcQ8PAVCkkbL1ju+YM/v
	b2bAnPBQhE+dH4Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NONLoB2M;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NnK505cZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iyDXYvtmnHTjBGwvpmMSseMyjwG/VBRFeLnGHBIHtis=;
	b=NONLoB2MyJ9qVzCWAK1e47sfETcu9a8xjJuJDeA2f2YMRKj28CD13mVPmslnmy6ELWR+NP
	6L8aF0p5ewlZpgwJ3jk1VbjT6heiO/rOPXCTtx/gpC1Ykvh9vk8Tfb+/3pM6PKhcu9nONi
	62UdnS1rEDu70Be3YH660giDG58TyW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iyDXYvtmnHTjBGwvpmMSseMyjwG/VBRFeLnGHBIHtis=;
	b=NnK505cZLHqTwPIaOfh1J9lVje/isrrNbmQ0/jB0u+pAEvuopicTDzPAM/mPiv1uHC1zH7
	EnZSud+tKgyHfwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09A9713795;
	Thu,  6 Feb 2025 05:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 34TtK2pMpGcsBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:45:14 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/19 v7?] RFC: Allow concurrent and async changes in a directory
Date: Thu,  6 Feb 2025 16:42:37 +1100
Message-ID: <20250206054504.2950516-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA1FD21108
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is my latest attempt at removing the requirement for an exclusive
lock on a directory which performing updates in this.  This version,
inspired by Dave Chinner, goes a step further and allow async updates.

The inode operation still requires the inode lock, at least a shared
lock, but may return -EINPROGRES and then continue asynchronously
without needing any ongoing lock on the directory.

An exclusive lock on the dentry is held across the entire operation.

This change requires various extra checks.  rmdir must ensure there is
no async creation still happening.  rename between directories must
ensure non of the relevant ancestors are undergoing async rename.  There
may be or checks that I need to consider - mounting?

One other important change since my previous posting is that I've
dropped the idea of taking a separate exclusive lock on the directory
when the fs doesn't support shared locking.  This cannot work as it
doeesn't prevent lookups and filesystems don't expect a lookup while
they are changing a directory.  So instead we need to choose between
exclusive or shared for the inode on a case-by-case basis.

To make this choice we divide all ops into four groups: create, remove,
rename, open/create.  If an inode has no operations in the group that
require an exclusive lock, then a flag is set on the inode so that
various code knows that a shared lock is sufficient.  If the flag is not
set, an exclusive lock is obtained.

I've also added rename handling and converted NFS to use all _async ops.

The motivation for this comes from the general increase in scale of
systems.  We can support very large directories and many-core systems
and applications that choose to use large directories can hit
unnecessary contention.

NFS can easily hit this when used over a high-latency link.
Lustre already has code to allow concurrent directory updates in the
back-end filesystem (ldiskfs - a slightly modified ext4).
Lustre developers believe this would also benefit the client-side
filesystem with large core counts.

The idea behind the async support is to eventually connect this to
io_uring so that one process can launch several concurrent directory
operations.  I have not looked deeply into io_uring and cannot be
certain that the interface I've provided will be able to be used.  I
would welcome any advice on that matter, though I hope to find time to
explore myself.  For now if any _async op returns -EINPROGRESS we simply
wait for the callback to indicate completion.

Test status:  only light testing.  It doesn't easily blow up, but lockdep
complains that repeated calls to d_update_wait() are bad, even though
it has balanced acquire and release calls. Weird?

Thanks,
NeilBrown

 [PATCH 01/19] VFS: introduce vfs_mkdir_return()
 [PATCH 02/19] VFS: use global wait-queue table for d_alloc_parallel()
 [PATCH 03/19] VFS: use d_alloc_parallel() in lookup_one_qstr_excl()
 [PATCH 04/19] VFS: change kern_path_locked() and
 [PATCH 05/19] VFS: add common error checks to lookup_one_qstr()
 [PATCH 06/19] VFS: repack DENTRY_ flags.
 [PATCH 07/19] VFS: repack LOOKUP_ bit flags.
 [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
 [PATCH 09/19] VFS: add _async versions of the various directory
 [PATCH 10/19] VFS: introduce inode flags to report locking needs for
 [PATCH 11/19] VFS: Add ability to exclusively lock a dentry and use
 [PATCH 12/19] VFS: enhance d_splice_alias to accommodate shared-lock
 [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races with
 [PATCH 14/19] VFS: Ensure no async updates happening in directory
 [PATCH 15/19] VFS: Change lookup_and_lock() to use shared lock when
 [PATCH 16/19] VFS: add lookup_and_lock_rename()
 [PATCH 17/19] nfsd: use lookup_and_lock_one() and
 [PATCH 18/19] nfs: change mkdir inode_operation to mkdir_async
 [PATCH 19/19] nfs: switch to _async for all directory ops.

