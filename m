Return-Path: <linux-fsdevel+bounces-32115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546379A0B54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCDBB223AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F55209683;
	Wed, 16 Oct 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cv9b72WL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="68yNfONX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cv9b72WL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="68yNfONX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CD1C2325;
	Wed, 16 Oct 2024 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085028; cv=none; b=pMkX0Ov25UcpQhIKif0b5GpQCJLlt9o0tJSlMH2EnyD2eBYJ9Sl1FwRMkZnv2np2RAqYXySFIlof3J+59J0dTRGGTp0S4/QLdJr6UwZM7t/XHeUx3bmmGtbHqycrviLxpsAuYsgV+m3NM+FDrlgjTefW0cc+/IbbFUjcSssUNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085028; c=relaxed/simple;
	bh=Vyes9UArj6kLabqe01BeO1W1BwzZyrwUMN88W+36opQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb+slpMa3XH78pKqR8ii6W+14+u9SH41fwu9+/YRZJ84nRi6Xs7OYUrq4z57lPXwQBSYMJ4tpFPSyzxTbXeVsyL+CdTQXNUxs/cptb3ajsP17rsttBRjZb8lmq6I5re+GC800h2xuhVMB4hp0fV+mgGFgKlYGuniO6YGvZ2P7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cv9b72WL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=68yNfONX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cv9b72WL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=68yNfONX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 272AA21B27;
	Wed, 16 Oct 2024 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729085024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZO+sKhTsv8pLLoDC9fSPMQBrWslqPRrnnr+bCHanc4=;
	b=cv9b72WLMisKxFkDbxDM9PHu8D6CgEzyOm4N2OgsTzd3tU2CTEsR5DIKdjZioE5QVIuD76
	Pj6Y9zHfEsrD2Xly8mFEyHnyPF/mUx0fi2d48fGewt0+Sx6wraNphgf4xYXlGzDqFDbrg6
	uHvaTW1yLcpubxrBclh3jsZHOSk7icU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729085024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZO+sKhTsv8pLLoDC9fSPMQBrWslqPRrnnr+bCHanc4=;
	b=68yNfONXzqZZSINr4shKJhlRIhTFUuo4ivNuzNnGSGbPhpEbtqav0Y7MMLMecULYjYNCVu
	2/3AsDmC+PL1+PAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cv9b72WL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=68yNfONX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729085024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZO+sKhTsv8pLLoDC9fSPMQBrWslqPRrnnr+bCHanc4=;
	b=cv9b72WLMisKxFkDbxDM9PHu8D6CgEzyOm4N2OgsTzd3tU2CTEsR5DIKdjZioE5QVIuD76
	Pj6Y9zHfEsrD2Xly8mFEyHnyPF/mUx0fi2d48fGewt0+Sx6wraNphgf4xYXlGzDqFDbrg6
	uHvaTW1yLcpubxrBclh3jsZHOSk7icU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729085024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZO+sKhTsv8pLLoDC9fSPMQBrWslqPRrnnr+bCHanc4=;
	b=68yNfONXzqZZSINr4shKJhlRIhTFUuo4ivNuzNnGSGbPhpEbtqav0Y7MMLMecULYjYNCVu
	2/3AsDmC+PL1+PAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18C871376C;
	Wed, 16 Oct 2024 13:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Og3DBWC+D2eoCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Oct 2024 13:23:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AF776A083E; Wed, 16 Oct 2024 15:23:39 +0200 (CEST)
Date: Wed, 16 Oct 2024 15:23:39 +0200
From: Jan Kara <jack@suse.cz>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, anupnewsmail@gmail.com,
	alessandrozanni.dev@gmail.com,
	syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: Fix uninitialized value issue in from_kuid
Message-ID: <20241016132339.cq5qnklyblfxw4xl@quack3>
References: <20241016123723.171588-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016123723.171588-1-alessandro.zanni87@gmail.com>
X-Rspamd-Queue-Id: 272AA21B27
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[6c55f725d1bdc8c52058];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,linuxfoundation.org,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 16-10-24 14:37:19, Alessandro Zanni wrote:
> Fix uninitialized value issue in from_kuid by initializing the newattrs
> structure in do_truncate() method.

Thanks for the fix. It would be helpful to provide a bit more information
in the changelog so that one doesn't have to open the referenced syzbot
report to understand the problem. In this case I'd write something like:

ocfs2_setattr() uses attr->ia_uid in a trace point even though ATTR_UID
isn't set. Initialize all fields of newattrs to avoid uninitialized
variable use.

But see below as I don't think this is really the right fix.

> Fixes: uninit-value in from_kuid reported here
>  https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058

Fixes tag should reference some preexisting commit this patch is fixing. As
such this tag is not really applicable here. Keeping the syzbot reference
in Reported-by and Closes (or possibly change that to References) is good
enough.

> Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  fs/open.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index acaeb3e25c88..57c298b1db2c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -40,7 +40,7 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
>  		loff_t length, unsigned int time_attrs, struct file *filp)
>  {
>  	int ret;
> -	struct iattr newattrs;
> +	struct iattr newattrs = {0};

We usually perform such initialization as:
	struct iattr newattrs = {};

That being said there are many more places calling notify_change() and none
of them is doing the initialization so this patch only fixes that one
particular syzbot reproducer but doesn't really deal with the problem.
Looking at the bigger picture I think the right solution really is to fix
ocfs2_setattr() to not touch attr->ia_uid when ATTR_UID isn't set and
similarly for attr->ia_gid and ATTR_GID.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

