Return-Path: <linux-fsdevel+bounces-53061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4150FAE96A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 09:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BE84A25DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C1223B608;
	Thu, 26 Jun 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WBAnZyhN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTzYRbPB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WN7/bq4o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+lyEmxJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8022ACF3
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922390; cv=none; b=FfTeUMLIJ1O/B8kFvI28hboEBN7NafLHo07EMVTTw1JlmC83LPravlMeGMIuiiIhy6r97pGgrIsCNwmlp9h3LPZCBq/tL8leK+MotHwaM3MtNaCKL0f+pKak0TgvmX9pOrTOHOvrwEjkrBZpCH2tqy7bYlAZ65Zf0MH+yDWmXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922390; c=relaxed/simple;
	bh=XEZqvWn7zIRA7zYRRi4aNQ2t9vdPXJsQBrABnusBxsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBzeCJyXmvJBOqgye2FD9SzwOzQRshj1yQ0VZueMLClTuaZMVb+1Z9ry+8Vx/MLLFJsQfhAukrigAvQCfRKS/aDp6H2PlvBc3MUqto3j7D2WkAoA1OAogFSQNXS06KF7Kb1pN77Fxq8423EatOLgYipCe5RiNlfTEgIRBw3bXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WBAnZyhN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTzYRbPB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WN7/bq4o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+lyEmxJR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE1F421192;
	Thu, 26 Jun 2025 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750922387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98T2iTFRy6OGY3MA6c3ijODx7Lf2ZjSGvky10urQJjU=;
	b=WBAnZyhNyB5IDnZk/gCcalA6K3+HBb+45GAZDm/NIyax5R5omSwbV0xgZzYex9r6e+ZFLo
	gSn2dNGXmO9oN1oAR73h4bs5QOZI8xJKkJEDlzyL5dnzTxcRZGkjpS83k5iaoTxoL6h+vb
	pcQk0m4XVdcx4oMYU9E9WCLTwA3Up0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750922387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98T2iTFRy6OGY3MA6c3ijODx7Lf2ZjSGvky10urQJjU=;
	b=kTzYRbPB+Wm/2lvRrkCeZ+qXxD7+OCmEj67eLrq58gFoZqFbip1zSz7fLXh/KQ04C52Osr
	L1TAgHmVsvbvHrAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="WN7/bq4o";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+lyEmxJR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750922385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98T2iTFRy6OGY3MA6c3ijODx7Lf2ZjSGvky10urQJjU=;
	b=WN7/bq4ouRPZR98HO4fEWl0wHTYQUAW2NhWSeWiUt/xxBnIw2pB8YLCWM79KjEVDnHWxRk
	c1tzuWylwsfSJlVdNz9UmvT88exUSRmarsfP03yF6ECW3AnclDPgAIRkwIhE3+TFhx69Kb
	Gv1aZHUu5IUe66qAE3FiHZMMAb6H+Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750922385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98T2iTFRy6OGY3MA6c3ijODx7Lf2ZjSGvky10urQJjU=;
	b=+lyEmxJRN1MpTZ7uUyrEb/VQ5QimSor3OkzEgr1430XiU3HGgi3dSY02lYZM1kcijDZzWd
	qMXDGxRUQe0FmpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CAA313188;
	Thu, 26 Jun 2025 07:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R7wyJpH0XGihJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Jun 2025 07:19:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57852A0953; Thu, 26 Jun 2025 09:19:45 +0200 (CEST)
Date: Thu, 26 Jun 2025 09:19:45 +0200
From: Jan Kara <jack@suse.cz>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jan Kara <jack@suse.cz>, Pankaj Raghav <p.raghav@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] fs/buffer: remove the min and max limit checks in
 __getblk_slow()
Message-ID: <lpf4hlxv2e3dd527xmbueuquvo37c23e7mfuiedrjaullr3ilk@6ifh3tkjgyp2>
References: <20250625083704.167993-1-p.raghav@samsung.com>
 <u7fadbfaq5wm7nqhn4yewbn43h3ahxuqm536ly473uch2v5qfl@hpgo2dfg77jp>
 <jbtntrppqjzaq6tdfzvwojjsnpacrdmg74vcvab4dc2z6hlhnl@ntotjsab5ice>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jbtntrppqjzaq6tdfzvwojjsnpacrdmg74vcvab4dc2z6hlhnl@ntotjsab5ice>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE1F421192
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,samsung.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 25-06-25 12:53:54, Pankaj Raghav (Samsung) wrote:
> On Wed, Jun 25, 2025 at 12:16:49PM +0200, Jan Kara wrote:
> > On Wed 25-06-25 10:37:04, Pankaj Raghav wrote:
> > > All filesystems will already check the max and min value of their block
> > > size during their initialization. __getblk_slow() is a very low-level
> > > function to have these checks. Remove them and only check for logical
> > > block size alignment.
> > > 
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > I know this is a bikeshedding but FWIW this is in the should never trigger
> > territory so I'd be inclined to just make it WARN_ON_ONCE() and completely
> > delete it once we refactor bh apis to make sure nobody can call bh
> > functions with anything else than sb->s_blocksize.
> > 
> Something like this:
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a1aa01ebc0ce..a49b4be37c62 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1122,10 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>  {
>         bool blocking = gfpflags_allow_blocking(gfp);
>  
> -       if (unlikely(size & (bdev_logical_block_size(bdev) - 1))) {
> +       if (WARN_ON_ONCE(size & (bdev_logical_block_size(bdev) - 1))) {
>                 printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
>                        size, bdev_logical_block_size(bdev));
> -               dump_stack();
>                 return NULL;
>         }
> 
> I assume we don't need the dump_stack() anymore as we will print them
> with WARN_ON_ONCE anyway?

Correct. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

