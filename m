Return-Path: <linux-fsdevel+bounces-5683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA81D80ED77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0071C20C89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BF61FBC;
	Tue, 12 Dec 2023 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="picipgXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059CCB3;
	Tue, 12 Dec 2023 05:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b0EJSjGbwEr2b4Ml7A+chJ8+pEiLc4/B8ooSTDiYxzk=; b=picipgXFbvzoUhEoBG/zPnQX1q
	HE6smIRBy5a89R9akhr+qXOZgV2ZWsX5XPLxtAEgCavvFg2RD1Nd4bY6y3UtqlfS5bvjWd1FYs03a
	CEKxQcI96bW9kVZcHP+cYaV8hEgMc7fElg/c9Fc75ryish62M2PDTmzUmPs5fvjFZ8ka06osdMRpf
	ASMKxc6mHhCj37Uwwthec0X8EOQOG/hGGGWoR9QRV2Bnh4w97sL+F2xaXO4b3Qr1y31RDun14/d27
	LpamT9Qvnaapt6jca0mzWu9EovPM8+74IynFRKTN08S2sDe2pXO4Td8t8oHiM29FNbbe9flIcdz3n
	3xcYUrag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rD2lJ-00BnAr-2I;
	Tue, 12 Dec 2023 13:25:25 +0000
Date: Tue, 12 Dec 2023 05:25:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
	konishi.ryusuke@gmail.com, willy@infradead.org,
	akpm@linux-foundation.org, p.raghav@samsung.com, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 for-6.8/block 15/18] buffer: add a new helper to
 read sb block
Message-ID: <ZXhfRdocHfrViOos@infradead.org>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140753.975297-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211140753.975297-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 11, 2023 at 10:07:53PM +0800, Yu Kuai wrote:
> +static __always_inline int buffer_uptodate_or_error(struct buffer_head *bh)
> +{
> +	/*
> +	 * If the buffer has the write error flag, data was failed to write
> +	 * out in the block. In this case, set buffer uptodate to prevent
> +	 * reading old data.
> +	 */
> +	if (buffer_write_io_error(bh))
> +		set_buffer_uptodate(bh);
> +	return buffer_uptodate(bh);
> +}

So - risking this blows up into a lot of nasty work: Why do we even
clear the uptodate flag on write errors?  Doing so makes not sense to
me as the data isn't any less uptodate just because we failed to write
it..


