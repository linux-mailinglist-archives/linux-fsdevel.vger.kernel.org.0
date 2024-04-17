Return-Path: <linux-fsdevel+bounces-17102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B448A7B68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 06:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F13284082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D62B282E1;
	Wed, 17 Apr 2024 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mzUxtU4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C651170F;
	Wed, 17 Apr 2024 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328542; cv=none; b=vA43f+n3+epl0nCbGg+4eQ3HZPfSYP58cC9PE2tYEAkYFXDIQCcYfAsatQsmwXEREUhHtTqlJIZvQc3vD40Ng+jgV0VTwWl4ERfXSWygEcznDBthWPqtDaQjLndfnZEWojP0pSImi2/cd3DVYTbW1Zzk0Ru9sctW850eRSMz0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328542; c=relaxed/simple;
	bh=+iCfkqjUsgO1ZDGIbFr8GYdF2Rs6z6Z+S4k3UrB9408=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHpu8YnCs1HLy3Jj/iMdRu1ROc3cAUyx5qmcZbp0eFjRGcDAGTeZdZT91neQLWzckeY1rBFCq/7ZQpg9/GVzkzOF7bpLAwhQYg5yFmG5PF4Qq7e+T7QP3TU8ZR2zNh9YCFh4M9prDJGhZ5nG61ZjJ/RlGQUxQLrMXhXdR0k1cDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mzUxtU4l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iXIykWGQJpDXFJ+SQPt3FgFx7ryUGPRR4FBRYWESyMI=; b=mzUxtU4l0NNFUHX5mkoyXWNs8U
	GyEONlam9xOofQDVKIWaFGXjTyicdEu+M9CWxSsgz1+y0DdCcmXUCsqUYcXHbz0RbDk15FgCiVv/Y
	H0RSxN/J0QQ7am8VWK8V0alKv+w1DxQl2VesZTzdPbJNwdgI9uw86qyqj0v/en2FpqDKsWrOaZQnK
	o97xHh/bkoNxY8vNj4c8/JDB/9jKc+08tueOnQ2W+Y5CnrW7OLuqjonJGZoRx/cJ2GYGNJ5DbYIdi
	OgwrhfG/FYajJh2429fYyy4cEmyFEK8hqBqE21ErTCZX13036z7HIu37KaidENnny15/C+9QjCsp8
	U1/XnnAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwx1A-00E2jv-0T;
	Wed, 17 Apr 2024 04:35:32 +0000
Date: Wed, 17 Apr 2024 05:35:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: axboe@kernel.dk
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH][RFC] set_blocksize() in pktcdvd (was Re: [PATCH vfs.all
 22/26] block: stash a bdev_file to read/write raw blcok_device)
Message-ID: <20240417043532.GA3337808@ZenIV>
References: <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
 <20240412112919.GN2118490@ZenIV>
 <20240413-hievt-zweig-2e40ac6443aa@brauner>
 <20240415204511.GV2118490@ZenIV>
 <20240416063253.GA2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416063253.GA2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 16, 2024 at 07:32:53AM +0100, Al Viro wrote:

> drivers/block/pktcdvd.c:2285:           set_blocksize(disk->part0, CD_FRAMESIZE);

	We had hardsect_size set to that 2Kb from the very beginning
(well, logical_block_size these days).	And the first ->open() is
(and had been since before the pktcdvd went into mainline) followed by
setting block size anyway, so any effects of that set_blocksize() had
always been lost.  Candidate block sizes start at logical_block_size...
Rudiment of something from 2000--2004 when it existed out of tree?
<checks>  That logic into the tree in 2.5.13; May 2002...

	AFAICS, this one can be simply removed.  Jens, do you have
any objections to that?  It's safe, but really pointless...

> drivers/block/pktcdvd.c:2529:   set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);

	This, OTOH, is not safe at all - we don't have the underlying device
exclusive, and it's possible that it is in use with e.g. 4Kb block size (e.g.
from ext* read-only mount, with 4Kb blocks).  This set_blocksize() will screw
the filesystem very badly - block numbers mapping to LBA will change, for starters.

	We are setting a pktcdvd device up here, and that set_blocksize()
is done to the underlying device.  It does *not* prevent changes of block
size of the underlying device by the time we actually open the device
we'd set up - set_blocksize() in ->open() is done to pktcdvd device,
not the underlying one.  So... what is it for?

	It might make sense to move it into ->open(), where we do have
the underlying device claimed.	But doing that at the setup time looks
very odd...

	Do you have any objections against this:

commit d1d93f2c26f70fbcd714615d1a3ea7a104fc0f43
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed Apr 17 00:28:03 2024 -0400

    pktcdvd: sort set_blocksize() calls out
    
    1) it doesn't make any sense to have ->open() call set_blocksize() on the
    device being opened - the caller will override that anyway.
    
    2) setting block size on underlying device, OTOH, ought to be done when
    we are opening it exclusive - i.e. as part of pkt_open_dev().  Having
    it done at setup time doesn't guarantee us anything about the state
    at the time we start talking to it.  Worse, if you happen to have
    the underlying device containing e.g. ext2 with 4Kb blocks that
    is currently mounted r/o, that set_blocksize() will confuse the hell
    out of filesystem.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 21728e9ea5c3..05933f25b397 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2215,6 +2215,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 		}
 		dev_info(ddev, "%lukB available on disc\n", lba << 1);
 	}
+	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
 
 	return 0;
 
@@ -2278,11 +2279,6 @@ static int pkt_open(struct gendisk *disk, blk_mode_t mode)
 		ret = pkt_open_dev(pd, mode & BLK_OPEN_WRITE);
 		if (ret)
 			goto out_dec;
-		/*
-		 * needed here as well, since ext2 (among others) may change
-		 * the blocksize at mount time
-		 */
-		set_blocksize(disk->part0, CD_FRAMESIZE);
 	}
 	mutex_unlock(&ctl_mutex);
 	mutex_unlock(&pktcdvd_mutex);
@@ -2526,7 +2522,6 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	__module_get(THIS_MODULE);
 
 	pd->bdev_file = bdev_file;
-	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
 
 	atomic_set(&pd->cdrw.pending_bios, 0);
 	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->disk->disk_name);

