Return-Path: <linux-fsdevel+bounces-45876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D3A7E0B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D262A3B326E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633ED1C6FFF;
	Mon,  7 Apr 2025 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OrYd5NSv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZEVmoACG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OrYd5NSv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZEVmoACG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E231C5D58
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034744; cv=none; b=nHwAU28GrMwrAgAkfyZ4QMWZJRbbD6AV4JxagGDkS0mHeZjcOZYhT56e+OMaL5EMocji6du23A3EW2Flc75r9vmy+wm8zk7iaObfBliX3PiWCd9U0DO4lKLIvyl9grkbiW2CiAqmhrkxsZZXLHWfD3NoSXx6PbnNPBG8BhepeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034744; c=relaxed/simple;
	bh=AWXjbQX/s/k2DW9mCRF6+9F2odbHnPFfJsg+Rc48Whc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrINDkkSirapmzpKj1IUEtjjlGJM/GGf4hztZe0wg/3ZXvKXrpMQlU38SUkApReWSoHN26QzsJifz+lGdp/Upm3LImSiXTMUe5ZHmxMvz/XinoQuTWLpXlmxLA30OtV7MoIVJfD0kZsQzWevSZcz/dJ5ZkFvNrXIYxEe1f7XEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OrYd5NSv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZEVmoACG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OrYd5NSv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZEVmoACG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DA332116C;
	Mon,  7 Apr 2025 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VLhvhm//Ir4oXrZ9UlKIZS2DYdNsraFKrzlp4HN2hc=;
	b=OrYd5NSv5bzYc7usOwr5Qk2rBmGQoyu5kJ7nbEYIxmhsbdSBl5Bp5YmfpUH7Z3d6Wss5yG
	QRrXYzMgGnqa0pC/BNEb9JXlXojAxPJvqAqyBjSPMjgdmb30+mKCpVHiiYl84HkWv5Moel
	hSeZiCE9KbuflnzqUtG1K/zZ2ElCz8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VLhvhm//Ir4oXrZ9UlKIZS2DYdNsraFKrzlp4HN2hc=;
	b=ZEVmoACGZ5iPEzA0FdyNXgRLXQ646kxQSb+Do1gBTUKDUmGYA62gPKg5eCqcQ/TJEeCYmK
	KXMVzy4YtwoAC8Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744034740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VLhvhm//Ir4oXrZ9UlKIZS2DYdNsraFKrzlp4HN2hc=;
	b=OrYd5NSv5bzYc7usOwr5Qk2rBmGQoyu5kJ7nbEYIxmhsbdSBl5Bp5YmfpUH7Z3d6Wss5yG
	QRrXYzMgGnqa0pC/BNEb9JXlXojAxPJvqAqyBjSPMjgdmb30+mKCpVHiiYl84HkWv5Moel
	hSeZiCE9KbuflnzqUtG1K/zZ2ElCz8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744034740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VLhvhm//Ir4oXrZ9UlKIZS2DYdNsraFKrzlp4HN2hc=;
	b=ZEVmoACGZ5iPEzA0FdyNXgRLXQ646kxQSb+Do1gBTUKDUmGYA62gPKg5eCqcQ/TJEeCYmK
	KXMVzy4YtwoAC8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32B6713A4B;
	Mon,  7 Apr 2025 14:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6R9gDLTb82ddIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 14:05:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD13CA08D2; Mon,  7 Apr 2025 16:05:39 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:05:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH 3/9] anon_inode: explicitly block ->setattr()
Message-ID: <eqkk7mdlml3x3ceywv4wl6uwruzhm5mupggmbbx6uftfjwpj4e@fcjqcgjce3o5>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-3-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-work-anon_inode-v1-3-53a44c20d44e@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,toxicpanda.com,syzkaller.appspotmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[5d8e79d323a13aa0b248];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 07-04-25 11:54:17, Christian Brauner wrote:
> It is currently possible to change the mode and owner of the single
> anonymous inode in the kernel:
> 
> int main(int argc, char *argv[])
> {
>         int ret, sfd;
>         sigset_t mask;
>         struct signalfd_siginfo fdsi;
> 
>         sigemptyset(&mask);
>         sigaddset(&mask, SIGINT);
>         sigaddset(&mask, SIGQUIT);
> 
>         ret = sigprocmask(SIG_BLOCK, &mask, NULL);
>         if (ret < 0)
>                 _exit(1);
> 
>         sfd = signalfd(-1, &mask, 0);
>         if (sfd < 0)
>                 _exit(2);
> 
>         ret = fchown(sfd, 5555, 5555);
>         if (ret < 0)
>                 _exit(3);
> 
>         ret = fchmod(sfd, 0777);
>         if (ret < 0)
>                 _exit(3);
> 
>         _exit(4);
> }
> 
> This is a bug. It's not really a meaningful one because anonymous inodes
> don't really figure into path lookup and they cannot be reopened via
> /proc/<pid>/fd/<nr> and can't be used for lookup itself. So they can
> only ever serve as direct references.
> 
> But it is still completely bogus to allow the mode and ownership or any
> of the properties of the anonymous inode to be changed. Block this!
> 
> Cc: <stable@vger.kernel.org> # all LTS kernels
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Definitely. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/anon_inodes.c | 7 +++++++
>  fs/internal.h    | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 42e4b9c34f89..cb51a90bece0 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -57,8 +57,15 @@ int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	return 0;
>  }
>  
> +int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +		       struct iattr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static const struct inode_operations anon_inode_operations = {
>  	.getattr = anon_inode_getattr,
> +	.setattr = anon_inode_setattr,
>  };
>  
>  /*
> diff --git a/fs/internal.h b/fs/internal.h
> index 717dc9eb6185..f545400ce607 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -346,3 +346,5 @@ int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_
>  int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		       struct kstat *stat, u32 request_mask,
>  		       unsigned int query_flags);
> +int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +		       struct iattr *attr);
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

