Return-Path: <linux-fsdevel+bounces-10392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D337084AA43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FDFB21F23
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836047F71;
	Mon,  5 Feb 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gjvN0RdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE7482F0;
	Mon,  5 Feb 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174497; cv=none; b=AiaK3jHuRaoBVySqXVRwH25/rsoBquzhE1vzuQbrxcrmbb2nkbTRXRcQiJqKbtUCX58CSdlB5Po2vfbtFx/YBtSy8PNLAt+DWlz1Gg1tRvd8cv0+o8+hwjUIr11j4N38UWRSvNA1+4QziSD7ZIRQDZ5z/ns6RysC+vb0nBAy/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174497; c=relaxed/simple;
	bh=xuDmFQSWGlQWb6duBmXc34XJaq9eqcK4l/dLZuW5nP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYbxYzmRucS2+cquo8ZNFNsH82eO5bKGUdcwnIv7sjSMfyWJVOfTjTm8TYwIFoU2GaK0MU9JNpYPrHtZ6+Xrj1TCtF5Hqsv0oQ8teR2uY4ofkUyQFm/w7kDlgpP1B646Aqsh+P3IeRlmXVT8Et5GPwZGcuIDsKqyheAUuTMUO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gjvN0RdJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Nztq3kAKxiN7XZ+pUFMrtGoSQCmAM3BMqRaoiMZEu0=; b=gjvN0RdJ5BQAJPPtsuIJEMkWIm
	UH7igtwCP8GH/tjcpDdA4n8J63nSPTOfOAczSD9S6tlSSKQPATjpOXpj6KXwliUguwyXRTYtF0C4d
	8uwfKmw3nZRI1HI+7j0Aia7GDNPxZlo3I+TL1scE5mk4WSgivL5KZK77V8xmspJYAXzGQ1/a1imLk
	+6pJl7uee9flJs8Fj/CXwp36v2GS6F5g9NNYXyXl8M5mS2xQR0CAR9yqZQQJYELQAMKgRH2aST+52
	7nxk0KqviKqcghKQkZwvOJ4byVSUDpmCdSokZeWJQd6Hiudlx1PgGSSL/tXiusEWmNG3Q8pen44H1
	bDBmqYNg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX84Q-0000000Afhw-1S2j;
	Mon, 05 Feb 2024 23:08:10 +0000
Date: Mon, 5 Feb 2024 23:08:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: JonasZhou <jonaszhou-oc@zhaoxin.com>
Cc: CobeChen@zhaoxin.com, JonasZhou@zhaoxin.com, LouisQi@zhaoxin.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <ZcFqWifk2cBExIvG@casper.infradead.org>
References: <Zb1DVNGaorZCDS7R@casper.infradead.org>
 <20240205062229.5283-1-jonaszhou-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205062229.5283-1-jonaszhou-oc@zhaoxin.com>

On Mon, Feb 05, 2024 at 02:22:29PM +0800, JonasZhou wrote:
> When running UnixBench/execl, each execl process repeatedly performs 
> i_mmap_lock_write -> vma_interval_tree_remove/insert -> 
> i_mmap_unlock_write. As indicated below, when i_mmap and i_mmap_rwsem 
> are in the same CACHE Line, there will be more HITM.

(I wasn't familiar with the term HITM.  For anyone else who's
unfamiliar, this appears to mean a HIT in another core's cache, which
has the cachline in the Modified state)

> Func0: i_mmap_lock_write
> Func1: vma_interval_tree_remove/insert
> Func2: i_mmap_unlock_write
> In the same CACHE Line
> Process A | Process B | Process C | Process D | CACHE Line state 
> ----------+-----------+-----------+-----------+-----------------
> Func0     |           |           |           | I->M
>           | Func0     |           |           | HITM M->S
> Func1     |           |           |           | may change to M
>           |           | Func0     |           | HITM M->S
> Func2     |           |           |           | S->M
>           |           |           | Func0     | HITM M->S
> 
> In different CACHE Lines
> Process A | Process B | Process C | Process D | CACHE Line state 
> ----------+-----------+-----------+-----------+-----------------
> Func0     |           |           |           | I->M
>           | Func0     |           |           | HITM M->S
> Func1     |           |           |           | 
>           |           | Func0     |           | S->S
> Func2     |           |           |           | S->M
>           |           |           | Func0     | HITM M->S
> 
> The same issue will occur in Unixbench/shell because the shell 
> launches a lot of shell commands, loads executable files and dynamic 
> libraries into memory, execute, and exit.

OK, I see.

> Yes, his commit has been merged into the Linux kernel, but there 
> is an issue. After moving i_mmap_rwsem below flags, there is a 
> 32-byte gap between i_mmap_rwsem and i_mmap. However, the struct 
> address_space is aligned to sizeof(long), which is 8 on the x86-64 
> architecture. As a result, i_mmap_rwsem and i_mmap may be placed on 
> the same CACHE Line, causing a false sharing problem. This issue has 
> been observed using the perf c2c tool.

Got it.  OK, let's put this patch in.  It's a stopgap measure, clearly.
I'll reply to Dave's email with a longer term solution.

