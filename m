Return-Path: <linux-fsdevel+bounces-11468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD96853E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717CFB31C94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F56A01D;
	Tue, 13 Feb 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CPQtwNPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001C62A14;
	Tue, 13 Feb 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861948; cv=none; b=tLllnxk/OUppZBsDdS863ssU1jPjhgolSBTh1+shLz49GUD6yYMM2S/1zPTaz3nCJLchs6t/FIhLgx3sxtTLkh7bWt0rFWVOhH+J3VWw0vLjn/a8Hq68louQZ0/pt//xQFD6gBqmLFL1lFHpTH61IRdS6SfLj/BAosSqlJ5BxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861948; c=relaxed/simple;
	bh=DppRKrPmqw+3GKjCJBp1hknt3cyP9HMEeCzes6f3UmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRO9gXCXpLJlM1p0qaHiLzIY94I4qzSvmLngAFr5yNmkmkxpdPR9gJsy54YHFRmkstdgHOTuTA6hE1xyrGk78lsIYo5VUqmgO+dSMzdX9rnkRfkq6/c13gM0SxUe+ybieR4f5N5eifijFbA6npp34jagSBnvxwfrXgkyxJdcGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CPQtwNPy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JadPxG6WJhYUcvS6+IGeTjuA2qbpxxQZu/A1yx9oNs0=; b=CPQtwNPysUDgngBInSv6kmWZWN
	XjjxOCdU1RnMmnRTFinL1qVF0bVOMeUBB4THmC07L+mOS/XUH9oxBsZ5w7w0m45kVwz+oCC6ndU1e
	/8iHvlTqC0srnYNWT7WwqjKN683FnVWvUhHo6tUcXQkrBhQOtmvH2T+PZxm+oEKueUq88Ql6lFEPl
	KAwtbarvdKhop40jlDZYgmOHik9KeoHRVfCjg4Ppc0rXdsHGH9m+XwEqBn8GVQ/CaCFLqvxtPNz5z
	lMj03Q6Du7jkFhIbr3GdTUjgY8T213sBU9bUySaEBb88FimyLZUiwrUBc7XLuYm6bfNwpD7BfYaDz
	VwjAzbww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra0uJ-0000000Aypi-13wd;
	Tue, 13 Feb 2024 22:05:39 +0000
Date: Tue, 13 Feb 2024 14:05:39 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages
 (except order-1).
Message-ID: <Zcvns2HCB61cwvgE@bombadil.infradead.org>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213215520.1048625-6-zi.yan@sent.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Feb 13, 2024 at 04:55:18PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> Order-1 folio is not supported because _deferred_list, which is used by
> partially mapped folios, is stored in subpage 2 and an order-1 folio only
> has subpage 0 and 1.

The LBS patches has the patch from Matthew which enables and allowed us
to successfully test order 1. So this restriction could be dropped if
that gets merged.

  Luis

