Return-Path: <linux-fsdevel+bounces-67086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5DC34F94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D2284E86C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2C2D7DFE;
	Wed,  5 Nov 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJ5F9DRo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQMwDzZ7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJ5F9DRo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQMwDzZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449D3081A0
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336230; cv=none; b=limsGX7JEwmJKMbMnpvXuFUjzIp69L3DPBgQ5XG8ufXikPqvQOP1SCD1k8u/eRZj6ldes0V6TkEQDHVHVws5CHKRg1U9iLsu8TPCD42RKvgKuxT/SKfLhaFJ38ZuRoDP7XQrZVD1HFrHKJJ8La5EQ2705dFq86paiPXpN69iwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336230; c=relaxed/simple;
	bh=SaHx5AqH25u5jS1zdJna9eVUvittlFvbU/WKy3a1lQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQz252hdJzTGQptPW6eIbw5/+obC0J1WCG0o8k42y5xrhf8yoLGTHk49CbjnitoH+N84zutSgv/kVo5EKTFFfDm9I2UbZdhfhHO6oog2i0uF0HilMafAmJh7YhlKcIvLEzLH83J9LIRsjMHeZKKQXTwVWBf8AgE9gyG4urei+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJ5F9DRo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQMwDzZ7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJ5F9DRo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQMwDzZ7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9438F21190;
	Wed,  5 Nov 2025 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762336226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY5ii2iDdhZ8VdCxHaGIdjUSBVcQnRly9m7bibgj8xY=;
	b=sJ5F9DRouVc6UaiCoRTKMPUvE0xokRFGY3dcZTAt0qjt3Wh5IprrWhyNm7HicsXAy/UYBb
	LvEIyHEPITaNtLJMzxryjzcH+3zJnuttYdx1p6GqMtoYsmiQvzkokXlRPXKzTwVBqogq9R
	FhvZelBXeB+6gdHd78Yq0N6yZDwjUfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762336226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY5ii2iDdhZ8VdCxHaGIdjUSBVcQnRly9m7bibgj8xY=;
	b=iQMwDzZ7CiXw/caoRiyc8sBxyuvzbbxUp90wjCTqSNANDiUPnE7I+X3wFP0+zm0ZAqvVIq
	S++hRsEQPjJ1pRAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sJ5F9DRo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iQMwDzZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762336226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY5ii2iDdhZ8VdCxHaGIdjUSBVcQnRly9m7bibgj8xY=;
	b=sJ5F9DRouVc6UaiCoRTKMPUvE0xokRFGY3dcZTAt0qjt3Wh5IprrWhyNm7HicsXAy/UYBb
	LvEIyHEPITaNtLJMzxryjzcH+3zJnuttYdx1p6GqMtoYsmiQvzkokXlRPXKzTwVBqogq9R
	FhvZelBXeB+6gdHd78Yq0N6yZDwjUfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762336226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY5ii2iDdhZ8VdCxHaGIdjUSBVcQnRly9m7bibgj8xY=;
	b=iQMwDzZ7CiXw/caoRiyc8sBxyuvzbbxUp90wjCTqSNANDiUPnE7I+X3wFP0+zm0ZAqvVIq
	S++hRsEQPjJ1pRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84C0813699;
	Wed,  5 Nov 2025 09:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPFjIOIdC2lZMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:50:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 381C2A083B; Wed,  5 Nov 2025 10:50:26 +0100 (CET)
Date: Wed, 5 Nov 2025 10:50:26 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 21/25] ext4: make online defragmentation support large
 block size
Message-ID: <vkbarfyd6ozrrljhvwhmy2cq23mby6mxl2kxlsxp2wqgmvxvgi@6sgmqhhdnmru>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-22-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-22-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 9438F21190
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /

On Sat 25-10-25 11:22:17, libaokun@huaweicloud.com wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> There are several places assuming that block size <= PAGE_SIZE, modify
> them to support large block size (bs > ps).
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

...

> @@ -565,7 +564,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  	struct inode *orig_inode = file_inode(o_filp);
>  	struct inode *donor_inode = file_inode(d_filp);
>  	struct ext4_ext_path *path = NULL;
> -	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
> +	int blocks_per_page = 1;
>  	ext4_lblk_t o_end, o_start = orig_blk;
>  	ext4_lblk_t d_start = donor_blk;
>  	int ret;
> @@ -608,6 +607,9 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (i_blocksize(orig_inode) < PAGE_SIZE)
> +		blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
> +

I think these are strange and the only reason for this is that
ext4_move_extents() tries to make life easier to move_extent_per_page() and
that doesn't really work with larger folios anymore. I think
ext4_move_extents() just shouldn't care about pages / folios at all and
pass 'cur_len' as the length to the end of extent / moved range and
move_extent_per_page() will trim the length based on the folios it has got.

Also then we can rename some of the variables and functions from 'page' to
'folio'.

								Honza

>  	/* Protect orig and donor inodes against a truncate */
>  	lock_two_nondirectories(orig_inode, donor_inode);
>  
> @@ -665,10 +667,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		if (o_end - o_start < cur_len)
>  			cur_len = o_end - o_start;
>  
> -		orig_page_index = o_start >> (PAGE_SHIFT -
> -					       orig_inode->i_blkbits);
> -		donor_page_index = d_start >> (PAGE_SHIFT -
> -					       donor_inode->i_blkbits);
> +		orig_page_index = EXT4_LBLK_TO_P(orig_inode, o_start);
> +		donor_page_index = EXT4_LBLK_TO_P(donor_inode, d_start);
>  		offset_in_page = o_start % blocks_per_page;
>  		if (cur_len > blocks_per_page - offset_in_page)
>  			cur_len = blocks_per_page - offset_in_page;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

