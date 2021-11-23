Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C349C45AFDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhKWXQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:16:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233989AbhKWXQf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:16:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE20260FC3;
        Tue, 23 Nov 2021 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637709206;
        bh=S/IswOJvRGBagLJRqzKcshhJ4v7k/vBIf4Vs4dGT10g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xkg5cXpSDqabGeFWq7rmygKLTwImdF/9Sn8heQe42R/Yl8XGgY+AtzzmXPkUQcdes
         4zRZL+6+IKzGfg8DyRHpUlMflgVYZ/a0qcsQEyYMUOQSt8H1PN4K/4ljnF008ROVTO
         Wg2Yd6TaoIuT1rAuP4MQ5LHhkZR3MdspZQIYDo/j0RNRprZ6410ZDfRsvNNn/3BD0+
         BoXvZo3OFj7dm6LvkaiMpI52H2gbmIFDE7KYsgtFIOJtVx6wi7KK5ENEEMdlQFU1kG
         B8pfwvl1QCAx3g0SlZH2FEStKzn7XwOOnWr83DmLf696ZJnUywGpWhj7Qom2caz144
         ti5mzeKHYeHAw==
Date:   Tue, 23 Nov 2021 15:13:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 28/29] iomap: build the block based code conditionally
Message-ID: <20211123231325.GV266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-29-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:33:08AM +0100, Christoph Hellwig wrote:
> Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
> that is always the case, but it will change soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/Kconfig        | 4 ++--
>  fs/iomap/Makefile | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a6313a969bc5f..6d608330a096e 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -15,11 +15,11 @@ config VALIDATE_FS_PARSER
>  	  Enable this to perform validation of the parameter description for a
>  	  filesystem when it is registered.
>  
> -if BLOCK
> -
>  config FS_IOMAP
>  	bool
>  
> +if BLOCK
> +
>  source "fs/ext2/Kconfig"
>  source "fs/ext4/Kconfig"
>  source "fs/jbd2/Kconfig"
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index 4143a3ff89dbc..fc070184b7faa 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -9,9 +9,9 @@ ccflags-y += -I $(srctree)/$(src)		# needed for trace events
>  obj-$(CONFIG_FS_IOMAP)		+= iomap.o
>  
>  iomap-y				+= trace.o \
> -				   buffered-io.o \
> +				   iter.o
> +iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
>  				   direct-io.o \
>  				   fiemap.o \
> -				   iter.o \
>  				   seek.o
>  iomap-$(CONFIG_SWAP)		+= swapfile.o
> -- 
> 2.30.2
> 
