Return-Path: <linux-fsdevel+bounces-10769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961284DF49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 12:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426271C2904D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF176033;
	Thu,  8 Feb 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PklJu6k1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="22b85bw3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PklJu6k1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="22b85bw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520156BFDD
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389999; cv=none; b=DdM6EnRP8qvNSgzIhOXq3x1/ObGtisT9ff6I4/ILscmxB1Aab0umQKH6vJ7aFtMR45hRW/Ixdi1b7zYU7BQJJv+Z2MJWVktQmCkuqTzXvmHgc0ihUwUfLPIJDxiUIS84Xw+wnsxhY9sIJI7NEaozv+KPNdYIRFldhqplRZQswzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389999; c=relaxed/simple;
	bh=VER9yszrv2P9/GWSXjkKpofNRbcJMHhyiYu74TArIWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOdIlVqvipiRJhfQMVRSKa1Xfkq/tvS69mTQ9nmIQBmaVIXHGkpw5wWbu50LC9ih9hbLTkd+OVJw1mlIwp2dyniWe/6BdHAU7hq9cIfnrxQxzj2475iaCDlJ8pFOTR6LbKNBqptZ4GRMQBijDiQtDEkFVAFvUYu/VNof1T9TPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PklJu6k1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=22b85bw3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PklJu6k1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=22b85bw3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 720F11FCE2;
	Thu,  8 Feb 2024 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707389994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi/HLFk2knIK5s79A1OTh/Y3GgUyxvMpeCwJEM2gnAs=;
	b=PklJu6k1BhKBHKssTsE2weFGLy09JpJctMoJcwGZ2cx3mHPNr4AF83qzEFRoaAvgGSYxu5
	8CQp9XFj6egFCWob53pLgCGBvAVXQeMchpdy/tNvZeokDXFFulQ1mb1g+zlk5rQO3cmPU6
	212zIlbWwOIYPjmYTVWl3gp9J9g9GZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707389994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi/HLFk2knIK5s79A1OTh/Y3GgUyxvMpeCwJEM2gnAs=;
	b=22b85bw3FWmLhQpmSQEOcNsqbXi1defMxxFuFVGCZ7Y8E7CB1Hl7dK4XUh2vuzGijTKmCF
	uJNH45WhQslOvcBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707389994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi/HLFk2knIK5s79A1OTh/Y3GgUyxvMpeCwJEM2gnAs=;
	b=PklJu6k1BhKBHKssTsE2weFGLy09JpJctMoJcwGZ2cx3mHPNr4AF83qzEFRoaAvgGSYxu5
	8CQp9XFj6egFCWob53pLgCGBvAVXQeMchpdy/tNvZeokDXFFulQ1mb1g+zlk5rQO3cmPU6
	212zIlbWwOIYPjmYTVWl3gp9J9g9GZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707389994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi/HLFk2knIK5s79A1OTh/Y3GgUyxvMpeCwJEM2gnAs=;
	b=22b85bw3FWmLhQpmSQEOcNsqbXi1defMxxFuFVGCZ7Y8E7CB1Hl7dK4XUh2vuzGijTKmCF
	uJNH45WhQslOvcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6719813984;
	Thu,  8 Feb 2024 10:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MtsjGSq0xGUjMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Feb 2024 10:59:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E7B7A0809; Thu,  8 Feb 2024 11:59:54 +0100 (CET)
Date: Thu, 8 Feb 2024 11:59:54 +0100
From: Jan Kara <jack@suse.cz>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, linux@rainbow-software.org
Subject: Re: [PATCH] isofs: handle CDs with bad root inode but good Joliet
 root directory
Message-ID: <20240208105954.tovgh4borl7qbsqr@quack3>
References: <20240208022134.451490-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208022134.451490-1-alexhenrie24@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.59%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Wed 07-02-24 19:21:32, Alex Henrie wrote:
> I have a CD copy of the original Tom Clancy's Ghost Recon game from
> 2001. The disc mounts without error on Windows, but on Linux mounting
> fails with the message "isofs_fill_super: get root inode failed". The
> error originates in isofs_read_inode, which returns -EIO because de_len
> is 0. The superblock on this disc appears to be intentionally corrupt as
> a form of copy protection.
> 
> When the root inode is unusable, instead of giving up immediately, try
> to continue with the Joliet file table. This fixes the Ghost Recon CD
> and probably other copy-protected CDs too.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Thanks! I've added the patch to my tree. Just made two minor tweaks on
commit:

> @@ -908,8 +908,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
>  	 * we then decide whether to use the Joliet descriptor.
>  	 */
>  	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
> -	if (IS_ERR(inode))
> -		goto out_no_root;
> +
> +	/*
> +	 * Fix for broken CDs with a corrupt root inode but a correct Joliet
> +	 * root directory.
> +	 */
> +	if (IS_ERR(inode)) {
> +		if (joliet_level) {

Here I've added "&& sbi->s_firstdatazone != first_data_zone" to make sure
joliet extension has a different inode. Not sure if such media would be
valid but even if it was not, we should not crash the kernel (which would
happen in that case because we don't expect inode to be NULL).

> +			printk(KERN_NOTICE
> +				"ISOFS: root inode is unusable. "
> +				"Disabling Rock Ridge and switching to Joliet.");
> +			sbi->s_rock = 0;
> +			inode = NULL;
> +		} else {
> +			goto out_no_root;
> +		}
> +	}
>  
>  	/*
>  	 * Fix for broken CDs with Rock Ridge and empty ISO root directory but
> @@ -939,7 +953,8 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
>  			sbi->s_firstdatazone = first_data_zone;
>  			printk(KERN_DEBUG
>  				"ISOFS: changing to secondary root\n");
> -			iput(inode);
> +			if (inode != NULL)
> +				iput(inode);

This isn't needed. iput() handles NULL inode just fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

