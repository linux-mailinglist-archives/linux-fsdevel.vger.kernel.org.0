Return-Path: <linux-fsdevel+bounces-27277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0D95FFE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200411C21CC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734871CA84;
	Tue, 27 Aug 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ttq4LiKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96D17D2;
	Tue, 27 Aug 2024 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729797; cv=none; b=Z3bR7uV4qzlzD7cXtKOOrw0hsaR3WKtdfDxKVZLitqaausrXeZ6LUKxwc5iMZRmtnKtiuIdMUandecIkzIytgi+OxutA7KFUljt73nCTAVcDjXBl8l41wvExEm64PWI68qUbUE1K+njHsx7Ml8adyJU7+ehSerLHLjtFrmqbQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729797; c=relaxed/simple;
	bh=ZNU9siZLGJF9qLcL/LjvNCBDdbKVUwtaQLf7o0Tgtng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhvEWSgF2jmpWUXZeUJmNq1OYxQ9HhXRNzNJji39BKe0FBjYwe/sN92Ib2LYkMR/87pvDCCwyqJ8JpB6SYoBZbeb/dw7aTp3s4e+Yi+aUvb9Pf70tAQLqA4NeuXi/bCXoVKtSw4yQRXkmoyUfSMcsEv3uDIvAYCEreOzMbisa+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ttq4LiKK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6tyAm2bI6jnhZGsoe6xMNZqvocekGaBxCFlm8ROaKf8=; b=ttq4LiKK72IodBkv3KiZ4MYohr
	Zk79dyOcxdMU3A4BglAZfnNL9CfTPmtY0uatfIJecWYzTyxJDXUHwSeqwqeSKFKzgz758jHoj3FwW
	dFZ0pi7p57J5HwcHbZUVcGMikKJE15BdWN3+nsWXHlTnDlsZkAKvTZBa89IT8Q2kwXauyToRp4Lju
	zqwANiP1HOt9LFJUJ+P+oTD1M54qm2iBgEtZArNTGeOaLc3YCwwPGNZYd5iWjXfNdzvpc6oIj+Kxh
	5L81rBQYEPFZoyA2gmDsXenTZ+rqWQs8ELSI5Yi2fuCEwlEs26cirtZgbFOEUMH5XZBj1pxRtevyS
	JI0J9oNg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sin0T-0000000GKx0-3RU4;
	Tue, 27 Aug 2024 03:36:34 +0000
Date: Tue, 27 Aug 2024 04:36:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-bcachefs@vger.kernel.org
Subject: Re: bcachefs dropped writes with lockless buffered io path,
 COMPACTION/MIGRATION=y
Message-ID: <Zs1JwTsgNQiKXkdE@casper.infradead.org>
References: <ieb2nptxxk2apxfijk3qcjoxlz5uitsl5jn6tigunjmuqmkrwm@le74h3edr6oy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ieb2nptxxk2apxfijk3qcjoxlz5uitsl5jn6tigunjmuqmkrwm@le74h3edr6oy>

On Mon, Aug 26, 2024 at 11:29:52PM -0400, Kent Overstreet wrote:
> We had a report of corruption on nixos, on tests that build a system
> image, it bisected to the patch that enabled buffered writes without
> taking the inode lock:
> 
> https://evilpiepirate.org/git/bcachefs.git/commit/?id=7e64c86cdc6c
> 
> It appears that dirty folios are being dropped somehow; corrupt files,
> when checked against good copies, have ranges of 0s that are 4k aligned
> (modulo 2k, likely a misaligned partition).
> 
> Interestingly, it only triggers for QEMU - the test fails pretty
> consistently and we have a lot of nixos users, we'd notice (via nix
> store verifies) if the corruption was more widespread. We believe it
> only triggers with QEMU's snapshots mode (but don't quote me on that).

Just to be crystal clear here, the corruption happens while running
bcachefs in the qemu guest, and it doesn't matter what the host
filesystem is?

Or did I misunderstand, and it occurs while running anything inside qemu
on top of a bcachefs host?

> Further digging implicates CONFIG_COMPACTION or CONFIG_MIGRATION.
> 
> Testing with COMPACTION, MIGRATION=n and TRANSPARENT_HUGEPAGE=y passes
> reliably.
> 
> On the bcachefs side, I've been testing with that patch reduced to just
> "don't take inode lock if not extending"; i.e. killing the fancy stuff
> to preserve write atomicity. It really does appear to be "don't take
> inode lock -> dirty folios get dropped".
> 
> It's not a race with truncate, or anything silly like that; bcachefs has
> the pagecache add lock, which serves here for locking vs. truncate.
> 
> So - this is a real head scratcher. The inode lock really doesn't do
> much in IO paths, it's there for synchronization with truncate and write
> vs. write atomicity - the mm paths know nothing about it. Page
> fault/mkwrite paths don't take it at all; a buffered non-extending write
> should be able to work similarly: the folio lock should be entirely
> sufficient here.
> 
> Anyone got any bright ideas?

No, but I'm going to sleep on it.

