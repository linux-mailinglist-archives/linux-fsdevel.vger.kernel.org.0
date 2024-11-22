Return-Path: <linux-fsdevel+bounces-35568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B925E9D5E62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793582823A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B281CCB50;
	Fri, 22 Nov 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vq8j0YBG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mG2nPwLL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vq8j0YBG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mG2nPwLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAC1DE3DE;
	Fri, 22 Nov 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276254; cv=none; b=my2P3aMR0Rr7uyKZy8kzy14ek/mXo2HJ83iK9BmhZpB0AU5IQQONmUhRfsIFNkaJnwwYvRwUfL6WyulXoooohnslOVY+6LTp9IoZprUAGaEU1G9x6MGxP96fjpT2JKvntWfStTOejstbXyHYHVVMMFRpDNkK2kw6bu6Z69v66Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276254; c=relaxed/simple;
	bh=46YuAdYTa54L9lzoosFwe+UOpZiJ6UxxcaMH4kPOvZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2E/rIw3LdzABfZF87GloNIJVDANJnpImmDEIeyLlsDKplV8WQkcqlInOu1a6nlH972jYBFHznMw4gty4n1bYab10uu/6C0G8dxpuUG9ZTfkGGsnZ19gjStLIeR6ifwvwS0Z7DsTUVYZR3cbflf+TvbBlQH4KADUc3obO/Vsavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vq8j0YBG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mG2nPwLL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vq8j0YBG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mG2nPwLL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0DC1211F9;
	Fri, 22 Nov 2024 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732276250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNi5I7reiPlqqHt5gbVXCwATFjkyHB+xhF8Ivt2H0g=;
	b=Vq8j0YBGYZ94c7t2HaLJWJQAH1ygfRDlnoej4U3atMYH71rTeyRJADuUaH6fXcmyfV7Y/i
	3WBUDyjBb5VjPm/qAbto8FGygjolvZUchHeSl8Ks7WoWJEPtMb3hWJgsI3m5te0gDuqLFs
	RcG4be4ayrGX7UJRf9svW9kGlxk6K38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732276250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNi5I7reiPlqqHt5gbVXCwATFjkyHB+xhF8Ivt2H0g=;
	b=mG2nPwLLFBfHpUzlZWPYZznOFgT+uYSYV4URwy6w+17zlFSQWKGQMnkUtdrtGs1SL+NPXh
	Hsub4QHN2GpOYiAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Vq8j0YBG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mG2nPwLL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732276250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNi5I7reiPlqqHt5gbVXCwATFjkyHB+xhF8Ivt2H0g=;
	b=Vq8j0YBGYZ94c7t2HaLJWJQAH1ygfRDlnoej4U3atMYH71rTeyRJADuUaH6fXcmyfV7Y/i
	3WBUDyjBb5VjPm/qAbto8FGygjolvZUchHeSl8Ks7WoWJEPtMb3hWJgsI3m5te0gDuqLFs
	RcG4be4ayrGX7UJRf9svW9kGlxk6K38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732276250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtNi5I7reiPlqqHt5gbVXCwATFjkyHB+xhF8Ivt2H0g=;
	b=mG2nPwLLFBfHpUzlZWPYZznOFgT+uYSYV4URwy6w+17zlFSQWKGQMnkUtdrtGs1SL+NPXh
	Hsub4QHN2GpOYiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8012A13998;
	Fri, 22 Nov 2024 11:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5go/HxpwQGcSOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Nov 2024 11:50:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2BF09A08B5; Fri, 22 Nov 2024 12:50:50 +0100 (CET)
Date: Fri, 22 Nov 2024 12:50:50 +0100
From: Jan Kara <jack@suse.cz>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: viro@zeniv.linux.org.uk, almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V4] fs/ntfs3: check if the inode is bad before creating
 symlink
Message-ID: <20241122115050.7i3eslwb77tee37j@quack3>
References: <20241122074952.1585521-1-lizhi.xu@windriver.com>
 <20241122081025.1661161-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122081025.1661161-1-lizhi.xu@windriver.com>
X-Rspamd-Queue-Id: A0DC1211F9
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[73d8fc29ec7cba8286fa];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,windriver.com:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Fri 22-11-24 16:10:25, Lizhi Xu wrote:
> syzbot reported a null-ptr-deref in pick_link. [1]
> 
> First, i_link and i_dir_seq are in the same union, they share the same memory
> address, and i_dir_seq will be updated during the execution of walk_component,
> which makes the value of i_link equal to i_dir_seq.
> 
> Secondly, the chmod execution failed, which resulted in setting the mode value
> of file0's inode to REG when executing ntfs_bad_inode.
> 
> Third, during the execution of the link command, it sets the inode of the
> symlink file to the already bad inode of file0 by calling d_instantiate, which
> ultimately leads to null-ptr-deref when performing a mount operation on the
> symbolic link bus because it use bad inode's i_link and its value is equal to
> i_dir_seq=2. 
> 
> Note: ("file0, bus" are defined in reproducer [2])
> 
> To avoid null-ptr-deref in pick_link, when creating a symbolic link, first check
> whether the inode of file is already bad.

So actually there's no symbolic link involved here at all (which what was
confusing me all the time).

> move_mount(0xffffffffffffff9c, &(0x7f00000003c0)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000400)='./file0/file0\x00', 0x140)
> chmod(&(0x7f0000000080)='./file0\x00', 0x0)
> link(&(0x7f0000000200)='./file0\x00', &(0x7f0000000240)='./bus\x00')
> mount$overlay(0x0, &(0x7f00000000c0)='./bus\x00', 0x0, 0x0, 0x0)

This creates only a hardlink. And in fact the creation of the link seems to
be totally irrelevant for this problem. I believe:

move_mount(0xffffffffffffff9c, &(0x7f00000003c0)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000400)='./file0/file0\x00', 0x140)
chmod(&(0x7f0000000080)='./file0\x00', 0x0)
mount$overlay(0x0, &(0x7f00000000c0)='./file0\x00', 0x0, 0x0, 0x0)

would be as good reproducer of the problem. The core of the problem is that
NTFS3 calls make_bad_inode() on inode that is accessible to userspace and
is something else than a regular file. As long as that happens, some
variant of this NULL-ptr-dereference can happen as well, just the
reproducers will be somewhat different.

So I don't think patching ntfs_link_inode() makes a lot of sense. If
anything, I'd patch NTFS3 to not mark the inode as bad somewhere inside
ntfs_setattr() and deal with the error in a better way.

								Honza

> 
> Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=73d8fc29ec7cba8286fa
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 --> V2: add the root cause of the i_link not set issue and imporve the check
> V2 --> V3: when creating a symbolic link, first check whether the inode of file is bad.
> V3 --> V4: add comments for symlink use bad inode, it is the root cause
> 
>  fs/ntfs3/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index be04d2845bb7..fefbdcf75016 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1719,6 +1719,9 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
>  	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
>  	struct NTFS_DE *de;
>  
> +	if (is_bad_inode(inode))
> +		return -EIO;
> +
>  	/* Allocate PATH_MAX bytes. */
>  	de = __getname();
>  	if (!de)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

