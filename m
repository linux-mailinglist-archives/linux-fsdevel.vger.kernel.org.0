Return-Path: <linux-fsdevel+bounces-72917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14261D0508E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 231C4303E0E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4642E7BDC;
	Thu,  8 Jan 2026 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yPA12Jp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qq81RSYL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yPA12Jp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qq81RSYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3D2C15AA
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893687; cv=none; b=l1ZwlN+/dAviDr5ayM7rzrS49Wj5V9qW271U7Mn8gDUQc5NqLP6qHoiYyaZz1VN9g3bq+Q3ObKfDdgIzV6En3GHeywi0Mb4pDm1VNbkpPPXCqQeiKckFkStaav2pnCVKTCuYOHcLvGw8pcRmd4l5y3IPUdk4u77MKLfkcXhQFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893687; c=relaxed/simple;
	bh=R9bBp1xdQaviFy8B6Jj3EcaVJ+XL6YnMpUEO+LYdH4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC3WAeFzSKsBQ9Lya8nyVFnnuWas8hUHeqjzyW1JYMDCUsXzxO1JnfpCCotfx2Jk4Naijrxg97rAttfTPoWfpyMXuaPfYaDz7q2+T1gFyEhTiVd2ByRxR+CxAur4o9a9wEQzUb60oY0AmaJ48QOq2zSPwojJ+8V7Zjc/LHIrzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yPA12Jp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qq81RSYL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yPA12Jp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qq81RSYL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87122346F5;
	Thu,  8 Jan 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUc1HNzkDvMEUB9H5lBxhNGfEq+qWRq++O1au4+GYAI=;
	b=0yPA12Jp8JS5heOg95ZBNoDkf204gVcniWsn/fJeC6+fW2zpurpQMGMMkMCfxGVUVMIjgX
	dG04kvPamXGeblro397+b1pImKgAVsakUAf7h2gbihWm5ZUE2Wn69UivcIh4PjOG5M4Thp
	HtBRjSGX7Piz09dZWxAXHUvjuPH/no0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUc1HNzkDvMEUB9H5lBxhNGfEq+qWRq++O1au4+GYAI=;
	b=qq81RSYLs9Cj+wyrsmmCLVvswGxZhveuS0nYUbQFYpr4oMVsUrikb2GO7O4YuWAczj2C5u
	XCWEKFLS+EUOIXDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0yPA12Jp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qq81RSYL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUc1HNzkDvMEUB9H5lBxhNGfEq+qWRq++O1au4+GYAI=;
	b=0yPA12Jp8JS5heOg95ZBNoDkf204gVcniWsn/fJeC6+fW2zpurpQMGMMkMCfxGVUVMIjgX
	dG04kvPamXGeblro397+b1pImKgAVsakUAf7h2gbihWm5ZUE2Wn69UivcIh4PjOG5M4Thp
	HtBRjSGX7Piz09dZWxAXHUvjuPH/no0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUc1HNzkDvMEUB9H5lBxhNGfEq+qWRq++O1au4+GYAI=;
	b=qq81RSYLs9Cj+wyrsmmCLVvswGxZhveuS0nYUbQFYpr4oMVsUrikb2GO7O4YuWAczj2C5u
	XCWEKFLS+EUOIXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D7913EA63;
	Thu,  8 Jan 2026 17:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r/+xGrLqX2lSfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 17:34:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 253C2A0B23; Thu,  8 Jan 2026 18:34:42 +0100 (CET)
