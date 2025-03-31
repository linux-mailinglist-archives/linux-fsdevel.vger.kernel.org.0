Return-Path: <linux-fsdevel+bounces-45322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72769A763AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBF16540B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996441DF248;
	Mon, 31 Mar 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RsCrGFAN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDrN14Rr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p/v5NoU/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/G9fCVKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F011DED47
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415132; cv=none; b=OBkm2PtWqXnHCBYiur9uB8FFzC+fv5iHUwAgS7xy4Zw6vuMZXSGGNDEObCY8r4c8ATtEsNq1vzc64/beALcvvFbJtJ0FCwJWfa23XakWtTqJienMgh7HZ63Ld4HC5JMJc1++FBkj2C7U8yCrZpRk8UGbDg1YiFu3eZwxOckcRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415132; c=relaxed/simple;
	bh=9QA8hAVA+DkW9LvznPOjFLZe0xQz71Xtbfr296v09Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k00B/xF+FlV30O4BJsbrUirULLPpOG3V4zwCB+I3/vSdtpEXbGQUWOzfxmHro4KSQdjQBTBV6ju0wnzOYr0U5QAA6t8OF3MM5+U1Mj8C51RXTEXWBMAbWGuYOpZPhu3YjFaaF5YkHQxITeBzbhoy0w1BRwtWsd2KN7tMbkYKxDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RsCrGFAN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDrN14Rr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p/v5NoU/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/G9fCVKm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6A421F38D;
	Mon, 31 Mar 2025 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16H+qm94B9aoAZ004+7XaQrFI+HIiFIaXKZ+FNQBVoM=;
	b=RsCrGFANFPPLqr/9ZK3MG+LfZavGUKmGiTz02+RRv0F5psmmzVHC5q6fw53/HJ1WtEBxq9
	G9f2Lu4lWq+MxvAXPZ3FNeOsYqgst6uiuOQtwW1IgxjBYATi1HRSLIh3OQRKPmAR8ugvE9
	Y8OeiQUr9FT5WyX5v3PzDfJ5oBZGeq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16H+qm94B9aoAZ004+7XaQrFI+HIiFIaXKZ+FNQBVoM=;
	b=TDrN14RrGfg3KgUQ6K2HFejAJsvdlbRjWPYz0aKQCmbbeLkmrdLlbPsZck8L6OufxCiJx9
	8Ioe9EevDYc80gCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="p/v5NoU/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/G9fCVKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16H+qm94B9aoAZ004+7XaQrFI+HIiFIaXKZ+FNQBVoM=;
	b=p/v5NoU/aSgNnQ6K3BNDiSRNU32hR4AyKf/5gDV5znJRfxH1o2Y2QBheO8OzyOGrL0NZFc
	0STU4Cy3ok45VYvsNbPzBgyjZdnklScPof39RetwT3o80so5nFYQ4HnZRJ23/Q9/bjGGoJ
	cs1NVW+nW/p02WKFuLn9XlCm7woWe2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16H+qm94B9aoAZ004+7XaQrFI+HIiFIaXKZ+FNQBVoM=;
	b=/G9fCVKmWeqX+ArZYKD+j/VLL8uw2tqhn6cBbK9XJ+wvUqzdQyFJHT4qhCkbqYb023Cq5g
	pez9179otvLF9ZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC05413A1F;
	Mon, 31 Mar 2025 09:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5SLQMVdn6mdCWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 09:58:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90DABA08D2; Mon, 31 Mar 2025 11:58:39 +0200 (CEST)
Date: Mon, 31 Mar 2025 11:58:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 2/6] super: simplify user_get_super()
Message-ID: <apzp52dtiqmcnyrapztovqmw7lhfw7c4yefvup2rapcdes527n@l2r7v2noqxek>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-2-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-2-a47af37ecc3d@kernel.org>
X-Rspamd-Queue-Id: D6A421F38D
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,hansenpartnership.com,kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Sat 29-03-25 09:42:15, Christian Brauner wrote:
> Make it easier to read and remove one level of identation.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index dc14f4bf73a6..b1acfc38ba0c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -987,20 +987,21 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  
>  	spin_lock(&sb_lock);
>  	list_for_each_entry(sb, &super_blocks, s_list) {
> -		if (sb->s_dev == dev) {
> -			bool locked;
> -
> -			sb->s_count++;
> -			spin_unlock(&sb_lock);
> -			/* still alive? */
> -			locked = super_lock(sb, excl);
> -			if (locked)
> -				return sb; /* caller will drop */
> -			/* nope, got unmounted */
> -			spin_lock(&sb_lock);
> -			__put_super(sb);
> -			break;
> -		}
> +		bool locked;
> +
> +		if (sb->s_dev != dev)
> +			continue;
> +
> +		sb->s_count++;
> +		spin_unlock(&sb_lock);
> +
> +		locked = super_lock(sb, excl);
> +		if (locked)
> +			return sb;
> +
> +		spin_lock(&sb_lock);
> +		__put_super(sb);
> +		break;
>  	}
>  	spin_unlock(&sb_lock);
>  	return NULL;
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

