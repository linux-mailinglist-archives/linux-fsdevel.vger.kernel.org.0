Return-Path: <linux-fsdevel+bounces-72474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DB3CF7F28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 12:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF033114B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4931AA8D;
	Tue,  6 Jan 2026 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dknFXvlg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEENhlSj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o6GYRRI/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="euT+aJA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0988199E94
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767697020; cv=none; b=iaGMMtnBjrSuaBAqq1Zyovt9qdGhLrxLQi0jSGOzcSe0AjGIrr1RimjzjzBJgG3+72E0bHIzcdGbDBGxraS0Kd79KOHAH3hRlxKXRAQN5J0uCkoEKl6GEPWZCpoz5VInuvYvucMqSpEJwtJ4e231krDoNXBG22gU2C6mEJ+QsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767697020; c=relaxed/simple;
	bh=6s4Ay9LOJUcj9HxtsFOyGRFDUVmw+G4S56sQDNxNndY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4CN2Sg/bbAIKqGzqpRBP1U12clXzXsb86ooshVcTQh7ot+VxeyIp042XRmYpfPoFviBkcfN6QWB297vZ1Ofx3zJHh83K2Uq81LCkPBM1FXcoTz8Ig5EQnFFU1/Sq3IHlEefDD12qVgu/Vn95sDO1qb9betX35r1N6NSyk+f/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dknFXvlg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEENhlSj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o6GYRRI/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=euT+aJA3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D06D55BCCE;
	Tue,  6 Jan 2026 10:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767697017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EceJEOv3NYd1LQb0kSunwml0UObwvblgyGa3oOMlbGo=;
	b=dknFXvlgnbY19pfzC9pG3IUKV8An0dSEDhKSI1U/paVB+tz7v3HAbvSwypsUIkK+t7qL3z
	93131A0zcmGfK3FfFaXhjID5wxWrsjWvfkP8J5JhJzDVTR/8QwTrY3vyp2PHDdArNvrfW7
	PkoxdBbaOt65+OIih1y09OFHiINfBKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767697017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EceJEOv3NYd1LQb0kSunwml0UObwvblgyGa3oOMlbGo=;
	b=xEENhlSjb6y2skfxDNQWBe+rJKAHJ74SzC1rDsdB4sdve5ek+H4tFoW/GUgHE8U3LhHWNP
	dz37u9Kdqg0ZM/Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767697016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EceJEOv3NYd1LQb0kSunwml0UObwvblgyGa3oOMlbGo=;
	b=o6GYRRI/0USuVXYJv4ur1CqL21ByA8M6JFOEDsO2XbCRdKFk73vkbByN8EPtC+Xz6cdf+a
	wzsuNREd/QPWOgGalJEk9e/TkOoPfGq4DlUDR3ZJGfKSFqE+BuyKy4lyKDbd2YY3pAkeTc
	hhIIachc1kmCvVWZsSIY11vWHRFV5jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767697016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EceJEOv3NYd1LQb0kSunwml0UObwvblgyGa3oOMlbGo=;
	b=euT+aJA3HglZmsa12FEkRoAJKimyUxXGDy0s+5Fop1qCs8ylhfeyIxGmftDvdblTbuGwPi
	SgxEyHBs7JYGmBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C48443EA63;
	Tue,  6 Jan 2026 10:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bp3qL3jqXGlDNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 10:56:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84FA0A08E3; Tue,  6 Jan 2026 11:56:52 +0100 (CET)
