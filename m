Return-Path: <linux-fsdevel+bounces-63525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE63BC01DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 05:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067BD3BB36F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE121883F;
	Tue,  7 Oct 2025 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdVnM4Or"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6120322;
	Tue,  7 Oct 2025 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809134; cv=none; b=P3zmIZxvd3a/hY/jammp7ZQFj+El8dNdC1muBOjBzDjk4N7wv//9dOoeEQynyhz/kMjeiptgT0liMtg2353aNCqiaZGyaHbwIkCNAItYKF3SIt1VncZEmibnDNNWEJUipKvk5rBF60IuHUz5G3IayGwATZXOpxygId/pVAwF8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809134; c=relaxed/simple;
	bh=BSp7GCexnCGg0VQikg5WyQfBlMqBG8jgyDwxPWcEXuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJyaxC36nolkH7XRH3ayidyZbwqa3vxLjjI83nIa22ZVqCBp0+jMOCrR3FgP6oVJ36uU9gfrr05TFhoNFW3V6R41l6KTK5TYsLo/VUnACwwk2Z1GHRKOIhkVH8aIEZoTWqepz8VAIeIq7b3cXxuZdr260nLuGPjXB91emnCz2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdVnM4Or; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9RoMdyg6ZNu98kkI6TO+6dVZLuDwJBqIORcOFKn+p4=; b=BdVnM4OrdsohYV6Nem77XjfCCN
	ojgYgCC0XblgHf6FfVzeB8R0Z/QO+NkYaHjhAKNG99cPy5h6LkNN3X/cfpfdGbig7T8AoJoeNRxhk
	Egr0FhKq7pEQVjXQorN11TyYMKroedPVhPTuHQ+NqkRHgH4x8V/gEhxau1E+5Q/72m8rEaFkE6Fr6
	fCUrgdd/GHZFBz7AqTkaJLSOVmJN3y5iOp9bddqZXi2bfEZykJOYdOYGO037eTTu+3oaDxnVunHKU
	JDyCvQVRcL8hpoZO4HXgQtE2spenHGkQheduv+/hijGviWGfSgd3W4mnxcQiJ/WdkIjGLvKVW8Ia3
	3pNiqkfA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ykD-00000007UeE-1j0N;
	Tue, 07 Oct 2025 03:52:09 +0000
Date: Tue, 7 Oct 2025 04:52:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios
 that are fs block aligned
Message-ID: <aOSOaYLpBOZwMMF9@casper.infradead.org>
References: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>

On Tue, Oct 07, 2025 at 01:40:22PM +1030, Qu Wenruo wrote:
> During my development of btrfs bs > ps support, I hit some read bios
> that are submitted from iomap to btrfs, but are not aligned to fs block
> size.
> 
> In my case the fs block size is 8K, the page size is 4K. The ASSERT()
> looks like this:

Why isn't bdev_logical_block_size() set correctly by btrfs?

bio_iov_iter_get_bdev_pages:
        return bio_iov_iter_get_pages_aligned(bio, iter,
                                        bdev_logical_block_size(bdev) - 1);


