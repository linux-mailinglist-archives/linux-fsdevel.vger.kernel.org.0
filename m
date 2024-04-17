Return-Path: <linux-fsdevel+bounces-17117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D508A8049
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0F2840F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0613A896;
	Wed, 17 Apr 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pDDrSXFn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pfqa9KIh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pDDrSXFn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pfqa9KIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB513281B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348315; cv=none; b=epdplwxVl0JX4AOb/o5E+IvAWWA/M0lWf0IcL3A6fEI0yQN69HtOakssa7qjSOy4Z9bw9JoVSEi9MA8nKknzX5vNZjisGnQ8/Ran7rRp2f7MwkQaH6SntQDQd439axfuT9MQByej2nPbjjVlWtPuzgf3IDzMCdaiCI+V0n6Npks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348315; c=relaxed/simple;
	bh=UzmR018soB2mKNhOr1BDrnxFFfXOvLkLUzxwet1rLtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4R+CG7cyeV5jD2LcI8h0CHP/PE5WPUOP7kK2R0KzpqZf7v6K0O+LdjegXRadDrL95jbwYO7AL4JkWAnpSNlpjlwXBngpA3pb3P+FGRFKc5MUyl8aT4Vbpu1iGFLryxtMx1UQC23Mx8Umww4aPbHkTbgCtSjsmX33V+uKkz7gFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pDDrSXFn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pfqa9KIh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pDDrSXFn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pfqa9KIh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C589206B3;
	Wed, 17 Apr 2024 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713348308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aum35JXQEgOE5xAzKqCOgVY1xM0L9h1lMXM1kz177Pw=;
	b=pDDrSXFnIJ/YJXjeoLLIxqG/mydpurh3o7CRzU78xZiblkhZ61KR4+aD5zABzmsXbR/g9D
	82jMuMkspIh1Er4qrLLqqTxYDqSWc6TN3ujxlClXKM0KsJ3VArJab2oLQG+d/RqMuVJAKL
	NbnegaqYF3mt9LGaMkOW6o0uHF2p4tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713348308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aum35JXQEgOE5xAzKqCOgVY1xM0L9h1lMXM1kz177Pw=;
	b=Pfqa9KIhyaMnugrbf4oN0vwZqF8RiQJBkS0uyr0YpfOShc0FESNrW0QJLLda2qhOu16MJf
	CPV525WLWkSVLDDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pDDrSXFn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Pfqa9KIh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713348308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aum35JXQEgOE5xAzKqCOgVY1xM0L9h1lMXM1kz177Pw=;
	b=pDDrSXFnIJ/YJXjeoLLIxqG/mydpurh3o7CRzU78xZiblkhZ61KR4+aD5zABzmsXbR/g9D
	82jMuMkspIh1Er4qrLLqqTxYDqSWc6TN3ujxlClXKM0KsJ3VArJab2oLQG+d/RqMuVJAKL
	NbnegaqYF3mt9LGaMkOW6o0uHF2p4tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713348308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aum35JXQEgOE5xAzKqCOgVY1xM0L9h1lMXM1kz177Pw=;
	b=Pfqa9KIhyaMnugrbf4oN0vwZqF8RiQJBkS0uyr0YpfOShc0FESNrW0QJLLda2qhOu16MJf
	CPV525WLWkSVLDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D99113957;
	Wed, 17 Apr 2024 10:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kUNkHtSeH2bsZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Apr 2024 10:05:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C1CFA082E; Wed, 17 Apr 2024 12:05:08 +0200 (CEST)
Date: Wed, 17 Apr 2024 12:05:08 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Hillf Danton <hdanton@sina.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix UAF from FS_ERROR event on a shutting down
 filesystem
Message-ID: <20240417100508.4awz7f3plcrtdnqt@quack3>
References: <20240416181452.567070-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416181452.567070-1-amir73il@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8C589206B3
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,sina.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Tue 16-04-24 21:14:52, Amir Goldstein wrote:
> Protect against use after free when filesystem calls fsnotify_sb_error()
> during fs shutdown.
> 
> Move freeing of sb->s_fsnotify_info to destroy_super_work(), because it
> may be accessed from fs shutdown context.
> 
> Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-fsdevel/20240416173211.4lnmgctyo4jn5fha@quack3/
> Fixes: 07a3b8d0bf72 ("fsnotify: lazy attach fsnotify_sb_info state to sb")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks! Added to my tree.

								Honza

> ---
>  fs/notify/fsnotify.c             | 6 +++++-
>  fs/super.c                       | 1 +
>  include/linux/fsnotify_backend.h | 4 ++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 2ae965ef37e8..ff69ae24c4e8 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -103,7 +103,11 @@ void fsnotify_sb_delete(struct super_block *sb)
>  	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
>  	WARN_ON(fsnotify_sb_has_priority_watchers(sb,
>  						  FSNOTIFY_PRIO_PRE_CONTENT));
> -	kfree(sbinfo);
> +}
> +
> +void fsnotify_sb_free(struct super_block *sb)
> +{
> +	kfree(sb->s_fsnotify_info);
>  }
>  
>  /*
> diff --git a/fs/super.c b/fs/super.c
> index 69ce6c600968..b72f1d288e95 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -274,6 +274,7 @@ static void destroy_super_work(struct work_struct *work)
>  {
>  	struct super_block *s = container_of(work, struct super_block,
>  							destroy_work);
> +	fsnotify_sb_free(s);
>  	security_sb_free(s);
>  	put_user_ns(s->s_user_ns);
>  	kfree(s->s_subtype);
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 7f1ab8264e41..4dd6143db271 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -576,6 +576,7 @@ extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data
>  extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
>  extern void fsnotify_sb_delete(struct super_block *sb);
> +extern void fsnotify_sb_free(struct super_block *sb);
>  extern u32 fsnotify_get_cookie(void);
>  
>  static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
> @@ -880,6 +881,9 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  static inline void fsnotify_sb_delete(struct super_block *sb)
>  {}
>  
> +static inline void fsnotify_sb_free(struct super_block *sb)
> +{}
> +
>  static inline void fsnotify_update_flags(struct dentry *dentry)
>  {}
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

