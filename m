Return-Path: <linux-fsdevel+bounces-53075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CE3AE9B25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF06E3AC8EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA82580C7;
	Thu, 26 Jun 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XE0BK+4u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FF800;
	Thu, 26 Jun 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933522; cv=none; b=SrV0IZ+ChCbVSLRGiYcY1+WDJL+9ab9sYFl2gnwnco/pCqgPzGLHq7hSZaVXRvUwJ4AqWZk8NlDT9GfDm9XXIR/athckFbk7/RvNjeHpTjyMXVJkXBBM9rulgGu6WitAjZzvEtR32XKEW6uNmX1bn1q1zZ3KfSxIes+fmz4+opM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933522; c=relaxed/simple;
	bh=Gx06JMDSopyJ7pbFWSl7UigEcRh/jUspF/asLoozNcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSUfgOofZMGhQXHowA0dwlq1VUlLTp9Z+JZn/ahwivKpDlCDHrp7VbisKUieQ78d03UL6VQtJXuzj//1KaKvdQiNy3wtH/TGmFJamRSSgIaaZ1jkoREjIbdP+31X9z68nufIJt1fmMlfp1INPafXYWVTUWKRtk4GsEaT9peE8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XE0BK+4u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0z8VxbTUym1H07H34+Tq2p9LTx6bEUnk5amgzOtXLWc=; b=XE0BK+4ua7lsobC+vYQwrTfYNt
	g5TwyhtRN9mRjyfVN3f1R8/e6jU58c271ru9MXREUSYug0uKq+qjTV8Zt+/uW3+G3q2jAPdhNKsTi
	2GTuI5iW/D2evuvAXNWoj463Nm5C2dmSaxpRBAy6RsNak4SOXXDCjoU2G6kbBr+Wrpi5DYf4mbHlZ
	5dgdvCo1SaBDjczlztpzJ1oJ/6/M4/md16av0Bhi4ZYkERJ+rEbZYNmwjpFa7ZH6nwR5NrMCsi6A/
	0v7wODBYPIPMPCJPTkMBfC8We/5WU0B0Vd/So+pg+wgcHe5PI/0pHB+L1VULngphzE/60K5yJfB8u
	UM9Z3HhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUjnF-0000000BGpI-0WkA;
	Thu, 26 Jun 2025 10:25:21 +0000
Date: Thu, 26 Jun 2025 03:25:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aF0gEWcA6bX1eNzU@infradead.org>
References: <aFqyyUk9lO5mSguL@infradead.org>
 <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
 <aFuezjrRG4L5dumV@infradead.org>
 <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
 <aFvbr6H3WUyix2fR@infradead.org>
 <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
 <aFvkAIg4pAeCO3PN@infradead.org>
 <11735cf2e1893c14435c91264d58fae48be2973d.camel@kernel.org>
 <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>
 <aFzFR6zD7X1_9bWj@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFzFR6zD7X1_9bWj@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 26, 2025 at 01:57:59PM +1000, Dave Chinner wrote:
> writeback errors. Because scientists and data analysts that wrote
> programs to chew through large amounts of data didn't care about
> persistence of their data mid-processing. They just wanted what they
> wrote to be there the next time the processing pipeline read it.

That's only going to work if your RAM is as large as your permanent
storage :)

> IOWs, checking for a past writeback IO error is as simple as:
> 
> 	if (sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE) < 0) {
> 		/* An unreported writeback error was pending on the file */
> 		wb_err = -errno;
> 		......
> 	}
> 
> This does not cause new IO to be issued, it only blocks on writeback
> that is currently in progress, and it has no data integrity
> requirements at all. If the writeback has already been done, all it
> will do is sweep residual errors out to userspace.....

Not quite.

This will still wait for all I/O on the range, and given that
sync_file_range treats a 0 length as the entire file that might actually
do a significant amount of waiting.  But yes, it's the closest we get
right now.


