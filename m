Return-Path: <linux-fsdevel+bounces-17123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293258A823F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD42F1F245DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77113CF8A;
	Wed, 17 Apr 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsWHGaOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F484E15;
	Wed, 17 Apr 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354043; cv=none; b=gSg6hDBbLtfnhGgDvTxuYz5V55AyfojgRzpwGMtEz/C37ry1jbcSXD0shh4KfOzmzQ8Mdd9EJCE5amWE0ThE6uGzeHfJGgn0qeJE2zubAK4TSSgZVEpK+OQCr4DgsjBrlkR4Eba4pt0zhPsr6kU0KCaE1SHfRQOIl2zK8IdnD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354043; c=relaxed/simple;
	bh=L43NnvszKlXz0ZmRg0vx9dxOD8La0sz4qHaBZ0rotZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB69hbOpWVxIEzK7X37Cw/1Pf8smgnPJeGFYtCuCTnfoNWqN5o2343GFjWRDE8Edg9by/YynePsQlP6f95MXHPvB2SkjRIJ/s9y3qFpneM4LE6+ORZxWlaKNWDxSIAErmTMi/bqcj/2PmejGj8SThorle9gfTwyf6Zs7B+zBlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsWHGaOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106D5C072AA;
	Wed, 17 Apr 2024 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713354042;
	bh=L43NnvszKlXz0ZmRg0vx9dxOD8La0sz4qHaBZ0rotZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KsWHGaOuVQdO+3WHAidLoaIDHzCPsv3G9CE/sny7PMLLOv+uQ+BxmvEAT6kpxVINK
	 GpEnsN5vj5V5iooAZ4ouJ+FwA5PbaYrH+CX1pZHLRpsEJZH3zCbUkMzz7Q95FOKGTg
	 IukaDbbshPqvEnKdhyLlMCJh51Wm4s5R5neKQ4ri4JJH8qk1/5YW2BsL5RjlGsggGr
	 hvIWCLTBGFdizQn2golHPkfo69WMCWjgv2NhvNRkFeSEYijORRuPHm6zqlKK4JF2vc
	 Mz1yghTf9nlS6nJf3Lk1UTMzZNJcqDcPOPzK81i0ZKMtgOGCxCopvalPM1HYcHFRQY
	 y28cRshTqMEXw==
Date: Wed, 17 Apr 2024 13:40:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, djwong@kernel.org, 
	hch@infradead.org, david@fromorbit.com, tytso@mit.edu, jack@suse.cz, 
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 0/9] xfs/iomap: fix non-atomic clone operation and
 don't update size when zeroing range post eof
Message-ID: <20240417-finster-kichern-31077915c0be@brauner>
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
 <87ttk0d2ck.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttk0d2ck.fsf@debian-BULLSEYE-live-builder-AMD64>

On Wed, Apr 17, 2024 at 10:12:10AM +0530, Chandan Babu R wrote:
> On Wed, Mar 20, 2024 at 07:05:39 PM +0800, Zhang Yi wrote:
> > Changes since v3:
> >  - Improve some git message comments and do some minor code cleanup, no
> >    logic changes.
> >
> > Changes since v2:
> >  - Merge the patch for dropping of xfs_convert_blocks() and the patch
> >    for modifying xfs_bmapi_convert_delalloc().
> >  - Reword the commit message of the second patch.
> >
> > Changes since v1:
> >  - Make xfs_bmapi_convert_delalloc() to allocate the target offset and
> >    drop the writeback helper xfs_convert_blocks().
> >  - Don't use xfs_iomap_write_direct() to convert delalloc blocks for
> >    zeroing posteof case, use xfs_bmapi_convert_delalloc() instead.
> >  - Fix two off-by-one issues when converting delalloc blocks.
> >  - Add a separate patch to drop the buffered write failure handle in
> >    zeroing and unsharing.
> >  - Add a comments do emphasize updating i_size should under folio lock.
> >  - Make iomap_write_end() to return a boolean, and do some cleanups in
> >    buffered write begin path.
> >
> > This patch series fix a problem of exposing zeroed data on xfs since the
> > non-atomic clone operation. This problem was found while I was
> > developing ext4 buffered IO iomap conversion (ext4 is relying on this
> > fix [1]), the root cause of this problem and the discussion about the
> > solution please see [2]. After fix the problem, iomap_zero_range()
> > doesn't need to update i_size so that ext4 can use it to zero partial
> > block, e.g. truncate eof block [3].
> >
> > [1] https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/
> > [2] https://lore.kernel.org/linux-ext4/9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com/
> > [3] https://lore.kernel.org/linux-ext4/9c9f1831-a772-299b-072b-1c8116c3fb35@huaweicloud.com/
> >
> > Thanks,
> > Yi.
> >
> > Zhang Yi (9):
> >   xfs: match lock mode in xfs_buffered_write_iomap_begin()
> >   xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
> >   xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
> >   xfs: convert delayed extents to unwritten when zeroing post eof blocks
> >   iomap: drop the write failure handles when unsharing and zeroing
> >   iomap: don't increase i_size if it's not a write operation
> >   iomap: use a new variable to handle the written bytes in
> >     iomap_write_iter()
> >   iomap: make iomap_write_end() return a boolean
> >   iomap: do some small logical cleanup in buffered write
> >
> 
> Hi all,
> 
> I have picked up this patchset for inclusion into XFS' 6.10-rc1 patch
> queue. Please let me know if there are any objections.

It'd be nice if I could take the iomap patches into the vfs.iomap tree
that you can then pull from if you depend on it.. There's already some
cleanups in there. Sounds ok?

