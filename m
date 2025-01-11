Return-Path: <linux-fsdevel+bounces-38953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7CFA0A525
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 18:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815551889917
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7D61B424E;
	Sat, 11 Jan 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TM+5lBWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041EC1B424A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jan 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736618317; cv=none; b=OGnbcch1nfg9vRSj38UuPQbNMiyi8KzNPGV04Qyv2InECEzwdcMbE55QeXDwXrWJHk+GKLipREcmG4Xw71oL3PoFPls3xBswPBWWPuRFzXtBeCOPjS9AjJ081e0jrMvoQqoM/4YB94MP/xaoJK7k5N8dAv00DNt4kbXpD4Wn5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736618317; c=relaxed/simple;
	bh=1keDDxA0XuRXDfT/S5iNhaK9eZLl/lk005Ox1AcD6Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhV5mE4PEBdWMJauFhc3t50ZlK//JTjOqeHvKdlDy3JX23Fy9a9Gk8edG6ptMH3H78KqTqEmBUzC+Z3ErYujTqgUrZ0a/tFJBTDfo2Jk0aKTNmCavMCy9FzB7eLJPDdyVj2puhoCy9il7gJP7QqFdfnHHDJ1pOHczo5dkOiQDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TM+5lBWo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gDP2rkKKQtBaLbOL9OpXTvDsGssxcS6T4UgYMd+zd2o=; b=TM+5lBWo1bDzyZ620+2CXerYEF
	q1YNTlcpH/RjwUMphuiXxxKlFWoj8weTY5PQFnG6LJex0ExVYy/3mzG4s7mNegq5v8CFJwxBwmsCm
	JzbWNcyry0kNs2HYMe4egUptLt8844dqvwW14QTIwBi7rCN9CY7gg9D6N8Boq20M1HTOFHJJ4goZk
	1dElQZFiB9iubewANMFy65Mr7DGDaRFq4MGEMUa/kv3/gmsjyy/cbLCdRXTwLIYRFyae/a+TsTxJ0
	fQLZvfZP3c3FshahWL97VJ8sRHvg007b31FN3oWh7t0xDK+IQSvvOwK4CqIzdbZcKh2zDw2An6S78
	DNYJlZqg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWfkn-0000000Fb4e-0Hu9;
	Sat, 11 Jan 2025 17:58:33 +0000
Date: Sat, 11 Jan 2025 17:58:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	squashfs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] squashfs: Fix "convert squashfs_fill_page() to take
 a folio"
Message-ID: <Z4KxSBcKpwwr-WF2@casper.infradead.org>
References: <20250110163300.3346321-1-willy@infradead.org>
 <20250110163300.3346321-2-willy@infradead.org>
 <b9ce358d-4f67-48be-94b3-b65a17ef56f9@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ce358d-4f67-48be-94b3-b65a17ef56f9@arm.com>

On Sat, Jan 11, 2025 at 01:21:31PM +0000, Ryan Roberts wrote:
> On 10/01/2025 16:32, Matthew Wilcox (Oracle) wrote:
> > I got the polarity of "uptodate" wrong.  Rename it.  Thanks to
> > Ryan for testing; please fold into above named patch, and he'd like
> > you to add
> > 
> > Tested-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> This is missing the change to folio_end_read() and the change for IS_ERR() that
> was in the version of the patch I tested. Just checking that those were handled
> separately in a thread I'm not CCed on?

https://lore.kernel.org/mm-commits/20250109043130.F38E0C4CED2@smtp.kernel.org/
https://lore.kernel.org/mm-commits/20250110232601.CBE47C4CED6@smtp.kernel.org/

Shouldn't be anything missing; I applied the first one to my tree,
then wrote the second one and the third one you're replying to.  Then
I did a git diff HEAD~3 and sent the result to you to test.

Has anything gone wrong in this process?

