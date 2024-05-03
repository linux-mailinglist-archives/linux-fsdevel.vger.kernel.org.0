Return-Path: <linux-fsdevel+bounces-18599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7148BAA5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147A51F22E9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB932150988;
	Fri,  3 May 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NPA6SC/u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yok2G7sc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NPA6SC/u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yok2G7sc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95315350C;
	Fri,  3 May 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730060; cv=none; b=mS+ZgVR2yM7YYm44iWxFUs67oC3/1eMD1rAZ3t3EkpyJorq4VuemxxsR1vtMm7nEg+w7c2MiTaYb9tkAA6iKcTmo5k7CwiL+BOqgXckfMoNkpC68/FMIdYtppsAT7NJYJlomqqf2r2izFwXc40neLEVL3rT+vw3GVRWgEWRN8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730060; c=relaxed/simple;
	bh=T0RczkCF20dLomuGd+qHgTknHJxdWjNZZYLckdB9zTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIlXUslqxidZQfGFpPZX2ab9MFfmL5W+JD5Gzc5PJihSsyD49c/4lh8306bUW6j/RQsTvrv9IjLKLWyIZ8X2dJgpkRAbvhR26ajsHGVJGAksZJLV8v0WcRaC5I6Tk0xQhR7bMsEpTv+NZDNOhd4WbsgFKTX9DF5xZMPRv6DBCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NPA6SC/u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yok2G7sc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NPA6SC/u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yok2G7sc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDE132006B;
	Fri,  3 May 2024 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714730056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2Ac31NyZWUsS3N3akq2d+LIqGw4LB1ZTrN8Yb0GFFk=;
	b=NPA6SC/uao2PxHnxKGeZ51JbD+gPhZPfQ65EXAK2xNYiSExVEmLXwwrH2FgpNopjX14moW
	TxvTCNbstyKJgU5Y031vGyoOd7fEn6+0oEz+RBouIJs91/Mgi/R5dEOJ6wV0km8d7I9Z1u
	/oTWmC4NdRXzILx2h3a/zJDJISg6Lag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714730056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2Ac31NyZWUsS3N3akq2d+LIqGw4LB1ZTrN8Yb0GFFk=;
	b=Yok2G7scOKdaVzGai+0NAkUgYEYYxY1LqNpCfWf+/fvPZqK6uLzdo0wCBabvDWjVUZ0kj5
	0rGLhf24NPcRy1Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="NPA6SC/u";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Yok2G7sc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714730056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2Ac31NyZWUsS3N3akq2d+LIqGw4LB1ZTrN8Yb0GFFk=;
	b=NPA6SC/uao2PxHnxKGeZ51JbD+gPhZPfQ65EXAK2xNYiSExVEmLXwwrH2FgpNopjX14moW
	TxvTCNbstyKJgU5Y031vGyoOd7fEn6+0oEz+RBouIJs91/Mgi/R5dEOJ6wV0km8d7I9Z1u
	/oTWmC4NdRXzILx2h3a/zJDJISg6Lag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714730056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2Ac31NyZWUsS3N3akq2d+LIqGw4LB1ZTrN8Yb0GFFk=;
	b=Yok2G7scOKdaVzGai+0NAkUgYEYYxY1LqNpCfWf+/fvPZqK6uLzdo0wCBabvDWjVUZ0kj5
	0rGLhf24NPcRy1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2BEB139CB;
	Fri,  3 May 2024 09:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gtqhK0i0NGZ6OgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 May 2024 09:54:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57F30A0A12; Fri,  3 May 2024 11:54:16 +0200 (CEST)
Date: Fri, 3 May 2024 11:54:16 +0200
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext2: Remove LEGACY_DIRECT_IO dependency
Message-ID: <20240503095416.u3msp4eaamjwcm32@quack3>
References: <f3303addc0b5cd7e5760beb2374b7e538a49d898.1714727887.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3303addc0b5cd7e5760beb2374b7e538a49d898.1714727887.git.ritesh.list@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.61
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BDE132006B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.61 / 50.00];
	BAYES_HAM(-2.60)[98.23%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]

On Fri 03-05-24 14:58:52, Ritesh Harjani (IBM) wrote:
> commit fb5de4358e1a ("ext2: Move direct-io to use iomap"), converted
> ext2 direct-io to iomap which killed the call to blockdev_direct_IO().
> So let's remove LEGACY_DIRECT_IO config dependency from ext2 Kconfig.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/ext2/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext2/Kconfig b/fs/ext2/Kconfig
> index d6cfb1849580..d5bce83ad905 100644
> --- a/fs/ext2/Kconfig
> +++ b/fs/ext2/Kconfig
> @@ -3,7 +3,6 @@ config EXT2_FS
>  	tristate "Second extended fs support (DEPRECATED)"
>  	select BUFFER_HEAD
>  	select FS_IOMAP
> -	select LEGACY_DIRECT_IO
>  	help
>  	  Ext2 is a standard Linux file system for hard disks.
> 
> --
> 2.44.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

