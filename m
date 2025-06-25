Return-Path: <linux-fsdevel+bounces-52883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17963AE7EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C726B7ABE00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494D27F170;
	Wed, 25 Jun 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1j4avAZU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cUXriR6M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1j4avAZU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cUXriR6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D61DF755
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846617; cv=none; b=FJuQj10zQy16s6v4cvMMetR0zWAneM6zI7iWTSmNAC2fLi5e3r8JXer1QiNukqRaCwtvtZKJOlVG/NY8Ym2AECg9tC3kM4ifDJMO+nX32nTZD3aBA4HaKnUbj/teYooJNPSdU+0ZAxfMuEG1ToTwqdNbQemdZeo3I74IHp1KT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846617; c=relaxed/simple;
	bh=vmao3ByiyJ0I+ZYhiyjw9OXU9NhF/CcySviV9PQfkl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCEs4AkwwyGg+RWbdZJ93ocIb5Gy9Vf0cY1xcmtTk6pp0faYT4HlyOyFUGRRUo3gxaubXA126z3ArsBVoVKR4yxpn2q6KoFGU4Lj2A4NCD4J7nPrdxnYXcg57bVgWlLHcc+I1pjIj2/pGBZGk0S9fpNjCvkeHoqkzBiGXfLqfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1j4avAZU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cUXriR6M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1j4avAZU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cUXriR6M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5917021193;
	Wed, 25 Jun 2025 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750846614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv0n0lCAdRE4CsGWXlkfFposDQbziD3Ysg3sTsxbXsY=;
	b=1j4avAZUPVbs4YW1jgchLfdGhEd1HbB9cWmFRSKyujfdxGcZt25MYWg76WhPLBOejKltfr
	hvEhfRlW5Zs57Ci5ZWrYgSuYXOBb+hkh/Z5LYrtmGya+Q444fKWlcqpkrqrWWQ3j/ndjTY
	csL9h/adrQBcoYvHdRUKazk0CboKKMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750846614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv0n0lCAdRE4CsGWXlkfFposDQbziD3Ysg3sTsxbXsY=;
	b=cUXriR6MPD1JUPW2/eMTzkpZeBr5yy/xmF31pbhj5PYtXVyDfbew69PFe7p/6BEKF7k5J4
	qxotv1FevkWis8CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750846614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv0n0lCAdRE4CsGWXlkfFposDQbziD3Ysg3sTsxbXsY=;
	b=1j4avAZUPVbs4YW1jgchLfdGhEd1HbB9cWmFRSKyujfdxGcZt25MYWg76WhPLBOejKltfr
	hvEhfRlW5Zs57Ci5ZWrYgSuYXOBb+hkh/Z5LYrtmGya+Q444fKWlcqpkrqrWWQ3j/ndjTY
	csL9h/adrQBcoYvHdRUKazk0CboKKMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750846614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv0n0lCAdRE4CsGWXlkfFposDQbziD3Ysg3sTsxbXsY=;
	b=cUXriR6MPD1JUPW2/eMTzkpZeBr5yy/xmF31pbhj5PYtXVyDfbew69PFe7p/6BEKF7k5J4
	qxotv1FevkWis8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4610813301;
	Wed, 25 Jun 2025 10:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HoAXEZbMW2ijQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Jun 2025 10:16:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98D9BA0857; Wed, 25 Jun 2025 12:16:49 +0200 (CEST)
Date: Wed, 25 Jun 2025 12:16:49 +0200
From: Jan Kara <jack@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>, kernel@pankajraghav.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] fs/buffer: remove the min and max limit checks in
 __getblk_slow()
Message-ID: <u7fadbfaq5wm7nqhn4yewbn43h3ahxuqm536ly473uch2v5qfl@hpgo2dfg77jp>
References: <20250625083704.167993-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625083704.167993-1-p.raghav@samsung.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email,samsung.com:email]
X-Spam-Level: 

On Wed 25-06-25 10:37:04, Pankaj Raghav wrote:
> All filesystems will already check the max and min value of their block
> size during their initialization. __getblk_slow() is a very low-level
> function to have these checks. Remove them and only check for logical
> block size alignment.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

I know this is a bikeshedding but FWIW this is in the should never trigger
territory so I'd be inclined to just make it WARN_ON_ONCE() and completely
delete it once we refactor bh apis to make sure nobody can call bh
functions with anything else than sb->s_blocksize.

								Honza

> ---
> Changes since v2:
> - Removed the max and min checks in __getblk_slow().
> 
>  fs/buffer.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a14d281c6a74..a1aa01ebc0ce 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1122,13 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>  {
>  	bool blocking = gfpflags_allow_blocking(gfp);
>  
> -	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> -		     (size < 512 || size > PAGE_SIZE))) {
> -		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
> -					size);
> -		printk(KERN_ERR "logical block size: %d\n",
> -					bdev_logical_block_size(bdev));
> -
> +	if (unlikely(size & (bdev_logical_block_size(bdev) - 1))) {
> +		printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
> +		       size, bdev_logical_block_size(bdev));
>  		dump_stack();
>  		return NULL;
>  	}
> 
> base-commit: 6ae58121126dcf8efcc2611f216a36a5e50b8ad9
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

