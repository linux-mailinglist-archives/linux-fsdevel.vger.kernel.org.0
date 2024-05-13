Return-Path: <linux-fsdevel+bounces-19359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3978A8C39F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 03:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8FC1C20BC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 01:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27985C4E;
	Mon, 13 May 2024 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BYer6LtP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4521CD3C;
	Mon, 13 May 2024 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715565502; cv=none; b=tTafVkhvzQgdyzftLKyi3hkl2JL8ZAYSJBMm5e2IKre8Z2kgJEQqmVEXVDYmfE8tDXwnb8sgwSwNIqEi0AVp6z9lW4K007w8zRFsQ11BAAWy3piTr9F6Dy4xNVp7NUu2XFe3KFUT66zpiP88lBAt/4q4aZ77rBxS/mV3EXJnJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715565502; c=relaxed/simple;
	bh=fyY0P/QS5R7Bfe+5ZcrYudncU7jjbKFsnZi8VgoqjaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V11ed4SmL0f5MWI1jRqflwgLnGfvMaJXO4LGLLPqsWlOT+++IIMAWAzGteziIY9nymKFAgFxkHJxd8s8T3/vTNNhAYVj1bOpUcS7g48s2qnmEjRMCgNuCohz/SBDQgJx6DJh6ZXMvf5X5kYb/NALEuSA5mjMdEOCrJVRHo5us0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BYer6LtP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+pT0sFnbnn1DgXXIuOY5zjQhw9QepWjWMgcKH5jB72M=; b=BYer6LtPStmT5hBQU5725ABYVc
	6N70oIDS5bzoIx98v3HsQMBddbfcZkg8eK0HzzJnrSPStqb6vKFrwR9lOdZODBELZl/GkP7UXc4r2
	x+Mep9WPtYln0ONcqjOfI1Y7T/U4n4TpQQ7lo+VMLaRFrDe9I0VuwrbIarFYKH1kIn6igDb7OWSmW
	V0BMzTeJGL1wl7WJdEGhiAVwWo8dOxukMZbNY7n0wKQOWABURZ3OJyVg6xcccookXrTToUxsMUVpd
	Ng7/Q/RI0yYe8sUIT3ApcnU/8LskE/L0lLdOEd6cdC/WMcBdaTp0HurRlKggupc4E/wuHEAT1mK/5
	DnWqggIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6Kx7-00000007XJc-43Y1;
	Mon, 13 May 2024 01:58:09 +0000
Date: Mon, 13 May 2024 02:58:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org,
	kdevops@lists.linux.dev,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, linux-cxl@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: kdevops BoF at LSFMM
Message-ID: <ZkFzsT1cEztffVa4@casper.infradead.org>
References: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
 <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
 <Zjug3BqYyW3hrMdy@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjug3BqYyW3hrMdy@bombadil.infradead.org>

On Wed, May 08, 2024 at 08:57:16AM -0700, Luis Chamberlain wrote:
> It is up to them, I mean, I've started to work on mmtests integration
> so we can help test memory fragmentation, and plan is to integrate
> automation of maple tree and xarray shortly, mm folks are more than
> welcomed!

I don't see how kdevops integration of the radix tree, xarray and maple
tree test suite is useful.  It's a white-box test suite.  kdevops is
more suited for black-box testing like xfstests and mmtests.

When we find a problem in the various data structures through the black
box testing of their users (like the page cache or the VMA), it's on us
to add tests that exercise that functionality.  Like 2a0774c2886d.

The important thing is that the data structures by design don't depend
on much of the kernel.  So if they work in-and-of themselves, there's
not much to gain by doing tests in-kernel.

