Return-Path: <linux-fsdevel+bounces-71710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE51CCE6A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 05:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB70230539A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6426C3AE;
	Fri, 19 Dec 2025 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o3ZHtDLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE822FE11;
	Fri, 19 Dec 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766117283; cv=none; b=d92ewogDiig1/g+H9Am9rN8OIKQ6teoGrbB73I02Ua0zRnezT3rq9mFeQgrm0s6pBDrpNOI1rlTIgaslizRifVRq2Si36LTNNJyigopZdwJzVf84dQCPbqN2uU/GJEJ8heLuUy8AlnorUtfAZqgm3L26BnonJ7scBKkjbCBZbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766117283; c=relaxed/simple;
	bh=ZPW3xgIvwGKMpz91t2evFYm0Q4dHfOw5xBl9i4Mesbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkvvlylaKRCl7oVtdS9f52iRih/PwGBomnKVq9KPzucvIe/+T+usVraRE9xjEVWfW1YRnM+LG0k4ljDi9xSiR9Z9NAxiG7TEajq6NGaKtCRu3fjniRmYVqu5duinRN2ON58rE1tnB7GTYYTkWZbOTuFOY+AMN8b6l9LCMcUpuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o3ZHtDLv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eCD1IBdj7ODKaeO2jXui4z4Z/L646xCoFb81QN9gPBM=; b=o3ZHtDLvF+Gw0VgM1ijzs6p5Yf
	s7behnjZvQy0gGmbBdkrJBjVQWiIjtRxDQVx2MdQHYwuHrQiD3SP1ieVTwPVqJymDs5fgnNuugwfm
	elP6tKuw7GZyHU4v9AGo5aa441ONdXY+iesx9/A464rih/SqZSte295FrlGrKOdKgZckPG+vJUGdM
	TtzWJpXUA49f1V/TGuvEyQJCsQSmpmz8f5YLvm1Z+ddZIg3Lrp+JbTJuRQVTQqg2Z7orVQmbh0yxn
	cask8wscp2V+WoVlLZ8/JB4WYuFC6s9bp1ZceNAntpezzZ8AfP3KxrtACOL+bpvrWh2M1Z5EWYpgk
	82wnOljA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWRmR-000000072ZY-1zCI;
	Fri, 19 Dec 2025 04:07:51 +0000
Date: Fri, 19 Dec 2025 04:07:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <aUTPl35UPcjc66l3@casper.infradead.org>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
 <aUSUe9jHnYJ577Gh@casper.infradead.org>
 <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>

On Thu, Dec 18, 2025 at 04:16:40PM -0800, Shakeel Butt wrote:
> On Thu, Dec 18, 2025 at 11:55:39PM +0000, Matthew Wilcox wrote:
> > On Thu, Dec 18, 2025 at 12:55:05PM -0800, Shakeel Butt wrote:
> > > +	do {
> > > +		ret = __kernel_read(r->file, buf, sz, &pos);
> > > +		if (ret <= 0) {
> > > +			r->err = ret ?: -EIO;
> > > +			return NULL;
> > > +		}
> > > +		buf += ret;
> > > +		sz -= ret;
> > > +	} while (sz > 0);
> > 
> > Why are you doing a loop around __kernel_read()?  eg kernel_read() does
> > not do a read around __kernel_read().  The callers of kernel_read()
> > don't do a loop either.  So what makes you think it needs to have a loop
> > around it?
> 
> I am assuming that __kernel_read() can return less data than the
> requested. Is that assumption incorrect?

I think it can, but I don't think a second call will get any more data.
For example, it could hit EOF.  What led you to think that calling it in
a loop was the right approach?

