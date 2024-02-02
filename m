Return-Path: <linux-fsdevel+bounces-10030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC6847281
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932821C21D55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C0F145341;
	Fri,  2 Feb 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ca5l3V6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743E41766;
	Fri,  2 Feb 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886240; cv=none; b=AEBZlJLAZGxOON4rQGutDmqNj3RxkEXYGR+3vHKa4P+Tsd/dpfqbcq1q1v+I3FpGUYgzOvK69lUS06wideKgu7uvf1Bxk4he+cqeQ/6BCpRHwF2nCatraH7zVat1If5KRW1dxuw4qtUUgafn8dQTWRZ1sf9XZVC/hhA6qGgt4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886240; c=relaxed/simple;
	bh=bG7tZJTitu5mna2D0nUxzyUXoNgmPMgUuBt+T8V3s9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeE8J+W4pX7Wd2843/0FIn0PRqJivfbUwRyGDWSQJK0jSBeVr+THst3dzIChIHeEgEqMoKedYKo9a1fd6FXd4CxX0AlFxyeZrAE+8+HMPyrkz5A2nMTH+o/9hoEGbN0lGSngCOEAKiQrjNgNhLGgva67XhvZm8ZW2lPMAJ2Iems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ca5l3V6j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XgWkmylmtJCHV/bvOe62Jxei6vo4+vXlT1wOK/22qQo=; b=Ca5l3V6jXt+Uz1VJMrcZkyvkSF
	yaSvU2QmTDjWw2UTNcHAoMhk1B2umw083a9CfMpavWzrOKi4nQfYhjLqcsmOzsp2kPGW8vI9RmU/t
	FC42bGKaJFyisfYlq88kxb4w1os7P7gzaVyuD+SuX1yoozxUJ9x00SJgged8Mf9JFFCc+ylDbTC6a
	3hzNcTR7NgimSJ8r52KZvUhiTgResKfKyBgvyEGZe7TdXm3+RWc6GecsLs+A0DlqB1vpoum3u9yiH
	0EGbct7sJKSpWfIvFxneofAAzYEJTk6a+0RUKdLtnx0w9DX3iSOO8JaNNxDQFhc9gRdNMVhKl3CVj
	2VBU3PjA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVv55-00000001L8U-27ip;
	Fri, 02 Feb 2024 15:03:51 +0000
Date: Fri, 2 Feb 2024 15:03:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	CobeChen@zhaoxin.com, LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <Zb0EV8rTpfJVNAJA@casper.infradead.org>
References: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>

On Fri, Feb 02, 2024 at 05:34:07PM +0800, JonasZhou-oc wrote:
> In the struct address_space, there is a 32-byte gap between i_mmap
> and i_mmap_rwsem. Due to the alignment of struct address_space
> variables to 8 bytes, in certain situations, i_mmap and
> i_mmap_rwsem may end up in the same CACHE line.
> 
> While running Unixbench/execl, we observe high false sharing issues
> when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> after i_private_list, ensuring a 64-byte gap between i_mmap and
> i_mmap_rwsem.

I'm confused.  i_mmap_rwsem protects i_mmap.  Usually you want the lock
and the thing it's protecting in the same cacheline.  Why is that not
the case here?


