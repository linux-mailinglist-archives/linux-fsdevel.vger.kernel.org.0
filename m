Return-Path: <linux-fsdevel+bounces-65076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0104BFB045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70744584030
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46730F53E;
	Wed, 22 Oct 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="INyd/zK+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JHYByJ7o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0CuB5OkP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="58uCDXvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A130CD98
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123509; cv=none; b=G1gACqK6olM6IhHEYMGS6DuQD8ckOFLFHgwB+Xm8RJtG14tqz3oYBq90gl6YqQM2KnnH9fQ3tNszfolIXfX/T+bQAK4FsCSEbN1WYzcwkSCIk4yccGwSCnXpSwoghSQrw3ABp3bqxB3TnJPJREzLBUxSWWIsfYXTOhsM4T3UKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123509; c=relaxed/simple;
	bh=miX3y3AeKahdUqLrwrfw2wjjomDQvkrf/LXUFqyccP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgPDcNjT51zAxmILUvNf+VlFmChaMBhhwbNHc7qkbUqfMxSxQ3ldo6eaUFOz4wVMRAOfwDChRhhGCIzTFUNUKk4hXGwInZ8jTKf9D9AKE9H5rfpLyMUjtGdqRi2sRT5XBpsgao99gXS1NTBW6hmt/S3zWsXJdofWwC4iaMBYVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=INyd/zK+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JHYByJ7o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0CuB5OkP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=58uCDXvn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49AC71F769;
	Wed, 22 Oct 2025 08:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761123501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ILnujSjCtzliBVQlHu/pU5YVaYGg09jhAWEZowBEYI=;
	b=INyd/zK+xbJrcBrQVb1B+Yzk4eqchns/Tixsdy/uw1Nvg4bMxgyr6lWwMItdZ99o+4Tuvf
	OC0hU2cAhalh409HahdTDkVdMCCD7XyZKnP1jl1fjkN+k90WXWdqlzfuilU1SIDvaWhJnV
	tOIwDSF4wAGfHlVHgE9+9WLnAlgRKZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761123501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ILnujSjCtzliBVQlHu/pU5YVaYGg09jhAWEZowBEYI=;
	b=JHYByJ7ohXRRBYIT4/WvR7ocJK2/PS/xHMwzuH+PQEE5hE750Jc2Hy5mNhhsC0NAtZLpix
	5Y7fVY+g/1HMtgCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761123497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ILnujSjCtzliBVQlHu/pU5YVaYGg09jhAWEZowBEYI=;
	b=0CuB5OkPCWFD9UEYoTzMlzHLl+3oq9dfRcDjqZIMD9aromE7ewtK1hvwwfD4lKCvAcpuea
	xo837RjPid/V6z3s7X46oFCDtfuX6lUjn5Pi/1Soy69AMixNZiC++5N1rG0SoFnY2kWQaJ
	2OgVFzyOWaRz3Jz7sbVXc6JNkbRexXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761123497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ILnujSjCtzliBVQlHu/pU5YVaYGg09jhAWEZowBEYI=;
	b=58uCDXvn81FxryP0z2T8/eVDp8/QLdcE2k7txaL8huaOyvLzEn4iOUu913pIG1VGP1Sz0u
	JhbWSOIRff+dmkAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3197813A29;
	Wed, 22 Oct 2025 08:58:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 31wSDKmc+Gg1aAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Oct 2025 08:58:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0A3DA0990; Wed, 22 Oct 2025 10:58:16 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:58:16 +0200
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
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 01/13] filelock: push the S_ISREG check down to
 ->setlease handlers
Message-ID: <vimhf2fgjnwcavlxevt5cnsfkgjdps6z545nb7cmknwodnewds@rtxxompo53xx>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
 <20251021-dir-deleg-ro-v3-1-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-dir-deleg-ro-v3-1-a08b1cde9f4c@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
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

On Tue 21-10-25 11:25:36, Jeff Layton wrote:
> When nfsd starts requesting directory delegations, setlease handlers may
> see requests for leases on directories. Push the !S_ISREG check down
> into the non-trivial setlease handlers, so we can selectively enable
> them where they're supported.
> 
> FUSE is special: It's the only filesystem that supports atomic_open and
> allows kernel-internal leases. atomic_open is issued when the VFS
> doesn't know the state of the dentry being opened. If the file doesn't
> exist, it may be created, in which case the dir lease should be broken.
> 
> The existing kernel-internal lease implementation has no provision for
> this. Ensure that we don't allow directory leases by default going
> forward by explicitly disabling them there.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fuse/dir.c          | 1 +
>  fs/locks.c             | 5 +++--
>  fs/nfs/nfs4file.c      | 2 ++
>  fs/smb/client/cifsfs.c | 3 +++
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ecaec0fea3a132e7cbb88121e7db7fb504d57d3c..667774cc72a1d49796f531fcb342d2e4878beb85 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2230,6 +2230,7 @@ static const struct file_operations fuse_dir_operations = {
>  	.fsync		= fuse_dir_fsync,
>  	.unlocked_ioctl	= fuse_dir_ioctl,
>  	.compat_ioctl	= fuse_dir_compat_ioctl,
> +	.setlease	= simple_nosetlease,
>  };
>  
>  static const struct inode_operations fuse_common_inode_operations = {
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e2072461b6e2d3d1cd12f2b089d69a7db3..0b16921fb52e602ea2e0c3de39d9d772af98ba7d 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1929,6 +1929,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
>  int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
>  			void **priv)
>  {
> +	if (!S_ISREG(file_inode(filp)->i_mode))
> +		return -EINVAL;
> +
>  	switch (arg) {
>  	case F_UNLCK:
>  		return generic_delete_lease(filp, *priv);
> @@ -2018,8 +2021,6 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
>  
>  	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
>  		return -EACCES;
> -	if (!S_ISREG(inode->i_mode))
> -		return -EINVAL;
>  	error = security_file_lock(filp, arg);
>  	if (error)
>  		return error;
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 7f43e890d3564a000dab9365048a3e17dc96395c..7317f26892c5782a39660cae87ec1afea24e36c0 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -431,6 +431,8 @@ void nfs42_ssc_unregister_ops(void)
>  static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
>  			 void **priv)
>  {
> +	if (!S_ISREG(file_inode(file)->i_mode))
> +		return -EINVAL;
>  	return nfs4_proc_setlease(file, arg, lease, priv);
>  }
>  
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 4f959f1e08d235071a151c1438c753fcd05099e5..1522c6b61b48c05c93f2bedeab0d35b6d85378e2 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1149,6 +1149,9 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
>  	struct inode *inode = file_inode(file);
>  	struct cifsFileInfo *cfile = file->private_data;
>  
> +	if (!S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
>  	/* Check if file is oplocked if this is request for new lease */
>  	if (arg == F_UNLCK ||
>  	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

