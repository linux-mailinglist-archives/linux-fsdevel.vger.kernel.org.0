Return-Path: <linux-fsdevel+bounces-50596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DEACD8DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D43A5078
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FDF231A57;
	Wed,  4 Jun 2025 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WInDx0va"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643422156D;
	Wed,  4 Jun 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023596; cv=none; b=mE8S68I2Tua+ZGQKrQ14DxRF+ur3mSrx3mLK4gXkYMjoyAHDvUGREXZDnRwWaF2Lrpd10y+31SYzJYn/wZtpLgg4Yaqhonn2SK+p6CJ1CMKqZPt12xIrP8KfIoyOCVPHo689clvzYfRp+VXEX97ojxpMMtgGRrB3WQArpxWmF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023596; c=relaxed/simple;
	bh=PA9ira8hxUqCFddTCYMY9Tjyt3g1sldkLEl+jTQLv5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kak4vlzKMDzz9zE3pIiTai2omDoVfLRK3Xbhs4FYvYUqbFtnNP+/SOiEqGXM7gfZQ8VT/1Vo5Y6hIZ02qN+5uqz5uRad/CLGm3zOZvY6bn8FEhYxVROCNnYk2QzqvV6HORxuqtZQIbimUj1SGWqs5g4/On+WTBwiF/eYuLwBLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WInDx0va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BB9C4CEE7;
	Wed,  4 Jun 2025 07:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749023595;
	bh=PA9ira8hxUqCFddTCYMY9Tjyt3g1sldkLEl+jTQLv5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WInDx0vahZXXNL8INqdUd2DVHYwcHYNPO9H00hE10t+5LQFBb7UxLvoB6cXCQWDG1
	 u4rnarlm+YR8zJzP7vpLRTlyaEV6AbjIVLQXT0I46KEMDKs3Z6nHvjqWcQn6ti6PnJ
	 WBSyKJr00ge/o6EeEooYE3FkRhhRYLtFf+LKpD3e+O03FXpb1QWe0Vi8FPCNmX/Tsc
	 SvBbWW3gBh17i+Xj4LoOcuJaJDSXBjpOcG34F4AxkVwZxUtk2pO8jukn5ZJzK2R4Sp
	 vHpBHs+Et5gZOFyh4X9Dh23FHr0z1GXgHW/zCfzD6ComqnuyO7tzz3hLIu7BUJMAl9
	 1PMzx/evjqyPg==
Date: Wed, 4 Jun 2025 09:53:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Anuj gupta <anuj1072538@gmail.com>, hch@infradead.org
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, jack@suse.cz, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
Message-ID: <20250604-notgedrungen-korallen-5ffd76cb7329@brauner>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com>
 <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
 <20250529175934.GB3840196@google.com>
 <20250530-raumakustik-herren-962a628e1d21@brauner>
 <CACzX3Av0uR5=zOXuTvcu2qovveYSmeVPnsDZA1ZByx2KLNJzEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzX3Av0uR5=zOXuTvcu2qovveYSmeVPnsDZA1ZByx2KLNJzEA@mail.gmail.com>

On Wed, Jun 04, 2025 at 12:13:38AM +0530, Anuj gupta wrote:
> > Hm, I wonder whether we should just make all of this an extension of the
> > new file_getattr() system call we're about to add instead of adding a
> > separate ioctl for this.
> 
> Hi Christian,
> Thanks for the suggestion to explore file_getattr() for exposing PI
> capabilities. I spent some time evaluating this path.
> 
> Block devices don’t implement inode_operations, including fileattr_get,
> so invoking file_getattr() on something like /dev/nvme0n1 currently
> returns -EOPNOTSUPP.  Supporting this would require introducing
> inode_operations, and then wiring up fileattr_get in the block layer.
> 
> Given that, I think sticking with an ioctl may be the cleaner approach.
> Do you see this differently?

Would it be so bad to add custom inode operations?
It's literally just something like:

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..9b4f76e2afca 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -453,6 +453,11 @@ void __init bdev_cache_init(void)
        blockdev_superblock = blockdev_mnt->mnt_sb;   /* For writeback */
 }

+static const struct inode_operations bdev_inode_operations = {
+       .fileattr_get   = bdev_file_attr_get,
+       .fileattr_set   = bdev_file_attr_set,
+}
+
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 {
        struct block_device *bdev;
@@ -462,6 +467,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
        if (!inode)
                return NULL;
        inode->i_mode = S_IFBLK;
+       inode->i_op = &bdev_inode_operations;
        inode->i_rdev = 0;
        inode->i_data.a_ops = &def_blk_aops;
        mapping_set_gfp_mask(&inode->i_data, GFP_USER);


instead of using empty_iops.

