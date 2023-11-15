Return-Path: <linux-fsdevel+bounces-2897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B17EC681
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB58E281562
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC433CDB;
	Wed, 15 Nov 2023 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H++OVUzw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473C33083
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 14:59:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2349DAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 06:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700060372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgSFAqsrrIeyfcEV4+4kyzG8JlxNH43PSFwHbBsH0s4=;
	b=H++OVUzwxJdOrLzoU5/oas2bldm0iC0+5cyGLgfOu4XWyhgH0f/hJoXeOEvQnN50kUWycB
	jGszMGa6lC5s3kfQlwb9vYBxs3RH5zVIXpzv2xaFsz+P7JomNnP9FKT1UNBe93ZMNCwAV3
	++UnUDldVIdYDEVXgqhSvSI4EolBvug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-NqVnE2VQNm60TzLstO6QCg-1; Wed, 15 Nov 2023 09:59:29 -0500
X-MC-Unique: NqVnE2VQNm60TzLstO6QCg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF10E85A58A;
	Wed, 15 Nov 2023 14:59:28 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ADF1336EE;
	Wed, 15 Nov 2023 14:59:25 +0000 (UTC)
Date: Wed, 15 Nov 2023 22:59:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Ming Lin <minggr@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Performance Difference between ext4 and Raw Block Device Access
 with buffer_io
Message-ID: <ZVTcyKbHTasef1Py@fedora>
References: <CAF1ivSY-V+afUxfH7SDyM9vG991u7EoDCteL1y5jurnKSzQ3YA@mail.gmail.com>
 <ZVSNIClnCnmay8e6@fedora>
 <ZVTTh/LdexBD7BdE@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTTh/LdexBD7BdE@x1-carbon>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, Nov 15, 2023 at 02:20:02PM +0000, Niklas Cassel wrote:
> On Wed, Nov 15, 2023 at 05:19:28PM +0800, Ming Lei wrote:
> > On Mon, Nov 13, 2023 at 05:57:52PM -0800, Ming Lin wrote:
> > > Hi,
> > > 
> > > We are currently conducting performance tests on an application that
> > > involves writing/reading data to/from ext4 or a raw block device.
> > > Specifically, for raw block device access, we have implemented a
> > > simple "userspace filesystem" directly on top of it.
> > > 
> > > All write/read operations are being tested using buffer_io. However,
> > > we have observed that the ext4+buffer_io performance significantly
> > > outperforms raw_block_device+buffer_io:
> > > 
> > > ext4: write 18G/s, read 40G/s
> > > raw block device: write 18G/s, read 21G/s
> > 
> > Can you share your exact test case?
> > 
> > I tried the following fio test on both ext4 over nvme and raw nvme, and the
> > result is the opposite: raw block device throughput is 2X ext4, and it
> > can be observed in both VM and read hardware.
> > 
> > 1) raw NVMe
> > 
> > fio --direct=0 --size=128G --bs=64k --runtime=20 --numjobs=8 --ioengine=psync \
> >     --group_reporting=1 --filename=/dev/nvme0n1 --name=test-read --rw=read
> > 
> > 2) ext4
> > 
> > fio --size=1G --time_based --bs=4k --runtime=20 --numjobs=8 \
> > 	--ioengine=psync --directory=$DIR --group_reporting=1 \
> > 	--unlink=0 --direct=0 --fsync=0 --name=f1 --stonewall --rw=read
> 
> Hello Ming,
> 
> 1) uses bs=64k, 2) uses bs=4k, was this intentional?

It is a typo, actually both two are taking bs=64k.

> 
> 2) uses stonewall, but 1) doesn't, was this intentional?

To be honest, both are run from different existed two scripts,
just run again by adding --stonewall to raw block test, not see
difference.

> 
> For fairness, you might want to use the same size (1G vs 128G).

For fs test, each io job creates one file and run IO against each file,
but there is only one 'file' in raw block test, and all 8 jobs run
IO on same block device.

So just start one quick randread test, similar gap can be observed
too compared with read test.

> 
> And perhaps clear the page cache before each fio invocation:
> # echo 1 > /proc/sys/vm/drop_caches

Yes, it is always done before running the two buffered IO tests.


thanks,
Ming


