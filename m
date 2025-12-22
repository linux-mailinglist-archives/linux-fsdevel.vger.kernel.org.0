Return-Path: <linux-fsdevel+bounces-71830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D620FCD690F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B946C3069328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7262DC334;
	Mon, 22 Dec 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lh1fa3GT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UkP/xbhy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SbCloAPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6iFgVVAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95521CFFA
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417695; cv=none; b=Un4r0sYhefXHnHvTBQg2/WbuRK9K5pad42ow0rPhCNgsBj7hkAe3g1c/Z7hmvUNEmgfjtRSmmvI1L4e3KG4MWtWtgCmW33rwlgApOQV013zgCsN5RIE4F3k3xMfr7wy5DDJ7+6GDUMhepuc8MibQhvEEBO21ThfXHDQ3VyrOlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417695; c=relaxed/simple;
	bh=+U3BtZFNqQtnFnYhhxn4TDo8FJ9r+Det5LAgI6joXJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJU8e9+kFz9HMS+j8jE5+GW6NBUTtPvVS5//tMnNh+uD3wI1IzgnonRSsf7Z256LI2UmYzs4GPA7EL6KHOnKY9yzMLWmbMo3Y7aloyzhbSfEuWIpoH3TLizLeePbnLZCAAM0ilPd2CibgEsZvtOfc4sGhE1UWOsuHsmfoA5rIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lh1fa3GT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UkP/xbhy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SbCloAPJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6iFgVVAy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2080D5BCD7;
	Mon, 22 Dec 2025 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766417690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRUouFAC/oP0my6hx2tkTmTx4Apcn2teuZxVScgsKOg=;
	b=lh1fa3GTt3g9XwcfHOjCXQ4/JRVP0OcdC2+ubsAx7ZVbTlXTSvMdp2Eb/mdcVmHlIkj2m8
	HzgAMN5fdZECHvKpnY7jIu7xAgkhNkn6F9+vK4C1ysJMjWolkMorq6m9p98Yi+M741ER8t
	qnUdqOtxKfMhBWWlj6oNSTv5D3dOTPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766417690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRUouFAC/oP0my6hx2tkTmTx4Apcn2teuZxVScgsKOg=;
	b=UkP/xbhy1M0tLLS169R/GNGFlf9Vb6BsnfEfq4PhJzyS0fRH/YfiJAqZllcj+SHQxRmMlg
	2qO5DnlqYL1CS5BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SbCloAPJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6iFgVVAy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766417689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRUouFAC/oP0my6hx2tkTmTx4Apcn2teuZxVScgsKOg=;
	b=SbCloAPJ+32Lgrmkv9eFL8ZPJGWw9t9MX7GCx3muHqokj5UJINmORABIYxYCJO6Fk1cyYT
	jYqJXkNrzlQl80X/Uq7whg1IIbAaPKOcEd925A98YrnXYRUcEB6yQeggdvCSqRRyhZrkG6
	oXuKOE5qSS6ziVmjpOxFm5Q2YPNEbX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766417689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRUouFAC/oP0my6hx2tkTmTx4Apcn2teuZxVScgsKOg=;
	b=6iFgVVAy1d1oaCOtf2qb0OtSeVsns+XoP+84QUKU7YCbOZyqDbk+81sYKjifH7souFV0r6
	px5mEfta7zu00dCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14B281364B;
	Mon, 22 Dec 2025 15:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +QILBRllSWk1DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Dec 2025 15:34:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A82E5A09CB; Mon, 22 Dec 2025 16:34:48 +0100 (CET)
Date: Mon, 22 Dec 2025 16:34:48 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, gabriel@krisman.be, hch@lst.de, 
	amir73il@gmail.com
Subject: Re: [PATCH 6/6] ext4: convert to new fserror helpers
Message-ID: <lhvwanmjakwkrpugrhg6qjjv5nvsywr2nlbqmwrt76jqijmkgv@fqpzmao4zknr>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332256.686273.6918131598618211052.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332256.686273.6918131598618211052.stgit@frogsfrogsfrogs>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 2080D5BCD7
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.cz,krisman.be,lst.de,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Wed 17-12-25 18:04:14, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Use the new fserror functions to report metadata errors to fsnotify.
> Note that ext4 inconsistently passes around negative and positive error
> numbers all over the codebase, so we force them all to negative for
> consistency in what we report to fserror, and fserror ensures that only
> positive error numbers are passed to fanotify, per the fanotify(7)
> manpage.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

We need to cleanup those error numbers passing - we should have mostly
negative ones AFAIK - where do we end up passing positive ones? But it's
unrelated to this patch so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c |    2 ++
>  fs/ext4/super.c |   13 +++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7ce0fc40aec2fb..ea26cd03d3ce28 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -26,6 +26,7 @@
>  #include <linux/fsmap.h>
>  #include "fsmap.h"
>  #include <trace/events/ext4.h>
> +#include <linux/fserror.h>
>  
>  typedef void ext4_update_sb_callback(struct ext4_sb_info *sbi,
>  				     struct ext4_super_block *es,
> @@ -844,6 +845,7 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
>  		return -EINVAL;
>  	}
>  	clear_opt(sb, DISCARD);
> +	fserror_report_shutdown(sb, GFP_KERNEL);
>  	return 0;
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87205660c5d026..a6241ffb8639c3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -48,6 +48,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
> +#include <linux/fserror.h>
>  
>  #include "ext4.h"
>  #include "ext4_extents.h"	/* Needed for trace points definition */
> @@ -824,7 +825,8 @@ void __ext4_error(struct super_block *sb, const char *function,
>  		       sb->s_id, function, line, current->comm, &vaf);
>  		va_end(args);
>  	}
> -	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
> +	fserror_report_metadata(sb, error ? -abs(error) : -EFSCORRUPTED,
> +				GFP_ATOMIC);
>  
>  	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
> @@ -856,7 +858,9 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>  			       current->comm, &vaf);
>  		va_end(args);
>  	}
> -	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
> +	fserror_report_file_metadata(inode,
> +				     error ? -abs(error) : -EFSCORRUPTED,
> +				     GFP_ATOMIC);
>  
>  	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
>  			  function, line);
> @@ -896,7 +900,7 @@ void __ext4_error_file(struct file *file, const char *function,
>  			       current->comm, path, &vaf);
>  		va_end(args);
>  	}
> -	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
> +	fserror_report_file_metadata(inode, -EFSCORRUPTED, GFP_ATOMIC);
>  
>  	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
>  			  function, line);
> @@ -965,7 +969,8 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>  		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
>  		       sb->s_id, function, line, errstr);
>  	}
> -	fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
> +	fserror_report_metadata(sb, errno ? -abs(errno) : -EFSCORRUPTED,
> +				GFP_ATOMIC);
>  
>  	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

