Return-Path: <linux-fsdevel+bounces-41963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BC2A3955A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C102D1897A8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958022C322;
	Tue, 18 Feb 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zhUQ+e6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561722B8BE;
	Tue, 18 Feb 2025 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867168; cv=none; b=NdOtmBmF7j508RZr+KvYl2BV47KyTOhT/uA+t4+QqMLqVnrRnKd3712ssutnYv4tcY+v6GbxgXl+j71MkSJDIHb0Rjs1EBDGiNZzY4ilUGQ75Qlxx4/CdSSoVeOrf4jtmMy/RjnIzbu8BiFcUvR4q3zwd/fPORkMxqywlyt3awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867168; c=relaxed/simple;
	bh=6+V3lp5W22nRBogzJ+Ne1Q5jwm+N2HfbNVp8+d6wAmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VQqaNseWIraIvWYO0x4oYG6HXSbBiUKWpZLy7JbWZZqY6lZhV2IPGxgGRidZsUapbYw2Zo/lCwvZhr2MiQdhRZ6veNjabF71uwSAxLYhnCu7hN0G4/1Hi9+KIbIaHyVAMUtHhAjWJ/FboLuG03CDAyhZEi3R3xIP2yR7tcpHQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zhUQ+e6H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=FkUCjxz9vjqxLei0utw3tRN3Rl77dSlMqLgpoQD9LSw=; b=zhUQ+e6HSttPyyE2/vmwfPYv33
	X+w/gXVba5sH/Xs9XQ6XLUasYNrzvNvxOvX7Nb/XdZlh4iIa94HDOCqLQ+o/ZIVmxhCScLRN/MzTw
	YxQy84GMZef8zz4k+rqrdU5SeKL29sLd3kN1Ez5nhGt39B+KHRdlw5Wgx89hjcwDX55Oev9byfxVQ
	ko5eHRSUOjD80H85xR8DfMNvPlQRqotlBiVOgI2YbOZDuzxYfHaI1V0xUklb6YTAQpVD2p3GTLDH2
	44PtrClYGsMkeWE0CHFmCANkhTCwyZs4rxxz8RR8mhke5UaII8tGB9vd1jJxb7c1JfQouNLYAxfZt
	0tWPxfew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIve-00000007GjS-2N6c;
	Tue, 18 Feb 2025 08:26:06 +0000
Date: Tue, 18 Feb 2025 00:26:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 0/2 v9] reclaim file-backed pages given POSIX_FADV_NOREUSE
Message-ID: <Z7REHrJ3ImdrF476@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212023518.897942-1-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This still has a file system sysfs HACK, you're still not Ccing the
right list, etc.

Can you pleae at least try to get it right?

On Wed, Feb 12, 2025 at 02:31:55AM +0000, Jaegeuk Kim wrote:
> This patch series does not add new API, but implements POSIX_FADV_NOREUSE where
> it keeps the page ranges in the f2fs superblock and add a way for users to
> reclaim the pages manually.
> 
> Change log from v8:
>  - remove new APIs, but use fadvise(POSIX_FADV_NOREUSE)
> 
> Jaegeuk Kim (2):
>   f2fs: keep POSIX_FADV_NOREUSE ranges
>   f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++
>  fs/f2fs/debug.c                         |  3 +
>  fs/f2fs/f2fs.h                          | 14 +++-
>  fs/f2fs/file.c                          | 60 +++++++++++++++--
>  fs/f2fs/inode.c                         | 14 ++++
>  fs/f2fs/shrinker.c                      | 90 +++++++++++++++++++++++++
>  fs/f2fs/super.c                         |  1 +
>  fs/f2fs/sysfs.c                         | 63 +++++++++++++++++
>  8 files changed, 246 insertions(+), 6 deletions(-)
> 
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 
> 
---end quoted text---

