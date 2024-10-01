Return-Path: <linux-fsdevel+bounces-30499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FAE98BD58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AA0B23B80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D31C3F1C;
	Tue,  1 Oct 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIV3S/+L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+R3f1HAg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIV3S/+L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+R3f1HAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4536C;
	Tue,  1 Oct 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788836; cv=none; b=YHVqL096iATi16J2kOOWKVVViooq8jm0IB05nl05cnsML7VG+zDw5wFDBm4PCCIlWIYX9hc9+pB2NEsFD3zMY3OcEBXcg4p1CQ5SqsKyGV+c0hqsoZQNklx7NzP9hJXkMMbBQlyTQj0RNVXEP/dZ/+L0s9K7el1dRoRDtOT4IyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788836; c=relaxed/simple;
	bh=1ubil/7TxmeZD5hymJFMuAWIci6zBIUbEPBzgacDiNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpxZWFmMFlBUPOuUuCaZAbnkx49NsiB441ujLBcren1BUS6lUriaA4gwHX/ZODyOXaKolki/EG93DY9OGiYxdZd12CJAKx1zV/ZKgzJNUHZsWGsVlueB8Noc8/SXHY6Pq7hZfDGHlO+Tv7UMaudtVaN/3yMuUd2B4O656BWsT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIV3S/+L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+R3f1HAg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIV3S/+L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+R3f1HAg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3787F1FCD5;
	Tue,  1 Oct 2024 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727788832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHUTx26u1Zm7t+hO3jWr5zq9TUpeNIsYN8Z7Hb7OSs=;
	b=xIV3S/+LwfzEYtIDCydLw+Wy/yUwjtVxzZA6yTqRJceVGe3a43oyQm+LI7e5nkwu7721zB
	Eh8Is2beSc0kbmu2HypHxSXVgPjHFxBjDdr/RZ7tx/6ZD9438fer6uSed9f/6nUsdU0fpO
	RHOAL+cGiPEToGudOqEooTTnVclvQF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727788832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHUTx26u1Zm7t+hO3jWr5zq9TUpeNIsYN8Z7Hb7OSs=;
	b=+R3f1HAgINp9IR2Q8zdasbBUQ60FRy2PlwzItyuOYH6S9jY3OkdWlF3glpvyRr7v5QI3w/
	UEppUOtDZEVJrwDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xIV3S/+L";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+R3f1HAg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727788832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHUTx26u1Zm7t+hO3jWr5zq9TUpeNIsYN8Z7Hb7OSs=;
	b=xIV3S/+LwfzEYtIDCydLw+Wy/yUwjtVxzZA6yTqRJceVGe3a43oyQm+LI7e5nkwu7721zB
	Eh8Is2beSc0kbmu2HypHxSXVgPjHFxBjDdr/RZ7tx/6ZD9438fer6uSed9f/6nUsdU0fpO
	RHOAL+cGiPEToGudOqEooTTnVclvQF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727788832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTHUTx26u1Zm7t+hO3jWr5zq9TUpeNIsYN8Z7Hb7OSs=;
	b=+R3f1HAgINp9IR2Q8zdasbBUQ60FRy2PlwzItyuOYH6S9jY3OkdWlF3glpvyRr7v5QI3w/
	UEppUOtDZEVJrwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C73713A73;
	Tue,  1 Oct 2024 13:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0wjrBiD3+2a4CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Oct 2024 13:20:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0DA2A0881; Tue,  1 Oct 2024 15:20:27 +0200 (CEST)
Date: Tue, 1 Oct 2024 15:20:27 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 02/12] fs: add infrastructure for multigrain timestamps
Message-ID: <20241001132027.ynzp4sahjek5umbb@quack3>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
 <20241001-mgtime-v8-2-903343d91bc3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-mgtime-v8-2-903343d91bc3@kernel.org>
