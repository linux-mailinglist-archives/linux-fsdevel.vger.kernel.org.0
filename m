Return-Path: <linux-fsdevel+bounces-1878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5420F7DFAB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A62C1C20FEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8F021358;
	Thu,  2 Nov 2023 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hAJAgFuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53481CFB6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 19:12:32 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9578312D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bXPoHY2tfJWC+khL7GINAlNeBBCsV4H0zp+4/vB8yb4=; b=hAJAgFuKIBd6QNZys72Kllol8F
	I/GN1ouYCzPLXRsqdwYZiJThIUFvIl9P51c9R3hQJp3KS9znXhauIHRFTGoVErrHCuQzh9u+BZA9X
	W91L1K9WmKOFA2jFbbseNiCbgMOHFjkHeZDKuvJEuHJaXZ6qU7F3zfEstALf4hehKoN5yWjWBVaMF
	5HBahXLBu1pQXc4oZjDpV16K/WhvJcf5Q1m17zBUKeuRYx71fWbbTO7tAbKogEZ1LriOuOcnFJ97r
	gYr9EQDC/BAvbpfvgq94sr4R91EqeRK14J/O5Y+gaBHgU7V+qztjMuEOtvKv6GQjH9ov0Fm6Ug+br
	Rqb7s2eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qyd7B-000zIt-Fc; Thu, 02 Nov 2023 19:12:25 +0000
Date: Thu, 2 Nov 2023 19:12:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] ida: Add kunit based tests for new IDA functions
Message-ID: <ZUP0mbMqtCaQIQGX@casper.infradead.org>
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
 <20231102153455.1252-4-michal.wajdeczko@intel.com>
 <ZUPfzKMIToSe+X5q@casper.infradead.org>
 <e7637a99-ca4f-460a-8ee5-9583790be567@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7637a99-ca4f-460a-8ee5-9583790be567@intel.com>

On Thu, Nov 02, 2023 at 07:58:16PM +0100, Michal Wajdeczko wrote:
> On 02.11.2023 18:43, Matthew Wilcox wrote:
> > On Thu, Nov 02, 2023 at 04:34:55PM +0100, Michal Wajdeczko wrote:
> >> New functionality of the IDA (contiguous IDs allocations) requires
> >> some validation coverage.  Add KUnit tests for simple scenarios:
> >>  - counting single ID at different locations
> >>  - counting different sets of IDs
> >>  - ID allocation start at requested position
> >>  - different contiguous ID allocations are supported
> >>
> >> More advanced tests for subtle corner cases may come later.
> > 
> > Why are you using kunit instead of extending the existing test-cases?
> 
> I just assumed (maybe wrong) that kunit is preferred these days as some
> other components are even converting their existing test code to kunit.
> 
> But also I might be biased as I was working recently with kunit and just
> found it helpful in fast test development.  Note that to run these new
> IDA tests, anyone who cares just need a single command line:
> 
> $ ./tools/testing/kunit/kunit.py run "ida.*"
> 
> But if you feel that having two places with IDA tests is wrong, we can
> still convert old tests to kunit (either as follow up or prerequisite)
> to this patch (well, already did that locally when started working on
> these improvements)

Why would using kunit be superior to the existing test suite?

