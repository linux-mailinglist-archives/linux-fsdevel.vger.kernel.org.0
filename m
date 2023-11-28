Return-Path: <linux-fsdevel+bounces-4011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34FE7FB18B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 06:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC9281E2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 05:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5516111AD;
	Tue, 28 Nov 2023 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zxF6+s0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D249C4;
	Mon, 27 Nov 2023 21:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=piX6sU8uUfRdM3HI4C5o5RtKyEk7LebUsWmX5nAnS9s=; b=zxF6+s0SCn2mTM1F5sDGatwdiD
	r+J5EdNg/JbVc8/TEwBGrSiUOrPltOv0SB5DHqEzye3x5UYQ3y43F+9CYP+YH9zZju4MAnIxN7jLr
	52H6aTiRg9m6ogsTbJ455qxXjn6rKf3EheShZA+8TlQ0nbft+l3Lre4a0bU7FkEs+H18O/xb4HfZ2
	DcIkdp3IB1Vc74yjq/SGmA7ZBc/H0ChYb2skCnNlw+1loprwzCvOOZXqJXWMJW983aVx/FvifwWE8
	GXy6mVkavESjy4cQk0Ees741WqX1/u5t1i6oo5VnA69qG8fgQUNZnB/k4V2ZDGbJGb/SxQnB+AlVf
	iSo+n9HA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7qxI-004BPZ-2N;
	Tue, 28 Nov 2023 05:48:20 +0000
Date: Mon, 27 Nov 2023 21:48:20 -0800
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
Message-ID: <ZWV/JBxrrGXzY0gr@infradead.org>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-2-yukuai1@huaweicloud.com>
 <ZWRDeQ4K8BiYnV+X@infradead.org>
 <6acdeece-7163-3219-95e2-827e54eadd0c@huaweicloud.com>
 <ZWTErvnMf7HiO1Wj@infradead.org>
 <bc64da80-e9bd-84cb-f173-876623303131@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc64da80-e9bd-84cb-f173-876623303131@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 28, 2023 at 09:35:56AM +0800, Yu Kuai wrote:
> Thanks for the advice! In case I'm understanding correctly, do you mean
> that all other fs/drivers that is using pages versions can safely switch
> to folio versions now?

If you never allocate a high-order folio pages are identical to folios.
So yes, we can do folio based interfaces only, and also use that as
an opportunity to convert over the callers.

> By the way, my orginal idea was trying to add a new field 'bd_flags'
> in block_devcie, and then add a new bit so that bio_check_ro() will
> only warn once for each partition. Now that this patchset will be quite
> complex, I'll add a new bool field 'bd_ro_warned' to fix the above
> problem first, and then add 'bd_flags' once this patchset is done.

Yes, please do a minimal version if you can find space where the
rmw cycles don't cause damage to neighbouring fields.  Or just leave
the current set of warnings in if it's too hard.


