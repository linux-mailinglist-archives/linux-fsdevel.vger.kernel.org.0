Return-Path: <linux-fsdevel+bounces-30847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E698EC2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090131C21EE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC4145FE8;
	Thu,  3 Oct 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kINfBTiO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XopqQ4Hh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kINfBTiO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XopqQ4Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E3142E7C;
	Thu,  3 Oct 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947213; cv=none; b=rXv3XijHoR1CL4a7+5V+OIPG1Bd6V80aiEvI5CUWffRsd8TQlSDrJscXlACocncRxgzvLuDqajdklMQ8hjXdAhfEnIfwBTrwzxLK8ae8O7rAp3xXvpgaTLpfevCjPQo1+crKTZrm7d7BtSP406Y6l8YCFEIGgQuhez59/H0Awn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947213; c=relaxed/simple;
	bh=HpSg4uPT57z+yFVjv2qUWXRrtFmbShFKEto95tZFuto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTrV/pbkCZ1Njz9pZpr0UOu7Z8HakM+UWQ76f1nJMiFtta98P9A0d2iox79ElKk9ogRpaRvAUtZiI7GFW+EQlIO43T7rQfXCKh18ETyJE76RRQlRdzITD2A2O1wZZTwVWmpjzO6S2wt2k9YJSJtYiHy+k/rt6xGkYXielBvQD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kINfBTiO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XopqQ4Hh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kINfBTiO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XopqQ4Hh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0994721D1C;
	Thu,  3 Oct 2024 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727947203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtiHrCDe2cBAFXvqtg+ujXCV8xUpYaNIQo/MxZah8zs=;
	b=kINfBTiOs46E5+lwjBmfaTewMASHQMuEx3imq8916qdWtOUloHJO/wibONsr5IXPOpYpAQ
	2NK77PgCQLL+ZEUon5sSdrOglvd2Rj/ScGkrj9jewMrvRLf08Xh6RdhoGUW+Um8cFIV+IB
	xTaxfqb2R0tooQl0B01OLli972chZ0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727947203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtiHrCDe2cBAFXvqtg+ujXCV8xUpYaNIQo/MxZah8zs=;
	b=XopqQ4Hhpnfww9fNxDYALkapBPpSOo3v9OhDRG0lVS0e1TiwuFDinqG9HRkSupVLgbhc8o
	IZtHe3qrsm5lElCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kINfBTiO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XopqQ4Hh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727947203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtiHrCDe2cBAFXvqtg+ujXCV8xUpYaNIQo/MxZah8zs=;
	b=kINfBTiOs46E5+lwjBmfaTewMASHQMuEx3imq8916qdWtOUloHJO/wibONsr5IXPOpYpAQ
	2NK77PgCQLL+ZEUon5sSdrOglvd2Rj/ScGkrj9jewMrvRLf08Xh6RdhoGUW+Um8cFIV+IB
	xTaxfqb2R0tooQl0B01OLli972chZ0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727947203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtiHrCDe2cBAFXvqtg+ujXCV8xUpYaNIQo/MxZah8zs=;
	b=XopqQ4Hhpnfww9fNxDYALkapBPpSOo3v9OhDRG0lVS0e1TiwuFDinqG9HRkSupVLgbhc8o
	IZtHe3qrsm5lElCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3C66139CE;
	Thu,  3 Oct 2024 09:20:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sQuCO8Jh/mZqagAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 09:20:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1314A086F; Thu,  3 Oct 2024 11:20:02 +0200 (CEST)
Date: Thu, 3 Oct 2024 11:20:02 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/7] vfs: replace invalidate_inodes() with evict_inodes()
Message-ID: <20241003092002.h4p46cifkodeubjb@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-2-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-2-david@fromorbit.com>
X-Rspamd-Queue-Id: 0994721D1C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 02-10-24 11:33:18, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> As of commit e127b9bccdb0 ("fs: simplify invalidate_inodes"),
> invalidate_inodes() is functionally identical to evict_inodes().
> Replace calls to invalidate_inodes() with a call to
> evict_inodes() and kill the former.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Indeed :). Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c    | 40 ----------------------------------------
>  fs/internal.h |  1 -
>  fs/super.c    |  2 +-
>  3 files changed, 1 insertion(+), 42 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 471ae4a31549..0a53d8c34203 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -827,46 +827,6 @@ void evict_inodes(struct super_block *sb)
>  }
>  EXPORT_SYMBOL_GPL(evict_inodes);
>  
> -/**
> - * invalidate_inodes	- attempt to free all inodes on a superblock
> - * @sb:		superblock to operate on
> - *
> - * Attempts to free all inodes (including dirty inodes) for a given superblock.
> - */
> -void invalidate_inodes(struct super_block *sb)
> -{
> -	struct inode *inode, *next;
> -	LIST_HEAD(dispose);
> -
> -again:
> -	spin_lock(&sb->s_inode_list_lock);
> -	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> -		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> -			spin_unlock(&inode->i_lock);
> -			continue;
> -		}
> -		if (atomic_read(&inode->i_count)) {
> -			spin_unlock(&inode->i_lock);
> -			continue;
> -		}
> -
> -		inode->i_state |= I_FREEING;
> -		inode_lru_list_del(inode);
> -		spin_unlock(&inode->i_lock);
> -		list_add(&inode->i_lru, &dispose);
> -		if (need_resched()) {
> -			spin_unlock(&sb->s_inode_list_lock);
> -			cond_resched();
> -			dispose_list(&dispose);
> -			goto again;
> -		}
> -	}
> -	spin_unlock(&sb->s_inode_list_lock);
> -
> -	dispose_list(&dispose);
> -}
> -
>  /*
>   * Isolate the inode from the LRU in preparation for freeing it.
>   *
> diff --git a/fs/internal.h b/fs/internal.h
> index 8c1b7acbbe8f..37749b429e80 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -207,7 +207,6 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
>   * fs-writeback.c
>   */
>  extern long get_nr_dirty_inodes(void);
> -void invalidate_inodes(struct super_block *sb);
>  
>  /*
>   * dcache.c
> diff --git a/fs/super.c b/fs/super.c
> index 1db230432960..a16e6a6342e0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1417,7 +1417,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	if (!surprise)
>  		sync_filesystem(sb);
>  	shrink_dcache_sb(sb);
> -	invalidate_inodes(sb);
> +	evict_inodes(sb);
>  	if (sb->s_op->shutdown)
>  		sb->s_op->shutdown(sb);
>  
> -- 
> 2.45.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

