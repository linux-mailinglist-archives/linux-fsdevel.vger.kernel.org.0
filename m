Return-Path: <linux-fsdevel+bounces-16499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24389E51A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB21B21B9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65D8158A3D;
	Tue,  9 Apr 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ud318HAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4D158A1E;
	Tue,  9 Apr 2024 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698969; cv=none; b=B/g0wp9WvgV+Od/BNwMG4GI7lPI4tHs2qnGayH2uQMVcBCJfFSAZkXKA8Sif3LYE8nNJSCQi4c0kjKW4JYQhfHMN8kXcN8FB/NdZhL5QyTpEdZDlX9VdrZ//tlpA5pymP9BCWPPIKRlxoM+kNDxNCb7AXw8BsTp2nls3ZaKKle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698969; c=relaxed/simple;
	bh=VnI1mV5conMscaAY6LWaUtz+ynM+a4jRDb2r1ctiVko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iil2HtdTAhX7w74xJYNazIAQAik0ZX86RJ7Wozax2ytUbpNR/vyF2H5sVAqWOXJONtcQyhrmw4JVdn6zjBgCwGGL2vX9mzzrupd5CS18JbawAZdXPFyhnz+IuUS4jb74LR+EyhytAVkhXMFttE8x67FzfRh/IIVZL1GEIaed50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ud318HAF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cAZm87PzI6fyQ1m2jU/2dvY7F4KiYWybRLHCj3v2RmA=; b=ud318HAFAMuxza1NMA5qxCWVYS
	Q3RQ7jjtcx3N5nPxhhPAR0r9nI5meQpupzsoLYg/sLklNXZGNvq4mJldoHmAZlB8EiPlc66C1enlq
	5v9zE4iPBgno4IMn85s2hY3bY/kxn2nymlq59ieFhSg6I4plV2yvY3X40V7jN6+qA4t8AL8cjDmKV
	QL1wHhqVrLEbkmzXAyAszoqKaMDh+yZfRq646kXMiDKPVWpKg079mOaofT7ZiO68GJv1A7tl2Inw5
	ry5F7XRa498awRyp/nbS9D2xQlZqxN9g3+IyGZhZ2iwmQQDGSZCm5jlUbR8JiU25qsEUpJwq5Ir6G
	6HhHRSJw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruJEb-00000002zqV-2c7l;
	Tue, 09 Apr 2024 21:42:29 +0000
Date: Tue, 9 Apr 2024 22:42:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>, Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: Re: [PATCH v1 01/18] mm: allow for detecting underflows with
 page_mapcount() again
Message-ID: <ZhW2RQtKDvUrbyWA@casper.infradead.org>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409192301.907377-2-david@redhat.com>

On Tue, Apr 09, 2024 at 09:22:44PM +0200, David Hildenbrand wrote:
> Commit 53277bcf126d ("mm: support page_mapcount() on page_has_type()
> pages") made it impossible to detect mapcount underflows by treating
> any negative raw mapcount value as a mapcount of 0.

Yes, but I don't think this is the right place to check for underflow.
We should be checking for that on modification, not on read.  I think
it's more important for page_mapcount() to be fast than a debugging aid.


