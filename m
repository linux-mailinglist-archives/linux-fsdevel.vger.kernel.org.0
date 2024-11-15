Return-Path: <linux-fsdevel+bounces-34893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C879CDD62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10775B236A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41001B85D1;
	Fri, 15 Nov 2024 11:21:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D61B218E;
	Fri, 15 Nov 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669697; cv=none; b=uXaGuKwosNQQze9z4NcZUR7EiIi2tOkqQaHy+PQn0IDTKMT20ZodpALyGC4F7vLZ52e3ZZoE+w9eRVkyLQEByuLIu/8j7LWWcP7tI26nfFnImoeH07xf/36QsENXS5wB0TtA/RC+Ts9v0pZVYHq0azlhYuH3XRz2p+c3ACJ6eJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669697; c=relaxed/simple;
	bh=KTIoMi/r1hTENNKL0/G/hsDkGqPwoHDgtpul7a9ld2w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoOglhZdTJxcnlBxFiF5V4ByM1/UFO4HnYws4shEvQrZtGn8fLstdSsnLKmd+CKNe4VQADn14CjOh34w1ydSKIUtO3bkIBwCJHVuVEErmZ3mlVOGHSQgXj/Lloa2NKyLx+c4mIDy2xR3sn0k/0aRVzD4DfmMe+jNTHLg3fxP7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XqZL1286qz2GZhG;
	Fri, 15 Nov 2024 19:19:37 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id E370518002B;
	Fri, 15 Nov 2024 19:21:29 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Nov
 2024 19:21:29 +0800
Date: Fri, 15 Nov 2024 19:20:09 +0800
From: Long Li <leo.lilong@huawei.com>
To: Dave Chinner <dchinner@redhat.com>
CC: John Garry <john.g.garry@oracle.com>, Dave Chinner <david@fromorbit.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, <chandan.babu@oracle.com>,
	<djwong@kernel.org>, <hch@lst.de>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <linux-xfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<catherine.hoang@oracle.com>, <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZzcuaYVuFuhknNs_@localhost.localdomain>
References: <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
 <ZufBMioqpwjSFul+@dread.disaster.area>
 <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>
 <ZuoCafOAVqSN6AIK@dread.disaster.area>
 <1394ceeb-ce8c-4d0f-aec8-ba93bf1afb90@oracle.com>
 <ZzXxlf6RWeX3e-3x@localhost.localdomain>
 <ZzZYmTuSsHN-M0Of@rh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZzZYmTuSsHN-M0Of@rh>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Fri, Nov 15, 2024 at 07:07:53AM +1100, Dave Chinner wrote:
> On Thu, Nov 14, 2024 at 08:48:21PM +0800, Long Li wrote:
> > On Wed, Sep 18, 2024 at 11:12:47AM +0100, John Garry wrote:
> > > On 17/09/2024 23:27, Dave Chinner wrote:
> > > > > # xfs_bmap -vvp  mnt/file
> > > > > mnt/file:
> > > > > EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> > > > >    0: [0..15]:         384..399          0 (384..399)          16 010000
> > > > >    1: [16..31]:        400..415          0 (400..415)          16 000000
> > > > >    2: [32..127]:       416..511          0 (416..511)          96 010000
> > > > >    3: [128..255]:      256..383          0 (256..383)         128 000000
> > > > > FLAG Values:
> > > > >     0010000 Unwritten preallocated extent
> > > > > 
> > > > > Here we have unaligned extents wrt extsize.
> > > > > 
> > > > > The sub-alloc unit zeroing would solve that - is that what you would still
> > > > > advocate (to solve that issue)?
> > > > Yes, I thought that was already implemented for force-align with the
> > > > DIO code via the extsize zero-around changes in the iomap code. Why
> > > > isn't that zero-around code ensuring the correct extent layout here?
> > > 
> > > I just have not included the extsize zero-around changes here. They were
> > > just grouped with the atomic writes support, as they were added specifically
> > > for the atomic writes support. Indeed - to me at least - it is strange that
> > > the DIO code changes are required for XFS forcealign implementation. And,
> > > even if we use extsize zero-around changes for DIO path, what about buffered
> > > IO?
> > 
> > 
> > I've been reviewing and testing the XFS atomic write patch series. Since
> > there haven't been any new responses to the previous discussions on this
> > issue, I'd like to inquire about the buffered IO problem with force-aligned
> > files, which is a scenario we might encounter.
> > 
> > Consider a case where the file supports force-alignment with a 64K extent size,
> > and the system page size is 4K. Take the following commands as an example:
> > 
> > xfs_io  -c "pwrite 64k 64k" mnt/file
> > xfs_io  -c "pwrite 8k 8k" mnt/file
> > 
> > If unaligned unwritten extents are not permitted, we need to zero out the
> > sub-allocation units for ranges [0, 8K] and [16K, 64K] to prevent stale
> > data. While this can be handled relatively easily in direct I/O scenarios,
> > it presents significant challenges in buffered I/O operations. The main
> > difficulty arises because the extent size (64K) is larger than the page
> > size (4K), and our current code base has substantial limitations in handling
> > such cases.
> > 
> > Any thoughts on this?
> 
> Large folios in the page cache solve this problem. i.e. it's the
> same problem that block size > page size support had to solve.
> 
> 

Thanks for your reply, it cleared up my confusion. So maybe we need
to set a minimum folio order for force-aligned inodes, just
like Large block sizes (LBS).

Thanks,
Long Li

