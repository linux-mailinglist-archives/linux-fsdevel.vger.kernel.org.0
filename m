Return-Path: <linux-fsdevel+bounces-35416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FA9D4B96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F617280DBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9D1D1F4B;
	Thu, 21 Nov 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTQxoRUv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8uqnrCf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTQxoRUv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8uqnrCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE51D14E0;
	Thu, 21 Nov 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188148; cv=none; b=f+n0/cRcwsfnfFg4IjGyvlqRMHphstovcgR5FknTOsStl4YfGDBlUI3zvIgwBxvpke++UF3+Q9MtQI2Szm1QA09JrN1RdSt/2TPmbbzijGGtit2p4yhiCUS77SR/PPUxG3Mw1ao+MmSJTkesKgu5nLGpl2syX5EmMkX//Y4AApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188148; c=relaxed/simple;
	bh=qfsAqSoAVXT8cbgfyQnpu4JXwZAyDEx2uq1uS0F56mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EZVb7+45zMEbCENRusuoVgEgbHgJMmOisBp1njLlqWNJr4hwEK6B7o78UrlY6rJgi2khSyNT9v9LPhexrYFl/LqfzyXDaOdVuBCMUqP4j9Hh6wWpwMU64AN4lISnIWVh368IossL1/y6I4IYX5Vigx88pKsA5Q9wZioCC77DqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTQxoRUv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8uqnrCf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTQxoRUv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8uqnrCf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FEBC219F9;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o57/VEUA4QHkI70THHkI80+GxpRYr2skfkA5KFU5bt8=;
	b=qTQxoRUvFDyTE2sDDNsLl3929odtHNTBWyNItd+q6aEzAOFATP/LFEZc6HgxTLpxrHtl5P
	/uyEdr55J7M1AsAHdy75zO2ZLUxWfvkVxrIJ6lZMcJdk6jUyF4ljMU+xeKuL5zKnY5rCl6
	vVDVblGZx+g5jEidWDSQNIldmLH/7Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o57/VEUA4QHkI70THHkI80+GxpRYr2skfkA5KFU5bt8=;
	b=v8uqnrCfa9zmHD1g/PRiaUsTeGEV2CEabfkgs9oa9JW1IY/jYpIGbhYgpad4FpzEs1qsOs
	Hg8CT6gQC2qUHWCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o57/VEUA4QHkI70THHkI80+GxpRYr2skfkA5KFU5bt8=;
	b=qTQxoRUvFDyTE2sDDNsLl3929odtHNTBWyNItd+q6aEzAOFATP/LFEZc6HgxTLpxrHtl5P
	/uyEdr55J7M1AsAHdy75zO2ZLUxWfvkVxrIJ6lZMcJdk6jUyF4ljMU+xeKuL5zKnY5rCl6
	vVDVblGZx+g5jEidWDSQNIldmLH/7Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o57/VEUA4QHkI70THHkI80+GxpRYr2skfkA5KFU5bt8=;
	b=v8uqnrCfa9zmHD1g/PRiaUsTeGEV2CEabfkgs9oa9JW1IY/jYpIGbhYgpad4FpzEs1qsOs
	Hg8CT6gQC2qUHWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2834613A7D;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BKxxCfAXP2cXfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE14EA089E; Thu, 21 Nov 2024 12:22:23 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v9 00/19] fanotify: add pre-content hooks
Date: Thu, 21 Nov 2024 12:21:59 +0100
Message-Id: <20241121112218.8249-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,kernel.org,linux-foundation.org,ZenIV.linux.org.uk,vger.kernel.org,kvack.org,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

I'm posting here the series I'm currently carrying in my tree [1]. The changes
from v8 Josef posted are not huge but big enough that I think it's worth a
repost. Unless somebody speaks up, the plan is to merge into fsnotify branch
after the merge window closes.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/log/?h=fsnotify_hsm

v8:
https://lore.kernel.org/all/cover.1731684329.git.josef@toxicpanda.com
v7:
https://lore.kernel.org/linux-fsdevel/cover.1731433903.git.josef@toxicpanda.com/
v6:
https://lore.kernel.org/linux-fsdevel/cover.1731355931.git.josef@toxicpanda.com/
v5:
https://lore.kernel.org/linux-fsdevel/cover.1725481503.git.josef@toxicpanda.com/
v4:
https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxicpanda.com/
v3:
https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
v2:
https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
v1:
https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

