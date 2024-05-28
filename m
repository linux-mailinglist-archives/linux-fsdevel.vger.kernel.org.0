Return-Path: <linux-fsdevel+bounces-20367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F37C8D21FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04A02865B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9A173342;
	Tue, 28 May 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eXSHGh1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DC173320;
	Tue, 28 May 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915051; cv=none; b=M7Hv3WjoWDqvGQ6O9qLTJiw7JUCDlAX7pwBjeza++vQBKMfNprHmh0sQYjfiZzVIPOM5fwot0XHM4gt2bs2q8AiAehkXhvJcp4zMnD4k5ksqxORClD1q1/Q+oTuBfxDkaH/aHswRi5h9G969cj6OQhVvSMX64MnDyHYqlfsbYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915051; c=relaxed/simple;
	bh=JAzCKYhJiRdsOP574Hm7UVE9hmhk0rucPt/WJiZzrX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWzJhF7OtERUJOhbma7FnYjHZj1+46H/t2Hco9Beud8SUaXsTwNX9yv+y+vYsp2bCC9iB17qmCuzZ5cQvVTnXiczPBKrnJ5fChP2F89OteS40BoRwbR9MA1RGGG70Pso+Z/T85kCQ/F+T0jJD8tS6xFBvyQtEoibdPkQWO1Eh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eXSHGh1p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lNjknxnwxTUc0vLbaKhHCJ/HfoVv19mC8Y/io4dSkrM=; b=eXSHGh1pu3Y0oVrjs+ehYMr+Vn
	3SNZe7TkBOw8HLw2mwAHG0EhgvKhX9KaJoPbU9WPleYnq6Fl+mdPBuFCoZ4pAft4Iqc/jlUoM9kMs
	nZHMZIz7/tv2t4U5qe7H7jCDwFSQ6D1aTFv+PsJA0jYvE6j3aM4LK16bZ9lV69cfwgvHT0Kc0bug2
	Y+AeBLKIkUZaQzSt47EOX0yicsdNlR92uWYzZjbDA4HfSZpv/xMrpKdOWTzKfu7u70+0MIcpkdRe2
	wnozIUyx6q3GVNoQx4MDeGFJP4DUePcnAnDOOCHx7xi1iV3WLelNMb7CKYDEO6VoWGDiW/nrHZSBY
	fbwEjUXw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC028-00000008poX-0yzU;
	Tue, 28 May 2024 16:50:44 +0000
Date: Tue, 28 May 2024 17:50:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to support
 large folios
Message-ID: <ZlYLZDG_D74AtW5M@casper.infradead.org>
References: <20240527163616.1135968-1-hch@lst.de>
 <20240527163616.1135968-2-hch@lst.de>
 <CGME20240528152340eucas1p17ba2ad78d8ea869ef44cdeedb2601f80@eucas1p1.samsung.com>
 <gh7wdpeqorbtvbywigkzy3fakb7a4e46y6h6nrusn6rmup6yfm@2rjq4ltwmdq4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gh7wdpeqorbtvbywigkzy3fakb7a4e46y6h6nrusn6rmup6yfm@2rjq4ltwmdq4>

On Tue, May 28, 2024 at 03:23:39PM +0000, Daniel Gomez wrote:
> I have the same patch for shmem and large folios tree. That was the last piece
> needed for getting better performance results. However, it is also needed to
> support folios in the write_begin() and write_end() callbacks.

I don't think it's *needed*.  It's nice!  But clearly not necessary
since Christoph made nfs work without doing that.

> In order to avoid
> making them local to shmem, how should we do the transition to folios in these
> 2 callbacks? I was looking into aops->read_folio approach but what do you think?

See the v2 of buffer_write_operations that I just posted.  I was waiting
for feedback from Christoph on the revised method for passing fsdata
around, but I may as well just post a v2 and see what happens.

