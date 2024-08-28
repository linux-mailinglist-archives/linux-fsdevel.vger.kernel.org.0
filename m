Return-Path: <linux-fsdevel+bounces-27553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DB96255F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884ED1C20ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A6116C68C;
	Wed, 28 Aug 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n1cGnE/N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bqaWrCLt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PPGikH2x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t5lWNckI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E4145323
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842768; cv=none; b=YDQ7CjC7Zs77rcv6K0w23IsJY+ZICj/qWJI1trykTs586eSHUOZ2euZdqN7x7WFUXc1+xBawQGIdC4mAfyh39m2+oQrPiZd5xoHsSMaMG4Il9STZMGwcEQgvAb8f4nXJ15BU7NAgIhc4dQvTfnIYSaDGxDkr7PjzT5x0BWAT8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842768; c=relaxed/simple;
	bh=xqU3/rG9jRKr/1HV5btau19C57Q1wMFL7G6UCS1xAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkxi9bBtH1J4fbab5cGWfJaQGuo6v/zLfe03pwWT8PsuiK4MpNeJ6R83SqJHyYVT7GybDJS0mAzWhEAQ/HdskfA5Y2PeczqMaJ6WPxNXSb6PJ+7Va8KeNaaMG2aw6uh2HVa5nyBDevUXGnrbky8BEbPaYREEH+o0RM1c+JWOsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n1cGnE/N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bqaWrCLt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PPGikH2x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t5lWNckI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D7221FBED;
	Wed, 28 Aug 2024 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724842764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl+xe1oZROAufIxZpWFD/rVemi0ir14hnt+05YY4FRA=;
	b=n1cGnE/NyCt/LwD4gM+x+ogUkVrEhk7yOot+lIrWEI/ejfaGlmJ0v33cHg2QHXg52Y/2XO
	WeS0sF7bN6s6Jm/yEzitPYDzzDU7o5oDlHhwRY0v8ahrpVnPxpRtJW5dXZ0N6m+GPZ8NCh
	ahQzVlFLBm5K1Jnhdssw4iJS8bgNJAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724842764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl+xe1oZROAufIxZpWFD/rVemi0ir14hnt+05YY4FRA=;
	b=bqaWrCLtsaXYPrwOeAjoI8b/puEjztnXGxhIUMHOhfL1VMy227nbOWzeglX77lY4RU1NAp
	WuwCuUu17SdjHuBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724842763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl+xe1oZROAufIxZpWFD/rVemi0ir14hnt+05YY4FRA=;
	b=PPGikH2xIxCYlBqTulrVkbdIg2LbhP+j+7gTW8mxDhs4QTcQ/G/GQUEadVGrJmkbTwuLcv
	RRdiaQ7bUEwSeQGJNaycjxuMTpbuP4aFGhhL2bzWgejHb1eQVRIeqJX3S5ze0YyFGOiHxp
	0ChmqODyCwAZpEAgY6wtqzZuyxx8WOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724842763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl+xe1oZROAufIxZpWFD/rVemi0ir14hnt+05YY4FRA=;
	b=t5lWNckICl4tGFvlcdMpvoPDo/vP9UU0Bi60ty5QoHpgo3ZUKHfpdUHhQ2MF9d2VlXU5HQ
	DGHlJIgDXQ8HfzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ECA6138D2;
	Wed, 28 Aug 2024 10:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XFAXFwsDz2ZFdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 10:59:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E096AA0968; Wed, 28 Aug 2024 12:59:07 +0200 (CEST)
Date: Wed, 28 Aug 2024 12:59:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: s/__u32/u32/ for s_fsnotify_mask
Message-ID: <20240828105907.ghlzdaygfx4r7hmr@quack3>
References: <20240822-anwerben-nutzung-1cd6c82a565f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-anwerben-nutzung-1cd6c82a565f@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,suse.cz];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 22-08-24 11:30:58, Christian Brauner wrote:
> The underscore variants are for uapi whereas the non-underscore variants
> are for in-kernel consumers.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I didn't know this :). Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 23e7d46b818a..7eb4f706d59f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1273,7 +1273,7 @@ struct super_block {
>  	time64_t		   s_time_min;
>  	time64_t		   s_time_max;
>  #ifdef CONFIG_FSNOTIFY
> -	__u32			s_fsnotify_mask;
> +	u32			s_fsnotify_mask;
>  	struct fsnotify_sb_info	*s_fsnotify_info;
>  #endif
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

