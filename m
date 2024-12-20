Return-Path: <linux-fsdevel+bounces-37899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D49F8A60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75486188CFCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A733062;
	Fri, 20 Dec 2024 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MugXV2K9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+/u6stI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MugXV2K9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+/u6stI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924612594A6;
	Fri, 20 Dec 2024 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664126; cv=none; b=gazgxCYLNj+YPMp9svpHVOCHDw/p31to9gjT8ik6ILAKxGBW6aFN5KOtLxcsoWT4XUnn4xgRpk8Aunr3gugCJps8speT5LnwajRHcRZBCUNX9/WmhwuSrws9j+Ijmg55tbGEHCf73pMGKGntRldDriX2em7lnFQDd19ed1PzuKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664126; c=relaxed/simple;
	bh=pHgnuYTLUh0Ni+z88/T82ADPt268OkOVUtt9Fubn9lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUm+UFXlFTi6ZG+IhpZPnc95wJJJDhFNeTtnRA3q6/ctRIggx5tSPFnTiR4Hm94LgCh5vcj6Wl4r/CykMa+4HBGwwXSb5eLUUbuW2FDjSvaOGPUFTpM6KFKdWXQHMgH5tmspdtAhRSram8XUweD5j/XjbY2UbSdI9UqMbXygqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MugXV2K9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+/u6stI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MugXV2K9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+/u6stI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D4A8210F2;
	Fri, 20 Dec 2024 03:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cOkVodGlWRqKFgJawtG/fFkzeXJVHoe57H9hD6cE/ek=;
	b=MugXV2K9poVBeURSbcs3EFnKu96IPmvYJYMEGFv3bYCDHXL9FWMCRN7CtyVvpOVWzY339T
	qlrNGaflyXGQFRhOiIEq1tf+JePM7KW3x3SZVKRa3T13j/rIGjJmRGM+MJfdJSXL1DH2oI
	3dSPPGVRvdSv0LVfwx0ftfn+qSSEais=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cOkVodGlWRqKFgJawtG/fFkzeXJVHoe57H9hD6cE/ek=;
	b=g+/u6stIAZvg5WXnO9VVB4R3LPk3b2u/WT/in9a5HzHLDmnpAD/K+ox4Qh4UuyPoXeN3Ay
	0qzN3JUVd/jE8rAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cOkVodGlWRqKFgJawtG/fFkzeXJVHoe57H9hD6cE/ek=;
	b=MugXV2K9poVBeURSbcs3EFnKu96IPmvYJYMEGFv3bYCDHXL9FWMCRN7CtyVvpOVWzY339T
	qlrNGaflyXGQFRhOiIEq1tf+JePM7KW3x3SZVKRa3T13j/rIGjJmRGM+MJfdJSXL1DH2oI
	3dSPPGVRvdSv0LVfwx0ftfn+qSSEais=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cOkVodGlWRqKFgJawtG/fFkzeXJVHoe57H9hD6cE/ek=;
	b=g+/u6stIAZvg5WXnO9VVB4R3LPk3b2u/WT/in9a5HzHLDmnpAD/K+ox4Qh4UuyPoXeN3Ay
	0qzN3JUVd/jE8rAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 746F313A32;
	Fri, 20 Dec 2024 03:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1pOtCrjfZGcwGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:08:40 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11 RFC] Allow concurrent changes in a directory
Date: Fri, 20 Dec 2024 13:54:18 +1100
Message-ID: <20241220030830.272429-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

A while ago I posted a patchset with a similar goal as this:

https://lore.kernel.org/all/166147828344.25420.13834885828450967910.stgit@noble.brown/

and recieved useful feedback.  Here is a new version.

This version is not complete.  It does not change rename and does not
change any filesystem to make use of the new opportunity for
parallelism.  I'll work on those once the bases functionality is agreed
on.

With this series, instead of a filesystem setting a flag to indiciate
that parallel updates are support, there are now a new set of inode
operations with a _shared prefix.  If a directory provides a _shared
interface it will be used with a shared lock on the inode, else the
current interface will be used with an exclusive lock.

When a shared lock is taken, we also take an exclusive lock on the
dentry using a couple of flag bits and the "wait_var_event"
infrastructure.

When an exclusive lock is needed (for the old interface) we still take a
shared lock on the directory i_rw_sem but also take a second exclusive
lock on the directory using a couple of flag bits and wait_var_event.
This is meant as a temporary measure until all filesystems are change to
use the _shared interfaces.

Not all calling code has been converted.  Some callers outside of
fs/namei.c still take an exclusive lock with i_rw_sem.  Some might never
be changed.

As yet this has only been lightly tested as I haven't add foo_shared
operations to any filesystem yet.

The motivation partly come from NFS where a high-latency network link
can cause a noticiable performance hit when multiple files are being
created concurrently in a directory.  Another motivation is lustre which
can use a modified ext4 as the storage backend.  One of the current
modification is to allow concurrent updates in a directory as lustre uses a flat directory structure to store data.

Thoughts?

Thanks,
NeilBrown


 [PATCH 01/11] VFS: introduce vfs_mkdir_return()
 [PATCH 02/11] VFS: add _shared versions of the various directory
 [PATCH 03/11] VFS: use global wait-queue table for d_alloc_parallel()
 [PATCH 04/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl()
 [PATCH 05/11] VFS: change kern_path_locked() and
 [PATCH 06/11] VFS: introduce done_lookup_and_lock()
 [PATCH 07/11] VFS: introduce lookup_and_lock()
 [PATCH 08/11] VFS: add inode_dir_lock/unlock
 [PATCH 09/11] VFS: re-pack DENTRY_ flags.
 [PATCH 10/11] VFS: take a shared lock for create/remove directory
 [PATCH 11/11] nfsd: use lookup_and_lock_one()

