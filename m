Return-Path: <linux-fsdevel+bounces-58351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46209B2D011
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 01:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1A91C27590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E3A270EAB;
	Tue, 19 Aug 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrixnQh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37735337A;
	Tue, 19 Aug 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646578; cv=none; b=oiHegR6HhrS65dhkXmiT6sQyMOb2VfyQQnQQ5KRLRcVTA1HwvqfPx/AabABHAbGiUJVxhdSm3yFljmE/n2MKc68x7qOTS/Gj+gz2u9XczA/yy9uSWehltLBsUB5/A7/fcR9jy6yKTkmXeSxKJDSgldFnanuurZGc7jfHYi0Ucvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646578; c=relaxed/simple;
	bh=OUiImZ/OymQmu2CCcYUgaGwLWJ5r4RdCQDFeCi6weYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVxJlyHaQxNFv3oGkoeDeK985IFUc1wA5TAcuqQZIRjjLbLvdKg79t98r9DuaJ4/iEnQMZq5e81pJ1EZ43keBSsiQtIoauUeAwI9g9+ypFUxNPWQbQkanzeHU36yR5NZh8g2G5TmggmnDzk2keqyKLgXuqD0pT5v0icFEP68xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrixnQh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E2CC4CEF1;
	Tue, 19 Aug 2025 23:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755646577;
	bh=OUiImZ/OymQmu2CCcYUgaGwLWJ5r4RdCQDFeCi6weYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrixnQh9594Z7RH6439sNQIWdZdIU00qc0OaUNkjIcyqP6trzqwtQVt6EobTTxyaE
	 3bpl/pniyJrmm5NBnukzjrgxWpdJCES+qMrAmfmetRKMKnrr73G9FxFrg28BbK464K
	 hGGgKGTObXEyt6vNmoIl2CpZQu9QEu+LVrqIS9La6rRKFJ+v4NXKcSykYD4MGd6BXl
	 71FnPAhBFyBrOQPlgIwu4x4lU0aTpdeRrYFyTBFmDIvnf3n65abApMxJ1Nlhwffg3R
	 zrW8SO0INsR+5r25/9+PGcTps5xkWF+DqX75Vs900riF7ILGKzAttE/zRIvVbmeReR
	 bmQhAEROCcOZA==
Date: Tue, 19 Aug 2025 19:36:16 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <aKUKcCIGDc79ulZ_@kernel.org>
References: <20250819164922.640964-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819164922.640964-1-kbusch@meta.com>

On Tue, Aug 19, 2025 at 09:49:14AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Previous version:
> 
>   https://lore.kernel.org/linux-block/20250805141123.332298-1-kbusch@meta.com/
> 
> This series removes the direct io requirement that io vector lengths
> align to the logical block size.
> 
> I tested this on a few raw block device types including nvme,
> virtio-blk, ahci, and loop. NVMe is the only one I tested with 4k
> logical sectors; everything else was 512.
> 
> On each of those, I tested several iomap filesystems: xfs, ext4, and
> btrfs. I found it interesting that each behave a little
> differently with handling invalid vector alignments:
> 
>   - XFS is the most straight forward and reports failures on invalid
>     vector conditions, same as raw blocks devices.
> 
>   - EXT4 falls back to buffered io for writes but not for reads.
> 
>   - BTRFS doesn't even try direct io for any unusual alignments; it
>     chooses buffered io from the start.
> 
> So it has been a little slow going figuring out which results to expect
> from various tests, but I think I've got all the corner cases covered. I
> can submit the tests cases to blktests and fstests for consideration
> separately, too.
> 
> I'm not 100% sure where we're at with the last patch. I think Mike
> initially indicated this was okay to remove, but I could swear I read
> something saying that might not be the case anymore. I just can't find
> the message now. Mike?

Hey,

Yes, I don't have pointers immediately available but I did mention it
and cc'd you.  I have found that my work relative to NFS and NFSD does
still need to use iov_iter_aligned_bvec -- otherwise misaligned DIO
can get issued to the underlying filesystem.

I did try to push all the relevant checking down to NFS/NFSD code that
assembles their respective bvec into an iov_iter, like you suggested,
but came up short after my first attempt.

I don't want to speak for the NFS or NFSD miantainers, but I'm
personally still OK with the broader iov_iter_is_aligned() interface
and even iov_iter_aligned_bvec() going away (and NFS/NFSD carrying
their own until I can circle back to hopefully eliminating the need).

Either that, or we remove all but iov_iter_aligned_bvec() and export
it so that NFS/NFSD can use it, _and_  tweak it so that it offers more
coarse-grained length checking, like so:
https://lore.kernel.org/linux-nfs/20250708160619.64800-5-snitzer@kernel.org/
(this is probably the best intermediate solution actually, though it'd
force my NFS and NFSD changes to be dependent on your series landing
-- which is probably a perfectly appropriate constraint)

Thanks,
Mike


> 
> Changes from v2:
> 
>   Include vector lengths when validating a split. The length check is
>   only valid for r/w commands, and skipped for passthrough
>   DRV_IN/DRV_OUT commands.
> 
>   Introduce a prep patch having bio_iov_iter_get_pages() take the
>   caller's desired length alignment.
> 
>   Additional code comments explaing less obvious error conditions.
> 
>   Added reviews on the patches that haven't changed.
> 
> Keith Busch (8):
>   block: check for valid bio while splitting
>   block: add size alignment to bio_iov_iter_get_pages
>   block: align the bio after building it
>   block: simplify direct io validity check
>   iomap: simplify direct io validity check
>   block: remove bdev_iter_is_aligned
>   blk-integrity: use simpler alignment check
>   iov_iter: remove iov_iter_is_aligned
> 
>  block/bio-integrity.c  |  4 +-
>  block/bio.c            | 64 ++++++++++++++++++----------
>  block/blk-map.c        |  2 +-
>  block/blk-merge.c      | 20 +++++++--
>  block/fops.c           | 13 +++---
>  fs/iomap/direct-io.c   |  6 +--
>  include/linux/bio.h    | 13 ++++--
>  include/linux/blkdev.h | 20 +++++----
>  include/linux/uio.h    |  2 -
>  lib/iov_iter.c         | 95 ------------------------------------------
>  10 files changed, 94 insertions(+), 145 deletions(-)
> 
> -- 
> 2.47.3
> 

