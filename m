Return-Path: <linux-fsdevel+bounces-28722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E16C996D7E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0695B21FC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B36019ABAE;
	Thu,  5 Sep 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZUBIhauk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DjnIceNR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZUBIhauk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DjnIceNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06659199FB4;
	Thu,  5 Sep 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538100; cv=none; b=DynmsdZyqE8JoqKVIQYpGjasCRzi4jJI9o3c0w57NwYcL8bSlt1DUsfrS2NP+/3RvLJtZxAuWNZVjWu3qw6y58ja+xwoo7u9+YT4edeZICqXwKDAfHNKuGawaVTaD7rJRe9i0RQiM2B5ElAtJ+Peubkt84m2OboiIGc/2oDd59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538100; c=relaxed/simple;
	bh=pnup+PjNdWYL01f6Vj8DyxDxFFGWiNQX79oCLmQV2cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WALUXvsADid7f3LOT1CkN6+0yRm8uSi3OZXy4lYcrcBDYY9AQ/BrkZikgHnIMMWodj3bFCZJI9xdDbaKOFwn1AgF3i3zWYiziUTx82kt/wTih02H9LGytWno5HW45kXLc7VifCKc+7C6f9Ff8KMXoGVzwIZM2MyJiI/LfV968sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZUBIhauk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DjnIceNR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZUBIhauk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DjnIceNR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2205421A81;
	Thu,  5 Sep 2024 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725538097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WJ4nFRla3E237+ALZbePBMCha1Jx0LA7680EWIZ9qA=;
	b=ZUBIhauk9pLBn+4LtJzsocMf/RdTLy24lmCpQqShpi8SbBM/cNVVG2D4BUnJnHTyV6NuNo
	Xc2FU8Q2CA8TL4E1kWdxYz6g86k7fiDmM9MnDHAA8X4fbZEMqEKBvEbKCqLvnxXIgWWB5l
	0KzppmFnuC1nIEfCnB5bP/djulDphLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725538097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WJ4nFRla3E237+ALZbePBMCha1Jx0LA7680EWIZ9qA=;
	b=DjnIceNRdWP15oYi6DsfMSICUce41R5WBJZXVfFmhDi3YmzSQR+qRyG0QJhu7wLGzfRbqi
	Lwpq7LY9iCpx6KDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725538097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WJ4nFRla3E237+ALZbePBMCha1Jx0LA7680EWIZ9qA=;
	b=ZUBIhauk9pLBn+4LtJzsocMf/RdTLy24lmCpQqShpi8SbBM/cNVVG2D4BUnJnHTyV6NuNo
	Xc2FU8Q2CA8TL4E1kWdxYz6g86k7fiDmM9MnDHAA8X4fbZEMqEKBvEbKCqLvnxXIgWWB5l
	0KzppmFnuC1nIEfCnB5bP/djulDphLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725538097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WJ4nFRla3E237+ALZbePBMCha1Jx0LA7680EWIZ9qA=;
	b=DjnIceNRdWP15oYi6DsfMSICUce41R5WBJZXVfFmhDi3YmzSQR+qRyG0QJhu7wLGzfRbqi
	Lwpq7LY9iCpx6KDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1653613419;
	Thu,  5 Sep 2024 12:08:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dP5sBTGf2WbLawAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 12:08:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2A12A0968; Thu,  5 Sep 2024 14:08:08 +0200 (CEST)
Date: Thu, 5 Sep 2024 14:08:08 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 00/18] fanotify: add pre-content hooks
Message-ID: <20240905120808.7fcsnv7nslqsq4t6@quack3>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Wed 04-09-24 16:27:50, Josef Bacik wrote:
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

The test tool seems to be a bit outdated wrt the current series. It took me
quite a while to debug why HSM isn't working with it (eventually I've
tracked it down to the changes in struct fanotify_event_info_range...).
Anyway all seems to be working (after fixing up some missing export), I've
pushed out the result I have to:

https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify

and will push it to linux-next as well so that it gets some soaking before
the merge window. That being said I'd still like to get explicit ack from
XFS folks (hint) so don't patches may still rebase due to that.

								Honza

 
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
> Amir Goldstein (8):
>   fsnotify: introduce pre-content permission event
>   fsnotify: generate pre-content permission event on open
>   fanotify: introduce FAN_PRE_ACCESS permission event
>   fanotify: introduce FAN_PRE_MODIFY permission event
>   fanotify: pass optional file access range in pre-content event
>   fanotify: rename a misnamed constant
>   fanotify: report file range info with pre-content events
>   fanotify: allow to set errno in FAN_DENY permission response
> 
> Josef Bacik (10):
>   fanotify: don't skip extra event info if no info_mode is set
>   fs: add a flag to indicate the fs supports pre-content events
>   fanotify: add a helper to check for pre content events
>   fanotify: disable readahead if we have pre-content watches
>   mm: don't allow huge faults for files with pre content watches
>   fsnotify: generate pre-content permission event on page fault
>   bcachefs: add pre-content fsnotify hook to fault
>   xfs: add pre-content fsnotify hook for write faults
>   btrfs: disable defrag on pre-content watched files
>   fs: enable pre-content events on supported file systems
> 
>  fs/bcachefs/fs-io-pagecache.c      |   4 +
>  fs/bcachefs/fs.c                   |   2 +-
>  fs/btrfs/ioctl.c                   |   9 ++
>  fs/btrfs/super.c                   |   3 +-
>  fs/ext4/super.c                    |   6 +-
>  fs/namei.c                         |   9 ++
>  fs/notify/fanotify/fanotify.c      |  33 ++++++--
>  fs/notify/fanotify/fanotify.h      |  15 ++++
>  fs/notify/fanotify/fanotify_user.c | 119 ++++++++++++++++++++++-----
>  fs/notify/fsnotify.c               |  17 +++-
>  fs/xfs/xfs_file.c                  |   4 +
>  fs/xfs/xfs_super.c                 |   2 +-
>  include/linux/fanotify.h           |  20 +++--
>  include/linux/fs.h                 |   1 +
>  include/linux/fsnotify.h           |  58 +++++++++++--
>  include/linux/fsnotify_backend.h   |  59 ++++++++++++-
>  include/linux/mm.h                 |   1 +
>  include/uapi/linux/fanotify.h      |  18 ++++
>  mm/filemap.c                       | 128 +++++++++++++++++++++++++++--
>  mm/memory.c                        |  22 +++++
>  mm/readahead.c                     |  13 +++
>  security/selinux/hooks.c           |   3 +-
>  22 files changed, 489 insertions(+), 57 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

