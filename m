Return-Path: <linux-fsdevel+bounces-2727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFCF7E7CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BE2B20DD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40E1BDD0;
	Fri, 10 Nov 2023 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8Alpsjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9D1BDC9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 14:26:52 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985838E9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TsZMnjGVp8qJhJNF0D58M2qyhdRSxmBGHH5vXWhDKe4=; b=D8Alpsjs22WPFyB4sJsGyighsO
	xyPlhmHik+TPPC3bBHGoXb/ndJDcJhNNLoVDPX4i/lIeXlwjZ27I5jeq6GwiP10X+Bq80KFB/EfoJ
	vJ1wO8jqz5YOqp5R7a1ty3tBMgePquhVEbK4NXWHJl9obu4Nonf00Ifi3MEA0Ryi9SsWtNFQ2Bq5/
	XGS+gx6aoJp9JriiLMQYvUdZ/PPKySm245v8kLZCpniPpJ+0ze8idk9VXo7j77zezG6HqyCjyPWeH
	HheGU5FOoE0KXvRVd3mrTbFU7EzHDWPWd5F78d4gcvNI4qbwrigvT9Y6V5ETompIFPW1WGr+/MSBZ
	37mGJOpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1ST5-00Du4S-5L; Fri, 10 Nov 2023 14:26:43 +0000
Date: Fri, 10 Nov 2023 14:26:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] buffer: Fix more functions for block size >
 PAGE_SIZE
Message-ID: <ZU49o9oIfSc84pDt@casper.infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-8-willy@infradead.org>
 <20231110045019.GB6572@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110045019.GB6572@sol.localdomain>

On Thu, Nov 09, 2023 at 08:50:19PM -0800, Eric Biggers wrote:
> On Thu, Nov 09, 2023 at 09:06:08PM +0000, Matthew Wilcox (Oracle) wrote:
> > Replace the shift with a divide, which is probably cheaper than first
> > calculating the shift.
> 
> No.  The divs are almost certainly more expensive on most CPUs, especially when
> doing two of them.  On x86_64 for example, it will be two div instructions
> instead of one bsr and two shr instructions.  The two divs are much more costly.
> The block size is always a power of 2; we should take advantage of that.

I just looked it up and it's more expensive than I thought, but I don't
see a huge difference here.

DIV has a 23-cycle latency on Skylake (just to pick a relatively recent
CPU).  But it has reciprocal throughput of 6, so two DIVs have latency
of 29, not 46.  Unless the second DIV depends on the result of the first
(it doesn't).

BSF (the ffs instruction) has latency 3.  SHRD has latency 4, but the
SHR is going to depend on the output of the BSF, so they necessarily
add to 7 cycles latency.  SHR has reciprocal latency of 2, so
BSF,SHR,SHR will be 9 cycles.

So I've cost 20 cycles, which is about the cost of missing in the L1
cache and hitting in the L2 cache.  That doesn't feel too bad to me?
Would you want to invest more engineering time in changing it?

