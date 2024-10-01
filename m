Return-Path: <linux-fsdevel+bounces-30502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE1598BDBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AED289461
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3561C461F;
	Tue,  1 Oct 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDj2Daeg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B1A5Czx/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDj2Daeg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B1A5Czx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFCCEEC5;
	Tue,  1 Oct 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789547; cv=none; b=n4614+MK8rmcjreLV2CKTZFDGz1mya1HVW+h0GDmGLxNADJxVE/VVRkMA2C0nlY7ba+9fQhtoa+lhP3TzbuJHvqf54Ov667qEAE3tNon9qxtcnCyeZtTCzgGmD3a4mc2aQn0icDZvIIXLEPYhRYUVh0SUA4Cqn0cbPb01mvFBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789547; c=relaxed/simple;
	bh=HW2VSXeX/jBgYNRhPYF7a3Igw5CEPNBegW6vQHHcbU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tyw4fZth/0ucL94Go2LLyUd1x5dMcfXJ6MChZo86rlL4DFRcQKI+hWyN7xeQIAcEG4QPYl8HMwcwGDYFtl0tRUcWEm+BfW3wV6EJW/KpDdnsGKEVs81RyjxUPCG6zIYVWMXFEFV2xJNtyWQWsDXSk2txA96zGckXE6yLWni7Z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDj2Daeg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B1A5Czx/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDj2Daeg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B1A5Czx/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC9501F813;
	Tue,  1 Oct 2024 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727789543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJyVh7xpKFUerqgpvOUGQtwMuhiG+vMZUA+eKVSBOeQ=;
	b=rDj2Daegw8acNetwuj+igR8urk35s9IZ5Ei4I5Xxg1Hf1yqHsGh07lzo6akylF2rlreVuA
	RBAeL6aZkGoF0vKutQUZhkX3qKm/b1/jlPlXDc2TU6/f+CeVzyg5lpcXpqHqMArMLoBpqB
	v9XWD2kMJCRuN9Moac3CaUXQnIsYDQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727789543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJyVh7xpKFUerqgpvOUGQtwMuhiG+vMZUA+eKVSBOeQ=;
	b=B1A5Czx/JU851NEzyiwPym53Dc/Uk7kviKL8OOcS1KkhL/cvrtNrUAxf40xEk6CgQKiBQn
	jRfTdeTqntkjpyCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727789543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJyVh7xpKFUerqgpvOUGQtwMuhiG+vMZUA+eKVSBOeQ=;
	b=rDj2Daegw8acNetwuj+igR8urk35s9IZ5Ei4I5Xxg1Hf1yqHsGh07lzo6akylF2rlreVuA
	RBAeL6aZkGoF0vKutQUZhkX3qKm/b1/jlPlXDc2TU6/f+CeVzyg5lpcXpqHqMArMLoBpqB
	v9XWD2kMJCRuN9Moac3CaUXQnIsYDQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727789543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJyVh7xpKFUerqgpvOUGQtwMuhiG+vMZUA+eKVSBOeQ=;
	b=B1A5Czx/JU851NEzyiwPym53Dc/Uk7kviKL8OOcS1KkhL/cvrtNrUAxf40xEk6CgQKiBQn
	jRfTdeTqntkjpyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEA3713A73;
	Tue,  1 Oct 2024 13:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vHWbKuf5+2ZwDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Oct 2024 13:32:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A189A0881; Tue,  1 Oct 2024 15:32:19 +0200 (CEST)
Date: Tue, 1 Oct 2024 15:32:19 +0200
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
Subject: Re: [PATCH v8 04/12] fs: handle delegated timestamps in
 setattr_copy_mgtime
Message-ID: <20241001133219.aenkpa5ydeefqqyd@quack3>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
 <20241001-mgtime-v8-4-903343d91bc3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-mgtime-v8-4-903343d91bc3@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLy4jt9zmnbk4oncb1qwahh5jo)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 01-10-24 06:58:58, Jeff Layton wrote:
