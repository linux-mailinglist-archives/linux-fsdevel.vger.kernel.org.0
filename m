Return-Path: <linux-fsdevel+bounces-81-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B07C5836
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3D92824DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3EE208CC;
	Wed, 11 Oct 2023 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ByrDNLUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12C2031D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:38:59 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C7C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tyAX2GGF5WV240iVniNWqH70mmnkZ8EoftydcTqoRKs=; b=ByrDNLUeJNS5wpOghIhDAouuur
	Ct9PPm4xWoE/kiQP7Mlek48tP8QrkvBPP5aZQud7MwPU5V/azcHYawsH9V/fqdMNhHD7IFYLwRIaC
	oW2PvUELxU5gkxgWt/sUChk45kApxqa/DuachsU1SO24xRKCgEYHA25t4oGD5FIjUR4id6WaYeBCw
	db5XnYnCxeETBeHPJcHlHBx8GO2s9nFASyLBA61dcZezaODBO1ECqLlHFruYF2KgbHzP4jXBtp/37
	pJXFt0uSBw/w+//amHyL2fEbJc1c/6qU/pC2LZHZ+u9Kk6vpM3Kn7gLIkWQNy8yB9k6KuTUS/GFlQ
	7xEvqJpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qqbIP-00BYSn-BS; Wed, 11 Oct 2023 15:38:49 +0000
Date: Wed, 11 Oct 2023 16:38:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] xarray: Fix race in xas_find_chunk()
Message-ID: <ZSbBiQmx71u2RDdj@casper.infradead.org>
References: <20231011144320.29201-1-jack@suse.cz>
 <20231011150252.32737-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011150252.32737-2-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 05:02:32PM +0200, Jan Kara wrote:
> xas_find_chunk() can be called only under RCU protection and thus tags
> can be changing while it is working. Hence the code:
> 
> 	unsigned long data = *addr & (~0UL << offset);
> 	if (data)
> 		return __ffs(data);
> 
> is prone to 'data' being refetched from addr by the compiler and thus
> calling __ffs() with 0 argument and undefined results.
> 
> Fix the problem by removing XA_CHUNK_SIZE == BITS_PER_LONG special case
> completely. find_next_bit() gets this right and there's no performance
> difference because it is inline and has the very same special branch for
> const-sized bitmaps anyway.
> 
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> CC: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

