Return-Path: <linux-fsdevel+bounces-67082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F2C34E6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61165658BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E4308F0C;
	Wed,  5 Nov 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFsG9XOx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9nFT0QKk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFsG9XOx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9nFT0QKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B2307AEC
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335111; cv=none; b=jIhr6WMncpz1qm+ZUEMxXaBalFpoJl0giydUrc952T+ncuT4GtMU3HY7gF8E4NrPa5LhQCsZgj4wO3O2e73AmeZ67d22QMGvW3c+odj2WzeBwTmyU/gxPgX6gCp9o57U0wP1NXgFJ8k6qKzTwTSHSBJgi2fheCyWGPStezeVXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335111; c=relaxed/simple;
	bh=GDB21ai+kCMmgIslapYk1wk+NMXv8CUnfEY2zyE44rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9nJ9sGHwKcfogXzWhlShwyPHIMNPCVP96tx0qHKCByKDD8NQS0Q5D02AjWfLtAu2/fYwuqtuYtDDEWDpz8nDojESCp/aG0VdRMyMR+Cfoukwe0v+IgCq85sieU0RNhG3H6mmxF/V/NdfyX0P3iGyrQjiiFkUWTOpXXof3eygf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFsG9XOx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9nFT0QKk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFsG9XOx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9nFT0QKk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A65A211CD;
	Wed,  5 Nov 2025 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762335108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dhBI3wtUUGN8VYMC+NN1TmUWEPtpBQKbvGkUzp4Vn4=;
	b=aFsG9XOxNgfZjqF1+TZq/aUlkyMAiG05LcrvqPnchHr6sZXxbpALmJkaW7aGCADJxPrk5n
	RuN8RRXOzucWiSgNK2gBI2JAUjD4iXGWsG6Aa2+Im3OGLAJKF5HG7lRJniHhBZAvgCGngn
	o3m72mdRxiE0fpM5Jxcz8fFg4dty6P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762335108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dhBI3wtUUGN8VYMC+NN1TmUWEPtpBQKbvGkUzp4Vn4=;
	b=9nFT0QKkG7hMvQYQz1w+N4wRwdOEX10tqjL851bdA15QjLQ7JVXzRO2WuQFuVL9qqHMar/
	5HzjHwYO4GhrbgDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aFsG9XOx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9nFT0QKk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762335108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dhBI3wtUUGN8VYMC+NN1TmUWEPtpBQKbvGkUzp4Vn4=;
	b=aFsG9XOxNgfZjqF1+TZq/aUlkyMAiG05LcrvqPnchHr6sZXxbpALmJkaW7aGCADJxPrk5n
	RuN8RRXOzucWiSgNK2gBI2JAUjD4iXGWsG6Aa2+Im3OGLAJKF5HG7lRJniHhBZAvgCGngn
	o3m72mdRxiE0fpM5Jxcz8fFg4dty6P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762335108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dhBI3wtUUGN8VYMC+NN1TmUWEPtpBQKbvGkUzp4Vn4=;
	b=9nFT0QKkG7hMvQYQz1w+N4wRwdOEX10tqjL851bdA15QjLQ7JVXzRO2WuQFuVL9qqHMar/
	5HzjHwYO4GhrbgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00BF9132DD;
	Wed,  5 Nov 2025 09:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nEssAIQZC2n6HgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:31:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AD641A083B; Wed,  5 Nov 2025 10:31:47 +0100 (CET)
Date: Wed, 5 Nov 2025 10:31:47 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 19/25] ext4: support large block size in
 mpage_prepare_extent_to_map()
Message-ID: <fgyzoczbfupsdkstxojoodxnny3mjoqj4jn7k26lq7barrtq72@zvw2p5pvglnk>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-20-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-20-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 0A65A211CD
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spamd-Bar: /

On Sat 25-10-25 11:22:15, libaokun@huaweicloud.com wrote:
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
>  fs/ext4/inode.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index cbf04b473ae7..ce48cc6780a3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2610,7 +2610,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  	pgoff_t end = mpd->end_pos >> PAGE_SHIFT;
>  	xa_mark_t tag;
>  	int i, err = 0;
> -	int blkbits = mpd->inode->i_blkbits;
>  	ext4_lblk_t lblk;
>  	struct buffer_head *head;
>  	handle_t *handle = NULL;
> @@ -2649,7 +2648,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  			 */
>  			if (mpd->wbc->sync_mode == WB_SYNC_NONE &&
>  			    mpd->wbc->nr_to_write <=
> -			    mpd->map.m_len >> (PAGE_SHIFT - blkbits))
> +			    EXT4_LBLK_TO_P(mpd->inode, mpd->map.m_len))
>  				goto out;
>  
>  			/* If we can't merge this page, we are done. */
> @@ -2727,8 +2726,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  				mpage_folio_done(mpd, folio);
>  			} else {
>  				/* Add all dirty buffers to mpd */
> -				lblk = ((ext4_lblk_t)folio->index) <<
> -					(PAGE_SHIFT - blkbits);
> +				lblk = EXT4_P_TO_LBLK(mpd->inode, folio->index);
>  				head = folio_buffers(folio);
>  				err = mpage_process_page_bufs(mpd, head, head,
>  						lblk);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

