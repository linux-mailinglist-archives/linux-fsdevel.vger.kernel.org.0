Return-Path: <linux-fsdevel+bounces-2586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3637E6DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CB91C208DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC9208BE;
	Thu,  9 Nov 2023 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RMp53fB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692C1DA3A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:47:09 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE525BAE;
	Thu,  9 Nov 2023 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RKnP+XikWvj5vH2A63fow0gt1bMo8cosvQ7cojAZCBY=; b=RMp53fB80kcP5r6flXCQ4tPGXu
	jevpIs82pO2yzFksIH2PjBpSeiqxD/WKLSQiThwyyvQqrbu0+srS2w+iHTNeXYGjszUjg5Idw/cJM
	DoqV7+by3Pe/kb6Yi8pwRwSsGrFh5HGziplje2VWGlF70HcYUCWz9upb9x0MID4YE7NQFjQX2XWzv
	Ma3E3B6o5TH0jOgpsF3FMeO1qt7SkVITGnDdUbnw5x/As36fI9+/6HjCwItOigQRXb+xjIFe2eT+k
	1GkeOd/kRwI92cwyp1vjHrcz/NjK4f1p7wzQbDJb9OTInJaR44Pfuv1TcBk0CHl0o1yUKo84HYQ0l
	EAcMP5Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r17FC-0085bA-Vl; Thu, 09 Nov 2023 15:46:59 +0000
Date: Thu, 9 Nov 2023 15:46:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: jeff.xie@linux.dev
Cc: akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	chensong_2000@189.cn, xiehuan09@gmail.com
Subject: Re: [RFC][PATCH 3/4] filemap: implement filemap allocate post
 callback for page_owner
Message-ID: <ZUz+8nlEaRMU8QaO@casper.infradead.org>
References: <ZUzoAhpkrCNz9l1k@casper.infradead.org>
 <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-4-jeff.xie@linux.dev>
 <27f7b8c52e2da5e8003de2226bff181fdc7a7f69@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f7b8c52e2da5e8003de2226bff181fdc7a7f69@linux.dev>

On Thu, Nov 09, 2023 at 03:43:10PM +0000, jeff.xie@linux.dev wrote:
> November 9, 2023 at 10:09 PM, "Matthew Wilcox" <willy@infradead.org> wrote:
> > Why not just walk the rmap directly to find out where it's mapped in
> > any process instead of the one which allocated it?
> 
> Since the page_owner's result only shows which PID allocated this page, we only need to obtain the address space of the corresponding process for that PID.

But that's probably uninteresting.  Consider, eg, a page from libc.
That's going to be mapped by hundreds or even thousands of processes.
And the one which originally allocated it may well have exited by this
point; files often live long past the process that first reads them.

