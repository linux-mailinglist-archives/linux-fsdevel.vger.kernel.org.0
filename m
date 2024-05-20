Return-Path: <linux-fsdevel+bounces-19777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F79D8C9B91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 12:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F7A1C21B86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E072535A6;
	Mon, 20 May 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLB1ytG7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="723fzpgG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IN7ckt6p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0DdsLj9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326C51C4A;
	Mon, 20 May 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201831; cv=none; b=NyZ0WAWnR2DevPgigpvzXlV2R1rbI6PQKM4G/LPp5cjVFc9Ko4Owhbjfk9FmVUpg8V0v449B2s7NOV/3mFM13A0gNvbqxxY0rwCn078iOmgZpwVJj23WTrr3Rwe4c4o5gdS2JR5xnE4zox1Jj4D0e/UGT6yrSW3s20RDZze0OGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201831; c=relaxed/simple;
	bh=LdTzAMi5TKgNq3l31+TNE+TGIdjpRws9y1+byOlBjnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdd1x3tz1Gsc4vpcgGJn5V/qsN3NVG7sAeBMxTqvvaWMNAv21++Md0BQ9BFwLKycx9ng/dHlOsB/bCUGwfuvif63QDzTl/Zmi5H9BrPepF1nZ9urFEnUSGhMjdbn5wsc6Isnesp1zcX+2+i0bOo8zj8x5nDa5VJREa1kon7o7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLB1ytG7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=723fzpgG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IN7ckt6p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0DdsLj9i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE56B22BD0;
	Mon, 20 May 2024 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716201828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jwGZNorRwfBZNFPD2p7q0lR24E8OwAu0v57PfJQHrQ=;
	b=cLB1ytG7webEmKeOWls3odwtpm8gXYrkLd5jHHnu8l70/G4TpBjvRbWcEbGHkBDFmxKtQf
	j1glvTA8G/XHRwOQCN3xO3t5ubQwL2G7jNsxqYV6lXlQEn11t9zYfIpIx+ClpnTM3o6hV4
	puJHRnHHaORFah0h3tnBRgrHQMw91+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716201828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jwGZNorRwfBZNFPD2p7q0lR24E8OwAu0v57PfJQHrQ=;
	b=723fzpgGsK0M5Z3zsnhM/vVxeuqXY0lQwNTZFQL9AKV1aF6c+wyk2Mv3aAI2xq+aI0exhI
	y18uMvOf1yjhMIBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716201827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jwGZNorRwfBZNFPD2p7q0lR24E8OwAu0v57PfJQHrQ=;
	b=IN7ckt6p9Nf0UIrD6R8NZmOl1JILgENYN+x/tNH3bvF+iavZRpL2QKqo+RebFF701f+Vsu
	zICKSSWgTrJjBzFuq69/PLv4lfdXxF+tU/BebYPQ4Tdi7i0sYch///HSax27oY677XygV9
	SU9A5DCsXU8h4WMMKHeB+qWXTd4jw+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716201827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jwGZNorRwfBZNFPD2p7q0lR24E8OwAu0v57PfJQHrQ=;
	b=0DdsLj9iWo+g2h6zrpfHub3tZ9hcEwZbbstac4QiraHsmlpQaN6bpN5SlLdHUs+0xMbRSQ
	qZbv/aeu8lJEg2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E25B713A21;
	Mon, 20 May 2024 10:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +mgvN2MpS2Y5XgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 10:43:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78A84A0888; Mon, 20 May 2024 12:43:47 +0200 (CEST)
Date: Mon, 20 May 2024 12:43:47 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: switch timespec64 fields in inode to discrete
 integers
Message-ID: <20240520104347.j5fz4eem52bv2wzg@quack3>
References: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,linux-foundation.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]

