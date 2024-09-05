Return-Path: <linux-fsdevel+bounces-28761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A68196DF12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9521C21DE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593519E7E3;
	Thu,  5 Sep 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TTWR8btl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsJBpR/v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TTWR8btl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsJBpR/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A217C9B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552159; cv=none; b=vGOH9cj62haUscGRkOOPPvdjs3We9ip4TTTm1Y7jtXnW/6AbtBzwuFzFgB1QpBqk/sfGXKeAoO2C1ALxPT8kQXcWMy8Awv31Qtumy4oY3lTWiay3SBoFjg+tKEoTpY9Q1AQ/LvJH1FgPSwcdA8Vz6umQQK8qV2cL5IOR1+kwr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552159; c=relaxed/simple;
	bh=IoWjXY+5EefL96yOJvPm8BuP56Qksb/O90v9MWJMBHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWMy6iUPh9CA3FnwJEovm35QdQNxuuM+ybS4fNmLDfEH7xyPjqb01cR8oydoTCB+5R5juCt1Ie549zvWAtyuQj96jWJqsdLRiQxXzP0+PcTqOCchUIhpORgSBMepwEpF52EcsMKeE3gNenXtREg3ncEpqc/OGZb7ReCMcF1f/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TTWR8btl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsJBpR/v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TTWR8btl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsJBpR/v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 514461F828;
	Thu,  5 Sep 2024 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725552156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xAb4ZI9m/fCrtAwRIZ+A1Wo5zDOXktckO6SQPc8hq8=;
	b=TTWR8btlxpOKJfU8FbsFogr7RU1HsfrsUPZxOO4nBXIs0DOIEC2Xy1eYXbTglH5rMFWtMV
	Bx057EzT2Aeo2mqllozyI/hZMH9SLx51gNaechUv7KwT/fZHz94SV0UUp0pC6NFOLiAIe2
	6G7ABvGP0Y7wmF4EL7Eiv3kz2VCUaQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725552156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xAb4ZI9m/fCrtAwRIZ+A1Wo5zDOXktckO6SQPc8hq8=;
	b=EsJBpR/vF8G3RoLk2xG9gEwUcJ3r+b6wgYllLz2XNbf2Qoyp8zDpz4zLElE36afeUKOFtr
	Jkb2SHAuc1gXdGBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725552156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xAb4ZI9m/fCrtAwRIZ+A1Wo5zDOXktckO6SQPc8hq8=;
	b=TTWR8btlxpOKJfU8FbsFogr7RU1HsfrsUPZxOO4nBXIs0DOIEC2Xy1eYXbTglH5rMFWtMV
	Bx057EzT2Aeo2mqllozyI/hZMH9SLx51gNaechUv7KwT/fZHz94SV0UUp0pC6NFOLiAIe2
	6G7ABvGP0Y7wmF4EL7Eiv3kz2VCUaQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725552156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xAb4ZI9m/fCrtAwRIZ+A1Wo5zDOXktckO6SQPc8hq8=;
	b=EsJBpR/vF8G3RoLk2xG9gEwUcJ3r+b6wgYllLz2XNbf2Qoyp8zDpz4zLElE36afeUKOFtr
	Jkb2SHAuc1gXdGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47043139D2;
	Thu,  5 Sep 2024 16:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SqBVERzW2WbHNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 16:02:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0CB49A0968; Thu,  5 Sep 2024 18:02:21 +0200 (CEST)
Date: Thu, 5 Sep 2024 18:02:21 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] fs: reorder i_state bits
Message-ID: <20240905160221.dfqyx4oq4gccuap4@quack3>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
 <20240823-work-i_state-v3-2-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-work-i_state-v3-2-5cd5fd207a57@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 23-08-24 14:47:36, Christian Brauner wrote:
> so that we can use the first bits to derive unique addresses from
> i_state.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1d895b8cb801..f257f8fad7d0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2417,28 +2417,32 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   *			i_count.
>   *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
> + *
> + * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> + * upon. There's one free address left.
>   */
> -#define I_DIRTY_SYNC		(1 << 0)
> -#define I_DIRTY_DATASYNC	(1 << 1)
> -#define I_DIRTY_PAGES		(1 << 2)
> -#define __I_NEW			3
> +#define __I_NEW			0
>  #define I_NEW			(1 << __I_NEW)
> -#define I_WILL_FREE		(1 << 4)
> -#define I_FREEING		(1 << 5)
> -#define I_CLEAR			(1 << 6)
> -#define __I_SYNC		7
> +#define __I_SYNC		1
>  #define I_SYNC			(1 << __I_SYNC)
> -#define I_REFERENCED		(1 << 8)
> +#define __I_LRU_ISOLATING	2
> +#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
> +
> +#define I_DIRTY_SYNC		(1 << 3)
> +#define I_DIRTY_DATASYNC	(1 << 4)
> +#define I_DIRTY_PAGES		(1 << 5)
> +#define I_WILL_FREE		(1 << 6)
> +#define I_FREEING		(1 << 7)
> +#define I_CLEAR			(1 << 8)
> +#define I_REFERENCED		(1 << 9)
>  #define I_LINKABLE		(1 << 10)
>  #define I_DIRTY_TIME		(1 << 11)
> -#define I_WB_SWITCH		(1 << 13)
> -#define I_OVL_INUSE		(1 << 14)
> -#define I_CREATING		(1 << 15)
> -#define I_DONTCACHE		(1 << 16)
> -#define I_SYNC_QUEUED		(1 << 17)
> -#define I_PINNING_NETFS_WB	(1 << 18)
> -#define __I_LRU_ISOLATING	19
> -#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
> +#define I_WB_SWITCH		(1 << 12)
> +#define I_OVL_INUSE		(1 << 13)
> +#define I_CREATING		(1 << 14)
> +#define I_DONTCACHE		(1 << 15)
> +#define I_SYNC_QUEUED		(1 << 16)
> +#define I_PINNING_NETFS_WB	(1 << 17)
>  
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

