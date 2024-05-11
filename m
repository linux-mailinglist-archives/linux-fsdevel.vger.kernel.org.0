Return-Path: <linux-fsdevel+bounces-19322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB128C3242
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE851F21AAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1456766;
	Sat, 11 May 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AIOfS7zl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAC56759
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443144; cv=none; b=tDCsjoq59VbFeXp6x/pUPawLcrW0xgfNdPXTNelg3z0hJy+S8DHU+zblxeTRWV9iv7rvxFKMswUg92MTIAetFg/WjU5ZzxRhpPFWAsCI3j3na+60dY+U/EZp/TaBRHAyre/LQDBVbsjMYIK4rodmYEGTqjO+9l/1TqBFTrJizyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443144; c=relaxed/simple;
	bh=osrocCXmUNVWie8FlSiyQRe6jjKRwqnpAxJarnfK1q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQwd88sog0tjEu90Pkqj4T+CqUB8gnWZ+vpDUhmqRgKY0ZHb/QxDneSuY3r29DIZS3dEQH4ZFxBYMd0XczUlgRqgOnqGQ//F0AqAQhVxiASSk6dKXMJ99w07DDhdhwaQMNwPh+R1c8we3pfUGqqUS3nV/0oGjzT93rwrQwbNF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AIOfS7zl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OZQbE3XQNmN4pJYb6MLugF+03DmcuANWaIMZ5MvlqXc=; b=AIOfS7zlQyUDj9IS8Z2PTS0ZKA
	2ilUqqA2kZlnlMLsM9ctQExU8+TjAI923Wv7/J1d6bGNhD6goJcrPdnwGqmDzak6sovJ/Q1CP7Dxo
	eaRdRGL21BjNChJaw0UPBLWuYbG3kwwP9j3ojKlRfINYcwvOxzD4myjjdkGjCzRc7I9442iWt8Xsr
	1ndOWln/0XK7eFrU+RYz5SeKBmsXaCxN8niKIbcz/DsqCUJniRpDJoaAsnWXLa4/YHbCZhsMmkx0P
	jn00NzBMYSXVSIbbu8M6H+OBrt2U1mm2vCMcVxIPJ+oCUxL6yrECfksDDhUWNLgh1Ih8fXxhDyvxu
	MGc2xHbw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5p7c-00000005cQg-3X45;
	Sat, 11 May 2024 15:58:52 +0000
Date: Sat, 11 May 2024 16:58:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>,
	Colin Walters <walters@verbum.org>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
Message-ID: <Zj-VvK237nNfMgys@casper.infradead.org>
References: <20240511022729.35144-1-laoar.shao@gmail.com>
 <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
 <bed71a80-b701-4d04-bf30-84f189c41b2c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed71a80-b701-4d04-bf30-84f189c41b2c@redhat.com>

On Sat, May 11, 2024 at 12:54:18AM -0400, Waiman Long wrote:
> I had suggested in the past to have a sysctl parameter to set a threshold on
> how many negative dentries (as a percentage of total system memory) are

Yes, but that's obviously bogus.  System memory is completely
uncorrelated with the optimum number of negative dentries to keep
around for workload performance.

Some multiple of "number of positive dentries" might make sense.


