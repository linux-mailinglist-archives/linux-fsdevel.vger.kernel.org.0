Return-Path: <linux-fsdevel+bounces-67955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9332C4E7DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E85E4F82F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2530CD99;
	Tue, 11 Nov 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XDPmb+Uf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCw54wrv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jtro0Scs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DhUb478c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAC304BDC
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871158; cv=none; b=r8vQshyGmUqeKtcEq3RfYYoxil9MASTpMeUXgePxUv3Lyc/23/UuwVL3/QK/jLmlp0vfZTiIREzLotjgnUck8mYDCgJhYI0neMVzWoXJrEtzHleLi5x2K28LwRN+7M208VeDW8NNVM9b/F/+P53K2NdEX+/KG5e/FTi1/fn5OIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871158; c=relaxed/simple;
	bh=1809HnR7Hz1M8xafkGHEdCVyU1OizBxqpQi1PLjiYzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI+2I1xaypYpyoUx2aDHc26OPC/+UgRcvfyo0qO2l+PBGr3nYPwcEW1NRI52QpY9iHYHhmT1KgDoGz7pyzlJiCkmhK2+OhLGRdghDiGnYXpmgmQrFhdJ2vQUBk8nuf6iaJKpsoqR9X3AQodGwVBS7/PRnk2OTQ1GMKmMje4TwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XDPmb+Uf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCw54wrv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jtro0Scs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DhUb478c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C2BB21A21;
	Tue, 11 Nov 2025 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762871154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8EYNR6057DpYywoZVROv3Xbkt2PD3YynG2WTWg+5xo=;
	b=XDPmb+UfXnYZ4U4kJyC9+pBDY8gY9tDz64lI/0nR8GxyW9NPJIL4DPvOLQX33MEgVmxB5T
	Jy2fKqv4Z1hESX7GbTr99569cCLZRMB+H26otLlDB31Ar0iq9jSi47j7ZevTLfQN/fAP1v
	pN5WmpxftotUGEqUUEbxSqzhWHF6hv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762871154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8EYNR6057DpYywoZVROv3Xbkt2PD3YynG2WTWg+5xo=;
	b=BCw54wrvCIsmkl1lRV4ZUJTTToBp0YdLl8Bo01xfMv/I8zga6cnMDthoEM+QgrU9sqUB6H
	K7Vn26UeTrCLSUAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762871153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8EYNR6057DpYywoZVROv3Xbkt2PD3YynG2WTWg+5xo=;
	b=jtro0ScsPQM4YnNdw66AZeap93Mf/8vY7pCxI1Kux+0ptVXqdcFOFxwN92DgNWmdIh5gos
	wVskORC7dwbtRVliK1N48Nn4a6AzKjXPqy6/l/9DkFK0TdRXWWK4S7e+1D/9MEpErrFDnh
	tSg3yuWjRsa8X6kbw8B9dvMmTWMLouo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762871153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8EYNR6057DpYywoZVROv3Xbkt2PD3YynG2WTWg+5xo=;
	b=DhUb478cbGhAGgd89TUndeM8qCjteLGvIUdnqcAVRUfeD0U9wKg66NdR3YIx+PPSp53/6e
	7W6qgTZX4Rns+FBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27CAB149D7;
	Tue, 11 Nov 2025 14:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1WqyCXFHE2mwGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 14:25:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BEFCBA28CD; Tue, 11 Nov 2025 15:25:52 +0100 (CET)
Date: Tue, 11 Nov 2025 15:25:52 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 17/17] vfs: expose delegation support to userland
Message-ID: <htsrrghapbhriwdtt6pbrgsptwf5nri6ehzgmgjqrc2bmsmku4@hl4q3fvz4kyc>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
 <20251111-dir-deleg-ro-v6-17-52f3feebb2f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-dir-deleg-ro-v6-17-52f3feebb2f2@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Tue 11-11-25 09:12:58, Jeff Layton wrote:
