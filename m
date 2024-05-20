Return-Path: <linux-fsdevel+bounces-19779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115DA8C9C11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF411C21D8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331BE5337F;
	Mon, 20 May 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zJUwLbd+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ww99VMJm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zJUwLbd+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ww99VMJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEB20EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716204163; cv=none; b=frDlrWXA6tBua+THaFBLGQxs0+f9QFiVHcO+WWS4gFgY6U+T/wzBEV+ew/Pwyt5zgWk95FqWDc+Y4Rz2YjLeNFnP8JrFtdFU7jeF2g8aG/e/kalhBAtj55SOhwZqjKxGa51cvNNuJlgSNUj112eB97je0ArYUJ6xCD473moXMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716204163; c=relaxed/simple;
	bh=R/LD8gK9RWotORZUfYxsKtoiglZt5RAwomEx6sxmEVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rtFXy5lF7icS2SHx8Oa1UDoMV21V2RwTMArELRWwbX8AZAK5DLEjeand2Gc7iwIu2d7m0dCDeILC8AcCUlZzEWFNbsXRqUyJQRE0p4GaWl/Clue4rVJitD7v6/2d9yiK+Rb0m+o5vIsyTTE0wPc1emQ3bh0kStp67LScQIXkEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zJUwLbd+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ww99VMJm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zJUwLbd+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ww99VMJm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BECF220C81;
	Mon, 20 May 2024 11:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716204159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=f0+cBerWqFxMH69QswKQxemn6zOKtGX+ctf6Z9sepiE=;
	b=zJUwLbd+zwOCTSPJyWC+sX0jNVysVH9fmC8GIWdmDb9uLy61UxE07WoZVjRCSgNYBNtRdV
	qC9TupPLR3YKJtjCrM9TGDuME9XVTWmXbsAqABrxl/FOGUs0J7ebrkzT3OENAIk37pRQl9
	5zjl2fe5wAIwMjuNeroZh2KJJNzEisQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716204159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=f0+cBerWqFxMH69QswKQxemn6zOKtGX+ctf6Z9sepiE=;
	b=ww99VMJmzbEsB8/YLJQke9qnmuVx551Ga92JnQezMg25CAk70R73lUmGGxLWRFng50v2vv
	LOUBcyITOAaiINAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zJUwLbd+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ww99VMJm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716204159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=f0+cBerWqFxMH69QswKQxemn6zOKtGX+ctf6Z9sepiE=;
	b=zJUwLbd+zwOCTSPJyWC+sX0jNVysVH9fmC8GIWdmDb9uLy61UxE07WoZVjRCSgNYBNtRdV
	qC9TupPLR3YKJtjCrM9TGDuME9XVTWmXbsAqABrxl/FOGUs0J7ebrkzT3OENAIk37pRQl9
	5zjl2fe5wAIwMjuNeroZh2KJJNzEisQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716204159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=f0+cBerWqFxMH69QswKQxemn6zOKtGX+ctf6Z9sepiE=;
	b=ww99VMJmzbEsB8/YLJQke9qnmuVx551Ga92JnQezMg25CAk70R73lUmGGxLWRFng50v2vv
	LOUBcyITOAaiINAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B39C713A6B;
	Mon, 20 May 2024 11:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KjjPK38yS2byNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 11:22:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63565A08D8; Mon, 20 May 2024 13:22:39 +0200 (CEST)
Date: Mon, 20 May 2024 13:22:39 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 6.10-rc1
Message-ID: <20240520112239.pz35myprqju2gzo6@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BECF220C81
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.10-rc1

The pull contains:
  * Changes to reduce overhead of fsnotify infrastructure when no
    permission events are in use
  * A few small cleanups

Top of the tree is 795bb82d12a1. The full shortlog is:

Amir Goldstein (11):
      fsnotify: rename fsnotify_{get,put}_sb_connectors()
      fsnotify: create helpers to get sb and connp from object
      fsnotify: create a wrapper fsnotify_find_inode_mark()
      fanotify: merge two checks regarding add of ignore mark
      fsnotify: pass object pointer and type to fsnotify mark helpers
      fsnotify: create helper fsnotify_update_sb_watchers()
      fsnotify: lazy attach fsnotify_sb_info state to sb
      fsnotify: move s_fsnotify_connectors into fsnotify_sb_info
      fsnotify: use an enum for group priority constants
      fsnotify: optimize the case of no permission event watchers
      fsnotify: fix UAF from FS_ERROR event on a shutting down filesystem

Gustavo A. R. Silva (1):
      fsnotify: Avoid -Wflex-array-member-not-at-end warning

Nikita Kiryushin (1):
      fanotify: remove unneeded sub-zero check for unsigned value

The diffstat is

 fs/nfsd/filecache.c                |   4 +-
 fs/notify/dnotify/dnotify.c        |   4 +-
 fs/notify/fanotify/fanotify_user.c | 143 +++++++++---------------------
 fs/notify/fdinfo.c                 |  20 ++---
 fs/notify/fsnotify.c               |  27 ++++--
 fs/notify/fsnotify.h               |  39 ++++++---
 fs/notify/inotify/inotify_user.c   |   2 +-
 fs/notify/mark.c                   | 174 ++++++++++++++++++++++++++++---------
 fs/super.c                         |   1 +
 include/linux/fs.h                 |  14 +--
 include/linux/fsnotify.h           |  21 ++++-
 include/linux/fsnotify_backend.h   |  97 ++++++++++++++-------
 kernel/audit_tree.c                |   2 +-
 kernel/audit_watch.c               |   2 +-
 14 files changed, 334 insertions(+), 216 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

