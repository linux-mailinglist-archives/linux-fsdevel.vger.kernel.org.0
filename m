Return-Path: <linux-fsdevel+bounces-72913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD9ED055C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FEAA31DF703
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102F326D53;
	Thu,  8 Jan 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LKLHZsve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xtHDnGn+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LKLHZsve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xtHDnGn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB12F3C19
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893378; cv=none; b=oAgRqAoEm+IBxIfClxZKPT8OyFBIHwNFjXXUofGHCwoJmrBsctQrqFijex3nt/n+NhPiuwVExJ/uJwZA2d4RrdJRusEEyHtKtHt40m/Atwe84yisMClPdddQgyIat0DQX4mq5yFhCe7aRVEHL83Q7LBLjyTU3ZomVaT5WW7ixD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893378; c=relaxed/simple;
	bh=Y0pfcw49zxMrh3XgUleyy0Ez7ydTSqetA2Cc+nKXVYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5gIUkgA4tO7+j4sSzDQILR17YVwREn2u9P5f9xwXViciRdQFWwxMyHcWd6IAmuKpcYn5LGL5pYKsr8iUCSyNcZT33N5SyJ8V0VN1ujiLbeUD67dUrZgO3phWGQ7bs5D0wmUXRfi2olngG3zKx1vDihOuB4tT2fp9IWsyhHExIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LKLHZsve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xtHDnGn+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LKLHZsve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xtHDnGn+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B7B0346DD;
	Thu,  8 Jan 2026 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSDIIOSgIHhRcbxi9/+AQB/pdbt9dql3OYIFgg84PNM=;
	b=LKLHZsveRqERTai/L93RkI2K84owBSoPVDX4PWwQdZUPnhOhUJ/E2ghFkO7TB3qTeFK4In
	hyXqDZRKe3gPdTEa2pfQUJD9r7JhY2Gxy+QwNxGBAIUcG2XYPrlvQ2GUfH/jDBAwWN0nsL
	ohZmkjATm1kB2ioRc8QTK5suspy3fCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSDIIOSgIHhRcbxi9/+AQB/pdbt9dql3OYIFgg84PNM=;
	b=xtHDnGn+2hOmpYwhvCDVTOBaoIs4Ao1kPHDaKuKZg7EQKiV5T+3VpS+c1qeMoAhoh6KcSh
	BVtoa2RrFhAbRIAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSDIIOSgIHhRcbxi9/+AQB/pdbt9dql3OYIFgg84PNM=;
	b=LKLHZsveRqERTai/L93RkI2K84owBSoPVDX4PWwQdZUPnhOhUJ/E2ghFkO7TB3qTeFK4In
	hyXqDZRKe3gPdTEa2pfQUJD9r7JhY2Gxy+QwNxGBAIUcG2XYPrlvQ2GUfH/jDBAwWN0nsL
	ohZmkjATm1kB2ioRc8QTK5suspy3fCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSDIIOSgIHhRcbxi9/+AQB/pdbt9dql3OYIFgg84PNM=;
	b=xtHDnGn+2hOmpYwhvCDVTOBaoIs4Ao1kPHDaKuKZg7EQKiV5T+3VpS+c1qeMoAhoh6KcSh
	BVtoa2RrFhAbRIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76FDE3EA65;
	Thu,  8 Jan 2026 17:29:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M3oBHX3pX2k0eAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 17:29:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 213A0A0B23; Thu,  8 Jan 2026 18:29:33 +0100 (CET)
Date: Thu, 8 Jan 2026 18:29:33 +0100
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
Subject: Re: [PATCH 20/24] udf: add setlease file operation
Message-ID: <uyibvpewjdnrwrdyby3kr4lq244qjolgoje5bdyzpwjwndhzh6@mgp67jphmu2u>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-20-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-setlease-6-20-v1-20-ea4dec9b67fa@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLwapsqjcu3srfensh8n36bg4p)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 08-01-26 12:13:15, Jeff Layton wrote:
> Add the setlease file_operation pointing to generic_setlease to the udf
> file_operations structures. A future patch will change the default
> behavior to reject lease attempts with -EINVAL when there is no
> setlease file operation defined. Add generic_setlease to retain the
> ability to set leases on this filesystem.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/dir.c  | 2 ++
>  fs/udf/file.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
> index 5023dfe191e8088b78396997a8915bf383f7a2d2..5bf75638f3520ecb3a0a2ade2279ab56787ecd11 100644
> --- a/fs/udf/dir.c
> +++ b/fs/udf/dir.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/string.h>
>  #include <linux/errno.h>
> +#include <linux/filelock.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/bio.h>
> @@ -157,4 +158,5 @@ const struct file_operations udf_dir_operations = {
>  	.iterate_shared		= udf_readdir,
>  	.unlocked_ioctl		= udf_ioctl,
>  	.fsync			= generic_file_fsync,
> +	.setlease		= generic_setlease,
>  };
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 0d76c4f37b3e71ffe6a883a8d97a6c3038d2a01d..32ae7cfd72c549958b70824b449cf146f6750f44 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -28,6 +28,7 @@
>  #include <linux/string.h> /* memset */
>  #include <linux/capability.h>
>  #include <linux/errno.h>
> +#include <linux/filelock.h>
>  #include <linux/pagemap.h>
>  #include <linux/uio.h>
>  
> @@ -208,6 +209,7 @@ const struct file_operations udf_file_operations = {
>  	.splice_read		= filemap_splice_read,
>  	.splice_write		= iter_file_splice_write,
>  	.llseek			= generic_file_llseek,
> +	.setlease		= generic_setlease,
>  };
>  
>  static int udf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> 
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

