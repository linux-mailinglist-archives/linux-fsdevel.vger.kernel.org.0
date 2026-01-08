Return-Path: <linux-fsdevel+bounces-72914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7AD052AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7108031F828C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF06288C3F;
	Thu,  8 Jan 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SjGu8xWF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Wn9HqxA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TrDPHqNz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHn8wQXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84907299948
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893519; cv=none; b=LEWnoUwOAmczOBbDx6G0DtjvAGIGDL6+tl6s+W9Wgk2QjK7/Hadnh4KHLFd6w3byTYPtkxGimd2Qo/RJyE8LFsSzKpGPCiX6J12c3bL9cMHydYvKI2hkA2Y7cLeKWM4kYvnLtVidqyJIc32nB0giWStVGXOhjF/7WSUV+SLZMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893519; c=relaxed/simple;
	bh=KXOKF2CuyUbzsB+FTiaRXQ8fhSj0kiQOhUAT87t16KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cgw1In6KJEn++we8jae2yxPttUucYnnV3+S9qK1EASSCTnsxHEppPmx8KCPPJSZHzcX2gfgR/Bn8UT76sEJ6gnkwrS5rhXRH/D1pL92Ue8YmFTk44CBP7381fInUjGE3LVBkWAQ9atXyQYzAZPdG5QIPFDeMCv3V5cVfH7RPIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SjGu8xWF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Wn9HqxA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TrDPHqNz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHn8wQXB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CACA55CBAA;
	Thu,  8 Jan 2026 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc9QMKouyjzH45LZUhjCbf9iU6kNH1nER3QE4i7JiDM=;
	b=SjGu8xWFvqvPTajUdrve/tkEoODH6+r/GTBr8gpUYcGrmBEYga3xqYG8St2+RFHlLn30ka
	0yohoC73wEYkhvbqwS6GnHxD2oBY4ZvgUnY3vkjJhl1qJIFpoH6YRxl7fWIBVymyiY2YLc
	XrvV8+PtnHJg7Upq20EtygKwXodCegM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc9QMKouyjzH45LZUhjCbf9iU6kNH1nER3QE4i7JiDM=;
	b=2Wn9HqxA7CtfXS7UqvYpfju0o6PArRNvw1XQkBWAeQZIrv+GhiWrKHLx6Q09tcNVGlK0GJ
	JBYqc/CmjqnU7jCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc9QMKouyjzH45LZUhjCbf9iU6kNH1nER3QE4i7JiDM=;
	b=TrDPHqNzriwslUs1c+7umCElSUglJP1N5Zj45yrhcb6NcnNa3QZ5Xc/mz4AwHdFJrQrZ5I
	gnZXsNKVPzgxosuKgeRHqv2JCjP7sUHGP0yoiMJLfOjVfsqd7Szv1HtjxdoIlkHa8j+49C
	+/raVpT9Bb7uw3+ieXjOxGIBzIO8HwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc9QMKouyjzH45LZUhjCbf9iU6kNH1nER3QE4i7JiDM=;
	b=vHn8wQXB1vszOd1f6QtOMrupIQRL10p/S9F5NFMaGecrQrGdhlfSJO4pGhGt3J4bJUSYNF
	CzjlGQiF5MUsfcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7C4D3EA63;
	Thu,  8 Jan 2026 17:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5NrWLArqX2npegAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 17:31:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B7FAA0B23; Thu,  8 Jan 2026 18:31:54 +0100 (CET)
Date: Thu, 8 Jan 2026 18:31:54 +0100
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
Subject: Re: [PATCH 19/24] tmpfs: add setlease file operation
Message-ID: <5dtyb6by4ujjnkjz6lu4rl2x3s5km6awilvrozuzmgq2wn7bl6@cxvq3jpviunf>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-19-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-setlease-6-20-v1-19-ea4dec9b67fa@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	R_RATELIMIT(0.00)[to_ip_from(RLwapsqjcu3srfensh8n36bg4p)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Thu 08-01-26 12:13:14, Jeff Layton wrote:
> Add the setlease file_operation pointing to generic_setlease to the
> tmpfs file_operations structures. A future patch will change the
> default behavior to reject lease attempts with -EINVAL when there is no
> setlease file operation defined. Add generic_setlease to retain the
> ability to set leases on this filesystem.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c | 2 ++
>  mm/shmem.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 591eb649ebbacf202ff48cd3abd64a175daa291c..697c6d5fc12786c036f0086886297fb5cd52ae00 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/blkdev.h>
>  #include <linux/export.h>
> +#include <linux/filelock.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/cred.h>
> @@ -570,6 +571,7 @@ const struct file_operations simple_offset_dir_operations = {
>  	.iterate_shared	= offset_readdir,
>  	.read		= generic_read_dir,
>  	.fsync		= noop_fsync,
> +	.setlease	= generic_setlease,
>  };
>  
>  struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ec6c01378e9d2bd47db9d7506e4d6a565e092185..88ef1fd5cd38efedbb31353da2871ab1d47e68a5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -29,6 +29,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/file.h>
>  #include <linux/fileattr.h>
> +#include <linux/filelock.h>
>  #include <linux/mm.h>
>  #include <linux/random.h>
>  #include <linux/sched/signal.h>
> @@ -5219,6 +5220,7 @@ static const struct file_operations shmem_file_operations = {
>  	.splice_read	= shmem_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= shmem_fallocate,
> +	.setlease	= generic_setlease,
>  #endif
>  };
>  
> 
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

