Return-Path: <linux-fsdevel+bounces-66711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7DBC2A61D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 08:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2243A82FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E52B2C029E;
	Mon,  3 Nov 2025 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fco/1o4Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="36nnXm7N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nz0e0JhF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ruSI0m/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB412BEFF9
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155713; cv=none; b=PQTDe+SmJsvj48uu9heVCxSobr0u5d9QKHR9+DUbSPzFkTFUVjg37IdS4g966N0oxvdIDK5xn+6VPpnVNrh0q6Xi9DxKqQtFa29yBRscZ579vOy2lPllfDHoaaogCcyqBGSn80/2aNhXV+pSeI4q4Ifg1UlYEKedLyRfrAQrGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155713; c=relaxed/simple;
	bh=eP192i3l/QqHyo+S9e/JNIQT+fCbHSmrMaT6+p6HfBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI/3V7mIlb6ugUfaW5Ru0IILKUZ/d61umERTfg9BfL5gia7b5m4iKDnpSRqb0qZwLsH9s+iUdFTmkUJonveXfDfkUb65jPsEbodqc/T9E/Uk6DY8YiXaNXjzt42S5TXCx7OC/Ob1asVM0UdHA3gW5F5dgb+8UoDVrAVr8B8SYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fco/1o4Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=36nnXm7N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nz0e0JhF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ruSI0m/z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D309D1F787;
	Mon,  3 Nov 2025 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762155703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf4jQTpB9VGe8rGSo1CupspYWZxA+nV5Rkk/NcNgaTk=;
	b=Fco/1o4YyB8iS5bcU70L/XwLCQmi7qhWcwRKdn0IP7ikTW2SnYYMejZHOhFOlJkj2aqbYv
	7Og4UdFt3FYyg0RAaJiJd87MyeKJqIMGRah3xgjwru1mrFcbM71/MRFI61T4CNKbQ/sX/a
	tExDc26+tFJuMH/kJjt8STWfE9jf66s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762155703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf4jQTpB9VGe8rGSo1CupspYWZxA+nV5Rkk/NcNgaTk=;
	b=36nnXm7NdXBObt6o7MmXBreIjaTra9Fc9Esd6P/Sn6DNWcwYHVi8j93/BIkgjqD+wt54Zp
	zJn9a7o979ZCSOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762155702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf4jQTpB9VGe8rGSo1CupspYWZxA+nV5Rkk/NcNgaTk=;
	b=nz0e0JhFowNrzf/aSLze8jAtlvEedLy3sCYQJeKOvmoebvnHAa0rrjsHlx4/ew7ybr+Hus
	DaS7mMAkVoD6YCAlLaA0sqopXJS8OVwxLjz1cDgKMnO9Hhgwt88xOvdli9dLflEd33tppW
	k14iL1q7Be1O1sFP4KIK6EZX/kj7JAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762155702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf4jQTpB9VGe8rGSo1CupspYWZxA+nV5Rkk/NcNgaTk=;
	b=ruSI0m/zQZfLi+kTpwut7bmbwxLnOc9AATOzXEy5HyIzV774iyAoJsuyYLIBARDgakIh0N
	CJXb55htoN3cmbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7B4813A88;
	Mon,  3 Nov 2025 07:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F6rPLLZcCGlVQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 07:41:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 24BF0A2A61; Mon,  3 Nov 2025 08:41:42 +0100 (CET)
Date: Mon, 3 Nov 2025 08:41:42 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 01/25] ext4: remove page offset calculation in
 ext4_block_zero_page_range()
Message-ID: <w7dawsu3tli23h6ezt4u7evprczgbezylnbyh3sqhv5rfimg4q@5vqelz5hsev6>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-2-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.24 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.14)[-0.682];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.24

On Sat 25-10-25 11:21:57, libaokun@huaweicloud.com wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> For bs <= ps scenarios, calculating the offset within the block is
> sufficient. For bs > ps, an initial page offset calculation can lead to
> incorrect behavior. Thus this redundant calculation has been removed.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..0742039c53a7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4157,9 +4157,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
>  		struct address_space *mapping, loff_t from, loff_t length)
>  {
>  	struct inode *inode = mapping->host;
> -	unsigned offset = from & (PAGE_SIZE-1);
>  	unsigned blocksize = inode->i_sb->s_blocksize;
> -	unsigned max = blocksize - (offset & (blocksize - 1));
> +	unsigned int max = blocksize - (from & (blocksize - 1));
>  
>  	/*
>  	 * correct length if it does not fall between
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

