Return-Path: <linux-fsdevel+bounces-32192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF39A22F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E87A1C226C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D91DDA2E;
	Thu, 17 Oct 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrPG1Q9B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aK490+Yx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENyc1v92";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3u66M7zU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560B1DA112;
	Thu, 17 Oct 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170382; cv=none; b=FddN9NqRZ0126sR7jhljKx9Z9uupiWZ6ygeukIRrMAvIQ76AEX5h9tAaSfvLu2fz3v9HYgCFDYuP6/+Afuzrii9150llkI9ZvP/8Nn3VbqijKtVKVbzVQuGVgXZQVe6u5r36rMo/VSS3Kojcot/v/LZInbN/qZQvCnat1GH9nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170382; c=relaxed/simple;
	bh=H8dbz8O/RfljEkZIrlnI00EgBVQhVesNCt7ezHS+cj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJXTxuGzprt6Ilmi/fZxzroiQwss1wqdFn4o63PmD2fwRUS5nV2dgwaqIAlJKJPh0bF/X2UPcL2wnu7LxkuFatYOvZ0X7ScfRkoh94f/FFKXeO8gbrV6+3Xjr/Ab3fTy4V43UNcPSiVoOVKGS67KQGWtTVfiUlLffCLVcSjeP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrPG1Q9B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aK490+Yx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENyc1v92; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3u66M7zU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B92E71FB4C;
	Thu, 17 Oct 2024 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729170375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJBz6Y4leuaFQ0T7+AG93l8aPU2e1zEtdhoFRXEUI44=;
	b=PrPG1Q9BEAALXGbQ9TzJ2NMr9e2NldYbiFF715+EqCZkbDjHNu+UL/c/4L3RtqIeirWbzt
	krvTikIQ/g1qRtcGMkvgLBCmnWWGpiHtymtI7+1bspSx2tuAW6FLLMWz0fVCglbMhWDXaz
	JvvDGSZDvbWONsLdPWe7VKpZnq7Whns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729170375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJBz6Y4leuaFQ0T7+AG93l8aPU2e1zEtdhoFRXEUI44=;
	b=aK490+Yx+BFKYbfpQ7hOVEcZxrtT4sN+XQ7pKgWZw6E5UY+OyiAowEUi7i1j5pwvewQbaa
	IcuvXJs8+HXIyiCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ENyc1v92;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3u66M7zU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729170374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJBz6Y4leuaFQ0T7+AG93l8aPU2e1zEtdhoFRXEUI44=;
	b=ENyc1v92jIWEmF7Ilpb8SbnIE+m/0CYwPnRaLy2qNw86A57eGj5HnO4fu4W/wrUHUPdDaP
	KTEhkhFWzpymZZKMwMlOblHF5pSfxgeqEYk/6yAMVJr8fjeygUvi5gKXCWQhBkUNQHod2s
	0aHno8OjDpd8ZHRkmDip/YG5ogB/nwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729170374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJBz6Y4leuaFQ0T7+AG93l8aPU2e1zEtdhoFRXEUI44=;
	b=3u66M7zUpuscLVwmLlcKv4d32JdH9GUh/Wg8OhW8LROGUy8RXTcAxV0UU1h6XxxZ4SMiI9
	wlGnVAnuo1Ps9ZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAF6213A42;
	Thu, 17 Oct 2024 13:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hz9zKcYLEWfWDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 17 Oct 2024 13:06:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 554D9A08B5; Thu, 17 Oct 2024 15:06:10 +0200 (CEST)
Date: Thu, 17 Oct 2024 15:06:10 +0200
From: Jan Kara <jack@suse.cz>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, anupnewsmail@gmail.com,
	alessandrozanni.dev@gmail.com,
	syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fs: Fix uninitialized value issue in from_kuid and
 from_kgid
Message-ID: <20241017130610.sryqcth6e2yao3gx@quack3>
References: <20241017120553.55331-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017120553.55331-1-alessandro.zanni87@gmail.com>
X-Rspamd-Queue-Id: B92E71FB4C
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[6c55f725d1bdc8c52058];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,linuxfoundation.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 17-10-24 14:05:51, Alessandro Zanni wrote:
> ocfs2_setattr() uses attr->ia_mode, attr->ia_uid and attr->ia_gid in
> a trace point even though ATTR_MODE, ATTR_UID and ATTR_GID aren't set.
> 
> Initialize all fields of newattrs to avoid uninitialized variables, by
> checking if ATTR_MODE, ATTR_UID, ATTR_GID are initialized, otherwise 0.
> 
> Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> Notes:
>     v2: fix ocfs2_setattr to avoid similar issues; improved commit description
> 
>  fs/ocfs2/file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index ad131a2fc58e..58887456e3c5 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1129,9 +1129,12 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	trace_ocfs2_setattr(inode, dentry,
>  			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
>  			    dentry->d_name.len, dentry->d_name.name,
> -			    attr->ia_valid, attr->ia_mode,
> -			    from_kuid(&init_user_ns, attr->ia_uid),
> -			    from_kgid(&init_user_ns, attr->ia_gid));
> +			    attr->ia_valid,
> +				attr->ia_valid & ATTR_MODE ? attr->ia_mode : 0,
> +				attr->ia_valid & ATTR_UID ?
> +					from_kuid(&init_user_ns, attr->ia_uid) : 0,
> +				attr->ia_valid & ATTR_GID ?
> +					from_kgid(&init_user_ns, attr->ia_gid) : 0);
>  
>  	/* ensuring we don't even attempt to truncate a symlink */
>  	if (S_ISLNK(inode->i_mode))
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