v8->v9:
- fix DAX fault handling for ext4 & xfs
- rework FMODE_ constants a bit to keep FMODE_NONOTIFY a single bit
- move file_set_fsnotify_mode() out of line as it's quite big
- fold fsnotify_file_object_watched() into the single caller
- use explicit f_mode checks instead of fsnotify_file_has_pre_content_watches()
- fix compilation breakage with CONFIG_NOMMU
- fixed up some changelogs

v7->v8:
- A bunch of work from Amir to cleanup the fast path for the common case of no
  watches, which cascades through the rest of th series to update the helpers
  and the hooks to use the new helpers.
- A patch from Al to get rid of the __FMODE_NONOTIFY flag and cleanup the usage
  there, thanks Al!

v6->v7:
- As per Linus's suggestion, Amir added the file flag FMODE_NOTIFY_PERM that
  will be set at open time if the file has permission related watches (this is
  the original malware style permission watches and the new precontent watches).
  All of the VFS hooks and the page fault hooks use this flag to determine if
  they should generate a notification to allow for a much cheaper check in the
  common case.

v5->v6:
- Linus had problems with this and rejected Jan's PR
  (https://lore.kernel.org/linux-fsdevel/20240923110348.tbwihs42dxxltabc@quack3/
),
  so I'm respinning this series to address his concerns.  Hopefully this is more
  acceptable.
- Change the page fault hooks to happen only in the case where we have to add a
  page, not where there exists pages already.
- Amir added a hook to truncate.
- We made the flag per SB instead of per fstype, Amir wanted this because of
  some potential issues with other file system specific work he's doing.
- Dropped the bcachefs patch, there were some concerns that we were doing
  something wrong, and it's not a huge deal to not have this feature for now.
- Unfortunately the xfs write fault path still has to do the page fault hook
  before we know if we have a page or not, this is because of the locking that's
  done before we get to the part where we know if we have a page already or not,
  so that's the path that is still the same from last iteration.
- I've re-validated this series with btrfs, xfs, and ext4 to make sure I didn't
  break anything.

v4->v5:
- Cleaned up the various "I'll fix it on commit" notes that Jan made since I had
  to respin the series anyway.
- Renamed the filemap pagefault helper for fsnotify per Christians suggestion.
- Added a FS_ALLOW_HSM flag per Jan's comments, based on Amir's rough sketch.
- Added a patch to disable btrfs defrag on pre-content watched files.
- Added a patch to turn on FS_ALLOW_HSM for all the file systems that I tested.
- Added two fstests (which will be posted separately) to validate everything,
  re-validated the series with btrfs, xfs, ext4, and bcachefs to make sure I
  didn't break anything.

v3->v4:
- Trying to send a final verson Friday at 5pm before you go on vacation is a
  recipe for silly mistakes, fixed the xfs handling yet again, per Christoph's
  review.
- Reworked the file system helper so it's handling of fpin was a little less
  silly, per Chinner's suggestion.
- Updated the return values to not or in VM_FAULT_RETRY, as we have a comment
  in filemap_fault that says if VM_FAULT_ERROR is set we won't have
  VM_FAULT_RETRY set.

v2->v3:
- Fix the pagefault path to do MAY_ACCESS instead, updated the perm handler to
  emit PRE_ACCESS in this case, so we can avoid the extraneous perm event as per
  Amir's suggestion.
- Reworked the exported helper so the per-filesystem changes are much smaller,
  per Amir's suggestion.
- Fixed the screwup for DAX writes per Chinner's suggestion.
- Added Christian's reviewed-by's where appropriate.

v1->v2:
- reworked the page fault logic based on Jan's suggestion and turned it into a
  helper.
- Added 3 patches per-fs where we need to call the fsnotify helper from their
  ->fault handlers.
- Disabled readahead in the case that there's a pre-content watch in place.
- Disabled huge faults when there's a pre-content watch in place (entirely
  because it's untested, theoretically it should be straightforward to do).
- Updated the command numbers.
- Addressed the random spelling/grammer mistakes that Jan pointed out.
- Addressed the other random nits from Jan.

--- Original email ---

Hello,

These are the patches for the bare bones pre-content fanotify support.  The
majority of this work is Amir's, my contribution to this has solely been around
adding the page fault hooks, testing and validating everything.  I'm sending it
because Amir is traveling a bunch, and I touched it last so I'm going to take
all the hate and he can take all the credit.

There is a PoC that I've been using to validate this work, you can find the git
repo here

