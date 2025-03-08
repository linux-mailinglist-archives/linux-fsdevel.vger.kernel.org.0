Return-Path: <linux-fsdevel+bounces-43529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06958A57E3C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 21:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC1116C886
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486751EDA1D;
	Sat,  8 Mar 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcgC7L8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A091F5823
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741466732; cv=none; b=k6rlO4icqz6wGKd1jxwTRxJPbyHfJxJInwu/VPZ1xx53CzyuQxhpNmpmH+ePzSZjPIqyNPAYBL/0pPoPKwmltvWVsWAoWDeLBAM6+BkAISLaQJ3W/SLVylbjr3jzlGmmuXDDI76HTqz99lB9RSva/WkXhXZOZbY/19awQ0JO6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741466732; c=relaxed/simple;
	bh=PPyvufgAWR7rNTCyTZMjT4tPhN/1t/o73atSQ21maOM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wkib0jPGdbmoPSTuMmz2ms7I2NaQyEbfjuw0EOiTKKGRTETpcBrKyqNEh+VgVEEEZhKRCMQOiEZENKTchQP3b7cqNQoXzxhXPyWyYUJEBhVv9FbXmAC/Y7x3dQXs6Dv9GVzVPbPyeShPr+LU5eY6UDBZoLLSGZv4hBlbrJ3Y9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcgC7L8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741466729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tI7vJWycCZb7O/jK+mzUBHYszZSb9B4nRDxa4wUAFKY=;
	b=YcgC7L8e5X5s6AsFamUsL7ST3eJlMv2A91Dfyu4R5e5lXd7O2MIhOMVRj96sf0Crd9Xzmb
	jI8bRv1ZMfuU/r1itnW/hbGOvjWYtiRZyXaiNPI/bdNTzF3Wfkj/3MoT6IrIQV0C3qe55u
	U50LNC02/Lpt257f3G6yDYCV4DoPgI0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-ciook4O9M_GnLhMBfsuEHQ-1; Sat,
 08 Mar 2025 15:45:24 -0500
X-MC-Unique: ciook4O9M_GnLhMBfsuEHQ-1
X-Mimecast-MFC-AGG-ID: ciook4O9M_GnLhMBfsuEHQ_1741466723
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93EC7195608B;
	Sat,  8 Mar 2025 20:45:22 +0000 (UTC)
Received: from [10.45.224.17] (unknown [10.45.224.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDB6C1956094;
	Sat,  8 Mar 2025 20:45:18 +0000 (UTC)
Date: Sat, 8 Mar 2025 21:45:15 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
    Jens Axboe <axboe@kernel.dk>, Jooyung Han <jooyung@google.com>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
    dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
In-Reply-To: <20250308034945.GG2803740@frogsfrogsfrogs>
Message-ID: <747a3ac0-8c5c-64d4-8857-df63112e6b72@redhat.com>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com> <Z8W1q6OYKIgnfauA@infradead.org> <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com> <Z8XlvU0o3C5hAAaM@infradead.org> <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com> <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com> <Z8eURG4AMbhornMf@dread.disaster.area> <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com> <20250308034945.GG2803740@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Fri, 7 Mar 2025, Darrick J. Wong wrote:

> On Fri, Mar 07, 2025 at 04:21:58PM +0100, Mikulas Patocka wrote:
> > > I didn't say you were. I said the concept that dm-loop is based on
> > > is fundamentally flawed and that your benchmark setup does not
> > > reflect real world usage of loop devices.
> > 
> > > Where are the bug reports about the loop device being slow and the
> > > analysis that indicates that it is unfixable?
> > 
> > So, I did benchmarks on an enterprise nvme drive (SAMSUNG 
> > MZPLJ1T6HBJR-00007). I stacked ext4/loop/ext4, xfs/loop/xfs (using losetup 
> > --direct-io=on), ext4/dm-loop/ext4 and xfs/dm-loop/xfs. And loop is slow.
> 
> Are you running the loop device in directio mode?  The default is to use
> buffered io, which wastes pagecache /and/ sometimes trips dirty limits
> throttling.  The loopdev tests in fstests get noticeably faster if I
> force directio mode.

Yes, I am. I set it up with:
losetup --direct-io=on /dev/loop0 /mnt/test/l
mount -t xfs /dev/loop0 /mnt/test2

I double checked it and I got the same results.

Mikulas

> --D
> 
> > synchronous I/O:
> > fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=psync --iodepth=1 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> > raw block device:
> >    READ: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3985MiB (4179MB), run=10001-10001msec
> >   WRITE: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3990MiB (4184MB), run=10001-10001msec
> > ext4/loop/ext4:
> >    READ: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2232MiB (2341MB), run=10002-10002msec
> >   WRITE: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2231MiB (2339MB), run=10002-10002msec
> > xfs/loop/xfs:
> >    READ: bw=220MiB/s (230MB/s), 220MiB/s-220MiB/s (230MB/s-230MB/s), io=2196MiB (2303MB), run=10001-10001msec
> >   WRITE: bw=219MiB/s (230MB/s), 219MiB/s-219MiB/s (230MB/s-230MB/s), io=2193MiB (2300MB), run=10001-10001msec
> > ext4/dm-loop/ext4:
> >    READ: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3383MiB (3547MB), run=10002-10002msec
> >   WRITE: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3385MiB (3549MB), run=10002-10002msec
> > xfs/dm-loop/xfs:
> >    READ: bw=375MiB/s (393MB/s), 375MiB/s-375MiB/s (393MB/s-393MB/s), io=3752MiB (3934MB), run=10002-10002msec
> >   WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=3756MiB (3938MB), run=10002-10002msec
> > 
> > asynchronous I/O:
> > fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=libaio --iodepth=16 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> > raw block device:
> >    READ: bw=1246MiB/s (1306MB/s), 1246MiB/s-1246MiB/s (1306MB/s-1306MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
> >   WRITE: bw=1247MiB/s (1308MB/s), 1247MiB/s-1247MiB/s (1308MB/s-1308MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
> > ext4/loop/ext4:
> >    READ: bw=274MiB/s (288MB/s), 274MiB/s-274MiB/s (288MB/s-288MB/s), io=2743MiB (2877MB), run=10001-10001msec
> >   WRITE: bw=275MiB/s (288MB/s), 275MiB/s-275MiB/s (288MB/s-288MB/s), io=2747MiB (2880MB), run=10001-10001msec
> > xfs/loop/xfs:
> >    READ: bw=276MiB/s (289MB/s), 276MiB/s-276MiB/s (289MB/s-289MB/s), io=2761MiB (2896MB), run=10002-10002msec
> >   WRITE: bw=276MiB/s (290MB/s), 276MiB/s-276MiB/s (290MB/s-290MB/s), io=2765MiB (2899MB), run=10002-10002msec
> > ext4/dm-loop/ext4:
> >    READ: bw=1189MiB/s (1247MB/s), 1189MiB/s-1189MiB/s (1247MB/s-1247MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
> >   WRITE: bw=1190MiB/s (1248MB/s), 1190MiB/s-1190MiB/s (1248MB/s-1248MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
> > xfs/dm-loop/xfs:
> >    READ: bw=1209MiB/s (1268MB/s), 1209MiB/s-1209MiB/s (1268MB/s-1268MB/s), io=11.8GiB (12.7GB), run=10001-10001msec
> >   WRITE: bw=1210MiB/s (1269MB/s), 1210MiB/s-1210MiB/s (1269MB/s-1269MB/s), io=11.8GiB (12.7GB), run=10001-10001msec
> > 
> > Mikulas


