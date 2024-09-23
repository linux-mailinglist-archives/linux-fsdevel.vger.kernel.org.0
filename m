Return-Path: <linux-fsdevel+bounces-29834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3097E7ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D2F1F21E9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09EE19415D;
	Mon, 23 Sep 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lk7oGuWS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mh49yuCJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lk7oGuWS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mh49yuCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF449649;
	Mon, 23 Sep 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081646; cv=none; b=kXB35HisMUmkbpNhEGqQrSqnTS4oll7Pte/h94MSFU/Bm68aGKfd2s2CaUO/O21ENWe8qEVt/MA8ir0UFbRLZp1WHPrRHDmmeC6jgN7XwYZ21ZAlZ0klFbPUwBy6ZwqBMbFynASXHoDWjqFXTE5aQXv4BNZ3puNDzP24UXT64OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081646; c=relaxed/simple;
	bh=O7powSMYV53/q5xvNeAigkdmWUjsqYWO0CqysN5jlAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6m9jG8pswH/6lccuhqqkoJIgvoC/SW9IdP/L/88NAV8VwWA60OcPKbw+01IJY3y0XUFL2ix369vVPVpoSon9eLz2d6MBMyIUjdcpKyqqvIWOf6KkpohxvI6LO/ex8zLIiQmIouqu7HA8yvh702KEndks+8G5xELE4tIjWUGxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lk7oGuWS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mh49yuCJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lk7oGuWS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mh49yuCJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADA971F7A5;
	Mon, 23 Sep 2024 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727081642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=In9SJZ6ZHi06A9k5Lxyf47PBCyy9O7DDkMytyeOolwg=;
	b=Lk7oGuWSPr629D/kdVE8FNC0heaRHAYy+/wCjcrL4lgvAFl5dzhXq07aEwjgXEV+OwWW7Q
	M5KGQDAhyKIcJPVFh3zOzR5RJmR9YkzUzffc/FABfsVdsCC9Y8C/uvvuyTukWiWaEVB3uw
	m618x6ktaKgqOtbCwyY1ylehIaQv9Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727081642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=In9SJZ6ZHi06A9k5Lxyf47PBCyy9O7DDkMytyeOolwg=;
	b=Mh49yuCJKZ+7ri1WkowjZsyZK6BVIANAVCZ6uPCA5XeshdHvCUPB0eCuF8VQSsDgPphdXQ
	6enX+Tbu5VqPEICg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727081642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=In9SJZ6ZHi06A9k5Lxyf47PBCyy9O7DDkMytyeOolwg=;
	b=Lk7oGuWSPr629D/kdVE8FNC0heaRHAYy+/wCjcrL4lgvAFl5dzhXq07aEwjgXEV+OwWW7Q
	M5KGQDAhyKIcJPVFh3zOzR5RJmR9YkzUzffc/FABfsVdsCC9Y8C/uvvuyTukWiWaEVB3uw
	m618x6ktaKgqOtbCwyY1ylehIaQv9Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727081642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=In9SJZ6ZHi06A9k5Lxyf47PBCyy9O7DDkMytyeOolwg=;
	b=Mh49yuCJKZ+7ri1WkowjZsyZK6BVIANAVCZ6uPCA5XeshdHvCUPB0eCuF8VQSsDgPphdXQ
	6enX+Tbu5VqPEICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9519A13A64;
	Mon, 23 Sep 2024 08:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WWZiJKos8WaydgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 08:54:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 577EFA0ABF; Mon, 23 Sep 2024 10:54:02 +0200 (CEST)
Date: Mon, 23 Sep 2024 10:54:02 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 10/10] ext4: factor out a common helper to lock and
 flush data before fallocate
Message-ID: <20240923085402.amto7pryy67eadpj@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-11-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 14:29:25, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now the beginning of the first four functions in ext4_fallocate() (punch
> hole, zero range, insert range and collapse range) are almost the same,
> they need to wait for the dio to finish, get filemap invalidate lock,
> write back dirty data and finally drop page cache. Factor out a common
> helper to do these work can reduce a lot of the redundant code.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I like that we factor out this functionality in a common helper. But see
below:

> @@ -4731,6 +4707,52 @@ static int ext4_fallocate_check(struct inode *inode, int mode,
>  	return 0;
>  }
>  
> +int ext4_prepare_falloc(struct file *file, loff_t start, loff_t end, int mode)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct address_space *mapping = inode->i_mapping;
> +	int ret;
> +
> +	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> +	inode_dio_wait(inode);
> +	ret = file_modified(file);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Prevent page faults from reinstantiating pages we have released
> +	 * from page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
> +
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto failed;
> +
> +	/*
> +	 * Write data that will be zeroed to preserve them when successfully
> +	 * discarding page cache below but fail to convert extents.
> +	 */
> +	ret = filemap_write_and_wait_range(mapping, start, end);

The comment is somewhat outdated now. Also the range is wrong for collapse
and insert range. There we need to writeout data upto the EOF because we
truncate it below.

								Honza

> +	if (ret)
> +		goto failed;
> +
> +	/*
> +	 * For insert range and collapse range, COWed private pages should
> +	 * be removed since the file's logical offset will be changed, but
> +	 * punch hole and zero range doesn't.
> +	 */
> +	if (mode & (FALLOC_FL_INSERT_RANGE | FALLOC_FL_COLLAPSE_RANGE))
> +		truncate_pagecache(inode, start);
> +	else
> +		truncate_pagecache_range(inode, start, end);
> +
> +	return 0;
> +failed:
> +	filemap_invalidate_unlock(mapping);
> +	return ret;
> +}

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

