Return-Path: <linux-fsdevel+bounces-41196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14905A2C35E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A144E7A2692
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B21EEA30;
	Fri,  7 Feb 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sAaW5P+r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbZBfjYH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sAaW5P+r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbZBfjYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE21A5BB1;
	Fri,  7 Feb 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934201; cv=none; b=Isw715xtyYqVPowKFM2KVxqnM2ev4R8Mlq1g9QOyaLvtJE6dNfpc7K1iCKEwD2uTiDXLnkNTjGCPiNmkA5ZsDqA8Guiwoz5tItcnJl1gKDzZTUnFPlsTTgaKb1TGQnL0eYWNiM6iNMpyo/2NV+ADQV8tgUSkYg766BOc9hLH8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934201; c=relaxed/simple;
	bh=5nTaQUvFxlMWygqAXJ5NTc4zhQFO1lwOJ/HjdO/0CC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs5MUD8Oq+dMwEhUuP4AkcLrP9pgbnlaIk2qBS4KwnokWcokKLiJ7pXc4agGBeEzZ6oAIzL/DP6qQrzbJvA1EaOBgAqSGsJDFB6VFFgqvSkrG7D1+XUbyhrrzjblxqh4PZylrEo4NFafYxyuMEEk/OATCAjhJ//k9Whwjw3++jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sAaW5P+r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbZBfjYH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sAaW5P+r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbZBfjYH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFB8521167;
	Fri,  7 Feb 2025 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738934197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+G7u8G4dZW1Z7wAr5j88Hm7ApvHhPGjX6mT8B9kPE4=;
	b=sAaW5P+rdsnMBfaocUynOEJClSpVBAZF14OCOs0p9KntgkF0/aj1Zkqx/Va2P2qbQd+yDw
	epk3KeKijRXbDBvEz0CoZRsUiueWWKsZFfPOTa+BUObmjdRxfx1Gjq7AYGC9PEJqD4+FBw
	B50vYSHV9gCYSMPTMZ74RIjxsh9KmLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738934197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+G7u8G4dZW1Z7wAr5j88Hm7ApvHhPGjX6mT8B9kPE4=;
	b=TbZBfjYHaUZQneyt5fRzHF7KUvHeRcABwqR7ilAMqC3kZCU8LlEuVufnObgiXzCNxvuHND
	XyJsuE475YwBy5AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738934197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+G7u8G4dZW1Z7wAr5j88Hm7ApvHhPGjX6mT8B9kPE4=;
	b=sAaW5P+rdsnMBfaocUynOEJClSpVBAZF14OCOs0p9KntgkF0/aj1Zkqx/Va2P2qbQd+yDw
	epk3KeKijRXbDBvEz0CoZRsUiueWWKsZFfPOTa+BUObmjdRxfx1Gjq7AYGC9PEJqD4+FBw
	B50vYSHV9gCYSMPTMZ74RIjxsh9KmLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738934197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+G7u8G4dZW1Z7wAr5j88Hm7ApvHhPGjX6mT8B9kPE4=;
	b=TbZBfjYHaUZQneyt5fRzHF7KUvHeRcABwqR7ilAMqC3kZCU8LlEuVufnObgiXzCNxvuHND
	XyJsuE475YwBy5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B00E13694;
	Fri,  7 Feb 2025 13:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /0HZJbUHpmfSJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Feb 2025 13:16:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4FD89A28E7; Fri,  7 Feb 2025 14:16:37 +0100 (CET)
Date: Fri, 7 Feb 2025 14:16:37 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] vfs: catch invalid modes in may_open()
Message-ID: <wve6u2kei6lfycbg7sogkjogd76tqoixfydop4dnhisgdcueep@uipa6akqgmuh>
References: <20250206170307.451403-1-mjguzik@gmail.com>
 <20250206170307.451403-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206170307.451403-3-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 06-02-25 18:03:06, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/namei.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..21630a0f8e30 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3415,6 +3415,8 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
>  		if ((acc_mode & MAY_EXEC) && path_noexec(path))
>  			return -EACCES;
>  		break;
> +	default:
> +		VFS_BUG_ON_INODE(1, inode);
>  	}
>  
>  	error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

