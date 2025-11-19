Return-Path: <linux-fsdevel+bounces-69107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ADAC6F472
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B1714FA3D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0E34F48A;
	Wed, 19 Nov 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3sqfIua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A873115B5;
	Wed, 19 Nov 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561690; cv=none; b=RvYLF04dG7Jt1UMAwXwz4m75mNIAfIUkbBQ9inf6u0v2WQnlHcH7PBG7mDDYacPxHJUeQ1HNc6h+QgbCyFFiJGvrxmTKR4OywKGuZZklepnbpIJpWqjdoD05rDv95HmDMGu9q/ZxtuHzRLTn9KBQxMwzXC8KIZNpbcbA+ZVnJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561690; c=relaxed/simple;
	bh=sWqA0/SO2+nWkd0Rlx14NWB6yc1F/Reg95odqKwNvyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9MXXvYYHNasOh9Dksoe6FajEg+X9YlDNA1fbmBIMP92hteKr6gVhcefRxYk0K2+lqhaN0kHTR6wdPVRHYTDm6cvJw81VB0Gi2anXZ+5ZFLzfleQWRNlJKtGSC7KqHvAlrrcp+o6jjDIM2CBprslbMaTt0dAK6htKrsvCdZVDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3sqfIua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C03C2BCB3;
	Wed, 19 Nov 2025 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763561686;
	bh=sWqA0/SO2+nWkd0Rlx14NWB6yc1F/Reg95odqKwNvyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3sqfIuaMv7uU8mtPZmxDIknUnIb+crz9yhS4aMye8SyRYvGTaWNnzKw1RM4l/3k8
	 +IfnwXHFoUnx9PHyAVkMRECr956mX7dMfi4iLVUslrpSocXNztjywXUxdAkgdjmDlt
	 wcbJ5sIFsREUyik8ehHDL3BU+ZTXk4tQEa7FagKIgXamVXlrT4+NtKA8tnZ6Np2tfG
	 2jOl3qhSTwNp3Qs6v1SAl1BSFZP+9AU3G6Y+sPPQUq2dsgEMpYqYJmIYGBhWCILJJd
	 TBJ483MzE3SbA6Xhjdvq/Pbsa/6nuXzkjQUn4XmJXNSqY4eZnz9a3EGk8eOKlzC4l/
	 HycNwanspemGw==
Date: Wed, 19 Nov 2025 15:14:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	jack@suse.cz, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
Message-ID: <20251119-delfin-bioladen-6bf291941d4f@brauner>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>

On Wed, Nov 19, 2025 at 08:38:20AM +0100, Mehdi Ben Hadj Khelifa wrote:
> The regression introduced by commit aca740cecbe5 ("fs: open block device
> after superblock creation") allows setup_bdev_super() to fail after a new
> superblock has been allocated by sget_fc(), but before hfs_fill_super()
> takes ownership of the filesystem-specific s_fs_info data.
> 
> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
> are never reached, leaving the HFS mdb structures attached to s->s_fs_info
> unreleased.The default kill_block_super() teardown also does not free 
> HFS-specific resources, resulting in a memory leak on early mount failure.
> 
> Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
> hfs_put_super() and the hfs_fill_super() failure path into a dedicated
> hfs_kill_sb() implementation. This ensures that both normal unmount and
> early teardown paths (including setup_bdev_super() failure) correctly
> release HFS metadata.
> 
> This also preserves the intended layering: generic_shutdown_super()
> handles VFS-side cleanup, while HFS filesystem state is fully destroyed
> afterwards.
> 
> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")

I don't think that's correct.

The bug was introduced when hfs was converted to the new mount api as
this was the point where sb->s_fs_info allocation was moved from
fill_super() to init_fs_context() in ffcd06b6d13b ("hfs: convert hfs to
use the new mount api") which was way after that commit.

I also think this isn't the best way to do it. There's no need to
open-code kill_block_super() at all.

That whole hfs_mdb_get() calling hfs_mdb_put() is completely backwards
and the cleanup labels make no sense - predated anything you did ofc. It
should not call hfs_mdb_put(). It's only caller is fill_super() which
already cleans everything up. So really hfs_kill_super() should just
free the allocation and it should be moved out of hfs_mdb_put().

And that solution is already something I mentioned in my earlier review.
Let me test a patch.

