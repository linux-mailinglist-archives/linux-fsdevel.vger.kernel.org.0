Return-Path: <linux-fsdevel+bounces-62568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF84DB999F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD62F19C41F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6B2FE05D;
	Wed, 24 Sep 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C01t3IYZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Ut7Bbel";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C01t3IYZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Ut7Bbel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF32DE6FC
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714100; cv=none; b=DoBNoD2u4RCM+GJuFnejgRuFaslg3l/0itXwINW3zpKvWxsy+gVXmTbg1/LWM+y3YHXXqvEEzegs8lN2dcz8XzwZ2HBA6YLDh1nd1q0NYu9fnsL5CkEKvS/hJj+2q9O3D+4xsJ0u2vy50o1hOqT7bIW7ufAmlrvrTbXyMkG6X+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714100; c=relaxed/simple;
	bh=sddq8rAEdyqgTc4qgfAfccSPYL6DnhKQQ6LI3dkehyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0KOPw6kinxxqTwlfKT1CLxjA3tojOOy9TZ06Ax+LZcnmWj4cttAfGLYi4KfYK3b2Z89VUl5Hq0HKJi6OMsXDzmGPZDGgjTD4SIoFS+pwRibJEwEswq63IRxOV6J+uc4gYV8BPIqKJgw6l8BbCDlfXrXE3aSGtln3SzxNScyhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C01t3IYZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Ut7Bbel; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C01t3IYZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Ut7Bbel; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEEB65BE8C;
	Wed, 24 Sep 2025 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpaOwqW/+ql6JunOY/CPZHVV+mK+N4kE1eRvfpfIsXU=;
	b=C01t3IYZI2JcodeoykGQlWpeatmEzPKbIAwqrGetfn74BF8H6kh1bnRX70gQ+dpvW152o6
	lVyGc3rat1t52ZTIa/4H0WlBRQDvnSSJsPxvBE8FADkSlbuHQdWga0PNE8taC0GMyI05cc
	yQ7jTDR90Mj3wl1Zn0FmFLKC8RRY6b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpaOwqW/+ql6JunOY/CPZHVV+mK+N4kE1eRvfpfIsXU=;
	b=+Ut7BbelrXlr9wAyA9F14PTbUp8QE2Y95w/OnEWOvULkC+URdCv5eec8QzpJXALRqPEEQ2
	Q5bVSDOky0H0ZiCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758714096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpaOwqW/+ql6JunOY/CPZHVV+mK+N4kE1eRvfpfIsXU=;
	b=C01t3IYZI2JcodeoykGQlWpeatmEzPKbIAwqrGetfn74BF8H6kh1bnRX70gQ+dpvW152o6
	lVyGc3rat1t52ZTIa/4H0WlBRQDvnSSJsPxvBE8FADkSlbuHQdWga0PNE8taC0GMyI05cc
	yQ7jTDR90Mj3wl1Zn0FmFLKC8RRY6b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758714096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpaOwqW/+ql6JunOY/CPZHVV+mK+N4kE1eRvfpfIsXU=;
	b=+Ut7BbelrXlr9wAyA9F14PTbUp8QE2Y95w/OnEWOvULkC+URdCv5eec8QzpJXALRqPEEQ2
	Q5bVSDOky0H0ZiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9829E13647;
	Wed, 24 Sep 2025 11:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ADDHJPDY02hJQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:41:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C509A0A9A; Wed, 24 Sep 2025 13:41:36 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:41:36 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] fs: Defer evicting inodes to a workqueue
Message-ID: <m23ezi6fiy65kw3jwvo7zydwodfzyiy4pv5hgx4evjhdbqp3bp@4crtpibozzw5>
References: <20250924091000.2987157-1-willy@infradead.org>
 <20250924091000.2987157-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924091000.2987157-3-willy@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 24-09-25 10:09:57, Matthew Wilcox (Oracle) wrote:
> If we're in memory reclaim, evicting inodes is actually a bad idea.
> The filesystem may need to allocate more memory to evict the inode
> than it will free by evicting the inode.  It's better to defer
> evicting the inode until a workqueue has time to run.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/inode.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d882b0fc787..fe7899cdd50c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -854,6 +854,34 @@ static void dispose_list(struct list_head *head)
>  	}
>  }
>  
> +static DEFINE_SPINLOCK(deferred_inode_lock);
> +static LIST_HEAD(deferred_inode_list);
> +
> +static void dispose_inodes_wq(struct work_struct *work)
> +{
> +	LIST_HEAD(dispose);
> +
> +	spin_lock_irq(&deferred_inode_lock);
> +	list_splice_init(&deferred_inode_list, &dispose);
> +	spin_unlock_irq(&deferred_inode_lock);
> +
> +	dispose_list(&dispose);
> +}
> +
> +static DECLARE_WORK(dispose_inode_work, dispose_inodes_wq);
> +
> +static void deferred_dispose_inodes(struct list_head *inodes)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&deferred_inode_lock, flags);
> +	list_splice_tail(inodes, &deferred_inode_list);
> +	spin_unlock_irqrestore(&deferred_inode_lock, flags);
> +
> +	printk("deferring some inodes\n");
> +	schedule_work(&dispose_inode_work);
> +}
> +
>  /**
>   * evict_inodes	- evict all evictable inodes for a superblock
>   * @sb:		superblock to operate on
> @@ -897,13 +925,17 @@ void evict_inodes(struct super_block *sb)

As mentioned in my reply to cover letter this is a wrong function to patch.
You'll never see this triggering, unless kswapd can trigger fs unmount :)

I guess let's keep the discussion about the approach threaded behind the
cover letter so I won't comment more here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

