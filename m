Return-Path: <linux-fsdevel+bounces-67079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A54C34DE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C04FB923
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C62FC037;
	Wed,  5 Nov 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L9tYzCnF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V8/edqQ4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a2GTD0gV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXaS4806"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088C2E7F22
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334808; cv=none; b=SLG84x1jykm7xi6rSvV7u1IeoBEM9iwHTasdbN83SB3OyOReNwvGEdRsijf/MNXsm8DLjec1rvy+Y9tREklO/CiBpuNGpuXd0iJDqX2d7wlS3/aoNysH4kH/8uZHNjgRmXkIpxhU/OzevBLJamYJRbHiUNTeVcWEIBC8CT4XuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334808; c=relaxed/simple;
	bh=TUvSzCiOknzhmbyoqiJLSl9R1ozU3ncGTDjum/genRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifonsxxEggpQPxbXp4nwNwyHZOZZ6GlB0XwckyJs9u9EMw7LbI1QLxTmPSMzzabFa1fF89h6lm7tF8coUuivpDWdpek91AGYHSaEclBxHq7W1LYJ5N1CvE+2f4H2vbmspAJpY8869P3O2HV7lUXIpR8vTi9M4oJad37I38l4C7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L9tYzCnF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V8/edqQ4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a2GTD0gV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXaS4806; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1435021188;
	Wed,  5 Nov 2025 09:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li6o80IDGYsi/HbFc5gcJrYIZ6xt1ndrYA5Yrhm9wNM=;
	b=L9tYzCnFnPxMFuFnOfQRCTNTtEyMVQOdkUn+7rLE2UtBCcgYApNO7kUwOkaSzFkAs9fbWX
	964rhJRj5yIOXynF6JT64L3PtB+cspGGo4RcpfBq3sWR6ecTtuY4girAmeXOLX6TtOq4Vh
	CEcAGYDAaKZM+TIG1DOW6P6FDz006Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li6o80IDGYsi/HbFc5gcJrYIZ6xt1ndrYA5Yrhm9wNM=;
	b=V8/edqQ4VYHBV3+J/0iSOO02dNdLpMV2fSfXdDwrCTDjabtF1W5I7gxFonx995PwgeLR25
	sTstR3kE12ZLp3CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a2GTD0gV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qXaS4806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li6o80IDGYsi/HbFc5gcJrYIZ6xt1ndrYA5Yrhm9wNM=;
	b=a2GTD0gV0mhZgLZteeOUH4zQxnnXtQbZDxi7zdllqLOtx5VQGvPPU9nUvVsiONPPSqFPTr
	ZFQhfmuur98C5FER/YijuSEk/hNFtqpSeUoA1cttZQ/iB9Txtrirhl+WgBnJXZItaEDv8T
	sLJJEhLrTLWvh0rOXg1Lh1z9lgaHrjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li6o80IDGYsi/HbFc5gcJrYIZ6xt1ndrYA5Yrhm9wNM=;
	b=qXaS4806tt+tAI2XoSRPECl8tFg0HBvPluO4XJm0TKioJkPUJ7nSG9G2QydtTvidgBS1Em
	oMV8YsNRY3Pb6OCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08375132DD;
	Wed,  5 Nov 2025 09:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AksAAlMYC2nRGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:26:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE55FA083B; Wed,  5 Nov 2025 10:26:42 +0100 (CET)
Date: Wed, 5 Nov 2025 10:26:42 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 16/25] ext4: support large block size in
 ext4_mpage_readpages()
Message-ID: <svvbzbdnlvd5bvcbale6xe2qtdaf4ddr3rlrphqv3spcy6dxpt@cynxzantfcmu>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-17-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-17-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,huaweicloud.com:email,suse.com:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 1435021188
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Sat 25-10-25 11:22:12, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Use the EXT4_P_TO_LBLK() macro to convert folio indexes to blocks to avoid
> negative left shifts after supporting blocksize greater than PAGE_SIZE.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/readpage.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index f329daf6e5c7..8c8ec9d60b90 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -213,9 +213,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  {
>  	struct bio *bio = NULL;
>  	sector_t last_block_in_bio = 0;
> -
>  	const unsigned blkbits = inode->i_blkbits;
> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
>  	sector_t next_block;
>  	sector_t block_in_file;
> @@ -251,9 +249,8 @@ int ext4_mpage_readpages(struct inode *inode,
>  
>  		blocks_per_folio = folio_size(folio) >> blkbits;
>  		first_hole = blocks_per_folio;
> -		block_in_file = next_block =
> -			(sector_t)folio->index << (PAGE_SHIFT - blkbits);
> -		last_block = block_in_file + nr_pages * blocks_per_page;
> +		block_in_file = next_block = EXT4_P_TO_LBLK(inode, folio->index);
> +		last_block = EXT4_P_TO_LBLK(inode, folio->index + nr_pages);
>  		last_block_in_file = (ext4_readpage_limit(inode) +
>  				      blocksize - 1) >> blkbits;
>  		if (last_block > last_block_in_file)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

