Return-Path: <linux-fsdevel+bounces-2540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303277E6D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909E4B20CC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16362032A;
	Thu,  9 Nov 2023 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C0nU4zM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F6F20321
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:37:03 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B061FF3;
	Thu,  9 Nov 2023 07:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NFkxRWLuyVaV5/yNfiI+b9FYk59N9eHUD1UJ8k1Z614=; b=C0nU4zM0T0T6q/7Qvr8X7IG/y3
	OkPoel1ipzsmpCRIxUDl6YpjY3bCAU06orKheElFPV+a6RT5JaI5YDAHjxMacFYzAs504gfxFcRRA
	mmWpexVWorumSWIXjTmiqUh/SSpYnObfImSbEzqthgXmZDFBjaoegrH+8nSxjOpfLXZ18K0qzFhFu
	z8hdk3zsKGbxybdxwvj98hBhYE8rziJu+5II3xY/LpwfxtbU2i882ubzBF0N1vB9a6VZkO8plQStE
	L+F8kQA0fRD/z4JLgELMaNap5hmobTKe74W5iWLFCAATx6gsTyGIoIYImv+H5dJIg47S3njqr0y6J
	jrMKzUGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r175N-0082n4-PC; Thu, 09 Nov 2023 15:36:49 +0000
Date: Thu, 9 Nov 2023 15:36:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Xie <xiehuan09@gmail.com>
Cc: Jeff Xie <jeff.xie@linux.dev>, akpm@linux-foundation.org,
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	chensong_2000@189.cn
Subject: Re: [RFC][PATCH 1/4] mm, page_owner: add folio allocate post
 callback for struct page_owner to make the owner clearer
Message-ID: <ZUz8kTx1eNQkkbFc@casper.infradead.org>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-2-jeff.xie@linux.dev>
 <ZUzl0U++a5fRpCQm@casper.infradead.org>
 <CAEr6+EB5q3ksmgYruOVngiwf6KJcrzABchd=Osyk0MiVDGQyQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEr6+EB5q3ksmgYruOVngiwf6KJcrzABchd=Osyk0MiVDGQyQQ@mail.gmail.com>

On Thu, Nov 09, 2023 at 11:25:18PM +0800, Jeff Xie wrote:
> >From the perspective of a folio, it cannot obtain information about
> all the situations in which folios are allocated.
> If we want to determine whether a folio is related to vmalloc or
> kernel_stack or the other memory allocation process,
> using just a folio parameter is not sufficient. To achieve this goal,
> we can add a callback function to provide more extensibility and
> information.

But we want that anyway (or at least I do).  You're right that vmalloc
pages are not marked as being vmalloc pages and don't contain the
information about which vmalloc area they belong to.  I've talked about
ways we can add that information to folios in the past, but I have a lot
of other projects I'm working on.  Are you interested in doing that?

