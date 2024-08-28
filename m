Return-Path: <linux-fsdevel+bounces-27562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEDE96264A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AF51F23DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC21172767;
	Wed, 28 Aug 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dQ+2oV2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NQk4GbpW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZxo/Ji4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p4D6y0Ku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652115B12F;
	Wed, 28 Aug 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845629; cv=none; b=KkYZQ3WBvrzObciXHw+s2asE804En/q4as+AX/P69ILo+oreSOdoNDLs4gkVf7FmpYKNkqEbkScKBGe2XxZwxb39u4/L3GRRPo5tp8n3jbqvtJESuj7ge08JqloFb/o/9GltJnmfk//lj8Avgo4qsc3c8aTLtbhjLRNP/6Ui5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845629; c=relaxed/simple;
	bh=Enm6138RgDorhRk3wxn+bP/C4XQ9FuqyGaItLvRMgdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSCXPHZLHRBHJT9/0W6VSdnHC6JYn7HROGIKIopJhTb/BS12PV1aQsOe/Kq96DRQ4iuFMyL3OXltEdVRoGj37rHWqbCmUw7zd/GXmAHbUerXXbsLyW8QnpfX1s5xhpkC/xTLRWKDvqKqVYslrC4T+5roi/Jpdt20unBk/1REN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dQ+2oV2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NQk4GbpW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZxo/Ji4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p4D6y0Ku; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FBB221CCD;
	Wed, 28 Aug 2024 11:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724845625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujrJinPxS9XcnTqjoRDZaPXZgAYarh+WtsinJKeeaNU=;
	b=dQ+2oV2GEe3BvxPTGq9PA3L7lTDgbkOrxTgQ1TwoHH3yxksYHRTzLWOkLdGxfdrbTbohKn
	PteOIjZNuBlfhKJckDq6Ksu4Zt5xLH5CTu9FQgLaAIy83jdbZCDmS4mdgLfvrbtUQ3Vku1
	g/j/PxZSjpvOyKkf577hfRxX5B0jliU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724845625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujrJinPxS9XcnTqjoRDZaPXZgAYarh+WtsinJKeeaNU=;
	b=NQk4GbpW8gCSRyJXqumTanIcjbNWiEWxGT3EM1iPwaysyTaCUoXIkn3fRW9ehC4Af9km/e
	OCZ9jigssEUt1RCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="tZxo/Ji4";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p4D6y0Ku
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724845624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujrJinPxS9XcnTqjoRDZaPXZgAYarh+WtsinJKeeaNU=;
	b=tZxo/Ji4F7JauhlytQiILq0fzXLkVABvocO30orpIke4CtIqChLoZGKiByH0wbz0Ihwxof
	PtNk5xt3Xfe/CGU6B945PDRfO1dH4V0n8mQxetFV7s94IA5eCzvtnM+IZxM1YJ6K7ZDR23
	BW1OM/RrBsTblpCbo4JSSuclFWPgFMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724845624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujrJinPxS9XcnTqjoRDZaPXZgAYarh+WtsinJKeeaNU=;
	b=p4D6y0KuyNEN8e/GlJbuqzz8wko685ztXfeAlsVL4pR1jGpR89OG/HPNOnc4pSk6IesmxH
	Shsazly+0gePudDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AB681398F;
	Wed, 28 Aug 2024 11:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GRIIGjgOz2ZeBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 11:47:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E4B4A0968; Wed, 28 Aug 2024 13:47:04 +0200 (CEST)
Date: Wed, 28 Aug 2024 13:47:04 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] mnt_idmapping: Use kmemdup_array instead of kmemdup
 for multiple allocation
Message-ID: <20240828114704.mjzb3pxnjt45lt45@quack3>
References: <20240823015542.3006262-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823015542.3006262-1-yujiaoliang@vivo.com>
X-Rspamd-Queue-Id: 7FBB221CCD
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 23-08-24 09:55:41, Yu Jiaoliang wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> v2:Add a new modification for reverse array.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/mnt_idmapping.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 3c60f1eaca61..79491663dbc0 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -228,15 +228,15 @@ static int copy_mnt_idmap(struct uid_gid_map *map_from,
>  		return 0;
>  	}
>  
> -	forward = kmemdup(map_from->forward,
> -			  nr_extents * sizeof(struct uid_gid_extent),
> -			  GFP_KERNEL_ACCOUNT);
> +	forward = kmemdup_array(map_from->forward, nr_extents,
> +				sizeof(struct uid_gid_extent),
> +				GFP_KERNEL_ACCOUNT);
>  	if (!forward)
>  		return -ENOMEM;
>  
> -	reverse = kmemdup(map_from->reverse,
> -			  nr_extents * sizeof(struct uid_gid_extent),
> -			  GFP_KERNEL_ACCOUNT);
> +	reverse = kmemdup_array(map_from->reverse, nr_extents,
> +				sizeof(struct uid_gid_extent),
> +				GFP_KERNEL_ACCOUNT);
>  	if (!reverse) {
>  		kfree(forward);
>  		return -ENOMEM;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

