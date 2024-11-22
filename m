Return-Path: <linux-fsdevel+bounces-35575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4139D5EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7871F2216E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E541DED6D;
	Fri, 22 Nov 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZCbmGaVK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TFbArNtu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xdYKkDnc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pNe5Lt8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F91DE8B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279509; cv=none; b=BN7ZOnde3jsEE0h3Xl+xFxaWc3Q/nECX66VkzxrfLUEuLVJouEcwGI4T17BmIk7ba3oGvQVuNV/4mqRQLOdBmCKk59BZWlDCf6AHIrHMiXhF8SFgdGmDzskiSljEkNc75Rz7D2vvLzyvz56F1lRDxDstccJJtHo3Vp15WHnbnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279509; c=relaxed/simple;
	bh=etMzpbTN7DNo6dMbGjCEvNx3zySfwVX8arPDZugzvok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPziW2dMa0vOxhmKPNMuZ4Xo+QVYO2vbGblmPcOWQCev9Hols6FC6Cwt5ihJWjokJKS46Lfc79wU+XDa9pVKXp2fKxmlgZZXb8yeVVgrNpde1ES8Q8bEMWXpj3a0k+xEwNLfv9oBr68RFTgzg4LG7d0evc59ydQ4CHHd8inG7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZCbmGaVK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TFbArNtu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xdYKkDnc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pNe5Lt8d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E64331F37E;
	Fri, 22 Nov 2024 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732279506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQbx9ex1TNo29hhptwpTfNa6Rp2/Q2hMUKd5wWv0kCI=;
	b=ZCbmGaVKak4lJ59CHyBS72EslrtubDk9FBm4SCToElwXhHAaXtL5uC1Hz/1217NToyoabj
	WgedtBjRLdOegMOF/nQAB6cKC0eyMPX2AZfhkOWLDZrDZh7Fdbg8Pl7yEeH3yyBmYc4m69
	5NP6CQk4ShvR5nSOVqrTgq3qqcKEOhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732279506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQbx9ex1TNo29hhptwpTfNa6Rp2/Q2hMUKd5wWv0kCI=;
	b=TFbArNtup9nbfgqsjvVw6tmbn5yD/sciZY0/qESTDp/MoaI+LS24ol2eFM9D3NvBGaFYlZ
	sbQfOWrSLnQmSaCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xdYKkDnc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pNe5Lt8d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732279504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQbx9ex1TNo29hhptwpTfNa6Rp2/Q2hMUKd5wWv0kCI=;
	b=xdYKkDnc5RkcsPEQ6IzRpXiT0dr4wYIoFdCxMqEWgQEXfm4/SAJULma5Jb6vbqUm/lbpb3
	zoL0rTRnfIJX+a81zEFkfghqAOySl0p1gQ/rv+QxwZItbNqg54ZAlZAU7hdRhv+PWa/86H
	bWRsQIroS5rxC6lqqByuwXj2pPNZYxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732279504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQbx9ex1TNo29hhptwpTfNa6Rp2/Q2hMUKd5wWv0kCI=;
	b=pNe5Lt8d7JeEVofM7+Nk0iFNPytZHbFJSf0DT+pbFnvB3oYXlInFCWo26zmVUj/KYkhy8b
	etBZQIxE3AgJAECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8166138A7;
	Fri, 22 Nov 2024 12:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oTpvNNB8QGcySgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Nov 2024 12:45:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7BF1EA08B5; Fri, 22 Nov 2024 13:45:00 +0100 (CET)
Date: Fri, 22 Nov 2024 13:45:00 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: require inode_owner_or_capable for F_SET_RW_HINT
Message-ID: <20241122124500.xowqviyirjuhfbbq@quack3>
References: <20241122122931.90408-1-hch@lst.de>
 <20241122122931.90408-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122122931.90408-2-hch@lst.de>
X-Rspamd-Queue-Id: E64331F37E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 22-11-24 13:29:24, Christoph Hellwig wrote:
> F_SET_RW_HINT controls data placement in the file system and / or
> device and should not be available to everyone who can read a given file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fcntl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 22dd9dcce7ec..7fc6190da342 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -375,6 +375,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>  	u64 __user *argp = (u64 __user *)arg;
>  	u64 hint;
>  
> +	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
> +		return -EPERM;
> +
>  	if (copy_from_user(&hint, argp, sizeof(hint)))
>  		return -EFAULT;
>  	if (!rw_hint_valid(hint))
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

