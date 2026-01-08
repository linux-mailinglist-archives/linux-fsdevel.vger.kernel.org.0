Return-Path: <linux-fsdevel+bounces-72911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818AD05178
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C1593034F3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52EF3033C9;
	Thu,  8 Jan 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgM0qTCX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7I3Psqn1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgM0qTCX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7I3Psqn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6C2FF14C
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893314; cv=none; b=WDdofA01tjEJ3nRXqz6UR5nQzzihm/SM0GaUDFNmXJH17fjZuXqWZa8I8f7uysfDeJfzsBta7SNqwDBaIG2os0ImiAczzO2m8Q0Yml7J8792tulir0bBPTNwLua5dSaQ1UOGsvowhAk92byU85q+7BS9mhG+qXgRDEby7yvajNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893314; c=relaxed/simple;
	bh=3/TfIJFj0fSL1UQdwuJ/ICKIid51hUCzdXiPT2VVfNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga/ZaADxLSr0PIKRh+DO01INZ/20/A7MOyZvaeSqHmicxRBqj85LnHNuLh2XYdGFxoR3sNtatvs8fTB5DGMA5h56yUtAAABYBvlLgMJJF2vthNORD/Cc89Hj6CsTQFcs8AgxVJ34HsEU/IcGaKUd9T6fLwtpyf8+/vLQVJgVl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgM0qTCX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7I3Psqn1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgM0qTCX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7I3Psqn1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29F5E346CE;
	Thu,  8 Jan 2026 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZmRq1jobUO8YamiQvtoLSiP3S45TLaZihc+2opPu78=;
	b=PgM0qTCXZ2X5Z3hkK3jtzjZOvDMZLm/E4JYhqQ6em+5IaD4UT31FECDXudaGiS5xM4DJ0y
	CjQygviac/9t0aQvin8JilOeYO3xwSNnNhPdm0cnkvbpJgP68yJhD2J3X6sGHvKGWvyaXj
	1+h9HLpBlNo8eR3zYHP8X4pAMSGnU84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZmRq1jobUO8YamiQvtoLSiP3S45TLaZihc+2opPu78=;
	b=7I3Psqn1KNPxXCXm9PcU1P3QCaLnWDhGBG6oy6mEBBHZkBtmbJGI/TRrEDw+5SLm4knqEo
	+ceMclR97Y1K14AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PgM0qTCX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7I3Psqn1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZmRq1jobUO8YamiQvtoLSiP3S45TLaZihc+2opPu78=;
	b=PgM0qTCXZ2X5Z3hkK3jtzjZOvDMZLm/E4JYhqQ6em+5IaD4UT31FECDXudaGiS5xM4DJ0y
	CjQygviac/9t0aQvin8JilOeYO3xwSNnNhPdm0cnkvbpJgP68yJhD2J3X6sGHvKGWvyaXj
	1+h9HLpBlNo8eR3zYHP8X4pAMSGnU84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZmRq1jobUO8YamiQvtoLSiP3S45TLaZihc+2opPu78=;
	b=7I3Psqn1KNPxXCXm9PcU1P3QCaLnWDhGBG6oy6mEBBHZkBtmbJGI/TRrEDw+5SLm4knqEo
	+ceMclR97Y1K14AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B7013EA63;
	Thu,  8 Jan 2026 17:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z9uuBjzpX2lkdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 17:28:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D507AA0B23; Thu,  8 Jan 2026 18:28:27 +0100 (CET)
Date: Thu, 8 Jan 2026 18:28:27 +0100
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
Subject: Re: [PATCH 06/24] ext4: add setlease file operation
Message-ID: <4vqji2aypves2bafiyxtpw442nxzhbipvayyl3jky6uogdks6s@l6tfwl272v7e>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-6-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-setlease-6-20-v1-6-ea4dec9b67fa@kernel.org>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[86];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL69z8khd5z6hpuq3c6dg5xrb8)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 29F5E346CE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu 08-01-26 12:13:01, Jeff Layton wrote:
> Add the setlease file_operation to ext4_file_operations and
> ext4_dir_operations, pointing to generic_setlease.  A future patch will
> change the default behavior to reject lease attempts with -EINVAL when
> there is no setlease file operation defined. Add generic_setlease to
> retain the ability to set leases on this filesystem.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/dir.c  | 2 ++
>  fs/ext4/file.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 256fe2c1d4c1619eb2cd915d8b6b05bce72656e7..00c4b3c82b6534790962dc3964c0c557162b6dff 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/buffer_head.h>
> +#include <linux/filelock.h>
>  #include <linux/slab.h>
>  #include <linux/iversion.h>
>  #include <linux/unicode.h>
> @@ -690,4 +691,5 @@ const struct file_operations ext4_dir_operations = {
>  #endif
>  	.fsync		= ext4_sync_file,
>  	.release	= ext4_release_dir,
> +	.setlease	= generic_setlease,
>  };
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b3093218921f26a7f8962f94739ba49431230..534cf864101f8d1e5f4106b61c0580c858bc0e27 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -25,6 +25,7 @@
>  #include <linux/mount.h>
>  #include <linux/path.h>
>  #include <linux/dax.h>
> +#include <linux/filelock.h>
>  #include <linux/quotaops.h>
>  #include <linux/pagevec.h>
>  #include <linux/uio.h>
> @@ -980,6 +981,7 @@ const struct file_operations ext4_file_operations = {
>  	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
>  			  FOP_DIO_PARALLEL_WRITE |
>  			  FOP_DONTCACHE,
> +	.setlease	= generic_setlease,
>  };
>  
>  const struct inode_operations ext4_file_inode_operations = {
> 
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

