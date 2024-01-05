Return-Path: <linux-fsdevel+bounces-7439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B6824E6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 07:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77AAB23A8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 06:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8611C687;
	Fri,  5 Jan 2024 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e70OEnap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53483566A;
	Fri,  5 Jan 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MfpbILepFAZMB7h2HpBoL7ju9YNJfneelNa0zdsWGTE=; b=e70OEnapxROCnryMJ+/p/ZRb6q
	Co5Z26/TzQb4j3uqh1HZXPyKmCgH2RwmGzkFPqv/2KSdkod23+EEjl5k+gUFVeqhE5cLIgjhrZRln
	/TXAnczuvmS/5fv3lonygpNZAr1rkpjLeOKpUo4IcO+WT8eqyhpsxuK7Ezd7daqbCvaeMhieEDC36
	2YdiX92FOcKP4zmjzJggSzAOI+XBEn3tUqKwk8TRuVaK3ZW0yVd/FMa71m8GX6rJkaQu4CkxJRsNW
	K9G8CtK6Nzof6XV0ra5vX4twK05qlkoQTCHmArqOs9K34hsqfqleQt54ZZt7JnrErtkJGz1qKQ4DI
	JcEjMrNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLdNq-00G2Lb-1Y;
	Fri, 05 Jan 2024 06:08:42 +0000
Date: Thu, 4 Jan 2024 22:08:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
	joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org,
	chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.com, konishi.ryusuke@gmail.com, willy@infradead.org,
	akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-nilfs@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 02/17] xen/blkback: use bdev api in
 xen_update_blkif_status()
Message-ID: <ZZec6mX1vz4ayRq1@infradead.org>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-3-yukuai1@huaweicloud.com>
 <20240104110631.3vspsvxbbvcpdqdu@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104110631.3vspsvxbbvcpdqdu@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 04, 2024 at 12:06:31PM +0100, Jan Kara wrote:
> This function uses invalidate_inode_pages2() while invalidate_bdev() ends
> up using mapping_try_invalidate() and there are subtle behavioral
> differences between these two (for example invalidate_inode_pages2() tries
> to clean dirty pages using the ->launder_folio method). So I think you'll
> need helper like invalidate_bdev2() for this.

That assues that the existing code actually does this intentionally,
which seems doubtful.  But the change in behavior does not to be
documented and explained.


