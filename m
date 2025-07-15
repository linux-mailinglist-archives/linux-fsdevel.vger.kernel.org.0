Return-Path: <linux-fsdevel+bounces-54945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D2B058F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69284188C727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5B2D94AF;
	Tue, 15 Jul 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHTlVTTY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B42D878C;
	Tue, 15 Jul 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579365; cv=none; b=RXtWrVznzPAsU4iAkRlNZlSKyJaf2yWNdX/TO0YZ4qU7Omyir7763GDJ7RmvHQ96Uf2OhM5Ydu9c2DebGsCUlio0fDCHrdazz9SZ/dTj9WdoOAJhLyx9RMtmSqxgPHd5M6ZTHXhzE2s7uxja6MLxZs1MIRIXCzGnvOUHxpw5vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579365; c=relaxed/simple;
	bh=4DFIF1EYyx+hUN+VqC/2Rk28I0elEVqiMl8SAkUsR8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knu5d+B+zr61e+HQlK5YSaNUdDuHTq4am52V0CfNS0YnVMFljK4jVnhqeYYE/SzOfQ62tjljRwjnrGCVQikIXSD7RmYJ02qHHzHv1lFtbBWHWQdXvfX09XGposXaqeZLZcntrf5XQb4jRybOVzP6pSTOxdNOyiQEuvxtuS3zEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHTlVTTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B1CC4CEE3;
	Tue, 15 Jul 2025 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752579365;
	bh=4DFIF1EYyx+hUN+VqC/2Rk28I0elEVqiMl8SAkUsR8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHTlVTTYLrt7Ir1ZLubNi6ULL1EyRG3ssnD2hL+UA6QeIin4qhOHi7kKMiLe14MR8
	 5T+IAEehfFJLBhp1gi5tJ+u8TW3gi9+5NfZ+QPxkLEfUWwud4hr6suIGaxwde4n/W+
	 WEnl756SThcv9CaKg/tW4dXWIm+h1vqqLyIB59UAmw4b3px6sLOAC/1F1W0nBNZejG
	 xz0xLmHqp3f3zrQCwutRqDvkPZe3suA0Ve4Ki1JzIqPh3ZXxkOxBF0F65Y/uJTmGe8
	 aOkVjdlXCk7tfwzInrogx9VTnIkvDj/QkJ7qMBJDPmhHJnYJPJ3mBiIMOMt/Cm7br2
	 Nrnu5aH0pef5g==
Date: Tue, 15 Jul 2025 13:36:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH v5 6/6] btrfs: implement remove_bdev and shutdown super
 operation callbacks
Message-ID: <20250715-gastwirtschaft-halbpension-3a7c1f34fd25@brauner>
References: <cover.1752470276.git.wqu@suse.com>
 <85faf081c038c5c4a501529b5ed52deea69c58ce.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85faf081c038c5c4a501529b5ed52deea69c58ce.1752470276.git.wqu@suse.com>

On Mon, Jul 14, 2025 at 02:56:02PM +0930, Qu Wenruo wrote:
> For the ->remove_bdev() callback, btrfs will:
> 
> - Mark the target device as missing
> 
> - Go degraded if the fs can afford it
> 
> - Return error other wise
>   Thus falls back to the shutdown callback
> 
> For the ->shutdown callback, btrfs will:
> 
> - Set the SHUTDOWN flag
>   Which will reject all new incoming operations, and make all writeback
>   to fail.
> 
>   The behavior is the same as the NOLOGFLUSH behavior.
> 
> To support the lookup from bdev to a btrfs_device,
> btrfs_dev_lookup_args is enhanced to have a new @devt member.
> If set, we should be able to use that @devt member to uniquely locating a
> btrfs device.
> 
> I know the shutdown can be a little overkilled, if one has a RAID1
> metadata and RAID0 data, in that case one can still read data with 50%
> chance to got some good data.
> 
> But a filesystem returning -EIO for half of the time is not really
> considered usable.
> Further it can also be as bad as the only device went missing for a single
> device btrfs.
> 
> So here we go safe other than sorry when handling missing device.
> 
> And the remove_bdev callback will be hidden behind experimental features
> for now, the reasons are:
> 
> - There are not enough btrfs specific bdev removal test cases
>   The existing test cases are all removing the only device, thus only
>   exercises the ->shutdown() behavior.
> 
> - Not yet determined what's the expected behavior
>   Although the current auto-degrade behavior is no worse than the old
>   behavior, it may not always be what the end users want.
> 
>   Before there is a concrete interface, better hide the new feature
>   from end users.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/super.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c |  2 ++
>  fs/btrfs/volumes.h |  5 ++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 466d0450269c..79f6ad1d44de 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2413,6 +2413,68 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +static int btrfs_remove_bdev(struct super_block *sb, struct block_device *bdev)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> +	struct btrfs_device *device;
> +	struct btrfs_dev_lookup_args lookup_args = { .devt = bdev->bd_dev };
> +	bool can_rw;
> +
> +	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> +	device = btrfs_find_device(fs_info->fs_devices, &lookup_args);
> +	if (!device) {
> +		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> +		/* Device not found, should not affect the running fs, just give a warning. */
> +		btrfs_warn(fs_info, "unable to find btrfs device for block device '%pg'",
> +			   bdev);
> +		return 0;
> +	}

I got very confused when reviewing this questioning myself how this is
going to work... until I pulled btrfs/for-next. It would've been good to
know that you merged patches to do bdev_file_open_by_*() calls with the
superblock as owner and fs_holder_ops set. Very good to see this! Thanks
everyone!

So I can now go delete the whole paragraph I had about that. :)