X-Rspamd-Queue-Id: 3787F1FCD5
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	R_RATELIMIT(0.00)[to_ip_from(RLswiucb9kpekg6cnj18gdugi4)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 01-10-24 06:58:56, Jeff Layton wrote:
> The VFS has always used coarse-grained timestamps when updating the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metadata updates, down to around 1
> per jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. A lot of changes
> can happen in a jiffy, so timestamps aren't sufficient to help the
> client decide when to invalidate the cache. Even with NFSv4, a lot of
> exported filesystems don't properly support a change attribute and are
> subject to the same problems with timestamp granularity. Other
> applications have similar issues with timestamps (e.g backup
> applications).
> 
> If we were to always use fine-grained timestamps, that would improve the
> situation, but that becomes rather expensive, as the underlying
> filesystem would have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried. Use the (unused) top bit in inode->i_ctime_nsec
> as a flag that indicates whether the current timestamps have been
> queried via stat() or the like. When it's set, we allow the kernel to
> use a fine-grained timestamp iff it's necessary to make the ctime show
> a different value.
> 
> This solves the problem of being able to distinguish the timestamp
> between updates, but introduces a new problem: it's now possible for a
> file being changed to get a fine-grained timestamp. A file that is
> altered just a bit later can then get a coarse-grained one that appears
> older than the earlier fine-grained time. This violates timestamp
> ordering guarantees.
> 
> To remedy this, keep a global monotonic atomic64_t value that acts as a
> timestamp floor.  When we go to stamp a file, we first get the latter of
> the current floor value and the current coarse-grained time. If the
> inode ctime hasn't been queried then we just attempt to stamp it with
> that value.
> 
> If it has been queried, then first see whether the current coarse time
> is later than the existing ctime. If it is, then we accept that value.
> If it isn't, then we get a fine-grained timestamp.
> 
> Filesystems can opt into this by setting the FS_MGTIME fstype flag.
> Others should be unaffected (other than being subject to the same floor
> value as multigrain filesystems).
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Mostly looks good. Some smaller comments below.

> +/**
> + * current_time - Return FS time (possibly fine-grained)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
> + * as having been QUERIED, get a fine-grained timestamp, but don't update
> + * the floor.
> + *
> + * For a multigrain inode, this is effectively an estimate of the timestamp
> + * that a file would receive. An actual update must go through
> + * inode_set_ctime_current().
> + */
> +struct timespec64 current_time(struct inode *inode)
> +{
> +	struct timespec64 now;
> +	u32 cns;
> +
> +	ktime_get_coarse_real_ts64_mg(&now);
> +
> +	if (!is_mgtime(inode))
> +		goto out;
> +
> +	/* If nothing has queried it, then coarse time is fine */
> +	cns = smp_load_acquire(&inode->i_ctime_nsec);
> +	if (cns & I_CTIME_QUERIED) {
> +		/*
> +		 * If there is no apparent change, then get a fine-grained
> +		 * timestamp.
> +		 */
> +		if (now.tv_nsec == (cns & ~I_CTIME_QUERIED))
> +			ktime_get_real_ts64(&now);
> +	}
> +out:
> +	return timestamp_truncate(now, inode);
> +}
> +EXPORT_SYMBOL(current_time);
> +
>  static int inode_needs_update_time(struct inode *inode)
>  {
> +	struct timespec64 now, ts;
>  	int sync_it = 0;
> -	struct timespec64 now = current_time(inode);
> -	struct timespec64 ts;
>  
>  	/* First try to exhaust all avenues to not sync */
>  	if (IS_NOCMTIME(inode))
>  		return 0;
>  
> +	now = current_time(inode);
> +
>  	ts = inode_get_mtime(inode);
>  	if (!timespec64_equal(&ts, &now))
> -		sync_it = S_MTIME;
> +		sync_it |= S_MTIME;
>  
>  	ts = inode_get_ctime(inode);
>  	if (!timespec64_equal(&ts, &now))
> @@ -2598,6 +2637,15 @@ void inode_nohighmem(struct inode *inode)
>  }
>  EXPORT_SYMBOL(inode_nohighmem);
>  
> +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
> +{
> +	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
> +	inode->i_ctime_sec = ts.tv_sec;
> +	inode->i_ctime_nsec = ts.tv_nsec;
> +	return ts;
> +}
> +EXPORT_SYMBOL(inode_set_ctime_to_ts);
> +
>  /**
>   * timestamp_truncate - Truncate timespec to a granularity
>   * @t: Timespec
> @@ -2630,36 +2678,75 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
>  EXPORT_SYMBOL(timestamp_truncate);
>  
>  /**
> - * current_time - Return FS time
> - * @inode: inode.
> + * inode_set_ctime_current - set the ctime to current_time
> + * @inode: inode
>   *
> - * Return the current time truncated to the time granularity supported by
> - * the fs.
> + * Set the inode's ctime to the current value for the inode. Returns the
> + * current value that was assigned. If this is not a multigrain inode, then we
> + * set it to the later of the coarse time and floor value.
>   *
> - * Note that inode and inode->sb cannot be NULL.
> - * Otherwise, the function warns and returns time without truncation.
> + * If it is multigrain, then we first see if the coarse-grained timestamp is
> + * distinct from what we have. If so, then we'll just use that. If we have to
> + * get a fine-grained timestamp, then do so, and try to swap it into the floor.
> + * We accept the new floor value regardless of the outcome of the cmpxchg.
> + * After that, we try to swap the new value into i_ctime_nsec. Again, we take
> + * the resulting ctime, regardless of the outcome of the swap.

This comment seems outdated now. No floor in this function anymore...

> -struct timespec64 current_time(struct inode *inode)
> +struct timespec64 inode_set_ctime_current(struct inode *inode)
>  {
>  	struct timespec64 now;
> +	u32 cns, cur;
...

> diff --git a/fs/stat.c b/fs/stat.c
> index 41e598376d7e..381926fb405f 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -26,6 +26,35 @@
>  #include "internal.h"
>  #include "mount.h"
>  
> +/**
> + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> + * @stat: where to store the resulting values
> + * @request_mask: STATX_* values requested
> + * @inode: inode from which to grab the c/mtime
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
						 ^^ of

> + * in @stat. When fetching the value, flag it as QUERIED (if not already)
> + * so the next write will record a distinct timestamp.
> + */
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
> +{

Given how things worked out in the end, it seems this function doesn't need
to handle mtime at all and we can move mtime handling back to shared generic
code?

> +	atomic_t *pcn = (atomic_t *)&inode->i_ctime_nsec;
> +
> +	/* If neither time was requested, then don't report them */
> +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> +		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
> +		return;
> +	}
> +
> +	stat->mtime = inode_get_mtime(inode);
> +	stat->ctime.tv_sec = inode->i_ctime_sec;
> +	stat->ctime.tv_nsec = (u32)atomic_read(pcn);
> +	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
> +		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
> +	stat->ctime.tv_nsec &= ~I_CTIME_QUERIED;
> +}
> +EXPORT_SYMBOL(fill_mg_cmtime);
> +
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
>   * @idmap:		idmap of the mount the inode was found from
> @@ -58,8 +87,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>  	stat->rdev = inode->i_rdev;
>  	stat->size = i_size_read(inode);
>  	stat->atime = inode_get_atime(inode);
> -	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	if (is_mgtime(inode)) {
> +		fill_mg_cmtime(stat, request_mask, inode);
> +	} else {
> +		stat->ctime = inode_get_ctime(inode);
> +		stat->mtime = inode_get_mtime(inode);
> +	}
> +
>  	stat->blksize = i_blocksize(inode);
>  	stat->blocks = inode->i_blocks;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e3c603d01337..23908bad166c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1653,6 +1653,17 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
>  	return inode_set_mtime_to_ts(inode, ts);
>  }
>  
> +/*
> + * Multigrain timestamps
> + *
> + * Conditionally use fine-grained ctime and mtime timestamps when there
> + * are users actively observing them via getattr. The primary use-case
> + * for this is NFS clients that use the ctime to distinguish between
> + * different states of the file, and that are often fooled by multiple
> + * operations that occur in the same coarse-grained timer tick.

Again, mtime seems unaffected by mgtime changes now.

> + */
> +#define I_CTIME_QUERIED		((u32)BIT(31))
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

