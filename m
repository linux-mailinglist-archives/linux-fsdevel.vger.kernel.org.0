Return-Path: <linux-fsdevel+bounces-43447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24758A56BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A903AB2FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8020E21D002;
	Fri,  7 Mar 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9Kqy4hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8B21CC49
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360938; cv=none; b=Jyd9ML32KqeKbktV3xWYqjB3b/3/8uBXNUE5u2nvSnjRnqtXM8xy20MI+J0PUBUr1w26rl2PS55t7clTyMaZz8gnukdDGRakNrJ8Duqnp6+EhOYYPxE+J0eo11Rw33gsatmeW+3/OLxtQj0bWM+wFjOmtRgjVvF1sOHxqoRZM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360938; c=relaxed/simple;
	bh=8bkm9D+A9b09Me9TsLQSLQoaTKIDYLGe1bUICWPE0eY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t/9zUM9iEPXH26VNcFA9+1C7xSid/JgH8dkI4aGG6WjcskFGBrKGgC1x8CrhCPsStDyLFfAtybPS932HwQtDa0QZWQmPpx/sCm+YkVEKQFQTtIh+Rbhv0L+DH+4WdqZ3hpF6qBvylnbvsOkirqVB/XN3GUOStxh3s3q/bYfCGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9Kqy4hd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeDSEd/YjPeusnr10Mm42vys340e0N+uOy6aIocYd3Q=;
	b=N9Kqy4hd3y8dwuzx2KKoe9mG7EIH0JzbakJbBIdtwnOR1qNQLBON2HWCt05OfBXqYGDQFn
	oQrn8OhLZPqzczNJecVCn5t5l/vmW+FP2vbvV7RitpLq3niVARi98amuSguqTnxA2obPDJ
	ZW9C2bcYAl3tLOYLuYaNloqWMR7QlNk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-DViTGFTgMkuZHqgu0UVOTQ-1; Fri,
 07 Mar 2025 10:22:10 -0500
X-MC-Unique: DViTGFTgMkuZHqgu0UVOTQ-1
X-Mimecast-MFC-AGG-ID: DViTGFTgMkuZHqgu0UVOTQ_1741360929
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19F261828A93;
	Fri,  7 Mar 2025 15:22:06 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0251E1955DCE;
	Fri,  7 Mar 2025 15:22:01 +0000 (UTC)
Date: Fri, 7 Mar 2025 16:21:58 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Dave Chinner <david@fromorbit.com>
cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
    Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, 
    zkabelac@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
In-Reply-To: <Z8eURG4AMbhornMf@dread.disaster.area>
Message-ID: <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com> <Z8W1q6OYKIgnfauA@infradead.org> <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com> <Z8XlvU0o3C5hAAaM@infradead.org> <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com> <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com> <Z8eURG4AMbhornMf@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

> I didn't say you were. I said the concept that dm-loop is based on
> is fundamentally flawed and that your benchmark setup does not
> reflect real world usage of loop devices.

> Where are the bug reports about the loop device being slow and the
> analysis that indicates that it is unfixable?

So, I did benchmarks on an enterprise nvme drive (SAMSUNG 
MZPLJ1T6HBJR-00007). I stacked ext4/loop/ext4, xfs/loop/xfs (using losetup 
--direct-io=on), ext4/dm-loop/ext4 and xfs/dm-loop/xfs. And loop is slow.

synchronous I/O:
fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=psync --iodepth=1 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
raw block device:
   READ: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3985MiB (4179MB), run=10001-10001msec
  WRITE: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3990MiB (4184MB), run=10001-10001msec
ext4/loop/ext4:
   READ: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2232MiB (2341MB), run=10002-10002msec
  WRITE: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2231MiB (2339MB), run=10002-10002msec
xfs/loop/xfs:
   READ: bw=220MiB/s (230MB/s), 220MiB/s-220MiB/s (230MB/s-230MB/s), io=2196MiB (2303MB), run=10001-10001msec
  WRITE: bw=219MiB/s (230MB/s), 219MiB/s-219MiB/s (230MB/s-230MB/s), io=2193MiB (2300MB), run=10001-10001msec
ext4/dm-loop/ext4:
   READ: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3383MiB (3547MB), run=10002-10002msec
  WRITE: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3385MiB (3549MB), run=10002-10002msec
xfs/dm-loop/xfs:
   READ: bw=375MiB/s (393MB/s), 375MiB/s-375MiB/s (393MB/s-393MB/s), io=3752MiB (3934MB), run=10002-10002msec
  WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=3756MiB (3938MB), run=10002-10002msec

asynchronous I/O:
fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=libaio --iodepth=16 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
raw block device:
   READ: bw=1246MiB/s (1306MB/s), 1246MiB/s-1246MiB/s (1306MB/s-1306MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
  WRITE: bw=1247MiB/s (1308MB/s), 1247MiB/s-1247MiB/s (1308MB/s-1308MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
ext4/loop/ext4:
   READ: bw=274MiB/s (288MB/s), 274MiB/s-274MiB/s (288MB/s-288MB/s), io=2743MiB (2877MB), run=10001-10001msec
  WRITE: bw=275MiB/s (288MB/s), 275MiB/s-275MiB/s (288MB/s-288MB/s), io=2747MiB (2880MB), run=10001-10001msec
xfs/loop/xfs:
   READ: bw=276MiB/s (289MB/s), 276MiB/s-276MiB/s (289MB/s-289MB/s), io=2761MiB (2896MB), run=10002-10002msec
  WRITE: bw=276MiB/s (290MB/s), 276MiB/s-276MiB/s (290MB/s-290MB/s), io=2765MiB (2899MB), run=10002-10002msec
ext4/dm-loop/ext4:
   READ: bw=1189MiB/s (1247MB/s), 1189MiB/s-1189MiB/s (1247MB/s-1247MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
  WRITE: bw=1190MiB/s (1248MB/s), 1190MiB/s-1190MiB/s (1248MB/s-1248MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
xfs/dm-loop/xfs:
   READ: bw=1209MiB/s (1268MB/s), 1209MiB/s-1209MiB/s (1268MB/s-1268MB/s), io=11.8GiB (12.7GB), run=10001-10001msec
  WRITE: bw=1210MiB/s (1269MB/s), 1210MiB/s-1210MiB/s (1269MB/s-1269MB/s), io=11.8GiB (12.7GB), run=10001-10001msec

Mikulas


