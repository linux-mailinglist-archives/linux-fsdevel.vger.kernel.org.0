Return-Path: <linux-fsdevel+bounces-3900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00E7F9A2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED7F1C208C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A74DF53;
	Mon, 27 Nov 2023 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X33IAizB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA800133;
	Sun, 26 Nov 2023 22:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PRdjsHwBJnTnCFJ6KWMNGkw3R1XwKUQdbL+BMJT0K70=; b=X33IAizBXxOu44K+tKNOQcX6aN
	L3R58WnMzMuH49yXIvG7omqQGa3O2DELuiG9T0RDZfJfL9RxoTFv7kUL42tZGssHxvodfBhu53zAl
	oziCAbD1I4rfcGgYF7+pmO1j4z7VlfcJSt54k/bu5RznWMw8UGAKzI85OeNE+/rj2cbLblF4OE6VJ
	eTO7WwvbpkhSAH2j8YC9xxeFsHPww+97YyGIXXbr6H0E8B8/2bjSezQMUryHuqSaucYpxVB9Oms42
	fJOuOXLDq1bOpbdO9PADT2+G/2FCegqrb+HsEfhKX3cA8yGKyYkW0zp9+6loKz3FcpZ/JElMbJsDK
	wQbg0j1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7VP7-003r7k-26;
	Mon, 27 Nov 2023 06:47:37 +0000
Date: Mon, 27 Nov 2023 06:47:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, ming.lei@redhat.com, axboe@kernel.dk,
	roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
	joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
	konishi.ryusuke@gmail.com, dchinner@redhat.com,
	linux@weissschuh.net, min15.li@samsung.com, yukuai3@huawei.com,
	dlemoal@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
	hare@suse.de, p.raghav@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH block/for-next v2 00/16] block: remove field 'bd_inode'
 from block_device
Message-ID: <20231127064737.GH38156@ZenIV>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 27, 2023 at 02:21:00PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>  - split different portions into different patches, as greg k-h
>  suggested.
>  - use container_of() instead of "bdev + 1" to get the address of
>  bd_inode in the new helper, as grep k-h suggested.

You might have misinterpreted gregkh - in your place I would rather
do a one-patch never-rebased branch (introduction of bdev_inode() in
form that returns bdev->bd_inode), with followup in your branch that
switches it to your variant.  Then conversions of ->bd_inode users,
to be either picked by individual filesystems of staying in your branch.
Any filesystem tree could merge from your never-rebased branch, after
which they could switch their ->bd_inode uses to the new helper, without
introducing any bisection hazards or interdependencies.
After the next -rc1, once all ->bd_inode users are gone from the tree -
remove the field.

