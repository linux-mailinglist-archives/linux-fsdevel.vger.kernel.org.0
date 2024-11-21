Return-Path: <linux-fsdevel+bounces-35432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEFF9D4BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7325B21966
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51D1D357B;
	Thu, 21 Nov 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="akqOuB90";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WeOK63SA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NxDLZ+rD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6i3YK0G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBF1D12F9;
	Thu, 21 Nov 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188604; cv=none; b=QcyiIXjDSl999RCXDZXzkF2Ippf9SFWDOSmfUBeCLDHbFdSw2/a+UDw2u4o1NJdilM5EKRSC+VCGSPg0nmOzUvx6N3hPkN0Pgh8+PDkBOu/01LRdnNqGryBEXaMPegohmdnWZhx4P+zVqzzVsncQa8lcrqgG53jREp5rsiLk41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188604; c=relaxed/simple;
	bh=BzVXMuN6LaYdhYroHWUULgviZzb1IQ7+7a98tflsNTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAjpQQk0Ug3SlG/3f0/md42L9rrLol8yj2Vc4cEeac12d/kZtwfpYXkKDl+du+ogETreyCIeT20jJbh5xkLvTPY8MUM6hekmUtwdgzCZSs9WG3gdbKLzS9S+L7Hb58GA9NhDg7T8jkojIklNp5i5kNnPp73rCBzACHy3nqvbFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=akqOuB90; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WeOK63SA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NxDLZ+rD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X6i3YK0G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C777221A01;
	Thu, 21 Nov 2024 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGjTsk5CR/YHeMOkWFIWPZUtLOX5dPduTKE5Kp6QQG0=;
	b=akqOuB90AloRXKLMoUlWuHHQ2FIks/vwIKF+xb1zyGwthcz5M37qLQXh7I85bDKAYLTX4g
	payB/e5PHgZQj3cMnqHn6/qz3+cAc3qsiGG6hRwCPEj/BvZBNxxCd8BKyHetcsP5yeatdL
	YCV0LJN0h4QLU+UumetKsL5t2U3s0cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGjTsk5CR/YHeMOkWFIWPZUtLOX5dPduTKE5Kp6QQG0=;
	b=WeOK63SABhtlFGfs3d/ePKHeuuVGMaPyivRlf8aMxPLKtTBmhVbhGm5uF3pyllUqkJ5gN1
	BptCcr+SF8Yz2dDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGjTsk5CR/YHeMOkWFIWPZUtLOX5dPduTKE5Kp6QQG0=;
	b=NxDLZ+rDTKTPtggla/Fq2CsXjIg9892Al8b1+8WT7KoJ+aXgdFdjzsKtOViml6j0hCYGQL
	XAKXx88gXhtvy0wG53VotVdNyA8aTejPyoAgKZXiWihQvE7+n1hZnAAj6h3D2eJFQlH3cB
	kC02fACWRJyDz+HBcyof6Njz26wPNew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGjTsk5CR/YHeMOkWFIWPZUtLOX5dPduTKE5Kp6QQG0=;
	b=X6i3YK0G4M3fUWmmna+jTKibjEtFWD787oFakdvCzg+SYsdyo4f4DHy7E7hyrbaHHNJaMn
	Ab7TKK2VYVKNqnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B818D13A7D;
	Thu, 21 Nov 2024 11:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a6nsLLgZP2cKAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:30:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6AAD6A089E; Thu, 21 Nov 2024 12:29:56 +0100 (CET)
Date: Thu, 21 Nov 2024 12:29:56 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 00/19] fanotify: add pre-content hooks
Message-ID: <20241121112956.c5w6fnnf7cztkzb4@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,fedora:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 15-11-24 10:30:13, Josef Bacik wrote:
> v7: https://lore.kernel.org/linux-fsdevel/cover.1731433903.git.josef@toxicpanda.com/
> v6: https://lore.kernel.org/linux-fsdevel/cover.1731355931.git.josef@toxicpanda.com/
> v5: https://lore.kernel.org/linux-fsdevel/cover.1725481503.git.josef@toxicpanda.com/
> v4: https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxicpanda.com/
> v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
> v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
> v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

OK, I have merged the series with all the changes I've suggested into a topic
branch in my tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/log/?h=fsnotify_hsm

I've also added there a patch making sure HSM events are properly generated
on ext4 with DAX. There's one open question I still have whether we
shouldn't completely refuse pre-content events on directories but besides
that I'm now happy with the series.

The branch passes LTP tests so we hopefully didn't break some existing
functionality but it would be great to run it through the tests Josef has.
Josef, can you please do that?

