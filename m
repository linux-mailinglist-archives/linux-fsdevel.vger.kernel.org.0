Return-Path: <linux-fsdevel+bounces-49128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2AAB852F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEC16906A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865B0298981;
	Thu, 15 May 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="debK0Nr7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UF8E//dH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="debK0Nr7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UF8E//dH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAD298253
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309668; cv=none; b=WC7PQSZqRPNSVcIJhDz1IbMY2K7DKa6k1sVNQUmOcfwQ79kksGNJCCwHJvefko7rTLUSIsrhF+nuFXXIz3I4ql7T0xN6RfRkMbjq22aikFRQb9pNVcaXnqmPUcjnG718Ce2lPATqi1N8kh5T9mpt3sX9wi3OdDWAEypesmMXI6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309668; c=relaxed/simple;
	bh=zUVyxbhWjFuorrF/a4kP4qtrfJjqJHcXI9Ez9tuV8q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzLAa/wjZE9c0/s/HJknfV2HBx9o/RS8LWg5WYCiY4LRnvZ01wZ0qyDk9rRnzvWPGtWVy2Gg3D0WWLDy/waT5teKTZ/qy9O/mGfb9EAEf+GAdGuxwjjYCzIHQ+jsMGgVLg4cwxkMzpnwbs5Lr1h/tejX/GFCfyqa9cLhb7V/JSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=debK0Nr7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UF8E//dH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=debK0Nr7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UF8E//dH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 921601F391;
	Thu, 15 May 2025 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747309664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P3F3Szd7PRBmf+6JunC5ebnIxmdnh36JcmraQsCgto=;
	b=debK0Nr7g6huppII/+jI4pmoz6yUOdrJVpl0utsru9y7a/zjDWWrLkMeeju0iwLBrFoNx0
	NDs1Biz/6vQqv9CTDC4KoQ/qhH+KHHhjwjg17Sx9BigCcsU6Xa4yt8+j+SPYnbbo2AwF0D
	JpmtBoGzMMWcTLTgsXM6+MD+A/VQQRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747309664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P3F3Szd7PRBmf+6JunC5ebnIxmdnh36JcmraQsCgto=;
	b=UF8E//dHlEkW6ngPnec+fEMT+5uvVaRhXWJdBMSL2xswd/rhqJeRmqJzVKT1JgVNTwI1ei
	TZA/DX3UJcv0mSBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=debK0Nr7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="UF8E//dH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747309664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P3F3Szd7PRBmf+6JunC5ebnIxmdnh36JcmraQsCgto=;
	b=debK0Nr7g6huppII/+jI4pmoz6yUOdrJVpl0utsru9y7a/zjDWWrLkMeeju0iwLBrFoNx0
	NDs1Biz/6vQqv9CTDC4KoQ/qhH+KHHhjwjg17Sx9BigCcsU6Xa4yt8+j+SPYnbbo2AwF0D
	JpmtBoGzMMWcTLTgsXM6+MD+A/VQQRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747309664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P3F3Szd7PRBmf+6JunC5ebnIxmdnh36JcmraQsCgto=;
	b=UF8E//dHlEkW6ngPnec+fEMT+5uvVaRhXWJdBMSL2xswd/rhqJeRmqJzVKT1JgVNTwI1ei
	TZA/DX3UJcv0mSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85022139D0;
	Thu, 15 May 2025 11:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EwV3IGDUJWizeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 May 2025 11:47:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36313A08CF; Thu, 15 May 2025 13:47:40 +0200 (CEST)
Date: Thu, 15 May 2025 13:47:40 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] fs/read_write: make default_llseek() killable
Message-ID: <psvtoce37eljiye6nuzffpyaz65c33ipvfos7lyyitw5ixthkz@aclnplhcmlme>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
 <20250513150327.1373061-4-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513150327.1373061-4-max.kellermann@ionos.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 921601F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ionos.com:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 13-05-25 17:03:27, Max Kellermann wrote:
> Allows killing processes that are waiting for the inode lock.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> v2: split into separate patches
> 
> TODO: review whether all callers can handle EINTR; see

I did a quick audit and everything seems OK AFAICT.

								Honza

>  https://lore.kernel.org/linux-fsdevel/20250512-unrat-kapital-2122d3777c5d@brauner/
> and
>  https://lore.kernel.org/linux-fsdevel/hzrj5b7x3rvtxt4qgjxdihhi5vjoc5gw3i35pbyopa7ccucizo@q5c42kjlkly3/
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/read_write.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index bb0ed26a0b3a..0ef70e128c4a 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -332,7 +332,9 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
>  	struct inode *inode = file_inode(file);
>  	loff_t retval;
>  
> -	inode_lock(inode);
> +	retval = inode_lock_killable(inode);
> +	if (retval)
> +		return retval;
>  	switch (whence) {
>  		case SEEK_END:
>  			offset += i_size_read(inode);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

