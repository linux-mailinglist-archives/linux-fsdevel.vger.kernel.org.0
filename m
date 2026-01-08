Return-Path: <linux-fsdevel+bounces-72916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 936BCD05047
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F5E53016FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B892EA754;
	Thu,  8 Jan 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v/EZdGIT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThMGOBot";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v/EZdGIT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThMGOBot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5452D593E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893663; cv=none; b=QRX0glZ/LIpKhqtIJ190Q4VMZLubSMf6KciB6/FXYkf8s2rRxGmlrnqD2V+tAdhUgC/tRtNh3XHuHzM7SZUMvCXEOQFYFuUzqN5Bi9K+hrzM/LWj51oMwEbi3qMF7O8H9mW2Q1YiZcwQIKwamdzsdXvWy97ghiclmW+Hik/MLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893663; c=relaxed/simple;
	bh=sw6GX7rvICO2BQ+m5lYz6cODqa74MyQfhHREClxoR8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+1BPzU5RdjcafFhestsdFwilLhmqmnGIupI9mPqIzv5u8AEQEDMy2oQXd3I+6qKDOSIrmsEXUtraDSXPEpR5jp8oFokMZ9UwvtWDhPnd/P5CNfq2j4icRqjkDGx9CSz1UxzpJ4J6VdzMG/zQFqZ9nvGIJP1sT9+as/X5DNdzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v/EZdGIT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThMGOBot; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v/EZdGIT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThMGOBot; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35D805CBBF;
	Thu,  8 Jan 2026 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+CPMws/FnGYdGWk6ohH7U7LIk13uVJdlWREsvgP22k=;
	b=v/EZdGITitw8CsQiMuaGfXbUwWWx8X5TD/YRa/XZZpZ68ngQ9xwJ0IIhpHdhcnkJ73fsRf
	p+mufimcDsVx7itgUk6q88o1BMvGZdhe3E1n/AChQ7pU+p1eYtiCRpkctujSCJSu5bivTP
	E3j+OIjCP6YUECLftS1PCmGaQtp0d/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+CPMws/FnGYdGWk6ohH7U7LIk13uVJdlWREsvgP22k=;
	b=ThMGOBotWNLGznhXYptjblJw1E5rrD2imFij6R6Qug5s3TyXHn8Vw/C9Wgt+x5X6XILeTi
	WJvEzDPbx8aSLDBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767893658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+CPMws/FnGYdGWk6ohH7U7LIk13uVJdlWREsvgP22k=;
	b=v/EZdGITitw8CsQiMuaGfXbUwWWx8X5TD/YRa/XZZpZ68ngQ9xwJ0IIhpHdhcnkJ73fsRf
	p+mufimcDsVx7itgUk6q88o1BMvGZdhe3E1n/AChQ7pU+p1eYtiCRpkctujSCJSu5bivTP
	E3j+OIjCP6YUECLftS1PCmGaQtp0d/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767893658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+CPMws/FnGYdGWk6ohH7U7LIk13uVJdlWREsvgP22k=;
	b=ThMGOBotWNLGznhXYptjblJw1E5rrD2imFij6R6Qug5s3TyXHn8Vw/C9Wgt+x5X6XILeTi
	WJvEzDPbx8aSLDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 214E83EA65;
	Thu,  8 Jan 2026 17:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4jgcCJrqX2kmfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 17:34:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C390EA0B23; Thu,  8 Jan 2026 18:34:13 +0100 (CET)
Date: Thu, 8 Jan 2026 18:34:13 +0100
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
Subject: Re: [PATCH 23/24] filelock: default to returning -EINVAL when
 ->setlease operation is NULL
Message-ID: <j3qkk6xh6q76uorxfrqfp5gubc44qe6d3gqeshb55yxi3miexu@udfpls76gitt>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-23-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-setlease-6-20-v1-23-ea4dec9b67fa@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 08-01-26 12:13:18, Jeff Layton wrote:
> Now that most filesystems where we expect to need lease support have
> their ->setlease() operations explicitly set, change kernel_setlease()
> to return -EINVAL when the setlease is a NULL pointer.
> 
> Also update the Documentation/ with info about this change.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/porting.rst | 9 +++++++++
>  Documentation/filesystems/vfs.rst     | 9 ++++++---
>  fs/locks.c                            | 3 +--
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 3397937ed838e5e7dfacc6379a9d71481cc30914..c0f7103628ab5ed70d142a5c7f6d95ca4734c741 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1334,3 +1334,12 @@ end_creating() and the parent will be unlocked precisely when necessary.
>  
>  kill_litter_super() is gone; convert to DCACHE_PERSISTENT use (as all
>  in-tree filesystems have done).
> +
> +---
> +
> +**mandatory**
> +
> +The ->setlease() file_operation must now be explicitly set in order to provide
> +support for leases. When set to NULL, the kernel will now return -EINVAL to
> +attempts to set a lease. Filesystems that wish to use the kernel-internal lease
> +implementation should set it to generic_setlease().
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 670ba66b60e4964927164a57e68adc0edfc681ee..21dc8921dd9ebedeafc4c108de7327f172138b6e 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1180,9 +1180,12 @@ otherwise noted.
>  	method is used by the splice(2) system call
>  
>  ``setlease``
> -	called by the VFS to set or release a file lock lease.  setlease
> -	implementations should call generic_setlease to record or remove
> -	the lease in the inode after setting it.
> +	called by the VFS to set or release a file lock lease.  Local
> +	filesystems that wish to use the kernel-internal lease implementation
> +	should set this to generic_setlease(). Other setlease implementations
> +	should call generic_setlease() to record or remove the lease in the inode
> +	after setting it. When set to NULL, attempts to set or remove a lease will
> +	return -EINVAL.
>  
>  ``fallocate``
>  	called by the VFS to preallocate blocks or punch a hole.
> diff --git a/fs/locks.c b/fs/locks.c
> index e2036aa4bd3734be415296f9157d8f17166878aa..ea38a18f373c2202ba79e8e37125f8d32a0e2d42 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2016,8 +2016,7 @@ kernel_setlease(struct file *filp, int arg, struct file_lease **lease, void **pr
>  		setlease_notifier(arg, *lease);
>  	if (filp->f_op->setlease)
>  		return filp->f_op->setlease(filp, arg, lease, priv);
> -	else
> -		return generic_setlease(filp, arg, lease, priv);
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(kernel_setlease);
>  
> 
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

