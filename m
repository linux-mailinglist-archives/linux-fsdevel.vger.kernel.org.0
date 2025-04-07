Return-Path: <linux-fsdevel+bounces-45878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269D1A7E0C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C791890D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39C1C6889;
	Mon,  7 Apr 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWhcUxeV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDwp5uSE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWhcUxeV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDwp5uSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A31C5D78
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034874; cv=none; b=o6HdCQFIA2FKz24Z/GlUZ8kOpu/4e7CEFj3kjn3TnBrshcmJ1MO2kqsrDmT9wFILO1qe6rLTzEnbRceYDVCYzb++ndzsq3o8AMFkHFNeGKI5UBg94gdKdhPlvCRgrKU66+ESKTtcuyEAIzB8lNUG4aLAECaqfJuJHcXk89Uks88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034874; c=relaxed/simple;
	bh=G6lB0jpg+STljZw31DaU8/U1ZSRLTDbdpJD2hXqyOe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH6oYqyMJ8k6HNhKJijDeq139g83s1SzzPHgTumCHifRLwVeur0u4toaWGFXCA9aFKBETJuiNlmacUowl8aEJl7V/EJLgkrxREd2IlxUnzOt4EO1TiWwt1TZLQWNPXRvxhovKJmY5hg0Ter/D5KCjSrPsnQBBuJA4ztlIcltKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWhcUxeV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDwp5uSE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWhcUxeV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDwp5uSE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C75792116A;
	Mon,  7 Apr 2025 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFHBU8qKRsSo7KDj8R5CBHMz3B1xBDtyFEI2YAbYdI=;
	b=mWhcUxeVPKJ5eeWqmsgupGucnZIyZkKS6XNLYltHb9TqF7YYcAfyyMj6tRk22BuO2bl2Mg
	hvcMmSMzX1oHv5orEZee55ZBNmMHzDDudaBEaDQKUxssGcFjNXKr3tI/DSLg34+Ihov5ok
	CLWbXsN4gHteRApMbthPTUHqfUhopRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFHBU8qKRsSo7KDj8R5CBHMz3B1xBDtyFEI2YAbYdI=;
	b=JDwp5uSEzi6ILT5+J6ggL8SYknX1qqug6OUYhK4992Xu4k6EW9Byq6+Ppl0nxZgRgh/BBS
	HV42EqJJmpnEnHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFHBU8qKRsSo7KDj8R5CBHMz3B1xBDtyFEI2YAbYdI=;
	b=mWhcUxeVPKJ5eeWqmsgupGucnZIyZkKS6XNLYltHb9TqF7YYcAfyyMj6tRk22BuO2bl2Mg
	hvcMmSMzX1oHv5orEZee55ZBNmMHzDDudaBEaDQKUxssGcFjNXKr3tI/DSLg34+Ihov5ok
	CLWbXsN4gHteRApMbthPTUHqfUhopRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFHBU8qKRsSo7KDj8R5CBHMz3B1xBDtyFEI2YAbYdI=;
	b=JDwp5uSEzi6ILT5+J6ggL8SYknX1qqug6OUYhK4992Xu4k6EW9Byq6+Ppl0nxZgRgh/BBS
	HV42EqJJmpnEnHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2FCF13A4B;
	Mon,  7 Apr 2025 14:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vK+xKzfc82cDIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:07:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50ED2A08D2; Mon,  7 Apr 2025 16:07:47 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:07:47 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5/9] anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
Message-ID: <znozbhmeuz5sp24ksqsm5vsd4xlbuqfkbf5qwo6djle57gsnks@z274bu2spsxz>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-5-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-5-53a44c20d44e@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 11:54:19, Christian Brauner wrote:
> It isn't possible to execute anoymous inodes because they cannot be
				^^ anonymous

> opened in any way after they have been created. This includes execution:
> 
> execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)
> 
> Anonymous inodes have inode->f_op set to no_open_fops which sets
> no_open() which returns ENXIO. That means any call to do_dentry_open()
> which is the endpoint of the do_open_execat() will fail. There's no
> chance to execute an anonymous inode. Unless a given subsystem overrides
> it ofc.
> 
> Howerver, we should still harden this and raise SB_I_NODEV and
  ^^^ However

> SB_I_NOEXEC on the superblock itself so that no one gets any creative
> ideas.

;)

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Cc: <stable@vger.kernel.org> # all LTS kernels
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/anon_inodes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index cb51a90bece0..e51e7d88980a 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -86,6 +86,8 @@ static int anon_inodefs_init_fs_context(struct fs_context *fc)
>  	struct pseudo_fs_context *ctx = init_pseudo(fc, ANON_INODE_FS_MAGIC);
>  	if (!ctx)
>  		return -ENOMEM;
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	fc->s_iflags |= SB_I_NODEV;
>  	ctx->dops = &anon_inodefs_dentry_operations;
>  	return 0;
>  }
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

