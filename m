Return-Path: <linux-fsdevel+bounces-53666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF9AF5B35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094A83A60BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F5307AF3;
	Wed,  2 Jul 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cuqwUwUA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uZUdu1rh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eXUyGZai";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E0VG6IHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBE2F5307
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466876; cv=none; b=fNKHFNjqWMDzvuFFOTWGRvwHHI4KvpkyR9/+MycZtV0QJ8LsXzNtXYz+ZluA4QBqbUec1dCNhOwj/purZVU/c0sUv4bMYNlCtub+fruBJlTfRp5p0+3i+c95H8Xe3bXX+LdDWrqoXKXYbFBobzGRyAHFnpvgHgBNR7TUE2JL19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466876; c=relaxed/simple;
	bh=epLzkS0pNBoPrsvr5Xd6ikwLk40ga6ReZLZIvmH70J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWuPgbnPFReKqjAP46EvvCHgqnmkBzYWdlSUPBKpVI483720dGwugNK3acUMkYcbaAfjOLVlnBGZPKvhCieAjFWXE126fSaFsFMZyicrRFcCGWf3zFiw47m36EJ8f+mxvwkZKbdZX1ayMWWW926i7DvklawWXGzjeeW4qVJwaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cuqwUwUA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uZUdu1rh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eXUyGZai; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E0VG6IHZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFD801F38D;
	Wed,  2 Jul 2025 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751466873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Y/km41+XwnsHF2SeWAKoMP9vO75rN03wqB7wxWr5U=;
	b=cuqwUwUAhUkVzoDgT6Xdv1sA0yRpk9vOlCteZSEjlnDIsA+SIDFD8lfpKvQ7csi1ZOfNgM
	NwVsecHh/dp8QddDFkSNgoYEZbTstysvxjk1Z14V5tFpqbdO9/AV+lCZGm4tb8y1n03wJB
	yrUs1EjF03zKmQWhmAk8l6FB3ELwN8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751466873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Y/km41+XwnsHF2SeWAKoMP9vO75rN03wqB7wxWr5U=;
	b=uZUdu1rha3rTVRvPdx+63U+IV+tLWAZBinNwV7V6F5r9F/kJ/60Z+6KDApRiKrHLTFH+ok
	NvQdT8wq+AejifCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eXUyGZai;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=E0VG6IHZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751466872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Y/km41+XwnsHF2SeWAKoMP9vO75rN03wqB7wxWr5U=;
	b=eXUyGZai8cYwaUuO7cJLFs6EjvE2Cc+GR8oEgZgNEcqdn1rZeQnYwTXVCxaG0knY43ehuT
	oYC199zSeG0unmAlh3uxuMZw4gMV9UtHq7hrcAvEQH4h4EVTXqP/8z7nA8StlSPL+7E2bO
	QZUntFzmZr84ZiyiikBNPx21V7UXc7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751466872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Y/km41+XwnsHF2SeWAKoMP9vO75rN03wqB7wxWr5U=;
	b=E0VG6IHZZ7gebj2RU3ufIOVxxridH9Y+0SWkH+spzCAjRd5VnYIWbNyWkq81KDWahb5OZc
	+FOsFVFi0wqNPADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA8DF13A24;
	Wed,  2 Jul 2025 14:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /7hWNXhDZWiTRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 14:34:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F560A0A55; Wed,  2 Jul 2025 16:34:24 +0200 (CEST)
Date: Wed, 2 Jul 2025 16:34:24 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 08/10] ext4: reserved credits for one extent during
 the folio writeback
Message-ID: <3lhwbxlfcqt5ou3z2xzo7o7zdvpmgldju33cd2wqnvsszfhnaf@i2qkwhrja7be>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701130635.4079595-9-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EFD801F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 01-07-25 21:06:33, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After ext4 supports large folios, reserving journal credits for one
> maximum-ordered folio based on the worst case cenario during the
> writeback process can easily exceed the maximum transaction credits.
> Additionally, reserving journal credits for one page is also no
> longer appropriate.
> 
> Currently, the folio writeback process can either extend the journal
> credits or initiate a new transaction if the currently reserved journal
> credits are insufficient. Therefore, it can be modified to reserve
> credits for only one extent at the outset. In most cases involving
> continuous mapping, these credits are generally adequate, and we may
> only need to perform some basic credit expansion. However, in extreme
> cases where the block size and folio size differ significantly, or when
> the folios are sufficiently discontinuous, it may be necessary to
> restart a new transaction and resubmit the folios.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3230734a3014..ceaede80d791 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2546,21 +2546,6 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  	return err;
>  }
>  
> -/*
> - * Calculate the total number of credits to reserve for one writepages
> - * iteration. This is called from ext4_writepages(). We map an extent of
> - * up to MAX_WRITEPAGES_EXTENT_LEN blocks and then we go on and finish mapping
> - * the last partial page. So in total we can map MAX_WRITEPAGES_EXTENT_LEN +
> - * bpp - 1 blocks in bpp different extents.
> - */
> -static int ext4_da_writepages_trans_blocks(struct inode *inode)
> -{
> -	int bpp = ext4_journal_blocks_per_folio(inode);
> -
> -	return ext4_meta_trans_blocks(inode,
> -				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
> -}
> -
>  static int ext4_journal_folio_buffers(handle_t *handle, struct folio *folio,
>  				     size_t len)
>  {
> @@ -2917,8 +2902,14 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		 * not supported by delalloc.
>  		 */
>  		BUG_ON(ext4_should_journal_data(inode));
> -		needed_blocks = ext4_da_writepages_trans_blocks(inode);
> -
> +		/*
> +		 * Calculate the number of credits needed to reserve for one
> +		 * extent of up to MAX_WRITEPAGES_EXTENT_LEN blocks. It will
> +		 * attempt to extend the transaction or start a new iteration
> +		 * if the reserved credits are insufficient.
> +		 */
> +		needed_blocks = ext4_chunk_trans_blocks(inode,
> +						MAX_WRITEPAGES_EXTENT_LEN);
>  		/* start a new transaction */
>  		handle = ext4_journal_start_with_reserve(inode,
>  				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