> Now that support for recallable directory delegations is available,
> expose this functionality to userland with new F_SETDELEG and F_GETDELEG
> commands for fcntl().
> 
> Note that this also allows userland to request a FL_DELEG type lease on
> files too. Userland applications that do will get signalled when there
> are metadata changes in addition to just data changes (which is a
> limitation of FL_LEASE leases).
> 
> These commands accept a new "struct delegation" argument that contains a
> flags field for future expansion.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fcntl.c                 | 13 +++++++++++++
>  fs/locks.c                 | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/filelock.h   | 12 ++++++++++++
>  include/uapi/linux/fcntl.h | 11 +++++++++++
>  4 files changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 72f8433d9109889eecef56b32d20a85b4e12ea44..f93dbca0843557d197bd1e023519cfa0f00ad78f 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -445,6 +445,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  		struct file *filp)
>  {
>  	void __user *argp = (void __user *)arg;
> +	struct delegation deleg;
>  	int argi = (int)arg;
>  	struct flock flock;
>  	long err = -EINVAL;
> @@ -550,6 +551,18 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  	case F_SET_RW_HINT:
>  		err = fcntl_set_rw_hint(filp, arg);
>  		break;
> +	case F_GETDELEG:
> +		if (copy_from_user(&deleg, argp, sizeof(deleg)))
> +			return -EFAULT;
> +		err = fcntl_getdeleg(filp, &deleg);
> +		if (!err && copy_to_user(argp, &deleg, sizeof(deleg)))
> +			return -EFAULT;
> +		break;
> +	case F_SETDELEG:
> +		if (copy_from_user(&deleg, argp, sizeof(deleg)))
> +			return -EFAULT;
> +		err = fcntl_setdeleg(fd, filp, &deleg);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/fs/locks.c b/fs/locks.c
> index dd290a87f58eb5d522f03fa99d612fbad84dacf3..7f4ccc7974bc8d3e82500ee692c6520b53f2280f 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1703,7 +1703,7 @@ EXPORT_SYMBOL(lease_get_mtime);
>   *	XXX: sfr & willy disagree over whether F_INPROGRESS
>   *	should be returned to userspace.
>   */
> -int fcntl_getlease(struct file *filp)
> +static int __fcntl_getlease(struct file *filp, unsigned int flavor)
>  {
>  	struct file_lease *fl;
>  	struct inode *inode = file_inode(filp);
> @@ -1719,7 +1719,8 @@ int fcntl_getlease(struct file *filp)
>  		list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
>  			if (fl->c.flc_file != filp)
>  				continue;
> -			type = target_leasetype(fl);
> +			if (fl->c.flc_flags & flavor)
> +				type = target_leasetype(fl);
>  			break;
>  		}
>  		spin_unlock(&ctx->flc_lock);
> @@ -1730,6 +1731,19 @@ int fcntl_getlease(struct file *filp)
>  	return type;
>  }
>  
> +int fcntl_getlease(struct file *filp)
> +{
> +	return __fcntl_getlease(filp, FL_LEASE);
> +}
> +
> +int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
> +{
> +	if (deleg->d_flags != 0 || deleg->__pad != 0)
> +		return -EINVAL;
> +	deleg->d_type = __fcntl_getlease(filp, FL_DELEG);
> +	return 0;
> +}
> +
>  /**
>   * check_conflicting_open - see if the given file points to an inode that has
>   *			    an existing open that would conflict with the
> @@ -2039,13 +2053,13 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
>  }
>  EXPORT_SYMBOL_GPL(vfs_setlease);
>  
> -static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
> +static int do_fcntl_add_lease(unsigned int fd, struct file *filp, unsigned int flavor, int arg)
>  {
>  	struct file_lease *fl;
>  	struct fasync_struct *new;
>  	int error;
>  
> -	fl = lease_alloc(filp, FL_LEASE, arg);
> +	fl = lease_alloc(filp, flavor, arg);
>  	if (IS_ERR(fl))
>  		return PTR_ERR(fl);
>  
> @@ -2081,7 +2095,28 @@ int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
>  
>  	if (arg == F_UNLCK)
>  		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
> -	return do_fcntl_add_lease(fd, filp, arg);
> +	return do_fcntl_add_lease(fd, filp, FL_LEASE, arg);
> +}
> +
> +/**
> + *	fcntl_setdeleg	-	sets a delegation on an open file
> + *	@fd: open file descriptor
> + *	@filp: file pointer
> + *	@deleg: delegation request from userland
> + *
> + *	Call this fcntl to establish a delegation on the file.
> + *	Note that you also need to call %F_SETSIG to
> + *	receive a signal when the lease is broken.
> + */
> +int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg)
> +{
> +	/* For now, no flags are supported */
> +	if (deleg->d_flags != 0 || deleg->__pad != 0)
> +		return -EINVAL;
> +
> +	if (deleg->d_type == F_UNLCK)
> +		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
> +	return do_fcntl_add_lease(fd, filp, FL_DELEG, deleg->d_type);
>  }
>  
>  /**
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 208d108df2d73a9df65e5dc9968d074af385f881..54b824c05299261e6bd6acc4175cb277ea35b35d 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -159,6 +159,8 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
>  
>  int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
>  int fcntl_getlease(struct file *filp);
> +int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg);
> +int fcntl_getdeleg(struct file *filp, struct delegation *deleg);
>  
>  static inline bool lock_is_unlock(struct file_lock *fl)
>  {
> @@ -278,6 +280,16 @@ static inline int fcntl_getlease(struct file *filp)
>  	return F_UNLCK;
>  }
>  
> +static inline int fcntl_setdeleg(unsigned int fd, struct file *filp, struct delegation *deleg)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline bool lock_is_unlock(struct file_lock *fl)
>  {
>  	return false;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 3741ea1b73d8500061567b6590ccf5fb4c6770f0..008fac15e573084a9b48e4e991528b4363c54047 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -79,6 +79,17 @@
>   */
>  #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
>  
> +/* Set/Get delegations */
> +#define F_GETDELEG		(F_LINUX_SPECIFIC_BASE + 15)
> +#define F_SETDELEG		(F_LINUX_SPECIFIC_BASE + 16)
> +
> +/* Argument structure for F_GETDELEG and F_SETDELEG */
> +struct delegation {
> +	uint32_t	d_flags;	/* Must be 0 */
> +	uint16_t	d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
> +	uint16_t	__pad;		/* Must be 0 */
> +};
> +
>  /*
>   * Types of directory notifications that may be requested.
>   */
> 
> -- 
> 2.51.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

