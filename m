Return-Path: <linux-fsdevel+bounces-16941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE648A54B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E47B243A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095BB745C9;
	Mon, 15 Apr 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzgsGIgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D02A8D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191774; cv=none; b=fDkpQf8Kelijnrrjzeh8zxQAx3kBMmV50T3ZhMK61jj38X44CgN483aF3BHTAi+8KT1nkrBgLzsi67dpqzWe4ieijmXlcEovTVMkGiPNGPT3TaCihyzB2jEsDJE4YHssa658wzjIT9r9ZPiA4JMwpjtuwEu4aICPRzfYP6AA4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191774; c=relaxed/simple;
	bh=YMv48aXULq+P+Zfe6u92CCqGqs7nverst/BByaD+MJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRnlmYC5K8EIQ46lVfKCOmuBlpaG42r0NHW8mTG9y7RlXoQNRF9MUqtUHV74jDXnu1xoQ6a8aV1crrhbL1oJzTM4k7gnoTHtu9eXiO8OWBW0nwRZYRmyXLjCfcz0zkDARHcrtv7qc9KRu5SzQSevM9XEeSgM1RG+bAkDXs5GZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzgsGIgO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713191770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Fpco6JyEqxSHVCGXvAnj47X9HVqOOy7QTJFx9DYGrE=;
	b=PzgsGIgODAYbgmfYTSW2HJi3oW63GuinZlNBA01TVUW6EzYiQ6+6aYWmw2vokpsy4q5esn
	Etx/Mga8ZYBbuSl6T/aqGQZPx1K4wDRwEesXgoAVE07Xqm3qhos25gI3E5pv19H6zw/PIU
	3bEe95Y3EjMW6j8A/7xH5kMqVwY8P0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-O5C2w4qgPzGIwjnOkYKvtQ-1; Mon,
 15 Apr 2024 10:36:07 -0400
X-MC-Unique: O5C2w4qgPzGIwjnOkYKvtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3F4A380350C;
	Mon, 15 Apr 2024 14:36:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FC5F51EF;
	Mon, 15 Apr 2024 14:36:01 +0000 (UTC)
Date: Mon, 15 Apr 2024 22:35:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <Zh07Sc3lYStOWK8J@fedora>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
 <Zhzyu6pQYkSNgvuh@fedora>
 <20240415-haufen-demolieren-8c6da8159586@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-haufen-demolieren-8c6da8159586@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Mon, Apr 15, 2024 at 02:35:17PM +0200, Christian Brauner wrote:
> On Mon, Apr 15, 2024 at 05:26:19PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > On Tue, Jan 23, 2024 at 02:26:21PM +0100, Christian Brauner wrote:
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  drivers/md/dm.c               | 23 +++++++++++++----------
> > >  drivers/md/md.c               | 12 ++++++------
> > >  drivers/md/md.h               |  2 +-
> > >  include/linux/device-mapper.h |  2 +-
> > >  4 files changed, 21 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index 8dcabf84d866..87de5b5682ad 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > 
> > ...
> > 
> > > @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
> > >  {
> > >  	if (md->disk->slave_dir)
> > >  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> > > -	bdev_release(td->dm_dev.bdev_handle);
> > > +	fput(td->dm_dev.bdev_file);
> > 
> > The above change caused regression on 'dmsetup remove_all'.
> > 
> > blkdev_release() is delayed because of fput(), so dm_lock_for_deletion
> > returns -EBUSY, then this dm disk is skipped in remove_all().
> > 
> > Force to mark DMF_DEFERRED_REMOVE might solve it, but need our device
> > mapper guys to check if it is safe.
> > 
> > Or other better solution?
> 
> Yeah, I think there is. You can just switch all fput() instances in
> device mapper to bdev_fput() which is mainline now. This will yield the
> device and make it able to be reclaimed. Should be as simple as the
> patch below. Could you test this and send a patch based on this (I'm on
> a prolonged vacation so I don't have time right now.):

Unfortunately it doesn't work.

Here the problem is that blkdev_release() is delayed, which changes
'dmsetup remove_all' behavior, and causes that some of dm disks aren't
removed.

Please see dm_lock_for_deletion() and dm_blk_open()/dm_blk_close().

Thanks,
Ming