After the merge window closes and if the tests pass, I plan to merge the
topic branch into fsnotify branch so that we get some exposure in
linux-next.

								Honza

> v7->v8:
> - A bunch of work from Amir to cleanup the fast path for the common case of no
>   watches, which cascades through the rest of th series to update the helpers
>   and the hooks to use the new helpers.
> - A patch from Al to get rid of the __FMODE_NONOTIFY flag and cleanup the usage
>   there, thanks Al!
> 
> v6->v7:
> - As per Linus's suggestion, Amir added the file flag FMODE_NOTIFY_PERM that
>   will be set at open time if the file has permission related watches (this is
>   the original malware style permission watches and the new precontent watches).
>   All of the VFS hooks and the page fault hooks use this flag to determine if
>   they should generate a notification to allow for a much cheaper check in the
>   common case.
> 
> v5->v6:
> - Linus had problems with this and rejected Jan's PR
>   (https://lore.kernel.org/linux-fsdevel/20240923110348.tbwihs42dxxltabc@quack3/),
>   so I'm respinning this series to address his concerns.  Hopefully this is more
>   acceptable.
> - Change the page fault hooks to happen only in the case where we have to add a
>   page, not where there exists pages already.
> - Amir added a hook to truncate.
> - We made the flag per SB instead of per fstype, Amir wanted this because of
>   some potential issues with other file system specific work he's doing.
> - Dropped the bcachefs patch, there were some concerns that we were doing
>   something wrong, and it's not a huge deal to not have this feature for now.
> - Unfortunately the xfs write fault path still has to do the page fault hook
>   before we know if we have a page or not, this is because of the locking that's
>   done before we get to the part where we know if we have a page already or not,
>   so that's the path that is still the same from last iteration.
> - I've re-validated this series with btrfs, xfs, and ext4 to make sure I didn't
>   break anything.
> 
> v4->v5:
> - Cleaned up the various "I'll fix it on commit" notes that Jan made since I had
>   to respin the series anyway.
> - Renamed the filemap pagefault helper for fsnotify per Christians suggestion.
> - Added a FS_ALLOW_HSM flag per Jan's comments, based on Amir's rough sketch.
> - Added a patch to disable btrfs defrag on pre-content watched files.
> - Added a patch to turn on FS_ALLOW_HSM for all the file systems that I tested.
> - Added two fstests (which will be posted separately) to validate everything,
>   re-validated the series with btrfs, xfs, ext4, and bcachefs to make sure I
>   didn't break anything.
> 
> v3->v4:
> - Trying to send a final verson Friday at 5pm before you go on vacation is a
>   recipe for silly mistakes, fixed the xfs handling yet again, per Christoph's
>   review.
> - Reworked the file system helper so it's handling of fpin was a little less
>   silly, per Chinner's suggestion.
> - Updated the return values to not or in VM_FAULT_RETRY, as we have a comment
>   in filemap_fault that says if VM_FAULT_ERROR is set we won't have
>   VM_FAULT_RETRY set.
> 
> v2->v3:
> - Fix the pagefault path to do MAY_ACCESS instead, updated the perm handler to
>   emit PRE_ACCESS in this case, so we can avoid the extraneous perm event as per
>   Amir's suggestion.
> - Reworked the exported helper so the per-filesystem changes are much smaller,
>   per Amir's suggestion.
> - Fixed the screwup for DAX writes per Chinner's suggestion.
> - Added Christian's reviewed-by's where appropriate.
> 
> v1->v2:
> - reworked the page fault logic based on Jan's suggestion and turned it into a
>   helper.
> - Added 3 patches per-fs where we need to call the fsnotify helper from their
>   ->fault handlers.
> - Disabled readahead in the case that there's a pre-content watch in place.
> - Disabled huge faults when there's a pre-content watch in place (entirely
>   because it's untested, theoretically it should be straightforward to do).
> - Updated the command numbers.
> - Addressed the random spelling/grammer mistakes that Jan pointed out.
> - Addressed the other random nits from Jan.
> 
> --- Original email ---
> 
> Hello,
> 
> These are the patches for the bare bones pre-content fanotify support.  The
> majority of this work is Amir's, my contribution to this has solely been around
> adding the page fault hooks, testing and validating everything.  I'm sending it
> because Amir is traveling a bunch, and I touched it last so I'm going to take
> all the hate and he can take all the credit.
> 
> There is a PoC that I've been using to validate this work, you can find the git
> repo here
> 
> https://github.com/josefbacik/remote-fetch
> 
> This consists of 3 different tools.
> 
> 1. populate.  This just creates all the stub files in the directory from the
>    source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
>    recursively create all of the stub files and directories.
> 2. remote-fetch.  This is the actual PoC, you just point it at the source and
>    destination directory and then you can do whatever.  ./remote-fetch ~/linux
>    ~/hsm-linux.
> 3. mmap-validate.  This was to validate the pagefault thing, this is likely what
>    will be turned into the selftest with remote-fetch.  It creates a file and
>    then you can validate the file matches the right pattern with both normal
>    reads and mmap.  Normally I do something like
> 
>    ./mmap-validate create ~/src/foo
>    ./populate ~/src ~/dst
>    ./rmeote-fetch ~/src ~/dst
>    ./mmap-validate validate ~/dst/foo
> 
> I did a bunch of testing, I also got some performance numbers.  I copied a
> kernel tree, and then did remote-fetch, and then make -j4
> 
> Normal
> real    9m49.709s
> user    28m11.372s
> sys     4m57.304s
> 
> HSM
> real    10m6.454s
> user    29m10.517s
> sys     5m2.617s
> 
> So ~17 seconds more to build with HSM.  I then did a make mrproper on both trees
> to see the size
> 
> [root@fedora ~]# du -hs /src/linux
> 1.6G    /src/linux
> [root@fedora ~]# du -hs dst
> 125M    dst
> 
> This mirrors the sort of savings we've seen in production.
> 
> Meta has had these patches (minus the page fault patch) deployed in production
> for almost a year with our own utility for doing on-demand package fetching.
> The savings from this has been pretty significant.
> 
> The page-fault hooks are necessary for the last thing we need, which is
> on-demand range fetching of executables.  Some of our binaries are several gigs
> large, having the ability to remote fetch them on demand is a huge win for us
> not only with space savings, but with startup time of containers.
> 
> There will be tests for this going into LTP once we're satisfied with the
> patches and they're on their way upstream.  Thanks,
> 
> Josef
> 
> Al Viro (1):
>   fs: get rid of __FMODE_NONOTIFY kludge
> 
> Amir Goldstein (12):
>   fsnotify: opt-in for permission events at file open time
>   fsnotify: add helper to check if file is actually being watched
>   fanotify: don't skip extra event info if no info_mode is set
>   fanotify: rename a misnamed constant
>   fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
>   fsnotify: introduce pre-content permission events
>   fsnotify: pass optional file access range in pre-content event
>   fsnotify: generate pre-content permission event on truncate
>   fanotify: introduce FAN_PRE_ACCESS permission event
>   fanotify: report file range info with pre-content events
>   fanotify: allow to set errno in FAN_DENY permission response
>   fanotify: add a helper to check for pre content events
> 
> Josef Bacik (6):
>   fanotify: disable readahead if we have pre-content watches
>   mm: don't allow huge faults for files with pre content watches
>   fsnotify: generate pre-content permission event on page fault
>   xfs: add pre-content fsnotify hook for write faults
>   btrfs: disable defrag on pre-content watched files
>   fs: enable pre-content events on supported file systems
> 
>  fs/btrfs/ioctl.c                   |   9 ++
>  fs/btrfs/super.c                   |   2 +-
>  fs/ext4/super.c                    |   3 +
>  fs/fcntl.c                         |   4 +-
>  fs/notify/fanotify/fanotify.c      |  33 +++++--
>  fs/notify/fanotify/fanotify.h      |  15 +++
>  fs/notify/fanotify/fanotify_user.c | 145 +++++++++++++++++++++++------
>  fs/notify/fsnotify.c               |  56 +++++++++--
>  fs/open.c                          |  62 +++++++++---
>  fs/xfs/xfs_file.c                  |   4 +
>  fs/xfs/xfs_super.c                 |   2 +-
>  include/linux/fanotify.h           |  19 +++-
>  include/linux/fs.h                 |  42 +++++++--
>  include/linux/fsnotify.h           | 135 +++++++++++++++++++++++----
>  include/linux/fsnotify_backend.h   |  60 +++++++++++-
>  include/linux/mm.h                 |   1 +
>  include/uapi/asm-generic/fcntl.h   |   1 -
>  include/uapi/linux/fanotify.h      |  18 ++++
>  mm/filemap.c                       |  90 ++++++++++++++++++
>  mm/memory.c                        |  22 +++++
>  mm/readahead.c                     |  13 +++
>  security/selinux/hooks.c           |   3 +-
>  22 files changed, 639 insertions(+), 100 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

