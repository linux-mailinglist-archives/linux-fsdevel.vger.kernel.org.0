Return-Path: <linux-fsdevel+bounces-73219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 668AAD12617
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4873085A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7309356A36;
	Mon, 12 Jan 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xmYIxAo5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pulubb06";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xmYIxAo5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pulubb06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85A280309
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218445; cv=none; b=GlPaDp5XW20Elzn7XufrDn+XcZNuWDkzXRIwwGii1GtzweNOFMzmrE9CzxW0/14m0gP44V4dRCakwywm0gLbNBPGDh4znZpxf4svZwpB92VYt7rA8MgigFXZCLX3oSKNHmyDYGalGAge/TKAqhyy89tBUBYjmuGbyMo14CFUu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218445; c=relaxed/simple;
	bh=YkqjyN8WME87j4ypoPUn82LSoorCUFzeTb7Ce4AHsnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixB+gA0W0b9r+ZRRl9wHGuIoN1H9NjdXGb1EhV5iCuIGWo6DoyARrdy/PpjSExwdCr/9BPVRTQqEtLi1etqwCb2b0HsshB7Cghof03oNL7ux+FPjLLWOp+G4KYbHFLpu6CvCBnJpkZGzRS8T3XmFMUHTssry6zvz0JsJG3ZrIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xmYIxAo5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pulubb06; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xmYIxAo5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pulubb06; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F69C33731;
	Mon, 12 Jan 2026 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768218442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+6OXiyg/YFPs7lZyX3PudwloLdm4MyI3XfGdWd2DKM=;
	b=xmYIxAo50nLAXi1DXL3ZwACFEITXSQ0Hph5OJ1r9PtBULgDQa0Gopasgddu3HyFCpp9WTQ
	VWmd/ItWApOAW0pjVM1yAz9acxeFeZVHYt5I/wWecNfgYnVEY5FYhNQiuRjZ+FxdRWyAek
	1LbTqaQovayCZMrxicpQbUCaitOJxHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768218442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+6OXiyg/YFPs7lZyX3PudwloLdm4MyI3XfGdWd2DKM=;
	b=Pulubb0623wv98T7HSrBRgsi9zpQMIRwL2zwMaXLpdYRm6Z5JI5zZ7pVkeBzIvXJhdxW60
	4JIpbh/E3l8cMiBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xmYIxAo5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Pulubb06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768218442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+6OXiyg/YFPs7lZyX3PudwloLdm4MyI3XfGdWd2DKM=;
	b=xmYIxAo50nLAXi1DXL3ZwACFEITXSQ0Hph5OJ1r9PtBULgDQa0Gopasgddu3HyFCpp9WTQ
	VWmd/ItWApOAW0pjVM1yAz9acxeFeZVHYt5I/wWecNfgYnVEY5FYhNQiuRjZ+FxdRWyAek
	1LbTqaQovayCZMrxicpQbUCaitOJxHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768218442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+6OXiyg/YFPs7lZyX3PudwloLdm4MyI3XfGdWd2DKM=;
	b=Pulubb0623wv98T7HSrBRgsi9zpQMIRwL2zwMaXLpdYRm6Z5JI5zZ7pVkeBzIvXJhdxW60
	4JIpbh/E3l8cMiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15C533EA63;
	Mon, 12 Jan 2026 11:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +CROBUrfZGnpRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Jan 2026 11:47:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BFC7EA0A7E; Mon, 12 Jan 2026 12:47:21 +0100 (CET)
Date: Mon, 12 Jan 2026 12:47:21 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: make insert_inode_locked() wait for inode destruction
Message-ID: <o2ypypbtb6jjlditunp67nir52qb3q7jr262nawh4cn5hfxlca@cgg3mshbsg77>
References: <20260111083843.651167-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111083843.651167-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 1F69C33731
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Sun 11-01-26 09:38:42, Mateusz Guzik wrote:
> This is the only routine which instead skipped instead of waiting.
> 
> The current behavior is arguably a bug as it results in a corner case
> where the inode hash can have *two* matching inodes, one of which is on
> its way out.
> 
> Ironing out this difference is an incremental step towards sanitizing
> the API.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Agreed, it's an odd difference between the two inode insertion apis. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f8904f813372..3b838f07cb40 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1832,16 +1832,13 @@ int insert_inode_locked(struct inode *inode)
>  	while (1) {
>  		struct inode *old = NULL;
>  		spin_lock(&inode_hash_lock);
> +repeat:
>  		hlist_for_each_entry(old, head, i_hash) {
>  			if (old->i_ino != ino)
>  				continue;
>  			if (old->i_sb != sb)
>  				continue;
>  			spin_lock(&old->i_lock);
> -			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> -				spin_unlock(&old->i_lock);
> -				continue;
> -			}
>  			break;
>  		}
>  		if (likely(!old)) {
> @@ -1852,6 +1849,11 @@ int insert_inode_locked(struct inode *inode)
>  			spin_unlock(&inode_hash_lock);
>  			return 0;
>  		}
> +		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> +			__wait_on_freeing_inode(old, true);
> +			old = NULL;
> +			goto repeat;
> +		}
>  		if (unlikely(inode_state_read(old) & I_CREATING)) {
>  			spin_unlock(&old->i_lock);
>  			spin_unlock(&inode_hash_lock);
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