Date: Tue, 6 Jan 2026 11:56:52 +0100
From: Jan Kara <jack@suse.cz>
To: sunyongjian1@huawei.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tytso@mit.edu, jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, chengzhihao1@huawei.com
Subject: Re: [RFC PATCH] ext4: fix e4b bitmap inconsistency reports
Message-ID: <ak5cxhlqoqdq47nyp6v6ynbww4u4pndkytzitzt3w2ukad2wlq@qlcwq5fhr7qa>
References: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[huawei.com:email,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 06-01-26 17:08:20, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> A bitmap inconsistency issue was observed during stress tests under
> mixed huge-page workloads. Ext4 reported multiple e4b bitmap check
> failures like:
> 
> ext4_mb_complex_scan_group:2508: group 350, 8179 free clusters as
> per group info. But got 8192 blocks
> 
> Analysis and experimentation confirmed that the issue is caused by a
> race condition between page migration and bitmap modification. Although
> this timing window is extremely narrow, it is still hit in practice:
> 
> folio_lock                        ext4_mb_load_buddy
> __migrate_folio
>   check ref count
>   folio_mc_copy                     __filemap_get_folio
>                                       folio_try_get(folio)
>                                   ......
>                                   mb_mark_used
>                                   ext4_mb_unload_buddy
>   __folio_migrate_mapping
>     folio_ref_freeze
> folio_unlock
> 
> The root cause of this issue is that the fast path of load_buddy only
> increments the folio's reference count, which is insufficient to prevent
> concurrent folio migration. We observed that the folio migration process
> acquires the folio lock. Therefore, we can determine whether to take the
> fast path in load_buddy by checking the lock status. If the folio is
> locked, we opt for the slow path (which acquires the lock) to close this
> concurrency window.
> 
> Additionally, this change addresses the following issues:
> 
> When the DOUBLE_CHECK macro is enabled to inspect bitmap-related
> issues, the following error may be triggered:
> 
> corruption in group 324 at byte 784(6272): f in copy != ff on
> disk/prealloc
> 
> Analysis reveals that this is a false positive. There is a specific race
> window where the bitmap and the group descriptor become momentarily
> inconsistent, leading to this error report:
> 
> ext4_mb_load_buddy                   ext4_mb_load_buddy
>   __filemap_get_folio(create|lock)
>     folio_lock
>   ext4_mb_init_cache
>     folio_mark_uptodate
>                                      __filemap_get_folio(no lock)
>                                      ......
>                                      mb_mark_used
>                                        mb_mark_used_double
>   mb_cmp_bitmaps
>                                        mb_set_bits(e4b->bd_bitmap)
>   folio_unlock
> 
> The original logic assumed that since mb_cmp_bitmaps is called when the
> bitmap is newly loaded from disk, the folio lock would be sufficient to
> prevent concurrent access. However, this overlooks a specific race
> condition: if another process attempts to load buddy and finds the folio
> is already in an uptodate state, it will immediately begin using it without
> holding folio lock.
> 
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>

Nice catch! The fix looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..de4cacb740b3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1706,16 +1706,17 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
>  
>  	/* Avoid locking the folio in the fast path ... */
>  	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
> +		/*
> +		 * folio_test_locked is employed to detect ongoing folio
> +		 * migrations, since concurrent migrations can lead to
> +		 * bitmap inconsistency. And if we are not uptodate that
> +		 * implies somebody just created the folio but is yet to
> +		 * initialize it. We can drop the folio reference and
> +		 * try to get the folio with lock in both cases to avoid
> +		 * concurrency.
> +		 */
>  		if (!IS_ERR(folio))
> -			/*
> -			 * drop the folio reference and try
> -			 * to get the folio with lock. If we
> -			 * are not uptodate that implies
> -			 * somebody just created the folio but
> -			 * is yet to initialize it. So
> -			 * wait for it to initialize.
> -			 */
>  			folio_put(folio);
>  		folio = __filemap_get_folio(inode->i_mapping, pnum,
>  				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
> @@ -1764,7 +1765,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
>  
>  	/* we need another folio for the buddy */
>  	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (IS_ERR(folio) || !folio_test_uptodate(folio) || folio_test_locked(folio)) {
>  		if (!IS_ERR(folio))
>  			folio_put(folio);
>  		folio = __filemap_get_folio(inode->i_mapping, pnum,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

