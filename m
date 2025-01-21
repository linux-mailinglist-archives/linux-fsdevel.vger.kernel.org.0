Return-Path: <linux-fsdevel+bounces-39786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2439A1814D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC649188423C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969461F4E44;
	Tue, 21 Jan 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Msrxffw+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIh2KbiP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Msrxffw+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIh2KbiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BE1F470E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474295; cv=none; b=Tjn5Gf15kFMGpgMGHfa5oO/jOSBNKCB5pEi4bE4m6Jg1Am8yLQ8FIgLCnR9+eT5Bw8dYvQzECzRwKEFM7kO7j9cribeTOZd2WgDpjqvaM4/GBRGDkgdm4PTk0D0ru6tS0CzoIlMgVDP/zgJxyVTvNVlSbJOm3SDy/sYcVarP9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474295; c=relaxed/simple;
	bh=qpAnQmLvax83w5pVEYXymxzu3/UF6EhkDzwN6+hg2a4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X0fba5fXOjFMJT5yFODM4wapf9y6ZKUYpqCbRQ8Mq2jmhMPBDKEmDp0L2Fdo+8+FvDylYomlitUbCywRtd/s7O6sqG1r1VnpsqHUAvgzI368lDGEpm21Nz4Fh0Tbl4eTxGPOxnnNHRuAqPJb1muacRl1qv70mD3KdkcPw1Afhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Msrxffw+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIh2KbiP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Msrxffw+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIh2KbiP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D630E21172;
	Tue, 21 Jan 2025 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737474290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2EAr0JdRwiTzY1ZYousgtAIDHX2SbemQDyM+V2uO6Go=;
	b=Msrxffw+/QVaC98FfLZppPRVhivX9Qu+5oHfatk1ml+lhPWqPLpnF3pYUQTzJnQYDbFDoE
	Jag8hyNbDKiw6aVODtlm1ZltgGT7FbTyOX/kxk14fOcn6B/7cMUrES2vz0DXsX5bGzAPT8
	2aOfB3cTBJnpdCkDhUMdPdZx3xkzkdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737474290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2EAr0JdRwiTzY1ZYousgtAIDHX2SbemQDyM+V2uO6Go=;
	b=EIh2KbiPI8NA1VyOvGBaNTp2I5GLEwFlHsxQRSXZp2ljbQxG4o/rZJb5XJkl+bSNbEEVwZ
	ynQ0Ifhr98Cm4QAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737474290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2EAr0JdRwiTzY1ZYousgtAIDHX2SbemQDyM+V2uO6Go=;
	b=Msrxffw+/QVaC98FfLZppPRVhivX9Qu+5oHfatk1ml+lhPWqPLpnF3pYUQTzJnQYDbFDoE
	Jag8hyNbDKiw6aVODtlm1ZltgGT7FbTyOX/kxk14fOcn6B/7cMUrES2vz0DXsX5bGzAPT8
	2aOfB3cTBJnpdCkDhUMdPdZx3xkzkdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737474290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2EAr0JdRwiTzY1ZYousgtAIDHX2SbemQDyM+V2uO6Go=;
	b=EIh2KbiPI8NA1VyOvGBaNTp2I5GLEwFlHsxQRSXZp2ljbQxG4o/rZJb5XJkl+bSNbEEVwZ
	ynQ0Ifhr98Cm4QAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5EDF13963;
	Tue, 21 Jan 2025 15:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9esLMPLAj2egVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 15:44:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 715DDA0889; Tue, 21 Jan 2025 16:44:46 +0100 (CET)
Date: Tue, 21 Jan 2025 16:44:46 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: [GIT PULL] Fsnotify pre-content events for 6.14-rc1
Message-ID: <uuxkzulie4wewcbfdtdn6sx75ncm7tbhg3ptj3jpu2sh6q4lx3@zuahiyvmnigl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_hsm_for_v6.14-rc1

to get support for fsnotify pre-content (or HSM) event. Let me quickly sum
up what the feature is about:

