Return-Path: <linux-fsdevel+bounces-28535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CBF96B86C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CD5283BCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9F1CF7C6;
	Wed,  4 Sep 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2wegCgE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMyC2S/G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vW9+Ae3q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QzCXnza6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE81CF5F2;
	Wed,  4 Sep 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445560; cv=none; b=X1L9/Kl9WvD5CoY4lTHgMuzKnqSZCH8xg0SK16E9FJVtAi4W5LvzvzHd3+c8UbQnrA4RwDkUlE56QuXWARCcVgQl/kdWyW5ukzUQBLSKi+9f4MUHDjFfj0KnHoSkeFAQv7El92JwFb+Q603+30E+MqHc0gyRzYSSMUkxdjsxcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445560; c=relaxed/simple;
	bh=q4as4XDVvwS3kMvrlVkdV/pDI8QxGcewH6j2WlOSWXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3p+tiqPsYMOgLTvH1d6CN20BMj2S4dbG0sjGKR8Msu7CEl9F+CjLcl/vFxlR6qEyZlSpjAkobLVfLy9rXBfB82T0PltrME6OLTrdcwaVb3903V44fyqrNdtf2tKJr0ma958wdMeU5kWUQHpR1cdvZdii7RDPHpHwF01g2+SeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2wegCgE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMyC2S/G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vW9+Ae3q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QzCXnza6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23178219EA;
	Wed,  4 Sep 2024 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4hpI9e1wugmOeK0G5MLa5XAjHvJjYP939/FinYjtc0=;
	b=P2wegCgEo3UoCx1fNkAh9hF4XhyRTgIadxg6G2KlVfw94rfB4dZja+zEbBAhWeb2/vUmw5
	O1RXDs0TOj6vDizd5JkdeynHBakcJgm9lUWvaXm1bcS2H/IjqTiPc/XOKjVvVT/pGN7dtW
	fq4G8OGlMV72Oen8pacWGAAOggIn8gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4hpI9e1wugmOeK0G5MLa5XAjHvJjYP939/FinYjtc0=;
	b=EMyC2S/GyPelKCbdp2qAfHNZ3qF2uyW7H3wp/t6mGM5gA8aniK2u3aSXrYNJOs4ncZWAW/
	akYHfUbizf0kzxDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vW9+Ae3q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QzCXnza6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4hpI9e1wugmOeK0G5MLa5XAjHvJjYP939/FinYjtc0=;
	b=vW9+Ae3qiAGDxhKE7tmW4oDJAsZBA12rueKr0b9pkoPfqgrKwtftH+mTL06Pj7jCTkQzLK
	ek5fMb6eTy0Rz2QUKTXNxQpoRNq69ABeY4vvkVg8lw6AX0bs0AZVVDKbEbdRTkfx7j8Dth
	18K37Uw3scJtnjdfZFHhp1jxLFfJ2JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4hpI9e1wugmOeK0G5MLa5XAjHvJjYP939/FinYjtc0=;
	b=QzCXnza62i/TNjeB9JoXfQQhLhuyYzfGJNykVv0DmuMwA0oYeh3PX/AxruLCZI/kMpIdzA
	zm2kbWbTWGMf3mDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18828139D2;
	Wed,  4 Sep 2024 10:25:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IgH7BbQ12GaVKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:25:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7B1EA0968; Wed,  4 Sep 2024 12:25:51 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:25:51 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 09/12] ext4: drop unused ext4_es_store_status()
Message-ID: <20240904102551.vgwlivosmk6ysh6j@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-10-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 23178219EA
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email,huawei.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 13-08-24 20:34:49, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The helper ext4_es_store_status() is unused now, just drop it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Yes. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/extents_status.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 47b3b55a852c..3ca40f018994 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -224,13 +224,6 @@ static inline void ext4_es_store_pblock(struct extent_status *es,
>  	es->es_pblk = block;
>  }
>  
> -static inline void ext4_es_store_status(struct extent_status *es,
> -					unsigned int status)
> -{
> -	es->es_pblk = (((ext4_fsblk_t)status << ES_SHIFT) & ES_MASK) |
> -		      (es->es_pblk & ~ES_MASK);
> -}
> -
>  static inline void ext4_es_store_pblock_status(struct extent_status *es,
>  					       ext4_fsblk_t pb,
>  					       unsigned int status)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

