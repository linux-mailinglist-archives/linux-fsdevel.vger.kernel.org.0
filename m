Return-Path: <linux-fsdevel+bounces-43007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD24A4CD2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 22:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593CC173969
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76198235360;
	Mon,  3 Mar 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyrT36kb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6F214A91
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035861; cv=none; b=odbfTip5vKeimnMLOKNMOdqvZkEFesEs1XLVk9OfaPhs6oG5nFtuOnkCbHL2U0xXra/TKnZrPSk26pTjIgvbBZD0g+n58Gh6XSVXA3TFLtethCf99e4QKUjoFFwSXm0lNBta351bTMOkz0xUt1arDL4fbMyF5l4ktrp0Fg6XSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035861; c=relaxed/simple;
	bh=YyUEqbG8RQHyX8fBvFc8Vh7nzq9Xu9KmRwdJTNGv54c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iBRilLp7KLkxdB4T55hH4VUtZnP5sEOP2KTBFDcZiNpPvi7PWy14MoPz89bK5JY+lW9QsXKvlBdQRn4jbxKpXiYDFNKaqFPh9i/hvOnFidpOJkEJ2juojDaJ4ef94X1PIFeHudXRNVCVJ6SOYEg3aoHTBuSj9fAmGKUcPvqx72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyrT36kb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741035859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ys4JNLGyErR7JxC1BDaK7BQRhc1U8Vdx80t+A0LJfXw=;
	b=TyrT36kbOjDUq7iARxsGadT4TBA4ztoszLueDp0zy54oAm86Ecr48XbzcE2dDd1lXMX5vl
	roCuV8B3desxFdnsOw0S4Akcme53lNHTKpLRyaIBW+xnX9HrFtl0bgrBkOobnUU5YKnvlt
	jRn38NgQjDL5bFXF8er7TVobKWL5rI8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-JCnYpTmDM8aeGCkRpfys5w-1; Mon,
 03 Mar 2025 16:03:58 -0500
X-MC-Unique: JCnYpTmDM8aeGCkRpfys5w-1
X-Mimecast-MFC-AGG-ID: JCnYpTmDM8aeGCkRpfys5w_1741035837
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5492A1800878;
	Mon,  3 Mar 2025 21:03:51 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 117601800362;
	Mon,  3 Mar 2025 21:03:46 +0000 (UTC)
Date: Mon, 3 Mar 2025 22:03:42 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>, Jooyung Han <jooyung@google.com>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
    dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
In-Reply-To: <Z8XlvU0o3C5hAAaM@infradead.org>
Message-ID: <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com> <Z8W1q6OYKIgnfauA@infradead.org> <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com> <Z8XlvU0o3C5hAAaM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Mon, 3 Mar 2025, Christoph Hellwig wrote:

> On Mon, Mar 03, 2025 at 05:16:48PM +0100, Mikulas Patocka wrote:
> > What should I use instead of bmap? Is fiemap exported for use in the 
> > kernel?
> 
> You can't do an ahead of time mapping.  It's a broken concept.

Swapfile does ahead of time mapping. And I just looked at what swapfile 
does and copied the logic into dm-loop. If swapfile is not broken, how 
could dm-loop be broken?

> > Would Jens Axboe agree to merge the dm-loop logic into the existing loop 
> > driver?
> 
> What logic?

The ahead-of-time mapping.

> > Dm-loop is significantly faster than the regular loop:
> > 
> > # modprobe brd rd_size=1048576
> > # dd if=/dev/zero of=/dev/ram0 bs=1048576
> > # mkfs.ext4 /dev/ram0
> > # mount -t ext4 /dev/ram0 /mnt/test
> > # dd if=/dev/zero of=/mnt/test/test bs=1048576 count=512
> 
> All of this needs to be in a commit log.  Also note that the above:
> 
>  a) does not use direct I/O which any sane loop user should
>  b) is not on a file but a block device, rendering the use of a loop
>     device entirely pointless.

With "losetup --direct-io=on /dev/loop0 /mnt/test/test", it is even slower 
than without:

   READ: bw=217MiB/s (227MB/s), 217MiB/s-217MiB/s (227MB/s-227MB/s), io=2170MiB (2275MB), run=10003-10003msec
  WRITE: bw=217MiB/s (227MB/s), 217MiB/s-217MiB/s (227MB/s-227MB/s), io=2169MiB (2274MB), run=10003-10003msec

with --direct-io=off

   READ: bw=398MiB/s (417MB/s), 398MiB/s-398MiB/s (417MB/s-417MB/s), io=3978MiB (4171MB), run=10003-10003msec
  WRITE: bw=398MiB/s (417MB/s), 398MiB/s-398MiB/s (417MB/s-417MB/s), io=3981MiB (4175MB), run=10003-10003msec

Mikulas


