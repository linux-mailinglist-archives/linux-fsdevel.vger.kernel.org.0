Return-Path: <linux-fsdevel+bounces-52251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF1AE0B71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 18:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80580189AE97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091A28C004;
	Thu, 19 Jun 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f3Egjlbj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TtVBeF+8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f3Egjlbj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TtVBeF+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FE1AE877
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350802; cv=none; b=oGrzffq1nZhizTwM6dmSnfbKtEpcGS7oearQPEovaMOQ2wTKsiLKPsiR8/vq/haGOAdc1EK8zNU8Nug74eL4mXYOaCRraURR2JJHBLPRxJRWRkc3Na+BhRPRmhZ5XQcJJ3N9x5qBW6SP1EOZhFHFiIri0Cvo5PVvJj3pmCAcyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350802; c=relaxed/simple;
	bh=tL0j3d+WoQaI145+Ggpfa9fyEz+w6ykpo8zcye/PJQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApQQJml6BHYxGIgCaJdRH6tBUYgBz2XH0hR1vAeceJEKnU9HtODP7wRk9Ud4INaaSQEBLzmQrE9uTeCWiWfkV0SOrgvmqHJbrA2T0R/TmOCxCeSmwCMKjj5vcKqjYIgfztRp5sJ3mBojZnGu/iN10bvrF1ix5WELALtJ5QhImlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f3Egjlbj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TtVBeF+8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f3Egjlbj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TtVBeF+8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C91A421233;
	Thu, 19 Jun 2025 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750350797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trTySnNF4YbcEMneXVP3iop9ApEh2WZaTogTTe6r7h4=;
	b=f3Egjlbj7bBAFy+QTNU9T/eSRZ9ZFg/K0s5vo5tGgVjaUZpg3wiqCcQsN+a8UljBUI1y9/
	dX7gsMFU2Cnuz+tWC3neWr/nhm6ewqGN1MzQDSLKmPaMIpBtee9fwq4yDmT8tdjEoiRPqE
	tNAGwj33jw1DR5xwu2azIoe4T7LFG/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750350797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trTySnNF4YbcEMneXVP3iop9ApEh2WZaTogTTe6r7h4=;
	b=TtVBeF+834tC9j7NCb3YRvU6yAjtimykIwl3Cl9KS14zlQFtm+sSFDh6DKPX3A5nOOvCBg
	/KRegQ/eTgcV50Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750350797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trTySnNF4YbcEMneXVP3iop9ApEh2WZaTogTTe6r7h4=;
	b=f3Egjlbj7bBAFy+QTNU9T/eSRZ9ZFg/K0s5vo5tGgVjaUZpg3wiqCcQsN+a8UljBUI1y9/
	dX7gsMFU2Cnuz+tWC3neWr/nhm6ewqGN1MzQDSLKmPaMIpBtee9fwq4yDmT8tdjEoiRPqE
	tNAGwj33jw1DR5xwu2azIoe4T7LFG/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750350797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trTySnNF4YbcEMneXVP3iop9ApEh2WZaTogTTe6r7h4=;
	b=TtVBeF+834tC9j7NCb3YRvU6yAjtimykIwl3Cl9KS14zlQFtm+sSFDh6DKPX3A5nOOvCBg
	/KRegQ/eTgcV50Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BADAF136CC;
	Thu, 19 Jun 2025 16:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHOaLc07VGicRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 16:33:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 746F0A29FA; Thu, 19 Jun 2025 18:33:13 +0200 (CEST)
Date: Thu, 19 Jun 2025 18:33:13 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 3/6] ext4: restart handle if credits are insufficient
 during allocating blocks
Message-ID: <7nw5sxwibqmp6zuuanb6eklkxnm5n536fpgzqus6pxts37q2ix@vlpsd2muuj6w>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611111625.1668035-4-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 11-06-25 19:16:22, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After large folios are supported on ext4, writing back a sufficiently
> large and discontinuous folio may consume a significant number of
> journal credits, placing considerable strain on the journal. For
> example, in a 20GB filesystem with 1K block size and 1MB journal size,
> writing back a 2MB folio could require thousands of credits in the
> worst-case scenario (when each block is discontinuous and distributed
> across different block groups), potentially exceeding the journal size.
> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
> when delalloc is not enabled.
> 
> Fix this by ensuring that there are sufficient journal credits before
> allocating an extent in mpage_map_one_extent() and _ext4_get_block(). If
> there are not enough credits, return -EAGAIN, exit the current mapping
> loop, restart a new handle and a new transaction, and allocating blocks
> on this folio again in the next iteration.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

...

>  static int _ext4_get_block(struct inode *inode, sector_t iblock,
>  			   struct buffer_head *bh, int flags)
>  {
>  	struct ext4_map_blocks map;
> +	handle_t *handle = ext4_journal_current_handle();
>  	int ret = 0;
>  
>  	if (ext4_has_inline_data(inode))
>  		return -ERANGE;
>  
> +	/* Make sure transaction has enough credits for this extent */
> +	if (flags & EXT4_GET_BLOCKS_CREATE) {
> +		ret = ext4_journal_ensure_extent_credits(handle, inode);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	map.m_lblk = iblock;
>  	map.m_len = bh->b_size >> inode->i_blkbits;
>  
> -	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
> -			      flags);
> +	ret = ext4_map_blocks(handle, inode, &map, flags);

Good spotting with ext4_page_mkwrite() and ext4_write_begin() also needing
this treatment! But rather then hiding the transaction extension in
_ext4_get_block() I'd do this in ext4_block_write_begin() where it is much
more obvious (and also it is much more obvious who needs to be prepared for
handling EAGAIN error). Otherwise the patch looks good!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

