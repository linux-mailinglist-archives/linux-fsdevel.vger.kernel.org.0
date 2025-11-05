Return-Path: <linux-fsdevel+bounces-67081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B545AC34E0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53053A4863
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65450301026;
	Wed,  5 Nov 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KuZQtyDj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cn3IsDC1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KuZQtyDj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cn3IsDC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C42FFF86
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335066; cv=none; b=NmDIwenGIfrYxbl0KAWxaHUu5bY6XP1Qmk8R47t1rIQDKZsaV5v8UtImnQbhR0AXy5vT5T5RhNrEtYWzZyfjeEw2wIOksZkaZGbj65Yrzp6CJuimUt1f2G0qHmbToL3LPfPFNnhMribuaSxqD+7hZBztUkO5ZK4RxwSUbaEvpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335066; c=relaxed/simple;
	bh=S8h7iUaVF7c86BoK6i0mG+iUthG0j0q+DUEPZ3HsKzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO39/V4ExJphg5Vo++KyeP32Xfxe4guAzzzjJHYgYJOiiBl78PREyCktrhX5iaBwVR3yRCG5HpXup0P2rkvZ1jXfCTHbPUYJSP2Y4fc2aRRZzBy0yY1luyenz3izOBc3Ro2CxsThEvqYxDaIsgh0VelTQekhg5VkTSUVSuNgRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KuZQtyDj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cn3IsDC1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KuZQtyDj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cn3IsDC1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9A691F443;
	Wed,  5 Nov 2025 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762335061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3v0IBakxPfN80lKZ9HG+/JKVr7LVerWut7g1o96eek=;
	b=KuZQtyDjDUi7V99tm5RZCGH6RaZguDOoGjZ3UKdBXbYzrtKjGV6VqRMeSTuk0gMYQpaWs7
	ANBEo3cnhvywej/ZR7p4863VnVib1MuQybQG+sJKjhDvGk+o2esTiXlx/P41jamBcA7X6v
	C5CYJee1QE3CSvn2WIp1rAMlt3uvYgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762335061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3v0IBakxPfN80lKZ9HG+/JKVr7LVerWut7g1o96eek=;
	b=cn3IsDC1WuCkmuWAXqBY5fycF9EKm9Cx/1ov+sr8+dV249nzyqfUgdOZSsFaUmVjt5VCIh
	XLspu1adc1xBnpDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KuZQtyDj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cn3IsDC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762335061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3v0IBakxPfN80lKZ9HG+/JKVr7LVerWut7g1o96eek=;
	b=KuZQtyDjDUi7V99tm5RZCGH6RaZguDOoGjZ3UKdBXbYzrtKjGV6VqRMeSTuk0gMYQpaWs7
	ANBEo3cnhvywej/ZR7p4863VnVib1MuQybQG+sJKjhDvGk+o2esTiXlx/P41jamBcA7X6v
	C5CYJee1QE3CSvn2WIp1rAMlt3uvYgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762335061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3v0IBakxPfN80lKZ9HG+/JKVr7LVerWut7g1o96eek=;
	b=cn3IsDC1WuCkmuWAXqBY5fycF9EKm9Cx/1ov+sr8+dV249nzyqfUgdOZSsFaUmVjt5VCIh
	XLspu1adc1xBnpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF959132DD;
	Wed,  5 Nov 2025 09:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ir3cKlUZC2kpHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:31:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5E667A083B; Wed,  5 Nov 2025 10:30:57 +0100 (CET)
Date: Wed, 5 Nov 2025 10:30:57 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 18/25] ext4: support large block size in
 mpage_map_and_submit_buffers()
Message-ID: <cyxlv42ng4cetw55mzxywfmzoqo7uzeemswnwn3ztfuphdpdiv@bjlhohw3gdzs>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-19-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-19-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: B9A691F443
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: /

On Sat 25-10-25 11:22:14, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Use the EXT4_P_TO_LBLK/EXT4_LBLK_TO_P macros to complete the conversion
> between folio indexes and blocks to avoid negative left/right shifts after
> supporting blocksize greater than PAGE_SIZE.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d97ce88d6e0a..cbf04b473ae7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2289,15 +2289,14 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
>  	struct folio_batch fbatch;
>  	unsigned nr, i;
>  	struct inode *inode = mpd->inode;
> -	int bpp_bits = PAGE_SHIFT - inode->i_blkbits;
>  	pgoff_t start, end;
>  	ext4_lblk_t lblk;
>  	ext4_fsblk_t pblock;
>  	int err;
>  	bool map_bh = false;
>  
> -	start = mpd->map.m_lblk >> bpp_bits;
> -	end = (mpd->map.m_lblk + mpd->map.m_len - 1) >> bpp_bits;
> +	start = EXT4_LBLK_TO_P(inode, mpd->map.m_lblk);
> +	end = EXT4_LBLK_TO_P(inode, mpd->map.m_lblk + mpd->map.m_len - 1);
>  	pblock = mpd->map.m_pblk;
>  
>  	folio_batch_init(&fbatch);
> @@ -2308,7 +2307,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
>  		for (i = 0; i < nr; i++) {
>  			struct folio *folio = fbatch.folios[i];
>  
> -			lblk = folio->index << bpp_bits;
> +			lblk = EXT4_P_TO_LBLK(inode, folio->index);
>  			err = mpage_process_folio(mpd, folio, &lblk, &pblock,
>  						 &map_bh);
>  			/*
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

