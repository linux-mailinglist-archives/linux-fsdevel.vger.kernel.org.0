Return-Path: <linux-fsdevel+bounces-25333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5A94AF0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 19:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C1B1C2181C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD213D533;
	Wed,  7 Aug 2024 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S66iPBG7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CD1c8Uor";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6frZRCC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BM72KGD6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B05473E;
	Wed,  7 Aug 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052631; cv=none; b=SrH22XD9IQ6jVMd7hxxVSbjLlhovvKPOBVzASMPQz5q1uamCmg779pN9GwcmJzQnVfTrfm+SMqAvUcbar2r0lJnGffmWn5Gfui+Y/wU7VubGUysyXNl0fTT/M/QCZO8Uj3TOzSRm15tbUvvK97WHX9bt498Px8lKstViDDvPRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052631; c=relaxed/simple;
	bh=b2Ld5JXoX3oZXS7hW/qdf1IUKj2/e483MbH7MAS78p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS1Ci2R0bI5kIVesDazoJMpr92sYj7E5w98s0ff5G1BjR3h9wQ9cm6oagHNIkCy/UGsCQOEtLplQVAGg+wafEEXz5x7g3yhEf6kknUIfn7FDrYMzBdohMGRTxrUd8LUy4wHBLWiY8NcnwOPKRxVXqxoLY3G8ixHqV1M6a2btAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S66iPBG7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CD1c8Uor; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6frZRCC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BM72KGD6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBE3F1FB95;
	Wed,  7 Aug 2024 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723052627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQkeBanqg60GtpUfZlBS62zpYbgL/ISaKUGWSGg0h8M=;
	b=S66iPBG76regzsytaPH0hslThluhJvpedFpTAAa25PD0/LD9pacOz43g11G+pwaviKZ5qx
	HPl968H7g5FhsV+03wsG9jL/8Ulov4B4tMsLZJG4OkUqbfvQgOPxkQK+Zxceg3Xg1InAMu
	jFOMMS/dTeJ/ABzfJYwg8zeMdl6NlDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723052627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQkeBanqg60GtpUfZlBS62zpYbgL/ISaKUGWSGg0h8M=;
	b=CD1c8Uor16oz/EEnyIuq6OTxEaDr3QyxzJXiGHJ8/UGRzhvY0hhDX7EhmJ85yr3iNQlHqV
	EQchp5taOcfPt4BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723052626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQkeBanqg60GtpUfZlBS62zpYbgL/ISaKUGWSGg0h8M=;
	b=Y6frZRCCgvvgUqqGA7mBRST7f+vMIVk7MNrBZU3WT9CFNEXlovwVsVApH5id865erHj8l7
	j43rujq6r9/Qb3biPGYtmotK+yJquc/TwuHyQ8LOhrhHr5xT6TfxSnfl0TnjBoca046iae
	F3UmWBucH4ifh0wWl1/rU9OKs7xx05g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723052626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQkeBanqg60GtpUfZlBS62zpYbgL/ISaKUGWSGg0h8M=;
	b=BM72KGD6+TLfBHaJZ3IGn7TLaCilmVDJRz8/w2CIR0D5wOpBl5eBfAJnwyjTyuSRYDIyqI
	pKFmzg5f7wonVqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0BD313A7D;
	Wed,  7 Aug 2024 17:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uKnbNlKys2YaJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 17:43:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8BD1DA0762; Wed,  7 Aug 2024 19:43:46 +0200 (CEST)
Date: Wed, 7 Aug 2024 19:43:46 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 08/10] ext4: use ext4_map_query_blocks() in
 ext4_map_blocks()
Message-ID: <20240807174346.2wxfqu3hjrvihwai@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802115120.362902-9-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [0.70 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: 0.70

On Fri 02-08-24 19:51:18, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The blocks map querying logic in ext4_map_blocks() are the same as
> ext4_map_query_blocks(), so switch to directly use it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e9ce1e4e6acb..8bd65a45a26a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -658,27 +658,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	 * file system block.
>  	 */
>  	down_read(&EXT4_I(inode)->i_data_sem);
> -	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		retval = ext4_ext_map_blocks(handle, inode, map, 0);
> -	} else {
> -		retval = ext4_ind_map_blocks(handle, inode, map, 0);
> -	}
> -	if (retval > 0) {
> -		unsigned int status;
> -
> -		if (unlikely(retval != map->m_len)) {
> -			ext4_warning(inode->i_sb,
> -				     "ES len assertion failed for inode "
> -				     "%lu: retval %d != map->m_len %d",
> -				     inode->i_ino, retval, map->m_len);
> -			WARN_ON(1);
> -		}
> -
> -		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> -				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -				      map->m_pblk, status);
> -	}
> +	retval = ext4_map_query_blocks(handle, inode, map);
>  	up_read((&EXT4_I(inode)->i_data_sem));
>  
>  found:
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

