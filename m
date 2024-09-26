Return-Path: <linux-fsdevel+bounces-30171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E2987533
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FAB1F232E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625413B7AF;
	Thu, 26 Sep 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kfoFBXNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0524174A;
	Thu, 26 Sep 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359910; cv=none; b=QWHfUYJatbpSK0UPuOuKx+oQmDIpdBxrCQVYvireD2p1mTC3zDZVAZ2skawIfemrVfdywfOE4dFMZXx2iOjP7cZ2DWvMJUqSyovvyHTy8jMzX4jjMPpki6VPD/R8JhjOErthd3KcgrXWlVM19BVHyJY8gQpRfL+KQHt3IhH2IYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359910; c=relaxed/simple;
	bh=tGiIVDvvLwJ3qUCf6f36SkwoMzgkld7ZsoJ9zOdwrgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+3z1hwFg/70xQNBOg64AcRByneE0b6S+rGyHW1GDL8azl3KLSfesDup4AduXAZiR8c+NPpX2m5si6yOJr1D57SEQJPx2bA2oVwqpJPpx0Rs4vRHLKg/a3CcIsBES5CIjA/L74z5878xs9I2Z2zK9QFph6M5FK45uTZJLba1gpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kfoFBXNH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lj+/8xAR5PaVy59MnBKM3J07hbpzGvxFdzdZSeN/YVU=; b=kfoFBXNHfVwMRIGX58SyrymBNC
	YzUHnIoUnLjQhsOFGr/HgSKhf3+vtBej7GIrhPF6uJQZlA9RXMo9hf8uOr744bEBaXKz4VW24DO5Y
	6vV3x411I/LWjg/Qn9Vsl5g3Kv6zIUm2BjY1t8ZjFLgKK3CCmWDhJi7/8ixdd4VZeCJrEwAdsL/8G
	W8rDpaZWebuh5xNSTP5aQ297lauuyCUmyJHNVwSxGeGChNQ4GFB1o4rWC/bHhPdWP8NBAtnTGtktq
	TSOPtw4Bls2gGeycnfp5N2w0L+ArZ9N2tQbrdIlD3Xw0t2udvWW+seTOeiXmGLyZeWypPD2Y92Dod
	D7IeMC0g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stpDU-00000006ofk-2nuu;
	Thu, 26 Sep 2024 14:11:36 +0000
Date: Thu, 26 Sep 2024 15:11:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
	akpm@linux-foundation.org, Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	cgroups@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] fs/writeback: convert wbc_account_cgroup_owner to take a
 folio
Message-ID: <ZvVrmBYTyNL3UDyR@casper.infradead.org>
References: <20240926140121.203821-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926140121.203821-1-kernel@pankajraghav.com>

On Thu, Sep 26, 2024 at 04:01:21PM +0200, Pankaj Raghav (Samsung) wrote:
> Convert wbc_account_cgroup_owner() to take a folio instead of a page,
> and convert all callers to pass a folio directly except f2fs.
> 
> Convert the page to folio for all the callers from f2fs as they were the
> only callers calling wbc_account_cgroup_owner() with a page. As f2fs is
> already in the process of converting to folios, these call sites might
> also soon be calling wbc_account_cgroup_owner() with a folio directly in
> the future.

I was hoping for more from f2fs.  I still don't have an answer from them
whether they're going to support large folios.  There's all kinds of
crud already in these functions like:

        f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
                        page_folio(fio->page)->index, fio, GFP_NOIO);

and this patch is making it worse, not better.  A series of patches
which at least started to spread folios throughout f2fs would be better.
I think that struct f2fs_io_info should have its page converted to
a folio, for example.  Although maybe not; perhaps this structure can
carry data which doesn't belong to a folio that came from the page cache.
It's very hard to tell because f2fs is so mind-numbingly complex and
riddled with stupid abstraction layers.

But I don't know what the f2fs maintainers have planned.  And they won't
tell me despite many times of asking.

