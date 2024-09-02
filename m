Return-Path: <linux-fsdevel+bounces-28246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB7B9687D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35C21C2034E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0E19C576;
	Mon,  2 Sep 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ctdpG5fr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PDJiSIQU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ctdpG5fr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PDJiSIQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622121DA5E;
	Mon,  2 Sep 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281222; cv=none; b=r/XBf0ORa8A0d9nUDoFi9Py2gJsRw8L8zt/ePqoy3hy5Kvdw2CbxgmLKA7/QFxQ0GsLunwr9F+mEUSKSmodcsn5/T5jk2eAcDf/OkUdyPaTuQ401Gc1TSqBsOTBMfgnOx3arzkxJUD3JFgnjvkwxg40xGrG6casnHjmbjiFTmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281222; c=relaxed/simple;
	bh=V+ctCPuZGEGZ/84g8DtS3E7QBTEzQ+hS55LnYQbLRa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAPUvitpJU94qyqfjobEdiw/j9Jj5nheGWG8fQJ1NV+AKqX+XliIIXCpY/RX1fpev4hioEZ2zW15YqtBWMBv3gic4t0ig2665bA/FYvOM0gHptz4hBdWD/ZzTAhe63UgCWcLpYIlGCdi41M7NP4EFu39MVdznNAJetknVo4LLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ctdpG5fr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PDJiSIQU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ctdpG5fr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PDJiSIQU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57A3A1FBAD;
	Mon,  2 Sep 2024 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725281218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFstIjDPTOs4v9AvZs81wQ2doD93L8DG1en8SaXJpDQ=;
	b=ctdpG5frht3svZQLPGw9AcMmighGktAHVPqpvKWDeEyermXyCwNktVYVbycO7409fK82Z1
	rc1w/79TFBlQui5haHQIJgB1hLhO/Xs4IvMwGkBLvO4OXpN+Et9AALumO3HzW/KOtAq6WI
	eup1EwyqkaIfHoBgio/OD6hLvH13WQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725281218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFstIjDPTOs4v9AvZs81wQ2doD93L8DG1en8SaXJpDQ=;
	b=PDJiSIQUoF5bRzAhK4un3VcajyhhYEEa+H65+8RqLtKFVJMni1CsJsP3xSXCweSk9/orUb
	5NSsDbt9VGnrojDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ctdpG5fr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PDJiSIQU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725281218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFstIjDPTOs4v9AvZs81wQ2doD93L8DG1en8SaXJpDQ=;
	b=ctdpG5frht3svZQLPGw9AcMmighGktAHVPqpvKWDeEyermXyCwNktVYVbycO7409fK82Z1
	rc1w/79TFBlQui5haHQIJgB1hLhO/Xs4IvMwGkBLvO4OXpN+Et9AALumO3HzW/KOtAq6WI
	eup1EwyqkaIfHoBgio/OD6hLvH13WQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725281218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFstIjDPTOs4v9AvZs81wQ2doD93L8DG1en8SaXJpDQ=;
	b=PDJiSIQUoF5bRzAhK4un3VcajyhhYEEa+H65+8RqLtKFVJMni1CsJsP3xSXCweSk9/orUb
	5NSsDbt9VGnrojDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3848313AE0;
	Mon,  2 Sep 2024 12:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +gK2DcKz1WZuFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 12:46:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5361A0965; Mon,  2 Sep 2024 14:46:42 +0200 (CEST)
Date: Mon, 2 Sep 2024 14:46:42 +0200
From: Jan Kara <jack@suse.cz>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/2] uapi: explain how per-syscall AT_* flags
 should be allocated
