Return-Path: <linux-fsdevel+bounces-1101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC0D7D5501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160A6281AB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295830CF1;
	Tue, 24 Oct 2023 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFUggP7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77A2C84D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B616C433C9;
	Tue, 24 Oct 2023 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698160452;
	bh=q7cSG3gpGdVICKJoxAd8b2GRgGxy99uiBzk+sdK1PKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFUggP7ntXaGMNYshu5p3+d1jMTW2TINRZRRT7qG6CH1DMSx4vGWoITm5JbFjq0yM
	 h5EKVq6xDqzx8/HfhbnuLcV8OdNIC/RfCH013G7RVW6ohDhmJepmDaSnH55ojE9ONb
	 WVcI8FTzpPkhFm0BUENMne4QWz1xVFZ9uLpXx7aM9IddIGTKZWMdygzevOKvfD4vju
	 ev3AvQOVjoLQt76Hlw/2P8eu3vohwdJzDdSptDHYaGFNb8JdE45CTG7Emgy3L42Jfe
	 HptddYY01humVKQYTXHvfPYjBa8KyP0CgPuvpu/RVEoR53ZMROmhIuc/tuwspahetO
	 AYJHqlnujf3Ig==
Date: Tue, 24 Oct 2023 08:14:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] bdev: surface the error from sync_blockdev()
Message-ID: <20231024151411.GE11424@frogsfrogsfrogs>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-3-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-3-599c19f4faac@kernel.org>

On Tue, Oct 24, 2023 at 03:01:09PM +0200, Christian Brauner wrote:
> When freeze_super() is called, sync_filesystem() will be called which
> calls sync_blockdev() and already surfaces any errors. Do the same for
> block devices that aren't owned by a superblock and also for filesystems
> that don't call sync_blockdev() internally but implicitly rely on
> bdev_freeze() to do it.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yessss less EIO munching in the VFS layer!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  block/bdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index d674ad381c52..a3e2af580a73 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -245,7 +245,7 @@ int bdev_freeze(struct block_device *bdev)
>  	bdev->bd_fsfreeze_sb = sb;
>  
>  sync:
> -	sync_blockdev(bdev);
> +	error = sync_blockdev(bdev);
>  done:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
> 
> -- 
> 2.34.1
> 

