Return-Path: <linux-fsdevel+bounces-49126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9AAB8501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0649F1882E03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D929AAED;
	Thu, 15 May 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rOA8izm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFFSaoJm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rOA8izm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFFSaoJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4829A9E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308636; cv=none; b=aMDkRUdFrpdB5Qhrce+8o5NN/9dG3wPbvi6d9W8pZBCxV56DSHdl2GQqppTYO2Y8hBWZp8vF4/o1lUwTwnv6Lp0fKV7f8uc4ewtqVn/zvVqMEMrCN6q7for7mJJhMix1/MLTB8jH4seHXx1xa0PWSG9bQT0zD3o1DcXcC6HVT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308636; c=relaxed/simple;
	bh=mZQ0YKMCvRGkD+30zp+GH5Nhw2v3/UhgJSIX7UvJ6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAoBHvhy29qJ50d+uqxpDrzgw6ivuPg7v70J1nuG1uj1Rg8l7bQNEK92kN3Ze5HHt++LzLDDzh1IHve1JSDcPePfS7RJatkpOXdcZ5hyL9BOFWE3RYhW5et8hQE+389cLva+XNJ+TXh8CFtT5FIn4pLXjNBFRLokfQnmn5QMVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rOA8izm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFFSaoJm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rOA8izm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFFSaoJm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D0DE1F391;
	Thu, 15 May 2025 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747308633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7aBvIxI3PhlnKGRH4Ftftz5HOs5Y5hifM7+CXLdtc4=;
	b=1rOA8izmwxtRJVh5ou/l+YWlpMDvsum71wjkGq78jqS3o+yExBx8Ny5f+BeiMTyAsolCpv
	pRMGbRt8OZCTkbbNfCFDEgwhYp8XOXgtHcXQB5IsBxqBBlyw1NNwumtanm9ZwWCfOlEpe0
	viHyb6da5zjuxxBY6LMnZBSJPTPi6TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747308633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7aBvIxI3PhlnKGRH4Ftftz5HOs5Y5hifM7+CXLdtc4=;
	b=OFFSaoJmRSPpnRWIxVLkcQwhJvsOGnYPuqjDJ4tWyuDhiFVwARSrBubLqLvmvfRW9kC/ih
	1y+3OIdoXM66fQCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747308633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7aBvIxI3PhlnKGRH4Ftftz5HOs5Y5hifM7+CXLdtc4=;
	b=1rOA8izmwxtRJVh5ou/l+YWlpMDvsum71wjkGq78jqS3o+yExBx8Ny5f+BeiMTyAsolCpv
	pRMGbRt8OZCTkbbNfCFDEgwhYp8XOXgtHcXQB5IsBxqBBlyw1NNwumtanm9ZwWCfOlEpe0
	viHyb6da5zjuxxBY6LMnZBSJPTPi6TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747308633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7aBvIxI3PhlnKGRH4Ftftz5HOs5Y5hifM7+CXLdtc4=;
	b=OFFSaoJmRSPpnRWIxVLkcQwhJvsOGnYPuqjDJ4tWyuDhiFVwARSrBubLqLvmvfRW9kC/ih
	1y+3OIdoXM66fQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 124A8139D0;
	Thu, 15 May 2025 11:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7hByBFnQJWiNdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 May 2025 11:30:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4585A08CF; Thu, 15 May 2025 13:30:28 +0200 (CEST)
Date: Thu, 15 May 2025 13:30:28 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fs/open: make do_truncate() killable
Message-ID: <uhnvgtcppnqedjmqv4j3r4lrkiqf66mxfzcvhgvjjydnzlyekg@vygdj6vbd7jg>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
 <20250513150327.1373061-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513150327.1373061-3-max.kellermann@ionos.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -3.80

On Tue 13-05-25 17:03:26, Max Kellermann wrote:
> Allows killing processes that are waiting for the inode lock.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2: split into separate patches
> 
> Review here (though nothing about do_truncate()):
>  https://lore.kernel.org/linux-fsdevel/20250512-unrat-kapital-2122d3777c5d@brauner/
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/open.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index d2f2df52c458..7828234a7caa 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -60,7 +60,10 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (ret)
>  		newattrs.ia_valid |= ret | ATTR_FORCE;
>  
> -	inode_lock(dentry->d_inode);
> +	ret = inode_lock_killable(dentry->d_inode);
> +	if (ret)
> +		return ret;
> +
>  	/* Note any delegations or leases have already been broken: */
>  	ret = notify_change(idmap, dentry, &newattrs, NULL);
>  	inode_unlock(dentry->d_inode);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

