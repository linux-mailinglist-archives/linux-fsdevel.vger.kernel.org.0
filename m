Return-Path: <linux-fsdevel+bounces-44610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F162A6AA77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327A6189A708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5791EB9FD;
	Thu, 20 Mar 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy/JUVoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB914B08A;
	Thu, 20 Mar 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486331; cv=none; b=Tp9WCnDFUcEc01Bp/SZZrUaQvnxXqxeF9/kYxvUeKbGqqygBnxordFcEe0S5KLeLS8g2xwXBwieLllFUns4sIvVH9dk5wkkhKMrc7xGnR2N3B07rlMnUbFvK5f2BuGmesdE0gALZDshnIxJSfxndQKun6TWeHYaG1eE6bVWIE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486331; c=relaxed/simple;
	bh=kEMYb1JDv1HDrUaDiio6agDObcxFRmWmlmQGt0VX4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsM1wDeOaEXnFintKd898LRgt/BQmDC4KkUvKFtd0oVwCwMcndI/r70XSm6UDTxkmaIE+k4tA8EVRqOz3VgCXHYCZY/9AlyvlnOpubBRkmX4nMxx+vZLIt3L/D1K+FYxXB6W50dDb4jx5H5K8UO6sCPh8DOoMgEEBjB21L707ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy/JUVoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7180FC4CEDD;
	Thu, 20 Mar 2025 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486330;
	bh=kEMYb1JDv1HDrUaDiio6agDObcxFRmWmlmQGt0VX4h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dy/JUVoIQP9T5awVvskPFXgVGzW9fA0utk7uFP6TF6W2utNxTI5Feo7RN3BAX1da5
	 WtXQLRMRleI3VW+LW46DIRCT1bnY2GIp21hCCU1GryHWfKJFy7RoKHjUT6qraut4wf
	 z/1/TA0zLdxxRJ9rNTtDGRMj/k47J/ZHP38ntz/XXMGMOI+jilOSP6Dn3g1+9UfvUR
	 PUd5pt9GyTGFqjQB2DZ+4Kn+8+QXmpw47g/IzvnzYZ6n1w8N3ZEy6flP82kXNpLBWn
	 By0XcJNXvNDhSpBgDnykq+YYcubmf/UQM9nLu4xnzEurV+g9YAiUNhLjOmnDQqVhv6
	 I06AvsnNfmQHw==
Date: Thu, 20 Mar 2025 09:58:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	david@fromorbit.com, leon@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, p.raghav@samsung.com, gost.dev@samsung.com,
	da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <20250320141846.GA11512@lst.de>
 <a40a704f-22c8-4ae9-9800-301c9865cee4@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a40a704f-22c8-4ae9-9800-301c9865cee4@acm.org>

On Thu, Mar 20, 2025 at 08:37:05AM -0700, Bart Van Assche wrote:
> On 3/20/25 7:18 AM, Christoph Hellwig wrote:
> > On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
> > > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> > 
> > No, we absolutely haven't.  I'm regularly seeing multi-MB I/O on both
> > SCSI and NVMe setup.
> 
> Is NVME_MAX_KB_SZ the current maximum I/O size for PCIe NVMe
> controllers? From drivers/nvme/host/pci.c:

Yes, this is the driver's limit. The device's limit may be lower or
higher.

I allocate out of hugetlbfs to reliably send direct IO at this size
because the nvme driver's segment count is limited to 128. The driver
doesn't impose a segment size limit, though. If each segment is only 4k
(a common occurance), I guess that's where Luis is getting the 512K
limit?

> /*
>  * These can be higher, but we need to ensure that any command doesn't
>  * require an sg allocation that needs more than a page of data.
>  */
> #define NVME_MAX_KB_SZ	8192
> #define NVME_MAX_SEGS	128
> #define NVME_MAX_META_SEGS 15
> #define NVME_MAX_NR_ALLOCATIONS	5
> 
> > > This is due to the number of DMA segments and the segment size.
> > 
> > In nvme the max_segment_size is UINT_MAX, and for most SCSI HBAs it is
> > fairly large as well.
> 
> I have a question for NVMe device manufacturers. It is known since a
> long time that submitting large I/Os with the NVMe SGL format requires
> less CPU time compared to the NVMe PRP format. Is this sufficient to
> motivate NVMe device manufacturers to implement the SGL format? All SCSI
> controllers I know of, including UFS controllers, support something that
> is much closer to the NVMe SGL format rather than the NVMe PRP format.

SGL support does seem less common than you'd think. It is more efficient
when you have physically contiguous pages, or an IOMMU mapped
discontiguous pages into a dma contiguous IOVA. If you don't have that,
PRP is a little more efficient for memory and CPU usage. But in the
context of large folios, yeah, SGL is the better option.

