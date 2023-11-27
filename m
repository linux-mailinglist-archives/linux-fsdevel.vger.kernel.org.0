Return-Path: <linux-fsdevel+bounces-3959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F07FA687
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD1B21453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896DF374D9;
	Mon, 27 Nov 2023 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3w8bJekj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80128D4B;
	Mon, 27 Nov 2023 08:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N2zDXv8N842SdWeP1QfvmzEvIcEsyQplx8msSV1RBzc=; b=3w8bJekjauD14xkhiSXsSeP1yp
	9N3b2DKZZPdBt27xj1DIEE7RXLXZrvHxDKR2sRYD21pNAAIJ3vl1ZCKZ4NFvv5G6xjzqey6N1n0KK
	ZrI0nakNUBsMEbW2Q4e4j1NRh5OeO1tyxIFUhlV8EaqwcQbah9MgH17+QPadh0DqL/pm4sqZ5f/vV
	IH1EMWIP6up9ybGx4dw0MvcLdLRClPIEOMfWizJpOcO8WEMAVnlOuY5kgUVe2HK2Xt75AhDq2qkmf
	jzAFQBFfr3qP/5tAASIdgOPBH9JmPj2A8s0x9fJ50RYVccYl2K4OsZZ71u82sMqjEZ1B5f5BIa6y8
	Lia9qiAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eXO-0030D4-22;
	Mon, 27 Nov 2023 16:32:46 +0000
Date: Mon, 27 Nov 2023 08:32:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, ming.lei@redhat.com,
	axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
	konishi.ryusuke@gmail.com, dchinner@redhat.com,
	linux@weissschuh.net, min15.li@samsung.com, dlemoal@kernel.org,
	willy@infradead.org, akpm@linux-foundation.org, hare@suse.de,
	p.raghav@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH block/for-next v2 01/16] block: add a new helper to get
 inode from block_device
Message-ID: <ZWTErvnMf7HiO1Wj@infradead.org>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-2-yukuai1@huaweicloud.com>
 <ZWRDeQ4K8BiYnV+X@infradead.org>
 <6acdeece-7163-3219-95e2-827e54eadd0c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acdeece-7163-3219-95e2-827e54eadd0c@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 27, 2023 at 09:07:22PM +0800, Yu Kuai wrote:
> 1) Is't okay to add a new helper to pass in bdev for following apis?


For some we already have them (e.g. bdev_nr_bytes to read the bdev)
size, for some we need to add them.  The big thing that seems to
stick out is page cache API, and I think that is where we need to
define maintainable APIs for file systems and others to use the
block device page cache.  Probably only in folio versions and not
pages once if we're touching the code anyay

> 2) For the file fs/buffer.c, there are some special usage like
> following that I don't think it's good to add a helper:
> 
> spin_lock(&bd_inode->i_mapping->private_lock);
> 
> Is't okay to move following apis from fs/buffer.c directly to
> block/bdev.c?
> 
> __find_get_block
> bdev_getblk

I'm not sure moving is a good idea, but we might end up the
some kind of low-level access from buffer.c, be that special
helpers, a separate header or something else.  Let's sort out
the rest of the kernel first.


