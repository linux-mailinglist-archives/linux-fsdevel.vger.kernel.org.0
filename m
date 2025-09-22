Return-Path: <linux-fsdevel+bounces-62384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27856B90637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EB2189EB77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57C3090F9;
	Mon, 22 Sep 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxR8QPeJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tp9CHrZS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxR8QPeJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tp9CHrZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F583054F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540688; cv=none; b=YbagnSjmyBHINNCxSpnxLj56ALzl5Ak02vj+UuMZwqCQNMNE829iThFgNKGXjJmg+Z6RxRZCnonLgUUTLm371XjNQytUc6Kq4qr2HgcGgzVGHYHWSGsCObfqkPXnt6DH5XJkDftHMfWE67iEoSHczywRN03xsK9x03w0WtTfSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540688; c=relaxed/simple;
	bh=reYfWOi918Ulg2cuhqR/zeKkhW2tpcQpYWtD59+SRjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/0RvuoWhrViKfZSrD5494QcxVDdhNfkNjdhMk/5Pc9Dan1Bkznp6DYtIW70Zpr/SP0DRklN6KXYlIFH5cF8H9tndZj4xiaGRbt006PA2DKxqjXKsGnp7u87tT/alMnQHbeiTKVkLVvCFmvBhlCVaOOO5w/vqMrcrXOKhoyaI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxR8QPeJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tp9CHrZS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxR8QPeJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tp9CHrZS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B66F211EA;
	Mon, 22 Sep 2025 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758540684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0WtXU1txr+PudB85nWSdZWaXTLDKrsojYDBAhwl6do=;
	b=RxR8QPeJhVIxQivbpihvOVQjcFhAUNQK4/NGyXgyoKBVUxqzsR/wCn4nEVuO855ROjSlQm
	znLbrkIF7uIODcO09pmQ46kW+7Kjmfp+Yl94r5nAFAeL+bKmVxr3Dyps9NZWeZlB7hwqR/
	iuIwYD7uPT0h18XnnKsSHSJZX7B6kLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758540684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0WtXU1txr+PudB85nWSdZWaXTLDKrsojYDBAhwl6do=;
	b=tp9CHrZSq2rYbHd/6HmiFXRo1FHoFuVJfr2xr/zUul+EmLNB24sXyOILl+oAyYCjELDkuT
	ejFL12khUrdIx3AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RxR8QPeJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tp9CHrZS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758540684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0WtXU1txr+PudB85nWSdZWaXTLDKrsojYDBAhwl6do=;
	b=RxR8QPeJhVIxQivbpihvOVQjcFhAUNQK4/NGyXgyoKBVUxqzsR/wCn4nEVuO855ROjSlQm
	znLbrkIF7uIODcO09pmQ46kW+7Kjmfp+Yl94r5nAFAeL+bKmVxr3Dyps9NZWeZlB7hwqR/
	iuIwYD7uPT0h18XnnKsSHSJZX7B6kLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758540684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0WtXU1txr+PudB85nWSdZWaXTLDKrsojYDBAhwl6do=;
	b=tp9CHrZSq2rYbHd/6HmiFXRo1FHoFuVJfr2xr/zUul+EmLNB24sXyOILl+oAyYCjELDkuT
	ejFL12khUrdIx3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F34E1388C;
	Mon, 22 Sep 2025 11:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NbexA4wz0WhYUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 11:31:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BBCD2A07C4; Mon, 22 Sep 2025 13:31:23 +0200 (CEST)
Date: Mon, 22 Sep 2025 13:31:23 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v5 3/4] Manual conversion of ->i_state uses
Message-ID: <ayjwe2moaswosrvcv6mhd2wztwvexfjgy6dfnxxegnhppca7ac@75h6kmoj32e6>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
 <20250919154905.2592318-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919154905.2592318-4-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1B66F211EA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 19-09-25 17:49:03, Mateusz Guzik wrote:
> Takes care of spots not converted by coccinelle.
> 
> Nothing to look at with one exception: smp_store_release and
> smp_load_acquire pair replaced with a manual store/load +
> smb_wmb()/smp_rmb(), see I_WB_SWITCH.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

...

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 0e9e96f10dd4..745df148baaa 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -478,8 +478,8 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
>  	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
>  	 */
> -	smp_store_release(&inode->i_state,
> -			  inode_state_read(inode) & ~I_WB_SWITCH);
> +	smp_wmb();
> +	inode_state_del(inode, I_WB_SWITCH);
>  
>  	xa_unlock_irq(&mapping->i_pages);
>  	spin_unlock(&inode->i_lock);

Comments need updating here and in backing-dev.h...

> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index e721148c95d0..720e5f8ad782 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -292,7 +292,8 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
>  	 * Paired with store_release in inode_switch_wbs_work_fn() and
>  	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
>  	 */
> -	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
> +	cookie->locked = inode_state_read(inode) & I_WB_SWITCH;
> +	smp_rmb();
>  
>  	if (unlikely(cookie->locked))
>  		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

