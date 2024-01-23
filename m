Return-Path: <linux-fsdevel+bounces-8621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624C839A6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 21:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994601F28600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7B65C9A;
	Tue, 23 Jan 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJFPPpPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BD522C
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042354; cv=none; b=o8dw7aVVDrL1NJGfDwHA6kguPpElin4OnjHjVZD8aj6w/McLhXdD0I7meQ0CoLiavem1uk4tWsEJHMfEVCuevmnccGrt8spyWmMLjQ/a85zGGPEPK0zOdgsZ1aB886aYGeB0Y8U63UULc7gTSzwf4+7AHdS+CHcKlmboG346VGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042354; c=relaxed/simple;
	bh=AKvnUEhfVuCU8VrVyAXnPsxlke6MhfWDzU9qTo+VAk8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i9f023f2UY8/lmxZOabJWr2JIT4uPpsElsQh7qiwQ6//7YD9Eps8fq9x+M4hLxFM1OBqlsx2rjB1Fh9K+nGsJO7pVEOIO7HcMTf2M/BSTzCX/MlFeNMYR6sWkdxVCXGYhXemAu+Cg1kXWhUGt76Ac4squI8WK/lqYXNohrJroto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJFPPpPk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706042352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZviQqgVcq2tRc3p4TWEA+VfgMFTGON5OotgVwwOHF4=;
	b=aJFPPpPk2Xn9pFFTreWagiCPH81mEwYaWr58enNhSxInmtwXUKl7Ho98T9lOwffS3dhTlU
	6LMjc/4YpN+5ji1R0dtb280DTlpo/afi0q1/N+HOqluC+oILho0qW+t79ehMBicVYmoGGY
	wzObYO0gdnOykHgoiDbmAyum7CsN7wo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-4b7BRzuFOe-EJjmvnNvwOg-1; Tue, 23 Jan 2024 15:39:04 -0500
X-MC-Unique: 4b7BRzuFOe-EJjmvnNvwOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 088278828C2;
	Tue, 23 Jan 2024 20:39:03 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2462026D66;
	Tue, 23 Jan 2024 20:39:02 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D9D7030A79CB; Tue, 23 Jan 2024 20:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D72613FB4E;
	Tue, 23 Jan 2024 21:39:02 +0100 (CET)
Date: Tue, 23 Jan 2024 21:39:02 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
cc: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
    Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
    David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
    Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
    linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, 
    linux-nvme@lists.infradead.org, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
In-Reply-To: <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
Message-ID: <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com> <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4



On Tue, 23 Jan 2024, Johannes Thumshirn wrote:

> Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
> zonefs_zone_mgmt().
> 
> As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
> from a place that can recurse back into the filesystem on memory reclaim,
> it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 93971742613a..63fbac018c04 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
>  
>  	trace_zonefs_zone_mgmt(sb, z, op);
>  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
> -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
> +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
>  	if (ret) {
>  		zonefs_err(sb,
>  			   "Zone management operation %s at %llu failed %d\n",
> 
> -- 
> 2.43.0

zonefs_inode_zone_mgmt calls 
lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex); - so, this 
function is called with the mutex held - could it happen that the 
GFP_KERNEL allocation recurses into the filesystem and attempts to take 
i_truncate_mutex as well?

i.e. GFP_KERNEL -> iomap_do_writepage -> zonefs_write_map_blocks -> 
zonefs_write_iomap_begin -> mutex_lock(&zi->i_truncate_mutex)

Mikulas


