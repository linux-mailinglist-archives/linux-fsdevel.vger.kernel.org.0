Return-Path: <linux-fsdevel+bounces-46453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D8A89986
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A463BA158
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8D28A1CE;
	Tue, 15 Apr 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ng62jFf/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zGB5zBG9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ng62jFf/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zGB5zBG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2631991B2
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711723; cv=none; b=QhhbYtSGYvp5kkgnZfa0wgWqgt0caYDJGSDZPhhvCHsyVVEIdVcmwpZdIqde6ldOTyNV4jJM6nndmooXB1z2WxvRtMm3uiGeYYFUKI6pcHSkgyEU87xJLhSk4koDtWH7I1FciTfZyTU1Wru2502ktkjGXZXuKkqP8qGwsK77cmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711723; c=relaxed/simple;
	bh=9mByjF5E3Le6Y5gYDGOF7+lKf8TpxsBJCAjMAuHLEco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc0QgeSZIBggjCgllFjKfX7MV9PyL4gPTwH6ycF3EnlHBIDzFMMmRQogs47nnNK+f5xViXiPUUPkbl7HV1/Ah2dKQ5A2SyvZv9cnRO2JG626uvJVRvS5qrtNfAt6TqbAwjZFYV9pqFG1G2n3h0xZgysS4S2PjZIf0eb7KE3VCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ng62jFf/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zGB5zBG9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ng62jFf/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zGB5zBG9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53BF3210F9;
	Tue, 15 Apr 2025 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744711719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBd+Faz362YMVvy8CvlZ+rMvMpx45J0980Cl7iqno7Y=;
	b=Ng62jFf/w76g7DeH000seHsxoiJUADgXi+c7UvcffxUh2f1x8aasAt4rmMJ3CSBeZQNK7V
	RGVlLQ9tWxWBpSFxz21IBYJzOwqmef5gYRk35Eds6b6Riv5kPTsUyehWq7W5IE95qHg2cv
	HDLTiYNEW0tu9lHI639Pd+7wFrTGfFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744711719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBd+Faz362YMVvy8CvlZ+rMvMpx45J0980Cl7iqno7Y=;
	b=zGB5zBG9eJjwzWEgdH3inlcXv+ObvnsWxgGJIiDoKnz0Dg24PBUrcQtz8tACIJC8ES1+IE
	eRsljJh39TwBjVAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744711719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBd+Faz362YMVvy8CvlZ+rMvMpx45J0980Cl7iqno7Y=;
	b=Ng62jFf/w76g7DeH000seHsxoiJUADgXi+c7UvcffxUh2f1x8aasAt4rmMJ3CSBeZQNK7V
	RGVlLQ9tWxWBpSFxz21IBYJzOwqmef5gYRk35Eds6b6Riv5kPTsUyehWq7W5IE95qHg2cv
	HDLTiYNEW0tu9lHI639Pd+7wFrTGfFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744711719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBd+Faz362YMVvy8CvlZ+rMvMpx45J0980Cl7iqno7Y=;
	b=zGB5zBG9eJjwzWEgdH3inlcXv+ObvnsWxgGJIiDoKnz0Dg24PBUrcQtz8tACIJC8ES1+IE
	eRsljJh39TwBjVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C863139A1;
	Tue, 15 Apr 2025 10:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjfBDicw/mdgZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 10:08:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EAD60A0947; Tue, 15 Apr 2025 12:08:34 +0200 (CEST)
Date: Tue, 15 Apr 2025 12:08:34 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	David Sterba <dsterba@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, Sandeen <sandeen@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
Message-ID: <qpldkactlzezvbggcxrw53bplk2hytdhp7yatdfvgyl4yofbpf@d2v25f6bb5t7>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-orchester-robben-2be52e119ee4@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 15-04-25 09:51:37, Christian Brauner wrote:
> Both the hfs and hfsplus filesystem have been orphaned since at least
> 2014, i.e., over 10 years. It's time to remove them from the kernel as
> they're exhibiting more and more issues and no one is stepping up to
> fixing them.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. And I agree hopefully it sparks interest in the maintainership
because this is not completely useless filesystem:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hfs/super.c     | 2 ++
>  fs/hfsplus/super.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index fe09c2093a93..4413cd8feb9e 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -404,6 +404,8 @@ static int hfs_init_fs_context(struct fs_context *fc)
>  {
>  	struct hfs_sb_info *hsb;
>  
> +	pr_warn("The hfs filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
> +
>  	hsb = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
>  	if (!hsb)
>  		return -ENOMEM;
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 948b8aaee33e..58cff4b2a3b4 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -656,6 +656,8 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
>  {
>  	struct hfsplus_sb_info *sbi;
>  
> +	pr_warn("The hfsplus filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
> +
>  	sbi = kzalloc(sizeof(struct hfsplus_sb_info), GFP_KERNEL);
>  	if (!sbi)
>  		return -ENOMEM;
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

