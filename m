Return-Path: <linux-fsdevel+bounces-7835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB682B7D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 00:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5128A340
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7A5810E;
	Thu, 11 Jan 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TvrWFyKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FD537FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VTRlnr7nTsltwjauiUwkQ3mYBh3OaNcgbyMuz/Pdong=; b=TvrWFyKE+rnrzg4URzp5YFvz3L
	8o8sjzCRkYmV4NCK1bBgHeyoh771KfGPpwxfcafQvFILyYYEZG/tK01FmoqtzK6956C+dGIMEAiB8
	ZbHgXDhvBFRICys8zCAxlJJKDXrTq4bUQVffHcTlYsKJe0y1HgfXdBgSsnDdIPHgeeO/7reJ7SamD
	IIE3RqeiV7UCSb9CweaQp6wLuKlOpTlEG6Se6I+sx+UZ1GxTTz2yk0EA1IBXUGW1NsUAC6glXOd5+
	DW0gZQWvVR8WyADFmyG9pUlo1TvCGMJmIuzNXifZnVwyi1gdPOJGNfXINQ7W8qaX1UambaANaanFH
	PQ+K+GUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rO45C-00FDK3-K8; Thu, 11 Jan 2024 23:03:30 +0000
Date: Thu, 11 Jan 2024 23:03:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: Convert generic_perform_write() to support
 large folios
Message-ID: <ZaBzwtC/o+JA3wVU@casper.infradead.org>
References: <20240111192513.3505769-1-willy@infradead.org>
 <ZaBIFPQqzWHnaeaX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaBIFPQqzWHnaeaX@casper.infradead.org>

On Thu, Jan 11, 2024 at 07:57:08PM +0000, Matthew Wilcox wrote:
> I'm just doing an xfstests run now, but I think this will fix the problem
> (it's up to 400 seconds after crashing at 6 seconds the first time).
> Essentially if we pass in a length larger than the folio we find, we
> just clamp the amount of work we do to the size of the folio.

No, that's not enough.  It dies in submit_bh_wbc() at the
BUG_ON(buffer_delay(bh));  I have no idea why.

Since Dave tells me he's not using generic_perform_write(), and the only
possible user would be the bs>PS work, I'm going to abandon this for now.