On Fri 17-05-24 20:08:40, Jeff Layton wrote:
> Adjacent struct timespec64's pack poorly. Switch them to discrete
> integer fields for the seconds and nanoseconds. This shaves 8 bytes off
> struct inode with a garden-variety Fedora Kconfig on x86_64, but that
> also moves the i_lock into the previous cacheline, away from the fields
> it protects.
> 
> To remedy that, move i_generation above the i_lock, which moves the new
> 4-byte hole to just after the i_fsnotify_mask in my setup. Amir has
> plans to use that to expand the i_fsnotify_mask, so add a comment to
> that effect as well.
> 
> Cc: Amir Goldstein <amir73il@gmail.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I like this! Although it doesn't possibly result in less memory being used
by the slab cache in the end as Matthew points out, it still makes the
struct more dense and if nothing else it gives us more space for future
growth ;).  So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> For reference (according to pahole):
> 
>     Before:	/* size: 624, cachelines: 10, members: 53 */
>     After: 	/* size: 616, cachelines: 10, members: 56 */
> 
> I've done some lightweight testing with this and it seems fine, but I
> wouldn't mind seeing it sit in -next for a bit to make sure I haven't
> missed anything.
> ---
>  include/linux/fs.h | 48 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b7b9b3b79acc..45e8766de7d8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -660,9 +660,13 @@ struct inode {
>  	};
>  	dev_t			i_rdev;
>  	loff_t			i_size;
> -	struct timespec64	__i_atime;
> -	struct timespec64	__i_mtime;
> -	struct timespec64	__i_ctime; /* use inode_*_ctime accessors! */
> +	time64_t		i_atime_sec;
> +	time64_t		i_mtime_sec;
> +	time64_t		i_ctime_sec;
> +	u32			i_atime_nsec;
> +	u32			i_mtime_nsec;
> +	u32			i_ctime_nsec;
> +	u32			i_generation;
>  	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
>  	unsigned short          i_bytes;
>  	u8			i_blkbits;
> @@ -719,10 +723,10 @@ struct inode {
>  		unsigned		i_dir_seq;
>  	};
>  
> -	__u32			i_generation;
>  
>  #ifdef CONFIG_FSNOTIFY
>  	__u32			i_fsnotify_mask; /* all events this inode cares about */
> +	/* 32-bit hole reserved for expanding i_fsnotify_mask */
>  	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
>  #endif
>  
> @@ -1544,23 +1548,27 @@ struct timespec64 inode_set_ctime_current(struct inode *inode);
>  
>  static inline time64_t inode_get_atime_sec(const struct inode *inode)
>  {
> -	return inode->__i_atime.tv_sec;
> +	return inode->i_atime_sec;
>  }
>  
>  static inline long inode_get_atime_nsec(const struct inode *inode)
>  {
> -	return inode->__i_atime.tv_nsec;
> +	return inode->i_atime_nsec;
>  }
>  
>  static inline struct timespec64 inode_get_atime(const struct inode *inode)
>  {
> -	return inode->__i_atime;
> +	struct timespec64 ts = { .tv_sec  = inode_get_atime_sec(inode),
> +				 .tv_nsec = inode_get_atime_nsec(inode) };
> +
> +	return ts;
>  }
>  
>  static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
>  						      struct timespec64 ts)
>  {
> -	inode->__i_atime = ts;
> +	inode->i_atime_sec = ts.tv_sec;
> +	inode->i_atime_nsec = ts.tv_nsec;
>  	return ts;
>  }
>  
> @@ -1569,28 +1577,32 @@ static inline struct timespec64 inode_set_atime(struct inode *inode,
>  {
>  	struct timespec64 ts = { .tv_sec  = sec,
>  				 .tv_nsec = nsec };
> +
>  	return inode_set_atime_to_ts(inode, ts);
>  }
>  
>  static inline time64_t inode_get_mtime_sec(const struct inode *inode)
>  {
> -	return inode->__i_mtime.tv_sec;
> +	return inode->i_mtime_sec;
>  }
>  
>  static inline long inode_get_mtime_nsec(const struct inode *inode)
>  {
> -	return inode->__i_mtime.tv_nsec;
> +	return inode->i_mtime_nsec;
>  }
>  
>  static inline struct timespec64 inode_get_mtime(const struct inode *inode)
>  {
> -	return inode->__i_mtime;
> +	struct timespec64 ts = { .tv_sec  = inode_get_mtime_sec(inode),
> +				 .tv_nsec = inode_get_mtime_nsec(inode) };
> +	return ts;
>  }
>  
>  static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
>  						      struct timespec64 ts)
>  {
> -	inode->__i_mtime = ts;
> +	inode->i_mtime_sec = ts.tv_sec;
> +	inode->i_mtime_nsec = ts.tv_nsec;
>  	return ts;
>  }
>  
> @@ -1604,23 +1616,27 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
>  
>  static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>  {
> -	return inode->__i_ctime.tv_sec;
> +	return inode->i_ctime_sec;
>  }
>  
>  static inline long inode_get_ctime_nsec(const struct inode *inode)
>  {
> -	return inode->__i_ctime.tv_nsec;
> +	return inode->i_ctime_nsec;
>  }
>  
>  static inline struct timespec64 inode_get_ctime(const struct inode *inode)
>  {
> -	return inode->__i_ctime;
> +	struct timespec64 ts = { .tv_sec  = inode_get_ctime_sec(inode),
> +				 .tv_nsec = inode_get_ctime_nsec(inode) };
> +
> +	return ts;
>  }
>  
>  static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
>  						      struct timespec64 ts)
>  {
> -	inode->__i_ctime = ts;
> +	inode->i_ctime_sec = ts.tv_sec;
> +	inode->i_ctime_nsec = ts.tv_nsec;
>  	return ts;
>  }
>  
> 
> ---
> base-commit: 7ee332c9f12bc5b380e36919cd7d056592a7073f
> change-id: 20240517-amtime-68a7ebc76f45
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

