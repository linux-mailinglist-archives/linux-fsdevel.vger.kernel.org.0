Return-Path: <linux-fsdevel+bounces-74416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22189D3A266
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00DB13014AE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AB35295B;
	Mon, 19 Jan 2026 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pqm1FT36";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2qBvuQr+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pqm1FT36";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2qBvuQr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF21C3BFC
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813560; cv=none; b=UxnOKVNi1igN4FuAKgStJWtwkC2K/O+JpxTrdX2/Tb2EZqYkiV1kbOshjwcNGe6B83tjHvVWYliVMGcQJrlpLSKHnPzoxgst8+Tj0lj/XTX9GaGV23sP3KF+mcpXXx9HJpmBzH2+TeuXi5EkkqTHxxcXQZ2drsw+ES5T01YBd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813560; c=relaxed/simple;
	bh=Z3MQ82CKvB/0Dcy3eWdwcjOOizGJHCIltkTjKhfKLLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igoW+5igMpx9GAZuwqKyQ3lbK5P5C+xl1rawElout5u9Osa+PgetJMVAOzK1z+HBqeiqVvXDnxVyZMmLWRtQH0Ol5Zo8qTDIrZOVgj7GKNsbA41b9ozYqqZ/ceM6xM6HRK6Jq72yxD8HxbEG4GC9LN5dq0S8B7tRYUmrsnBjD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pqm1FT36; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2qBvuQr+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pqm1FT36; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2qBvuQr+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AAEEB5BD21;
	Mon, 19 Jan 2026 09:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768813556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WV7bGoR2PRO6j4igxWjiYheWWlYULse5GUTsUYL8BDk=;
	b=pqm1FT36/jm6jURdU2bqiIqexQSvOfmfk8LpRJfM36fns+qDwJ+Bg6bgf4NGPPbKGdsi3M
	VtZHH3Td34t18FkNA03XtaX6NgiqhiZdlcj/0XhtZT+6ST64FEImwouEw0TAwBjhBJPR6m
	0wt3rJBWJaZFCUfhi3E6x0PFg/T6nsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768813556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WV7bGoR2PRO6j4igxWjiYheWWlYULse5GUTsUYL8BDk=;
	b=2qBvuQr+goPfaZg7KcDtjGzpWjwhz0o/abKRUT0ku2GkTCi9ZLDZ8J4N+yMb4BZ/jgPkMh
	qozwGmwu1O0GnAAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pqm1FT36;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2qBvuQr+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768813556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WV7bGoR2PRO6j4igxWjiYheWWlYULse5GUTsUYL8BDk=;
	b=pqm1FT36/jm6jURdU2bqiIqexQSvOfmfk8LpRJfM36fns+qDwJ+Bg6bgf4NGPPbKGdsi3M
	VtZHH3Td34t18FkNA03XtaX6NgiqhiZdlcj/0XhtZT+6ST64FEImwouEw0TAwBjhBJPR6m
	0wt3rJBWJaZFCUfhi3E6x0PFg/T6nsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768813556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WV7bGoR2PRO6j4igxWjiYheWWlYULse5GUTsUYL8BDk=;
	b=2qBvuQr+goPfaZg7KcDtjGzpWjwhz0o/abKRUT0ku2GkTCi9ZLDZ8J4N+yMb4BZ/jgPkMh
	qozwGmwu1O0GnAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FB4A3EA63;
	Mon, 19 Jan 2026 09:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MD76JvTzbWnZOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Jan 2026 09:05:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67C91A0A29; Mon, 19 Jan 2026 10:05:56 +0100 (CET)
Date: Mon, 19 Jan 2026 10:05:56 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 3/6] fs,fsverity: handle fsverity in generic_file_open
Message-ID: <tn4evey6q4ktzfu4vd2fmaz5j233cigw2grnyvzc4cnholsolb@z44vyuenknkl>
References: <20260119062250.3998674-1-hch@lst.de>
 <20260119062250.3998674-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119062250.3998674-4-hch@lst.de>
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AAEEB5BD21
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon 19-01-26 07:22:44, Christoph Hellwig wrote:
> Call into fsverity_file_open from generic_file_open instead of requiring
> the file system to handle it explicitly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
...
> -int generic_file_open(struct inode * inode, struct file * filp)
> +int generic_file_open(struct inode *inode, struct file *filp)
>  {
>  	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
>  		return -EOVERFLOW;
> +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> +		if (filp->f_mode & FMODE_WRITE)
> +			return -EPERM;
> +		return fsverity_file_open(inode, filp);
> +	}

Why do you check f_mode here when fsverity_file_open() checks for it as
well?

> -int __fsverity_file_open(struct inode *inode, struct file *filp)
> +/*
> + * When opening a verity file, deny the open if it is for writing.  Otherwise,
> + * set up the inode's verity info if not already done.
> + *
> + * When combined with fscrypt, this must be called after fscrypt_file_open().
> + * Otherwise, we won't have the key set up to decrypt the verity metadata.
> + */
> +int fsverity_file_open(struct inode *inode, struct file *filp)
>  {
>  	if (filp->f_mode & FMODE_WRITE)
>  		return -EPERM;
>  	return ensure_verity_info(inode);
>  }
> -EXPORT_SYMBOL_GPL(__fsverity_file_open);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

