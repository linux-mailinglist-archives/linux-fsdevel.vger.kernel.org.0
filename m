Return-Path: <linux-fsdevel+bounces-17235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D788A9635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 11:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC391F22F2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296A15ADAF;
	Thu, 18 Apr 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYtQ8IV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6C15AAD9;
	Thu, 18 Apr 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432675; cv=none; b=bIxWk6Y9Ff7l/7luR4GEdK7vrxAOJWvJhw+rsnAGCet5xcQF8uC87bhu3GTuO6k2HoPZsvULNRp0P8S1eSFUYIDQhSw+HbKnbFsqnQC7e3odr3u0BX7l7ldAqWZ7hA/+zk3iUgWFgGzyXCl/6j6TYN/KyuzWQn1Ah/ylct/vMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432675; c=relaxed/simple;
	bh=gN0fEs2IeXR2uuO3djCJi6oqh+EDHi/DMzZ/PmxG0OY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=R4cLJgTW/7r/D+CMJhTUKZtCew4qappdXy75yIZA5BKHzmbd3GxZSgd1XbSST4LoB0Oia/4APyqSVBpCNdcc95qm7TZef6hS4RiZj1rjZ4LWSlKaXJg5mvtfrhh9KVunbFrJA7H0uL/8696a6OJ8BsUBb7zd5SJ5nieT5rWecog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYtQ8IV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B6EC113CC;
	Thu, 18 Apr 2024 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713432675;
	bh=gN0fEs2IeXR2uuO3djCJi6oqh+EDHi/DMzZ/PmxG0OY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=KYtQ8IV73qHbXNUqGYmdNx4WMyYZ2SQUo4t+qUdIDXO09H/BsM5ayYka8bGqD5i7l
	 R+j79Z4noQwdPahEtL/ywwiqVRdmIC2l5a9GRyT2hBkdyuhDBTAYtdPV1PXUYnDSye
	 cpOP6uh7TOA9AMS0Qon2rUXsbNZwZSIuixDChyolENUC/YrnQOmJbjUeH9wygirF0p
	 9gC8EWWBy0T74iq85j6hXNQhtm78LBA0/G9h9MAa9bdrELL4/6/F7CO/2ZBVm/IXY4
	 /qfFM5vVT7viU2xW+s0j5izNZQ0zmtuVpqj28YyAu8EBP4C6YVCPgyBR7QuKjAxoM0
	 /5mPUrrvsuqoQ==
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
 <87ttk0d2ck.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240417-finster-kichern-31077915c0be@brauner>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, hch@infradead.org, david@fromorbit.com, tytso@mit.edu,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
Subject: Re: [PATCH v4 0/9] xfs/iomap: fix non-atomic clone operation and
 don't update size when zeroing range post eof
Date: Thu, 18 Apr 2024 15:00:11 +0530
In-reply-to: <20240417-finster-kichern-31077915c0be@brauner>
Message-ID: <87bk67t3ts.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17, 2024 at 01:40:36 PM +0200, Christian Brauner wrote:
> On Wed, Apr 17, 2024 at 10:12:10AM +0530, Chandan Babu R wrote:
>> On Wed, Mar 20, 2024 at 07:05:39 PM +0800, Zhang Yi wrote:
>> > Changes since v3:
>> >  - Improve some git message comments and do some minor code cleanup, no
>> >    logic changes.
>> >
>> > Changes since v2:
>> >  - Merge the patch for dropping of xfs_convert_blocks() and the patch
>> >    for modifying xfs_bmapi_convert_delalloc().
>> >  - Reword the commit message of the second patch.
>> >
>> > Changes since v1:
>> >  - Make xfs_bmapi_convert_delalloc() to allocate the target offset and
>> >    drop the writeback helper xfs_convert_blocks().
>> >  - Don't use xfs_iomap_write_direct() to convert delalloc blocks for
>> >    zeroing posteof case, use xfs_bmapi_convert_delalloc() instead.
>> >  - Fix two off-by-one issues when converting delalloc blocks.
>> >  - Add a separate patch to drop the buffered write failure handle in
>> >    zeroing and unsharing.
>> >  - Add a comments do emphasize updating i_size should under folio lock.
>> >  - Make iomap_write_end() to return a boolean, and do some cleanups in
>> >    buffered write begin path.
>> >
>> > This patch series fix a problem of exposing zeroed data on xfs since the
>> > non-atomic clone operation. This problem was found while I was
>> > developing ext4 buffered IO iomap conversion (ext4 is relying on this
>> > fix [1]), the root cause of this problem and the discussion about the
>> > solution please see [2]. After fix the problem, iomap_zero_range()
>> > doesn't need to update i_size so that ext4 can use it to zero partial
>> > block, e.g. truncate eof block [3].
>> >
>> > [1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
>> > [2] https://lore.kernel.org/linux-ext4/9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com/
>> > [3] https://lore.kernel.org/linux-ext4/9c9f1831-a772-299b-072b-1c8116c3fb35@huaweicloud.com/
>> >
>> > Thanks,
>> > Yi.
>> >
>> > Zhang Yi (9):
>> >   xfs: match lock mode in xfs_buffered_write_iomap_begin()
>> >   xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
>> >   xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
>> >   xfs: convert delayed extents to unwritten when zeroing post eof blocks
>> >   iomap: drop the write failure handles when unsharing and zeroing
>> >   iomap: don't increase i_size if it's not a write operation
>> >   iomap: use a new variable to handle the written bytes in
>> >     iomap_write_iter()
>> >   iomap: make iomap_write_end() return a boolean
>> >   iomap: do some small logical cleanup in buffered write
>> >
>> 
>> Hi all,
>> 
>> I have picked up this patchset for inclusion into XFS' 6.10-rc1 patch
>> queue. Please let me know if there are any objections.
>
> It'd be nice if I could take the iomap patches into the vfs.iomap tree
> that you can then pull from if you depend on it.. There's already some
> cleanups in there. Sounds ok?

Yes, that works for me. I will pick only those patches that are specific to
XFS i.e. patches numbered 1 to 4.

-- 
Chandan

