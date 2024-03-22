Return-Path: <linux-fsdevel+bounces-15077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0E886C74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408521C21E8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6545033;
	Fri, 22 Mar 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3mf+gxS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="utQrfkQq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3mf+gxS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="utQrfkQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA16446DB;
	Fri, 22 Mar 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112274; cv=none; b=K7JvWcIs8LHB2G4YLgguvzEOjK7MB1THYhpCNSIhjU03NWBs0ra8l2idQjvcCqY5w6p8ZUqfnae79dsX8rTqr3IG0TanB+AKK2o0OQPz1mbhXE/VbHCcMZCp2APnu0g9cY/bKSfKMnmgvJDZ4h6DdlAa6hXaxmVOpgSRv0RgMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112274; c=relaxed/simple;
	bh=E6ITrdHscrMzAQFG874j5NnqJtDsY+7ha30c7KlkGgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6d7fsWcKJBqZjaqRfxbiC7Dj4nkPKjlQxAoxhZWcOTsdei4UvkVUUolipQr98ngdoA9jKijRfFUah+GHSkz1VGjThGzl/N/AV85fVD7lpSY59jDyeZsiPrK4kxmIXn5UXjgYppMisMmKh/amdHELqzBdko2nMV+WXs1KDUCjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3mf+gxS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=utQrfkQq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3mf+gxS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=utQrfkQq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9200D38545;
	Fri, 22 Mar 2024 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711112270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7baqv304LSVZL25N7aS+O/esZ8xDzsXdlc1jVyTGZs=;
	b=T3mf+gxSTmquDIm4E9AL5ds4JHcLP8DfCQc7oLDbrFJ0DzjYnIb62bPz6AoBs7SR6eRfaA
	5m0CtS7Gi3nJ4tNi2zfXkf/jAmHogzemApzqVGL31HCRhVylVa4bsmNdzL9mjpwsTHzQWg
	AhKIXQgpFawEk6BtRh21H9Du71GIxcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711112270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7baqv304LSVZL25N7aS+O/esZ8xDzsXdlc1jVyTGZs=;
	b=utQrfkQqcKNGTQ7WoYWKAu5HjsxgCQ+aw4OIF9hd057EXJvznB5ft6i8oR2OFpo8laEoB5
	65iKF+O+Y7L+kTDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711112270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7baqv304LSVZL25N7aS+O/esZ8xDzsXdlc1jVyTGZs=;
	b=T3mf+gxSTmquDIm4E9AL5ds4JHcLP8DfCQc7oLDbrFJ0DzjYnIb62bPz6AoBs7SR6eRfaA
	5m0CtS7Gi3nJ4tNi2zfXkf/jAmHogzemApzqVGL31HCRhVylVa4bsmNdzL9mjpwsTHzQWg
	AhKIXQgpFawEk6BtRh21H9Du71GIxcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711112270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7baqv304LSVZL25N7aS+O/esZ8xDzsXdlc1jVyTGZs=;
	b=utQrfkQqcKNGTQ7WoYWKAu5HjsxgCQ+aw4OIF9hd057EXJvznB5ft6i8oR2OFpo8laEoB5
	65iKF+O+Y7L+kTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8620D13688;
	Fri, 22 Mar 2024 12:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pWm6IE6A/WV9CQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Mar 2024 12:57:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3590EA0806; Fri, 22 Mar 2024 13:57:50 +0100 (CET)
Date: Fri, 22 Mar 2024 13:57:50 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322125750.jov4f3alsrkmqnq7@quack3>
References: <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240321112737.33xuxfttrahtvbej@quack3>
 <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
 <20240322063718.GC3404528@ZenIV>
 <20240322063955.GM538574@ZenIV>
 <170c544c-164e-368c-474a-74ae4055d55f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170c544c-164e-368c-474a-74ae4055d55f@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.86
X-Spamd-Result: default: False [-0.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.14)[-0.710];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[66.59%]
X-Spam-Flag: NO

On Fri 22-03-24 14:52:16, Yu Kuai wrote:
> 在 2024/03/22 14:39, Al Viro 写道:
> > On Fri, Mar 22, 2024 at 06:37:18AM +0000, Al Viro wrote:
> > > On Thu, Mar 21, 2024 at 08:15:06PM +0800, Yu Kuai wrote:
> > > 
> > > > > blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
> > > > > inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
> > > > > block device instead of your file_bdev(inode->i_private)? I don't see any
> > > > > advantage in stashing away that special bdev_file into inode->i_private but
> > > > > perhaps I'm missing something...
> > > > > 
> > > > 
> > > > Because we're goning to remove the 'block_device' from iomap and
> > > > buffer_head, and replace it with a 'bdev_file'.
> > > 
> > > What of that?  file_inode(file)->f_mapping->host will give you bdevfs inode
> > > just fine...
> > 
> > file->f_mapping->host, obviously - sorry.
> > .
> 
> Yes, we already get bdev_inode this way, and use it in
> blkdev_iomap_begin() and blkdev_get_block(), the problem is that if we
> want to let iomap and buffer_head to use bdev_file for raw block fops as
> well, we need a 'bdev_file' somehow.

Do you mean for operations like bread(), getblk(), or similar, don't you?
Frankly I don't find a huge value in this and seeing how clumsy it is
getting I'm not convinced it is worth it at this point.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

