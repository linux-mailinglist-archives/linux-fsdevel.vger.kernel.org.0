Return-Path: <linux-fsdevel+bounces-3908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4C7F9AD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536851C208F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63CD107B8;
	Mon, 27 Nov 2023 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HmhTUB6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1092712D;
	Sun, 26 Nov 2023 23:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bbFcmB19INmvUTx5j+M9jRyJXBnU+PmCLplmYes7xKg=; b=HmhTUB6Bgh7OnZuv3MNiTVnfXC
	c22YIG8T5br8hsKMu41mjZ9/cx++C8wVTWDYSvUAH36xMkip5/yiTG260lY2rrIM/r+C0G+isp9uF
	etkeNOURS8fQD6aPmSdyzSSGKWF+pTqcC1ZGT7oZVvUTVk9QpHYUf0FBUrJw19CADdPVngmSrijuO
	IOMUdcJcEkdHTqMAdFx1L+mfGJd3fWDG081TsGYrqYpe4ADrF5w0LuzxW+1HqJjso+aXzjyCht+N2
	tYj8ta2d171C20L5JBM/BAzza5S6Fp5sV5ukto8ZE9jI63+MJW0c2xIdTP/sw0+cxDdqp7qdN9Sak
	f2DjTQ3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Vvt-001iAl-0W;
	Mon, 27 Nov 2023 07:21:29 +0000
Date: Sun, 26 Nov 2023 23:21:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, ming.lei@redhat.com, axboe@kernel.dk,
	roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
	joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org,
	chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	agruenba@redhat.com, jack@suse.com, konishi.ryusuke@gmail.com,
	dchinner@redhat.com, linux@weissschuh.net, min15.li@samsung.com,
	yukuai3@huawei.com, dlemoal@kernel.org, willy@infradead.org,
	akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH block/for-next v2 01/16] block: add a new helper to get
 inode from block_device
Message-ID: <ZWRDeQ4K8BiYnV+X@infradead.org>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127062116.2355129-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 27, 2023 at 02:21:01PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> block_devcie is allocated from bdev_alloc() by bdev_alloc_inode(), and
> currently block_device contains a pointer that point to the address of
> inode, while such inode is allocated together:

This is going the wrong way.  Nothing outside of core block layer code
should ever directly use the bdev inode.  We've been rather sloppy
and added a lot of direct reference to it, but they really need to
go away and be replaced with well defined high level operation on
struct block_device.  Once that is done we can remove the bd_inode
pointer, but replacing it with something that pokes even more deeply
into bdev internals is a bad idea.

