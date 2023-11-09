Return-Path: <linux-fsdevel+bounces-2583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958F7E6DDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC94B213F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27392208CF;
	Thu,  9 Nov 2023 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rc31F659"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0760208B0;
	Thu,  9 Nov 2023 15:43:01 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0954C07;
	Thu,  9 Nov 2023 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YAvU/H8ewWgtj8+lNR19xNcK269Z+0oH3wD0bk8ZHoo=; b=Rc31F659WDeW93mMNfNBwa+tdF
	uKwVofNS0q2HXkMP46RrMFTXTHha4qswZX/hwdgITzDg3dYgi7sLu7amPuG2nBv0Kf6i3urQ5MnQq
	hJHw22feJPvCysjpzWN9+ZaXes9oAio1bTIDx3bt9xmcKIz5w+UUsXbiM7/6b1JKDDCQfGDogqqg9
	NPb3sreQQcZAF+G2Yc/g1705bZgjnMLJidH45aFxrQMxRAZF20Yd96rPyMngzwmKy0LiGoAQBvlDT
	zK/Vo03uJK1tOnG7QSLRhq0FPmH5tkp/XnKZlIbXSH8owdhmWnwBGsCMqdXlPPCjdcizCHa6+eO4o
	k1pR69pg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r17B2-00838t-P7; Thu, 09 Nov 2023 15:42:40 +0000
Date: Thu, 9 Nov 2023 15:42:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <ZUz98KriiLsM8oQd@casper.infradead.org>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-22-john.g.garry@oracle.com>
 <20231109153603.GA2188@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109153603.GA2188@lst.de>

On Thu, Nov 09, 2023 at 04:36:03PM +0100, Christoph Hellwig wrote:
> Also I really want a check in the NVMe I/O path that any request
> with the atomic flag set actually adhers to the limits to at least
> partially paper over the annoying lack of a separate write atomic
> command in nvme.

That wasn't the model we had in mind.  In our thinking, it was fine to
send a write that crossed the atomic write limit, but the drive wouldn't
guarantee that it was atomic except at the atomic write boundary.
Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
into a single 80kB write, and if the power failed midway through, the
drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
64-80kB and not the other three.


