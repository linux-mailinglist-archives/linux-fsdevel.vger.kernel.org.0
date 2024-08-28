Return-Path: <linux-fsdevel+bounces-27620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0B962DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAC21C23D19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2D1A4F15;
	Wed, 28 Aug 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pYUdr+EN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DMGStuL5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o0ka+z48";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McmltJ7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65336130;
	Wed, 28 Aug 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862983; cv=none; b=NkobP4LBgFwjiggpgLsfJSnKlWU2RRDE2/3lvblm/p5bHX0Ko9HcRhxePrG/Mqw46539aY+oMkK9f1ZalxhWVhfDpiBQRzLBqX+vr6AX4HwLFfk1Qy4rAXhaj4IE1a5mdodiJuUXatbqFh15UBpt87NESEhjagHMKhH1Z+NREio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862983; c=relaxed/simple;
	bh=7Tx4u/wCein9qY/KIq4GT9HP4jQcGk1lfUy9Iler/mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC8vXYY9h+gRip/aBJWam2a9VJGQMXBzEzrie6q/t/vJ08w5seQK9P/nlIZM9YHKWMQMNBB1vy7J9KCpGDjNmOmP1UhPqusd+s05Ph34hHatrwWHlbDdF2UtBBh+bxS+plcncbI4zAlh2pray5onjJd5lk8ReCreWr8oKe0xPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pYUdr+EN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DMGStuL5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o0ka+z48; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McmltJ7t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E89F71FCE1;
	Wed, 28 Aug 2024 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724862980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki5vuidXZjGYdd78rEMC7d0LG8cLiU814H5NqoowWNk=;
	b=pYUdr+EN93Kb5SBp94ur9+0EZsZfdHYXtitqraoL0MkLzTwjcfyyq1x69B8qQaM5ZOJyyl
	V4OHB+1tijF+WH5oUgmVHdTAppIXfo8TJmoLf7FvLq+3reGqtmg7hpK9WSiJz8KsI7Gx9y
	ZcQ7ys00jtHSkGLHAS1u7XL9/vqLGoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724862980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki5vuidXZjGYdd78rEMC7d0LG8cLiU814H5NqoowWNk=;
	b=DMGStuL5d0cM24yORQYuSnc4aCmEy40tF9+HyqHgLebJ4KAins3C83KBA79HHnzuDOxt2v
	YdITvEy4PWtCojCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o0ka+z48;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=McmltJ7t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724862978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki5vuidXZjGYdd78rEMC7d0LG8cLiU814H5NqoowWNk=;
	b=o0ka+z48tVxxjBxC+7jPo+7terU8p+KJZHMhHARR4zC8Z2hnJzk1K2lnaTsPS3KNZhLdye
	bhclowkTeYX6jvEJL1WjNR4wq6Cey2iXB32RVsfbyKDcJE4bRZKpGFmbi3VxvxYkVl1DaP
	JBZZFbI34MErPlyV14ZHkQNqr4kfD2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724862978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki5vuidXZjGYdd78rEMC7d0LG8cLiU814H5NqoowWNk=;
	b=McmltJ7tvLj+lj8OAh9iZwVYV3I4/8mZlGweTb2gSpMNc+86aC2Um7ODTW6Z/kK4cylhxL
	71rTD9jQKrafQbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D34361398F;
	Wed, 28 Aug 2024 16:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LXyKMwJSz2beZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 16:36:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7F03BA0965; Wed, 28 Aug 2024 18:36:14 +0200 (CEST)
Date: Wed, 28 Aug 2024 18:36:14 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, zhuyifei1999@gmail.com,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vfs: fix race between evice_inodes() and
 find_inode()&iput()
Message-ID: <20240828163614.gsmg4vjjpy7gmsy7@quack3>
References: <20240823130730.658881-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823130730.658881-1-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: E89F71FCE1
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[67ba3c42bcbb4665d3ad];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,fromorbit.com,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:email,suse.cz:dkim,appspotmail.com:email,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 23-08-24 21:07:30, Julian Sun wrote:
> Hi, all
> 
> Recently I noticed a bug[1] in btrfs, after digged it into
> and I believe it'a race in vfs.
> 
> Let's assume there's a inode (ie ino 261) with i_count 1 is
> called by iput(), and there's a concurrent thread calling
> generic_shutdown_super().
> 
> cpu0:                              cpu1:
> iput() // i_count is 1
>   ->spin_lock(inode)
>   ->dec i_count to 0
>   ->iput_final()                    generic_shutdown_super()
>     ->__inode_add_lru()               ->evict_inodes()
>       // cause some reason[2]           ->if (atomic_read(inode->i_count)) continue;
>       // return before                  // inode 261 passed the above check
>       // list_lru_add_obj()             // and then schedule out
>    ->spin_unlock()
> // note here: the inode 261
> // was still at sb list and hash list,
> // and I_FREEING|I_WILL_FREE was not been set
> 
> btrfs_iget()
>   // after some function calls
>   ->find_inode()
>     // found the above inode 261
>     ->spin_lock(inode)
>    // check I_FREEING|I_WILL_FREE
>    // and passed
>       ->__iget()
>     ->spin_unlock(inode)                // schedule back
>                                         ->spin_lock(inode)
>                                         // check (I_NEW|I_FREEING|I_WILL_FREE) flags,
>                                         // passed and set I_FREEING
> iput()                                  ->spin_unlock(inode)
>   ->spin_lock(inode)			  ->evict()
>   // dec i_count to 0
>   ->iput_final()
>     ->spin_unlock()
>     ->evict()
> 
> Now, we have two threads simultaneously evicting
> the same inode, which may trigger the BUG(inode->i_state & I_CLEAR)
> statement both within clear_inode() and iput().
> 
> To fix the bug, recheck the inode->i_count after holding i_lock.
> Because in the most scenarios, the first check is valid, and
> the overhead of spin_lock() can be reduced.
> 
> If there is any misunderstanding, please let me know, thanks.
> 
> [1]: https://lore.kernel.org/linux-btrfs/000000000000eabe1d0619c48986@google.com/
> [2]: The reason might be 1. SB_ACTIVE was removed or 2. mapping_shrinkable()
> return false when I reproduced the bug.
> 
> Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
> CC: stable@vger.kernel.org
> Fixes: 63997e98a3be ("split invalidate_inodes()")
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Thanks for the fix. It looks good to me and I'm curious how come we didn't
hit this earlier ;). Anyway, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'd just note that the Fixes tag isn't correct AFAICT. At the time of
commit 63997e98a3be we had a global inode_lock and the
atomic_read(&inode->i_count) check was done under it. I'd say it was

55fa6091d831 ("fs: move i_sb_list out from under inode_lock")

or possibly

250df6ed274d ("fs: protect inode->i_state with inode->i_lock")

(depending on how you look at it) that introduced this problem. Not that it
would matter that much these days :).

								Honza

> ---
>  fs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..011f630777d0 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -723,6 +723,10 @@ void evict_inodes(struct super_block *sb)
>  			continue;
>  
>  		spin_lock(&inode->i_lock);
> +		if (atomic_read(&inode->i_count)) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
>  		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

