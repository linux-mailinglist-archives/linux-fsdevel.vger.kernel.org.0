Return-Path: <linux-fsdevel+bounces-8200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3696830E18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8892A1F28F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 20:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7462C250F0;
	Wed, 17 Jan 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qe4YR7qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106E250E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523915; cv=none; b=RsrIfUIdeWxWlBETTKfdqzanUqxN2EN3yj9qyImlUIDhKKDNPYE3phUqHSJBuEtf0dXI31TrBO0MfWYJazNwKT+ATpx5cIoOEQqdFZXBJ/ftFxpwH0mgFYDghnvYEhiIHwP6/iBzjyyEXp4p9ZqydyfFlcz+E4Ot3bIVPGqO2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523915; c=relaxed/simple;
	bh=0XYKUVxg9ZEPZXTXsvIPYMbxiM2HvWn24nBCY6JoJNY=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=qUfkCVkBXTk1W9c3Vj/u9BPfQSSw2siZnzp4lW0Cps29mq00UhUJ0ND8vxdhsli1U2TKluJLqzU1yGZ36rnVHSVWTbPdQz6p2nk0HIZmhlWgEtk+IG34ow4CeczM157uhMq155s1THufoc9Oc2Gr+7J6z0ajfHoybQIAXijdzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qe4YR7qx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8KR7LDuJuULbvbkfkcg0Pw2uzyZFXH73CrNO1+XqHr4=; b=Qe4YR7qx2xbxXS54byCy3o9N7Z
	eqQ7K538mxhgX2CrPfASvUzk90bcnIG89ow+XvVsXTxly3/QmT/UqbY64V+1kuDZ12lDtFiEx1v7R
	FXC8tu17hbgN1oz35+I2xo/ipwgsisghxBiyKA3rrGZiz04Hi8hUGnYWHK2Qw0mbIbdEPJwx/x4yz
	aaW4PwPjh2JDm+wVbSDZHCN292HgMWCKrRpne/iMUQ0qtAnyv+HablXB+DyMX4k6SsxIWazC7c7ih
	h54bkRYJR2o8isOzjhpWrWV68bLOtwapjl6jYGXqXgN1WXd7Lvp98G5oDpv9dx46xCiZtqm546xYF
	zFuAtOPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQCgA-00000000ibD-1sZY;
	Wed, 17 Jan 2024 20:38:30 +0000
Date: Wed, 17 Jan 2024 20:38:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gabriel Ryan <gabe@cs.columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Race in mm/readahead.c:140 file_ra_state_init /
 block/ioctl.c:497 blkdev_common_ioctl
Message-ID: <Zag6xv3N7VZ_HFVT@casper.infradead.org>
References: <CALbthtcbD1bDYrQC6iNk6rMgBXO8LvH0kqxFh3=0nUdqm35Lsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALbthtcbD1bDYrQC6iNk6rMgBXO8LvH0kqxFh3=0nUdqm35Lsg@mail.gmail.com>

On Wed, Jan 17, 2024 at 03:08:47PM -0500, Gabriel Ryan wrote:
> We found a race in the mm subsystem in kernel version v5.18-rc5 that

What an odd kernel version to be analysing.  It's simultaneously almost
two years old, and yet not an actual release.  You'd be better off
choosing an LTS kernel as your version to analyse, something like v6.6
or v6.1.  Or staying right on the bleeding edge and using something more
recent like v6.7.

> appears to be potentially harmful using a race testing tool we are
> developing. The race occurs between:
> 
> mm/readahead.c:140 file_ra_state_init
> 
>     ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> 
> block/ioctl.c:497 blkdev_common_ioctl
> 
>     bdev->bd_disk->bdi->ra_pages = (arg * 512) / PAGE_SIZE;
> 
> 
> which both set the ra->ra_pages value. It appears this race could lead
> to undefined behavior, if multiple threads set ra->ra_pages to
> different values simultaneously for a single file inode.

Undefined behaviour from the C spec point of view, sure.  But from a
realistic hardware/compiler point of view, not really.  These are going
to be simple loads & stores. since bdi->ra_pages is an unsigned long.
And if it does happen to be garbage, how much harm is really done?
We'll end up with the wrong readahead value for a single open file.
Performance might not be so great, but it's not like we're going to
grant root access as a result.

We should probably add READ_ONCE / WRITE_ONCE annotations to be
certain the compiler doesn't get all clever, but that brings me to the
question about why you're developing this tool.  We already have tooling
to annoy people with these kinds of nitpicks (KCSAN).

