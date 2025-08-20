Return-Path: <linux-fsdevel+bounces-58355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F41B2D1B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 03:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E62584E94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839D278E5D;
	Wed, 20 Aug 2025 01:57:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.189.cn (unknown [14.29.118.224])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948CD277C96;
	Wed, 20 Aug 2025 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.29.118.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755655029; cv=none; b=rEm7JzngIuaHBY+vi0bjt1kWQsLpe/7d0d8QFnRG7dc6tlapoANryYAtdy/TOa8FgXkHcA7Y5Md6rzEqiC3AHvv/q5UOAgdlHtptbh1LK+0N2VtXTakzzPNAUM1UK9nBXMJT1CJmfjAkX8gYkJMjUGANf3/oAJuwcFnlNdBIf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755655029; c=relaxed/simple;
	bh=JljQWhyzIJt7C788pKgaXNB1oPW5minMsML/GRveAao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgkV/ODLZFmUOxZiXJEIb/OgBlfhspXlCoT9fnarr0Qa+DEzAYqI4VQbqg94j884npeck4tJPhkyfG8QR3OXdbxL7C5bVTT+ooBv5Rwr5z1yxPC0b+/te1StiBXsLxIhhB2hjAkeXwmDYI0x6svA5Lhyf3vwK7lkNSIytxoxrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.29.118.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.323270274
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 554F2400310;
	Wed, 20 Aug 2025 09:52:37 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-cdbdfc76c-6vnnj with ESMTP id 1fa85400c497490182ac2cbe6ac6ffa0 for kbusch@meta.com;
	Wed, 20 Aug 2025 09:52:39 CST
X-Transaction-ID: 1fa85400c497490182ac2cbe6ac6ffa0
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.48
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <5706ae6d-5ffd-445d-bfb3-d44fc2afa350@189.cn>
Date: Wed, 20 Aug 2025 09:52:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org,
 linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
 Keith Busch <kbusch@kernel.org>
References: <20250819164922.640964-1-kbusch@meta.com>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <20250819164922.640964-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/8/20 00:49, Keith Busch 写道:
> From: Keith Busch <kbusch@kernel.org>
> 
> Previous version:
> 
>    https://lore.kernel.org/linux-block/20250805141123.332298-1-kbusch@meta.com/
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
>    - XFS is the most straight forward and reports failures on invalid
>      vector conditions, same as raw blocks devices.
> 
>    - EXT4 falls back to buffered io for writes but not for reads.

I found it in ext4 too, i tried to fall the misaligned dio read request 
back to buffered io and submitted a patch[1], but haven't received any 
comments yet.

[1]:https://lore.kernel.org/all/20250710085910.123168-1-chensong_2000@189.cn/

Song
> 
>    - BTRFS doesn't even try direct io for any unusual alignments; it
>      chooses buffered io from the start.
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
> 
> Changes from v2:
> 
>    Include vector lengths when validating a split. The length check is
>    only valid for r/w commands, and skipped for passthrough
>    DRV_IN/DRV_OUT commands.
> 
>    Introduce a prep patch having bio_iov_iter_get_pages() take the
>    caller's desired length alignment.
> 
>    Additional code comments explaing less obvious error conditions.
> 
>    Added reviews on the patches that haven't changed.
> 
> Keith Busch (8):
>    block: check for valid bio while splitting
>    block: add size alignment to bio_iov_iter_get_pages
>    block: align the bio after building it
>    block: simplify direct io validity check
>    iomap: simplify direct io validity check
>    block: remove bdev_iter_is_aligned
>    blk-integrity: use simpler alignment check
>    iov_iter: remove iov_iter_is_aligned
> 
>   block/bio-integrity.c  |  4 +-
>   block/bio.c            | 64 ++++++++++++++++++----------
>   block/blk-map.c        |  2 +-
>   block/blk-merge.c      | 20 +++++++--
>   block/fops.c           | 13 +++---
>   fs/iomap/direct-io.c   |  6 +--
>   include/linux/bio.h    | 13 ++++--
>   include/linux/blkdev.h | 20 +++++----
>   include/linux/uio.h    |  2 -
>   lib/iov_iter.c         | 95 ------------------------------------------
>   10 files changed, 94 insertions(+), 145 deletions(-)
> 

