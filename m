Return-Path: <linux-fsdevel+bounces-15090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7646B886F3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DA42861AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A851037;
	Fri, 22 Mar 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gYnXLvjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A64CE04;
	Fri, 22 Mar 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119466; cv=none; b=HuJf3DdBCIk4+a0l6+cbXvsVH0M2UkOjgDiiuH2iXgrIRP0ou/az6hURSk86S0rAd5tlWESNNSOXDAD0T6COyJ1L4H1FhQH2oAvW1eInMLl8Qu3tMc+spIpoYFcoFrxN7bzLQRFZYJZBRcvEdbMOa8664+IUfCp2tzNOB6P6A+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119466; c=relaxed/simple;
	bh=cnjz/pdPrArb3OD0ALvV5aoLfVc+0EoXGRKf2726D+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYtRaCfQ7bdQ+HnRxfya1na6u2XYcjj9rXANzh6QsZ5ZFXMqJjGMuJpyFT7rsZ3OXiTDGNZY4XrApnqatnDDyexeYN+Xu+L99T1us8pfx0BuDzvRMlU5pEtIUQqXJlPY+4+Bl34O9MxKWw6YNGn6ZWnT6MGEtpwlNB9JY+56FVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gYnXLvjU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4G+UacrO2zoPfV1aUMFyQbLZLPEMouTLqH7eFTxvzN8=; b=gYnXLvjUYdgYp2FeX4Jgb8pY+P
	AnVOKfuz4FXAN3pjqPykAWHM4aPGh9aOrhIdvX0rg+bOywpbYDd2XNfOIgjfCDAxrmg3GLaOLbhUn
	5ApulJUDICCY1YPhRirGi3iVJktrKzkphQ7PE2qWJfNousRWpAkEySXnjEKpzdZXghBXXTrM4kUaT
	p32Q8ZkvhC6uDqMz1xIJhxWnQuV+wvqAmZtbxBG4Pt5KN5tbDt6dvcEPlVW1Q0b4xoeKCx1bY3JTM
	FeJE1oqQO9ovQeDoAGyyLdDYELTnO1YaoPytGVQ01pK7ZJqVGNYsH880pWhQbjG3lL6uEkM0BfTft
	QWiimd3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rngKm-00EaAI-32;
	Fri, 22 Mar 2024 14:57:29 +0000
Date: Fri, 22 Mar 2024 14:57:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322145728.GN538574@ZenIV>
References: <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240322063346.GB3404528@ZenIV>
 <20240322131030.pxbvtubien2t27zw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322131030.pxbvtubien2t27zw@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 22, 2024 at 02:10:30PM +0100, Jan Kara wrote:
> > End result:
> > 
> > * old ->i_private leaked (already grabbed by your get_bdev_file())
> > * ->bd_openers at 1 (after your bdev_open() gets through)
> > * ->i_private left NULL.
> > 
> > Christoph, could we please get rid of that atomic_t nonsense?
> > It only confuses people into brainos like that.  It really
> > needs ->open_mutex for any kind of atomicity.
> 
> Well, there are a couple of places where we end up reading bd_openers
> without ->open_mutex. Sure these places are racy wrt other opens / closes
> so they need to be careful but we want to make sure we read back at least
> some sane value which is not guaranteed with normal int and compiler
> possily playing weird tricks when updating it. But yes, we could convert
> the atomic_t to using READ_ONCE + WRITE_ONCE in appropriate places to avoid
> these issues and make it more obvious bd_openers are not really handled in
> an atomic way.

What WRITE_ONE()?  We really shouldn't modify it without ->open_mutex; do
we ever do that?  In current mainline:

in blkdev_get_whole(), both callers under ->open_mutex:
block/bdev.c:671:       if (!atomic_read(&bdev->bd_openers))
block/bdev.c:675:       atomic_inc(&bdev->bd_openers);

in blkdev_put_whole(), the sole caller under ->open_mutex:
block_mutex/bdev.c:681:       if (atomic_dec_and_test(&bdev->bd_openers))

in blkdev_get_part(), both callers under ->open_mutex:
block/bdev.c:700:       if (!atomic_read(&part->bd_openers)) {
block/bdev.c:704:       atomic_inc(&part->bd_openers);

in blkdev_put_whole(), the sole caller under ->open_mutex:
block/bdev.c:741:       if (atomic_dec_and_test(&part->bd_openers)) {

in bdev_release(), a deliberately racy reader, commented as such:
block/bdev.c:1032:      if (atomic_read(&bdev->bd_openers) == 1)

in sync_bdevs(), under ->open_mutex:
block/bdev.c:1163:              if (!atomic_read(&bdev->bd_openers)) {

in bdev_del_partition(), under ->open_mutex:
block/partitions/core.c:460:    if (atomic_read(&part->bd_openers))

and finally, in disk_openers(), a racy reader:
include/linux/blkdev.h:231:     return atomic_read(&disk->part0->bd_openers);

So that's two READ_ONCE() and a bunch of reads and writes under ->open_mutex.
Callers of disk_openers() need to be careful and looking through those...
Some of them are under ->open_mutex (either explicitly, or as e.g. lo_release()
called only via bdev ->release(), which comes only under ->open_mutex), but
four of them are not:

arch/um/drivers/ubd_kern.c:1023:                if (disk_openers(ubd_dev->disk))
in ubd_remove().  Racy, possibly a bug.  AFAICS, it's accessible through UML
console and there's nothing to stop it from racing with open().

drivers/block/loop.c:1245:      if (disk_openers(lo->lo_disk) > 1) {
in loop_clr_fd().  Under loop's private lock, but that's likely to
be a race - ->bd_openers updates are not under that.  Note that
there's no ->open() for /dev/loop, BTW...

drivers/block/loop.c:2161:      if (lo->lo_state != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
in loop_control_remove().  Similar to the previous one, except that
it's done out of band *and* it doesn't have the "autoclean" logics
to work around udev, lovingly described in the comment before the
call in loop_clr_fd().

drivers/block/nbd.c:1279:       if (disk_openers(nbd->disk) > 1)
in nbd_bdev_reset().  Under nbd private mutex (->config_lock),
so there's some exclusion with nbd_open(), but ->bd_openers change
comes outside of that.  Might or might not be a bug - I need to wake
up properly to look through that.