Message-ID: <20240902124642.rnd763njngu6qsg2@quack3>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240828-exportfs-u64-mount-id-v3-1-10c2c4c16708@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-exportfs-u64-mount-id-v3-1-10c2c4c16708@cyphar.com>
X-Rspamd-Queue-Id: 57A3A1FBAD
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,toxicpanda.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 28-08-24 20:19:42, Aleksa Sarai wrote:
> Unfortunately, the way we have gone about adding new AT_* flags has
> been a little messy. In the beginning, all of the AT_* flags had generic
> meanings and so it made sense to share the flag bits indiscriminately.
> However, we inevitably ran into syscalls that needed their own
> syscall-specific flags. Due to the lack of a planned out policy, we
> ended up with the following situations:
> 
>  * Existing syscalls adding new features tended to use new AT_* bits,
>    with some effort taken to try to re-use bits for flags that were so
>    obviously syscall specific that they only make sense for a single
>    syscall (such as the AT_EACCESS/AT_REMOVEDIR/AT_HANDLE_FID triplet).
> 
>    Given the constraints of bitflags, this works well in practice, but
>    ideally (to avoid future confusion) we would plan ahead and define a
>    set of "per-syscall bits" ahead of time so that when allocating new
>    bits we don't end up with a complete mish-mash of which bits are
>    supposed to be per-syscall and which aren't.
> 
>  * New syscalls dealt with this in several ways:
> 
>    - Some syscalls (like renameat2(2), move_mount(2), fsopen(2), and
>      fspick(2)) created their separate own flag spaces that have no
>      overlap with the AT_* flags. Most of these ended up allocating
>      their bits sequentually.
> 
>      In the case of move_mount(2) and fspick(2), several flags have
>      identical meanings to AT_* flags but were allocated in their own
>      flag space.
> 
>      This makes sense for syscalls that will never share AT_* flags, but
>      for some syscalls this leads to duplication with AT_* flags in a
>      way that could cause confusion (if renameat2(2) grew a
>      RENAME_EMPTY_PATH it seems likely that users could mistake it for
>      AT_EMPTY_PATH since it is an *at(2) syscall).
> 
>    - Some syscalls unfortunately ended up both creating their own flag
>      space while also using bits from other flag spaces. The most
>      obvious example is open_tree(2), where the standard usage ends up
>      using flags from *THREE* separate flag spaces:
> 
>        open_tree(AT_FDCWD, "/foo", OPEN_TREE_CLONE|O_CLOEXEC|AT_RECURSIVE);
> 
>      (Note that O_CLOEXEC is also platform-specific, so several future
>      OPEN_TREE_* bits are also made unusable in one fell swoop.)
> 
> It's not entirely clear to me what the "right" choice is for new
> syscalls. Just saying that all future VFS syscalls should use AT_* flags
> doesn't seem practical. openat2(2) has RESOLVE_* flags (many of which
> don't make much sense to burn generic AT_* flags for) and move_mount(2)
> has separate AT_*-like flags for both the source and target so separate
> flags are needed anyway (though it seems possible that renameat2(2)
> could grow *_EMPTY_PATH flags at some point, and it's a bit of a shame
> they can't be reused).
> 
> But at least for syscalls that _do_ choose to use AT_* flags, we should
> explicitly state the policy that 0x2ff is currently intended for
> per-syscall flags and that new flags should err on the side of
> overlapping with existing flag bits (so we can extend the scope of
> generic flags in the future if necessary).
> 
> And add AT_* aliases for the RENAME_* flags to further cement that
> renameat2(2) is an *at(2) flag, just with its own per-syscall flags.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/uapi/linux/fcntl.h                         | 80 ++++++++++++++-------
>  tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 83 +++++++++++++++-------
>  2 files changed, 115 insertions(+), 48 deletions(-)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index e55a3314bcb0..38a6d66d9e88 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -90,37 +90,69 @@
>  #define DN_ATTRIB	0x00000020	/* File changed attibutes */
>  #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
>  
> +#define AT_FDCWD		-100    /* Special value for dirfd used to
> +					   indicate openat should use the
> +					   current working directory. */
> +
> +
> +/* Generic flags for the *at(2) family of syscalls. */
> +
> +/* Reserved for per-syscall flags	0xff. */
> +#define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
> +						   links. */
> +/* Reserved for per-syscall flags	0x200 */
> +#define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
> +#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
> +						   traversal. */
> +#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
> +						   pathname to operate on dirfd
> +						   directly. */
>  /*
> - * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
> - * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
> - * unlinkat.  The two functions do completely different things and therefore,
> - * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
> - * faccessat would be undefined behavior and thus treating it equivalent to
> - * AT_EACCESS is valid undefined behavior.
> + * These flags are currently statx(2)-specific, but they could be made generic
> + * in the future and so they should not be used for other per-syscall flags.
>   */
> -#define AT_FDCWD		-100    /* Special value used to indicate
> -                                           openat should use the current
> -                                           working directory. */
> -#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
> +#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required from statx() */
> +#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
> +#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync'd with the server */
> +#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the server */
> +
> +#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
> +
> +/*
> + * Per-syscall flags for the *at(2) family of syscalls.
> + *
> + * These are flags that are so syscall-specific that a user passing these flags
> + * to the wrong syscall is so "clearly wrong" that we can safely call such
> + * usage "undefined behaviour".
> + *
> + * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same value.
> + * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is meaningful
> + * only to unlinkat. The two functions do completely different things and
> + * therefore, the flags can be allowed to overlap. For example, passing
> + * AT_REMOVEDIR to faccessat would be undefined behavior and thus treating it
> + * equivalent to AT_EACCESS is valid undefined behavior.
> + *
> + * Note for implementers: When picking a new per-syscall AT_* flag, try to
> + * reuse already existing flags first. This leaves us with as many unused bits
> + * as possible, so we can use them for generic bits in the future if necessary.
> + */
> +
> +/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +#define AT_RENAME_NOREPLACE	0x0001
> +#define AT_RENAME_EXCHANGE	0x0002
> +#define AT_RENAME_WHITEOUT	0x0004
> +
> +/* Flag for faccessat(2). */
>  #define AT_EACCESS		0x200	/* Test access permitted for
>                                             effective IDs, not real IDs.  */
> +/* Flag for unlinkat(2). */
>  #define AT_REMOVEDIR		0x200   /* Remove directory instead of
>                                             unlinking file.  */
> -#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
> -#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
> -#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
> -
> -#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required from statx() */
> -#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
> -#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
> -#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
> -
> -#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> +/* Flags for name_to_handle_at(2). */
> +#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
> +					   object identity and may not be
> +					   usable with open_by_handle_at(2). */
>  
> -/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
> -#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
> -					compare object identity and may not
> -					be usable to open_by_handle_at(2) */
>  #if defined(__KERNEL__)
>  #define AT_GETATTR_NOSEC	0x80000000
>  #endif
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> index c0bcc185fa48..38a6d66d9e88 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> @@ -16,6 +16,9 @@
>  
>  #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
>  
> +/* Was the file just created? */
> +#define F_CREATED_QUERY	(F_LINUX_SPECIFIC_BASE + 4)
> +
>  /*
>   * Cancel a blocking posix lock; internal use only until we expose an
>   * asynchronous lock api to userspace:
> @@ -87,37 +90,69 @@
>  #define DN_ATTRIB	0x00000020	/* File changed attibutes */
>  #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
>  
> +#define AT_FDCWD		-100    /* Special value for dirfd used to
> +					   indicate openat should use the
> +					   current working directory. */
> +
> +
> +/* Generic flags for the *at(2) family of syscalls. */
> +
> +/* Reserved for per-syscall flags	0xff. */
> +#define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
> +						   links. */
> +/* Reserved for per-syscall flags	0x200 */
> +#define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
> +#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
> +						   traversal. */
> +#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
> +						   pathname to operate on dirfd
> +						   directly. */
> +/*
> + * These flags are currently statx(2)-specific, but they could be made generic
> + * in the future and so they should not be used for other per-syscall flags.
> + */
> +#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required from statx() */
> +#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
> +#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync'd with the server */
> +#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the server */
> +
> +#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
> +
>  /*
> - * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
> - * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
> - * unlinkat.  The two functions do completely different things and therefore,
> - * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
> - * faccessat would be undefined behavior and thus treating it equivalent to
> - * AT_EACCESS is valid undefined behavior.
> + * Per-syscall flags for the *at(2) family of syscalls.
> + *
> + * These are flags that are so syscall-specific that a user passing these flags
> + * to the wrong syscall is so "clearly wrong" that we can safely call such
> + * usage "undefined behaviour".
> + *
> + * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same value.
> + * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is meaningful
> + * only to unlinkat. The two functions do completely different things and
> + * therefore, the flags can be allowed to overlap. For example, passing
> + * AT_REMOVEDIR to faccessat would be undefined behavior and thus treating it
> + * equivalent to AT_EACCESS is valid undefined behavior.
> + *
> + * Note for implementers: When picking a new per-syscall AT_* flag, try to
> + * reuse already existing flags first. This leaves us with as many unused bits
> + * as possible, so we can use them for generic bits in the future if necessary.
>   */
> -#define AT_FDCWD		-100    /* Special value used to indicate
> -                                           openat should use the current
> -                                           working directory. */
> -#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
> +
> +/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +#define AT_RENAME_NOREPLACE	0x0001
> +#define AT_RENAME_EXCHANGE	0x0002
> +#define AT_RENAME_WHITEOUT	0x0004
> +
> +/* Flag for faccessat(2). */
>  #define AT_EACCESS		0x200	/* Test access permitted for
>                                             effective IDs, not real IDs.  */
> +/* Flag for unlinkat(2). */
>  #define AT_REMOVEDIR		0x200   /* Remove directory instead of
>                                             unlinking file.  */
> -#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
> -#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
> -#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
> -
> -#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required from statx() */
> -#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
> -#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
> -#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
> -
> -#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> +/* Flags for name_to_handle_at(2). */
> +#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
> +					   object identity and may not be
> +					   usable with open_by_handle_at(2). */
>  
> -/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
> -#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
> -					compare object identity and may not
> -					be usable to open_by_handle_at(2) */
>  #if defined(__KERNEL__)
>  #define AT_GETATTR_NOSEC	0x80000000
>  #endif
> 
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

