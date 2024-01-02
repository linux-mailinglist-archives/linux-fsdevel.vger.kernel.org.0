Return-Path: <linux-fsdevel+bounces-7074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912188218D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C745283C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864EE544;
	Tue,  2 Jan 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAUtDYOW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410FADF61;
	Tue,  2 Jan 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uPWAKkXOKfryzl9yN1UKKSOG50U5J8qvhPQ1ksSNgUo=; b=HAUtDYOWMfKlLCC7XMD7oOKxjw
	cnguEIKvS62b8o0SlmshYVvIvr8OZE35XKI2L4ALaq4zgHnVxp2HQ9nllfD3QzqtllRTclMAJq34h
	P5Tx3LDtMmTBLGZHqbXvrx1zF38bIFPiXm/Ru4jtDIdUNmLU07AZA3iBq2hZVUGPO6W3HprNSkclv
	eMWzu8qu4hTW1LLtWxRyIAZ4ChuIRJ2uRfqaVdKG6kCGTodIDsZJkkGEd/OuOYouXApBmCJPH/aQk
	UZQfJyMk5hvlGJiCXF+BFcB5rjB9547OPEyLPE7z/XifJEDJgvjEYPQilGkFcfnjND5DOdvm6pJu2
	ZyKNt1zA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKaro-009pvp-PQ; Tue, 02 Jan 2024 09:15:20 +0000
Date: Tue, 2 Jan 2024 09:15:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: bio_vec, bv_page and folios
Message-ID: <ZZPUKHTQ//eL53SM@casper.infradead.org>
References: <3490948.1704185806@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3490948.1704185806@warthog.procyon.org.uk>

On Tue, Jan 02, 2024 at 08:56:46AM +0000, David Howells wrote:
> Hi Christoph, Willy,
> 
> Will bv_page in struct bio_vec ever become a folio pointer rather than I page
> pointer?  I'm guessing not as it still presumably needs to be able to point to
> non-folio pages.

My plan for bio_vec is that it becomes phyr -- a physical address +
length.  No more page or folio reference.

