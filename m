Return-Path: <linux-fsdevel+bounces-43596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385DCA592A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798B97A42A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2091221569;
	Mon, 10 Mar 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffEYzZHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B81221547
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605648; cv=none; b=E5U6boHM34JwulvevN6yRT33V/55iCSsjC6tyUqA/uOAw5Pn06cFVEKyBAsKVbqQBGzSD7dQT9ohzgaIMWzgeeFjfddfS2K6ydbakfIBGSwOrJcrQFcPGyRDzvyx4ZhI5JyKArwmOrJeqfmfvA7femEWv4Kf/3BFRl4m2UtFy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605648; c=relaxed/simple;
	bh=fGr3BNhMVOr7TeVMqln/q9SDeGXkyalVL4FjxkOB3jM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vDtVRb4N7t3TfyLwjWZqPgZhlCeo6FaXle9O7CZ0H6/BruewzhkTgvcNM5nXF2S7erNg1veMvT4ZBXzolrXOjM6I1tNo3kYJ5vlt4Csq07uxdIgQHSRdOrwXmRMzmPOsbBvN62/DcgtfEEIKYlNUGEkqvqFGw/mmYbIiLgb005Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffEYzZHd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741605645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIGJRRONDUfWtW53ChawtWMmz7c8o56oFPc2hHVQKfM=;
	b=ffEYzZHdQMzagAY/QKar1ToD8/LmrxxXC7J38ukfg92e/4L03cDhV3AxROru2gxiRn1H77
	lyw/DfjIzmOfsAF6Dz0+aW16c0GZCKHezxVb+eZ/Rz2OsBFfAV1cJIG4+U9nmpATpbN/F9
	+R1EGknEsT45xOXqsomuNMY7kyc3TzI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-bcOjqFFfOgCy9g5ksPa7zg-1; Mon,
 10 Mar 2025 07:20:41 -0400
X-MC-Unique: bcOjqFFfOgCy9g5ksPa7zg-1
X-Mimecast-MFC-AGG-ID: bcOjqFFfOgCy9g5ksPa7zg_1741605640
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7448F19560AB;
	Mon, 10 Mar 2025 11:20:39 +0000 (UTC)
Received: from [10.45.224.17] (unknown [10.45.224.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ACCB1956094;
	Mon, 10 Mar 2025 11:20:35 +0000 (UTC)
Date: Mon, 10 Mar 2025 12:20:32 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
    Jens Axboe <axboe@kernel.dk>, Jooyung Han <jooyung@google.com>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
    dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
In-Reply-To: <Z8zd85X2gosbrsc8@fedora>
Message-ID: <f7c9d956-2b9b-8bb4-aa49-d57323fc8eb0@redhat.com>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com> <Z8W1q6OYKIgnfauA@infradead.org> <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com> <Z8XlvU0o3C5hAAaM@infradead.org> <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com> <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com> <Z8eURG4AMbhornMf@dread.disaster.area> <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com> <Z8zd85X2gosbrsc8@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Sun, 9 Mar 2025, Ming Lei wrote:

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
> > 
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
> 
> BTW, raw device is supposed to be xfs or ext4 over raw block device, right?

No - raw device means fio directly on /dev/nvme0n1

> Otherwise, please provide test data for this case, then it becomes one fair
> comparison because there should be lock contention for FS write IOs on same file.
> 
> Thanks,
> Ming


Mikulas


