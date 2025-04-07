Return-Path: <linux-fsdevel+bounces-45875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4887A7E0BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69853B00B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB661CAA82;
	Mon,  7 Apr 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3X7wvZNe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ipiO99Sj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3X7wvZNe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ipiO99Sj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB71C32EA
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034706; cv=none; b=TKEIboehALP5vMp7jS5QQUBEa02H/b6FPbD/gF+ex0oHYqC0IzwbNG/b48/e6MG8NXLnIxlleFMaSSozwZYt6pz1fXlcFYS3mYBTxm/XNZ4G09zQYgD9cdGM6Gr0whtCDObXqONsftwKH+0MNM2wNDfG+cKYWfUM/gPvd8TpF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034706; c=relaxed/simple;
	bh=p9hBjtbzD+WLpfbHMqWsjVdEPBOKf6YM4zJPUMR+c9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALLh+hT5pSUUhBAlKfymEpWjdxNAJCHBwlZmSJ50YjlvOC+2ChKIfZgxOwzvDKFYKVwDUKDlDU607MLVQ864X0F8VTVskCilf18q9w0y7AUoZESzCZv7ZXiTBOvPD9q3rWPQuy8RU++R4zkSQ41m/eYa2t7ZW9HEjkrimuugzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3X7wvZNe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ipiO99Sj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3X7wvZNe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ipiO99Sj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B24401F388;
	Mon,  7 Apr 2025 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Oe8DnpIkDHiQzb7eHmiOCMgQ4subawKFXxR+/74zSg=;
	b=3X7wvZNe0ROy6Ga3l/LLZc/c4jIYw7LKhpQhHhVhAM19+uohUqtM3jD8mT7PxoxXhMBqUw
	31FZpdYiS0qEdZZXoKtDTDD5HnqmbUeFZ3tx1Zi0V/eszpDDOBfVJiF/bqV59sJ+mQuUG7
	nuV5D4BiH4btbjy9Xj3scG0ZYDFdL1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Oe8DnpIkDHiQzb7eHmiOCMgQ4subawKFXxR+/74zSg=;
	b=ipiO99SjlKV2J3kTndM6TNEQi0vCgkj+enb3xpYudxVmwhpUL55VXHE5uhMr0//lu5ubvZ
	f/T2aPwCTZ6GcuBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3X7wvZNe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ipiO99Sj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Oe8DnpIkDHiQzb7eHmiOCMgQ4subawKFXxR+/74zSg=;
	b=3X7wvZNe0ROy6Ga3l/LLZc/c4jIYw7LKhpQhHhVhAM19+uohUqtM3jD8mT7PxoxXhMBqUw
	31FZpdYiS0qEdZZXoKtDTDD5HnqmbUeFZ3tx1Zi0V/eszpDDOBfVJiF/bqV59sJ+mQuUG7
	nuV5D4BiH4btbjy9Xj3scG0ZYDFdL1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Oe8DnpIkDHiQzb7eHmiOCMgQ4subawKFXxR+/74zSg=;
	b=ipiO99SjlKV2J3kTndM6TNEQi0vCgkj+enb3xpYudxVmwhpUL55VXHE5uhMr0//lu5ubvZ
	f/T2aPwCTZ6GcuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A735D13A4B;
	Mon,  7 Apr 2025 14:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6B3SKI7b82ceIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:05:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C0E1A08D2; Mon,  7 Apr 2025 16:04:54 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:04:54 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/9] pidfs: use anon_inode_getattr()
Message-ID: <c2tjrnce7jcgqi6bhw6ymtlvotoxhc2dsy4pld74ngh6rvclsw@63xmncl33vkm>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-2-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-2-53a44c20d44e@kernel.org>
X-Rspamd-Queue-Id: B24401F388
X-Spam-Score: -2.51
X-Rspamd-Action: no action
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 11:54:16, Christian Brauner wrote:
> So far pidfs did use it's own version. Just use the generic version. We
> use our own wrappers because we're going to be implementing our own
> retrieval properties soon.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index d64a4cbeb0da..809c3393b6a3 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -572,33 +572,11 @@ static int pidfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return -EOPNOTSUPP;
>  }
>  
> -
> -/*
> - * User space expects pidfs inodes to have no file type in st_mode.
> - *
> - * In particular, 'lsof' has this legacy logic:
> - *
> - *	type = s->st_mode & S_IFMT;
> - *	switch (type) {
> - *	  ...
> - *	case 0:
> - *		if (!strcmp(p, "anon_inode"))
> - *			Lf->ntype = Ntype = N_ANON_INODE;
> - *
> - * to detect our old anon_inode logic.
> - *
> - * Rather than mess with our internal sane inode data, just fix it
> - * up here in getattr() by masking off the format bits.
> - */
>  static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  			 struct kstat *stat, u32 request_mask,
>  			 unsigned int query_flags)
>  {
> -	struct inode *inode = d_inode(path->dentry);
> -
> -	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> -	stat->mode &= ~S_IFMT;
> -	return 0;
> +	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
>  }
>  
>  static const struct inode_operations pidfs_inode_operations = {
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

