Return-Path: <linux-fsdevel+bounces-36266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D39E0782
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FE017800D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3420CCD0;
	Mon,  2 Dec 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Xa4/XXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9yCcvbV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Xa4/XXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9yCcvbV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7241D540;
	Mon,  2 Dec 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152518; cv=none; b=IUpzbioWhvtr0bATmanhxouDk3f+f1DqncCpJqNBR62QWN8p9iENTakTbYuLrqWxF4SEEjpBB0k0Kp/mB+4hNWd+LFGi0hRMTMHH04+kDmxUcqBESgcyRQdqJDNooykKWajWvsfa7ezCvJQboUV9sW+3qp3ehNBAH29CbqAluSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152518; c=relaxed/simple;
	bh=cR6WbO2evMztc0uRTuu5FT2oo7QhN0rDknR9ZXjR/ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdj+NdlvuC7eJ0TXpqNunHaopU8krDJrijMu3Mtl3S6j429nKhVk3p9wSbg/xCd6cLu0N1qepeP0wItsx9BFnnbQZbHVrcN8FBb6iWRZtiUcnq6H0RCvnoDXAyXieRYpP8YCUi03JYffIwy/8wUipSgU2C5jnLrrQKCIJhdOrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Xa4/XXp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9yCcvbV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Xa4/XXp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9yCcvbV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D6971F396;
	Mon,  2 Dec 2024 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733152513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t46+INLEnxS/57LH5/qlM9GnVJom2dSX//F+vn7CqBo=;
	b=1Xa4/XXp2pkOdqT0okobzClvxS9qRiJiI5+db3OzCFT+H+vsolvwpaYkbq4KkUi27vTYxB
	D1SaRi5+tL8AyEDGm36aJTN2mBVqtcady7wG0e1paPpJw3X2Xss8kUD41dF1m5ibNbJQUO
	WX3nIYnpEzhiLj/4fpReww4H+nbpJoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733152513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t46+INLEnxS/57LH5/qlM9GnVJom2dSX//F+vn7CqBo=;
	b=v9yCcvbVZv1cCZdCItufM7MZFQwnUaYIgWt7OsuTFA3rZJide0uJnxrWuDPZgZKOj5VQy+
	ycho3pKX7RdiOfDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="1Xa4/XXp";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v9yCcvbV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733152513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t46+INLEnxS/57LH5/qlM9GnVJom2dSX//F+vn7CqBo=;
	b=1Xa4/XXp2pkOdqT0okobzClvxS9qRiJiI5+db3OzCFT+H+vsolvwpaYkbq4KkUi27vTYxB
	D1SaRi5+tL8AyEDGm36aJTN2mBVqtcady7wG0e1paPpJw3X2Xss8kUD41dF1m5ibNbJQUO
	WX3nIYnpEzhiLj/4fpReww4H+nbpJoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733152513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t46+INLEnxS/57LH5/qlM9GnVJom2dSX//F+vn7CqBo=;
	b=v9yCcvbVZv1cCZdCItufM7MZFQwnUaYIgWt7OsuTFA3rZJide0uJnxrWuDPZgZKOj5VQy+
	ycho3pKX7RdiOfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24FE5139C2;
	Mon,  2 Dec 2024 15:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9j3ECAHPTWeHLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 15:15:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A778A075D; Mon,  2 Dec 2024 16:15:12 +0100 (CET)
Date: Mon, 2 Dec 2024 16:15:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] pidfs: rework inode number allocation
Message-ID: <20241202151512.cfen5rebpzrhi5ru@quack3>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
 <20241129-work-pidfs-v2-1-61043d66fbce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-v2-1-61043d66fbce@kernel.org>
