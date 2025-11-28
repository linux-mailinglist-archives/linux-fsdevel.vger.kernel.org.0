Return-Path: <linux-fsdevel+bounces-70180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0124C92D69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C02434E529E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E82D594B;
	Fri, 28 Nov 2025 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQjuKCDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171B33290F;
	Fri, 28 Nov 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352249; cv=none; b=AncrIRzzcBh0d8rHLjuIaG8RjO/phnPJV2D5SfsjfGRNp2bD2Wtx25xKETyWclmtPoLwKntdYUNLDz6x8CMRjVhy78atqgKp6Sis8B8t7VDlbbHFfnJsGEZ8PPwb8uANTnd60VS2NTatE9SNDhLAOpsfhswN2Rk3+o5BtvczENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352249; c=relaxed/simple;
	bh=lMxGP9Y74RTNlyC4T67QqtY8O+iNeCiJvv3TFT+OFuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAsysUItc6eYGDamDyIZbgeuI2I+TCyQVWcZiopMHfuUlrCiPW2MSopp6ZQhk0C0WlvsJ8muIXQD0i8yIOt1o5/pQFh/OUjzkTx/4E0XCzgfwPf51mz5vkEdYLS9lZvrmgipR3aQZjfmmhG8CvuP5drdTt/G2IS19hhaiZmAt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQjuKCDT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ISlazhlQCvrNS1N+QRuhxBA4roAuVAjOK83kV5oq3EI=; b=nQjuKCDTL1ZW2JnJee46rMuyxC
	xO9FjOm5E1qkedtVN4/qFx7K/obuiyPkPjX0iIe8zYPBkXrcuyPvh6V8SnFLTedreigH7fSKcZ6CX
	JHH38tt6sgOA72/2WBR2tP4xeSebgQ/zZoc3IQhPc1pyBj0KLe6aPaRZA2GyoMvTjPwe39bckygZA
	KN5JPw/BhEcUv4N/PEaYAevBZWlsoTeaCempHddKuBGZnvDnKnAHkRayrocXlUEdg9EFB5XTVTNQi
	CygbMkNvUKEKjxK/yCcTk/UTCmRkiIezm7cbIYY4km0PbbVHw2u/p1XRoXURdi4LsOPSj7rXgJdDV
	qsmY327g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP2cE-0000000Da5F-2iR2;
	Fri, 28 Nov 2025 17:50:42 +0000
Date: Fri, 28 Nov 2025 17:50:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Sokolowski, Jan" <jan.sokolowski@intel.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be
 outside given range
Message-ID: <aSng8hKuttOWQuds@casper.infradead.org>
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
 <aShYJta2EHh1d8az@casper.infradead.org>
 <06dbd4f8-ef5f-458c-a8b4-8a8fb2a7877c@amd.com>
 <aShb9lLyR537WDNq@casper.infradead.org>
 <aShmW2gMTyRwyC6m@casper.infradead.org>
 <IA4PR11MB9251BBCF39B18A557BF08C0799DCA@IA4PR11MB9251.namprd11.prod.outlook.com>
 <aSnFME6-LqQXKazB@casper.infradead.org>
 <IA4PR11MB92511BAEF257742C82ED590199DCA@IA4PR11MB9251.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92511BAEF257742C82ED590199DCA@IA4PR11MB9251.namprd11.prod.outlook.com>

On Fri, Nov 28, 2025 at 04:47:17PM +0000, Sokolowski, Jan wrote:
> > No.  You didn't co-develop anything.  You reported the bug, badly.
> > 
> And I've sent a potential patch on how it should've been fixed. That should count for something, right?

Literally everything about that patch was wrong.  If I'd used any of it,
you'd have a point, but the entire approach was wrong.

You _can't_allow the allocation to succeed and then undo it.  There might
be an RCU-protected reader which would see the intermediate state.
And that's an inconsistency we guarantee can't happen; an RCU reader
can see the state before the lock, the state after the lock.  It must
not see a state that never happened.

If you'd written a test case, I'd happily add a co-developed-by tag.
But you didn't do that either.

