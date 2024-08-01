Return-Path: <linux-fsdevel+bounces-24800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EC944F45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9B828BF20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3721B32D7;
	Thu,  1 Aug 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sLjKJ6ic";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XcmTlJ+0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTHjQfXU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rot/6YPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC11EB4BA;
	Thu,  1 Aug 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526249; cv=none; b=LPOxS3Ya9vWsI8zt1Rl0A0PvwljUaGkmAQc7OkPWAG57SU1BePPihie+LA6gGuk/2Nzhb1Ob2Jb9sJJiFq3GOOvbsNgVpIceER6ApyUGo5kF1BmEny2iA1FqBXiBQYoCH00lvdiCHwlLlcuBPfcpAusHDdXl1JHgatZs559/wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526249; c=relaxed/simple;
	bh=Zjje1dsw86/XFnd6IoKFXuCS2tuvK+qHefycMLmHQQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUkbcGqks+1LK0ZrKeBIXimjfo6OEHXnJvk6jEKkTgahA9N/NJ36nYNvBJXkO7obOfinDHyanhyO3fV8+MyXw8YcsEVzd4JLirhmxKG8SBYx+R38ppeGUN6RmU6BVRhrSd2WwTR22v2OVd1UtKm2BXgIanwJIdwDq67mt22WdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sLjKJ6ic; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XcmTlJ+0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTHjQfXU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rot/6YPe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B13041FB60;
	Thu,  1 Aug 2024 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722526244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9YSBDQ+YbfO1lnAnahQ9OcUcmCOX9004ClcBxBpHW4=;
	b=sLjKJ6icTGMf85COLUjjSSQyPfH3bwr7PCUbbeArYqKL995abNtT2vmljzWzdEWvjClNNH
	0DvJSpryvXU/wIAUvGHkDFQEt3cpztpgW0UnkCxMqKfAOux0VH17tz3oT+eRaZ73cIqUat
	uDnIm4ABer9jTuRkDmcyUICZgOZlmWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722526244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9YSBDQ+YbfO1lnAnahQ9OcUcmCOX9004ClcBxBpHW4=;
	b=XcmTlJ+0i7lHB4RZyAOKiWfWiefRzPvYXTA5JdaI6rPOD1puI+XKT88Y65wvaSEoBckEpr
	pKsjP04dYGUqPkBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OTHjQfXU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="rot/6YPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722526242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9YSBDQ+YbfO1lnAnahQ9OcUcmCOX9004ClcBxBpHW4=;
	b=OTHjQfXUWsfYe1KxfMFevJWoGNGCOe5gF+WYQBlR7yXoAd/1FRWEBKFW71sRrmEItUSwIF
	PUQseqYNwv5JZZZF1H2Qm9rSk+MEF1JANbGedBaX19yi7ChOTsFFUb76XnzqLEDNowNs1h
	zU969Pa82cZ18MG8CCHBnbOqqu0etAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722526242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9YSBDQ+YbfO1lnAnahQ9OcUcmCOX9004ClcBxBpHW4=;
	b=rot/6YPeZ7Ed+EVrWeyf3ua0nAznswMzlZ0SwToMo81x82uqCRCbbIqBjo3GbDvRHolsqj
	1pSJJHQ5g1H7rSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 964FA136CF;
	Thu,  1 Aug 2024 15:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id apxoJCKqq2bJFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 15:30:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B153A08CB; Thu,  1 Aug 2024 17:30:42 +0200 (CEST)
Date: Thu, 1 Aug 2024 17:30:42 +0200
From: Jan Kara <jack@suse.cz>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] squashfs: Add length check in
 squashfs_symlink_read_folio
Message-ID: <20240801153042.prhbovbuys4zmprv@quack3>
References: <20240801124220.GP5334@ZenIV>
 <20240801151740.339272-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801151740.339272-1-lizhi.xu@windriver.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B13041FB60
X-Spam-Score: -2.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[24ac24ff58dc5b0d26b9];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu 01-08-24 23:17:40, Lizhi Xu wrote:
> syzbot report KMSAN: uninit-value in pick_link, the root cause is that
> squashfs_symlink_read_folio did not check the length, resulting in folio
> not being initialized and did not return the corresponding error code.
> 
> The incorrect value of length is due to the incorrect value of inode->i_size.
> 
> Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/squashfs/symlink.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
> index 6ef735bd841a..d5fa5165ddd6 100644
> --- a/fs/squashfs/symlink.c
> +++ b/fs/squashfs/symlink.c
> @@ -61,6 +61,12 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
>  		}
>  	}
>  
> +	if (length < 0) {

OK, so this would mean that (int)inode->i_size is a negative number.
Possible. Perhaps we should rather better validate i_size of symlinks in
squashfs_read_inode()? Otherwise it would be a whack-a-mole game of
catching places that get confused by bogus i_size...

								Honza

> +		ERROR("Unable to read symlink, wrong length [%d]\n", length);
> +		error = -EINVAL;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Read length bytes from symlink metadata.  Squashfs_read_metadata
>  	 * is not used here because it can sleep and we want to use
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

