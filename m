Return-Path: <linux-fsdevel+bounces-17103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6658A7B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 06:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC581C2193B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144245949;
	Wed, 17 Apr 2024 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT8CmgOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F81F40847;
	Wed, 17 Apr 2024 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329119; cv=none; b=DRZgnHIf3ZqJt0hfS1kZEHZQ80nV9gW7rshRlU8zFarXAvTYY0UcXKjOEcTjg5cDm6VUIRkpciCViOOyzAsdNEHLXZYhQFxYlAVQ9ld1ISVkrwFU9evouuBRg5kAMFUhgyuQnRoyCVBZL4iYobcoPmhS9jZZX0+vzzLU6MdZPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329119; c=relaxed/simple;
	bh=d3UI7TPsKQ6hePG28+svcxqObPL4Pt/HEcBjwPLGNzU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=CcoUSmau8hC3gPjZ5ngf1b0lKKCGOLdysbohWuBnW/OQp+b+UsxcxSURB2vqnHla0UmZOh2EM6v/cWzCAuUM2q6zAHpnMpVIhLDr1ClKYQkWqaDi5AhNrKEBYBI9856GA53R/eAqivmOTV2zssWVCIE2cE7T7eMVuLdblfciWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT8CmgOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EEBC072AA;
	Wed, 17 Apr 2024 04:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713329118;
	bh=d3UI7TPsKQ6hePG28+svcxqObPL4Pt/HEcBjwPLGNzU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=gT8CmgOiOdcbtHflAEjF4Qw72KcTh3+J5vJQTBS7Ri/styB0ktHbpFDHnusUDABSn
	 +If5NL10FHgBc+RHv8+nZKY8XRIKNixeNhO4+ep/770XcCEHxaTnEOuLYBRJCq79jV
	 Yai3a3Twt1B0wwUZLrESU7Y+O9XdgBTXMZQaQOZga8ax7OnZO4bZPexCsgXe8XdpLf
	 P8b/xXOoff+gSfIcvJ+5xvZxkurKPu3LGtCERLR5O2G/gwaLLgxuO5ERi7vDGVvdtm
	 mL8K0gcdjtZYt3LAlciLpoFUM/Df0zVL2P3xDCzSQE6e2tkrLfNV4gM53iUpy4J3Z0
	 lEYva8Sfduj6Q==
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 0/9] xfs/iomap: fix non-atomic clone operation and
 don't update size when zeroing range post eof
Date: Wed, 17 Apr 2024 10:12:10 +0530
In-reply-to: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
Message-ID: <87ttk0d2ck.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 20, 2024 at 07:05:39 PM +0800, Zhang Yi wrote:
> Changes since v3:
>  - Improve some git message comments and do some minor code cleanup, no
>    logic changes.
>
> Changes since v2:
>  - Merge the patch for dropping of xfs_convert_blocks() and the patch
>    for modifying xfs_bmapi_convert_delalloc().
>  - Reword the commit message of the second patch.
>
> Changes since v1:
>  - Make xfs_bmapi_convert_delalloc() to allocate the target offset and
>    drop the writeback helper xfs_convert_blocks().
>  - Don't use xfs_iomap_write_direct() to convert delalloc blocks for
>    zeroing posteof case, use xfs_bmapi_convert_delalloc() instead.
>  - Fix two off-by-one issues when converting delalloc blocks.
>  - Add a separate patch to drop the buffered write failure handle in
>    zeroing and unsharing.
>  - Add a comments do emphasize updating i_size should under folio lock.
>  - Make iomap_write_end() to return a boolean, and do some cleanups in
>    buffered write begin path.
>
> This patch series fix a problem of exposing zeroed data on xfs since the
> non-atomic clone operation. This problem was found while I was
> developing ext4 buffered IO iomap conversion (ext4 is relying on this
> fix [1]), the root cause of this problem and the discussion about the
> solution please see [2]. After fix the problem, iomap_zero_range()
> doesn't need to update i_size so that ext4 can use it to zero partial
> block, e.g. truncate eof block [3].
>
> [1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
> [2] https://lore.kernel.org/linux-ext4/9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com/
> [3] https://lore.kernel.org/linux-ext4/9c9f1831-a772-299b-072b-1c8116c3fb35@huaweicloud.com/
>
> Thanks,
> Yi.
>
> Zhang Yi (9):
>   xfs: match lock mode in xfs_buffered_write_iomap_begin()
>   xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
>   xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
>   xfs: convert delayed extents to unwritten when zeroing post eof blocks
>   iomap: drop the write failure handles when unsharing and zeroing
>   iomap: don't increase i_size if it's not a write operation
>   iomap: use a new variable to handle the written bytes in
>     iomap_write_iter()
>   iomap: make iomap_write_end() return a boolean
>   iomap: do some small logical cleanup in buffered write
>

Hi all,

I have picked up this patchset for inclusion into XFS' 6.10-rc1 patch
queue. Please let me know if there are any objections.

-- 
Chandan

