Return-Path: <linux-fsdevel+bounces-71302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB4CBD3FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 10:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F3C3015A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35740315772;
	Mon, 15 Dec 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGNKstCl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tCaYSEBJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tttXcNhO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpWJtLKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2F314A8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791983; cv=none; b=ux4xiBErIQVQ49Qy1D0/KWpqtktg2HFQ17cEA+ql8UM4QUAGIt9Cm/7VSrwSCsli0XHHHrnrLbTpV1jaJLavGJFc+0fkb5fvGPcD2gx9ozGBn3qfsrWX0NJpJUF389qT685tPOC3HyaPODQtAKiQ1pHqgIyIUMRrIFBuStDECuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791983; c=relaxed/simple;
	bh=TKUAEGFvvpKkjalzw0PfwVe25KDjuB9Fxuixn2dP/xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG7obL7AspfP6jSajMJOf7SP/RHhhJKCG4Lm6P9Jp0mhc/bw+7+8X6JWFFQjrc2JqY451dDzgGkRHDgQrtpdruHJEQrxKgNJNLSw1HtU08u3abJ434VTAnAW9AGXhhT5Kl79hSr7E1QluX6jjXgCA4rjoeYCEzPcwLSXi+nneSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGNKstCl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tCaYSEBJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tttXcNhO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpWJtLKK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72D9E337C4;
	Mon, 15 Dec 2025 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765791978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJv/KnuYUi6bTC/y8u3k9PcS9d8rFBSdWoZXsh6PAgQ=;
	b=bGNKstClLV69YG4+pssaW6EEX1j95yeXjc517BfcAgMDqnW04Np3/0tYeaU01jRAVI5cZR
	Jf8ltVgA8pKkClfE4V7EKpy/1tQLWRQhOgQakBOJJxpWZ2i0vYwJXbUIqxmP+QabhZOup3
	T/xyrwv7zjKhlcDaXz0wdOepVtAIhPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765791978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJv/KnuYUi6bTC/y8u3k9PcS9d8rFBSdWoZXsh6PAgQ=;
	b=tCaYSEBJKrNjST5bkAwaDRNP+rCLERap7CKfvXLVRb1OHQenDNVIUhhTQQzSl8yluyzjEn
	liBX7f+mT38i4mAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tttXcNhO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mpWJtLKK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765791977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJv/KnuYUi6bTC/y8u3k9PcS9d8rFBSdWoZXsh6PAgQ=;
	b=tttXcNhO7OMQi0ijOH3AlPux3b6Y5jRxlJYU0Tb1E6aqPHHhmvcSPY+LKI5cqZjlTZd1jj
	CRDopDkjYW91CJYCzqKG5xYpz1quh3Z+rB+Z3BHkh+LBx9JxnSddu86eGneopH3GnNzESU
	9F0IQAno0KI0ubPY2AJklBFf/3SqHC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765791977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJv/KnuYUi6bTC/y8u3k9PcS9d8rFBSdWoZXsh6PAgQ=;
	b=mpWJtLKKp5lIXSGim/Kkth/isS6sM0B6NYfIbEuTGpKGlJV7FE4L7hViEdO/UXUnIch5oF
	qFZpuJHTp8ArpfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6850E3EA65;
	Mon, 15 Dec 2025 09:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6KhxGenYP2lMHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Dec 2025 09:46:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B3E5A09B4; Mon, 15 Dec 2025 10:46:17 +0100 (CET)
Date: Mon, 15 Dec 2025 10:46:17 +0100
From: Jan Kara <jack@suse.cz>
To: chen zhang <chenzhang@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, chenzhang_0901@163.com
Subject: Re: [PATCH] chardev: Switch to guard(mutex)
Message-ID: <twm7w7grcgw6h4s5iyzifgmaazlx2u2awl3l4sjm24unq64ath@erjimgt3u4wi>
References: <20251215060657.87947-1-chenzhang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215060657.87947-1-chenzhang@kylinos.cn>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 72D9E337C4
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 15-12-25 14:06:57, chen zhang wrote:
> Instead of using the 'goto label; mutex_unlock()' pattern use
> 'guard(mutex)' which will release the mutex when it goes out of scope.
> 
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>

Thanks for the patch. I agree guards can simplify this function but why not
handle 'cd' variable with __free as well then? The kfree() calls you have
to add otherwise kind of defeat the purpose of guards...

								Honza

> ---
>  fs/char_dev.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index c2ddb998f3c9..ca6037304e19 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -117,14 +117,15 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  	if (cd == NULL)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mutex_lock(&chrdevs_lock);
> +	guard(mutex)(&chrdevs_lock);
>  
>  	if (major == 0) {
>  		ret = find_dynamic_major();
>  		if (ret < 0) {
>  			pr_err("CHRDEV \"%s\" dynamic allocation region is full\n",
>  			       name);
> -			goto out;
> +			kfree(cd);
> +			return ERR_PTR(ret);
>  		}
>  		major = ret;
>  	}
> @@ -144,7 +145,8 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  		if (curr->baseminor >= baseminor + minorct)
>  			break;
>  
> -		goto out;
> +		kfree(cd);
> +		return ERR_PTR(ret);
>  	}
>  
>  	cd->major = major;
> @@ -160,12 +162,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  		prev->next = cd;
>  	}
>  
> -	mutex_unlock(&chrdevs_lock);
>  	return cd;
> -out:
> -	mutex_unlock(&chrdevs_lock);
> -	kfree(cd);
> -	return ERR_PTR(ret);
>  }
>  
>  static struct char_device_struct *
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

