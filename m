Return-Path: <linux-fsdevel+bounces-43083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC63A4DC5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EAF179E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9BC1FECDC;
	Tue,  4 Mar 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V33b5Pxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DC1FC105
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087106; cv=none; b=eVHwBibBzWKUp3m/IQlIIso1KjtBli5Jc8cAzlOPIbdguHhKaEmR3iRbpt/bxXvTrvKrDMQU/x3iLhH4K23crJXet3Iqd1YomXewgZmXbvYjt3xxdlzMgiIYcckmJCxhxXBLDbKhUjww4cHYN6dZ4DXfAkKcaux0YcOy5RtvDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087106; c=relaxed/simple;
	bh=9mTH7ItLTK9ncQHKsdc3UyY37G50MU5MYZiyBlBzTrM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wf1yh1NYsBJa44Ou0dC8TxusviIhRROTH1YG5FtMDwkFo2UVKB/ho+LtKaeHX2AhF5ydr8V4wBXjC9bZ2ULze5LNzojQzLKPvBRo+CP7S0dbFUnpV0loTFbEUFhL05vTCDe2C4yZESiHNGCDjml5iOeuj4aO5O8KzgCoAsDMDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V33b5Pxy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741087103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=usTDXviTOoXK2bqIgIBvnRDmIQUTE9ubAbo+F2b7Uro=;
	b=V33b5PxyQeKWFc2kYnUGZJXHh82UXE8Inz3SOe+BNmu2ioIR44NeulEb0pZ26FFnYAN4xH
	IRT0VT2i/38bjYxvqXEpSd2w8ieCjf//HB5wwDr344yeErRRSERUHO4wFn0EMGaxLrIwiF
	yfxu8qjVotcdkx4FSGL4Ok5GDUSseSI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-m6SLKZ_7NNaTqO1wbE1WlA-1; Tue,
 04 Mar 2025 06:18:15 -0500
X-MC-Unique: m6SLKZ_7NNaTqO1wbE1WlA-1
X-Mimecast-MFC-AGG-ID: m6SLKZ_7NNaTqO1wbE1WlA_1741087094
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B25B8193585F;
	Tue,  4 Mar 2025 11:18:13 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC5561954B00;
	Tue,  4 Mar 2025 11:18:08 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:18:04 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Dave Chinner <david@fromorbit.com>
cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
    Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, 
    zkabelac@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
In-Reply-To: <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
Message-ID: <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com> <Z8W1q6OYKIgnfauA@infradead.org> <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com> <Z8XlvU0o3C5hAAaM@infradead.org> <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Tue, 4 Mar 2025, Dave Chinner wrote:

> On Mon, Mar 03, 2025 at 10:03:42PM +0100, Mikulas Patocka wrote:
> > 
> > 
> > On Mon, 3 Mar 2025, Christoph Hellwig wrote:
> > 
> > > On Mon, Mar 03, 2025 at 05:16:48PM +0100, Mikulas Patocka wrote:
> > > > What should I use instead of bmap? Is fiemap exported for use in the 
> > > > kernel?
> > > 
> > > You can't do an ahead of time mapping.  It's a broken concept.
> > 
> > Swapfile does ahead of time mapping. And I just looked at what swapfile 
> > does and copied the logic into dm-loop. If swapfile is not broken, how 
> > could dm-loop be broken?
> 
> Swap files cannot be accessed/modified by user code once the
> swapfile is activated.  See all the IS_SWAPFILE() checked throughout
> the VFS and filesystem code.
> 
> Swap files must be fully allocated (i.e. not sparse), nor contan
> shared extents. This is required so that writes to the swapfile do
> not require block allocation which would change the mapping...
> 
> Hence we explicitly prevent modification of the underlying file
> mapping once a swapfile is owned and mapped by the kernel as a
> swapfile.
> 
> That's not how loop devices/image files work - we actually rely on
> them being:
> 
> a) sparse; and
> b) the mapping being mutable via direct access to the loop file
> whilst there is an active mounted filesystem on that loop file.
> 
> and so every IO needs to be mapped through the filesystem at
> submission time.
> 
> The reason for a) is obvious: we don't need to allocate space for
> the filesystem so it's effectively thin provisioned. Also, fstrim on
> the mounted loop device can punch out unused space in the mounted
> filesytsem.
> 
> The reason for b) is less obvious: snapshots via file cloning,
> deduplication via extent sharing.
> 
> The clone operaiton is an atomic modification of the underlying file
> mapping, which then triggers COW on future writes to those mappings,
> which causes the mapping to the change at write IO time.
> 
> IOWs, the whole concept that there is a "static mapping" for a loop
> device image file for the life of the image file is fundamentally
> flawed.

I'm not trying to break existing loop.

But some users don't use COW filesystems, some users use fully provisioned 
files, some users don't need to write to a file when it is being mapped - 
and for them dm-loop would be viable alternative because of better 
performance.

The Android people concluded that loop is too slow and rather than using 
loop they want to map a file using a table with dm-linear targets over the 
image of the host filesystem. So, they are already doing what dm-loop is 
doing.

Mikulas


