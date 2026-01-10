Return-Path: <linux-fsdevel+bounces-73127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05339D0D040
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 06:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDA7F3016AFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13D3126B6;
	Sat, 10 Jan 2026 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z1TbNG9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C64220F2C;
	Sat, 10 Jan 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768024604; cv=none; b=LYtzo3X0JNka/1XRsNt5us0IfJBxLZxvwiS7tVRZYo7JmQ+QgcVknZ2e6SMl7cXv+HqJVGpBrghItuAocchFVpJefOn8172h5FcPRe0FjcpRAmAlVmJLtcv/d00maQ5oU7iPbov51d379V6BMaJYbWAD+5qr7hUzFlb6i0DfYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768024604; c=relaxed/simple;
	bh=CiRgL2DRLIx4GqPEKxKBvCusgMGbAyl4T8Z1UAyVuRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX4CJMdkeQv0XqdJsXGTjGE3s4Ds6re/XCMAOCfSBwl5WtNefr53ZtgDrLSeaY+1zuUohMywlOPdjl0Uo3wD17TMQ6OG1kRLu/p2jZGl9mTMgnqSZr0eUpe5G/tlOkNA9V4HpPk0XNUpdDnjBGXJXk3qFdwzEATEdmSEtbKy1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z1TbNG9C; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KLe+Mi/b7dOgrP38Ir+vp2S6Iyfk5DV6D4CfuAf7BPM=; b=Z1TbNG9CpTxcy6DpAY+80uBkMJ
	AsYaVD7oqKSOXgE9NsGc/405ZZAEWccRkgPIM/deRvYGRjqq2ZKGmKUQDJ94rtuq+PTCf6cC6JU+G
	EtpsNOMu4blF5yhEFYkUsWjr/ce4Hr2UcqUA9KO85CWp/SEBL0yekBMWb7bDmTGzLQMgFTEnhIGpR
	L5EUlII81UnD3//exZRW357uOOQfKLvTaRZalC+1KGGmolgW2VriezGI+KbtU97nVh083tYH/sCxA
	hKwrsZOTuy7PwJs7L6p0636nIl54WecZGYTDUj1RoC24hSBA6pmsnO/zXCU78yVrYNBvBFvYsuZJq
	JZbZhzzg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veRxl-00000000HUR-0L0v;
	Sat, 10 Jan 2026 05:56:37 +0000
Date: Sat, 10 Jan 2026 05:56:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/3] btrfs: use bdev_rw_virt() to read and scratch the
 disk super block
Message-ID: <aWHqFJfzD9QeaKkS@casper.infradead.org>
References: <cover.1768017091.git.wqu@suse.com>
 <829db7e054cd290b5aed0b337cd219da128ac0e7.1768017091.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829db7e054cd290b5aed0b337cd219da128ac0e7.1768017091.git.wqu@suse.com>

On Sat, Jan 10, 2026 at 02:26:19PM +1030, Qu Wenruo wrote:
> Furthermore read_cache_page*() can race with device block size setting,
> thus requires extra locking.

What?  There's supposed to be sufficient locking to prevent this.
Is there a bug report I can look at?