The patches introduce new fsnotify event (FS_PRE_ACCESS) that gets
generated before a file contents is accessed. The event is synchronous so
if there is listener for this event, the kernel waits for reply. On success
the execution continues as usual, on failure we propagate the error to
userspace. This allows userspace to fill in file content on demand from
slow storage. The context in which the events are generated has been
picked so that we don't hold any locks and thus there's no risk of a
deadlock for the userspace handler.

The new pre-content event is available only for users with global
CAP_SYS_ADMIN capability (similarly to other parts of fanotify
functionality) and it is an administrator responsibility to make sure the
userspace event handler doesn't do stupid stuff that can DoS the system.

Based on your feedback from the last submission, fsnotify code has been
improved and now file->f_mode encodes whether pre-content event needs to be
generated for the file so the fast path when nobody wants pre-content event
for the file just grows the additional file->f_mode check. As a bonus this
also removes the checks whether the old FS_ACCESS event needs to be
generated from the fast path. Also the place where the event is generated
during page fault has been moved so now filemap_fault() generates the event
if and only if there is no uptodate folio in the page cache. 

Also we have dropped FS_PRE_MODIFY event as current real-world users of the
pre-content functionality don't really use it so let's start with the
minimal useful feature set.

Top of the tree is 0c0214df28f0. The full shortlog is:

Al Viro (1):
      fs: get rid of __FMODE_NONOTIFY kludge

Amir Goldstein (11):
      fsnotify: opt-in for permission events at file open time
      fsnotify: check if file is actually being watched for pre-content events on open
      fanotify: rename a misnamed constant
      fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
      fsnotify: introduce pre-content permission events
      fsnotify: pass optional file access range in pre-content event
      fsnotify: generate pre-content permission event on truncate
      fanotify: introduce FAN_PRE_ACCESS permission event
      fanotify: report file range info with pre-content events
      fanotify: allow to set errno in FAN_DENY permission response
      fs: don't block write during exec on pre-content watched files

Jan Kara (2):
      ext4: add pre-content fsnotify hook for DAX faults
      fanotify: Fix crash in fanotify_init(2)

Josef Bacik (7):
      fanotify: don't skip extra event info if no info_mode is set
      fanotify: disable readahead if we have pre-content watches
      mm: don't allow huge faults for files with pre content watches
      fsnotify: generate pre-content permission event on page fault
      xfs: add pre-content fsnotify hook for DAX faults
      btrfs: disable defrag on pre-content watched files
      fs: enable pre-content events on supported file systems

The diffstat is

 fs/binfmt_elf.c                    |   4 +-
 fs/binfmt_elf_fdpic.c              |   4 +-
 fs/btrfs/ioctl.c                   |   9 +++
 fs/btrfs/super.c                   |   2 +-
 fs/exec.c                          |   8 +-
 fs/ext4/file.c                     |   3 +
 fs/ext4/super.c                    |   3 +
 fs/fcntl.c                         |   4 +-
 fs/notify/fanotify/fanotify.c      |  31 ++++++--
 fs/notify/fanotify/fanotify.h      |  15 ++++
 fs/notify/fanotify/fanotify_user.c | 150 +++++++++++++++++++++++++++++--------
 fs/notify/fsnotify.c               |  83 +++++++++++++++++++-
 fs/open.c                          |  62 +++++++++++----
 fs/xfs/xfs_file.c                  |  13 ++++
 fs/xfs/xfs_super.c                 |   2 +-
 include/linux/fanotify.h           |  18 +++--
 include/linux/fs.h                 |  72 ++++++++++++++++--
 include/linux/fsnotify.h           |  78 ++++++++++++++-----
 include/linux/fsnotify_backend.h   |  53 ++++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/asm-generic/fcntl.h   |   1 -
 include/uapi/linux/fanotify.h      |  18 +++++
 kernel/fork.c                      |  12 +--
 mm/filemap.c                       |  86 +++++++++++++++++++++
 mm/memory.c                        |  19 +++++
 mm/nommu.c                         |   7 ++
 mm/readahead.c                     |  14 ++++
 security/selinux/hooks.c           |   3 +-
 28 files changed, 669 insertions(+), 106 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

