Return-Path: <linux-fsdevel+bounces-29752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A33A97D6CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3562846E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324817BB26;
	Fri, 20 Sep 2024 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B5BH4Ra3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681283BBC1;
	Fri, 20 Sep 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842204; cv=none; b=H/PdavsYYYF/zBelYO+t2qKtITHAGgaCNYcwChwiqySVCD/W7LQQLEJZq8mFsjGn0QeF6xx6AtzGKUfu0C6UTEEQjx3bdBBADAi31AJCD5UOSImsUOAoBRKdmxA3bLz461RrmRjjKfK5LK+ozkmtFK3Hhk5mzVhxvZ/+LzcB0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842204; c=relaxed/simple;
	bh=IbOvxZra/ttTtwAzOHHts614QYQVMb8TCnt/nARtR40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmCZJrOH0NV5OKi3akkMi2kESWh4xHgIE4XlAel9SX9nxel4aL5ulcU0cPtCRbndyZPIHMW1693rltEVXw4BOYIGY6J9vh3dxv3RrsCowQeBX1O4HI173VxLA2AOluhJq4kbWd/hc+suX6iM+NwOuBDWFrlZvfoPYRkvvRDiCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B5BH4Ra3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JPQsXVCbHcj+ARLsuPO/0OQ0gkjAViaYLdgrZgBtEiI=; b=B5BH4Ra3TFUWcMae1/6UliXkg1
	WaxL3lPIKkk0a0orrKPofyYXUh+JQ/nKYjDDHp4bJT35qRR1SsT9Iwo/kwgcft8SiTK5N+3sQsvXu
	G0anZKFj2UrYC69pFSp+beI3+MUr18HXl3xs0tH4y/IEQWYVJ8qkn/a+G4BiF6wgNgsYcRKG71Ann
	ydGDeM797wOICKT+FTMgXzJhvi1AcwrVCNT0xFN5K7BkhL24mY8ErrTrB5fa/GiNFf+k8zQQHm80o
	AqetfvtzVjxcRoCgmFzdUDT2eAsDC0YnKHqClq8AzWUFmcpACBObxQFjh8SsLOHIu/wwuOFC0p6gU
	bTCNVtWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sreXa-0000000CNR2-39rk;
	Fri, 20 Sep 2024 14:23:22 +0000
Date: Fri, 20 Sep 2024 07:23:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	chandan.babu@oracle.com, djwong@kernel.org, stable@vger.kernel.org,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/3] xfs: Do not unshare ranges beyond EOF
Message-ID: <Zu2FWuonuO97Q6V8@infradead.org>
References: <20240920122621.215397-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920122621.215397-1-sunjunchao2870@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 08:26:21PM +0800, Julian Sun wrote:
> Attempting to unshare extents beyond EOF will trigger
> the need zeroing case, which in turn triggers a warning.
> Therefore, let's skip the unshare process if extents are
> beyond EOF.
> 
> Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> Inspired-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/xfs/xfs_reflink.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 6fde6ec8092f..65509ff6aba0 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2016 Oracle.  All Rights Reserved.
>   * Author: Darrick J. Wong <darrick.wong@oracle.com>
>   */
> +#include "linux/fs.h"

This really should not be needed (and is the wrong way to include
non-local headers anyway).

>  #include "xfs.h"
>  #include "xfs_fs.h"
>  #include "xfs_shared.h"
> @@ -1669,6 +1670,9 @@ xfs_reflink_unshare(
>  
>  	if (!xfs_is_reflink_inode(ip))
>  		return 0;
> +	/* don't try to unshare any ranges beyond EOF. */
> +	if (offset + len > i_size_read(inode))
> +		len = i_size_read(inode) - offset;

So i_size is a byte granularity value, but later on iomap_file_unshare
operates on blocks.  If you reduce the value like this here this means
we can't ever unshare the last block of a file if the file size is
not block aligned, which feels odd.


