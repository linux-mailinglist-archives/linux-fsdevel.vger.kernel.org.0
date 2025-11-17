Return-Path: <linux-fsdevel+bounces-68806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CBC668AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B72B5244EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9942E0B58;
	Mon, 17 Nov 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pR+/MY0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43626F2A6;
	Mon, 17 Nov 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421772; cv=none; b=kJMkvYx/PRl3OU70sNZtqz35MF8y1nfhn3nhSFbeXa1eMKTbDZpyruRPUtioj/Ai9H8G2kjZYwDGEJoukuBeyThdZVNxFhdKrxnu0plLJpd4jwRubOgUaC0rhljejtqlg96+PQMGRgTsi+Lo7qVwdjtROhPnj8MmVciD1xkVVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421772; c=relaxed/simple;
	bh=vscYXsShR3zS38L6ZAcZEBYlJOiAMQClv58NAd43y/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu18RrP1Ad6ZTDaumVmTP9ZWzVzb5xMZnopqMQnnSchUrrutWFugBR2U5ry1wJVdLWbOlPSxnkNCkcUuhYW3rGv5ulugoByvheb3BkTNmwWHXL7Ulr88KyEZiw9OuoJEjEvFHji/Cmh4EIvIilwwEa8RAYN56FhZFrXW6fuVDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pR+/MY0Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2tW51k/48tIPIeu/OA5C8tFspHqOenqhYuYE1vLb6mk=; b=pR+/MY0Qaw1o61uWOSxUf1fOTO
	rVCl2RdEbFl5fqSjcqYn0uYhBgBMMOQrSZdd1WEcikQcpc4m21mUTaoEXhTrHGm+mSSLaPWip44dt
	FzDoES5HUEHizaSBHcqZBXN/ghiiH+YPnRgmm41Xvx/srSa1r+od8ux1+ku/DeboOgbkBX0fk2877
	wAZuPLFEBq2RQpIDBBexqUh8x0hSU2iyL3jqt4Gyfg7VGrWlAncEw98XGrw94y0sXrOFvM+tvBFQH
	qbE71HhdMq4bJc9YSbEpoCbpKb+MvPQ5UvfP3TeHxBfy09zEoaKS80ozzt0TZ2vUCn5bQQwxpxm86
	kGRhyNTg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL8YW-0000000EZso-3OIP;
	Mon, 17 Nov 2025 23:22:44 +0000
Date: Mon, 17 Nov 2025 23:22:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
	michael.roth@amd.com, vannapurve@google.com
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting
 arbitrarily large entries
Message-ID: <aRuuRGxw2vuXcVv6@casper.infradead.org>
References: <20251117224701.1279139-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117224701.1279139-1-ackerleytng@google.com>

On Mon, Nov 17, 2025 at 02:46:57PM -0800, Ackerley Tng wrote:
> guest_memfd is planning to store huge pages in the filemap, and
> guest_memfd's use of huge pages involves splitting of huge pages into
> individual pages. Splitting of huge pages also involves splitting of
> the filemap entries for the pages being split.

Hm, I'm not most concerned about the number of nodes you're allocating.
I'm most concerned that, once we have memdescs, splitting a 1GB page
into 512 * 512 4kB pages is going to involve allocating about 20MB
of memory (80 bytes * 512 * 512).  Is this necessary to do all at once?

