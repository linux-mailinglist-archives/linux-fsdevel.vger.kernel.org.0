Return-Path: <linux-fsdevel+bounces-30423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E340598AEC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247A9B21D62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A161A254C;
	Mon, 30 Sep 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uQYqFNAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9BF17BB38;
	Mon, 30 Sep 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729827; cv=none; b=K4UnTYAwYmTupqvsvIBhw+wClKofRkWFO8tv1wJl+dzcLLU2DgqHx9dNtWRMhMfE52YaOLOoF5lcDP9UyOfzvgj+KEEdtC2F+Aaf6PDyaBtpHjrIqzvJ9Y6dozaIQd6nRs+bTUYsGs3m5KQLjeHr1eW1B3JDfzQBtcqFJ2+kQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729827; c=relaxed/simple;
	bh=oAnbrt3CNRO8/aNuu0f/1Al0yrakZS5BFEVOZbkrSsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Lve06OAyIzA1aACrNoc3HiTelf3RlqTmfvEsGPZLbyjhIYen9OxYzljdWAw/FfRAD27YvcuNj1ur8Y+s5c9sSqjoxmHZfR1FNVkIL33x4YQhN0LdSrv2Av8yckwF5ZFfvE5L7e9gcMUMALuic1vFe0eIf9+nzljre8ht7gUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uQYqFNAu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CYhZpytb38aFtb2OIz5EkmYbXp7wsTdiyaA1Hi7/lRY=; b=uQYqFNAujgk6D4yfw7K+xlhc+N
	s9mPV+J3PpTfHxSccYhnB2FyKGUifVBubSYz7Si8lA2eiYw/FGZ8LfAzL05fap14UMYO3sv7k6mbS
	uv+ctARlaq4JQPxDePMCfjp0vjG7Pn77oJ1/clzYyP+RHz3tAtwsTOKif9fTQC1egl2NpKr36By+4
	1DW1ISu+xyM2W7451yQy8gv/Qlg8ZEr+HLZBYkZZIS/qTAdR1dW2P5ccEFuXRIjmJpeNTVyu7MQVk
	HgjSuuL8i6l2Zocqb9+o/DmWZetyQhwRHCLiJj6bwravb8Qu4bsUmNdOnKPN5EMQcrNJi62vuVLKl
	M4PVNnCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svNRw-00000000cMU-3ST3;
	Mon, 30 Sep 2024 20:56:56 +0000
Date: Mon, 30 Sep 2024 21:56:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Theune <ct@flyingcircus.io>,
	Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>,
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZvsQmJM2q7zMf69e@casper.infradead.org>
References: <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
 <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
 <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com>
 <295BE120-8BF4-41AE-A506-3D6B10965F2B@flyingcircus.io>
 <CAHk-=wgF3LV2wuOYvd+gqri7=ZHfHjKpwLbdYjUnZpo49Hh4tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgF3LV2wuOYvd+gqri7=ZHfHjKpwLbdYjUnZpo49Hh4tA@mail.gmail.com>

On Mon, Sep 30, 2024 at 01:12:37PM -0700, Linus Torvalds wrote:
> It's basically been that way forever. The code has changed many times,
> but we've basically always had that "wait on bit will wait not until
> the next wakeup, but until it actually sees the bit being clear".
> 
> And by "always" I mean "going back at least to before the git tree". I
> didn't search further. It's not new.
> 
> The only reason I pointed at that (relatively recent) commit from 2021
> is that when we rewrote the page bit waiting logic (for some unrelated
> horrendous scalability issues with tens of thousands of pages on wait
> queues), the rewritten code _tried_ to not do it, and instead go "we
> were woken up by a bit clear op, so now we've waited enough".
> 
> And that then caused problems as explained in that commit c2407cf7d22d
> ("mm: make wait_on_page_writeback() wait for multiple pending
> writebacks") because the wakeups aren't atomic wrt the actual bit
> setting/clearing/testing.

Could we break out if folio->mapping has changed?  Clearly if it has,
we're no longer waiting for the folio we thought we were waiting for,
but for a folio which now belongs to a different file.

maybe this:

+void __folio_wait_writeback(struct address_space *mapping, struct folio *folio)
+{
+       while (folio_test_writeback(folio) && folio->mapping == mapping) {
+               trace_folio_wait_writeback(folio, mapping);
+               folio_wait_bit(folio, PG_writeback);
+       }
+}

[...]

 void folio_wait_writeback(struct folio *folio)
 {
-       while (folio_test_writeback(folio)) {
-               trace_folio_wait_writeback(folio, folio_mapping(folio));
-               folio_wait_bit(folio, PG_writeback);
-       }
+       __folio_wait_writeback(folio->mapping, folio);
 }


