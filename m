Return-Path: <linux-fsdevel+bounces-15035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53900886333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 23:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8751C21F68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 22:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4595A13699B;
	Thu, 21 Mar 2024 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pyiM6dG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B927136678;
	Thu, 21 Mar 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059480; cv=none; b=N1emJFYIdJU+4EOLVoT8EhAR7D8cwBrGIMAk9V4zf8UOt/OlOoIrSVyDmYWdY6DnWWBD5AyCJkOCCNzfhem8BlcZTjlt1wDHLlcH/uzfpW+zkbsVtf7uaYtUymG64H3pBoWcRF5Rr0IAyQPDP/GMlB06USCbaKNPyjjcT79f+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059480; c=relaxed/simple;
	bh=TWPywZmYQfSzaaVw6MlOvZjfhCLwaTpQvIshNj2rZ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVm5ymMbyqv/Vv6evQbrRpqOIGIZYIhQyiye3nGQDwwv0WJyopdP5kb72CqfpxFL1o4+nvc9bf6LKnMyfGapPNlhISc4qK+dgI5tR+hs+Ey/RWlEQ5fNJlWpdczOUVjJ2c4PzhgythcRAn0dZCaVEpN5I30mKGyqD66AIFGHNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pyiM6dG8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7boV6kwIyDNNQcD+l25f0yRaiDI5TrZ7g7lLnA+hpMU=; b=pyiM6dG8hRPG2lbz4s25X7e/ox
	7vEpbt9QViv6ANHZpKZkenkbFID0zYN3EQJXQMJ/ihjyA4itJst/O82ZcspaW/ca9juj+y8/bdYVz
	ZLb+HBUijkCpjc4G19REQKhBujQvYdPoyf/efP1Zi50xiOn0f3uAhqDGNJgPnt9gztpwpiydS+vnB
	5ZpDebkQlkvB4/Y0UJm5HKc4k5SSgSlMrFC86qzUsSlQvyrhv6ZntA4xD+hqXZtDFF2ZbQ2RanWbs
	qxmXzl3N5qlveYUEY86O7nfLUxO4E7JavpJR3adg0f8D2euBlH4ZrsWz/NyAQKHakbiAOLnayNWuY
	wKXH29cA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnQjT-00000007ifl-0yqY;
	Thu, 21 Mar 2024 22:17:55 +0000
Date: Thu, 21 Mar 2024 22:17:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <ZfyyEwu9Uq5Pgb94@casper.infradead.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>

On Tue, Jan 23, 2024 at 02:26:17PM +0100, Christian Brauner wrote:
> This opens block devices as files. Instead of introducing a separate
> indirection into bdev_open_by_*() vis struct bdev_handle we can just
> make bdev_file_open_by_*() return a struct file. Opening and closing a
> block device from setup_bdev_super() and in all other places just
> becomes equivalent to opening and closing a file.
> 
> This has held up in xfstests and in blktests so far and it seems stable
> and clean. The equivalence of opening and closing block devices to
> regular files is a win in and of itself imho. Added to that is the
> ability to do away with struct bdev_handle completely and make various
> low-level helpers private to the block layer.

It fails to hold up in xfstests for me.

git bisect leads to:

commit 321de651fa565dcf76c017b257bdf15ec7fff45d
Author: Christian Brauner <brauner@kernel.org>
Date:   Tue Jan 23 14:26:48 2024 +0100

    block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access

QA output created by 015
mkfs failed
(see /ktest-out/xfstests/generic/015.full for details)
umount: /dev/vdc: not mounted.

** mkfs failed with extra mkfs options added to "-m reflink=1,rmapbt=1 -i sparse=1,nrext64=1" by test 015 **
** attempting to mkfs using only test 015 options: -d size=268435456 -b size=4096 **
mkfs.xfs: cannot open /dev/vdc: Device or resource busy
mkfs failed

About half the xfstests fail this way (722 of 1387 tests)