X-Rspamd-Queue-Id: 8D6971F396
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 29-11-24 14:02:23, Christian Brauner wrote:
> Recently we received a patchset that aims to enable file handle encoding
> and decoding via name_to_handle_at(2) and open_by_handle_at(2).
> 
> A crucical step in the patch series is how to go from inode number to
> struct pid without leaking information into unprivileged contexts. The
> issue is that in order to find a struct pid the pid number in the
> initial pid namespace must be encoded into the file handle via
> name_to_handle_at(2). This can be used by containers using a separate
> pid namespace to learn what the pid number of a given process in the
> initial pid namespace is. While this is a weak information leak it could
> be used in various exploits and in general is an ugly wart in the design.
> 
> To solve this problem a new way is needed to lookup a struct pid based
> on the inode number allocated for that struct pid. The other part is to
> remove the custom inode number allocation on 32bit systems that is also
> an ugly wart that should go away.
> 
> So, a new scheme is used that I was discusssing with Tejun some time
> back. A cyclic ida is used for the lower 32 bits and a the high 32 bits
> are used for the generation number. This gives a 64 bit inode number
> that is unique on both 32 bit and 64 bit. The lower 32 bit number is
> recycled slowly and can be used to lookup struct pids.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c            | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pidfs.h |  2 ++
>  kernel/pid.c          | 14 ++++++------
>  3 files changed, 72 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 618abb1fa1b84cf31282c922374e28d60cd49d00..0bdd9c525b80895d33f2eae5e8e375788580072f 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -23,6 +23,59 @@
>  #include "internal.h"
>  #include "mount.h"
>  
> +static u32 pidfs_ino_highbits;
> +static u32 pidfs_ino_last_ino_lowbits;
> +
> +static DEFINE_IDR(pidfs_ino_idr);
> +
> +static inline ino_t pidfs_ino(u64 ino)
> +{
> +	/* On 32 bit low 32 bits are the inode. */
> +	if (sizeof(ino_t) < sizeof(u64))
> +		return (u32)ino;
> +
> +	/* On 64 bit simply return ino. */
> +	return ino;
> +}
> +
> +static inline u32 pidfs_gen(u64 ino)
> +{
> +	/* On 32 bit the generation number are the upper 32 bits. */
> +	if (sizeof(ino_t) < sizeof(u64))
> +		return ino >> 32;
> +
> +	/* On 64 bit the generation number is 1. */
> +	return 1;
> +}
> +
> +/*
> + * Construct an inode number for struct pid in a way that we can use the
> + * lower 32bit to lookup struct pid independent of any pid numbers that
> + * could be leaked into userspace (e.g., via file handle encoding).
> + */
> +int pidfs_add_pid(struct pid *pid)
> +{
> +	u32 ino_highbits;
> +	int ret;
> +
> +	ret = idr_alloc_cyclic(&pidfs_ino_idr, pid, 1, 0, GFP_ATOMIC);
> +	if (ret >= 0 && ret < pidfs_ino_last_ino_lowbits)
> +		pidfs_ino_highbits++;
> +	ino_highbits = pidfs_ino_highbits;
> +	pidfs_ino_last_ino_lowbits = ret;
> +	if (ret < 0)
> +		return ret;
> +
> +	pid->ino = (u64)ino_highbits << 32 | ret;
> +	pid->stashed = NULL;
> +	return 0;
> +}
> +
> +void pidfs_remove_pid(struct pid *pid)
> +{
> +	idr_remove(&pidfs_ino_idr, (u32)pidfs_ino(pid->ino));
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  /**
>   * pidfd_show_fdinfo - print information about a pidfd
> @@ -491,6 +544,16 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  
>  void __init pidfs_init(void)
>  {
> +	/*
> +	 * On 32 bit systems the lower 32 bits are the inode number and
> +	 * the higher 32 bits are the generation number. The starting
> +	 * value for the inode number and the generation number is one.
> +	 */
> +	if (sizeof(ino_t) < sizeof(u64))
> +		pidfs_ino_highbits = 1;
> +	else
> +		pidfs_ino_highbits = 0;
> +
>  	pidfs_mnt = kern_mount(&pidfs_type);
>  	if (IS_ERR(pidfs_mnt))
>  		panic("Failed to mount pidfs pseudo filesystem");
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 75bdf9807802a5d1a9699c99aa42648c2bd34170..2958652bb108b8a2e02128e17317be4545b40a01 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -4,5 +4,7 @@
>  
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
>  void __init pidfs_init(void);
> +int pidfs_add_pid(struct pid *pid);
> +void pidfs_remove_pid(struct pid *pid);
>  
>  #endif /* _LINUX_PID_FS_H */
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 115448e89c3e9e664d0d51c8d853e8167ba0540c..6131543e7c090c164a2bac014f8eeee61926b13d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -64,11 +64,6 @@ int pid_max = PID_MAX_DEFAULT;
>  
>  int pid_max_min = RESERVED_PIDS + 1;
>  int pid_max_max = PID_MAX_LIMIT;
> -/*
> - * Pseudo filesystems start inode numbering after one. We use Reserved
> - * PIDs as a natural offset.
> - */
> -static u64 pidfs_ino = RESERVED_PIDS;
>  
>  /*
>   * PID-map pages start out as NULL, they get allocated upon
> @@ -157,6 +152,7 @@ void free_pid(struct pid *pid)
>  		}
>  
>  		idr_remove(&ns->idr, upid->nr);
> +		pidfs_remove_pid(pid);
>  	}
>  	spin_unlock_irqrestore(&pidmap_lock, flags);
>  
> @@ -273,22 +269,26 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  	INIT_HLIST_HEAD(&pid->inodes);
>  
>  	upid = pid->numbers + ns->level;
> +	idr_preload(GFP_KERNEL);
>  	spin_lock_irq(&pidmap_lock);
>  	if (!(ns->pid_allocated & PIDNS_ADDING))
>  		goto out_unlock;
> -	pid->stashed = NULL;
> -	pid->ino = ++pidfs_ino;
> +	retval = pidfs_add_pid(pid);
> +	if (retval)
> +		goto out_unlock;
>  	for ( ; upid >= pid->numbers; --upid) {
>  		/* Make the PID visible to find_pid_ns. */
>  		idr_replace(&upid->ns->idr, pid, upid->nr);
>  		upid->ns->pid_allocated++;
>  	}
>  	spin_unlock_irq(&pidmap_lock);
> +	idr_preload_end();
>  
>  	return pid;
>  
>  out_unlock:
>  	spin_unlock_irq(&pidmap_lock);
> +	idr_preload_end();
>  	put_pid_ns(ns);
>  
>  out_free:
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