> When updating the ctime on an inode for a SETATTR with a multigrain
> filesystem, we usually want to take the latest time we can get for the
> ctime. The exception to this rule is when there is a nfsd write
> delegation and the server is proxying timestamps from the client.
> 
> When nfsd gets a CB_GETATTR response, we want to update the timestamp
> value in the inode to the values that the client is tracking. The client
> doesn't send a ctime value (since that's always determined by the
> exported filesystem), but it can send a mtime value. In the case where
> it does, then we may need to update the ctime to a value commensurate
> with that instead of the current time.
> 
> If ATTR_DELEG is set, then use ia_ctime value instead of setting the
> timestamp to the current time.
> 
> With the addition of delegated timestamps we can also receive a request
> to update only the atime, but we may not need to set the ctime. Trust
> the ATTR_CTIME flag in the update and only update the ctime when it's
> set.
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/attr.c          | 28 +++++++++++++--------
>  fs/inode.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  3 files changed, 92 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 3bcbc45708a3..392eb62aa609 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -286,16 +286,20 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
>  	unsigned int ia_valid = attr->ia_valid;
>  	struct timespec64 now;
>  
> -	/*
> -	 * If the ctime isn't being updated then nothing else should be
> -	 * either.
> -	 */
> -	if (!(ia_valid & ATTR_CTIME)) {
> -		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
> -		return;
> +	if (ia_valid & ATTR_CTIME) {
> +		/*
> +		 * In the case of an update for a write delegation, we must respect
> +		 * the value in ia_ctime and not use the current time.
> +		 */
> +		if (ia_valid & ATTR_DELEG)
> +			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
> +		else
> +			now = inode_set_ctime_current(inode);
> +	} else {
> +		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
> +		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
>  	}
>  
> -	now = inode_set_ctime_current(inode);
>  	if (ia_valid & ATTR_ATIME_SET)
>  		inode_set_atime_to_ts(inode, attr->ia_atime);
>  	else if (ia_valid & ATTR_ATIME)
> @@ -354,8 +358,12 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
>  		inode_set_atime_to_ts(inode, attr->ia_atime);
>  	if (ia_valid & ATTR_MTIME)
>  		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> -	if (ia_valid & ATTR_CTIME)
> -		inode_set_ctime_to_ts(inode, attr->ia_ctime);
> +	if (ia_valid & ATTR_CTIME) {
> +		if (ia_valid & ATTR_DELEG)
> +			inode_set_ctime_deleg(inode, attr->ia_ctime);
> +		else
> +			inode_set_ctime_to_ts(inode, attr->ia_ctime);
> +	}
>  }
>  EXPORT_SYMBOL(setattr_copy);
>  
> diff --git a/fs/inode.c b/fs/inode.c
> index 4ec1e71e9a9d..7a324d999816 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2751,6 +2751,78 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  }
>  EXPORT_SYMBOL(inode_set_ctime_current);
>  
> +/**
> + * inode_set_ctime_deleg - try to update the ctime on a delegated inode
> + * @inode: inode to update
> + * @update: timespec64 to set the ctime
> + *
> + * Attempt to atomically update the ctime on behalf of a delegation holder.
> + *
> + * The nfs server can call back the holder of a delegation to get updated
> + * inode attributes, including the mtime. When updating the mtime we may
> + * need to update the ctime to a value at least equal to that.
> + *
> + * This can race with concurrent updates to the inode, in which
> + * case we just don't do the update.
> + *
> + * Note that this works even when multigrain timestamps are not enabled,
> + * so use it in either case.
> + */
> +struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 update)
> +{
> +	struct timespec64 now, cur_ts;
> +	u32 cur, old;
> +
> +	/* pairs with try_cmpxchg below */
> +	cur = smp_load_acquire(&inode->i_ctime_nsec);
> +	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> +	cur_ts.tv_sec = inode->i_ctime_sec;
> +
> +	/* If the update is older than the existing value, skip it. */
> +	if (timespec64_compare(&update, &cur_ts) <= 0)
> +		return cur_ts;
> +
> +	ktime_get_coarse_real_ts64_mg(&now);
> +
> +	/* Clamp the update to "now" if it's in the future */
> +	if (timespec64_compare(&update, &now) > 0)
> +		update = now;
> +
> +	update = timestamp_truncate(update, inode);
> +
> +	/* No need to update if the values are already the same */
> +	if (timespec64_equal(&update, &cur_ts))
> +		return cur_ts;
> +
> +	/*
> +	 * Try to swap the nsec value into place. If it fails, that means
> +	 * we raced with an update due to a write or similar activity. That
> +	 * stamp takes precedence, so just skip the update.
> +	 */
> +retry:
> +	old = cur;
> +	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
> +		inode->i_ctime_sec = update.tv_sec;
> +		mgtime_counter_inc(mg_ctime_swaps);
> +		return update;
> +	}
> +
> +	/*
> +	 * Was the change due to someone marking the old ctime QUERIED?
> +	 * If so then retry the swap. This can only happen once since
> +	 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> +	 * with a new ctime.
> +	 */
> +	if (!(old & I_CTIME_QUERIED) && (cur == (old | I_CTIME_QUERIED)))
> +		goto retry;
> +
> +	/* Otherwise, it was a new timestamp. */
> +	cur_ts.tv_sec = inode->i_ctime_sec;
> +	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> +	return cur_ts;
> +}
> +EXPORT_SYMBOL(inode_set_ctime_deleg);
> +
>  /**
>   * in_group_or_capable - check whether caller is CAP_FSETID privileged
>   * @idmap:	idmap of the mount @inode was found from
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 23908bad166c..b1a3bd07711b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1584,6 +1584,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
>  
>  struct timespec64 current_time(struct inode *inode);
>  struct timespec64 inode_set_ctime_current(struct inode *inode);
> +struct timespec64 inode_set_ctime_deleg(struct inode *inode,
> +					struct timespec64 update);
>  
>  static inline time64_t inode_get_atime_sec(const struct inode *inode)
>  {
> 
> -- 
> 2.46.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

