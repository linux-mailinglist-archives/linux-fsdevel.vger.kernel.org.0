Return-Path: <linux-fsdevel+bounces-4764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81CB8032E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 13:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97741C209E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986624203
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fiv8d/Zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF4F3
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 04:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701692355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKpnHl1rqARfzhPXeJ+4bbVOHPefal8/mof2N40xC9Q=;
	b=Fiv8d/Zj/xLoJkxrXT8+A2MHGp5eGuHR18zmsm2/LeXsktjuPbfzuhdbCDH4Cx405RXjhZ
	s/zFNnxnDFlQjSQ00M3yrsFZ4cVlPw6+RdWH8/9i76WwZv9qBGsOdyv1oEhP/6lsWbXvTq
	gmk1QBlCfZqxjfRXQtEOKQenW2H7vXM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-x75rTCgfPLCaKgb9CbtjsQ-1; Mon,
 04 Dec 2023 07:19:09 -0500
X-MC-Unique: x75rTCgfPLCaKgb9CbtjsQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74D7E299E740;
	Mon,  4 Dec 2023 12:19:08 +0000 (UTC)
Received: from fedora (unknown [10.72.120.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E27C25028;
	Mon,  4 Dec 2023 12:18:57 +0000 (UTC)
Date: Mon, 4 Dec 2023 20:18:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZW3DracIEH7uTyEA@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <ZW05th/c0sNbM2Zf@fedora>
 <03a87103-0721-412c-92f5-9fd605dc0c74@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a87103-0721-412c-92f5-9fd605dc0c74@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Mon, Dec 04, 2023 at 09:27:00AM +0000, John Garry wrote:
> On 04/12/2023 02:30, Ming Lei wrote:
> 
> Hi Ming,
> 
> > > +static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
> > > +			      struct iov_iter *iter)
> > > +{
> > > +	unsigned int atomic_write_unit_min_bytes =
> > > +			queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
> > > +	unsigned int atomic_write_unit_max_bytes =
> > > +			queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
> > > +
> > > +	if (!atomic_write_unit_min_bytes)
> > > +		return false;
> > The above check should have be moved to limit setting code path.
> 
> Sorry, I didn't fully understand your point.
> 
> I added this here (as opposed to the caller), as I was not really worried
> about speeding up the failure path. Are you saying to call even earlier in
> submission path?

atomic_write_unit_min is one hardware property, and it should be checked
in blk_queue_atomic_write_unit_min_sectors() from beginning, then you
can avoid this check every other where.

> 
> > 
> > > +	if (pos % atomic_write_unit_min_bytes)
> > > +		return false;
> > > +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> > > +		return false;
> > > +	if (!is_power_of_2(iov_iter_count(iter)))
> > > +		return false;
> > > +	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
> > > +		return false;
> > > +	if (pos % iov_iter_count(iter))
> > > +		return false;
> > I am a bit confused about relation between atomic_write_unit_max_bytes and
> > atomic_write_max_bytes.
> 
> I think that naming could be improved. Or even just drop merging (and
> atomic_write_max_bytes concept) until we show it to improve performance.
> 
> So generally atomic_write_unit_max_bytes will be same as
> atomic_write_max_bytes, however it could be different if:
> a. request queue nr hw segments or other request queue limits needs to
> restrict atomic_write_unit_max_bytes
> b. atomic_write_unit_max_bytes does not need to be a power-of-2 and
> atomic_write_max_bytes does. So essentially:
> atomic_write_unit_max_bytes = rounddown_pow_of_2(atomic_write_max_bytes)
> 

plug merge often improves sequential IO perf, so if the hardware supports
this way, I think 'atomic_write_max_bytes' should be supported from the
beginning, such as:

- user space submits sequential N * (4k, 8k, 16k, ...) atomic writes, all can
be merged to single IO request, which is issued to driver.

Or 

- user space submits sequential 4k, 4k, 8k, 16K, 32k, 64k atomic writes, all can
be merged to single IO request, which is issued to driver.

The hardware should recognize unit size by start LBA, and check if length is
valid, so probably the interface might be relaxed to:

1) start lba is unit aligned, and this unit is in the supported unit
range(power_2 in [unit_min, unit_max])

2) length needs to be:

- N * this_unit_size
- <= atomic_write_max_bytes


> > 
> > Here the max IO length is limited to be <= atomic_write_unit_max_bytes,
> > so looks userspace can only submit IO with write-atomic-unit naturally
> > aligned IO(such as, 4k, 8k, 16k, 32k, ...),
> 
> correct
> 
> > but these user IOs are
> > allowed to be merged to big one if naturally alignment is respected and
> > the merged IO size is <= atomic_write_max_bytes.
> 
> correct, but the resultant merged IO does not have have to be naturally
> aligned.
> 
> > 
> > Is my understanding right?
> 
> Yes, but...
> 
> > If yes, I'd suggest to document the point,
> > and the last two checks could be change to:
> > 
> > 	/* naturally aligned */
> > 	if (pos % iov_iter_count(iter))
> > 		return false;
> > 
> > 	if (iov_iter_count(iter) > atomic_write_max_bytes)
> > 		return false;
> 
> .. we would not be merging at this point as this is just IO submission to
> the block layer, so atomic_write_max_bytes does not come into play yet. If
> you check patch 7/21, you will see that we limit IO size to
> atomic_write_max_bytes, which is relevant merging.

I know the motivation of atomic_write_max_bytes, and now I am wondering
atomic_write_max_bytes may be exported to userspace for the sake of
atomic write performance.


Thanks,
Ming


