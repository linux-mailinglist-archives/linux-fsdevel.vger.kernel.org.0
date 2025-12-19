Return-Path: <linux-fsdevel+bounces-71755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE64CD082D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AB4C303FD23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BBA33EAFF;
	Fri, 19 Dec 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ACjEfJo+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/0ki7K9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ACjEfJo+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/0ki7K9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE933EAF2
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157951; cv=none; b=rFy4+orVEVeQH2H1+ElsXsYjteu4IrjEC+Q0SMHBhYXajBBrhvIaEmM3KbeIcj9H0WcW6GeVzdY3yKjIpRRfbBeQOt65ZP9AKKA5tX0yfcrxQwPYALVBqMbekLYChYn/5PrWFcbSDCG7IJ8BYFF/I+HsC4HpLDGhRdpa9L90OMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157951; c=relaxed/simple;
	bh=7qQy84sNqAMqVPoPFPVfN5tMvnycTE+myhbMj5pIUyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNm34Ko6Pl0dKO0G9oh8YDakHSpIKO1aQJGSyoAOfg2hN3/fo2QO96nHKEppWQUw6ZJBb1MqRRLeNi+ebUuKssoSlnc6CNFRl0QA5czxQHsfWv5/waG7Fk+KcA/hFNdBFOcpHpBOQLup1GDKxpsjnOUXt2/52LXjHX8MsW29tYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ACjEfJo+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/0ki7K9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ACjEfJo+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/0ki7K9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 237D8336DD;
	Fri, 19 Dec 2025 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766157948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFotEe3IJz8l3bjdbuYx6DmYu8KAWJ36NP/CcbO8i2k=;
	b=ACjEfJo+PxxZphrzKGUfoXzzdp0zsO7ZO+4HqUN9uWOEdYxGgI3hBHV7Rdi96Kn3gxDRzP
	HxlnmxzXbB7JuRQEZGLL0SBiB+wphRAWQEDsND30uVp+GFWrMtTQkVAbq5I1MHGGsBS3r7
	fWvGzMjeACpMqb7e7Fhnf+e0idFM7tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766157948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFotEe3IJz8l3bjdbuYx6DmYu8KAWJ36NP/CcbO8i2k=;
	b=Z/0ki7K963Vuk0iVDECfIO1+P8pMuVOhIBxSWRvVH5AxSzBvMJWUcD6dsnRfsqSCg0n/KN
	Tni1PmntytQTFVDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766157948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFotEe3IJz8l3bjdbuYx6DmYu8KAWJ36NP/CcbO8i2k=;
	b=ACjEfJo+PxxZphrzKGUfoXzzdp0zsO7ZO+4HqUN9uWOEdYxGgI3hBHV7Rdi96Kn3gxDRzP
	HxlnmxzXbB7JuRQEZGLL0SBiB+wphRAWQEDsND30uVp+GFWrMtTQkVAbq5I1MHGGsBS3r7
	fWvGzMjeACpMqb7e7Fhnf+e0idFM7tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766157948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFotEe3IJz8l3bjdbuYx6DmYu8KAWJ36NP/CcbO8i2k=;
	b=Z/0ki7K963Vuk0iVDECfIO1+P8pMuVOhIBxSWRvVH5AxSzBvMJWUcD6dsnRfsqSCg0n/KN
	Tni1PmntytQTFVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A9A73EA63;
	Fri, 19 Dec 2025 15:25:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id slV7BnxuRWl+RQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 15:25:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD449A090B; Fri, 19 Dec 2025 16:25:47 +0100 (CET)
Date: Fri, 19 Dec 2025 16:25:47 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next 3/7] ext4: avoid starting handle when dio writing
 an unwritten extent
Message-ID: <6kfhyiin2m3iook5c4s6dwq45yeqshv4vbez3dfvwaehltajuc@4ybsharot344>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213022008.1766912-4-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Sat 13-12-25 10:20:04, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we have deferred the split of the unwritten extent until after I/O
> completion, it is not necessary to initiate the journal handle when
> submitting the I/O.
> 
> This can improve the write performance of concurrent DIO for multiple
> files. The fio tests below show a ~25% performance improvement when
> wirting to unwritten files on my VM with a mem disk.
> 
>   [unwritten]
>   direct=1
>   ioengine=psync
>   numjobs=16
>   rw=write     # write/randwrite
>   bs=4K
>   iodepth=1
>   directory=/mnt
>   size=5G
>   runtime=30s
>   overwrite=0
>   norandommap=1
>   fallocate=native
>   ramp_time=5s
>   group_reporting=1
> 
>  [w/o]
>   w:  IOPS=62.5k, BW=244MiB/s
>   rw: IOPS=56.7k, BW=221MiB/s
> 
>  [w]
>   w:  IOPS=79.6k, BW=311MiB/s
>   rw: IOPS=70.2k, BW=274MiB/s
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/file.c  | 4 +---
>  fs/ext4/inode.c | 4 +++-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..9f571acc7782 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -418,9 +418,7 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>   *
>   * - shared locking will only be true mostly with overwrites, including
> - *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
> - *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
> - *   also release exclusive i_rwsem lock.
> + *   initialized blocks and unwritten blocks.
>   *
>   * - Otherwise we will switch to exclusive i_rwsem lock.
>   */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ffde24ff7347..08a296122fe0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3819,7 +3819,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			 * For atomic writes the entire requested length should
>  			 * be mapped.
>  			 */
> -			if (map.m_flags & EXT4_MAP_MAPPED) {
> +			if ((map.m_flags & EXT4_MAP_MAPPED) ||
> +			    (!(flags & IOMAP_DAX) &&

Why is here an exception for DAX writes? DAX is fine writing to unwritten
extents AFAIK. It only needs to pre-zero newly allocated blocks... Or am I
missing some corner case?

								Honza

> +			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
>  				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
>  				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
>  					goto out;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

