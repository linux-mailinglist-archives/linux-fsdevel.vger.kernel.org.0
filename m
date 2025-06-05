Return-Path: <linux-fsdevel+bounces-50723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B8ACEE97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AED1177E5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C921507F;
	Thu,  5 Jun 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VIq3L636";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fNs6hq+x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VIq3L636";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fNs6hq+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EC101E6
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123137; cv=none; b=KzKskDP54ILXl0Jv/N9HgIRq0xIkH/CKMf0ijUZm3J62F7/9lcyXj7A7i1RsLZgZ8qpweIN8PUBO7NtVGJzJ78UjF0RBjKIwKxiJsLgI6su8K4khkzlBPT/qYWIA5WXrZY0mLR8D/GGnK5Zz21uxXFRa9FtTP/+IyFRKU020Z3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123137; c=relaxed/simple;
	bh=pnGl/l8pcKgaFKuCfCrF0AvIewkIuELE+b6p5jB7ECk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiF/nxoGurr2JBJg8VMC0Z+IOShpUGOiJqoWLKrwMg+N5rkmI46bntzwzt9EjvAIQl1ul65t3J0G2u2m5OD0/GfVbWUOi0h8hsbXN7ei6mai0+mkEC7GylGc3JbnnEMqSZaa30sPy9yg1oGpsI5AtEKFz+QqZoHzUjaso7bcUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VIq3L636; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fNs6hq+x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VIq3L636; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fNs6hq+x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0880B20B8B;
	Thu,  5 Jun 2025 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749123133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KF/A/J9bSP7U/XEa9MZJ9ajKV9tr5ExQhcU9vC/jFc=;
	b=VIq3L636CWt5294O5kpRs00BaCr+ehsydiBiSPU15UAfZJGSNXNlj5htvWRkptYQzx92vc
	jDQzVyuuwpxo4GYV812hNcQftEXUfI7CeW0HFWcdAFPrQT9cgOjCA1P464FKrPgHIjZNms
	IBy8+1NQp2uQo16VMYe54g4DtF4ztmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749123133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KF/A/J9bSP7U/XEa9MZJ9ajKV9tr5ExQhcU9vC/jFc=;
	b=fNs6hq+xqBl1p9dXVZPsrtyPHSWmsV9BqrapoTN0RUND5nnGmr7NHtuNddR4yTdfBByt7J
	Kf+EuIGTTO194HAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VIq3L636;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fNs6hq+x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749123133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KF/A/J9bSP7U/XEa9MZJ9ajKV9tr5ExQhcU9vC/jFc=;
	b=VIq3L636CWt5294O5kpRs00BaCr+ehsydiBiSPU15UAfZJGSNXNlj5htvWRkptYQzx92vc
	jDQzVyuuwpxo4GYV812hNcQftEXUfI7CeW0HFWcdAFPrQT9cgOjCA1P464FKrPgHIjZNms
	IBy8+1NQp2uQo16VMYe54g4DtF4ztmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749123133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KF/A/J9bSP7U/XEa9MZJ9ajKV9tr5ExQhcU9vC/jFc=;
	b=fNs6hq+xqBl1p9dXVZPsrtyPHSWmsV9BqrapoTN0RUND5nnGmr7NHtuNddR4yTdfBByt7J
	Kf+EuIGTTO194HAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA9C11373E;
	Thu,  5 Jun 2025 11:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6L+ODyAQWhlCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Jun 2025 11:32:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C2E2A0951; Thu,  5 Jun 2025 13:32:12 +0200 (CEST)
Date: Thu, 5 Jun 2025 13:32:12 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 2/5] ext4: correct the reserved credits for extent
 conversion
Message-ID: <2xgxxvibw35ijwl5gtuure7hegce6h3ysx2m453hx6hcs5vnqs@2tvvv57fbvee>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
 <20250530062858.458039-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530062858.458039-3-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0880B20B8B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Fri 30-05-25 14:28:55, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now, we reserve journal credits for converting extents in only one page
> to written state when the I/O operation is complete. This is
> insufficient when large folio is enabled.
> 
> Fix this by reserving credits for converting up to one extent per block in
> the largest 2MB folio, this calculation should only involve extents index
> and leaf blocks, so it should not estimate too many credits.
> 
> Fixes: 7ac67301e82f ("ext4: enable large folio for regular file")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5ef34c0c5633..d35c07c1dcac 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2808,12 +2808,12 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  	mpd->journalled_more_data = 0;
>  
>  	if (ext4_should_dioread_nolock(inode)) {
> +		int bpf = ext4_journal_blocks_per_folio(inode);
>  		/*
>  		 * We may need to convert up to one extent per block in
> -		 * the page and we may dirty the inode.
> +		 * the folio and we may dirty the inode.
>  		 */
> -		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
> -						PAGE_SIZE >> inode->i_blkbits);
> +		rsv_blocks = 1 + ext4_ext_index_trans_blocks(inode, bpf);
>  	}
>  
>  	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

