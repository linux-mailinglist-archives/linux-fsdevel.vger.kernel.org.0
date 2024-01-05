Return-Path: <linux-fsdevel+bounces-7440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C08824E81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 07:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4D5B217E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7681DFD1;
	Fri,  5 Jan 2024 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VzS7OQo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37711D690;
	Fri,  5 Jan 2024 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dSHA2/+sx7Ginf1zZQjwMoxOOLN3aAKl+o5J049zcoQ=; b=VzS7OQo05vKzjkbMgtDbyoqlq1
	xMjqJoHMrYZx0z8X2pzLagECzGMwlohl9ymKqBvvmtpDIlsWY6AG4N/f1Z7a0npjBNyE4ZwknljfO
	Adoqi4XTmVgFGXh4zBStmNMnqV7aBBtXocYkaX6HML2N7/QqnRhhdS2TWAoeezhinIAaanN7Ej7dv
	hxVnm2Vk5habqISRNzPmh9q8JmfV7hW/bJTp3S/nkUAXM07TMl3K+hndw/tt6Sa2uemEb90WWvc6e
	e9D7SiAdy2v6KE4fIeq1gb230I0mhq6ROH5a4jotGgz0Zrj+acjX4nO0JO/pnPZhJ1+dxysUg9Aw0
	JvaSlTvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLdPN-00G2Yc-1R;
	Fri, 05 Jan 2024 06:10:17 +0000
Date: Thu, 4 Jan 2024 22:10:17 -0800
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
Subject: Re: [PATCH RFC v3 for-6.8/block 04/17] mtd: block2mtd: use bdev apis
Message-ID: <ZZedSYAedA05Oex2@infradead.org>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-5-yukuai1@huaweicloud.com>
 <20240104112855.uci45hhqaiitmsir@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104112855.uci45hhqaiitmsir@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 04, 2024 at 12:28:55PM +0100, Jan Kara wrote:
> What do you think? Because when we are working with the folios it is rather
> natural to use their mapping for dirty balancing?

The real problem is that block2mtd pokes way to deep into block
internals.

I think the saviour here is Christians series to replace the bdev handle
with a struct file, which will allow to use the normal file write path
here and get rid of the entire layering volation.


