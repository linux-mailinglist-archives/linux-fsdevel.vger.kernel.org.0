Return-Path: <linux-fsdevel+bounces-31280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA64993F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1532B1F21DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C8179965;
	Tue,  8 Oct 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="won8RtEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8E146A69;
	Tue,  8 Oct 2024 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369308; cv=none; b=YVoGt68j2iWjyKWCVGpIiWNbb/fuoi9Hqzaz8oKAuwsp6dS4bK/7r0iTb1MBtQcSnwwvYzwp7guLXgReosmNSrW6QIUrScUlKg99rW85kUuN4Zf/PyeohqAic3j/7sjfA+pU50O/JUzomth55B/ne/dKeLnrxvMieO7kzWzE0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369308; c=relaxed/simple;
	bh=m2VU5zLM/AWsPzA752eHnqIp1c+LKrLc4cCzAvg6XXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3N8un2CKhVtUxe5w/ZZcUXti/lBfxIwOnxpRECTRIfC89gfqjJ/JUY4zn8mfA3IPhmvA108Nm3bCdb9B8pnMeHqXWxyqloyd8EGCA+T3qUvM94kbegKTxRMsvUO1GWrBEBo7DOaYyV6I8ze1r48zbQyJ8imBdp6T7I1Gt1lhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=won8RtEa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yUKqKzV8JqUTZKMD9Q1Phh5hMJ81k/O0PcaHT4VavoI=; b=won8RtEaSBHPHpiXvR4IS8TMC2
	Qe28G34+EOVLZ2Uozmi7gkLVNfN86iipRT/QpJV+Wt4G3BxtSJJjo37U3BK8NMnxZyO6oRyathiIF
	iTzSrSvPeJaN+mit+AhdegQFjdJtPqtZmmr5hAslSv6bvsFoNFqnEUXcT5AcRE4m54UUlJS4RqzHM
	gwRaBj/Ktv79uQNddRa5MBc61IXAxQc12lYMeog+4SIUggqJejOxNpenaS+XPVB+/Ne8E0QIAY8f3
	K6S8Mz51R+5E+K/eCX0UTthi2nnRMDsrWp1Y0zAQjf2u8Rz5f/byKU/yz52ZPEl2QeSeX9OcztlAF
	fI0O8nfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3oG-00000004fg3-33TW;
	Tue, 08 Oct 2024 06:35:04 +0000
Date: Mon, 7 Oct 2024 23:35:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Tang Yizhou <yizhou.tang@shopee.com>, jack@suse.cz, hch@infradead.org,
	willy@infradead.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <ZwTSmHM4o8Gg5NRW@infradead.org>
References: <20241006152849.247152-1-yizhou.tang@shopee.com>
 <20241006152849.247152-4-yizhou.tang@shopee.com>
 <ZwRUQvq4wqfL8rBd@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwRUQvq4wqfL8rBd@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 08:36:02AM +1100, Dave Chinner wrote:
> I think this map size limiting is completely unnecessary for
> buffered writeback - buffered writes are throttled against writeback
> by balance_dirty_pages(), not by extent allocation size. The size of
> the delayed allocation or the overwrite map is largely irrelevant -
> we're going to map the entire range during a write, do it just
> doesn't matter what size the mapping is...

Yes.  This goes back all the way to your original iomap prototype,
but even back then balance_dirty_pages should have done all the
work.  


