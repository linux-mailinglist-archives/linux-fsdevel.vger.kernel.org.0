Return-Path: <linux-fsdevel+bounces-66718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFCAC2A835
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2AED3464ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0952D7DD5;
	Mon,  3 Nov 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VQ+j7uxN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILcOvWE3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VQ+j7uxN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILcOvWE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E22C325F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157658; cv=none; b=Rx53b/gUF7UAmilcWZnlKkPD6cGCPH0BJ7XyxbB6Tx0l98nACg9X93ZfGdZukgOK80aklTnZV8cZFLPxikgVSDV1yqLmhHUx0/jabdlLUczYC6QZ7+pNEToChUWNL9Q85qL/p53C6Vn6lJB9mI/21tTPuUWgF52SJqhxTJInqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157658; c=relaxed/simple;
	bh=29KT2mtaw95gN6F/w0CUed3vKJQ6Zva+kqfNZoblUao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYsdtCHvBsHEHnJs66DlLbUME+FFGucYiYg12f2CEGoR0v1ho2PUUkvHJwjlhntpU2oDdv8FlsS3SSig7R6SFUsYFEaXOUN5WaBYbkWNIWSV0aNmqyIjQhdjpZT5DsBLH3dtn9rSK8/JULI8D9XXwwZOtgOV28h/n4hAgR5x4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VQ+j7uxN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILcOvWE3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VQ+j7uxN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILcOvWE3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A075B21EC9;
	Mon,  3 Nov 2025 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCdxGDoqhxMX2on1WCoiMvZKcJKb7d7apOzd7GJhudg=;
	b=VQ+j7uxNDcVsNPTHd3unaB+kEhcNnjs6bCHaF5ZxN9bXsiexkAeteKfEmlgA4MgQTwbgxa
	X3oBxfZVFo4NfcWRmG/LUEHk7zkbH7OX4zoNdm+vgbzjXP+Ppdj91X4+Ufa32ldnR2kdWD
	J7GCM/W+E1rZlUfHDFKC4y/9qmBGZYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCdxGDoqhxMX2on1WCoiMvZKcJKb7d7apOzd7GJhudg=;
	b=ILcOvWE3ko+Lu34V3dlOGO/OykohZmnSXALd+aOofNHRb+gfNSERLcnFd/Fk5p3Clu1xsN
	By3x0es9kLP96JBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VQ+j7uxN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ILcOvWE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCdxGDoqhxMX2on1WCoiMvZKcJKb7d7apOzd7GJhudg=;
	b=VQ+j7uxNDcVsNPTHd3unaB+kEhcNnjs6bCHaF5ZxN9bXsiexkAeteKfEmlgA4MgQTwbgxa
	X3oBxfZVFo4NfcWRmG/LUEHk7zkbH7OX4zoNdm+vgbzjXP+Ppdj91X4+Ufa32ldnR2kdWD
	J7GCM/W+E1rZlUfHDFKC4y/9qmBGZYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lCdxGDoqhxMX2on1WCoiMvZKcJKb7d7apOzd7GJhudg=;
	b=ILcOvWE3ko+Lu34V3dlOGO/OykohZmnSXALd+aOofNHRb+gfNSERLcnFd/Fk5p3Clu1xsN
	By3x0es9kLP96JBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E7321364F;
	Mon,  3 Nov 2025 08:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qa3DIlZkCGlZYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:14:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0DE2A2A64; Mon,  3 Nov 2025 09:14:09 +0100 (CET)
Date: Mon, 3 Nov 2025 09:14:09 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 07/25] ext4: support large block size in
 ext4_calculate_overhead()
Message-ID: <qmsx753xemvacoaghwhv6emusazmlynv54qqxwsdfsoaoeqre4@bp2lgrdufaim>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-8-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-8-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A075B21EC9
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Sat 25-10-25 11:22:03, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> ext4_calculate_overhead() used a single page for its bitmap buffer, which
> worked fine when PAGE_SIZE >= block size. However, with block size greater
> than page size (BS > PS) support, the bitmap can exceed a single page.
> 
> To address this, we now use __get_free_pages() to allocate multiple pages,
> sized to the block size, to properly support BS > PS.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

One comment below:

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d353e25a5b92..7338c708ea1d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4182,7 +4182,8 @@ int ext4_calculate_overhead(struct super_block *sb)
>  	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>  	ext4_fsblk_t overhead = 0;
> -	char *buf = (char *) get_zeroed_page(GFP_NOFS);
> +	gfp_t gfp = GFP_NOFS | __GFP_ZERO;
> +	char *buf = (char *)__get_free_pages(gfp, sbi->s_min_folio_order);

I think this should be using kvmalloc(). There's no reason to require
physically contiguous pages for this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

