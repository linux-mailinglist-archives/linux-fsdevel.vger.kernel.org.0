Return-Path: <linux-fsdevel+bounces-979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB57D47E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934BA1F219D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 07:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9AF134A1;
	Tue, 24 Oct 2023 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DBECAPPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA621170F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:03:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE557110;
	Tue, 24 Oct 2023 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LvOiTdTTHzhafayusvQwyLj5RJk0YCkV1tYeNqzUJuA=; b=DBECAPPXtQCD21PnNHQh3yfaL6
	TdF09ZOYxd7dp6Wksmz/aojmJhxz1llsjzkw+EcE8OULKL+wOtoC9yVJiDEfdKxDn/YAAWbu/ixmt
	xENYe2qSpgtHYwKWMzTT9xVYzb4OLp0Hyt5Cgcdus+t1wv0IC1fqWzXWO2FvVuehaCtm/4gBD9y2r
	4SBeLNP9LAdIKJJzmGQ4dXW69Tq/jF9M4MX6TFn/4EbKyDCZd6VkNhwLjmJMxSVONT3bBrDn/itI/
	UAB/XFm/oXEzy2t5c2pFbOzz3NviAXglGgFl/can+s6T7ZNCDHPmyHROOIjW1mCRvSPHDGySq34Qz
	7VEJ0Lnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBRl-0091xP-0F;
	Tue, 24 Oct 2023 07:03:25 +0000
Date: Tue, 24 Oct 2023 00:03:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: loop change deprecation bdev->bd_holder_lock
Message-ID: <ZTdsPUgCA5TK1hfj@infradead.org>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
 <20231023-ausgraben-berichten-d747aa50d876@brauner>
 <20231023-fungieren-erbschaft-0486c1eab011@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-fungieren-erbschaft-0486c1eab011@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 23, 2023 at 05:35:25PM +0200, Christian Brauner wrote:
> I just realized that if we're able to deprecate LOOP_CHANGE_FD we remove
> one of the most problematic/weird cases for partitions and filesystems.

> change fd event on the first partition:
> 
> sudo ./loop_change_fd /dev/loop0p1 img2
> 
> we call disk_force_media_change() but that only works on disk->part0
> which means that we don't even cleanly shutdown the filesystem on the
> partition we're trying to mess around with.

Yes, disk_force_media_change has that general problem back from the
early Linux days (it had a different name back then, though).  I think
it is because traditionally removable media in Linux never had
partitions, e.g. the CDROM drivers typically only allocated a single
minor number so they could not be scanned.  But that has changed because
the interfaces got used for different use cases, and we also had
dynamic majors for a long time that now allow partitions.  And there
are real use cases even for traditional removable media, e.g. MacOS
CDROMs traditionally did have partitions.

> For now, we should give up any pretense that disk_force_media_change()
> does anything useful for loop change fd and simply remove it completely.
> It's either useless, or it breaks the original semantics of loop change
> fd although I don't think anyone's ever used it the way I described
> above.

Maybe we can just drop the CHANGE_FD ioctl and see if anyone screams?


