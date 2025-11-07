Return-Path: <linux-fsdevel+bounces-67419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93836C3F251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 10:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752573B047C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946232BDC03;
	Fri,  7 Nov 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nNuFq4Jn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8162E7178
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507515; cv=none; b=njUyMSEo4ug8aHirsOMlp3O591STNpnu4g3EmQVcmSK1chP0AgTqoTK/n4br/btIxHUv4rgKMu9+kPuf2GjVofry/EFApMhkW6INGUpStcHwDnc8j5vrfDaLgezuSoFFcZhkk7eaf0Lir7zuAMTS+GDofLb48ej7FA6RxKn/EGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507515; c=relaxed/simple;
	bh=Llyb6G0N3m4WlabBeyiNpWRbU+9xF3fUAQa726lzReU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QaC9OvDRTv/MBe6DTcUcKj9N5u4spW6trvkSQwBsTTJh77crF+dMsWjvusGW2XP607wqD5TrsAoTmKGqD7T0QrMBh5EXcAZx70vo/+kFUZwrJ5AJbvhUbSb3H/+ZmDMDSyp1343GRMhLtx9MT16D36pFMBOWsxparRpcouyFw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nNuFq4Jn; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251107092510epoutp020993c72c37a7fbced46976de14616431~1rz4CT-g62580925809epoutp02L
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 09:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251107092510epoutp020993c72c37a7fbced46976de14616431~1rz4CT-g62580925809epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762507510;
	bh=u8uZZ4eKtfeKdhCl1Q4zHBINNzxY5n31tzDb1+D2ZUs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nNuFq4JnvaalPuw3XSCF+FmfhR4hroJIdPSDaHbSmmalxbF06Dg/9xIUKs6+9KzFz
	 +mAELlYpPRLM/VRb9troicO5aYquOMj5KfMMzbcDgQdZ0rmuNl5y5iIwuarLma8XZW
	 tCVt9qc3o0mDZEE2QeTmo6c4tZqQQITd/PUA9KvM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251107092509epcas5p39521b5623906275347b3ec7177eac680~1rz3UXgnn2572925729epcas5p39;
	Fri,  7 Nov 2025 09:25:09 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4d2tv81KkDz2SSKY; Fri,  7 Nov
	2025 09:25:08 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251107092507epcas5p3041edfe682f64c59ac3fe0fab4b9384b~1rz1O74AD2299222992epcas5p3F;
	Fri,  7 Nov 2025 09:25:07 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251107092447epsmtip2e07f9528cf570ebdd336a8a4571fc676~1rzi_2xUI0827208272epsmtip2i;
	Fri,  7 Nov 2025 09:24:46 +0000 (GMT)
Message-ID: <91367b76-e48b-46b4-b10b-43dfdd8472fa@samsung.com>
Date: Fri, 7 Nov 2025 14:54:42 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, jaegeuk@kernel.org, chao@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	miklos@szeredi.hu, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, amir73il@gmail.com, axboe@kernel.dk, ritesh.list@gmail.com,
	dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com,
	joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20251029085526.GA32407@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251107092507epcas5p3041edfe682f64c59ac3fe0fab4b9384b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
	<20251014120845.2361-1-kundan.kumar@samsung.com>
	<aPa7xozr7YbZX0W4@dread.disaster.area> <20251022043930.GC2371@lst.de>
	<e51e4fb9-01f7-4273-a363-fc1c2c61954b@samsung.com>
	<20251029060932.GS4015566@frogsfrogsfrogs> <20251029085526.GA32407@lst.de>

On 10/29/2025 2:25 PM, Christoph Hellwig wrote:
> On Tue, Oct 28, 2025 at 11:09:32PM -0700, Darrick J. Wong wrote:
>> Was that with or without rtgroups?  metadir/rtgroups aren't enabled by
>> default yet so you'd have to select that manually with mkfs.xfs -m
>> metadir=1.
>>
>> (and you might still not see much change because of what hch said)
> 
> The real problem here is that even the inode number to AG association
> is just a hint, and will often go wrong on an aged file system.
> 
> Now for the zoned RT device we could probably do a thread per open
> zone, as that is a very logical association.  The problem with that
> right now is that we only pick the zone to write to once doing
> writeback, but there might be ways to lift it up.  Then again
> zoned writeback is so little code that I can't see how it would
> saturate a single thread.
> 

Predicting the Allocation Group (AG) for aged filesystems and passing
this information to per-AG writeback threads appears to be a complex
task.

For write operations without pre-allocated data blocks (fallocate=none,
resulting in DELALLOC), the next available AG is selected, and the
XFS hook can be used to predict the AG that will be allocated.

In contrast, when writing to a previously allocated data block
(fallocate default, resulting in UNWRITTEN), the AG containing the data
block is chosen. Large files that span multiple AGs can lead to a mix
of random I/O operations (DELALLOC, UNWRITTEN, MAPPED) being directed
to different AGs, while still being cached in the same page cache.

To segregate these I/O requests by AG, it is necessary to associate
AG-specific information with the pages/folios in the page cache. Two
possible approaches are:
(1) storing AG information in the folio->private field, or
(2) introducing new markers in the xarray to track AG-specific data.

The AG-affined writeback thread processes specific pages from the page 
cache marked for its AG. Is this a viable approach, or are there 
alternative solutions that could be more effective?

>>
>> --D
> ---end quoted text---
> 


