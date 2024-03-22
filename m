Return-Path: <linux-fsdevel+bounces-15050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2688657A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 04:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B611F2301A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B263D5;
	Fri, 22 Mar 2024 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="izV6NGCH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5024436
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078694; cv=none; b=TOesaA9QaB1N7LXqwY4HgVxF6NUnaO4yodU9OxHGa+ATW1oXfN5skU9RUloB+4RmgdaC0Dn9uLI+nYxdNYKvBIKYJaLPl5Duq3xSXos6Fbqp8H6Y8DuRhmpfO6KjE8BSzugpJcGHG9S9AlEOuawIjztNj8GJAT04ZMp8sHww6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078694; c=relaxed/simple;
	bh=aXzEcMgK03ktUtjli7dv3iU6kR7ZuJbzmnLZD27piCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZOxiwvyFUvWi4FuUkNQdDUfA5kugdMpmlRL3BpVSZSU2xlDYvKYCKCglO0w9Xn+kvkgDPK6ledFNl5109SnjTm7jNrBvBGEIid0M4+/KOaS/HMZ1g3+zKG3dTzP6Gv8PEejy/yllYfgY4Ies0NTQfvuiF7H+lsShqO2NlW1kGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=izV6NGCH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Mar 2024 23:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711078690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+cKT4Y2w8MQNTOtlTHhMaKct7Pv7j1Qvo20xK7Y1P0=;
	b=izV6NGCHxuCG5cHJrBUMwHn0SJg+5jShzUomDyWp2ugpd3dAZfVZ84mFrnG+XQ0AgN++HQ
	vuempKm6FxDhknslJ1Hq7QS/eZqrnJEbfmGV5qGHCTTrw/5Iy8Os0BS+QcNPdpRjxHqMSX
	6jctNsSPDjZzVwyPfR88MRpV6UHwb7o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <62e6oefgpa5gj4xipmu6jjohkyl3bqcufcvfa2vn3tnyfwpmi2@oh6c2svzixxl>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <ZfyyEwu9Uq5Pgb94@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfyyEwu9Uq5Pgb94@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 21, 2024 at 10:17:55PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 23, 2024 at 02:26:17PM +0100, Christian Brauner wrote:
> > This opens block devices as files. Instead of introducing a separate
> > indirection into bdev_open_by_*() vis struct bdev_handle we can just
> > make bdev_file_open_by_*() return a struct file. Opening and closing a
> > block device from setup_bdev_super() and in all other places just
> > becomes equivalent to opening and closing a file.
> > 
> > This has held up in xfstests and in blktests so far and it seems stable
> > and clean. The equivalence of opening and closing block devices to
> > regular files is a win in and of itself imho. Added to that is the
> > ability to do away with struct bdev_handle completely and make various
> > low-level helpers private to the block layer.
> 
> It fails to hold up in xfstests for me.
> 
> git bisect leads to:
> 
> commit 321de651fa565dcf76c017b257bdf15ec7fff45d
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Tue Jan 23 14:26:48 2024 +0100
> 
>     block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access
> 
> QA output created by 015
> mkfs failed
> (see /ktest-out/xfstests/generic/015.full for details)
> umount: /dev/vdc: not mounted.
> 
> ** mkfs failed with extra mkfs options added to "-m reflink=1,rmapbt=1 -i sparse=1,nrext64=1" by test 015 **
> ** attempting to mkfs using only test 015 options: -d size=268435456 -b size=4096 **
> mkfs.xfs: cannot open /dev/vdc: Device or resource busy
> mkfs failed
> 
> About half the xfstests fail this way (722 of 1387 tests)

Christain, let's chat about testing at LSF - I was looking at this too
because we thought it was a ktest update that broke at first, but if we
can get you using the automated test infrastructure I built this could
get caught before hitting -next

