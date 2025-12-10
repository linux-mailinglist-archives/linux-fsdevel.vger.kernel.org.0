Return-Path: <linux-fsdevel+bounces-71048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 618BCCB2A2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 11:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 443D730B5FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13F030AAD7;
	Wed, 10 Dec 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2GcyCylJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NoZvRk/u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SanDXOBk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o4MOEaZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB183090F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361358; cv=none; b=CA3Sa3kPxkjCm8hUIRa5hgZMuEkR6S7HwRK/N8Uctt3UnF6uQtgVr+uZ3LOPMR16zwU0aMiW7mMmjrrK1o871HY4nbhTA9y+6iTcKlMhyvwthTkA7gSI4of9o1BdOYuDuJpFNQK7+VLLY4VuuBxPWC8UlA1VZglP85+a3Dn015Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361358; c=relaxed/simple;
	bh=oArDA34pACnZcGnMLuBgbI8xJ1dW5SOgi3NFNiEyUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXuuRQyud4Fh/X/ZNtmL+JprwCw0sPQ6EEdaiX8VG4wshwDeNTo6hEdrjxuA5EVw1ixBDd+bVXSVSymkyPim0pJuGyW5oafu8yJ+PTIN/ZV/ulxl+4F0v6jncH1pSDN7rZLwsmlJ+pX6dAoHs+EokE50q2RXIriQBHcf7cmrs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2GcyCylJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NoZvRk/u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SanDXOBk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o4MOEaZv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A06233718;
	Wed, 10 Dec 2025 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765361353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z82MqBP6rPYDT4u/WjVEc4Trou0iJQBrYhCn7s3i6Ks=;
	b=2GcyCylJACvAf3QNxSzqKuNaJnlvCwVg2kdU9Hs8LbVtAzlcUNeybpaJs9arrxMG2bGXB4
	PhqVbD7tkzoGxiguQEeWN1xbpgZgsUvVdDsJ9HRH/LiFHo0tRmbhCrRyxn0/df4RBlFuyg
	a0Avl+2DEmoXflQ0250JAsAych8Ox80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765361353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z82MqBP6rPYDT4u/WjVEc4Trou0iJQBrYhCn7s3i6Ks=;
	b=NoZvRk/urH5cTnMH1Oz/BqwGsa7fQzyvKzCbPtWVA793VHL+/surW3bjeH0ZbpP2NisnxF
	dBK+tSn9RldLblCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SanDXOBk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o4MOEaZv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765361352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z82MqBP6rPYDT4u/WjVEc4Trou0iJQBrYhCn7s3i6Ks=;
	b=SanDXOBkKhQqW+rAsM0l47YiQebnJPJ23PzfWVCweqNyZIclzwrLzYhkKa5LR8s3Qaxeu/
	fSJilPofSrUgorVpjm+lAaR7+SuA7t058N18v2VwrI5ersxZulNhg5sOU6su5jvocpQIrg
	GBaaYZcbggL1eh7BFFVJ9oAKFa2mYFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765361352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z82MqBP6rPYDT4u/WjVEc4Trou0iJQBrYhCn7s3i6Ks=;
	b=o4MOEaZv7ilPvMYD5Jasc50OEU1F7kHwrWaOmKgEhbYZIeK4UQqvtcybND8HWmJ7RG8ZCO
	29aFAyUimtN2EJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CB263EA63;
	Wed, 10 Dec 2025 10:09:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DzCUFshGOWkodQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Dec 2025 10:09:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18D6CA0A61; Wed, 10 Dec 2025 11:09:12 +0100 (CET)
Date: Wed, 10 Dec 2025 11:09:12 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>, brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
Message-ID: <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[d222f4b7129379c3d5bc];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,syzkaller.appspotmail.com,kernel.org,suse.cz,evilplan.org,linux.alibaba.com,vger.kernel.org,fasheh.com,lists.linux.dev,samsung.com,googlegroups.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,syzkaller.appspot.com:url,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,i-love.sakura.ne.jp:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 6A06233718
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Wed 10-12-25 18:45:26, Tetsuo Handa wrote:
> syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
> introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
> handling of MAY_EXEC"), for make_bad_inode() is blindly changing file type
> to S_IFREG. Since make_bad_inode() might be called after an inode is fully
> constructed, make_bad_inode() should not needlessly change file type.
> 
> Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

No. make_bad_inode() must not be called once the inode is fully visible
because that can cause all sorts of fun. That function is really only good
for handling a situation when read of an inode from the disk failed or
similar early error paths. It would be great if make_bad_inode() could do
something like:

	VFS_BUG_ON_INODE(!(inode_state_read_once(inode) & I_NEW));

but sadly that is not currently possible because inodes start with i_state
set to 0 and some places do call make_bad_inode() before I_NEW is set in
i_state. Matheusz wanted to clean that up a bit AFAIK.

Until the cleanup is done, perhaps we could add:

	VFS_BUG_ON_INODE(inode->i_dentry->first);

to make_bad_inode() and watch the fireworks from syzbot. But at least the
bugs would be attributed to the place where they are happening.

								Honza

> ---
> Should we implement all callbacks (except get_offset_ctx callback which is
> currently used by only tmpfs which does not call make_bad_inode()) within
> bad_inode_ops, for there might be a callback which is expected to be non-NULL
> for !S_IFREG types? Implementing missing callbacks is good for eliminating
> possibility of NULL function pointer call. Since VFS is using
> 
>     if (!inode->i_op->foo)
>         return error;
>     inode->i_op->foo();
> 
> pattern instead of
> 
>     pFoo = READ_ONCE(inode->i_op->foo)
>     if (!pFoo)
>         return error;
>     pFoo();
> 
> pattern, suddenly replacing "one i_op with i_op->foo != NULL" with "another
> i_op with i_op->foo == NULL" has possibility of NULL pointer function call
> (e.g. https://lkml.kernel.org/r/18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp ).
> If we implement missing callbacks, e.g. vfs_fileattr_get() will start
> calling security_inode_file_getattr() on bad inode, but we can eliminate
> possibility of inode->i_op->fileattr_get == NULL when make_bad_inode() is
> called from security_inode_file_getattr() for some reason.
> 
>  fs/bad_inode.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 0ef9bcb744dd..ff6c2daecd1c 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -207,7 +207,19 @@ void make_bad_inode(struct inode *inode)
>  {
>  	remove_inode_hash(inode);
>  
> -	inode->i_mode = S_IFREG;
> +	switch (inode->i_mode & S_IFMT) {
> +	case S_IFREG:
> +	case S_IFDIR:
> +	case S_IFLNK:
> +	case S_IFCHR:
> +	case S_IFBLK:
> +	case S_IFIFO:
> +	case S_IFSOCK:
> +		inode->i_mode &= S_IFMT;
> +		break;
> +	default:
> +		inode->i_mode = S_IFREG;
> +	}
>  	simple_inode_init_ts(inode);
>  	inode->i_op = &bad_inode_ops;	
>  	inode->i_opflags &= ~IOP_XATTR;
> -- 
> 2.47.3
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

