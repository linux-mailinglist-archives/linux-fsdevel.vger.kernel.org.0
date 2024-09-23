Return-Path: <linux-fsdevel+bounces-29840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E697EA6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 13:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3161F21FE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE2197554;
	Mon, 23 Sep 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5RrzcD0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="28sjW6Hd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5RrzcD0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="28sjW6Hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BF1957E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089436; cv=none; b=F0q6CJe3jT6ZpkspFmueAXchMYPPn5Qzx9SZLdyXZNHfTq0y6V3NZnQc2GxfvnDtVE3Pgi00yS98g6PtfZn4+qbihs0xPwFydkFvlstu8Qs8Y4GGTVDlt798Rh59ALkxgInKi5+a3KSlq9GBJHaaSq30czdpJPNSPmAmEcM55bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089436; c=relaxed/simple;
	bh=5WZUkFVhl5+ZPdFGwvhM+I6gDM0KJ29xXAr+HMYgsI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JBEOPaPnpXznLC6TTj6oQlQDdhX8jyQI2i+cCwu0UGLbjuS024HjC8K3RU2XfM9SYalpio6yMsNyYlP965+JR3PAEE9MAZbJ23pfGGDklDk2fmi1ywahBmWSB/BcJQH0w8jxU0BpS2FiXcFgjHN1vJls9UVG0Y4+mTQir1sxt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5RrzcD0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=28sjW6Hd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5RrzcD0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=28sjW6Hd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEB281FB87;
	Mon, 23 Sep 2024 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727089432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ga7pGfTBHl6XIuSzTe5xu3lgzdm1bPsbgkVkPd/zjB8=;
	b=J5RrzcD0QgB0ZXNi5zeICXCREaY1OHZm6fFbV3LpG2GPAsManQj9Hiyx3/1rk4Mgn0U6B7
	eaXcBz0tsX2i5fW+i5v9b/2IHTcoe0SwAbUJfZMeS0zIMatpDkdtk6bjj89XK4KKXIfNqx
	9Bp/rTgzBdBRNTwy2zn/8sY4DSZhARo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727089432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ga7pGfTBHl6XIuSzTe5xu3lgzdm1bPsbgkVkPd/zjB8=;
	b=28sjW6HdKFB2bJUZM5aJeOz9++jHoBd7It4iVbefzo4Kluc/emrIpdtd+oYx7sJHX7bdIb
	+Su050ON263yCiCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J5RrzcD0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=28sjW6Hd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727089432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ga7pGfTBHl6XIuSzTe5xu3lgzdm1bPsbgkVkPd/zjB8=;
	b=J5RrzcD0QgB0ZXNi5zeICXCREaY1OHZm6fFbV3LpG2GPAsManQj9Hiyx3/1rk4Mgn0U6B7
	eaXcBz0tsX2i5fW+i5v9b/2IHTcoe0SwAbUJfZMeS0zIMatpDkdtk6bjj89XK4KKXIfNqx
	9Bp/rTgzBdBRNTwy2zn/8sY4DSZhARo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727089432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ga7pGfTBHl6XIuSzTe5xu3lgzdm1bPsbgkVkPd/zjB8=;
	b=28sjW6HdKFB2bJUZM5aJeOz9++jHoBd7It4iVbefzo4Kluc/emrIpdtd+oYx7sJHX7bdIb
	+Su050ON263yCiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A58BF13A64;
	Mon, 23 Sep 2024 11:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HyhkKBhL8WanIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 11:03:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67AB3A0844; Mon, 23 Sep 2024 13:03:48 +0200 (CEST)
Date: Mon, 23 Sep 2024 13:03:48 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 6.12-rc1
Message-ID: <20240923110348.tbwihs42dxxltabc@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: AEB281FB87
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.12-rc1

to get:
  * The implementation of the pre-content fanotify events. These events are
  sent before read / write / page fault and the execution is paused until
  event listener replies similarly to current fanotify permission events. 
  Facebook and some other vendors already started to use these events for
  implementing hierarchical storage management in their infrastructure.

  * Fix of a data race noticed by syzbot

There are some conflicts of this pull with other work in linux-next, mostly
with multigrain timestamp series which I think Christian decided to
postpone in the end so this may be a non-issue in the end. The conflicts
were easy to resolve - two commits both adding a feature flag to .fs_flags
in struct filesystem_type. Anyway currently, the merge with your tree as
of today has only one trivial conflict in mm/filemap.c due to added
includes.

Top of the tree is 6165bfb427a6. The full shortlog is:

Amir Goldstein (8):
      fsnotify: introduce pre-content permission event
      fsnotify: generate pre-content permission event on open
      fanotify: introduce FAN_PRE_ACCESS permission event
      fanotify: introduce FAN_PRE_MODIFY permission event
      fanotify: pass optional file access range in pre-content event
      fanotify: rename a misnamed constant
      fanotify: report file range info with pre-content events
      fanotify: allow to set errno in FAN_DENY permission response

Jan Kara (1):
      fsnotify: Avoid data race between fsnotify_recalc_mask() and fsnotify_object_watched()

Josef Bacik (10):
      fanotify: don't skip extra event info if no info_mode is set
      fs: add a flag to indicate the fs supports pre-content events
      fanotify: add a helper to check for pre content events
      fanotify: disable readahead if we have pre-content watches
      mm: don't allow huge faults for files with pre content watches
      fsnotify: generate pre-content permission event on page fault
      bcachefs: add pre-content fsnotify hook to fault
      xfs: add pre-content fsnotify hook for write faults
      btrfs: disable defrag on pre-content watched files
      ext4: enable pre-content events

The diffstat is

 fs/bcachefs/fs-io-pagecache.c      |   4 ++
 fs/bcachefs/fs.c                   |   2 +-
 fs/btrfs/ioctl.c                   |   9 +++
 fs/btrfs/super.c                   |   3 +-
 fs/ext4/super.c                    |   6 +-
 fs/namei.c                         |   9 +++
 fs/notify/fanotify/fanotify.c      |  32 ++++++++--
 fs/notify/fanotify/fanotify.h      |  15 +++++
 fs/notify/fanotify/fanotify_user.c | 111 ++++++++++++++++++++++++++------
 fs/notify/fsnotify.c               |  39 ++++++++---
 fs/notify/inotify/inotify_user.c   |   2 +-
 fs/notify/mark.c                   |   8 ++-
 fs/xfs/xfs_file.c                  |   4 ++
 fs/xfs/xfs_super.c                 |   2 +-
 include/linux/fanotify.h           |  20 ++++--
 include/linux/fs.h                 |   1 +
 include/linux/fsnotify.h           |  58 +++++++++++++++--
 include/linux/fsnotify_backend.h   |  59 ++++++++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/linux/fanotify.h      |  18 ++++++
 mm/filemap.c                       | 128 +++++++++++++++++++++++++++++++++++--
 mm/memory.c                        |  22 +++++++
 mm/nommu.c                         |   7 ++
 mm/readahead.c                     |  13 ++++
 security/selinux/hooks.c           |   3 +-
 25 files changed, 511 insertions(+), 65 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

