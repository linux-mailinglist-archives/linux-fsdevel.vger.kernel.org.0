Return-Path: <linux-fsdevel+bounces-8306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DA1832AA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 14:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6F1285E89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D052F91;
	Fri, 19 Jan 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="loPCJFKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DD4F21A;
	Fri, 19 Jan 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671616; cv=none; b=MSOFI8hCplHEZYbPkXmtjprybNtZjSyHRmE8G48y3tv+LbTzqPjxQfrDdm/8swusVURnRBkfnSIHRU/GVVwheJUu5a86TD0xhOXM90SChqqWRLU1PyAkMdGYoLwuuCT9v4/ar+N/PnlnTpIfribsnLKPkoQgPzaNBAvWJqKjlJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671616; c=relaxed/simple;
	bh=Y4Mm6pe+e8cfQgYP7LhcO0HyBF1sGbEzf6pGZai00Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI6q77CDwdSlehDmfS20+rAa8i3FLYolv31g2Mphn63MYgNJp0NzeFBbMeQ7rYUwCVkZe/uO8jkOVIRHTEs6gqzZHmrUhymKMOGCJ5guCN2c7K3s+bcqhjK/xqJm1uevEdsr3xCqmutqTx6NHoaq7HA4/9r77fsNEGuA6+OSVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=loPCJFKT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=76lgfmwJ5lAYcq0PAI1xrtVyvSIBJZ52fv1km/3KaNM=; b=loPCJFKTwEltGKL8VA3mixmSyI
	4GHzuOaE/EAFXlgjUaXBuj3hCYwOE9+cB07l8AbQnp5gemCpnPcnYnFIpOY10pN1hhRduDQGJQlZ1
	Un6o56B8hPSc/N7bZ87+rAGn7E9fWpkpOgT7svw/Ur8l9j3pHUZFuMrrloTkbzHXHQSqvls1nAkTZ
	dyrXN78WMTGf9xaQ2vOVLMQYqbH/drc3Oh6bIos+GlSwMFrj1QKMt6tV+6AOBFekukSEdAu14OypY
	a2AC2qmfpySs8obaRUoKzm1Hc0urjgfUS0xk4FsixxNZ+hWM5GYiOELbNCtTLDjUAzaI7lR+e7mbN
	EqiMH3Lw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQp6N-000000056eE-1RV7;
	Fri, 19 Jan 2024 13:40:07 +0000
Date: Fri, 19 Jan 2024 13:40:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, akpm@linux-foundation.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, arjunroy@google.com,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] filemap: add mapping_mapped check in
 filemap_unaccount_folio()
Message-ID: <Zap7t9GOLTM1yqjT@casper.infradead.org>
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119092024.193066-1-zhangpeng362@huawei.com>

On Fri, Jan 19, 2024 at 05:20:24PM +0800, Peng Zhang wrote:
> Recently, we discovered a syzkaller issue that triggers
> VM_BUG_ON_FOLIO in filemap_unaccount_folio() with CONFIG_DEBUG_VM
> enabled, or bad page without CONFIG_DEBUG_VM.
> 
> The specific scenarios are as follows:
> (1) mmap: Use socket fd to create a TCP VMA.
> (2) open(O_CREAT) + fallocate + sendfile: Read the ext4 file and create
> the page cache. The mapping of the page cache is ext4 inode->i_mapping.
> Send the ext4 page cache to the socket fd through sendfile.
> (3) getsockopt TCP_ZEROCOPY_RECEIVE: Receive the ext4 page cache and use
> vm_insert_pages() to insert the ext4 page cache to the TCP VMA. In this
> case, mapcount changes from - 1 to 0. The page cache mapping is ext4
> inode->i_mapping, but the VMA of the page cache is the TCP VMA and
> folio->mapping->i_mmap is empty.

I think this is the bug.  We shouldn't be incrementing the mapcount
in this scenario.  Assuming we want to support doing this at all and
we don't want to include something like ...

	if (folio->mapping) {
		if (folio->mapping != vma->vm_file->f_mapping)
			return -EINVAL;
		if (page_to_pgoff(page) != linear_page_index(vma, address))
			return -EINVAL;
	}

But maybe there's a reason for networking needing to map pages in this
scenario?

> (4) open(O_TRUNC): Deletes the ext4 page cache. In this case, the page
> cache is still in the xarray tree of mapping->i_pages and these page
> cache should also be deleted. However, folio->mapping->i_mmap is empty.
> Therefore, truncate_cleanup_folio()->unmap_mapping_folio() can't unmap
> i_mmap tree. In filemap_unaccount_folio(), the mapcount of the folio is
> 0, causing BUG ON.
> 
> Syz log that can be used to reproduce the issue:
> r3 = socket$inet_tcp(0x2, 0x1, 0x0)
> mmap(&(0x7f0000ff9000/0x4000)=nil, 0x4000, 0x0, 0x12, r3, 0x0)
> r4 = socket$inet_tcp(0x2, 0x1, 0x0)
> bind$inet(r4, &(0x7f0000000000)={0x2, 0x4e24, @multicast1}, 0x10)
> connect$inet(r4, &(0x7f00000006c0)={0x2, 0x4e24, @empty}, 0x10)
> r5 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
> 0x181e42, 0x0)
> fallocate(r5, 0x0, 0x0, 0x85b8)
> sendfile(r4, r5, 0x0, 0x8ba0)
> getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
> &(0x7f00000001c0)={&(0x7f0000ffb000/0x3000)=nil, 0x3000, 0x0, 0x0, 0x0,
> 0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=0x40)
> r6 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
> 0x181e42, 0x0)
> 
> In the current TCP zerocopy scenario, folio will be released normally .
> When the process exits, if the page cache is truncated before the
> process exits, BUG ON or Bad page occurs, which does not meet the
> expectation.
> To fix this issue, the mapping_mapped() check is added to
> filemap_unaccount_folio(). In addition, to reduce the impact on
> performance, no lock is added when mapping_mapped() is checked.

NAK this patch, you're just preventing the assertion from firing.
I think there's a deeper problem here.

