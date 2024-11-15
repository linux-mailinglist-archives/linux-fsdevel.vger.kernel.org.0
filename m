Return-Path: <linux-fsdevel+bounces-34988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF19CF650
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C729CB31087
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F11E231D;
	Fri, 15 Nov 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQ0d7QkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4871BF311
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703377; cv=none; b=ZP/aNk/l4w4+r+gYTvjYD0EFtetLHCqiyLeHuBGOAO4IWrktptqiK0zJcy9ksLdQCG0LmC+1LxKipIrWis8AJbRSbkmkoI4S8GEhhlsz7rgShanJfNR6UBBmPVCUudMFZf4pwAAsQa1ECf4YKpse78bhDYz2H3vrE3MYxQG6mWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703377; c=relaxed/simple;
	bh=wOK/nJUWEnYj7NP67rWfZNuE5FjsZswj8Tjl4tMsLT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZfcuq0ldvbPHe5va3S6njpemioHejuk2ZU1gToTo/HgfKhBnRQB9d1duB6ST3fpxx0p3HHCFH1h6e3PdFKoQjqxOuA4QMiRGkIokmYjbEdLZh5I1CZ0OsyHtEA+Vf9yfmHVuhDLeOeUbOmTjYKG1ZsS4bI0ZLdwLjwQ2cCuGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cQ0d7QkI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Udau28taO+dk6qlJGqZKI+ozWC4FiiVC9rX1a9wR6rU=; b=cQ0d7QkIQouEfr1G6WQGvUEIau
	9X4sPw4Qii79tMGstp+RDa82Jh9chi59VDdl1HyaoZJx4kDf3JRVy23l+r4omaqKb+oYxxoRrYa45
	I3M++aFHERDQrmJyEZN15XftjdpK8CSc5sv/ykuvhmbni8xptKMXq1DbJnrv6w0qtw24XYaO/F12M
	4mOkCX8lCTJZ4Z3Iln6P/dMCl4juIBw9fi4Iz7ProqEehO7HcTQJdASyTJBHWRrQHQqBqpgmLyjPm
	pah3qktlsR7ZVeXroK/o2Y82LUfgmgqyF9vxomvryUj/lM6kOTYNsG8q+a9rHaXK57fvMXafxHGTx
	n/R2rKPg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tC39V-00000000JAf-0LVg;
	Fri, 15 Nov 2024 20:42:49 +0000
Date: Fri, 15 Nov 2024 20:42:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Al Viro <viro@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <ZzeySEN5BYOuHsFG@casper.infradead.org>
References: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <ZkNQiWpTOZDMp3kS@bombadil.infradead.org>
 <CAHk-=wgfgdhfe=Dw_Tg=LgSd+FXzsikg3-+cH5uP_LoZGJoU0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfgdhfe=Dw_Tg=LgSd+FXzsikg3-+cH5uP_LoZGJoU0Q@mail.gmail.com>

On Fri, Nov 15, 2024 at 11:43:10AM -0800, Linus Torvalds wrote:
> And I did find that the "do small reads entirely under RCU" didn't
> test for one condition that filemap_get_read_batch() checked for: the
> xa_is_sibling() check.

I don't think you need it:

xas_load:
                entry = xas_descend(xas, node);

xas_descend:
        while (xa_is_sibling(entry)) {
                entry = xa_entry(xas->xa, node, offset);

so I don't think xa_is_sibling() can ever be true here.

xas_next() can return a sibling entry, so it does need the extra check.


