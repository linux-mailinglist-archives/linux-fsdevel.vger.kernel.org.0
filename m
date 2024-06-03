Return-Path: <linux-fsdevel+bounces-20803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B992D8D808D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749F6286A43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3DD8405C;
	Mon,  3 Jun 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDdpM1Ro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uN37DMRB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDdpM1Ro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uN37DMRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7680039;
	Mon,  3 Jun 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412820; cv=none; b=Z0CxZ6i50EoS2nhmoVZWtsHNEboU06deGB5P/eN8/kUk0OVseaVH1/hPdsEt21C6byrsvKVopBfOYeV/9DBmM5B6NCEYR0FkujK8bYC6Z+kU12MTmqpQolT8vy+5OUbNLWs9D13hmZdU/n/93TUEYNecQvYbdU4HeVO4Xj+S+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412820; c=relaxed/simple;
	bh=jpy/t4O5aug/QVun/lz9D3QhkYTLyhBuH0/Zjq/W8qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQY1edGDcJTlb8e0hwR6yIUwPzKaYgNkDMp0TbkXX1GMtP6kdJYDnXzXt9oc1quyrxj5XsFYs4+MiqtqibRRKM61dtrPgzFbXOKGVtgSzoRZAOximmqc5sb/vLK9DFHVRmWJ/Wb61hlIt7KxAUYlXZQZbcG9Rs2q1V0YYw0yNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDdpM1Ro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uN37DMRB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDdpM1Ro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uN37DMRB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1F0B20031;
	Mon,  3 Jun 2024 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717412816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFSsFy81xNrHmazv14zuGs8br6dMUAF3G45dAiFtbbk=;
	b=MDdpM1RoyS6yzpbMhJ4GUtv1nYkXn3gVxVu8j836RHYrG2b8bpXOFAMj7HO6jLGWHkwvEk
	EuuLrrWr4mS0yc0C4RpsRpgEQrYZQhf6iJ2u9/Chg/WAMxJbS7WYfCn64BIkgLTUmVk86o
	xvdZKwH0KOPomSp75Xvi3Aiy4uzUUSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717412816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFSsFy81xNrHmazv14zuGs8br6dMUAF3G45dAiFtbbk=;
	b=uN37DMRBrvEnKBB4IuOB6DOm+4G7kdTAtj6G/Xwtc8LYOwHrPw3Ed2HA3+YAbT+X5qocsy
	iaLZyxpKNkt5UCBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MDdpM1Ro;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uN37DMRB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717412816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFSsFy81xNrHmazv14zuGs8br6dMUAF3G45dAiFtbbk=;
	b=MDdpM1RoyS6yzpbMhJ4GUtv1nYkXn3gVxVu8j836RHYrG2b8bpXOFAMj7HO6jLGWHkwvEk
	EuuLrrWr4mS0yc0C4RpsRpgEQrYZQhf6iJ2u9/Chg/WAMxJbS7WYfCn64BIkgLTUmVk86o
	xvdZKwH0KOPomSp75Xvi3Aiy4uzUUSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717412816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFSsFy81xNrHmazv14zuGs8br6dMUAF3G45dAiFtbbk=;
	b=uN37DMRBrvEnKBB4IuOB6DOm+4G7kdTAtj6G/Xwtc8LYOwHrPw3Ed2HA3+YAbT+X5qocsy
	iaLZyxpKNkt5UCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9367A13A93;
	Mon,  3 Jun 2024 11:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oe6vI9CjXWaeIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 11:06:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44F94A087F; Mon,  3 Jun 2024 13:06:52 +0200 (CEST)
Date: Mon, 3 Jun 2024 13:06:52 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readdir: Remove unused header include
Message-ID: <20240603110652.5hjcsajjjmefv63i@quack3>
References: <20240602101534.348159-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602101534.348159-2-thorsten.blum@toblux.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A1F0B20031
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Sun 02-06-24 12:15:35, Thorsten Blum wrote:
> Since commit c512c6918719 ("uaccess: implement a proper
> unsafe_copy_to_user() and switch filldir over to it") the header file is
> no longer needed.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/readdir.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 5045e32f1cb6..d6c82421902a 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -22,8 +22,6 @@
>  #include <linux/compat.h>
>  #include <linux/uaccess.h>
>  
> -#include <asm/unaligned.h>
> -
>  /*
>   * Some filesystems were never converted to '->iterate_shared()'
>   * and their directory iterators want the inode lock held for
> -- 
> 2.45.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