Date: Thu, 8 Jan 2026 18:34:42 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH 24/24] fs: remove simple_nosetlease()
Message-ID: <46yafpkezaxdv4jvw2lqdmisfzxqjuxml4x53cl3egpza7opjb@zahika34s67e>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-24-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-setlease-6-20-v1-24-ea4dec9b67fa@kernel.org>
X-Spam-Score: -2.51
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_GT_50(0.00)[86];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RL69z8khd5z6hpuq3c6dg5xrb8)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 87122346F5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu 08-01-26 12:13:19, Jeff Layton wrote:
> Setting ->setlease() to a NULL pointer now has the same effect as
> setting it to simple_nosetlease(). Remove all of the setlease
> file_operations that are set to simple_nosetlease, and the function
> itself.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/9p/vfs_dir.c        |  2 --
>  fs/9p/vfs_file.c       |  2 --
>  fs/ceph/dir.c          |  2 --
>  fs/ceph/file.c         |  1 -
>  fs/fuse/dir.c          |  1 -
>  fs/gfs2/file.c         |  2 --
>  fs/libfs.c             | 18 ------------------
>  fs/nfs/dir.c           |  1 -
>  fs/nfs/file.c          |  1 -
>  fs/smb/client/cifsfs.c |  1 -
>  fs/vboxsf/dir.c        |  1 -
>  fs/vboxsf/file.c       |  1 -
>  include/linux/fs.h     |  1 -
>  13 files changed, 34 deletions(-)
> 
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index af7f72abbb76aaff934b80d4002f32e3b0d17b6d..e0d34e4e9076e3b1a6c5ed07a3e009a50c9fa2a9 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -242,7 +242,6 @@ const struct file_operations v9fs_dir_operations = {
>  	.iterate_shared = v9fs_dir_readdir,
>  	.open = v9fs_file_open,
>  	.release = v9fs_dir_release,
> -	.setlease = simple_nosetlease,
>  };
>  
>  const struct file_operations v9fs_dir_operations_dotl = {
> @@ -252,5 +251,4 @@ const struct file_operations v9fs_dir_operations_dotl = {
>  	.open = v9fs_file_open,
>  	.release = v9fs_dir_release,
>  	.fsync = v9fs_file_fsync_dotl,
> -	.setlease = simple_nosetlease,
>  };
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 6f3880208587e39d965dcd4b4280a2079a36b4a2..c5e73c37baea55394294b939fdda7170db8503c0 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -517,7 +517,6 @@ const struct file_operations v9fs_file_operations = {
>  	.splice_read = v9fs_file_splice_read,
>  	.splice_write = iter_file_splice_write,
>  	.fsync = v9fs_file_fsync,
> -	.setlease = simple_nosetlease,
>  };
>  
>  const struct file_operations v9fs_file_operations_dotl = {
> @@ -532,5 +531,4 @@ const struct file_operations v9fs_file_operations_dotl = {
>  	.splice_read = v9fs_file_splice_read,
>  	.splice_write = iter_file_splice_write,
>  	.fsync = v9fs_file_fsync_dotl,
> -	.setlease = simple_nosetlease,
>  };
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 804588524cd570078ba59bf38d2460950ca67daf..86d7aa594ea99335af3e91a95c0a418fdc1b8a8a 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -2214,7 +2214,6 @@ const struct file_operations ceph_dir_fops = {
>  	.fsync = ceph_fsync,
>  	.lock = ceph_lock,
>  	.flock = ceph_flock,
> -	.setlease = simple_nosetlease,
>  };
>  
>  const struct file_operations ceph_snapdir_fops = {
> @@ -2222,7 +2221,6 @@ const struct file_operations ceph_snapdir_fops = {
>  	.llseek = ceph_dir_llseek,
>  	.open = ceph_open,
>  	.release = ceph_release,
> -	.setlease = simple_nosetlease,
>  };
>  
>  const struct inode_operations ceph_dir_iops = {
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 983390069f737254e8c7bcad1718f375499f443e..31b691b2aea21f04c6d6c9aacbfd664c13a3ef64 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -3169,7 +3169,6 @@ const struct file_operations ceph_file_fops = {
>  	.mmap_prepare = ceph_mmap_prepare,
>  	.fsync = ceph_fsync,
>  	.lock = ceph_lock,
> -	.setlease = simple_nosetlease,
>  	.flock = ceph_flock,
>  	.splice_read = ceph_splice_read,
>  	.splice_write = iter_file_splice_write,
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4b6b3d2758ff225dc389016017753b09fadff9d1..d6ee2d38fc2dad5c0995b62dd589e7a46d18424d 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2421,7 +2421,6 @@ static const struct file_operations fuse_dir_operations = {
>  	.fsync		= fuse_dir_fsync,
>  	.unlocked_ioctl	= fuse_dir_ioctl,
>  	.compat_ioctl	= fuse_dir_compat_ioctl,
> -	.setlease	= simple_nosetlease,
>  };
>  
>  static const struct inode_operations fuse_common_inode_operations = {
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 6daa96d815e1e30f099938543a0ed19aa90c720c..3e061e8115ece08c7cb6594b8adb653ccec998ed 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1593,7 +1593,6 @@ const struct file_operations gfs2_file_fops = {
>  	.flock		= gfs2_flock,
>  	.splice_read	= copy_splice_read,
>  	.splice_write	= gfs2_file_splice_write,
> -	.setlease	= simple_nosetlease,
>  	.fallocate	= gfs2_fallocate,
>  	.fop_flags	= FOP_ASYNC_LOCK,
>  };
> @@ -1608,7 +1607,6 @@ const struct file_operations gfs2_dir_fops = {
>  	.lock		= gfs2_lock,
>  	.flock		= gfs2_flock,
>  	.llseek		= default_llseek,
> -	.setlease	= simple_nosetlease,
>  	.fop_flags	= FOP_ASYNC_LOCK,
>  };
>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 697c6d5fc12786c036f0086886297fb5cd52ae00..f1860dff86f2703266beecf31e9d2667af7a9684 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1699,24 +1699,6 @@ struct inode *alloc_anon_inode(struct super_block *s)
>  }
>  EXPORT_SYMBOL(alloc_anon_inode);
>  
> -/**
> - * simple_nosetlease - generic helper for prohibiting leases
> - * @filp: file pointer
> - * @arg: type of lease to obtain
> - * @flp: new lease supplied for insertion
> - * @priv: private data for lm_setup operation
> - *
> - * Generic helper for filesystems that do not wish to allow leases to be set.
> - * All arguments are ignored and it just returns -EINVAL.
> - */
> -int
> -simple_nosetlease(struct file *filp, int arg, struct file_lease **flp,
> -		  void **priv)
> -{
> -	return -EINVAL;
> -}
> -EXPORT_SYMBOL(simple_nosetlease);
> -
>  /**
>   * simple_get_link - generic helper to get the target of "fast" symlinks
>   * @dentry: not used here
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 71df279febf797880ded19e45528c3df4cea2dde..23a78a742b619dea8b76ddf28f4f59a1c8a015e2 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -66,7 +66,6 @@ const struct file_operations nfs_dir_operations = {
>  	.open		= nfs_opendir,
>  	.release	= nfs_closedir,
>  	.fsync		= nfs_fsync_dir,
> -	.setlease	= simple_nosetlease,
>  };
>  
>  const struct address_space_operations nfs_dir_aops = {
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index d020aab40c64ebda30d130b6acee1b9194621457..9d269561961825f88529551b0f0287920960ac62 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -962,7 +962,6 @@ const struct file_operations nfs_file_operations = {
>  	.splice_read	= nfs_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.check_flags	= nfs_check_flags,
> -	.setlease	= simple_nosetlease,
>  	.fop_flags	= FOP_DONTCACHE,
>  };
>  EXPORT_SYMBOL_GPL(nfs_file_operations);
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index a3dc7cb1ab541d35c2e43eefb7a2d2d23ad88bb3..8015df1f711e150a0afb44875899435303d9d406 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1709,7 +1709,6 @@ const struct file_operations cifs_dir_ops = {
>  	.remap_file_range = cifs_remap_file_range,
>  	.llseek = generic_file_llseek,
>  	.fsync = cifs_dir_fsync,
> -	.setlease = simple_nosetlease,
>  };
>  
>  static void
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index 230d7589d15cc98f6bc7e930ba40ca5f7dbf7e18..42bedc4ec7af7709c564a7174805d185ce86f854 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -186,7 +186,6 @@ const struct file_operations vboxsf_dir_fops = {
>  	.release = vboxsf_dir_release,
>  	.read = generic_read_dir,
>  	.llseek = generic_file_llseek,
> -	.setlease = simple_nosetlease,
>  };
>  
>  /*
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 4bebd947314a796365728b3af1c46b0d7070abc1..111752010edb2ba48ee1fdf0e3729369c6521ee8 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -218,7 +218,6 @@ const struct file_operations vboxsf_reg_fops = {
>  	.release = vboxsf_file_release,
>  	.fsync = noop_fsync,
>  	.splice_read = filemap_splice_read,
> -	.setlease = simple_nosetlease,
>  };
>  
>  const struct inode_operations vboxsf_reg_iops = {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f5c9cf28c4dcf9ec648f0fc4f3f4bb44d1b1c482..e46e8aad9339357f99c40eede8ca7b6b727284fe 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3217,7 +3217,6 @@ extern int always_delete_dentry(const struct dentry *);
>  extern struct inode *alloc_anon_inode(struct super_block *);
>  struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
>  					   const struct inode *context_inode);
> -extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
>  
>  extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
>  extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
> 
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

