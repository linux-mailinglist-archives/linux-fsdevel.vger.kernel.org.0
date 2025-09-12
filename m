Return-Path: <linux-fsdevel+bounces-61088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5EB550C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A33B3EF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9912E8E0F;
	Fri, 12 Sep 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GjJ3VD8X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDFY1iJT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wjd8veLT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4///liCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B161A7264
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686674; cv=none; b=ocCOf13k10l7EHmTmEMlSLbf9Ed3twOq5dI5iW+HSKQHFHlK2StthOZAH4WMYY7CZDqMBxLRDYY7OElbxmKWpBE2Tq7NepRRKkELvOIoCXpIbXJSrHtdXCMPJMmthrzYS9xLgdkm0BZcusoQPtHUbxayT7hLtXVzPhBG29oGhzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686674; c=relaxed/simple;
	bh=1sbME5r+owD0+lHofe9cBTAzsoCemcqI+ZWkf66XS4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B19y12ZGWIa4is4xUM8AmqDc7RsU6u6hmOPjAUKllNdn6NA5iMZJzCinX8TtRbD96MrpMCGeklzdBeJs0xy4HQ6lIHn3h6FBN3S5F/tyUt6JyeHT/wXXDpS5sWHVEfpja84t2Ehmq2om8XwPmDL6EEVaE8+nLiJ2uELNAaKTw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GjJ3VD8X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDFY1iJT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wjd8veLT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4///liCg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C874921D94;
	Fri, 12 Sep 2025 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757686669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Toexo+JdLuZiAnUnNRPvC8MK0X27fEgMXq+wfpekpLw=;
	b=GjJ3VD8XOAqM4ijkIfW+C9VeLDf3rVInM3ufJQ9sOBUJqZU0zaMGvX9gdpCcIhSv+JTpI2
	5C6Kxox4ZAl6D0hXaTRsZjN/1OCPjBO++A/FrnVruAJKYIashrnNZ8DnRLUjFY0MB4En47
	xBvW+j6PWnpiicuVSj1bwUnU1ytuaUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757686669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Toexo+JdLuZiAnUnNRPvC8MK0X27fEgMXq+wfpekpLw=;
	b=qDFY1iJTHgtggWrNPHjm63d/FeqivVXFQcur/oYfNqYorgSbeIjeJVnlQqLJAFCRdRHFym
	nyZ8f+I7/gTwmfCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wjd8veLT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4///liCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757686668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Toexo+JdLuZiAnUnNRPvC8MK0X27fEgMXq+wfpekpLw=;
	b=wjd8veLTm4MdHVki8bOXtrKLamvcVDIKfZileRz8/liEBIdM3Vx81Lk+8uH6N2tsqXL+do
	wG15WZDj2NPyEVfEg7EgY3QKxlF2lfmEW0o7ZFUAYOH7cYQ41tE5ouVy0clx9ZovtJZbqC
	ILpdxbyfFFSSW6ZoPs8T+P/vzRp7w7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757686668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Toexo+JdLuZiAnUnNRPvC8MK0X27fEgMXq+wfpekpLw=;
	b=4///liCgswBmy73tvlwhhhhrVv5Zmy4L15zHbcdCq36yJ+7ecjxZGZHHMHQ3DhKDH0AU93
	tJgmiBGOsIlcBfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9990136DB;
	Fri, 12 Sep 2025 14:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 79dJLYwrxGiWIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 14:17:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18CC9A098E; Fri, 12 Sep 2025 16:17:40 +0200 (CEST)
Date: Fri, 12 Sep 2025 16:17:40 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: fix an off-by-one issue during moving extents
Message-ID: <sl2tbcoqrlktv23wkiwt7bkqv3aspnvsgijrbjx23b4gr53h6o@oskiuintay3k>
References: <20250912105841.1886799-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912105841.1886799-1-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C874921D94
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 12-09-25 18:58:41, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> During the movement of a written extent, mext_page_mkuptodate() is
> called to read data in the range [from, to) into the page cache and to
> update the corresponding buffers. Therefore, we should not wait on any
> buffer whose start offset is >= 'to'. Otherwise, it will return -EIO and
> fail the extents movement.
> 
>  $ for i in `seq 3 -1 0`; \
>    do xfs_io -fs -c "pwrite -b 1024 $((i * 1024)) 1024" /mnt/foo; \
>    done
>  $ umount /mnt && mount /dev/pmem1s /mnt  # drop cache
>  $ e4defrag /mnt/foo
>    e4defrag 1.47.0 (5-Feb-2023)
>    ext4 defragmentation for /mnt/foo
>    [1/1]/mnt/foo:    0%    [ NG ]
>    Success:                       [0/1]
> 
> Fixes: a40759fb16ae ("ext4: remove array of buffer_heads from mext_page_mkuptodate()")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index adae3caf175a..4b091c21908f 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -225,7 +225,7 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
>  	do {
>  		if (bh_offset(bh) + blocksize <= from)
>  			continue;
> -		if (bh_offset(bh) > to)
> +		if (bh_offset(bh) >= to)
>  			break;
>  		wait_on_buffer(bh);
>  		if (buffer_uptodate(bh))
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

