Return-Path: <linux-fsdevel+bounces-67075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA9C34B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D95818848CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE52FB0B4;
	Wed,  5 Nov 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DM49Z0AV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QqrZbFsD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DM49Z0AV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QqrZbFsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB92DE704
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334043; cv=none; b=jEubQbuxXcB3nU9afM3V3QV0/YBG+oZzYZw1YnoKtfXxT+ZIBUUoCbXBzYeopDYYZOlcqiJjKp3WgRJ0a9tA0sUqvTtQoCEdgt0UI2PpG7uaJ4Gikx00kcPGQ7Lx3glrO2X6eJHwuSlKD9ZliTwufOXajUMtfCfgPBVwk/FDmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334043; c=relaxed/simple;
	bh=CV9fZREeCgOAqmEQden0wucsawb7ZKlS5/iwvuk6mQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elsnkyEO9+JQ21jcyHdPoJ+OeuH+WGCf40iWlfbP7bFJwRHtcvG5rEVytBqMrnLfJLkm6SREHBf7hV0OXjH6+FJ6muwGqt22Q4GR1n+scqbv3bMKSgLppY/TJkman+6t8Mbtpkc/YDUDs1iSj4iqq1fxZFFc447qz9Hqu8VMrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DM49Z0AV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QqrZbFsD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DM49Z0AV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QqrZbFsD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88A842117A;
	Wed,  5 Nov 2025 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVULkgdA4xsS+fwyNhdq5btCzXP1JoCzKO3djpV8yo=;
	b=DM49Z0AVDbdX9K4m55bhvKSEXvqStAOD7sIrHzA2bDCs946x17M1wBUmJl0KvkxTtzOv4r
	J/GnFld1WgFiQx9BLNFwVIqYw3fRfJbcU1YjkAzYcmfPgsN67hftIv0BLEzuJBNfQz21O1
	Q5q6j0oV0lJ+5ArhM/wnnjKTAkCmw3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVULkgdA4xsS+fwyNhdq5btCzXP1JoCzKO3djpV8yo=;
	b=QqrZbFsD8QMZ+iHmxR557wLBgrgr/Tw9H8D62mgtMmeUi4R2sCijayKcLEYoWvYdCqYtph
	IDipEq2zq1JG4sDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DM49Z0AV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QqrZbFsD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVULkgdA4xsS+fwyNhdq5btCzXP1JoCzKO3djpV8yo=;
	b=DM49Z0AVDbdX9K4m55bhvKSEXvqStAOD7sIrHzA2bDCs946x17M1wBUmJl0KvkxTtzOv4r
	J/GnFld1WgFiQx9BLNFwVIqYw3fRfJbcU1YjkAzYcmfPgsN67hftIv0BLEzuJBNfQz21O1
	Q5q6j0oV0lJ+5ArhM/wnnjKTAkCmw3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVULkgdA4xsS+fwyNhdq5btCzXP1JoCzKO3djpV8yo=;
	b=QqrZbFsD8QMZ+iHmxR557wLBgrgr/Tw9H8D62mgtMmeUi4R2sCijayKcLEYoWvYdCqYtph
	IDipEq2zq1JG4sDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79C33132DD;
	Wed,  5 Nov 2025 09:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OkO0HVcVC2kwDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:13:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36A42A083B; Wed,  5 Nov 2025 10:13:55 +0100 (CET)
Date: Wed, 5 Nov 2025 10:13:55 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 12/25] ext4: support large block size in
 ext4_mb_get_buddy_page_lock()
Message-ID: <5kbyz6ilhj7zde4dtv7fhy33yks3bhs2g6xesdzwptdenrrfdg@ydurgdouhuwn>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-13-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-13-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:dkim,suse.cz:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 88A842117A
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Sat 25-10-25 11:22:08, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Currently, ext4_mb_get_buddy_page_lock() uses blocks_per_page to calculate
> folio index and offset. However, when blocksize is larger than PAGE_SIZE,
> blocks_per_page becomes zero, leading to a potential division-by-zero bug.
> 
> To support BS > PS, use bytes to compute folio index and offset within
> folio to get rid of blocks_per_page.
> 
> Also, since ext4_mb_get_buddy_page_lock() already fully supports folio,
> rename it to ext4_mb_get_buddy_folio_lock().
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good, just two typo fixes below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 3494c6fe5bfb..d42d768a705a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1510,50 +1510,52 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>  }
>  

Let's fix some typos when updating the comment:

>  /*
> - * Lock the buddy and bitmap pages. This make sure other parallel init_group
> - * on the same buddy page doesn't happen whild holding the buddy page lock.
> - * Return locked buddy and bitmap pages on e4b struct. If buddy and bitmap
> - * are on the same page e4b->bd_buddy_folio is NULL and return value is 0.
> + * Lock the buddy and bitmap folios. This make sure other parallel init_group
					     ^^^ makes

> + * on the same buddy folio doesn't happen whild holding the buddy folio lock.
					     ^^ while

> + * Return locked buddy and bitmap folios on e4b struct. If buddy and bitmap
> + * are on the same folio e4b->bd_buddy_folio is NULL and return value is 0.
>   */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

