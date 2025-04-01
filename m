Return-Path: <linux-fsdevel+bounces-45433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4DA7792F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA20A3AB6B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3941F17F7;
	Tue,  1 Apr 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8P+rHYu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zu3GfSkV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8P+rHYu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zu3GfSkV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F51F1818
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505061; cv=none; b=qtTRBa4KCYN2McxseinLUqyUOXqqHA0YfurVUE8MGsPyzLaRlj5LttK9DoXy2rovscXrWwKrj14H/xBdkRZZLE64gIUSHWocVADStLX7d+1i6WpnxxDe/RCl9NQfk+C3cgbkMyhnbUdPS7S6o2h62KJF4yziQtzd7ybuKjgiQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505061; c=relaxed/simple;
	bh=XTf5mAip32mtaZ16/701wMBkZimOdpWCwHnLEFEz5fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7IKWoDpcdpO3dZhgy1BxDe2CZcQlsfSQMN8qPPRkY599iAELw+U7EK5jd1Iqlm0mSwaYDFL4O6Vap1xMmZqGPOP6HHAMWaLVov4YwPrWeqkBQ8cudgWcgGufOE/CWN5Ur7J9Ioqj9aJy0wTSqYbimLeJiMChb3dTS/ZfUDBwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8P+rHYu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zu3GfSkV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8P+rHYu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zu3GfSkV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B8121F38E;
	Tue,  1 Apr 2025 10:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743505058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ks00aa614wqMqQeQ7qxtJzPV9hhH3xCwXQ795wViE=;
	b=L8P+rHYuPSWVevuIOQ+uMRIuQqnbnQ6j/kw/cvnoq3qhGXJPMJNGYS+EFHOyUj2ts37lEq
	VhVqpHPUfQ6neX2U/smIsVexEn9Q2UhGhWQMvMjciQ5GK/LEPXN5vnadNxFoJ1FB9tRPeo
	/aG4bpXxcRV592m1pstYHo3A0bfjsQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743505058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ks00aa614wqMqQeQ7qxtJzPV9hhH3xCwXQ795wViE=;
	b=Zu3GfSkVTh1ZSw7YNuHUhugCvDPA6n0OcaCvV90fRCiKAF54mbocG5V/Y7vrxzxj6ZbTOo
	Vrxjl1A/WaB4j7BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743505058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ks00aa614wqMqQeQ7qxtJzPV9hhH3xCwXQ795wViE=;
	b=L8P+rHYuPSWVevuIOQ+uMRIuQqnbnQ6j/kw/cvnoq3qhGXJPMJNGYS+EFHOyUj2ts37lEq
	VhVqpHPUfQ6neX2U/smIsVexEn9Q2UhGhWQMvMjciQ5GK/LEPXN5vnadNxFoJ1FB9tRPeo
	/aG4bpXxcRV592m1pstYHo3A0bfjsQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743505058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J5ks00aa614wqMqQeQ7qxtJzPV9hhH3xCwXQ795wViE=;
	b=Zu3GfSkVTh1ZSw7YNuHUhugCvDPA6n0OcaCvV90fRCiKAF54mbocG5V/Y7vrxzxj6ZbTOo
	Vrxjl1A/WaB4j7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 340FD13691;
	Tue,  1 Apr 2025 10:57:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o3JuDKLG62cSHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Apr 2025 10:57:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFC06A07E6; Tue,  1 Apr 2025 12:57:37 +0200 (CEST)
Date: Tue, 1 Apr 2025 12:57:37 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, riel@surriel.com, 
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, dave@stgolabs.net, 
	david@redhat.com, axboe@kernel.dk, hare@suse.de, david@fromorbit.com, 
	djwong@kernel.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, 
	da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330064732.3781046-3-mcgrof@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,vger.kernel.org,surriel.com,infradead.org,cmpxchg.org,intel.com,stgolabs.net,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 29-03-25 23:47:31, Luis Chamberlain wrote:
> diff --git a/fs/buffer.c b/fs/buffer.c
> index c7abb4a029dc..a4e4455a6ce2 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -208,6 +208,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  	head = folio_buffers(folio);
>  	if (!head)
>  		goto out_unlock;
> +
> +	if (folio->mapping->a_ops->migrate_folio &&
> +	    folio->mapping->a_ops->migrate_folio == buffer_migrate_folio_norefs) {

This is always true for bdev mapping we have here, isn't it?

> +		if (folio_test_lru(folio) &&

Do you expect bdev page cache to contain non-LRU folios? I thought every
pagecache folio is on LRU so this seems pointless as well? But I may be
missing something here.

> +		    folio_test_locked(folio) &&
> +		    !folio_test_writeback(folio))
> +			goto out_unlock;

I find this problematic. It fixes the race with migration, alright
(although IMO we should have a comment very well explaining the interplay
of folio lock and mapping->private_lock to make this work - probably in
buffer_migrate_folio_norefs() - and reference it from here), but there are
places which expect that if __find_get_block() doesn't return anything,
this block is not cached in the buffer cache. And your change breaks this
assumption. Look for example at write_boundary_block(), that will fail to
write the block it should write if it races with someone locking the folio
after your changes. Similarly the code tracking state of deleted metadata
blocks in fs/jbd2/revoke.c will fail to properly update buffer's state if
__find_get_block() suddently starts returning NULL although the buffer is
present in cache. 

> +	}
> +
>  	bh = head;
>  	do {
>  		if (!buffer_mapped(bh))

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

