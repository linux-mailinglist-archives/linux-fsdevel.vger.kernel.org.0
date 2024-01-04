Return-Path: <linux-fsdevel+bounces-7354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7D18240A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BC9B21928
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2C2137B;
	Thu,  4 Jan 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsQKzVwT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QnmhJ6W9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsQKzVwT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QnmhJ6W9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABD2134A;
	Thu,  4 Jan 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EE851F805;
	Thu,  4 Jan 2024 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704367735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=id+paq71QAy1mcff5/EB3PkmVyeX2lIOxwmUvRxr4fA=;
	b=wsQKzVwTEzNXMrID3WBUT2cACh+KzJec60Ql22fl5N5QaM5/2vK+qfg2IueeonhI3lc8Nw
	H4SFayUpxnCxSkdcbmYEGhQVwnDAKL/rHBCVpvzBMWMnq8D8tcrV6BiP5OkgTLI5R6djXs
	huBK7ewNueIlSgrTFcVmz95tuQULxHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704367735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=id+paq71QAy1mcff5/EB3PkmVyeX2lIOxwmUvRxr4fA=;
	b=QnmhJ6W9z9hciG62uLQwn7l6XDnoT7FgUsOy4cuGf7GKqEjXmnN5qYZJx69CAE4e0wLDCV
	6voNpMi3rZDHXuCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704367735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=id+paq71QAy1mcff5/EB3PkmVyeX2lIOxwmUvRxr4fA=;
	b=wsQKzVwTEzNXMrID3WBUT2cACh+KzJec60Ql22fl5N5QaM5/2vK+qfg2IueeonhI3lc8Nw
	H4SFayUpxnCxSkdcbmYEGhQVwnDAKL/rHBCVpvzBMWMnq8D8tcrV6BiP5OkgTLI5R6djXs
	huBK7ewNueIlSgrTFcVmz95tuQULxHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704367735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=id+paq71QAy1mcff5/EB3PkmVyeX2lIOxwmUvRxr4fA=;
	b=QnmhJ6W9z9hciG62uLQwn7l6XDnoT7FgUsOy4cuGf7GKqEjXmnN5qYZJx69CAE4e0wLDCV
	6voNpMi3rZDHXuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89DFF13722;
	Thu,  4 Jan 2024 11:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BsajIXeWlmXXBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 11:28:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 273FFA07EF; Thu,  4 Jan 2024 12:28:55 +0100 (CET)
Date: Thu, 4 Jan 2024 12:28:55 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.com, konishi.ryusuke@gmail.com,
	willy@infradead.org, akpm@linux-foundation.org, hare@suse.de,
	p.raghav@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 04/17] mtd: block2mtd: use bdev apis
Message-ID: <20240104112855.uci45hhqaiitmsir@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085712.1766333-5-yukuai1@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.61
X-Spamd-Bar: +
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.08)[63.79%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLhr85cyeg3mfw7iggddtjdkgs)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[48];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wsQKzVwT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QnmhJ6W9
X-Spam-Level: *
X-Rspamd-Queue-Id: 9EE851F805

On Thu 21-12-23 16:56:59, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> On the one hand covert to use folio while reading bdev inode, on the
> other hand prevent to access bd_inode directly.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
...
> +		for (p = folio_address(folio); p < max; p++)
>  			if (*p != -1UL) {
> -				lock_page(page);
> -				memset(page_address(page), 0xff, PAGE_SIZE);
> -				set_page_dirty(page);
> -				unlock_page(page);
> -				balance_dirty_pages_ratelimited(mapping);
> +				folio_lock(folio);
> +				memset(folio_address(folio), 0xff,
> +				       folio_size(folio));
> +				folio_mark_dirty(folio);
> +				folio_unlock(folio);
> +				bdev_balance_dirty_pages_ratelimited(bdev);

Rather then creating this bdev_balance_dirty_pages_ratelimited() just for
MTD perhaps we can have here (and in other functions):

				...
				mapping = folio_mapping(folio);
				folio_unlock(folio);
				if (mapping)
					balance_dirty_pages_ratelimited(mapping);

What do you think? Because when we are working with the folios it is rather
natural to use their mapping for dirty balancing?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

