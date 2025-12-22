Return-Path: <linux-fsdevel+bounces-71815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F1CD4B94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 06:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B2630071BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 05:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92F93016FC;
	Mon, 22 Dec 2025 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pQF//HiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432254315A;
	Mon, 22 Dec 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766381630; cv=none; b=hlR40eyrwNuQkIK5J1rXviatctwtbAKqrHga9uOSI6ehJouPUhmevuO50BYceB0/T73IQpNWItUBIBWR9dm6A3dnVfgJ1GsS7XbB2OfX5sJ9zblNPyAq8Br2q2wkDnvLHMH1dBbb1rME6UZ9oy0ImLAzUzkGXzAfwP2oLRL+9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766381630; c=relaxed/simple;
	bh=WqZBLKt8tPM9HLszScTCS7qvowupT4oNXxuCDquMDxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvA4M/3FR1P9b/z+sTARWWxXU6j1RRXIQlYEK7o7ZD0yJ77QYB5fu0Or+KBoOijJak9kDCZgHzUdHDg6nFY4ewI6GPgzpT1I0rx1gKkq7rHC8r+5g6v/xOgWHIqe1cH0ic70BZNnu9CNR44KokVqA6CkF17r3UQi2NndSGm/0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pQF//HiM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OIs6CFP5A9jSluqCx+18mI7gmdKlhYCYgDLoMvNckcU=; b=pQF//HiMUm3sOW88A16V4T6naV
	EjFN+hH0XDDpxid8DYmvlJmgneugAt4nTItrAxHWZfblbwt9mrFqhhCglEYhlLongrNvER+vsY6xz
	XSAnM6xlJzy8ynCZOezXIp56ubY6IFwFGLHk1SqnhSd/7zciM8J4ThSflEUJnP4xNXt143NxpQOds
	Zw8bdSB2li230hMTcC8SlIrQ5DoDfOGjHL39XPp/N8/B7qGzQmzIHsuQIQoA1TQEdQ+VvesdDn7U5
	6svUwlIhCZaHcLeq2HqLYWM77rrqBja/Dj3v/lOoS3pkSBA9CUgUbx5JR/YAnQRIdAt63cUsbu/YI
	RA2HwDZg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXYYA-0000000BFzx-0oyw;
	Mon, 22 Dec 2025 05:33:42 +0000
Date: Mon, 22 Dec 2025 05:33:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH bpf v2] lib/buildid: use __kernel_read() for sleepable
 context
Message-ID: <aUjYNUNygZh87Yih@casper.infradead.org>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
 <aUSUe9jHnYJ577Gh@casper.infradead.org>
 <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>
 <aUTPl35UPcjc66l3@casper.infradead.org>
 <64muytpsnwmjcnc5szbz4gfnh2owgorsfdl5zmomtykptfry4s@tuajoyqmulqc>
 <CAEf4BzY2YYJJsMx8BgkKk7BG67pj52stv_GRGwZkj3jnuipw+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY2YYJJsMx8BgkKk7BG67pj52stv_GRGwZkj3jnuipw+Q@mail.gmail.com>

On Fri, Dec 19, 2025 at 09:42:13AM -0800, Andrii Nakryiko wrote:
> From a user perspective, I'd very much appreciate it if I get exactly
> the requested amount of bytes from freader_fetch_sync(), so yeah,
> let's please keep the loop. It does seem that ret <= 0 handling is
> correct and should not result in an endless loop.

No, you don't understand.  If __kernel_read() doesn't get all the data in
one call, it's not there to get.  If a partial amount of data is useful
(I suspect not), we can return it, otherwise an error is the way to go.
The loop just betrays a lack of understanding of the VFS.

