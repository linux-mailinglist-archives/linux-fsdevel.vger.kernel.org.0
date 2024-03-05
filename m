Return-Path: <linux-fsdevel+bounces-13622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59511872134
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC51C20CB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380B5676A;
	Tue,  5 Mar 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7rLGd78";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2NeXmf8h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7rLGd78";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2NeXmf8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D08662E;
	Tue,  5 Mar 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647970; cv=none; b=Qyqbf6vpaixfPAmMkZCIHIBG/E57r+JwSrlZPYJZefQad/EzPNVVwpeVVEL/iY5WgZykNBOriNSCW+rqQOzuPA/f3cpzOlJ7OWT38sZCPCWsVzRjTKWxAaxMJDl16ZVg/sdPOgiZBXqcYC2ocjF9v5/+qbSfXlrf9wX/WuZVsT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647970; c=relaxed/simple;
	bh=jAvBGKZkDK+DJCXMX8Lptx599t3OO3/6NY//gbhJ8ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYBGaKFlkWMvcLdHX8Q+rILQZIwA4pGRjE33m+9DC56w0YZHaM37rlFB1Mq+05hreH7b5Z2ndFXmVPY/1goD5ru3uyWCFfEhWP/yqbJ1oL5q93ARKx0RJuCIxVkoHAkJjlMEZt8EDaX5tW8qBz0sfeyZ09bSf9ugRYNj0U3pYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7rLGd78; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2NeXmf8h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7rLGd78; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2NeXmf8h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C51DA6B3AB;
	Tue,  5 Mar 2024 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709647966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F9/7CluG7BEEDZ/l4zmtYN6IZ3U75GnXdcDIdLJHyjQ=;
	b=d7rLGd78mS8+FyfvMuPzfhnaNyDUU8T3D/lvmb+lKa5jChNJ9V58hMzOYowp+SFRr+2idK
	YJrdvK+jMg+PeIt32R+Y2mzanoHDbJU/PVv59y/Hs8kt5AR5XU2UgomTFCHiP3mSJhfL0w
	jRirKuwM/Fx6U9uyuTYfPWlymjs/sWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709647966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F9/7CluG7BEEDZ/l4zmtYN6IZ3U75GnXdcDIdLJHyjQ=;
	b=2NeXmf8h7ijEs65Ra//CRJj1L5/wmxKjgtDrfOYp8WPbBYMR4dHEOql5vBVrkqYbbgX4nx
	rNPGyR6oKY0rPLDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709647966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F9/7CluG7BEEDZ/l4zmtYN6IZ3U75GnXdcDIdLJHyjQ=;
	b=d7rLGd78mS8+FyfvMuPzfhnaNyDUU8T3D/lvmb+lKa5jChNJ9V58hMzOYowp+SFRr+2idK
	YJrdvK+jMg+PeIt32R+Y2mzanoHDbJU/PVv59y/Hs8kt5AR5XU2UgomTFCHiP3mSJhfL0w
	jRirKuwM/Fx6U9uyuTYfPWlymjs/sWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709647966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F9/7CluG7BEEDZ/l4zmtYN6IZ3U75GnXdcDIdLJHyjQ=;
	b=2NeXmf8h7ijEs65Ra//CRJj1L5/wmxKjgtDrfOYp8WPbBYMR4dHEOql5vBVrkqYbbgX4nx
	rNPGyR6oKY0rPLDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B0813A5D;
	Tue,  5 Mar 2024 14:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CgaQLF4o52WSQwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 05 Mar 2024 14:12:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6AA6AA0650; Tue,  5 Mar 2024 15:12:46 +0100 (CET)
Date: Tue, 5 Mar 2024 15:12:46 +0100
From: Jan Kara <jack@suse.cz>
To: chengming.zhou@linux.dev
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] isofs: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240305141246.p6bspc65seemkqyt@quack3>
References: <20240224134901.829591-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224134901.829591-1-chengming.zhou@linux.dev>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.73
X-Spamd-Result: default: False [-3.73 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.93)[99.70%]
X-Spam-Flag: NO

On Sat 24-02-24 13:49:01, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/isofs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 379c9edc907c..2a616a9f289d 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -93,7 +93,7 @@ static int __init init_inodecache(void)
>  	isofs_inode_cachep = kmem_cache_create("isofs_inode_cache",
>  					sizeof(struct iso_inode_info),
>  					0, (SLAB_RECLAIM_ACCOUNT|
> -					SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +					SLAB_ACCOUNT),
>  					init_once);
>  	if (!isofs_inode_cachep)
>  		return -ENOMEM;
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

