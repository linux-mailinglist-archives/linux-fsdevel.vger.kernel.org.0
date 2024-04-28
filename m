Return-Path: <linux-fsdevel+bounces-17990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A78B4911
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 03:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4936B1C20C74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A6110A;
	Sun, 28 Apr 2024 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JGJXEMSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33517E8;
	Sun, 28 Apr 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714267526; cv=none; b=aNE2ksE4kdW5E2uaLu7SliVq8otf8vOsJw1My17S/ffO2GfNA1hlXkJ04BcPwi2wvjoV4WIJbqloBiG9g6jhdK4UmZW2yCyz0jF4o450kDwrQKhvx31t6StriHTsdt9L4gW2J7ANpLMDQIyOk3BgjVnY+GXhCthLfkjQcVbq4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714267526; c=relaxed/simple;
	bh=nf4ART+KYv5Dm9DqbyKqYwkXppf5Az2AXqd2VKmooRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMkimmpFoB7f0Pj9vYkkAF9/A/Rjcq6Z/VDRIx3pnnCrSZsqGuaQHuG2yhs2evWCqI3D2qaNcSt4uNciw7kIurEmTPoRZupZbrRtd4qj/GUE/VIAS6udxzstfU5zuVKl3DvcmBf1XCkQBtKMxbsZJUeGY4ezuPzZddXFgnWcGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JGJXEMSW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZIdsTX1y4MugrwR5X85S0zLQbguz18AVqpgbABLPlEI=; b=JGJXEMSWj55q0jSKXBCKyaoHjO
	0WjSOkz/eraMPl0g7XFT2XN2SlAj4OYSMynpCGb1vSthd3mHcEtkWbcjbfJDcurUN6ez+VKUAQ1yJ
	db5WJ/qmdoCW6F9GTOhCj+JQqhSVDPLkMF8TbpSG1AxK+WY4cFCBFQYimQEtu3OhxrrrESbrw0kAX
	jss2sHsvm/q6slamQ+XsLhmMeoNR/adEQcO172ltkKd80tWB6XUfmdoz7hDXJVN7Jlt9Pjr5PcNvL
	h2VtvFc2Gm117yOSyzS/Uo+z1d2fYUQI1Xm1n+AXx9fKe79ZplXtM2PZKEl30slYR6YruSpZvM9Zg
	NrP7HMTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0tI9-006PHB-0V;
	Sun, 28 Apr 2024 01:25:21 +0000
Date: Sun, 28 Apr 2024 02:25:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240428012521.GT2118490@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211128.GD1495312@ZenIV>
 <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
 <20240427234623.GS2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427234623.GS2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 28, 2024 at 12:46:23AM +0100, Al Viro wrote:

> Switching swap exclusion to O_EXCL could've been done back in 2003 or
> at any later point; it's just that swapon(2)/swapoff(2) is something that
> rarely gets a look...

BTW, a fun archaeological question: at which point has this
                /*
                 * Retrying may succeed; for example the folio may finish   
                 * writeback, or buffers may be cleaned.  This should not  
                 * happen very often; maybe we have old buffers attached to
                 * this blockdev's page cache and we're trying to change
                 * the block size?
                 */
                if (!try_to_free_buffers(folio)) {
                        end_block = ~0ULL;
                        goto unlock;
                }

in grow_dev_folio() (grow_dev_page() in earlier kernels) become unreachable?
I _think_ it was
commit fbc139f54fdb7edfec470421c2cc885d3796dfcd
Author: Linus Torvalds <torvalds@athlon.transmeta.com>
Date:   Mon Feb 4 20:19:55 2002 -0800

    v2.4.10.0.2 -> v2.4.10.0.3

      - more buffers-in-pagecache coherency

when set_blocksize() started to do
	sync_buffers(dev, 2);
	...
	invalidate_bdev(bdev, 1);
	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);

at which point the "what if we'd found a page with attached buffers of the
wrong size?" should've become impossible.

Am I misreading that?

