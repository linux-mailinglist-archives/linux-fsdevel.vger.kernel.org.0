Return-Path: <linux-fsdevel+bounces-52240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8643AE09B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1514C3B5175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1272BF01B;
	Thu, 19 Jun 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dhBy4NpF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0awkBNA9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ufuwwc8+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L22I6nuJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D728E5E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345059; cv=none; b=mIxHfRrWkTpeyI49Mp8uNLwJ8hB8AWrljcGEsQ5YT+aEXxFSbdVZA7omr24MiK+PVvAt8XwQmsD0AK2waxY/1ohR8OIskKOPvJxV+/sfG7fsdTcqzdWh+kEfmy0MR9/YOf9wxK5LX7CGsXiqVOnrVnxEWfNdvg8e1HlPkhWvnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345059; c=relaxed/simple;
	bh=7J/CgqkbcXG80noHuDHoNIvH2vrVKo6vpYMK3no1se4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rogaXI3naVKgE1DZPNdUH0MiHZRdQLaWynzGnNlNOz5IGPpKXpP/rYbC/rBorcjAobmt2NXoP5VSiAcUxOoU31GgEgmjs24GxbyQzWeUMVBqXcrQ2hSMLs6CpHY4ZFoDpUXTRFbxQAPtn2R++4aSbxjr7UIZMGgLR5IgkgizxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dhBy4NpF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0awkBNA9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ufuwwc8+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L22I6nuJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D74DC1F38D;
	Thu, 19 Jun 2025 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750345055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsAbVB1A+G2OxEiG/UThBd8zRPy1cJO27DKKL7Bfk7A=;
	b=dhBy4NpFXrENKVoDlm5F9zRKTbXOI2iIGo4p+hDxV/38avsEdaVYDX8YjFv0qk5Hbrtfxc
	94pDJBFQrww2V0sKG0QBLRRe5pEublPW5jzD+NTsS2XqGxVvRytcAJnmIGwXO/3hkMZXrj
	tCnsxfS0gHQ0txiyEXDyB4jO40Q4jUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750345055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsAbVB1A+G2OxEiG/UThBd8zRPy1cJO27DKKL7Bfk7A=;
	b=0awkBNA9Qn/ucAaAy7vZZB4p5FBcUp5ykhONmJZ/jH8F/HCiMIQCC/1oeSUWMc4DIOWHii
	wSJcaD82ykgRfJDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750345054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsAbVB1A+G2OxEiG/UThBd8zRPy1cJO27DKKL7Bfk7A=;
	b=Ufuwwc8+qIyNq2wvtQEjo3Uw6cQ7D9VrXkbUZSb2dSwd5PRlXdhBvsJKmz9OL6TcBiSqEh
	6sFv/1dSSA47dXa/hhqqjK9zu9emOBqvETzxl1q8HiPaLir5FAP65zQcTKl5OAWZjdur1N
	af5r+KGsIKgxuLJfy9Yr8/H0Oeo3nCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750345054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsAbVB1A+G2OxEiG/UThBd8zRPy1cJO27DKKL7Bfk7A=;
	b=L22I6nuJQ1fKMgi3GLQkOCtJcqlkZTyCG3JsuAxpYEvvovrx7IYsWCzCg3Iu7UjIn6mc2E
	6ETIE9QoWEaPVSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C914813721;
	Thu, 19 Jun 2025 14:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j7IVMV4lVGi9KgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 14:57:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B2C4A29F8; Thu, 19 Jun 2025 16:57:34 +0200 (CEST)
Date: Thu, 19 Jun 2025 16:57:34 +0200
From: Jan Kara <jack@suse.cz>
To: avinashlalotra <abinashlalotra@gmail.com>
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, avinashlalotra <abinashsinghlalotra@gmail.com>, 
	syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fsnotify: initialize destroy_next to avoid KMSAN
 uninit-value warning
Message-ID: <hzxqc3tbxc7bd6s3qv3hyocxvhuh4zszkvkqkvrmefhc5qrlez@5yroq663nxpj>
References: <20250619105117.106907-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619105117.106907-1-abinashsinghlalotra@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[aaeb1646d01d0358cb2a];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 19-06-25 16:21:17, avinashlalotra wrote:
> KMSAN reported an uninitialized value use in
> fsnotify_connector_destroy_workfn(), specifically when accessing
> `conn->destroy_next`:
> 
>     BUG: KMSAN: uninit-value in fsnotify_connector_destroy_workfn+0x108/0x160
>     Uninit was created at:
>      slab_alloc_node mm/slub.c:4197 [inline]
>      kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4204
>      fsnotify_attach_connector_to_object fs/notify/mark.c:663
> 
> The struct fsnotify_mark_connector was allocated using
> kmem_cache_alloc(), but the `destroy_next` field was never initialized,
> leading to a use of uninitialized memory when the work function later
> traversed the destroy list.
> 
> Fix this by explicitly initializing `destroy_next` to NULL immediately
> after allocation.
> 
> Reported-by: syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
> Signed-off-by: abinashlalotra <abinashsinghlalotra@gmail.com>

This doesn't make sense. If you checked definition of
fsnotify_mark_connector you'd see that destroy_next is in union with void
*obj:

        union {
                /* Object pointer [lock] */
                void *obj;
                /* Used listing heads to free after srcu period expires */
                struct fsnotify_mark_connector *destroy_next;
        };

and we do initialize 'obj' pointer in
fsnotify_attach_connector_to_object(). So this report was caused either by
some other memory corruption or KMSAN getting utterly confused...

								Honza

> 
> ---
> v2: Corrected the syzbot Reported-by email address.
> ---
>  fs/notify/mark.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 798340db69d7..28013046f732 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -665,6 +665,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  		return -ENOMEM;
>  	spin_lock_init(&conn->lock);
>  	INIT_HLIST_HEAD(&conn->list);
> +	conn->destroy_next = NULL;
>  	conn->flags = 0;
>  	conn->prio = 0;
>  	conn->type = obj_type;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

