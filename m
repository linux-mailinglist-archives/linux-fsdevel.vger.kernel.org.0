Return-Path: <linux-fsdevel+bounces-63585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B151BC499F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F19404E239A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1B2F746D;
	Wed,  8 Oct 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yoad3HMS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8Te+tmI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/+Bw+7b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dig4r2Z2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD62F7443
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923866; cv=none; b=encCmp5ht4if8RH8HqfwDMCePKfj2g0HzZ0/URuB6tM/HPH0fwBVZmDMdPGjaoA0eeF9n+5X84i3JnZ2vZnblwRm5lPFNEZlyAf3VuoeRvAhBtaYksV287H4i3UaniyDQI31828lFITcDQXkkQ4cx1xncIgtuOnkd8C3ivj/xMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923866; c=relaxed/simple;
	bh=8v7pMj1cNgF/WLXKnpw6wCM56kD68LRugprQ0yOdh/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G749vKBZTpfkbUK3HFvsMGIVXQalhZdP12hnEHnS4IZ27vTvXuM7BTsGNT/zF0OQCjj+6HcfOO4C0BBrRN2YjeIxLWvRq/wxRscULPDL0O5EXyNIE4v92LvfgDuek8f+e/iXVDojc2yRSUoTo9bniqkY8MqI+lsP932K/lIJStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yoad3HMS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8Te+tmI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/+Bw+7b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dig4r2Z2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4B901F395;
	Wed,  8 Oct 2025 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759923863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RgXe54SgiMk7hloWzwKQ+bG1PauvSHuiGRwPmpFZnY=;
	b=Yoad3HMSSF/s4gg8nHnJ4AOmrlu7NWB0h0YEzuDX7iV1rwlpHkfF55/c6THDxKOOJF9tyY
	C22rEoCjypYHTJwD1L1ql4sjUnz4FqPaHLgblgiw+UDLnGP4CZL6mi7Ep9yduaDQZZF9J0
	FDyE8QsUeeuhHdMy4kKW8xeO+ubgDOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759923863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RgXe54SgiMk7hloWzwKQ+bG1PauvSHuiGRwPmpFZnY=;
	b=v8Te+tmIAH/k0HXoPG0gZpcEIaUdxyo+dYUCv4VJJ0KI+NUPQCoKQL2X4WqM8LZmVFA8ze
	zCNNIpv+b+6XisBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="T/+Bw+7b";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dig4r2Z2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759923862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RgXe54SgiMk7hloWzwKQ+bG1PauvSHuiGRwPmpFZnY=;
	b=T/+Bw+7bQr/qO/bJsWX3jFMb4a7GFlnaWdWnpwhNHxjgwIETkZM4vsQ2Pw+EuJLxY+IMve
	8JXqqAvP1+O7eFzhmfmqtY3sVEoE1vMprERr7sUFRv+2DWZuxqlF7QgS0nMk50AXzKauwG
	XQGgcMN1GiGg46Xo/eW0j087DIb0LPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759923862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RgXe54SgiMk7hloWzwKQ+bG1PauvSHuiGRwPmpFZnY=;
	b=dig4r2Z2KuL+CgzHqAFXlDb2zOcF3I90RToJvjjldDhzdHRANAYI+j3aa55T3ThYEXsrU4
	AxcjRmhcOgoaUgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4E1613A3D;
	Wed,  8 Oct 2025 11:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5yAdLJZO5miTLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:44:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 590CBA0ACD; Wed,  8 Oct 2025 13:44:22 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:44:22 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: introduce seq counter for the extent
 status entry
Message-ID: <ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-4-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C4B901F395
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 25-09-25 17:25:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In the iomap_write_iter(), the iomap buffered write frame does not hold
> any locks between querying the inode extent mapping info and performing
> page cache writes. As a result, the extent mapping can be changed due to
> concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
> write-back process faces a similar problem: concurrent changes can
> invalidate the extent mapping before the I/O is submitted.
> 
> Therefore, both of these processes must recheck the mapping info after
> acquiring the folio lock. To address this, similar to XFS, we propose
> introducing an extent sequence number to serve as a validity cookie for
> the extent. After commit 24b7a2331fcd ("ext4: clairfy the rules for
> modifying extents"), we can ensure the extent information should always
> be processed through the extent status tree, and the extent status tree
> is always uptodate under i_rwsem or invalidate_lock or folio lock, so
> it's safe to introduce this sequence number. The sequence number will be
> increased whenever the extent status tree changes, preparing for the
> buffered write iomap conversion.
> 
> Besides, this mechanism is also applicable for the moving extents case.
> In move_extent_per_page(), it also needs to reacquire data_sem and check
> the mapping info again under the folio lock.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

One idea for future optimization as I'm reading the series:

> @@ -955,6 +961,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  		}
>  		pending = err3;
>  	}
> +	ext4_es_inc_seq(inode);
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  	/*

ext4_es_insert_extent() doesn't always need to increment the sequence
counter. It is used in two situations:

1) When we found the extent in the on-disk extent tree and want to cache it
in memory. No increment needed is in this case.

2) When we allocated new blocks or changed their status. Increment needed
in this case.

Case 1) can be actually pretty frequent on large files and we would be
unnecessarily invalidating mapping information for operations happening in
other parts of the file although no allocation information changes are
actually happening.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

