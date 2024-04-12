Return-Path: <linux-fsdevel+bounces-16797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365B88A2E08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 14:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598581C2149E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563156B80;
	Fri, 12 Apr 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGBvZ4h+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8oZKfPu8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGBvZ4h+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8oZKfPu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4156B76;
	Fri, 12 Apr 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924122; cv=none; b=LdD9ZvrgA3W/3u+41dL1p7yaxP9uhISgDbWM1dA5HGUrKahxda+Z9nr7CimFoEHwUhfqzkLFOiL2vcucj0sBDw4aGoBY1ew/CeVH8OylAAKoUkt8By8dXJYtWVX6MYzqWTrhxrblWS8WVgiDHFrsLOYK/xYb8l/G54HQTwUlaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924122; c=relaxed/simple;
	bh=n0eNFqjcG5/e6FD0tZqHXi2DZkGJK+tAhG3/ir6LIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG3y0dtB2ehLIAgXnkppFLDFItNsGhI5+Y3fuONUR3E7PSQeXR7QaOMLt0IHxCP0o/quHBWAleBrRZBY5dVc+cBUZC7x8U4hjp26K63V4unXbxfPwlnTdPsnS1Rlbvpv3wB8QRZ2HezDBeYW1aom/D+h3imTkP6X+n1vIJd7zJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGBvZ4h+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8oZKfPu8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGBvZ4h+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8oZKfPu8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F87D38218;
	Fri, 12 Apr 2024 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712924118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdmWnw5E39YgmOSiekoth0B4zamZHPdp8goBAuAJSec=;
	b=fGBvZ4h+SDbV9RclFi1NtJvW+ptq3lKfVx2SIsostAzBRNyB03HNWochdNwrCaCgoR6Kh9
	c+hm+J5549TBe2sXKD1AD/8xn+oMrmjOxhSHTi3OGjxmEL9zXk0QLLt2E2GnnVPGGRmhBE
	nkqfmoVcDCRBy5+pQiByVB6jRRsK0rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712924118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdmWnw5E39YgmOSiekoth0B4zamZHPdp8goBAuAJSec=;
	b=8oZKfPu86rJxeiMcp7C3Afp/nt2UqPrBM+fD2rO9+jtVOdlkG0GRYFHxYvYrMtpv09gKpG
	2Pk3gcqtyArGlSBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712924118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdmWnw5E39YgmOSiekoth0B4zamZHPdp8goBAuAJSec=;
	b=fGBvZ4h+SDbV9RclFi1NtJvW+ptq3lKfVx2SIsostAzBRNyB03HNWochdNwrCaCgoR6Kh9
	c+hm+J5549TBe2sXKD1AD/8xn+oMrmjOxhSHTi3OGjxmEL9zXk0QLLt2E2GnnVPGGRmhBE
	nkqfmoVcDCRBy5+pQiByVB6jRRsK0rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712924118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdmWnw5E39YgmOSiekoth0B4zamZHPdp8goBAuAJSec=;
	b=8oZKfPu86rJxeiMcp7C3Afp/nt2UqPrBM+fD2rO9+jtVOdlkG0GRYFHxYvYrMtpv09gKpG
	2Pk3gcqtyArGlSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53F7C1368B;
	Fri, 12 Apr 2024 12:15:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vxd8FNYlGWYSRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Apr 2024 12:15:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF1CEA071E; Fri, 12 Apr 2024 14:15:17 +0200 (CEST)
Date: Fri, 12 Apr 2024 14:15:17 +0200
From: Jan Kara <jack@suse.cz>
To: Chao Yu <chao@kernel.org>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: fix to propagate error of mark_dquot_dirty() to
 caller
Message-ID: <20240412121517.dydwqiqkdzvwpwf5@quack3>
References: <20240412094942.2131243-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412094942.2131243-1-chao@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 12-04-24 17:49:42, Chao Yu wrote:
> in order to let caller be aware of failure of mark_dquot_dirty().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index dacbee455c03..b2a109d8b198 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1737,7 +1737,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>  
>  	if (reserve)
>  		goto out_flush_warn;
> -	mark_all_dquot_dirty(dquots);
> +	ret = mark_all_dquot_dirty(dquots);
>  out_flush_warn:
>  	srcu_read_unlock(&dquot_srcu, index);
>  	flush_warnings(warn);
> @@ -1786,7 +1786,7 @@ int dquot_alloc_inode(struct inode *inode)
>  warn_put_all:
>  	spin_unlock(&inode->i_lock);
>  	if (ret == 0)
> -		mark_all_dquot_dirty(dquots);
> +		ret = mark_all_dquot_dirty(dquots);
>  	srcu_read_unlock(&dquot_srcu, index);
>  	flush_warnings(warn);
>  	return ret;
> @@ -1990,7 +1990,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>  	qsize_t inode_usage = 1;
>  	struct dquot __rcu **dquots;
>  	struct dquot *transfer_from[MAXQUOTAS] = {};
> -	int cnt, index, ret = 0;
> +	int cnt, index, ret = 0, err;
>  	char is_valid[MAXQUOTAS] = {};
>  	struct dquot_warn warn_to[MAXQUOTAS];
>  	struct dquot_warn warn_from_inodes[MAXQUOTAS];
> @@ -2087,8 +2087,12 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>  	 * mark_all_dquot_dirty().
>  	 */
>  	index = srcu_read_lock(&dquot_srcu);
> -	mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
> -	mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
> +	err = mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
> +	if (err < 0)
> +		ret = err;
> +	err = mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
> +	if (err < 0)
> +		ret = err;
>  	srcu_read_unlock(&dquot_srcu, index);
>  
>  	flush_warnings(warn_to);
> @@ -2098,7 +2102,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
>  		if (is_valid[cnt])
>  			transfer_to[cnt] = transfer_from[cnt];
> -	return 0;
> +	return ret;
>  over_quota:
>  	/* Back out changes we already did */
>  	for (cnt--; cnt >= 0; cnt--) {
> @@ -2726,6 +2730,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>  	struct mem_dqblk *dm = &dquot->dq_dqb;
>  	int check_blim = 0, check_ilim = 0;
>  	struct mem_dqinfo *dqi = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
> +	int ret;
>  
>  	if (di->d_fieldmask & ~VFS_QC_MASK)
>  		return -EINVAL;
> @@ -2807,7 +2812,9 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>  	else
>  		set_bit(DQ_FAKE_B, &dquot->dq_flags);
>  	spin_unlock(&dquot->dq_dqb_lock);
> -	mark_dquot_dirty(dquot);
> +	ret = mark_dquot_dirty(dquot);
> +	if (ret < 0)
> +		return ret;
>  
>  	return 0;
>  }
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

