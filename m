Return-Path: <linux-fsdevel+bounces-6677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C081B584
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB98D1C23336
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC36E59A;
	Thu, 21 Dec 2023 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUDhVOiE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hzTwR5PX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUDhVOiE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hzTwR5PX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C16A02A;
	Thu, 21 Dec 2023 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B09D91FDAA;
	Thu, 21 Dec 2023 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703160670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+TyKykGlPVi1TiMaCKYzUe9Yh1Gu/kCcG/smM9DkYo=;
	b=pUDhVOiEd5zLszVe8ECaSa3ymfOk9bQCI97dUgxxgcf6D8Wmj4PoHuqXUwiEiq00br12S0
	D2Gf1Zo7C2/e7r1g7zglKHX1oyaVlmy/DLtPbKqTr0+zHreqGgJVRpjcHH+SSuS9HhUiRM
	mXQbxcRYE3LnxwLRKG6ztmQDVgS1G18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703160670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+TyKykGlPVi1TiMaCKYzUe9Yh1Gu/kCcG/smM9DkYo=;
	b=hzTwR5PXHZWTh5Wt3yjvB6dz8ugCKv2WGNijPFdBwhy0VBlFaBJLLSRWohuBcX1g8OLlqL
	q/PPCzwG1hqhQ2BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703160670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+TyKykGlPVi1TiMaCKYzUe9Yh1Gu/kCcG/smM9DkYo=;
	b=pUDhVOiEd5zLszVe8ECaSa3ymfOk9bQCI97dUgxxgcf6D8Wmj4PoHuqXUwiEiq00br12S0
	D2Gf1Zo7C2/e7r1g7zglKHX1oyaVlmy/DLtPbKqTr0+zHreqGgJVRpjcHH+SSuS9HhUiRM
	mXQbxcRYE3LnxwLRKG6ztmQDVgS1G18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703160670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+TyKykGlPVi1TiMaCKYzUe9Yh1Gu/kCcG/smM9DkYo=;
	b=hzTwR5PXHZWTh5Wt3yjvB6dz8ugCKv2WGNijPFdBwhy0VBlFaBJLLSRWohuBcX1g8OLlqL
	q/PPCzwG1hqhQ2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AB7B13AB5;
	Thu, 21 Dec 2023 12:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NWrBJV4rhGW9aQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 12:11:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36197A07E3; Thu, 21 Dec 2023 13:11:02 +0100 (CET)
Date: Thu, 21 Dec 2023 13:11:02 +0100
From: Jan Kara <jack@suse.cz>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	yangerkun <yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
	"zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: [PATCH 3/7] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20231221121102.2pfp3cyzmsf2xmls@quack3>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-3-jack@suse.cz>
 <64fdffaa-9a8f-df34-42e7-ccca81e95c3c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64fdffaa-9a8f-df34-42e7-ccca81e95c3c@huaweicloud.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed 20-12-23 11:26:38, Li Lingfeng wrote:
> > @@ -773,6 +803,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> >   	if (ret)
> >   		goto free_handle;
> > +	/* Blocking writes requires exclusive opener */
> > +	if (mode & BLK_OPEN_RESTRICT_WRITES && !holder)
> > +		return ERR_PTR(-EINVAL);
> > +
> >   	bdev = blkdev_get_no_open(dev);
> >   	if (!bdev) {
> >   		ret = -ENXIO;
> > @@ -800,12 +834,21 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> >   		goto abort_claiming;
> >   	if (!try_module_get(disk->fops->owner))
> >   		goto abort_claiming;
> > +	ret = -EBUSY;
> > +	if (!blkdev_open_compatible(bdev, mode))
> > +		goto abort_claiming;
> >   	if (bdev_is_partition(bdev))
> >   		ret = blkdev_get_part(bdev, mode);
> >   	else
> >   		ret = blkdev_get_whole(bdev, mode);
> >   	if (ret)
> >   		goto put_module;
> > +	if (!bdev_allow_write_mounted) {
> > +		if (mode & BLK_OPEN_RESTRICT_WRITES)
> > +			bdev_block_writes(bdev);
> 
> When a partition device is mounted, I think maybe it's better to block
> writes on the whole device at same time.
> 
> Allowing the whole device to be opened for writing when mounting a partition
> device, did you have any special considerations before?

Yes, we were considering this. But the truth is that:

a) It is *very* hard to stop all the possibilities of corrupting data on
the device - e.g. with device mapper / loop device / malicious partition
table you can construct many block devices pointing to the same storage,
you can use e.g. SG_IO to corrupt on disk data etc. So special-casing
partitions is providing little additional benefit.

b) It is difficult to then correctly handle valid cases of multiple
writeably mounted partitions on the same device - you'd need to track used
block numbers for each device which gets difficult in presence of device
mapper etc.

c) To stop filesystem crashes, it is enough to stop modifications of buffer
cache of that one block device. Because filesystems have to validate data
they are loading into buffer cache anyway to handle faulty device, fs
corruption etc.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

