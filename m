Return-Path: <linux-fsdevel+bounces-29298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73700977D85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0216028816E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD31DC04F;
	Fri, 13 Sep 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZFRm+Ca";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PtiA7dTM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZFRm+Ca";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PtiA7dTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1A1D88D5;
	Fri, 13 Sep 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223393; cv=none; b=rapTglMXrpVoywzLtzIvzTJYQeO6iqPY9hBWsGLte5QGfiM3DVyvdaIr0C1G8/HCUnRFWmq3LggoXx8z6c5SJJduWmn5UaW8FhqDGrAwnRoFlAwvdWe5pQcyo48Btrz6Jsh6Z8sN6Jk4xopl/x9j5lfieAXFNrEmDyj4M90fBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223393; c=relaxed/simple;
	bh=HUmiTqPLbAZY3bNkVA9UH/T36bc4eOZWyjZh+L/c9a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDmcbX94ReuW3UZZqNGRC4nKVEU4sY0BG4nTYRCnuilUnjbxGI5+Objsf0wcw1TzlH7rKvsMdocEE6vSFAJbnby+6S6P4ouRDQc+bwQ8hwt5J12CK68e3OY4w6GendxrL73cNieIdoTGBbacG2c4sWI4lxRd5hwIDNW8BG+xhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZFRm+Ca; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PtiA7dTM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZFRm+Ca; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PtiA7dTM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C209219CE;
	Fri, 13 Sep 2024 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726223384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlpatbU7/aMWmzQ7CP6MTvrOgrJwCCTYZ0D5bxXA+PI=;
	b=1ZFRm+CaDk3k8Ym4r5BxIt4aOmL8tA0Pd9pVe41O7AKrDHcAb1lBnMpHLJYp2vaHj0A2gK
	c0bbgYNTgEi44c6ocoyMgWMpIRqMytTxzhO8NGxBuVBdst6or2uCw+KiS60ZniyQamg9Gw
	UHb+9+ijx7qajTnqP/7FAsrmLwK46yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726223384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlpatbU7/aMWmzQ7CP6MTvrOgrJwCCTYZ0D5bxXA+PI=;
	b=PtiA7dTMt+aUMzaoKRdlcvQN0vpBFA8Pr4b10V9jrsX6SYZ4tk3mZ7gIVBPTJQ1fL63D1j
	rnuQO18uxkiEruAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726223384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlpatbU7/aMWmzQ7CP6MTvrOgrJwCCTYZ0D5bxXA+PI=;
	b=1ZFRm+CaDk3k8Ym4r5BxIt4aOmL8tA0Pd9pVe41O7AKrDHcAb1lBnMpHLJYp2vaHj0A2gK
	c0bbgYNTgEi44c6ocoyMgWMpIRqMytTxzhO8NGxBuVBdst6or2uCw+KiS60ZniyQamg9Gw
	UHb+9+ijx7qajTnqP/7FAsrmLwK46yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726223384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlpatbU7/aMWmzQ7CP6MTvrOgrJwCCTYZ0D5bxXA+PI=;
	b=PtiA7dTMt+aUMzaoKRdlcvQN0vpBFA8Pr4b10V9jrsX6SYZ4tk3mZ7gIVBPTJQ1fL63D1j
	rnuQO18uxkiEruAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20F9013A73;
	Fri, 13 Sep 2024 10:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZQoDCBgU5GZZZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Sep 2024 10:29:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF3F9A08EF; Fri, 13 Sep 2024 12:29:35 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:29:35 +0200
From: Jan Kara <jack@suse.cz>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>, mhocko@suse.cz
Subject: Re: [PATCH -next] fs/inode: Modify mismatched function name
Message-ID: <20240913102935.maz3vf42jkmcvfcn@quack3>
References: <20240913011004.128859-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913011004.128859-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 13-09-24 09:10:04, Jiapeng Chong wrote:
> No functional modification involved.
> 
> fs/inode.c:242: warning: expecting prototype for inode_init_always(). Prototype was for inode_init_always_gfp() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10845
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

I think this is a fallout from Michal's patch [1] which will be respinned
anyway AFAIU. Michal, can you please fixup the kernel doc when sending new
version of the patch? Thanks!

								Honza

[1] https://lore.kernel.org/all/20240827061543.1235703-1-mhocko@kernel.org/

> ---
>  fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index c391365cdfa7..6763900a7a87 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -229,7 +229,7 @@ static int no_open(struct inode *inode, struct file *file)
>  }
>  
>  /**
> - * inode_init_always - perform inode structure initialisation
> + * inode_init_always_gfp - perform inode structure initialisation
>   * @sb: superblock inode belongs to
>   * @inode: inode to initialise
>   * @gfp: allocation flags
> -- 
> 2.32.0.3.g01195cf9f
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

