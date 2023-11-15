Return-Path: <linux-fsdevel+bounces-2884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B417EBF54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E3FB20BF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2C567E;
	Wed, 15 Nov 2023 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9I1woH9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355447E
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 09:19:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317AA9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700039979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcNgWQ8ygzMvds1M1LN5SC3pyZyIqQga43z/omNaXOM=;
	b=N9I1woH9D9i92ENdheu/ZEIdaeljMGhPk5v8wTh2ceQ5m5hqm7Vb5ahQUcv4b93rKoWOa4
	HZpDpU82V+L4L6iigRUSO5vI6nknwX6IWStyILinRDbYqFGLcK/RwV66PiAQvG2XD01SN1
	5u/2RKaRhHPuJ9YDPg1CrcebAmyQRm4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-u9R57BHvPmycv6zpbz_K2g-1; Wed,
 15 Nov 2023 04:19:37 -0500
X-MC-Unique: u9R57BHvPmycv6zpbz_K2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A87A91C05EB4;
	Wed, 15 Nov 2023 09:19:36 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 812812166B27;
	Wed, 15 Nov 2023 09:19:33 +0000 (UTC)
Date: Wed, 15 Nov 2023 17:19:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ming Lin <minggr@gmail.com>
Cc: linux-block@vger.kernel.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, ming.lei@redhat.com
Subject: Re: Performance Difference between ext4 and Raw Block Device Access
 with buffer_io
Message-ID: <ZVSNIClnCnmay8e6@fedora>
References: <CAF1ivSY-V+afUxfH7SDyM9vG991u7EoDCteL1y5jurnKSzQ3YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1ivSY-V+afUxfH7SDyM9vG991u7EoDCteL1y5jurnKSzQ3YA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Nov 13, 2023 at 05:57:52PM -0800, Ming Lin wrote:
> Hi,
> 
> We are currently conducting performance tests on an application that
> involves writing/reading data to/from ext4 or a raw block device.
> Specifically, for raw block device access, we have implemented a
> simple "userspace filesystem" directly on top of it.
> 
> All write/read operations are being tested using buffer_io. However,
> we have observed that the ext4+buffer_io performance significantly
> outperforms raw_block_device+buffer_io:
> 
> ext4: write 18G/s, read 40G/s
> raw block device: write 18G/s, read 21G/s

Can you share your exact test case?

I tried the following fio test on both ext4 over nvme and raw nvme, and the
result is the opposite: raw block device throughput is 2X ext4, and it
can be observed in both VM and read hardware.

1) raw NVMe

fio --direct=0 --size=128G --bs=64k --runtime=20 --numjobs=8 --ioengine=psync \
    --group_reporting=1 --filename=/dev/nvme0n1 --name=test-read --rw=read

2) ext4

fio --size=1G --time_based --bs=4k --runtime=20 --numjobs=8 \
	--ioengine=psync --directory=$DIR --group_reporting=1 \
	--unlink=0 --direct=0 --fsync=0 --name=f1 --stonewall --rw=read


> 
> We are exploring potential reasons for this difference. One hypothesis
> is related to the page cache radix tree being per inode. Could it be
> that, for the raw_block_device, there is only one radix tree, leading
> to increased lock contention during write/read buffer_io operations?

'perf record/report' should show the hot spot if lock contention is the
reason.


Thanks,
Ming


