Return-Path: <linux-fsdevel+bounces-51786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC68ADB643
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 18:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB69E16301F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58C2877CA;
	Mon, 16 Jun 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBNFhvDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276E286421;
	Mon, 16 Jun 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090065; cv=none; b=AWUUidks4UzXNnOxMPD37mTok2ilzoETyQ2rw8gawneN5VV0hMdK3jo+WxnIUoDxIAQ8AVhuJC8Yqx9CWli0DCbr4MXEhAXfLs+fyqRL12EbYE/jg9r+QO3WZyne3teNZ8QWsDOkAnUCtE+RK89LQikD8iVCjMsydJ/X+VctS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090065; c=relaxed/simple;
	bh=y8s2kSUVR3nsjejTQkx1HrKSRbqann7Wo+gnkuEqrvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCThhSmP0W/rGSFDAk8bzScoFrC4n0J/zfySLiTSFFM7n/I7o0l9u1znoqgRP4bSNQP/eblBru5qL1OZXoLLbhkye42XZvk7HAvLvUbvOB4qzxv1TxXJdgCBSmXsNCBQO207KwVgmg0ZEXtxVAD+8DniWbV7JP/eCLpVGSGNMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBNFhvDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDDEC4CEF0;
	Mon, 16 Jun 2025 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750090064;
	bh=y8s2kSUVR3nsjejTQkx1HrKSRbqann7Wo+gnkuEqrvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBNFhvDtftuVMZmE84RjQjnAE0DNGPAQJ6lz5fKyGpnZXjaK408L/uw+P7u4iVkA0
	 4Qztbf3XN2O/Il/aN+jnR7697u3tNwd2pu04yBqaWGKqirLbx9DHeeHRzt/La5pVZj
	 NgV8MMed9yoeGY34APi27BHxp3iA7QC6Cdy7TkmjGvOw8LJvXMR7YU2UNjUFykygfW
	 YaoznivRSRGZ/ce8GqDFOr12LhG5NvJUX7wjheEBIvk3K7sGz7U3wu2UNrT6BfcXDJ
	 uUj0wlaYeVfLQSLB2jy0D2IZlQQ3lBJzbiMxt8hcZRnkK0FEKJB6LXl39o8fz+y30m
	 WjakJWWBFBqDg==
Date: Mon, 16 Jun 2025 12:07:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, david.flynn@hammerspace.com
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aFBBToft6H-r51TH@kernel.org>
References: <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
 <aEu7GSa7HRNNVJVA@infradead.org>
 <aEvuJP7_xhVk5R4S@kernel.org>
 <aFAOLAOsWngZV_aL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFAOLAOsWngZV_aL@infradead.org>

On Mon, Jun 16, 2025 at 05:29:32AM -0700, Christoph Hellwig wrote:
> On Fri, Jun 13, 2025 at 05:23:48AM -0400, Mike Snitzer wrote:
> > Which in practice has proven a hard requirement for O_DIRECT in my
> > testing
> 
> What fails if you don't page align the memory?
> 
> > But if you looking at patch 5 in this series:
> > https://lore.kernel.org/linux-nfs/20250610205737.63343-6-snitzer@kernel.org/
> > 
> > I added fs/nfsd/vfs.c:is_dio_aligned(), which is basically a tweaked
> > ditto of fs/btrfs/direct-io.c:check_direct_IO():
> 
> No idea why btrfs still has this, but it's not a general requirement
> from the block layer or other file system.  You just need to be
> aligned to the dma alignment in the queue limits, which for most NVMe,
> SCSI or ATA devices reports a dword alignment.  Some of the more
> obscure drivers might require more alignment, or just report it due to
> copy and paste.

Yeah, should probably be fixed and the rest of filesystems audited.
 
> > What I found is that unless SUNRPC TPC stored the WRITE payload in a
> > page-aligned boundary then iov_iter_alignment() would fail.
> 
> iov_iter_alignment would fail, or yout check based on it?  The latter
> will fail, but it doesn't check anything that matters :)
> 

The latter, the check based on iov_iter_alignment() failed.  I
understand your point.

Thankfully I can confirm that dword alignment is all that is needed on
modern hardware, just showing my work:

I retested a 512K write payload that is aligned to the XFS bdev's
logical_block_size (512b) fails when I skip the iov_iter_alignment()
check at a high level.

Because it fails in fs/iomap/direct-io.c:iomap_dio_bio_iter() with
this check:

        if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
            !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
                return -EINVAL;

Because:

static inline bool bdev_iter_is_aligned(struct block_device *bdev,
                                        struct iov_iter *iter)
{
        return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
                                   bdev_logical_block_size(bdev) - 1);
}

and because bdev_dma_alignment for my particular test bdev is 511 :(

But that's OK... my test bdev is a bad example (archaic VMware vSphere
provided SCSI device): it doesn't reflect expected modern hardware.

But I just slapped together a test pmem blockdevice (memory backed,
using memmap=6G!18G) and it too has dma_alignment=511

I do have access to a KVM guest with a virtio_scsi root bdev that has
dma_alignment=3

I also just confirmed that modern NVMe devices on another testbed also
have dma_alignment=3, whew...

I'd like NFSD to be able to know if its bvec is dma-aligned, before
issuing DIO writes to underlying XFS.  AFAIK I can do that simply by
checking the STATX_DIOALIGN provided dio_mem_align...

Thanks,
Mike