https://github.com/josefbacik/remote-fetch

This consists of 3 different tools.

1. populate.  This just creates all the stub files in the directory from the
   source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
   recursively create all of the stub files and directories.
2. remote-fetch.  This is the actual PoC, you just point it at the source and
   destination directory and then you can do whatever.  ./remote-fetch ~/linux
   ~/hsm-linux.
3. mmap-validate.  This was to validate the pagefault thing, this is likely what
   will be turned into the selftest with remote-fetch.  It creates a file and
   then you can validate the file matches the right pattern with both normal
   reads and mmap.  Normally I do something like

   ./mmap-validate create ~/src/foo
   ./populate ~/src ~/dst
   ./rmeote-fetch ~/src ~/dst
   ./mmap-validate validate ~/dst/foo

I did a bunch of testing, I also got some performance numbers.  I copied a
kernel tree, and then did remote-fetch, and then make -j4

Normal
real    9m49.709s
user    28m11.372s
sys     4m57.304s

HSM
real    10m6.454s
user    29m10.517s
sys     5m2.617s

So ~17 seconds more to build with HSM.  I then did a make mrproper on both trees
to see the size

[root@fedora ~]# du -hs /src/linux
1.6G    /src/linux
[root@fedora ~]# du -hs dst
125M    dst

This mirrors the sort of savings we've seen in production.

Meta has had these patches (minus the page fault patch) deployed in production
for almost a year with our own utility for doing on-demand package fetching.
The savings from this has been pretty significant.

The page-fault hooks are necessary for the last thing we need, which is
on-demand range fetching of executables.  Some of our binaries are several gigs
large, having the ability to remote fetch them on demand is a huge win for us
not only with space savings, but with startup time of containers.

There will be tests for this going into LTP once we're satisfied with the
patches and they're on their way upstream.  Thanks,

Josef

Al Viro (1):
      fs: get rid of __FMODE_NONOTIFY kludge

Amir Goldstein (11):
      fsnotify: opt-in for permission events at file open time
      fsnotify: check if file is actually being watched for pre-content events on open
      fanotify: don't skip extra event info if no info_mode is set
      fanotify: rename a misnamed constant
      fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
      fsnotify: introduce pre-content permission events
      fsnotify: pass optional file access range in pre-content event
      fsnotify: generate pre-content permission event on truncate
      fanotify: introduce FAN_PRE_ACCESS permission event
      fanotify: report file range info with pre-content events
      fanotify: allow to set errno in FAN_DENY permission response

Jan Kara (1):
      ext4: add pre-content fsnotify hook for DAX faults

Josef Bacik (6):
      fanotify: disable readahead if we have pre-content watches
      mm: don't allow huge faults for files with pre content watches
      fsnotify: generate pre-content permission event on page fault
      xfs: add pre-content fsnotify hook for DAX faults
      btrfs: disable defrag on pre-content watched files
      fs: enable pre-content events on supported file systems

 fs/btrfs/ioctl.c                   |   9 +++
 fs/btrfs/super.c                   |   2 +-
 fs/ext4/file.c                     |   3 +
 fs/ext4/super.c                    |   3 +
 fs/fcntl.c                         |   4 +-
 fs/notify/fanotify/fanotify.c      |  31 +++++++--
 fs/notify/fanotify/fanotify.h      |  15 ++++
 fs/notify/fanotify/fanotify_user.c | 137 +++++++++++++++++++++++++++++--------
 fs/notify/fsnotify.c               |  83 +++++++++++++++++++++-
 fs/open.c                          |  62 +++++++++++++----
 fs/xfs/xfs_file.c                  |  14 ++++
 fs/xfs/xfs_super.c                 |   2 +-
 include/linux/fanotify.h           |  18 +++--
 include/linux/fs.h                 |  44 +++++++++---
 include/linux/fsnotify.h           |  78 ++++++++++++++++-----
 include/linux/fsnotify_backend.h   |  53 +++++++++++++-
 include/linux/mm.h                 |   1 +
 include/uapi/asm-generic/fcntl.h   |   1 -
 include/uapi/linux/fanotify.h      |  18 +++++
 mm/filemap.c                       |  90 ++++++++++++++++++++++++
 mm/memory.c                        |  22 ++++++
 mm/nommu.c                         |   7 ++
 mm/readahead.c                     |  14 ++++
 security/selinux/hooks.c           |   3 +-
 24 files changed, 624 insertions(+), 90 deletions(-)

