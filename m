Return-Path: <linux-fsdevel+bounces-36275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FF9E0B46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 19:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12E7B26AFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EBD14A611;
	Mon,  2 Dec 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fu8jMINf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VUFXWwgv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fu8jMINf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VUFXWwgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D513AA2D;
	Mon,  2 Dec 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155521; cv=none; b=tsPe8V4CxlEXroPRuKNU6x7+sYgLAtY1YOiIHImGZNHP4nz8Y0K904kuZRk5TMLbbuiVHzUIO6QydAMnVOVY1UYSjIZdpAzCvpJQUTluySwKh5cVLyuUCBbo5Bds81iiX4guAnV85a4x0gdaZZJzOxLB+y9C1+Q0nOqDMsrbWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155521; c=relaxed/simple;
	bh=alzDezs/CQscvuOH1/1W94sLGnZ8zW6tifT7vS4lGY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgNEsNpD+F1U6YSoXJTn1JKuyMfqQNstlTSBneKe1QM1nhxXy12rTjrCUTSkecqSbEKgOvelZa2jLIVQ39D/jHDVkOazSnIIkgW9UvexMwR87V7GZ2B1WJfhNYyyhBkj2GcIP7zJ3BEcuEvob5NUT5JYg9b/TAUZp8opxrhkSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fu8jMINf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VUFXWwgv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fu8jMINf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VUFXWwgv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 279551F442;
	Mon,  2 Dec 2024 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44kF/6gGjH9Gr5UemTK9ZFE1dn4NXKDG6VUmfeKn0nw=;
	b=Fu8jMINfJWjRBOKPmuXM+4zs7q0vptLdbmlCXe6Xvl/NwQp2leAQWTFMjOnCztrlwylYQu
	GZWP6x/ERP/VjgBxO+kj3A38xaHGULgiRLcOjUJiW9U23GTu79kc9UUWAi5OW++H+Cm0po
	Qfi25pDX9rdrij8mPioPhK1EqtStXmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44kF/6gGjH9Gr5UemTK9ZFE1dn4NXKDG6VUmfeKn0nw=;
	b=VUFXWwgvzZeHyt2GeMtbHVX/o3ZfoB86i6+wVkmzi655hr97317ZofBw+B+tDy7kShA7/L
	od0CijsVkR5zm7AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Fu8jMINf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VUFXWwgv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44kF/6gGjH9Gr5UemTK9ZFE1dn4NXKDG6VUmfeKn0nw=;
	b=Fu8jMINfJWjRBOKPmuXM+4zs7q0vptLdbmlCXe6Xvl/NwQp2leAQWTFMjOnCztrlwylYQu
	GZWP6x/ERP/VjgBxO+kj3A38xaHGULgiRLcOjUJiW9U23GTu79kc9UUWAi5OW++H+Cm0po
	Qfi25pDX9rdrij8mPioPhK1EqtStXmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44kF/6gGjH9Gr5UemTK9ZFE1dn4NXKDG6VUmfeKn0nw=;
	b=VUFXWwgvzZeHyt2GeMtbHVX/o3ZfoB86i6+wVkmzi655hr97317ZofBw+B+tDy7kShA7/L
	od0CijsVkR5zm7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CC9B13A31;
	Mon,  2 Dec 2024 16:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id psAEB77aTWcJPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 16:05:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC6B9A07B4; Mon,  2 Dec 2024 17:05:13 +0100 (CET)
Date: Mon, 2 Dec 2024 17:05:13 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] exportfs: add open method
Message-ID: <20241202160513.6lyq3r6s5u2f6kgx@quack3>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <20241129-work-pidfs-file_handle-v1-3-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-file_handle-v1-3-87d803a42495@kernel.org>
X-Rspamd-Queue-Id: 279551F442
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 29-11-24 14:38:02, Christian Brauner wrote:
> This allows filesystems such as pidfs to provide their custom open.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/exportfs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 4cc8801e50e395442f9e3ae69b6c9f04fa590ff9..c69b79b64466d5bc32ffe9b2796a388130fe72d8 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -10,6 +10,7 @@ struct inode;
>  struct iomap;
>  struct super_block;
>  struct vfsmount;
> +struct path;
>  
>  /* limit the handle size to NFSv4 handle size now */
>  #define MAX_HANDLE_SZ 128
> @@ -225,6 +226,9 @@ struct fid {
>   *    is also a directory.  In the event that it cannot be found, or storage
>   *    space cannot be allocated, a %ERR_PTR should be returned.
>   *
> + * open:
> + *    Allow filesystems to specify a custom open function.
> + *
>   * commit_metadata:
>   *    @commit_metadata should commit metadata changes to stable storage.
>   *
> @@ -251,6 +255,7 @@ struct export_operations {
>  			  bool write, u32 *device_generation);
>  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>  			     int nr_iomaps, struct iattr *iattr);
> +	struct file * (*open)(struct path *path, unsigned int oflags);
>  #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
>  #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
>  #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

