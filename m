Return-Path: <linux-fsdevel+bounces-28251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036039688A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 15:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265D11C2252B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E19205E38;
	Mon,  2 Sep 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1oJF3DT0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7dP0lJSF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1oJF3DT0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7dP0lJSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFF13E8A5;
	Mon,  2 Sep 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283371; cv=none; b=tMeirWCw1+dnx0b0kL2aXCq8Jiwn6yQfdCECcBxEHvtkCBJcsJ3YSh8PyoJSYto26n5K1kJ/DM0KBQt7xQudTfe/zaAJEvM2tG9wTDXnZhRGyzhoairnakBu/QRvb0HBGksyQ1pXopMW0vMd2thYIejxFCuryzGebY94QHzyBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283371; c=relaxed/simple;
	bh=YnCwNQx7TKvbzrgN+Hy9VQiHnLlbt2oyWQ6b7LX2hWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2m9VoVP+52ZozOvLD5vF3coRrJ5zIZOB9W0XaRI+ZW61wCKmldwgNwhzniQirVMVSx/SoZzi6A7u02hNzwhcIjrlnbVKWlqX6TmvAB/MEkFwJBmSEIMnnUPitLvGbUcsdZ39xwXedo2zQ6SiN52bcrEIWd+urrr0wVx64sJG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1oJF3DT0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7dP0lJSF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1oJF3DT0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7dP0lJSF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 554F221B4F;
	Mon,  2 Sep 2024 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725283367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rPewlUTCLHFU77P7SyUEMQn7mEnc4uHPNt62pP4RE4=;
	b=1oJF3DT0giQJmLP3bX0+t4q2163U5ZHSJh++EIPMIB0hIOg0TTmZ0rCJsdBhmplQs+Fd7y
	OZVtlN8++IscoCDV2vtCd2Sys3WrgPOncWJPy31jkpUR45qMXNpYyPaO0DMajvqHosWr8+
	olRTpqeHgCjCSHykaGfhgG6u67PQ7/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725283367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rPewlUTCLHFU77P7SyUEMQn7mEnc4uHPNt62pP4RE4=;
	b=7dP0lJSFtnB/59XKeRj0hXRPYT7dpx/Iz2gNpbD9a5jJL+lYcncciFRqEupvLg4RiBaM4R
	jzg+//I0EoX5GXBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1oJF3DT0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7dP0lJSF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725283367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rPewlUTCLHFU77P7SyUEMQn7mEnc4uHPNt62pP4RE4=;
	b=1oJF3DT0giQJmLP3bX0+t4q2163U5ZHSJh++EIPMIB0hIOg0TTmZ0rCJsdBhmplQs+Fd7y
	OZVtlN8++IscoCDV2vtCd2Sys3WrgPOncWJPy31jkpUR45qMXNpYyPaO0DMajvqHosWr8+
	olRTpqeHgCjCSHykaGfhgG6u67PQ7/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725283367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rPewlUTCLHFU77P7SyUEMQn7mEnc4uHPNt62pP4RE4=;
	b=7dP0lJSFtnB/59XKeRj0hXRPYT7dpx/Iz2gNpbD9a5jJL+lYcncciFRqEupvLg4RiBaM4R
	jzg+//I0EoX5GXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44ECC13A7C;
	Mon,  2 Sep 2024 13:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAnNECe81Wa9IAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 13:22:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F09FEA0965; Mon,  2 Sep 2024 15:22:46 +0200 (CEST)
Date: Mon, 2 Sep 2024 15:22:46 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/13] fs: handle delegated timestamps in
 setattr_copy_mgtime
Message-ID: <20240902132246.zorbw3filqh73dms@quack3>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-11-271c60806c5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-delstid-v3-11-271c60806c5d@kernel.org>
X-Rspamd-Queue-Id: 554F221B4F
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,suse.de,netapp.com,talpey.com,kernel.org,redhat.com,zeniv.linux.org.uk,suse.cz,lwn.net,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 29-08-24 09:26:49, Jeff Layton wrote:
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
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/attr.c          | 28 +++++++++++++--------
>  fs/inode.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  3 files changed, 94 insertions(+), 10 deletions(-)
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
> index 01f7df1973bd..f0fbfd470d8e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2835,6 +2835,80 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
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
> +	ktime_t now, floor = atomic64_read(&ctime_floor);
> +	struct timespec64 now_ts, cur_ts;
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
> +	now = coarse_ctime(floor);
> +	now_ts = ktime_to_timespec64(now);
> +
> +	/* Clamp the update to "now" if it's in the future */
> +	if (timespec64_compare(&update, &now_ts) > 0)
> +		update = now_ts;
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
> index eff688e75f2f..ea7ed437d2b1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1544,6 +1544,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
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
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

