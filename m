Return-Path: <linux-fsdevel+bounces-45382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1EAA76CDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADD03A7FB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFB2165F3;
	Mon, 31 Mar 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oXR5XqEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CB1D86DC;
	Mon, 31 Mar 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445471; cv=none; b=hpHQiLARkmq1527YVuQpBJpYxc+59wn/hRdMQqAiaqDN7trsUJZ+vVrZncNG/vf1yrYHTd6C5Laeu4pww+h5k/PDPkb4T+j3FwYhXzhSPJGnIY2gYrQz/u0sE8pwJBMANgG1boGwGIQpC2I9uS7MwBzL4BkqMq3F0/vCBuw+8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445471; c=relaxed/simple;
	bh=/OoLqC17kj12wDqfq3a1fHvRklEU4G7YwC/tD2Y/xWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8e/q/dbmI73b0pRZ9zhwoKpKCBNSZHPDqvIDgW+GuwJizwJtpNMlVlhxy6Yp7NHluuq22SOwxz66NCodw5o3//Bzcb4Ab/4vW2oo5B0BVLv7TfOiXcJUT9VRgrJQfilQoKV5S5+dVgeABzmBfEp9MMdpEP7LuhS3BX0j0dUMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oXR5XqEE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vWFEuEO/6YJYPBwwKhBAOHb1eqQNmBxHho1hmUZQsoI=; b=oXR5XqEEjcgfAd7B8Ov2hNAFIe
	jecO8Ffsz4DVviTdWCtZAZYg5VpHwlu/XuEsdMU/Ty+2GYG8DNjJnL1E+08fU4fXiugC2+DOz+RU3
	dZOsHNytAKX3gVc3DbQn93VucBZZyLbCfvTuCOz7ZvoDwTRzDKhFaCVAkKKsjQTsBblctaNuKoNXG
	wmSwkCQW79JYc+zWi4hqqFcqetvhsLR715UYpfpt35NfpPnxa0NeHnOk+HIvuVYKjupzh8rcFftx1
	ahsFYhG2YWObDPQGwYStrsO4GpdpNO7QQM9KJipr+Njh81nq00CJbaM2Y9d53P+3YR2+aZA+gS7mf
	L6MsyDZw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzJo9-00000001PEm-2dvX;
	Mon, 31 Mar 2025 18:24:25 +0000
Date: Mon, 31 Mar 2025 19:24:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] radix-tree: add missing cleanup.h
Message-ID: <Z-rd2arGtdpSgDdC@casper.infradead.org>
References: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>

On Fri, Mar 21, 2025 at 08:24:33PM +0000, Daniel Gomez wrote:
> Fixes: 6c8b0b835f00 ("perf/core: Simplify perf_pmu_register()")

Ugh.  I'm not happy that new functionality is being added to IDR.
Peter, why aren't you using an allocating XArray?


